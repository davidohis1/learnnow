<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;

final class LearningService
{
    public static function catalogue(?int $uid = null, string $search = '', string $category = ''): array
    {
        $sql = "SELECT p.*,c.name AS category,c.icon,c.color,(SELECT COUNT(*) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=p.id AND l.status='published') AS lesson_count,(SELECT COALESCE(SUM(l.duration_minutes),0) FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=p.id AND l.status='published') AS duration_minutes FROM learning_paths p JOIN categories c ON c.id=p.category_id WHERE p.status='published'";
        $params = [];
        if ($search !== '') {
            $sql .= ' AND (p.title LIKE ? OR p.description LIKE ?)';
            $params[] = '%' . $search . '%';
            $params[] = '%' . $search . '%';
        } if ($category !== '') {
            $sql .= ' AND c.slug=?';
            $params[] = $category;
        }
        $sql .= ' ORDER BY p.id LIMIT 60';
        $paths = DB::all($sql, $params);
        foreach ($paths as &$p) {
            $p['enrolled'] = $uid && (bool)DB::value('SELECT 1 FROM enrolments WHERE user_id=? AND path_id=?', [$uid,$p['id']]);
            $p['completed'] = $uid ? (int)DB::value("SELECT COUNT(*) FROM lesson_progress lp JOIN lessons l ON l.id=lp.lesson_id JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE lp.user_id=? AND s.path_id=? AND l.status='published'", [$uid,$p['id']]) : 0;
            $p['progress'] = $p['lesson_count'] ? min(100, round($p['completed'] / $p['lesson_count'] * 100)) : 0;
        }
        return $paths;
    }
    public static function path(string|int $id): array
    {
        $p = DB::one("SELECT p.*,c.name AS category,c.icon,c.color FROM learning_paths p JOIN categories c ON c.id=p.category_id WHERE (p.slug=? OR p.id=?) AND p.status='published'", [(string)$id,ctype_digit((string)$id) ? (int)$id : 0]);
        if (!$p) {
            abort(404, 'This learning path is not currently available.');
        } return $p;
    }
    public static function enrol(int $uid, int $pathId): void
    {
        $path = self::path($pathId);
        TrackService::assertCanEnrol($uid, $pathId);
        if (DB::run('INSERT IGNORE INTO enrolments(user_id,path_id) VALUES(?,?)', [$uid,$pathId])->rowCount() && (int)DB::value('SELECT COUNT(*) FROM enrolments e JOIN learning_paths p ON p.id=e.path_id WHERE e.user_id=? AND p.category_id=?', [$uid,$path['category_id']]) === 1) {
            ChatService::highlight($uid, 'joined', 'joined the ' . $path['category'] . ' learners', (int)$path['category_id']);
        }
    }
    public static function stageComplete(int $uid, int $stage): bool
    {
        $lesson = DB::one("SELECT COUNT(*) AS total,SUM(EXISTS(SELECT 1 FROM lesson_progress lp WHERE lp.user_id=? AND lp.lesson_id=l.id)) AS done FROM lessons l JOIN modules m ON m.id=l.module_id WHERE m.stage_id=? AND l.status='published' AND l.required=1", [$uid,$stage]);
        $quiz = DB::one("SELECT COUNT(*) AS total,SUM(EXISTS(SELECT 1 FROM quiz_attempts a WHERE a.user_id=? AND a.quiz_id=q.id AND a.status='passed')) AS done FROM quizzes q WHERE q.stage_id=? AND q.status='published' AND q.required=1", [$uid,$stage]);
        $assignment = DB::one("SELECT COUNT(*) AS total,SUM(EXISTS(SELECT 1 FROM assignment_submissions s WHERE s.user_id=? AND s.assignment_id=a.id AND s.status='accepted' AND s.score>=a.passing_score)) AS done FROM assignments a WHERE a.stage_id=? AND a.status='published' AND a.required=1", [$uid,$stage]);
        $total = (int)$lesson['total'] + (int)$quiz['total'] + (int)$assignment['total'];
        return $total > 0 && (int)$lesson['done'] === (int)$lesson['total'] && (int)$quiz['done'] === (int)$quiz['total'] && (int)$assignment['done'] === (int)$assignment['total'];
    }
    public static function requirements(int $uid, int $stage): array
    {
        if (DB::value('SELECT 1 FROM stage_overrides WHERE user_id=? AND stage_id=?', [$uid,$stage])) {
            return [];
        }
        $prereqs = DB::all('SELECT s.* FROM stage_prerequisites sp JOIN stages s ON s.id=sp.required_stage_id WHERE sp.stage_id=? UNION SELECT s.* FROM skill_connections sc JOIN skill_nodes n ON n.id=sc.node_id JOIN skill_nodes p ON p.id=sc.prerequisite_node_id JOIN stages s ON s.id=p.stage_id WHERE n.stage_id=?', [$stage,$stage]);
        return array_values(array_filter($prereqs, fn($s)=>!self::stageComplete($uid, (int)$s['id'])));
    }
    public static function assertStage(int $uid, int $stage): array
    {
        $s = DB::one("SELECT s.*,p.slug AS path_slug,p.title AS path_title FROM stages s JOIN learning_paths p ON p.id=s.path_id JOIN enrolments e ON e.path_id=p.id AND e.user_id=? WHERE s.id=? AND p.status='published'", [$uid,$stage]);
        if (!$s) {
            abort(403, 'Enrol in this published path before starting an activity.');
        }
        $missing = self::requirements($uid, $stage);
        if ($missing) {
            abort(403, 'First complete: ' . implode(', ', array_column($missing, 'title')) . '.');
        } return $s;
    }
    public static function lesson(int $uid, int $id): array
    {
        $l = DB::one("SELECT l.*,m.stage_id,m.title AS module_title,s.path_id,s.title AS stage_title,p.title AS path_title,p.slug AS path_slug FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id JOIN learning_paths p ON p.id=s.path_id WHERE l.id=? AND l.status='published' AND p.status='published'", [$id]);
        if (!$l) {
            abort(404, 'This lesson is not available.');
        } self::assertStage($uid, (int)$l['stage_id']);
        $missing = DB::all('SELECT l.title FROM lesson_prerequisites p JOIN lessons l ON l.id=p.required_lesson_id LEFT JOIN lesson_progress lp ON lp.lesson_id=l.id AND lp.user_id=? WHERE p.lesson_id=? AND lp.user_id IS NULL', [$uid,$id]);
        if ($missing) {
            abort(403, 'First finish: ' . implode(', ', array_column($missing, 'title')) . '.');
        } return $l;
    }
    public static function completeLesson(int $uid, int $id): void
    {
        DB::transaction(function () use ($uid, $id) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
            $l = self::lesson($uid, $id);
            if ($l['require_checklist'] && DB::value('SELECT COUNT(*) FROM lesson_checklists c LEFT JOIN checklist_progress p ON p.checklist_id=c.id AND p.user_id=? WHERE c.lesson_id=? AND p.user_id IS NULL', [$uid,$id])) {
                abort(422, 'Complete every item on the lesson checklist first.');
            }
            if (DB::value("SELECT COUNT(*) FROM quizzes q WHERE q.lesson_id=? AND q.required=1 AND q.status='published' AND NOT EXISTS(SELECT 1 FROM quiz_attempts a WHERE a.quiz_id=q.id AND a.user_id=? AND a.status='passed')", [$id,$uid])) {
                abort(422, 'Pass this lesson’s required knowledge check first.');
            }
            if (DB::value("SELECT COUNT(*) FROM assignments a WHERE a.lesson_id=? AND a.required=1 AND a.status='published' AND NOT EXISTS(SELECT 1 FROM assignment_submissions s WHERE s.assignment_id=a.id AND s.user_id=? AND s.status='accepted' AND s.score>=a.passing_score)", [$id,$uid])) {
                abort(422, 'This lesson’s required assignment needs to be accepted first.');
            }
            if (DB::run('INSERT IGNORE INTO lesson_progress(user_id,lesson_id) VALUES(?,?)', [$uid,$id])->rowCount()) {
                RewardService::activity($uid, 'lesson', $id, (int)$l['duration_minutes'], 'Completed: ' . $l['title']);
            }
            self::checkPath($uid, (int)$l['path_id']);
        });
    }
    public static function checkPath(int $uid, int $pathId): bool
    {
        $stages = DB::all('SELECT id FROM stages WHERE path_id=?', [$pathId]);
        if (!$stages) {
            return false;
        }
        foreach ($stages as $s) {
            if (!self::stageComplete($uid, (int)$s['id'])) {
                return false;
            }
        }
        $already = DB::value('SELECT completed_at FROM enrolments WHERE user_id=? AND path_id=?', [$uid,$pathId]);
        DB::run('UPDATE enrolments SET completed_at=COALESCE(completed_at,UTC_TIMESTAMP()) WHERE user_id=? AND path_id=?', [$uid,$pathId]);
        if (!$already && DB::value('SELECT completed_at FROM enrolments WHERE user_id=? AND path_id=?', [$uid,$pathId])) {
            $p = DB::one('SELECT title,category_id FROM learning_paths WHERE id=?', [$pathId]);
            ChatService::highlight($uid, 'course', 'completed the course “' . $p['title'] . '”', (int)$p['category_id']);
        }
        return true;
    }
    public static function map(int $uid, int $pathId): array
    {
        $stages = DB::all('SELECT * FROM stages WHERE path_id=? ORDER BY position,id', [$pathId]);
        foreach ($stages as &$s) {
            $s['requirements'] = self::requirements($uid, (int)$s['id']);
            $s['lessons'] = DB::all("SELECT l.*,m.title AS module_title,lp.completed_at,EXISTS(SELECT 1 FROM lesson_prerequisites req LEFT JOIN lesson_progress done ON done.lesson_id=req.required_lesson_id AND done.user_id=? WHERE req.lesson_id=l.id AND done.user_id IS NULL) AS prerequisite_locked FROM lessons l JOIN modules m ON m.id=l.module_id LEFT JOIN lesson_progress lp ON lp.lesson_id=l.id AND lp.user_id=? WHERE m.stage_id=? AND l.status='published' ORDER BY m.position,l.position,l.id", [$uid,$uid,$s['id']]);
            $s['quizzes'] = DB::all("SELECT q.*,EXISTS(SELECT 1 FROM quiz_attempts a WHERE a.quiz_id=q.id AND a.user_id=? AND a.status='passed') AS passed FROM quizzes q WHERE q.stage_id=? AND q.status='published'", [$uid,$s['id']]);
            $s['assignments'] = DB::all("SELECT a.*,s.status AS submission_status FROM assignments a LEFT JOIN assignment_submissions s ON s.assignment_id=a.id AND s.user_id=? WHERE a.stage_id=? AND a.status='published'", [$uid,$s['id']]);
            $s['completed_count'] = count(array_filter($s['lessons'], fn($l)=>$l['completed_at']));
            $s['state'] = $s['requirements'] ? 'locked' : ($s['completed_count'] ? 'in_progress' : 'available');
            if (self::stageComplete($uid, (int)$s['id'])) {
                $s['state'] = 'completed';
                $quizCount = count($s['quizzes']);
                $mastered = (int)DB::value("SELECT COUNT(*) FROM quizzes q WHERE q.stage_id=? AND q.status='published' AND EXISTS(SELECT 1 FROM quiz_attempts a WHERE a.quiz_id=q.id AND a.user_id=? AND a.status='passed' AND a.score>=90)", [$s['id'],$uid]);
                if ($quizCount && $mastered === $quizCount) {
                    $s['state'] = 'mastered';
                }
            }
        }
        return $stages;
    }
    public static function nextLesson(int $uid, ?int $pathId = null): ?array
    {
        $params = [$uid,$uid];
        $where = '';
        if ($pathId) {
            $where = ' AND s.path_id=?';
            $params[] = $pathId;
        }
        $lessons = DB::all("SELECT l.id,l.title,m.stage_id,s.path_id,p.slug AS path_slug,p.title AS path_title,l.duration_minutes FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id JOIN learning_paths p ON p.id=s.path_id JOIN enrolments e ON e.path_id=p.id AND e.user_id=? LEFT JOIN lesson_progress lp ON lp.lesson_id=l.id AND lp.user_id=? WHERE lp.user_id IS NULL AND p.status='published' AND l.status='published' $where ORDER BY e.enrolled_at DESC,s.position,m.position,l.position LIMIT 100", $params);
        foreach ($lessons as $l) {
            try {
                self::lesson($uid, (int)$l['id']);
                return $l;
            } catch (\Learnow\Helpers\HttpError $e) {
                continue;
            }
        } return null;
    }
    public static function certificate(int $uid, int $pathId): array
    {
        return DB::transaction(function () use ($uid, $pathId) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
            $p = self::path($pathId);
            if (!$p['certificate_enabled'] || !DB::value('SELECT 1 FROM enrolments WHERE user_id=? AND path_id=?', [$uid,$pathId]) || !self::checkPath($uid, $pathId)) {
                abort(422, 'Complete every required lesson, quiz and assignment before requesting your certificate.');
            }
            $best = DB::all("SELECT q.id,(SELECT MAX(a.score) FROM quiz_attempts a WHERE a.quiz_id=q.id AND a.user_id=? AND a.status='passed') AS score FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE s.path_id=? AND q.required=1 AND q.status='published'", [$uid,$pathId]);
            $avg = $best ? array_sum(array_column($best, 'score')) / count($best) : 100;
            if ($avg < $p['certificate_min_score']) {
                abort(422, 'Your assessment average does not yet meet the certificate requirement.');
            }
            $name = DB::value('SELECT full_name FROM users WHERE id=?', [$uid]);
            $issued = DB::run('INSERT IGNORE INTO certificates(identifier,user_id,path_id,learner_name,path_title) VALUES(?,?,?,?,?)', [bin2hex(random_bytes(16)),$uid,$pathId,$name,$p['title']])->rowCount();
            if ($issued) {
                audit($uid, 'certificate.issue', 'certificates', DB::pdo()->lastInsertId(), ['path' => $pathId,'eligibility' => 'server-validated']);
            }
            $cert = DB::one('SELECT * FROM certificates WHERE user_id=? AND path_id=?', [$uid,$pathId]);
            if ($cert['revoked_at']) {
                abort(403, 'This certificate was revoked. Contact support for a review.');
            } return $cert;
        });
    }
}
