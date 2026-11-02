<?php

namespace Learnow\Controllers;

use Learnow\Repositories\DB;
use Learnow\Middleware\Auth;
use Learnow\Validators\Validate as V;
use Learnow\Services\LearningService;

final class ProfileController
{
    public function onboarding(): void
    {
        $u = Auth::requireUser();
        if ($u['onboarding_completed_at']) {
            redirect('/dashboard');
        } $r = DB::one('SELECT * FROM onboarding_responses WHERE user_id=?', [$u['id']]);
        render('onboarding', ['title' => 'Make this journey yours','categories' => DB::all('SELECT * FROM categories WHERE active=1 ORDER BY id'),'paths' => LearningService::catalogue(),'saved' => $r ? json_decode($r['responses'], true) : [],'step' => (int)($r['step'] ?? 0)], 'onboarding');
    }
    private function normalise(array $d): array
    {
        $interests = V::ids($d['interests'] ?? [], 20);
        foreach ($interests as $id) {
            if (!DB::value('SELECT 1 FROM categories WHERE id=? AND active=1', [$id])) {
                abort(422, 'Choose an available skill category.');
            }
        }
        $goal = V::choice($d['goal'] ?? 'new_skill', ['new_skill','projects','career','improve','freelancing'], 'learning goal');
        $experience = V::choice($d['experience'] ?? 'beginner', ['beginner','some','intermediate'], 'experience level');
        $daily = V::int($d['daily_minutes'] ?? 15, 'Daily target', 5, 180);
        $days = V::ids($d['study_days'] ?? [], 7);
        foreach ($days as $day) {
            if ($day > 7) {
                abort(422, 'Choose valid study days.');
            }
        }
        $time = (string)($d['reminder_time'] ?? '18:00');
        if (!preg_match('/^(?:[01]\d|2[0-3]):[0-5]\d$/D', $time)) {
            abort(422, 'Choose a valid reminder time.');
        }
        $tz = V::timezone($d['timezone'] ?? env('DEFAULT_TIMEZONE', 'UTC'));
        return ['interests' => $interests,'goal' => $goal,'experience' => $experience,'daily_minutes' => $daily,'study_days' => $days,'reminder_time' => $time,'timezone' => $tz,'reminders_enabled' => !empty($d['reminders_enabled'])];
    }
    private function persist(int $uid, array $d): void
    {
        DB::run('UPDATE users SET timezone=? WHERE id=?', [$d['timezone'],$uid]);
        DB::run('INSERT INTO user_preferences(user_id,goal,experience,daily_minutes) VALUES(?,?,?,?) ON DUPLICATE KEY UPDATE goal=VALUES(goal),experience=VALUES(experience),daily_minutes=VALUES(daily_minutes)', [$uid,$d['goal'],$d['experience'],$d['daily_minutes']]);
        DB::run('DELETE FROM user_interests WHERE user_id=?', [$uid]);
        foreach ($d['interests'] as $id) {
            DB::run('INSERT INTO user_interests(user_id,category_id) VALUES(?,?)', [$uid,$id]);
        }
        DB::run('INSERT INTO study_schedules(user_id,reminder_time,reminders_enabled) VALUES(?,?,?) ON DUPLICATE KEY UPDATE reminder_time=VALUES(reminder_time),reminders_enabled=VALUES(reminders_enabled)', [$uid,$d['reminder_time'],(int)$d['reminders_enabled']]);
        DB::run('DELETE FROM study_days WHERE user_id=?', [$uid]);
        foreach ($d['study_days'] as $day) {
            DB::run('INSERT INTO study_days(user_id,weekday) VALUES(?,?)', [$uid,$day]);
        }
    }
    public function saveOnboarding(): void
    {
        $u = Auth::requireUser();
        $raw = input();
        $step = V::int($raw['step'] ?? 0, 'Step', 0, 7);
        $d = $this->normalise($raw);
        $path = (int)($raw['path_id'] ?? 0);
        if ($path) {
            LearningService::path($path);
        } $d['path_id'] = $path;
        DB::transaction(function () use ($u, $d, $step, $raw, $path) {
            DB::run('INSERT INTO onboarding_responses(user_id,step,responses) VALUES(?,?,?) ON DUPLICATE KEY UPDATE step=VALUES(step),responses=VALUES(responses)', [$u['id'],$step,json_encode($d)]);
            if (!empty($raw['finish'])) {
                $this->persist((int)$u['id'], $d);
                if ($path) {
                    LearningService::enrol((int)$u['id'], $path);
                } DB::run('UPDATE users SET onboarding_completed_at=COALESCE(onboarding_completed_at,UTC_TIMESTAMP()) WHERE id=?', [$u['id']]);
            }
        });
        success(!empty($raw['finish']) ? 'Your learning space is ready.' : 'Your preferences are saved.', ['step' => $step] + (!empty($raw['finish']) ? ['redirect' => '/dashboard'] : []));
    }
    public function settings(string $tab = 'profile'): void
    {
        $u = Auth::requireUser();
        render('settings', ['title' => $tab === 'schedule' ? 'Make time for your future' : 'Your account, your way','tab' => $tab,'prefs' => DB::one('SELECT * FROM user_preferences WHERE user_id=?', [$u['id']]),'schedule' => DB::one('SELECT * FROM study_schedules WHERE user_id=?', [$u['id']]),'days' => array_column(DB::all('SELECT weekday FROM study_days WHERE user_id=?', [$u['id']]), 'weekday'),'interests' => array_column(DB::all('SELECT category_id FROM user_interests WHERE user_id=?', [$u['id']]), 'category_id'),'categories' => DB::all('SELECT * FROM categories WHERE active=1'),'notifications' => DB::one('SELECT * FROM notification_preferences WHERE user_id=?', [$u['id']])]);
    }
    public function saveSettings(): void
    {
        $u = Auth::requireUser();
        $d = $this->normalise(input());
        $name = V::text(input()['full_name'] ?? $u['full_name'], 'Full name', 2, 120);
        DB::transaction(function () use ($u, $d, $name) {
            $this->persist((int)$u['id'], $d);
            DB::run('UPDATE users SET full_name=? WHERE id=?', [$name,$u['id']]);
        });
        success('Your preferences are saved.', ['reload' => true]);
    }
    public function password(): void
    {
        $u = Auth::requireUser();
        \Learnow\Middleware\Security::throttle('change-password:' . $u['id'], 5, 3600);
        $d = input();
        $hash = DB::value('SELECT password_hash FROM users WHERE id=?', [$u['id']]);
        if (!password_verify((string)($d['current_password'] ?? ''), $hash)) {
            abort(422, 'Your current password is incorrect.');
        } $new = V::password($d['password'] ?? '');
        if ($new !== ($d['password_confirmation'] ?? '')) {
            abort(422, 'Your new passwords do not match.');
        }
        DB::transaction(function () use ($u, $new) {
            DB::run('UPDATE users SET password_hash=? WHERE id=?', [password_hash($new, PASSWORD_ARGON2ID),$u['id']]);
            DB::run('UPDATE auth_sessions SET revoked_at=UTC_TIMESTAMP() WHERE user_id=?', [$u['id']]);
        });
        Auth::issue((int)$u['id']);
        success('Password updated. All other sessions have been signed out.');
    }
    public function notifications(): void
    {
        $u = Auth::requireUser();
        $d = input();
        $vals = [];
        foreach (['study','streak','deadlines','feedback','milestones','weekly','email'] as $f) {
            $vals[] = (int)!empty($d[$f]);
        } $vals[] = $u['id'];
        DB::run('UPDATE notification_preferences SET study=?,streak=?,deadlines=?,feedback=?,milestones=?,weekly=?,email=? WHERE user_id=?', $vals);
        success('Notification preferences updated.');
    }
}
