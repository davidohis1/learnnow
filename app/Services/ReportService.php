<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;

final class ReportService
{
    /** A local calendar week is not always 168 UTC hours across daylight saving. */
    public static function previousWeek(string $timezone, ?\DateTimeImmutable $at = null): array
    {
        $now = ($at ?? new \DateTimeImmutable('now'))->setTimezone(new \DateTimeZone($timezone));
        $end = $now->modify('monday this week')->setTime(0, 0);
        return [$end->modify('-7 days'),$end];
    }
    public static function generate(int $uid): int
    {
        $u = DB::one('SELECT * FROM users WHERE id=?', [$uid]);
        if (!$u) {
            abort(404, 'Learner not found.');
        }
        [$start,$end] = self::previousWeek($u['timezone']);
        $weekStart = $start->format('Y-m-d');
        $weekEnd = $end->modify('-1 day')->format('Y-m-d');
        $utc = new \DateTimeZone('UTC');
        $from = $start->setTimezone($utc)->format('Y-m-d H:i:s');
        $until = $end->setTimezone($utc)->format('Y-m-d H:i:s');
        return DB::transaction(function () use ($uid, $weekStart, $weekEnd, $from, $until) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
            $existing = DB::value('SELECT id FROM weekly_reports WHERE user_id=? AND week_start=?', [$uid,$weekStart]);
            if ($existing) {
                return (int)$existing;
            }
            $lessons = (int)DB::value("SELECT COUNT(*) FROM activity_events WHERE user_id=? AND kind='lesson' AND created_at>=? AND created_at<?", [$uid,$from,$until]);
            $quizzes = DB::one('SELECT COUNT(*) AS total,AVG(score) AS average FROM quiz_attempts WHERE user_id=? AND submitted_at>=? AND submitted_at<?', [$uid,$from,$until]);
            $assignments = (int)DB::value("SELECT COUNT(DISTINCT h.submission_id) FROM submission_history h JOIN assignment_submissions s ON s.id=h.submission_id WHERE s.user_id=? AND h.status IN('submitted','resubmitted') AND h.created_at>=? AND h.created_at<?", [$uid,$from,$until]);
            $xp = (int)DB::value('SELECT COALESCE(SUM(amount),0) FROM xp_transactions WHERE user_id=? AND created_at>=? AND created_at<?', [$uid,$from,$until]);
            $goals = (int)DB::value('SELECT COUNT(*) FROM daily_activity WHERE user_id=? AND local_date BETWEEN ? AND ? AND qualified_at IS NOT NULL', [$uid,$weekStart,$weekEnd]);
            $streak = (int)DB::value('SELECT COUNT(*) FROM daily_activity WHERE user_id=? AND local_date BETWEEN ? AND ? AND (qualified_at IS NOT NULL OR protected=1)', [$uid,$weekStart,$weekEnd]);
            $next = LearningService::nextLesson($uid);
            $suggestion = $next ? 'Continue ' . $next['path_title'] . ' with “' . $next['title'] . '”. A manageable daily goal can help you keep your rhythm.' : 'Open your learning map to check outstanding assessments, or explore a published path that matches your interests. A small next step is enough.';
            $id = DB::insert('INSERT INTO weekly_reports(user_id,week_start,week_end,lessons_completed,quizzes_attempted,average_quiz_score,assignments_submitted,xp_earned,goals_met,streak_days,suggested_next) VALUES(?,?,?,?,?,?,?,?,?,?,?)', [$uid,$weekStart,$weekEnd,$lessons,$quizzes['total'],$quizzes['average'],$assignments,$xp,$goals,$streak,$suggestion]);
            $paths = DB::all('SELECT p.id,p.title FROM enrolments e JOIN learning_paths p ON p.id=e.path_id WHERE e.user_id=? AND e.enrolled_at<? LIMIT 200', [$uid,$until]);
            foreach ($paths as $p) {
                $counts = DB::one("SELECT COUNT(*) AS total,SUM(EXISTS(SELECT 1 FROM lesson_progress lp WHERE lp.lesson_id=l.id AND lp.user_id=? AND lp.completed_at<?)) AS done FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=? AND l.status='published'", [$uid,$until,$p['id']]);
                DB::run('INSERT INTO weekly_report_paths(report_id,path_id,path_title,lessons_completed,lesson_total) VALUES(?,?,?,?,?)', [$id,$p['id'],$p['title'],(int)$counts['done'],(int)$counts['total']]);
            }
            NotificationService::notify($uid, 'weekly', 'Your week, in perspective', 'Your reflection for ' . $weekStart . ' is ready. It uses recorded activity, not time with an open tab.', '/reports', 'weekly:' . $weekStart);
            return $id;
        });
    }
}
