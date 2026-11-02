<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;
use Learnow\Validators\Validate as V;

final class QuizService
{
    public static function definition(int $uid, int $qid): array
    {
        $q = DB::one("SELECT q.*,s.path_id FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE q.id=? AND q.status='published'", [$qid]);
        if (!$q) {
            abort(404, 'This quiz is not available.');
        } LearningService::assertStage($uid, (int)$q['stage_id']);
        if ($q['lesson_id']) {
            LearningService::lesson($uid, (int)$q['lesson_id']);
        }
        return $q;
    }
    public static function lives(int $uid): array
    {
        $max = max(1, min(20, (int)setting('lives_max', 5)));
        $interval = max(1, (int)setting('lives_recovery_minutes', 60)) * 60;
        DB::run('INSERT IGNORE INTO lives_records(user_id,remaining) VALUES(?,?)', [$uid,$max]);
        $r = DB::one('SELECT * FROM lives_records WHERE user_id=? FOR UPDATE', [$uid]);
        $restored = (int)floor((time() - strtotime($r['updated_at'])) / $interval);
        if ($restored > 0 || $r['remaining'] > $max) {
            $count = min($max, (int)$r['remaining'] + $restored);
            $updated = $count === $max ? time() : strtotime($r['updated_at']) + $restored * $interval;
            DB::run('UPDATE lives_records SET remaining=?,updated_at=? WHERE user_id=?', [$count,gmdate('Y-m-d H:i:s', $updated),$uid]);
            $r['remaining'] = $count;
            $r['updated_at'] = gmdate('Y-m-d H:i:s', $updated);
        }
        $r['maximum'] = $max;
        $r['next_recovery'] = gmdate('c', strtotime($r['updated_at']) + $interval);
        return $r;
    }
    public static function start(int $uid, int $qid): int
    {
        return DB::transaction(function () use ($uid, $qid) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
            DB::one('SELECT id FROM quizzes WHERE id=? FOR UPDATE', [$qid]);
            $q = self::definition($uid, $qid);
            $open = DB::one("SELECT * FROM quiz_attempts WHERE user_id=? AND quiz_id=? AND status IN('in_progress','pending_review') ORDER BY id DESC LIMIT 1", [$uid,$qid]);
            if ($open) {
                if ($open['status'] === 'pending_review') {
                    abort(422, 'Your written answers are waiting for review. You’ll be notified when they’re graded.');
                } return (int)$open['id'];
            }
            $count = (int)DB::value('SELECT COUNT(*) FROM quiz_attempts WHERE user_id=? AND quiz_id=?', [$uid,$qid]);
            if ($q['attempt_limit'] && $count >= $q['attempt_limit']) {
                abort(422, 'You’ve used the available attempts. Ask an administrator for guidance.');
            }
            if (!DB::value('SELECT COUNT(*) FROM quiz_questions WHERE quiz_id=?', [$qid])) {
                abort(422, 'This quiz has no published questions yet.');
            }
            if ($q['uses_lives'] && (int)setting('lives_enabled', 0) && self::lives($uid)['remaining'] < 1) {
                abort(422, 'Take a breather. Your next quiz life is recovering. You can keep reading lessons in the meantime.');
            }
            return DB::insert('INSERT INTO quiz_attempts(user_id,quiz_id,deadline_at) VALUES(?,?,?)', [$uid,$qid,$q['time_limit_minutes'] ? gmdate('Y-m-d H:i:s', time() + 60 * $q['time_limit_minutes']) : null]);
        });
    }
    public static function submit(int $uid, int $attemptId, array $answers): array
    {
        return DB::transaction(function () use ($uid, $attemptId, $answers) {
            DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$uid]);
            $a = DB::one('SELECT * FROM quiz_attempts WHERE id=? AND user_id=? FOR UPDATE', [$attemptId,$uid]);
            if (!$a) {
                abort(404, 'Quiz attempt not found.');
            } if ($a['status'] !== 'in_progress') {
                return $a;
            }
            $q = self::definition($uid, (int)$a['quiz_id']);
            $questions = DB::all('SELECT * FROM quiz_questions WHERE quiz_id=? ORDER BY position,id', [$q['id']]);
            $expired = $a['deadline_at'] && strtotime($a['deadline_at']) < time();
            $total = 0;
            $points = 0;
            $manual = false;
            $wrong = 0;
            foreach ($questions as $question) {
                $total += (int)$question['points'];
                $value = $answers[(string)$question['id']] ?? [];
                $earned = null;
                $text = null;
                $selected = [];
                if ($question['type'] === 'short') {
                    $text = V::text(is_array($value) ? '' : $value, 'Written answer', 0, 5000);
                    $manual = true;
                } else {
                    $selected = V::ids(is_array($value) ? $value : [$value], 30);
                    $options = DB::all('SELECT id,is_correct FROM answer_options WHERE question_id=?', [$question['id']]);
                    $valid = array_map('intval', array_column($options, 'id'));
                    foreach ($selected as $id) {
                        if (!in_array($id, $valid, true)) {
                            abort(422, 'An answer option does not belong to its question.');
                        }
                    } if (in_array($question['type'], ['single','boolean'], true) && count($selected) > 1) {
                        abort(422, 'Select only one answer for this question.');
                    }
                    $correct = array_map('intval', array_column(array_filter($options, fn($o)=>$o['is_correct']), 'id'));
                    sort($correct);
                    sort($selected);
                    $earned = (!$expired && $correct === $selected && count($correct) > 0) ? (int)$question['points'] : 0;
                    $points += $earned;
                    if (!$earned) {
                        $wrong++;
                    }
                }
                $response = DB::insert('INSERT INTO quiz_responses(attempt_id,question_id,answer_text,awarded_points) VALUES(?,?,?,?)', [$attemptId,$question['id'],$text,$earned]);
                foreach ($selected as $oid) {
                    DB::run('INSERT INTO quiz_response_options(response_id,option_id) VALUES(?,?)', [$response,$oid]);
                }
            }
            $score = $total ? round($points / $total * 100, 2) : 0;
            $status = $expired ? 'failed' : ($manual ? 'pending_review' : ($score >= $q['passing_score'] ? 'passed' : 'failed'));
            DB::run('UPDATE quiz_attempts SET status=?,score=?,awarded_points=?,total_points=?,submitted_at=UTC_TIMESTAMP() WHERE id=?', [$status,$manual && !$expired ? null : $score,$points,$total,$attemptId]);
            if ($q['uses_lives'] && (int)setting('lives_enabled', 0) && $wrong) {
                self::lives($uid);
                $consume = setting('lives_loss_mode', 'attempt') === 'question' ? $wrong : 1;
                DB::run('UPDATE lives_records SET remaining=GREATEST(0,remaining-?),updated_at=UTC_TIMESTAMP() WHERE user_id=?', [$consume,$uid]);
            }
            if ($status === 'passed') {
                RewardService::activity($uid, 'quiz', (int)$q['id'], 5, 'Passed: ' . $q['title']);
                LearningService::checkPath($uid, (int)$q['path_id']);
            }
            return DB::one('SELECT * FROM quiz_attempts WHERE id=?', [$attemptId]);
        });
    }
    public static function grade(int $actor, int $attemptId, array $grades): void
    {
        DB::transaction(function () use ($actor, $attemptId, $grades) {
            $owner = DB::value('SELECT user_id FROM quiz_attempts WHERE id=?', [$attemptId]);
            if (!$owner) {
                abort(404, 'Attempt not found.');
            }DB::one('SELECT id FROM users WHERE id=? FOR UPDATE', [$owner]);
            $a = DB::one("SELECT * FROM quiz_attempts WHERE id=? AND status='pending_review' FOR UPDATE", [$attemptId]);
            if (!$a) {
                abort(422, 'This attempt is not waiting for manual review.');
            }
            $role = DB::value("SELECT r.name FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=? AND u.status='active'", [$actor]);
            if ($role !== 'administrator' && !($role === 'reviewer' && (int)$a['assigned_reviewer_id'] === $actor)) {
                abort(403, 'You are not authorised to grade this attempt.');
            }
            $responses = DB::all("SELECT r.*,q.points FROM quiz_responses r JOIN quiz_questions q ON q.id=r.question_id WHERE r.attempt_id=? AND q.type='short'", [$attemptId]);
            foreach ($responses as $r) {
                $g = $grades[$r['id']] ?? [];
                $points = V::int($g['points'] ?? null, 'Awarded points', 0, (int)$r['points']);
                $feedback = V::text($g['feedback'] ?? '', 'Feedback', 0, 3000);
                DB::run('UPDATE quiz_responses SET awarded_points=?,feedback=? WHERE id=?', [$points,$feedback,$r['id']]);
            }
            $points = (float)DB::value('SELECT SUM(awarded_points) FROM quiz_responses WHERE attempt_id=?', [$attemptId]);
            $score = round($points / max(1, $a['total_points']) * 100, 2);
            $q = DB::one('SELECT q.*,s.path_id FROM quizzes q JOIN stages s ON s.id=q.stage_id WHERE q.id=?', [$a['quiz_id']]);
            $status = $score >= $q['passing_score'] ? 'passed' : 'failed';
            DB::run('UPDATE quiz_attempts SET awarded_points=?,score=?,status=?,graded_by=? WHERE id=?', [$points,$score,$status,$actor,$attemptId]);
            if ($status === 'passed') {
                RewardService::activity((int)$a['user_id'], 'quiz', (int)$q['id'], 5, 'Passed: ' . $q['title']);
                LearningService::checkPath((int)$a['user_id'], (int)$q['path_id']);
            }
            NotificationService::notify((int)$a['user_id'], 'feedback', 'Your quiz results are ready', 'Your written answers have been reviewed.', '/quizzes/' . $q['id'] . '?attempt=' . $attemptId, 'quiz-grade:' . $attemptId);
            audit($actor, 'quiz.grade', 'quiz_attempt', $attemptId, ['score' => $score]);
        });
    }
}
