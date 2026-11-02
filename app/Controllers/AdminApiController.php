<?php

namespace Learnow\Controllers;

use Learnow\Repositories\DB;
use Learnow\Middleware\Auth;
use Learnow\Validators\Validate as V;
use Learnow\Services\{AdminContentService as Content,AssignmentService,QuizService,ReferralService};

final class AdminApiController
{
    public function saveContent(string $resource, string $id): void
    {
        $u = Auth::permission('content.manage');
        try {
            $newId = Content::save((int)$u['id'], $resource, $id, input());
        } catch (\PDOException $e) {
            if ($e->getCode() === '23000') {
                abort(422, 'This record conflicts with an existing identifier or a linked record. Choose a unique slug or review the relationships.');
            }throw $e;
        }success('Your content is saved.', ['redirect' => '/admin/content/' . $resource . '/' . $newId . '/edit']);
    }
    public function duplicate(string $id): void
    {
        $u = Auth::permission('content.manage');
        $new = Content::duplicate((int)$u['id'], (int)$id);
        success('A full draft copy is ready to edit.', ['redirect' => '/admin/content/paths/' . $new . '/edit']);
    }
    public function archive(string $resource, string $id): void
    {
        $u = Auth::permission('content.manage');
        $c = Content::config($resource);
        if (!isset($c['fields']['status'])) {
            abort(422, 'This content type cannot be archived.');
        }DB::transaction(function () use ($c, $id, $u, $resource) {
            if (!DB::one('SELECT id FROM ' . $c['table'] . ' WHERE id=? FOR UPDATE', [$id])) {
                abort(404, 'Content not found.');
            }
            DB::run("UPDATE " . $c['table'] . " SET status='archived' WHERE id=?", [$id]);
            audit((int)$u['id'], 'content.archive', $resource, $id);
        });
        success('Content archived. Existing learner records have been preserved.', ['reload' => true]);
    }
    public function questions(string $id): void
    {
        $u = Auth::permission('content.manage');
        $questions = input()['questions'] ?? [];
        if (!is_array($questions)) {
            abort(422, 'The question list is invalid.');
        }Content::questions((int)$u['id'], (int)$id, $questions);
        success('Your question builder is saved.', ['reload' => true]);
    }
    public function userUpdate(string $id): void
    {
        $actor = Auth::permission('users.manage');
        $d = input();
        $status = V::choice($d['status'] ?? 'active', ['active','suspended'], 'account status');
        $role = V::int($d['role_id'] ?? 0, 'Role', 1, 100);
        DB::transaction(function () use ($id, $actor, $status, $role) {
            $u = DB::one('SELECT * FROM users WHERE id=? FOR UPDATE', [$id]);
            if (!$u) {
                abort(404, 'User not found.');
            }$newRole = DB::one('SELECT * FROM roles WHERE id=?', [$role]);
            if (!$newRole) {
                abort(422, 'Choose an existing role.');
            }if ($role !== (int)$u['role_id']) {
                Auth::permission('roles.manage');
            }if ((int)$id === (int)$actor['id'] && ($status === 'suspended' || $role !== (int)$actor['role_id'])) {
                abort(422, 'You cannot suspend yourself or remove your own administrator role.');
            }
            $adminRole = (int)DB::value("SELECT id FROM roles WHERE name='administrator'");
            if ((int)$u['role_id'] === $adminRole && ($role !== $adminRole || $status === 'suspended')) {
                $admins = DB::all("SELECT id FROM users WHERE role_id=? AND status='active' FOR UPDATE", [$adminRole]);
                if (count($admins) <= 1) {
                    abort(422, 'Keep at least one active administrator.');
                }
            }
            DB::run('UPDATE users SET role_id=?,status=? WHERE id=?', [$role,$status,$id]);
            if ($status === 'suspended' || $role !== (int)$u['role_id']) {
                DB::run('UPDATE auth_sessions SET revoked_at=UTC_TIMESTAMP() WHERE user_id=?', [$id]);
            }audit((int)$actor['id'], 'user.update', 'users', $id, ['old_role' => $u['role_id'],'new_role' => $role,'status' => $status]);
        });
        success('Account permissions updated.', ['reload' => true]);
    }
    public function override(string $id): void
    {
        $u = Auth::permission('users.manage');
        $stage = V::int(input()['stage_id'] ?? 0, 'Stage', 1, 2147483647);
        $reason = V::text(input()['reason'] ?? '', 'Override reason', 10, 500);
        DB::transaction(function () use ($u, $id, $stage, $reason) {
            $path = DB::value('SELECT path_id FROM stages WHERE id=?', [$stage]);
            if (!$path || !DB::value('SELECT 1 FROM enrolments WHERE user_id=? AND path_id=?', [$id,$path])) {
                abort(422, 'The learner must be enrolled in the selected stage’s path.');
            }DB::run('INSERT INTO stage_overrides(user_id,stage_id,granted_by,reason) VALUES(?,?,?,?) ON DUPLICATE KEY UPDATE granted_by=VALUES(granted_by),reason=VALUES(reason)', [$id,$stage,$u['id'],$reason]);
            audit((int)$u['id'], 'progress.override', 'users', $id, ['stage' => $stage,'reason' => $reason]);
        });
        success('Stage access granted and recorded. No XP or completion was added.', ['reload' => true]);
    }
    public function review(string $id): void
    {
        $u = Auth::permission('review.manage');
        $s = DB::one('SELECT reviewer_id FROM assignment_submissions WHERE id=?', [$id]);
        if (!$s || ($u['role'] === 'reviewer' && $s['reviewer_id'] !== $u['id'])) {
            abort(404, 'Submission not found.');
        }AssignmentService::review((int)$u['id'], (int)$id, input());
        success('Your feedback is saved and available to the learner.', ['reload' => true]);
    }
    public function grade(string $id): void
    {
        $u = Auth::permission('review.manage');
        $a = DB::one('SELECT assigned_reviewer_id FROM quiz_attempts WHERE id=?', [$id]);
        if (!$a || ($u['role'] === 'reviewer' && $a['assigned_reviewer_id'] !== $u['id'])) {
            abort(404, 'Attempt not found.');
        }$grades = input()['grades'] ?? [];
        if (!is_array($grades)) {
            abort(422, 'Review each written response.');
        }QuizService::grade((int)$u['id'], (int)$id, $grades);
        success('Written responses graded. The learner has been notified.', ['reload' => true]);
    }
    public function assignReviewer(string $kind, string $id): void
    {
        $u = Auth::permission('users.manage');
        if (!in_array($kind, ['assignment','quiz'], true)) {
            abort(404, 'Review type not found.');
        }$reviewer = V::int(input()['reviewer_id'] ?? 0, 'Reviewer', 1, 2147483647);
        if (!DB::value("SELECT u.id FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=? AND u.status='active' AND r.name IN('reviewer','administrator')", [$reviewer])) {
            abort(422, 'Choose an active authorised reviewer.');
        }$table = $kind === 'quiz' ? 'quiz_attempts' : 'assignment_submissions';
        $col = $kind === 'quiz' ? 'assigned_reviewer_id' : 'reviewer_id';
        DB::transaction(function () use ($table, $col, $reviewer, $id, $u, $kind) {
            if (!DB::one('SELECT id FROM ' . $table . ' WHERE id=? FOR UPDATE', [$id])) {
                abort(404, 'Review item not found.');
            }
            DB::run('UPDATE ' . $table . ' SET ' . $col . '=? WHERE id=?', [$reviewer,$id]);
            audit((int)$u['id'], 'review.assign', $kind, $id, ['reviewer' => $reviewer]);
        });
        success('Reviewer assigned.', ['reload' => true]);
    }
    public function rewardRules(): void
    {
        $u = Auth::permission('settings.manage');
        $rules = input()['rules'] ?? [];
        if (!is_array($rules)) {
            abort(422, 'Reward rules are invalid.');
        }DB::transaction(function () use ($u, $rules) {
            foreach (DB::all('SELECT kind FROM reward_rules') as $r) {
                $value = $rules[$r['kind']] ?? [];
                $xp = V::int($value['xp'] ?? 0, 'XP', 0, 10000);
                DB::run('UPDATE reward_rules SET xp=?,enabled=? WHERE kind=?', [$xp,(int)!empty($value['enabled']),$r['kind']]);
            }audit((int)$u['id'], 'rewards.update', 'reward_rules', 'all');
        });
        success('Reward rules updated. Existing ledger entries are unchanged.');
    }
    public function settings(): void
    {
        $u = Auth::permission('settings.manage');
        $d = input();
        $allowed = ['streak_protection_enabled' => [0,1],'streak_protection_max' => [0,10],'streak_protection_monthly_limit' => [0,10],'streak_protection_purchase' => [0,1],'streak_protection_cost' => [1,10000],'lives_enabled' => [0,1],'lives_max' => [1,20],'lives_recovery_minutes' => [1,1440],'peer_review_count' => [1,5],'peer_review_min_lessons' => [0,100],'peer_review_anonymous' => [0,1]];
        DB::transaction(function () use ($u, $d, $allowed) {
            foreach ($allowed as $key => $bounds) {
                if (!array_key_exists($key, $d)) {
                    continue;
                }$value = V::int($d[$key], str_replace('_', ' ', $key), ...$bounds);
                DB::run('INSERT INTO system_settings(setting_key,setting_value) VALUES(?,?) ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value)', [$key,(string)$value]);
            }if (isset($d['lives_loss_mode'])) {
                $v = V::choice($d['lives_loss_mode'], ['attempt','question'], 'lives loss mode');
                DB::run('INSERT INTO system_settings(setting_key,setting_value) VALUES(?,?) ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value)', ['lives_loss_mode',$v]);
            }if (isset($d['support_email'])) {
                $v = $d['support_email'] ? V::email($d['support_email']) : '';
                DB::run('INSERT INTO system_settings(setting_key,setting_value) VALUES(?,?) ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value)', ['support_email',$v]);
            }audit((int)$u['id'], 'settings.update', 'settings', 'platform', ['keys' => array_keys($d)]);
        });
        success('Platform settings saved.');
    }
    public function campaign(): void
    {
        $u = Auth::permission('settings.manage');
        $d = input();
        $title = V::text($d['title'] ?? '', 'Campaign title', 3, 160);
        $type = V::choice($d['reward_type'] ?? 'xp', ['xp','coins'], 'reward type');
        $reward = V::int($d['referrer_reward'] ?? 0, 'Referrer reward', 0, 10000);
        $referred = V::int($d['referred_reward'] ?? 0, 'Referred learner reward', 0, 10000);
        $lessons = V::int($d['qualifying_lessons'] ?? 3, 'Qualifying lessons', 1, 100);
        $max = V::int($d['max_rewards'] ?? 20, 'Reward cap', 1, 1000);
        $dates = [];
        foreach (['starts_at','ends_at'] as $field) {
            if (empty($d[$field])) {
                $dates[] = null;
                continue;
            }$date = \DateTimeImmutable::createFromFormat('!Y-m-d\TH:i', $d[$field]);
            if (!$date || $date->format('Y-m-d\TH:i') !== $d[$field]) {
                abort(422, 'Choose a valid campaign date.');
            }$dates[] = $date->format('Y-m-d H:i:s');
        }if ($dates[0] && $dates[1] && $dates[0] >= $dates[1]) {
            abort(422, 'The campaign end must be after its start.');
        }
        DB::transaction(function () use ($u, $d, $title, $type, $reward, $referred, $lessons, $max, $dates) {
            $id = DB::value('SELECT id FROM referral_campaigns ORDER BY id DESC LIMIT 1');
            $values = [$title,(int)!empty($d['enabled']),$type,$reward,$referred,$lessons,(int)!empty($d['require_verified']),$max,...$dates];
            if ($id) {
                DB::run('UPDATE referral_campaigns SET title=?,enabled=?,reward_type=?,referrer_reward=?,referred_reward=?,qualifying_lessons=?,require_verified=?,max_rewards=?,starts_at=?,ends_at=? WHERE id=?', [...$values,$id]);
            } else {
                $id = DB::insert('INSERT INTO referral_campaigns(title,enabled,reward_type,referrer_reward,referred_reward,qualifying_lessons,require_verified,max_rewards,starts_at,ends_at) VALUES(?,?,?,?,?,?,?,?,?,?)', $values);
            }
            audit((int)$u['id'], 'referral.rules.update', 'referral_campaigns', $id);
        });
        success('Referral conditions saved. No cash rewards are offered.', ['reload' => true]);
    }
    public function resolveReferral(string $id): void
    {
        $u = Auth::permission('settings.manage');
        $action = V::choice(input()['action'] ?? '', ['recheck','reject'], 'referral action');
        $reason = V::text(input()['reason'] ?? '', 'Reason', 10, 500);
        DB::transaction(function () use ($u, $id, $action, $reason) {
            $r = DB::one('SELECT * FROM referrals WHERE id=? FOR UPDATE', [$id]);
            if (!$r) {
                abort(404, 'Referral not found.');
            }if ($r['status'] === 'rewarded') {
                abort(422, 'An issued ledger reward cannot be silently rewritten.');
            }if ($action === 'reject') {
                DB::run("UPDATE referrals SET status='rejected' WHERE id=?", [$id]);
            } else {
                DB::run("UPDATE referrals SET status='pending' WHERE id=?", [$id]);
                ReferralService::qualify((int)$r['referred_id']);
            }audit((int)$u['id'], 'referral.' . $action, 'referrals', $id, ['reason' => $reason]);
        });
        success('Referral reviewed under the configured eligibility rules.', ['reload' => true]);
    }
    public function revoke(string $id): void
    {
        $u = Auth::permission('certificates.manage');
        $reason = V::text(input()['reason'] ?? '', 'Revocation reason', 10, 500);
        DB::transaction(function () use ($u, $id, $reason) {
            $record = DB::one('SELECT id,revoked_at FROM certificates WHERE id=? FOR UPDATE', [$id]);
            if (!$record) {
                abort(404, 'Certificate not found.');
            }
            if ($record['revoked_at']) {
                abort(422, 'This certificate is already revoked. Its original reason is preserved.');
            }
            DB::run('UPDATE certificates SET revoked_at=COALESCE(revoked_at,UTC_TIMESTAMP()),revocation_reason=? WHERE id=?', [$reason,$id]);
            audit((int)$u['id'], 'certificate.revoke', 'certificates', $id, ['reason' => $reason]);
        });
        success('Certificate revoked. Public verification now reflects its status.', ['reload' => true]);
    }
    public function moderate(string $kind, string $id): void
    {
        $u = Auth::permission('community.manage');
        $reason = V::text(input()['reason'] ?? '', 'Moderation reason', 10, 1000);
        DB::transaction(function () use ($u, $kind, $id, $reason) {
            $table = match ($kind) {
                'report'=>'community_reports','review'=>'peer_review_assignments',default=>null
            };
            if (!$table || !DB::one('SELECT id FROM ' . $table . ' WHERE id=? FOR UPDATE', [$id])) {
                abort(404, 'Moderation item not found.');
            }
            if ($kind === 'report') {
                DB::run("UPDATE community_reports SET status='resolved',resolution=? WHERE id=?", [$reason,$id]);
            } elseif ($kind === 'review') {
                DB::run("UPDATE peer_review_assignments SET status='hidden' WHERE id=?", [$id]);
            } else {
                abort(404, 'Moderation item not found.');
            }
            audit((int)$u['id'], 'community.moderate', $kind, $id, ['reason' => $reason]);
        });
        success('Moderation action recorded.', ['reload' => true]);
    }
}
