<?php

namespace Learnow\Services;

use Learnow\Middleware\Security;
use Learnow\Repositories\DB;

/** One group chat per skill area. Members are learners enrolled in, or following a track of, that area. */
final class ChatService
{
    public static function rooms(int $uid): array
    {
        try {
            return DB::all("SELECT c.id,c.name,c.slug,(SELECT COUNT(DISTINCT m.user_id) FROM (SELECT e.user_id,p.category_id FROM enrolments e JOIN learning_paths p ON p.id=e.path_id UNION SELECT ut.user_id,t.category_id FROM user_tracks ut JOIN tracks t ON t.id=ut.track_id) m JOIN users mu ON mu.id=m.user_id AND mu.status='active' WHERE m.category_id=c.id) AS member_count FROM categories c WHERE c.id IN (SELECT p.category_id FROM enrolments e JOIN learning_paths p ON p.id=e.path_id WHERE e.user_id=? UNION SELECT t.category_id FROM user_tracks ut JOIN tracks t ON t.id=ut.track_id WHERE ut.user_id=?) ORDER BY c.name", [$uid,$uid]);
        } catch (\Throwable $e) {
            return [];
        }
    }
    public static function isMember(int $uid, int $categoryId): bool
    {
        return (bool)array_filter(self::rooms($uid), fn($r)=>(int)$r['id'] === $categoryId);
    }
    public static function members(int $categoryId, int $limit = 60): array
    {
        $rows = DB::all("SELECT u.id,u.full_name,(SELECT COALESCE(SUM(x.amount),0) FROM xp_transactions x WHERE x.user_id=u.id) AS xp FROM users u WHERE u.status='active' AND u.id IN (SELECT e.user_id FROM enrolments e JOIN learning_paths p ON p.id=e.path_id WHERE p.category_id=? UNION SELECT ut.user_id FROM user_tracks ut JOIN tracks t ON t.id=ut.track_id WHERE t.category_id=?) ORDER BY xp DESC,u.full_name LIMIT " . (int)$limit, [$categoryId,$categoryId]);
        foreach ($rows as &$r) {
            $lvl = DB::one('SELECT level,title FROM level_definitions WHERE minimum_xp<=? ORDER BY minimum_xp DESC LIMIT 1', [$r['xp']]);
            $r['level'] = (int)($lvl['level'] ?? 1);
            $r['level_title'] = $lvl['title'] ?? 'Explorer';
        }
        return $rows;
    }
    public static function messages(int $categoryId, int $after = 0, int $limit = 60): array
    {
        $base = "SELECT m.id,m.kind,m.body,m.created_at,m.user_id,u.full_name FROM chat_messages m LEFT JOIN users u ON u.id=m.user_id WHERE m.category_id=? AND m.hidden=0";
        if ($after > 0) {
            return DB::all($base . ' AND m.id>? ORDER BY m.id LIMIT ' . (int)$limit, [$categoryId,$after]);
        }
        return array_reverse(DB::all($base . ' ORDER BY m.id DESC LIMIT ' . (int)$limit, [$categoryId]));
    }
    public static function post(int $uid, int $categoryId, string $body): int
    {
        Security::throttle('chat:' . $uid, 20, 60);
        return DB::insert("INSERT INTO chat_messages(category_id,user_id,kind,body) VALUES(?,?,'message',?)", [$categoryId,$uid,$body]);
    }
    /** Post an automatic highlight (level, achievement, course, joined). Never lets a chat failure break learning progress. */
    public static function highlight(int $uid, string $kind, string $body, ?int $categoryId = null): void
    {
        try {
            $ids = $categoryId ? [$categoryId] : array_map('intval', array_column(self::rooms($uid), 'id'));
            foreach ($ids as $id) {
                DB::run('INSERT INTO chat_messages(category_id,user_id,kind,body) VALUES(?,?,?,?)', [$id,$uid,$kind,mb_substr($body, 0, 900)]);
            }
        } catch (\Throwable $e) {
        }
    }
    public static function hide(int $messageId): void
    {
        DB::run('UPDATE chat_messages SET hidden=1 WHERE id=?', [$messageId]);
    }
}
