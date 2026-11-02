<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;

final class JobService
{
    public static function run(): array
    {
        $lock = 'learnow:jobs:' . substr(hash('sha256', (string)DB::value('SELECT DATABASE()')), 0, 32);
        if (!DB::value('SELECT GET_LOCK(?,0)', [$lock])) {
            return ['skipped' => 'Another scheduled worker is running.'];
        }
        $stats = ['learners_checked' => 0,'new_notifications' => 0,'new_reports' => 0,'emails_sent' => 0,'emails_failed' => 0,'email_delivery' => MailService::enabled() ? 'configured' : 'disabled'];
        $before = (int)DB::value('SELECT COUNT(*) FROM notifications');
        $reports = (int)DB::value('SELECT COUNT(*) FROM weekly_reports');
        try {
            $last = 0;
            do {
                $users = DB::all("SELECT u.id,u.timezone FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id>? AND u.status='active' AND r.name='learner' ORDER BY u.id LIMIT 100", [$last]);
                foreach ($users as $u) {
                    $uid = (int)$u['id'];
                    $last = $uid;
                    $stats['learners_checked']++;
                    $now = new \DateTimeImmutable('now', new \DateTimeZone($u['timezone']));
                    $date = $now->format('Y-m-d');
                    $schedule = DB::one('SELECT * FROM study_schedules WHERE user_id=?', [$uid]);
                    $daily = DB::one('SELECT * FROM daily_activity WHERE user_id=? AND local_date=?', [$uid,$date]);
                    if ($schedule && $schedule['reminders_enabled'] && (!$daily || !$daily['qualified_at'])) {
                        $study = new \DateTimeImmutable($date . ' ' . $schedule['reminder_time'], new \DateTimeZone($u['timezone']));
                        if ($now >= $study && $now <= $study->modify('+2 hours') && DB::value('SELECT 1 FROM study_days WHERE user_id=? AND weekday=?', [$uid,(int)$now->format('N')])) {
                            NotificationService::notify($uid, 'study', 'A little time for your future', 'Your planned learning session is here. Pick up with one manageable activity.', '/my-learning', 'study:' . $date);
                        }
                    }
                    if ((int)$now->format('H') >= 20 && (!$daily || !$daily['qualified_at'])) {
                        NotificationService::notify($uid, 'streak', 'There’s still room for a little progress', 'Your daily learning goal is not yet complete. A finished lesson or eligible assessment can move it forward.', '/dashboard', 'daily-goal:' . $date);
                    }
                    $due = DB::all("SELECT a.id,a.title,a.due_at FROM assignments a JOIN stages s ON s.id=a.stage_id JOIN enrolments e ON e.path_id=s.path_id AND e.user_id=? WHERE a.status='published' AND a.due_at>UTC_TIMESTAMP() AND a.due_at<=DATE_ADD(UTC_TIMESTAMP(),INTERVAL 48 HOUR) AND NOT EXISTS(SELECT 1 FROM assignment_submissions sub WHERE sub.user_id=? AND sub.assignment_id=a.id AND sub.status IN('submitted','resubmitted','under_review','graded','accepted')) LIMIT 50", [$uid,$uid]);
                    foreach ($due as $a) {
                        NotificationService::notify($uid, 'deadlines', 'A practical deadline is coming up', $a['title'] . ' is due ' . gmdate('M j, H:i', strtotime($a['due_at'])) . ' UTC.', '/assignments/' . $a['id'], 'deadline:' . $a['id'] . ':' . $a['due_at']);
                    }
                    DB::transaction(function () use ($uid) {
                        RewardService::streak($uid);
                        RewardService::achievements($uid);
                        ReferralService::qualify($uid);
                    });
                    ReportService::generate($uid);
                }
            } while (count($users) === 100);
            if (MailService::enabled()) {
                $queue = DB::all("SELECT m.*,u.email,u.full_name,u.email_verified_at,u.status AS user_status,p.email AS email_opt_in FROM mail_outbox m JOIN users u ON u.id=m.user_id JOIN notification_preferences p ON p.user_id=u.id WHERE m.status IN('queued','failed') AND m.attempts<3 AND u.status='active' AND u.email_verified_at IS NOT NULL AND p.email=1 ORDER BY m.id LIMIT 50");
                foreach ($queue as $m) {
                    if ($m['user_status'] !== 'active' || !$m['email_opt_in'] || !$m['email_verified_at']) {
                        continue;
                    }$claimed = DB::run("UPDATE mail_outbox SET status='sending',attempts=attempts+1 WHERE id=? AND status IN('queued','failed')", [$m['id']])->rowCount();
                    if (!$claimed) {
                        continue;
                    }$sent = MailService::send($m['email'], $m['full_name'], $m['subject'], $m['body'] . (!empty($m['link']) ? "\n\n" . route_url($m['link']) : ''));
                    DB::run('UPDATE mail_outbox SET status=?,sent_at=?,last_error=? WHERE id=?', [$sent ? 'sent' : 'failed',$sent ? gmdate('Y-m-d H:i:s') : null,$sent ? null : 'SMTP delivery failed. Review server configuration.',$m['id']]);
                    $stats[$sent ? 'emails_sent' : 'emails_failed']++;
                }
            }
            DB::run('DELETE FROM rate_limits WHERE resets_at<?', [time() - 86400]);
            DB::run('DELETE FROM account_tokens WHERE expires_at<DATE_SUB(UTC_TIMESTAMP(),INTERVAL 7 DAY)');
            DB::run('DELETE FROM refresh_tokens WHERE expires_at<DATE_SUB(UTC_TIMESTAMP(),INTERVAL 7 DAY)');
            DB::run('DELETE FROM auth_sessions WHERE expires_at<DATE_SUB(UTC_TIMESTAMP(),INTERVAL 30 DAY)');
            $stats['new_notifications'] = (int)DB::value('SELECT COUNT(*) FROM notifications') - $before;
            $stats['new_reports'] = (int)DB::value('SELECT COUNT(*) FROM weekly_reports') - $reports;
            DB::run("INSERT INTO system_settings(setting_key,setting_value) VALUES('last_job_run',?) ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value)", [gmdate('Y-m-d H:i:s')]);
            return $stats;
        } finally {
            DB::value('SELECT RELEASE_LOCK(?)', [$lock]);
        }
    }
}
