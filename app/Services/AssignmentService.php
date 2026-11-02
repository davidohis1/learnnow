<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;
use Learnow\Validators\Validate as V;

final class AssignmentService
{
    public static function definition(int $uid, int $id): array
    {
        $a = DB::one("SELECT a.*,s.path_id,p.slug AS path_slug FROM assignments a JOIN stages s ON s.id=a.stage_id JOIN learning_paths p ON p.id=s.path_id WHERE a.id=? AND a.status='published'", [$id]);
        if (!$a) {
            abort(404, 'This assignment is not available.');
        } LearningService::assertStage($uid, (int)$a['stage_id']);
        if ($a['lesson_id']) {
            LearningService::lesson($uid, (int)$a['lesson_id']);
        }
        return $a;
    }
    public static function submit(int $uid, int $id, array $d): void
    {
        $a = self::definition($uid, $id);
        $content = V::text($d['content'] ?? '', 'Your response', 0, 15000);
        $url = V::url($d['project_url'] ?? '', 'project URL');
        $action = V::choice($d['action'] ?? 'submitted', ['draft','submitted'], 'submission action');
        if ((!$a['allow_text'] && $content !== '') || (!$a['allow_url'] && $url)) {
            abort(422, 'That submission type is not enabled for this assignment.');
        }
        $file = null;
        if (!empty($_FILES['attachment']) && $_FILES['attachment']['error'] !== UPLOAD_ERR_NO_FILE) {
            if (!$a['allow_file']) {
                abort(422, 'File uploads are not allowed for this assignment.');
            } $file = UploadService::receive($_FILES['attachment']);
        }
        try {
            DB::transaction(function () use ($uid, $id, $content, $url, $action, $file) {
                DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
                $existing = DB::one('SELECT * FROM assignment_submissions WHERE user_id=? AND assignment_id=? FOR UPDATE', [$uid,$id]);
                if ($existing && !in_array($existing['status'], ['draft','revision_requested'], true)) {
                    abort(422, 'This submission is locked while it is being reviewed.');
                }
                if ($action === 'submitted' && !$content && !$url && !$file && empty($existing['file_key'])) {
                    abort(422, 'Add a response, a project URL or an approved attachment before submitting.');
                }
                $wasSubmitted = $existing && (bool)DB::value("SELECT 1 FROM submission_history WHERE submission_id=? AND status IN('submitted','resubmitted') LIMIT 1", [$existing['id']]);
                $status = $action === 'submitted' && $wasSubmitted ? 'resubmitted' : $action;
                $key = $file['key'] ?? ($existing['file_key'] ?? null);
                $name = $file['name'] ?? ($existing['file_name'] ?? null);
                $mime = $file['mime'] ?? ($existing['file_mime'] ?? null);
                DB::run('INSERT INTO assignment_submissions(user_id,assignment_id,content,project_url,file_key,file_name,file_mime,status,submitted_at) VALUES(?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE content=VALUES(content),project_url=VALUES(project_url),file_key=VALUES(file_key),file_name=VALUES(file_name),file_mime=VALUES(file_mime),status=VALUES(status),submitted_at=VALUES(submitted_at),score=NULL', [$uid,$id,$content,$url,$key,$name,$mime,$status,$action === 'submitted' ? gmdate('Y-m-d H:i:s') : null]);
                $sid = (int)DB::value('SELECT id FROM assignment_submissions WHERE user_id=? AND assignment_id=?', [$uid,$id]);
                DB::run('INSERT INTO submission_history(submission_id,content,project_url,file_key,status) VALUES(?,?,?,?,?)', [$sid,$content,$url,$key,$status]);
            });
        } catch (\Throwable $e) {
            if ($file) {
                @unlink(ROOT . '/storage/uploads/' . $file['key']);
            } throw $e;
        }
    }
    public static function review(int $actor, int $id, array $d): void
    {
        DB::transaction(function () use ($actor, $id, $d) {
            $owner = DB::value('SELECT user_id FROM assignment_submissions WHERE id=?', [$id]);
            if (!$owner) {
                abort(404, 'Submission not found.');
            }DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$owner]);
            $s = DB::one('SELECT s.*,a.max_score,a.passing_score,a.title,st.path_id FROM assignment_submissions s JOIN assignments a ON a.id=s.assignment_id JOIN stages st ON st.id=a.stage_id WHERE s.id=? FOR UPDATE', [$id]);
            if (!$s) {
                abort(404, 'Submission not found.');
            }
            $role = DB::value("SELECT r.name FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=? AND u.status='active'", [$actor]);
            if ($role !== 'administrator' && !($role === 'reviewer' && (int)$s['reviewer_id'] === $actor)) {
                abort(403, 'You are not authorised to review this submission.');
            }
            if (!in_array($s['status'], ['submitted','resubmitted','under_review','graded'], true)) {
                abort(422, 'This submission is not ready for review.');
            }
            $status = V::choice($d['status'] ?? '', ['under_review','revision_requested','graded','accepted'], 'review status');
            $score = in_array($status, ['graded','accepted'], true) ? V::int($d['score'] ?? null, 'Score', 0, (int)$s['max_score']) : null;
            $feedback = V::text($d['feedback'] ?? '', 'Feedback', 3, 10000);
            if ($status === 'accepted' && $score < $s['passing_score']) {
                abort(422, 'An accepted assignment must meet its required passing score.');
            }
            DB::run('UPDATE assignment_submissions SET status=?,score=?,reviewer_id=? WHERE id=?', [$status,$score,$actor,$id]);
            $feedbackId = DB::insert('INSERT INTO assignment_feedback(submission_id,author_id,action,feedback,score) VALUES(?,?,?,?,?)', [$id,$actor,$status,$feedback,$score]);
            if ($status === 'accepted') {
                RewardService::activity((int)$s['user_id'], 'assignment', (int)$s['assignment_id'], 20, 'Accepted: ' . $s['title']);
                LearningService::checkPath((int)$s['user_id'], (int)$s['path_id']);
            }
            NotificationService::notify((int)$s['user_id'], 'feedback', 'Feedback on your work', $s['title'] . ' has been reviewed. Open your assignment to read the feedback.', '/assignments/' . $s['assignment_id'], 'feedback:' . $id . ':' . $feedbackId);
            audit($actor, 'assignment.review', 'submission', $id, ['status' => $status,'score' => $score]);
        });
    }
}
