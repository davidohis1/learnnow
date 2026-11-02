<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;

final class RewardService
{
    public static function award(int $uid, string $kind, int $ref, string $reason): bool
    {
        $r = DB::one('SELECT * FROM reward_rules WHERE kind=?', [$kind]);
        if (!$r || !$r['enabled']) {
            return false;
        }
        return self::xp($uid, (int)$r['xp'], $reason, $kind . ':' . $ref);
    }
    public static function xp(int $uid, int $amount, string $reason, string $key): bool
    {
        $added = DB::run('INSERT IGNORE INTO xp_transactions(user_id,amount,reason,idempotency_key) VALUES(?,?,?,?)', [$uid,$amount,$reason,$key])->rowCount() > 0;
        if ($added && $amount > 0) {
            try {
                $after = (int)DB::value('SELECT COALESCE(SUM(amount),0) FROM xp_transactions WHERE user_id=?', [$uid]);
                $now = DB::one('SELECT level,title FROM level_definitions WHERE minimum_xp<=? ORDER BY minimum_xp DESC LIMIT 1', [$after]);
                $was = DB::one('SELECT level FROM level_definitions WHERE minimum_xp<=? ORDER BY minimum_xp DESC LIMIT 1', [$after - $amount]);
                if ($now && (int)$now['level'] > (int)($was['level'] ?? 0)) {
                    ChatService::highlight($uid, 'level', 'reached Level ' . (int)$now['level'] . ' · ' . $now['title']);
                }
            } catch (\Throwable $e) {
            }
        }
        return $added;
    }
    public static function today(array $u, ?\DateTimeImmutable $at = null): string
    {
        return ($at ?? new \DateTimeImmutable('now'))->setTimezone(new \DateTimeZone($u['timezone']))->format('Y-m-d');
    }
    public static function activity(int $uid, string $kind, int $ref, int $minutes, string $reason): void
    {
        DB::transaction(function () use ($uid, $kind, $ref, $minutes, $reason) {
            $u = DB::one('SELECT * FROM users WHERE id=? FOR UPDATE', [$uid]);
            $date = self::today($u);
            if (!DB::run('INSERT IGNORE INTO activity_events(user_id,kind,reference_id,local_date,goal_minutes) VALUES(?,?,?,?,?)', [$uid,$kind,$ref,$date,$minutes])->rowCount()) {
                return;
            }
            $target = (int)(DB::value('SELECT daily_minutes FROM user_preferences WHERE user_id=?', [$uid]) ?: 15);
            DB::run('INSERT INTO daily_activity(user_id,local_date,goal_minutes,goal_target) VALUES(?,?,?,?) ON DUPLICATE KEY UPDATE goal_minutes=goal_minutes+VALUES(goal_minutes)', [$uid,$date,$minutes,$target]);
            DB::run('UPDATE daily_activity SET qualified_at=COALESCE(qualified_at,UTC_TIMESTAMP()) WHERE user_id=? AND local_date=? AND goal_minutes>=goal_target', [$uid,$date]);
            self::award($uid, $kind, $ref, $reason);
            self::streak($uid);
            self::achievements($uid);
            ReferralService::qualify($uid);
        });
    }
    public static function streak(int $uid): array
    {
        return DB::transaction(function () use ($uid) {
            $u = DB::one('SELECT id,timezone FROM users WHERE id=? FOR UPDATE', [$uid]);
            $today = self::today($u);
            $yesterday = (new \DateTimeImmutable($today))->modify('-1 day')->format('Y-m-d');
            if ((int)setting('streak_protection_enabled', 0)) {
                $before = (new \DateTimeImmutable($yesterday))->modify('-1 day')->format('Y-m-d');
                $last = DB::value('SELECT MAX(local_date) FROM daily_activity WHERE user_id=? AND (qualified_at IS NOT NULL OR protected=1) AND local_date<?', [$uid,$today]);
                $monthStart = substr($yesterday, 0, 7) . '-01';
                $monthEnd = (new \DateTimeImmutable($monthStart))->modify('+1 month')->format('Y-m-d');
                $used = (int)DB::value('SELECT COUNT(*) FROM streak_protections WHERE user_id=? AND used_date>=? AND used_date<?', [$uid,$monthStart,$monthEnd]);
                if ($last === $before && $used < (int)setting('streak_protection_monthly_limit', 2)) {
                    $held = DB::one('SELECT id FROM streak_protections WHERE user_id=? AND used_date IS NULL ORDER BY id LIMIT 1 FOR UPDATE', [$uid]);
                    if ($held) {
                        DB::run('UPDATE streak_protections SET used_date=? WHERE id=?', [$yesterday,$held['id']]);
                        $target = (int)(DB::value('SELECT daily_minutes FROM user_preferences WHERE user_id=?', [$uid]) ?: 15);
                        DB::run('INSERT INTO daily_activity(user_id,local_date,goal_minutes,goal_target,protected) VALUES(?,?,0,?,1) ON DUPLICATE KEY UPDATE protected=1', [$uid,$yesterday,$target]);
                        NotificationService::notify($uid, 'streak', 'Your streak is protected', 'One earned protection covered ' . $yesterday . '. Pick up where you left off.', '/achievements', 'protected:' . $yesterday);
                    }
                }
            }
            $dates = DB::all('SELECT local_date FROM daily_activity WHERE user_id=? AND (qualified_at IS NOT NULL OR protected=1) ORDER BY local_date DESC LIMIT 10000', [$uid]);
            $current = 0;
            $best = 0;
            $run = 0;
            $prev = null;
            foreach ($dates as $row) {
                $d = $row['local_date'];
                $run = ($prev && (new \DateTimeImmutable($prev))->modify('-1 day')->format('Y-m-d') === $d) ? $run + 1 : 1;
                $best = max($best, $run);
                $prev = $d;
            }
            if ($dates && in_array($dates[0]['local_date'], [$today,$yesterday], true)) {
                $expect = $dates[0]['local_date'];
                foreach ($dates as $row) {
                    if ($row['local_date'] !== $expect) {
                        break;
                    } $current++;
                    $expect = (new \DateTimeImmutable($expect))->modify('-1 day')->format('Y-m-d');
                }
            }
            DB::run('INSERT INTO streak_records(user_id,current_streak,best_streak,last_date) VALUES(?,?,?,?) ON DUPLICATE KEY UPDATE current_streak=VALUES(current_streak),best_streak=GREATEST(best_streak,VALUES(best_streak)),last_date=VALUES(last_date)', [$uid,$current,$best,$dates[0]['local_date'] ?? null]);
            return DB::one('SELECT * FROM streak_records WHERE user_id=?', [$uid]);
        });
    }
    public static function achievements(int $uid): void
    {
        $counts = ['lessons' => (int)DB::value('SELECT COUNT(*) FROM lesson_progress WHERE user_id=?', [$uid]),'xp' => (int)DB::value('SELECT COALESCE(SUM(amount),0) FROM xp_transactions WHERE user_id=?', [$uid]),'streak' => (int)DB::value('SELECT current_streak FROM streak_records WHERE user_id=?', [$uid])];
        foreach (DB::all('SELECT * FROM achievements WHERE active=1') as $a) {
            if ($counts[$a['metric']] < $a['threshold_value']) {
                continue;
            } if (!DB::run('INSERT IGNORE INTO learner_achievements(user_id,achievement_id) VALUES(?,?)', [$uid,$a['id']])->rowCount()) {
                continue;
            }
            if ($a['xp_reward']) {
                self::xp($uid, (int)$a['xp_reward'], 'Achievement: ' . $a['title'], 'achievement:' . $a['id']);
            }
            $held = (int)DB::value('SELECT COUNT(*) FROM streak_protections WHERE user_id=? AND used_date IS NULL', [$uid]);
            for ($i = 0; $i < (int)$a['protection_reward'] && $held + $i < (int)setting('streak_protection_max', 2); $i++) {
                DB::run('INSERT IGNORE INTO streak_protections(user_id,source_key) VALUES(?,?)', [$uid,'achievement:' . $a['id'] . ':' . $i]);
            }
            ChatService::highlight($uid, 'achievement', 'unlocked the achievement “' . $a['title'] . '”');
            NotificationService::notify($uid, 'milestones', 'You earned ' . $a['title'], $a['description'], '/achievements', 'achievement:' . $a['id']);
        }
    }
    public static function summary(int $uid): array
    {
        $xp = (int)DB::value('SELECT COALESCE(SUM(amount),0) FROM xp_transactions WHERE user_id=?', [$uid]);
        $level = DB::one('SELECT * FROM level_definitions WHERE minimum_xp<=? ORDER BY minimum_xp DESC LIMIT 1', [$xp]) ?: ['level' => 1,'title' => 'Explorer','minimum_xp' => 0];
        $next = DB::one('SELECT * FROM level_definitions WHERE minimum_xp>? ORDER BY minimum_xp LIMIT 1', [$xp]);
        return ['xp' => $xp,'level' => $level,'next' => $next,'percentage' => $next ? min(100, round(($xp - $level['minimum_xp']) / max(1, $next['minimum_xp'] - $level['minimum_xp']) * 100)) : 100,'coins' => (int)DB::value('SELECT COALESCE(SUM(amount),0) FROM coin_transactions WHERE user_id=?', [$uid])];
    }
    public static function buyProtection(int $uid, string $key): void
    {
        if (!(int)setting('streak_protection_enabled', 0) || !(int)setting('streak_protection_purchase', 0)) {
            abort(422, 'Purchasing streak protection is not enabled.');
        }
        DB::transaction(function () use ($uid, $key) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
            if (DB::value('SELECT id FROM streak_protections WHERE user_id=? AND source_key=?', [$uid,'purchase:' . $key])) {
                return;
            }
            if ((int)DB::value('SELECT COUNT(*) FROM streak_protections WHERE user_id=? AND used_date IS NULL', [$uid]) >= (int)setting('streak_protection_max', 2)) {
                abort(422, 'You already hold the maximum number of protections.');
            } $cost = max(1, (int)setting('streak_protection_cost', 100));
            if (self::summary($uid)['coins'] < $cost) {
                abort(422, 'You don’t have enough virtual coins yet. No money will be charged.');
            }
            DB::run('INSERT INTO coin_transactions(user_id,amount,reason,idempotency_key) VALUES(?,?,?,?)', [$uid,-$cost,'Streak protection','protection:' . $key]);
            DB::run('INSERT INTO streak_protections(user_id,source_key) VALUES(?,?)', [$uid,'purchase:' . $key]);
        });
    }
}
