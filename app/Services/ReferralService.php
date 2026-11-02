<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;

final class ReferralService
{
    public static function qualify(int $uid): void
    {
        $ref = DB::one("SELECT * FROM referrals WHERE referred_id=? AND status='pending'", [$uid]);
        if (!$ref || $ref['referrer_id'] === $uid) {
            return;
        }
        DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$ref['referrer_id']]);
        $r = DB::one('SELECT * FROM referrals WHERE id=? FOR UPDATE', [$ref['id']]);
        if ($r['status'] !== 'pending') {
            return;
        }
        $c = DB::one('SELECT * FROM referral_campaigns WHERE enabled=1 AND (starts_at IS NULL OR starts_at<=UTC_TIMESTAMP()) AND (ends_at IS NULL OR ends_at>=UTC_TIMESTAMP()) ORDER BY id DESC LIMIT 1');
        if (!$c) {
            return;
        }
        $u = DB::one('SELECT email_verified_at,status FROM users WHERE id=?', [$uid]);
        if ($u['status'] !== 'active' || ($c['require_verified'] && !$u['email_verified_at']) || DB::value('SELECT status FROM users WHERE id=?', [$ref['referrer_id']]) !== 'active') {
            return;
        }
        $count = (int)DB::value('SELECT COUNT(*) FROM lesson_progress WHERE user_id=?', [$uid]);
        if ($count < $c['qualifying_lessons']) {
            return;
        }
        $rewards = (int)DB::value('SELECT COUNT(*) FROM referral_rewards rr JOIN referrals r ON r.id=rr.referral_id WHERE r.referrer_id=? AND rr.campaign_id=?', [$ref['referrer_id'],$c['id']]);
        if ($rewards >= $c['max_rewards']) {
            return;
        }
        DB::run('INSERT INTO referral_rewards(referral_id,campaign_id,amount,reward_type) VALUES(?,?,?,?)', [$ref['id'],$c['id'],$c['referrer_reward'],$c['reward_type']]);
        foreach ([[$ref['referrer_id'],$c['referrer_reward'],'referrer'],[$uid,$c['referred_reward'],'referred']] as [$beneficiary,$amount,$role]) {
            if (!$amount) {
                continue;
            } $key = 'referral:' . $ref['id'] . ':' . $role;
            if ($c['reward_type'] === 'xp') {
                RewardService::xp((int)$beneficiary, (int)$amount, 'Qualified referral', $key);
            } else {
                DB::run('INSERT IGNORE INTO coin_transactions(user_id,amount,reason,idempotency_key) VALUES(?,?,?,?)', [$beneficiary,$amount,'Qualified referral',$key]);
            }
        }
        DB::run("UPDATE referrals SET status='rewarded',qualified_at=UTC_TIMESTAMP() WHERE id=?", [$ref['id']]);
        NotificationService::notify((int)$ref['referrer_id'], 'milestones', 'A little shared progress', 'An eligible referral has qualified for your configured reward.', '/referrals', 'referral:' . $ref['id']);
    }
}
