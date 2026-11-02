<?php

namespace Learnow\Controllers;

use Learnow\Repositories\DB;
use Learnow\Middleware\Auth;
use Learnow\Services\{LearningService as Learning,RewardService as Rewards,QuizService,UploadService};

final class LearnerController
{
    public function dashboard(): void
    {
        $u = Auth::requireUser();
        if (!$u['onboarding_completed_at'] && $u['role'] === 'learner') {
            redirect('/onboarding');
        } $uid = (int)$u['id'];
        $today = Rewards::today($u);
        $streak = Rewards::streak($uid);
        $paths = Learning::catalogue($uid);
        $enrolled = array_values(array_filter($paths, fn($p)=>$p['enrolled']));
        $interests = array_column(DB::all('SELECT category_id FROM user_interests WHERE user_id=?', [$uid]), 'category_id');
        usort($paths, fn($a, $b)=>(int)in_array($b['category_id'], $interests) <=> (int)in_array($a['category_id'], $interests));
        render('dashboard', ['title' => 'Your learning space','enrolled' => $enrolled,'recommended' => array_slice(array_values(array_filter($paths, fn($p)=>!$p['enrolled'])), 0, 3),'next' => Learning::nextLesson($uid),'rewards' => Rewards::summary($uid),'streak' => $streak,'daily' => DB::one('SELECT * FROM daily_activity WHERE user_id=? AND local_date=?', [$uid,$today]),'prefs' => DB::one('SELECT * FROM user_preferences WHERE user_id=?', [$uid]),'weekly' => DB::all('SELECT * FROM daily_activity WHERE user_id=? AND local_date>=? ORDER BY local_date', [$uid,(new \DateTimeImmutable($today))->modify('-6 days')->format('Y-m-d')]),'achievements' => DB::all('SELECT a.*,la.awarded_at FROM learner_achievements la JOIN achievements a ON a.id=la.achievement_id WHERE la.user_id=? ORDER BY la.awarded_at DESC LIMIT 3', [$uid]),'pending' => DB::all("SELECT a.id,a.title,a.due_at,s.status FROM assignments a JOIN stages st ON st.id=a.stage_id JOIN enrolments e ON e.path_id=st.path_id AND e.user_id=? LEFT JOIN assignment_submissions s ON s.assignment_id=a.id AND s.user_id=? WHERE a.status='published' AND (s.status IS NULL OR s.status<>'accepted') ORDER BY a.due_at IS NULL,a.due_at LIMIT 4", [$uid,$uid]),'recentQuizzes' => DB::all('SELECT a.*,q.title FROM quiz_attempts a JOIN quizzes q ON q.id=a.quiz_id WHERE a.user_id=? ORDER BY a.id DESC LIMIT 3', [$uid]),'counts' => ['lessons' => DB::value('SELECT COUNT(*) FROM lesson_progress WHERE user_id=?', [$uid]),'certificates' => DB::value('SELECT COUNT(*) FROM certificates WHERE user_id=? AND revoked_at IS NULL', [$uid]),'referrals' => DB::value('SELECT COUNT(*) FROM referrals WHERE referrer_id=?', [$uid])],'schedule' => DB::one('SELECT * FROM study_schedules WHERE user_id=?', [$uid]),'days' => array_column(DB::all('SELECT weekday FROM study_days WHERE user_id=?', [$uid]), 'weekday')]);
    }
    public function myLearning(): void
    {
        $u = Auth::requireUser();
        render('my-learning', ['title' => 'A little further, every day','paths' => array_values(array_filter(Learning::catalogue((int)$u['id']), fn($p)=>$p['enrolled']))]);
    }
    public function path(string $slug): void
    {
        $u = Auth::requireUser();
        $p = Learning::path($slug);
        $enrolled = (bool)DB::value('SELECT 1 FROM enrolments WHERE user_id=? AND path_id=?', [$u['id'],$p['id']]);
        render('path', ['title' => $p['title'],'path' => $p,'enrolled' => $enrolled,'stages' => Learning::map((int)$u['id'], (int)$p['id']),'next' => $enrolled ? Learning::nextLesson((int)$u['id'], (int)$p['id']) : null]);
    }
    public function lesson(string $id): void
    {
        $u = Auth::requireUser();
        $uid = (int)$u['id'];
        $l = Learning::lesson($uid, (int)$id);
        $lessons = DB::all("SELECT l.id,l.title,l.duration_minutes,lp.completed_at FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id LEFT JOIN lesson_progress lp ON lp.lesson_id=l.id AND lp.user_id=? WHERE s.path_id=? AND l.status='published' ORDER BY s.position,m.position,l.position,l.id", [$uid,$l['path_id']]);
        render('lesson', ['title' => $l['title'],'lesson' => $l,'lessons' => $lessons,'checklist' => DB::all('SELECT c.*,p.completed_at FROM lesson_checklists c LEFT JOIN checklist_progress p ON p.checklist_id=c.id AND p.user_id=? WHERE c.lesson_id=? ORDER BY c.position,c.id', [$uid,$id]),'note' => DB::value('SELECT content FROM learner_notes WHERE user_id=? AND lesson_id=?', [$uid,$id]) ?: '','noteVersion' => (int)DB::value('SELECT version FROM learner_notes WHERE user_id=? AND lesson_id=?', [$uid,$id]),'resources' => DB::all('SELECT * FROM lesson_resources WHERE lesson_id=?', [$id]),'completed' => (bool)DB::value('SELECT 1 FROM lesson_progress WHERE user_id=? AND lesson_id=?', [$uid,$id]),'quizzes' => DB::all("SELECT * FROM quizzes WHERE lesson_id=? AND status='published'", [$id]),'assignments' => DB::all("SELECT * FROM assignments WHERE lesson_id=? AND status='published'", [$id])]);
    }
    public function quiz(string $id): void
    {
        $u = Auth::requireUser();
        $q = QuizService::definition((int)$u['id'], (int)$id);
        $attempt = null;
        if (isset($_GET['attempt'])) {
            $attempt = DB::one('SELECT * FROM quiz_attempts WHERE id=? AND user_id=? AND quiz_id=?', [(int)$_GET['attempt'],$u['id'],$id]);
        }
        $questions = DB::all('SELECT id,type,prompt,points,position FROM quiz_questions WHERE quiz_id=? ORDER BY position,id', [$id]);
        foreach ($questions as &$question) {
            $question['options'] = DB::all('SELECT id,label FROM answer_options WHERE question_id=? ORDER BY position,id', [$question['id']]);
            if ($attempt && $attempt['status'] !== 'in_progress') {
                $question['response'] = DB::one('SELECT * FROM quiz_responses WHERE attempt_id=? AND question_id=?', [$attempt['id'],$question['id']]);
                if ($q['show_answers']) {
                    $question['explanation'] = DB::value('SELECT explanation FROM quiz_questions WHERE id=?', [$question['id']]);
                    $question['correct'] = DB::all('SELECT label FROM answer_options WHERE question_id=? AND is_correct=1', [$question['id']]);
                }
            }
        }
        render('quiz', ['title' => $q['title'],'quiz' => $q,'attempt' => $attempt,'questions' => $questions,'attempts' => DB::all('SELECT * FROM quiz_attempts WHERE user_id=? AND quiz_id=? ORDER BY id DESC LIMIT 30', [$u['id'],$id]),'lives' => $q['uses_lives'] && (int)setting('lives_enabled', 0) ? DB::transaction(fn()=>QuizService::lives((int)$u['id'])) : null]);
    }
    public function assignments(): void
    {
        $u = Auth::requireUser();
        $offset = (pageNumber() - 1) * 20;
        $sql = " FROM assignments a JOIN stages st ON st.id=a.stage_id JOIN learning_paths p ON p.id=st.path_id JOIN enrolments e ON e.path_id=p.id AND e.user_id=? LEFT JOIN assignment_submissions s ON s.assignment_id=a.id AND s.user_id=? WHERE a.status='published' AND p.status='published'";
        render('assignments', ['title' => 'Turn knowledge into know-how','assignments' => DB::all('SELECT a.*,p.title AS path_title,s.status AS submission_status,s.score' . $sql . ' ORDER BY a.id DESC LIMIT 20 OFFSET ' . $offset, [$u['id'],$u['id']]),'total' => (int)DB::value('SELECT COUNT(*)' . $sql, [$u['id'],$u['id']])]);
    }
    public function assignment(string $id): void
    {
        $u = Auth::requireUser();
        $a = \Learnow\Services\AssignmentService::definition((int)$u['id'], (int)$id);
        $s = DB::one('SELECT * FROM assignment_submissions WHERE user_id=? AND assignment_id=?', [$u['id'],$id]);
        render('assignment', ['title' => $a['title'],'assignment' => $a,'submission' => $s,'rubrics' => DB::all('SELECT * FROM grading_rubrics WHERE assignment_id=?', [$id]),'feedback' => $s ? DB::all('SELECT f.*,u.full_name FROM assignment_feedback f JOIN users u ON u.id=f.author_id WHERE f.submission_id=? ORDER BY f.id DESC', [$s['id']]) : [],'history' => $s ? DB::all('SELECT status,created_at FROM submission_history WHERE submission_id=? ORDER BY id DESC', [$s['id']]) : []]);
    }
    public function achievements(): void
    {
        $u = Auth::requireUser();
        $streak = Rewards::streak((int)$u['id']);
        render('achievements', ['title' => 'Look how far you’ve come','rewards' => Rewards::summary((int)$u['id']),'streak' => $streak,'achievements' => DB::all('SELECT a.*,la.awarded_at FROM achievements a LEFT JOIN learner_achievements la ON la.achievement_id=a.id AND la.user_id=? WHERE a.active=1 ORDER BY a.metric,a.threshold_value', [$u['id']]),'ledger' => DB::all('SELECT * FROM xp_transactions WHERE user_id=? ORDER BY id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20), [$u['id']]),'total' => (int)DB::value('SELECT COUNT(*) FROM xp_transactions WHERE user_id=?', [$u['id']]),'protections' => DB::all('SELECT * FROM streak_protections WHERE user_id=? ORDER BY id DESC LIMIT 30', [$u['id']]),'activity' => DB::all('SELECT * FROM daily_activity WHERE user_id=? ORDER BY local_date DESC LIMIT 60', [$u['id']])]);
    }
    public function certificates(): void
    {
        $u = Auth::requireUser();
        render('certificates', ['title' => 'Progress worth celebrating','certificates' => DB::all('SELECT * FROM certificates WHERE user_id=? ORDER BY issued_at DESC', [$u['id']]),'enrolments' => DB::all('SELECT p.*,e.completed_at FROM enrolments e JOIN learning_paths p ON p.id=e.path_id WHERE e.user_id=? AND p.certificate_enabled=1 AND p.status=\'published\'', [$u['id']])]);
    }
    public function referrals(): void
    {
        $u = Auth::requireUser();
        $code = DB::value('SELECT code FROM referral_codes WHERE user_id=?', [$u['id']]);
        render('referrals', ['title' => 'Good skills are worth sharing','code' => $code,'campaign' => DB::one('SELECT * FROM referral_campaigns WHERE enabled=1 AND (starts_at IS NULL OR starts_at<=UTC_TIMESTAMP()) AND (ends_at IS NULL OR ends_at>=UTC_TIMESTAMP()) ORDER BY id DESC LIMIT 1'),'referrals' => DB::all('SELECT r.id,r.status,r.created_at,r.qualified_at,rr.amount,rr.reward_type FROM referrals r LEFT JOIN referral_rewards rr ON rr.referral_id=r.id WHERE r.referrer_id=? ORDER BY r.id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20), [$u['id']]),'total' => (int)DB::value('SELECT COUNT(*) FROM referrals WHERE referrer_id=?', [$u['id']])]);
    }
    public function notifications(): void
    {
        $u = Auth::requireUser();
        render('notifications', ['title' => 'A little nudge forward','notifications' => DB::all('SELECT * FROM notifications WHERE user_id=? ORDER BY id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20), [$u['id']]),'total' => (int)DB::value('SELECT COUNT(*) FROM notifications WHERE user_id=?', [$u['id']])]);
    }
    public function reports(): void
    {
        $u = Auth::requireUser();
        render('reports', ['title' => 'Your week, in perspective','reports' => DB::all('SELECT * FROM weekly_reports WHERE user_id=? ORDER BY week_start DESC LIMIT 12 OFFSET ' . ((pageNumber() - 1) * 12), [$u['id']]),'total' => (int)DB::value('SELECT COUNT(*) FROM weekly_reports WHERE user_id=?', [$u['id']])]);
    }
    public function download(string $id): void
    {
        $u = Auth::requireUser();
        $s = DB::one('SELECT * FROM assignment_submissions WHERE id=?', [$id]);
        if (!$s || ($s['user_id'] !== $u['id'] && $u['role'] !== 'administrator' && !($u['role'] === 'reviewer' && $s['reviewer_id'] === $u['id']))) {
            abort(404, 'File not found.');
        }UploadService::download($s);
    }
}
