<?php

namespace Learnow\Controllers;

use Learnow\Middleware\{Auth,Security};
use Learnow\Repositories\DB;
use Learnow\Validators\Validate as V;
use Learnow\Services\{LearningService as Learning,QuizService,AssignmentService,RewardService};

final class LearningApiController
{
    public function enrol(string $id): void
    {
        $u = Auth::requireUser();
        Learning::enrol((int)$u['id'], (int)$id);
        $p = Learning::path((int)$id);
        success('You’re in. Your next chapter starts here.', ['redirect' => '/paths/' . $p['slug']]);
    }
    public function note(string $id): void
    {
        $u = Auth::requireUser();
        Learning::lesson((int)$u['id'], (int)$id);
        $d = input();
        $text = V::text($d['content'] ?? '', 'Notes', 0, 20000);
        $expected = V::int($d['version'] ?? 0, 'Note version', 0, 2147483647);
        $version = DB::transaction(function () use ($u, $id, $text, $expected) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$u['id']]);
            $note = DB::one('SELECT content,version FROM learner_notes WHERE user_id=? AND lesson_id=? FOR UPDATE', [$u['id'],$id]);
            if ($note && $note['content'] === $text) {
                return (int)$note['version'];
            }
            if ((int)($note['version'] ?? 0) !== $expected) {
                abort(409, 'These notes were changed in another tab. Copy your current text, then reload to compare the saved version. Nothing has been overwritten.');
            }
            $next = $expected + 1;
            DB::run('INSERT INTO learner_notes(user_id,lesson_id,content,version)VALUES(?,?,?,?) ON DUPLICATE KEY UPDATE content=VALUES(content),version=VALUES(version)', [$u['id'],$id,$text,$next]);
            return $next;
        });
        success('Your private notes are saved.', ['version' => $version]);
    }
    public function checklist(string $id): void
    {
        $u = Auth::requireUser();
        $c = DB::one('SELECT * FROM lesson_checklists WHERE id=?', [$id]);
        if (!$c) {
            abort(404, 'Checklist item not found.');
        }Learning::lesson((int)$u['id'], (int)$c['lesson_id']);
        if (!empty(input()['completed'])) {
            DB::run('INSERT IGNORE INTO checklist_progress(user_id,checklist_id) VALUES(?,?)', [$u['id'],$id]);
        } else {
            DB::run('DELETE FROM checklist_progress WHERE user_id=? AND checklist_id=?', [$u['id'],$id]);
        }
        success('Checklist updated.');
    }
    public function complete(string $id): void
    {
        $u = Auth::requireUser();
        Learning::completeLesson((int)$u['id'], (int)$id);
        success('One step forward. Lesson completed!', ['reload' => true,'celebrate' => true]);
    }
    public function startQuiz(string $id): void
    {
        $u = Auth::requireUser();
        Security::throttle('quiz-start:' . $u['id'], 50, 3600);
        $attempt = QuizService::start((int)$u['id'], (int)$id);
        success('Your knowledge check is ready.', ['redirect' => '/quizzes/' . $id . '?attempt=' . $attempt]);
    }
    public function submitQuiz(string $id): void
    {
        $u = Auth::requireUser();
        $answers = input()['answers'] ?? [];
        if (!is_array($answers)) {
            abort(422, 'Answers must be a question-to-answer map.');
        }$a = QuizService::submit((int)$u['id'], (int)$id, $answers);
        success($a['status'] === 'passed' ? 'Nicely done. You passed!' : ($a['status'] === 'pending_review' ? 'Your answers are ready for review.' : 'Every attempt is a step forward. Review your results.'), ['redirect' => '/quizzes/' . $a['quiz_id'] . '?attempt=' . $a['id'],'result' => ['status' => $a['status'],'score' => $a['score']]]);
    }
    public function assignment(string $id): void
    {
        $u = Auth::requireUser();
        AssignmentService::submit((int)$u['id'], (int)$id, input());
        success((input()['action'] ?? 'submitted') === 'draft' ? 'Your draft is saved.' : 'Your work is submitted for review.', ['reload' => true]);
    }
    public function certificate(string $id): void
    {
        $u = Auth::requireUser();
        $cert = Learning::certificate((int)$u['id'], (int)$id);
        success('You earned it. Your certificate is ready.', ['redirect' => '/verify/' . $cert['identifier']]);
    }
    public function notifications(): void
    {
        $u = Auth::requireUser();
        $id = (int)(input()['id'] ?? 0);
        if ($id) {
            DB::run('UPDATE notifications SET read_at=COALESCE(read_at,UTC_TIMESTAMP()) WHERE id=? AND user_id=?', [$id,$u['id']]);
        } else {
            DB::run('UPDATE notifications SET read_at=COALESCE(read_at,UTC_TIMESTAMP()) WHERE user_id=?', [$u['id']]);
        }
        success('All caught up.', ['reload' => true]);
    }
    public function protection(): void
    {
        $u = Auth::requireUser();
        $key = V::text(input()['request_key'] ?? '', 'Request key', 32, 64);
        RewardService::buyProtection((int)$u['id'], $key);
        success('Streak protection added.', ['reload' => true]);
    }
    public function report(): void
    {
        $u = Auth::requireUser();
        \Learnow\Services\ReportService::generate((int)$u['id']);
        success('Your previous-week report is ready.', ['reload' => true]);
    }
}
