<?php

namespace Learnow\Controllers;

use Learnow\Repositories\DB;
use Learnow\Middleware\Auth;
use Learnow\Services\AdminContentService as Content;

final class AdminController
{
    public function dashboard(): void
    {
        $u = Auth::permission('admin.access');
        if ($u['role'] === 'reviewer') {
            redirect('/admin/reviews');
        }
        $metrics = ['learners' => DB::value("SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name='learner'"),'verified' => DB::value("SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name='learner' AND u.email_verified_at IS NOT NULL"),'active' => DB::value('SELECT COUNT(DISTINCT user_id) FROM activity_events WHERE created_at>=DATE_SUB(UTC_TIMESTAMP(),INTERVAL 30 DAY)'),'new' => DB::value("SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name='learner' AND u.created_at>=DATE_SUB(UTC_TIMESTAMP(),INTERVAL 30 DAY)"),'paths' => DB::value("SELECT COUNT(*) FROM learning_paths WHERE status='published'"),'lessons' => DB::value("SELECT COUNT(*) FROM lessons WHERE status='published'"),'attempts' => DB::value('SELECT COUNT(*) FROM quiz_attempts'),'reviews' => DB::value("SELECT COUNT(*) FROM assignment_submissions WHERE status IN('submitted','resubmitted','under_review')"),'completed' => DB::value('SELECT COUNT(*) FROM enrolments WHERE completed_at IS NOT NULL'),'certificates' => DB::value('SELECT COUNT(*) FROM certificates WHERE revoked_at IS NULL'),'referrals' => DB::value('SELECT COUNT(*) FROM referrals')];
        render('admin-dashboard', ['title' => 'A clearer view of learning','metrics' => $metrics,'activity' => DB::all('SELECT DATE(created_at) AS day,COUNT(*) AS count FROM activity_events WHERE created_at>=DATE_SUB(UTC_DATE(),INTERVAL 6 DAY) GROUP BY DATE(created_at)'),'recent' => DB::all('SELECT a.*,u.full_name FROM audit_logs a LEFT JOIN users u ON u.id=a.actor_id ORDER BY a.id DESC LIMIT 6'),'paths' => DB::all('SELECT p.*,c.name AS category,(SELECT COUNT(*) FROM enrolments e WHERE e.path_id=p.id) AS enrolled FROM learning_paths p JOIN categories c ON c.id=p.category_id ORDER BY p.updated_at DESC LIMIT 5')], 'admin');
    }
    public function content(string $resource): void
    {
        Auth::permission('content.manage');
        $c = Content::config($resource);
        $where = ' WHERE 1=1';
        $params = [];
        $q = mb_substr((string)($_GET['q'] ?? ''), 0, 150);
        $search = isset($c['fields']['title']) ? 'title' : (isset($c['fields']['name']) ? 'name' : (isset($c['fields']['label']) ? 'label' : 'level'));
        if ($q !== '') {
            $where .= ' AND `' . $search . '` LIKE ?';
            $params[] = '%' . $q . '%';
        }if (isset($c['fields']['status']) && in_array($_GET['status'] ?? '', ['draft','published','archived'], true)) {
            $where .= ' AND status=?';
            $params[] = $_GET['status'];
        }
        $pk = $c['pk'] ?? 'id';
        $rows = DB::all('SELECT * FROM ' . $c['table'] . $where . ' ORDER BY ' . $pk . ' DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20), $params);
        $total = (int)DB::value('SELECT COUNT(*) FROM ' . $c['table'] . $where, $params);
        render('admin-content', ['title' => $c['label'],'resource' => $resource,'config' => $c,'rows' => $rows,'total' => $total], 'admin');
    }
    public function editor(string $resource, string $id = 'new'): void
    {
        Auth::permission('content.manage');
        $c = Content::config($resource);
        $pk = $c['pk'] ?? 'id';
        $record = $id === 'new' ? null : DB::one('SELECT * FROM ' . $c['table'] . ' WHERE ' . $pk . '=?', [(int)$id]);
        if ($id !== 'new' && !$record) {
            abort(404, 'Record not found.');
        }$relations = [];
        foreach ($c['fields'] as $key => $f) {
            if ($f[1] === 'relation') {
                $relations[$key] = Content::options($f[3]);
            }
        }$extras = [];
        if ($resource === 'stages') {
            $extras['options'] = Content::options('stages');
            $extras['prerequisites'] = $record ? array_column(DB::all('SELECT required_stage_id FROM stage_prerequisites WHERE stage_id=?', [$id]), 'required_stage_id') : [];
        }
        if ($resource === 'lessons') {
            $extras['options'] = Content::options('lessons');
            $extras['prerequisites'] = $record ? array_column(DB::all('SELECT required_lesson_id FROM lesson_prerequisites WHERE lesson_id=?', [$id]), 'required_lesson_id') : [];
            $extras['checklist'] = $record ? implode("\n", array_column(DB::all('SELECT label FROM lesson_checklists WHERE lesson_id=? ORDER BY position,id', [$id]), 'label')) : '';
            $extras['resources'] = $record ? implode("\n", array_map(fn($r)=>$r['title'] . ' | ' . $r['url'], DB::all('SELECT * FROM lesson_resources WHERE lesson_id=?', [$id]))) : '';
        }
        if ($resource === 'assignments') {
            $extras['rubrics'] = $record ? implode("\n", array_map(fn($r)=>$r['criterion'] . ' | ' . $r['max_points'], DB::all('SELECT * FROM grading_rubrics WHERE assignment_id=?', [$id]))) : '';
        }
        if ($resource === 'quizzes' && $record) {
            $extras['questions'] = DB::all('SELECT * FROM quiz_questions WHERE quiz_id=? ORDER BY position,id', [$id]);
            foreach ($extras['questions'] as &$question) {
                $question['options'] = DB::all('SELECT label,is_correct AS correct FROM answer_options WHERE question_id=? ORDER BY position,id', [$question['id']]);
            }$extras['locked'] = (bool)DB::value('SELECT 1 FROM quiz_attempts WHERE quiz_id=? LIMIT 1', [$id]);
        }
        if ($resource === 'skills') {
            $extras['options'] = DB::all('SELECT id,label FROM skill_nodes ORDER BY id LIMIT 500');
            $extras['prerequisites'] = $record ? array_column(DB::all('SELECT prerequisite_node_id FROM skill_connections WHERE node_id=?', [$id]), 'prerequisite_node_id') : [];
        }
        if ($resource === 'paths' && $record) {
            $extras['stages'] = DB::all('SELECT * FROM stages WHERE path_id=? ORDER BY position,id', [$id]);
            foreach ($extras['stages'] as &$s) {
                $s['modules'] = DB::all('SELECT * FROM modules WHERE stage_id=? ORDER BY position,id', [$s['id']]);
                foreach ($s['modules'] as &$m) {
                    $m['lessons'] = DB::all('SELECT id,title,status FROM lessons WHERE module_id=? ORDER BY position,id', [$m['id']]);
                }
            }
        }
        render('admin-editor', ['title' => ($record ? 'Edit ' : 'Create ') . strtolower($c['singular']),'resource' => $resource,'config' => $c,'record' => $record,'relations' => $relations,'extras' => $extras], 'admin');
    }
    public function users(): void
    {
        Auth::permission('users.manage');
        $where = ' WHERE 1=1';
        $params = [];
        $q = mb_substr((string)($_GET['q'] ?? ''), 0, 150);
        if ($q !== '') {
            $where .= ' AND (u.full_name LIKE ? OR u.email LIKE ?)';
            $params = ['%' . $q . '%','%' . $q . '%'];
        }if (in_array($_GET['status'] ?? '', ['active','suspended'], true)) {
            $where .= ' AND u.status=?';
            $params[] = $_GET['status'];
        }
        render('admin-users', ['title' => 'People behind the progress','users' => DB::all('SELECT u.id,u.full_name,u.email,u.status,u.email_verified_at,u.created_at,r.name AS role FROM users u JOIN roles r ON r.id=u.role_id' . $where . ' ORDER BY u.id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20), $params),'total' => (int)DB::value('SELECT COUNT(*) FROM users u' . $where, $params)], 'admin');
    }
    public function userDetail(string $id): void
    {
        Auth::permission('users.manage');
        $u = DB::one('SELECT u.id,u.full_name,u.email,u.status,u.role_id,u.timezone,u.created_at,u.email_verified_at,r.name AS role FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=?', [$id]);
        if (!$u) {
            abort(404, 'Learner not found.');
        }render('admin-user', ['title' => $u['full_name'],'learner' => $u,'roles' => DB::all('SELECT * FROM roles ORDER BY id'),'enrolments' => DB::all('SELECT p.title,e.* FROM enrolments e JOIN learning_paths p ON p.id=e.path_id WHERE e.user_id=?', [$id]),'activity' => DB::all('SELECT * FROM activity_events WHERE user_id=? ORDER BY id DESC LIMIT 15', [$id]),'stages' => Content::options('stages'),'quizzes' => DB::all('SELECT a.*,q.title FROM quiz_attempts a JOIN quizzes q ON q.id=a.quiz_id WHERE a.user_id=? ORDER BY a.id DESC LIMIT 15', [$id]),'submissions' => DB::all('SELECT s.*,a.title FROM assignment_submissions s JOIN assignments a ON a.id=s.assignment_id WHERE s.user_id=? ORDER BY s.id DESC LIMIT 15', [$id]),'certificates' => DB::all('SELECT identifier,path_title,issued_at,revoked_at FROM certificates WHERE user_id=?', [$id])], 'admin');
    }
    public function reviews(): void
    {
        $u = Auth::permission('review.manage');
        $where = $u['role'] === 'reviewer' ? ' AND s.reviewer_id=' . (int)$u['id'] : '';
        $qwhere = $u['role'] === 'reviewer' ? ' AND a.assigned_reviewer_id=' . (int)$u['id'] : '';
        render('admin-reviews', ['title' => 'Help the next breakthrough happen','submissions' => DB::all("SELECT s.*,a.title,u.full_name FROM assignment_submissions s JOIN assignments a ON a.id=s.assignment_id JOIN users u ON u.id=s.user_id WHERE s.status<>'draft' $where ORDER BY FIELD(s.status,'submitted','resubmitted','under_review','revision_requested','graded','accepted'),s.id DESC LIMIT 20 OFFSET " . ((pageNumber() - 1) * 20)),'total' => (int)DB::value("SELECT COUNT(*) FROM assignment_submissions s WHERE s.status<>'draft' $where"),'quizzes' => DB::all("SELECT a.*,q.title,u.full_name FROM quiz_attempts a JOIN quizzes q ON q.id=a.quiz_id JOIN users u ON u.id=a.user_id WHERE a.status='pending_review' $qwhere ORDER BY a.id LIMIT 30")], 'admin');
    }
    public function review(string $id): void
    {
        $u = Auth::permission('review.manage');
        $s = DB::one('SELECT s.*,a.title,a.instructions,a.max_score,a.passing_score,u.full_name,u.email FROM assignment_submissions s JOIN assignments a ON a.id=s.assignment_id JOIN users u ON u.id=s.user_id WHERE s.id=?', [$id]);
        if (!$s || ($u['role'] === 'reviewer' && $s['reviewer_id'] !== $u['id'])) {
            abort(404, 'Submission not found.');
        }render('admin-review', ['title' => 'A thoughtful review makes a difference','submission' => $s,'rubrics' => DB::all('SELECT * FROM grading_rubrics WHERE assignment_id=?', [$s['assignment_id']]),'feedback' => DB::all('SELECT f.*,u.full_name FROM assignment_feedback f JOIN users u ON u.id=f.author_id WHERE submission_id=? ORDER BY f.id DESC', [$id]),'history' => DB::all('SELECT * FROM submission_history WHERE submission_id=? ORDER BY id DESC', [$id]),'reviewers' => DB::all("SELECT u.id,u.full_name FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name IN('administrator','reviewer') AND u.status='active'")], 'admin');
    }
    public function quizReview(string $id): void
    {
        $u = Auth::permission('review.manage');
        $a = DB::one('SELECT a.*,q.title,u.full_name FROM quiz_attempts a JOIN quizzes q ON q.id=a.quiz_id JOIN users u ON u.id=a.user_id WHERE a.id=?', [$id]);
        if (!$a || ($u['role'] === 'reviewer' && $a['assigned_reviewer_id'] !== $u['id'])) {
            abort(404, 'Attempt not found.');
        }render('admin-quiz-review', ['title' => 'Review written answers','attempt' => $a,'responses' => DB::all('SELECT r.*,q.prompt,q.type,q.points FROM quiz_responses r JOIN quiz_questions q ON q.id=r.question_id WHERE r.attempt_id=? ORDER BY q.position,q.id', [$id]),'reviewers' => DB::all("SELECT u.id,u.full_name FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name IN('administrator','reviewer') AND u.status='active'")], 'admin');
    }
    public function rewards(): void
    {
        Auth::permission('settings.manage');
        render('admin-rewards', ['title' => 'Make progress feel rewarding','rules' => DB::all('SELECT * FROM reward_rules'),'levels' => DB::all('SELECT * FROM level_definitions ORDER BY level'),'achievements' => DB::all('SELECT * FROM achievements ORDER BY id')], 'admin');
    }
    public function settings(): void
    {
        Auth::permission('settings.manage');
        render('admin-settings', ['title' => 'A well-run learning space','settings' => DB::all('SELECT * FROM system_settings ORDER BY setting_key'),'mailCounts' => DB::all('SELECT status,COUNT(*) AS total FROM mail_outbox GROUP BY status')], 'admin');
    }
    public function referrals(): void
    {
        Auth::permission('settings.manage');
        render('admin-referrals', ['title' => 'Learning is better when it’s shared','campaign' => DB::one('SELECT * FROM referral_campaigns ORDER BY id DESC LIMIT 1'),'referrals' => DB::all('SELECT r.*,u.full_name AS referrer,v.full_name AS referred,rr.amount,rr.reward_type FROM referrals r JOIN users u ON u.id=r.referrer_id JOIN users v ON v.id=r.referred_id LEFT JOIN referral_rewards rr ON rr.referral_id=r.id ORDER BY r.id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20)),'total' => (int)DB::value('SELECT COUNT(*) FROM referrals')], 'admin');
    }
    public function certificates(): void
    {
        Auth::permission('certificates.manage');
        render('admin-certificates', ['title' => 'Recognise genuine progress','certificates' => DB::all('SELECT * FROM certificates ORDER BY id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20)),'total' => (int)DB::value('SELECT COUNT(*) FROM certificates')], 'admin');
    }
    public function community(): void
    {
        Auth::permission('community.manage');
        render('admin-community', ['title' => 'Keep this a good place to grow','reports' => DB::all('SELECT r.*,u.full_name AS reporter,v.full_name AS reported FROM community_reports r JOIN users u ON u.id=r.reporter_id JOIN users v ON v.id=r.reported_user_id ORDER BY r.status,r.id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20)),'total' => (int)DB::value('SELECT COUNT(*) FROM community_reports'),'reviews' => DB::all("SELECT r.id,r.status,r.snapshot_title,u.full_name FROM peer_review_assignments r JOIN users u ON u.id=r.reviewer_id WHERE r.status IN('submitted','hidden') ORDER BY r.id DESC LIMIT 20")], 'admin');
    }
    public function audit(): void
    {
        Auth::permission('reports.view');
        $q = mb_substr((string)($_GET['q'] ?? ''), 0, 100);
        $where = $q ? ' WHERE a.action LIKE ?' : '';
        $params = $q ? ['%' . $q . '%'] : [];
        render('admin-audit', ['title' => 'A record you can rely on','logs' => DB::all('SELECT a.*,u.full_name FROM audit_logs a LEFT JOIN users u ON u.id=a.actor_id' . $where . ' ORDER BY a.id DESC LIMIT 30 OFFSET ' . ((pageNumber() - 1) * 30), $params),'total' => (int)DB::value('SELECT COUNT(*) FROM audit_logs a' . $where, $params)], 'admin');
    }
    public function reports(): void
    {
        Auth::permission('reports.view');
        $period = in_array((int)($_GET['period'] ?? 30), [7,30,90], true) ? (int)($_GET['period'] ?? 30) : 30;
        $rows = DB::all("SELECT p.id,p.title,p.status,(SELECT COUNT(*) FROM enrolments e WHERE e.path_id=p.id) AS enrolled,(SELECT COUNT(*) FROM enrolments e WHERE e.path_id=p.id AND e.completed_at IS NOT NULL) AS completed,(SELECT COUNT(*) FROM lesson_progress lp JOIN lessons l ON l.id=lp.lesson_id JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE s.path_id=p.id AND lp.completed_at>=DATE_SUB(UTC_TIMESTAMP(),INTERVAL $period DAY)) AS lessons,(SELECT AVG(a.score) FROM quiz_attempts a JOIN quizzes q ON q.id=a.quiz_id JOIN stages s ON s.id=q.stage_id WHERE s.path_id=p.id AND a.status IN('passed','failed') AND a.submitted_at>=DATE_SUB(UTC_TIMESTAMP(),INTERVAL $period DAY)) AS score FROM learning_paths p ORDER BY p.id DESC LIMIT 20 OFFSET " . ((pageNumber() - 1) * 20));
        render('admin-reports', ['title' => 'Understand what moves learning forward','rows' => $rows,'period' => $period,'total' => (int)DB::value('SELECT COUNT(*) FROM learning_paths')], 'admin');
    }
}
