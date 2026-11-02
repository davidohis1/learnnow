<?php

namespace Learnow\Services;

use Learnow\Helpers\HttpError;
use Learnow\Repositories\DB;

/** Skill areas, roadmap tracks and course-order gating. Every method degrades safely if migration 008 has not been applied. */
final class TrackService
{
    public static function areas(): array
    {
        try {
            return DB::all("SELECT c.id,c.name,c.slug,c.icon,c.color,i.availability,i.tagline,i.summary,i.position,(SELECT COUNT(*) FROM learning_paths p WHERE p.category_id=c.id AND p.status='published') AS course_count FROM skill_area_info i JOIN categories c ON c.id=i.category_id ORDER BY i.position,c.id");
        } catch (\Throwable $e) {
            return [];
        }
    }
    public static function area(string $slug): ?array
    {
        try {
            return DB::one('SELECT c.id,c.name,c.slug,c.icon,c.color,i.availability,i.tagline,i.summary,i.article FROM skill_area_info i JOIN categories c ON c.id=i.category_id WHERE c.slug=?', [$slug]) ?: null;
        } catch (\Throwable $e) {
            return null;
        }
    }
    public static function tracks(int $categoryId, ?int $uid): array
    {
        $tracks = DB::all('SELECT * FROM tracks WHERE category_id=? ORDER BY position,id', [$categoryId]);
        foreach ($tracks as &$t) {
            $t['items'] = self::items((int)$t['id'], $uid);
            $t['chosen'] = $uid ? (bool)DB::value('SELECT 1 FROM user_tracks WHERE user_id=? AND track_id=?', [$uid,$t['id']]) : false;
            $t['available_count'] = count(array_filter($t['items'], fn($i)=>$i['state'] !== 'coming_soon'));
            $t['completed_count'] = count(array_filter($t['items'], fn($i)=>$i['state'] === 'completed'));
        }
        return $tracks;
    }
    public static function track(string $slug, ?int $uid): ?array
    {
        try {
            $t = DB::one('SELECT t.*,c.name AS category_name,c.slug AS category_slug FROM tracks t JOIN categories c ON c.id=t.category_id WHERE t.slug=?', [$slug]);
        } catch (\Throwable $e) {
            return null;
        }
        if (!$t) {
            return null;
        }
        $t['items'] = self::items((int)$t['id'], $uid);
        $t['chosen'] = $uid ? (bool)DB::value('SELECT 1 FROM user_tracks WHERE user_id=? AND track_id=?', [$uid,$t['id']]) : false;
        return $t;
    }
    /** Items grouped by order with a computed state: completed, in_progress, available, locked or coming_soon. */
    public static function items(int $trackId, ?int $uid): array
    {
        $rows = DB::all("SELECT i.*,p.id AS path_id,p.title AS path_title,e.user_id AS enrolled_user,e.completed_at FROM track_items i LEFT JOIN learning_paths p ON p.slug=i.path_slug AND p.status='published' LEFT JOIN enrolments e ON e.path_id=p.id AND e.user_id=? WHERE i.track_id=? ORDER BY i.step,i.position,i.id", [$uid ?? 0,$trackId]);
        $steps = array_values(array_unique(array_map('intval', array_column($rows, 'step'))));
        sort($steps);
        $stepDone = [];
        $byLabel = [];
        foreach ($rows as $r) {
            $done = $r['path_id'] && $r['completed_at'];
            $stepDone[(int)$r['step']] = ($stepDone[(int)$r['step']] ?? false) || $done;
            $byLabel[$r['label']] = $done;
        }
        foreach ($rows as &$r) {
            $step = (int)$r['step'];
            $idx = array_search($step, $steps, true);
            $prev = $idx > 0 ? $steps[$idx - 1] : null;
            $r['blockers'] = [];
            if (!$r['path_id']) {
                $r['state'] = 'coming_soon';
                continue;
            }
            if ($r['completed_at']) {
                $r['state'] = 'completed';
                continue;
            }
            if ($prev === null) {
                $unlocked = true;
            } elseif ($r['requires_label']) {
                $unlocked = !empty($byLabel[$r['requires_label']]);
                if (!$unlocked) {
                    $r['blockers'] = [$r['requires_label']];
                }
            } else {
                $unlocked = !empty($stepDone[$prev]);
                if (!$unlocked) {
                    $r['blockers'] = array_values(array_map(fn($x)=>$x['label'], array_filter($rows, fn($x)=>(int)$x['step'] === $prev)));
                }
            }
            $r['state'] = !$unlocked ? 'locked' : ($r['enrolled_user'] ? 'in_progress' : 'available');
        }
        return $rows;
    }
    /** Server-side gate used before enrolment. Courses outside every track are never restricted. */
    public static function assertCanEnrol(int $uid, int $pathId): void
    {
        try {
            if (DB::value('SELECT 1 FROM enrolments WHERE user_id=? AND path_id=?', [$uid,$pathId])) {
                return;
            }
            $tracks = DB::all("SELECT DISTINCT i.track_id FROM track_items i JOIN learning_paths p ON p.slug=i.path_slug WHERE p.id=?", [$pathId]);
            if (!$tracks) {
                return;
            }
            $blockers = [];
            foreach ($tracks as $t) {
                foreach (self::items((int)$t['track_id'], $uid) as $item) {
                    if ((int)$item['path_id'] !== $pathId) {
                        continue;
                    }
                    if ($item['state'] !== 'locked') {
                        return;
                    }
                    $blockers = $blockers ?: $item['blockers'];
                }
            }
        } catch (HttpError $e) {
            throw $e;
        } catch (\Throwable $e) {
            return;
        }
        abort(403, 'First complete: ' . implode(' or ', $blockers ?: ['the previous course']) . '. Courses unlock in roadmap order.');
    }
    public static function choose(int $uid, int $trackId): array
    {
        $t = DB::one('SELECT * FROM tracks WHERE id=?', [$trackId]);
        if (!$t) {
            abort(404, 'This track could not be found.');
        }
        DB::run('INSERT IGNORE INTO user_tracks(user_id,track_id) VALUES(?,?)', [$uid,$trackId]);
        ChatService::highlight($uid, 'joined', 'started the ' . $t['title'] . ' track', (int)$t['category_id']);
        return $t;
    }
}
