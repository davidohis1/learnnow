<?php

namespace Learnow\Controllers;

use Learnow\Repositories\DB;
use Learnow\Middleware\{Auth,Security};
use Learnow\Validators\Validate as V;
use Learnow\Services\{UploadService,NotificationService,LearningService};

final class CommunityController
{
    public function portfolio(): void
    {
        $u = Auth::requireUser();
        render('portfolio', ['title' => 'Proof of what you can do','projects' => DB::all('SELECT p.*,(SELECT COUNT(*) FROM peer_review_assignments r WHERE r.project_id=p.id AND r.status=\'submitted\') AS review_count FROM portfolio_projects p WHERE p.user_id=? ORDER BY p.id DESC LIMIT 20 OFFSET ' . ((pageNumber() - 1) * 20), [$u['id']]),'total' => (int)DB::value('SELECT COUNT(*) FROM portfolio_projects WHERE user_id=?', [$u['id']])]);
    }
    public function editor(string $id = 'new'): void
    {
        $u = Auth::requireUser();
        $p = $id === 'new' ? null : DB::one('SELECT * FROM portfolio_projects WHERE id=? AND user_id=?', [(int)$id,$u['id']]);
        if ($id !== 'new' && !$p) {
            abort(404, 'Project not found.');
        }render('project-editor', ['title' => $p ? 'Keep building your story' : 'Add something you built','project' => $p,'paths' => array_values(array_filter(LearningService::catalogue((int)$u['id']), fn($p)=>$p['enrolled'])),'skills' => $p ? implode(', ', array_column(DB::all('SELECT skill FROM project_skills WHERE project_id=?', [$p['id']]), 'skill')) : '','images' => $p ? DB::all('SELECT id,file_name FROM project_images WHERE project_id=?', [$p['id']]) : [],'reviews' => $p ? DB::all("SELECT r.*,u.full_name FROM peer_review_assignments r JOIN users u ON u.id=r.reviewer_id WHERE r.project_id=? AND r.status='submitted'", [$p['id']]) : []]);
    }
    public function saveProject(string $id): void
    {
        $u = Auth::requireUser();
        $d = input();
        $p = $id === 'new' ? null : DB::one('SELECT * FROM portfolio_projects WHERE id=? AND user_id=?', [(int)$id,$u['id']]);
        if ($id !== 'new' && !$p) {
            abort(404, 'Project not found.');
        }
        $title = V::text($d['title'] ?? '', 'Project title', 3, 160);
        $description = V::text($d['description'] ?? '', 'Description', 10, 12000);
        $url = V::url($d['project_url'] ?? '');
        $repo = V::url($d['repository_url'] ?? '', 'repository URL');
        $visibility = V::choice($d['visibility'] ?? 'private', ['private','public'], 'visibility');
        $path = empty($d['path_id']) ? null : (int)$d['path_id'];
        if ($path && !DB::value('SELECT 1 FROM enrolments WHERE user_id=? AND path_id=?', [$u['id'],$path])) {
            abort(422, 'Choose one of your enrolled learning paths.');
        }
        $date = $d['completed_on'] ?? '';
        if ($date && (!preg_match('/^\d{4}-\d{2}-\d{2}$/D', $date) || !checkdate((int)substr($date, 5, 2), (int)substr($date, 8, 2), (int)substr($date, 0, 4)))) {
            abort(422, 'Choose a valid completion date.');
        }
        $skills = array_slice(array_values(array_unique(array_filter(array_map('trim', explode(',', V::text($d['skills'] ?? '', 'Skills', 0, 700)))))), 0, 10);
        foreach ($skills as $s) {
            V::text($s, 'Skill', 1, 80);
        }
        if ($p && (int)DB::value('SELECT COUNT(*) FROM project_images WHERE project_id=?', [$p['id']]) >= 5 && !empty($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
            abort(422, 'A project can hold up to five images.');
        }
        $image = isset($_FILES['image']) ? UploadService::receive($_FILES['image'], true) : null;
        try {
            $pid = DB::transaction(function () use ($u, $p, $title, $description, $url, $repo, $visibility, $path, $date, $skills, $image) {
                if ($p) {
                    $pid = (int)$p['id'];
                    DB::run('UPDATE portfolio_projects SET title=?,description=?,project_url=?,repository_url=?,visibility=?,path_id=?,completed_on=? WHERE id=? AND user_id=?', [$title,$description,$url,$repo,$visibility,$path,$date ?: null,$pid,$u['id']]);
                } else {
                    $slug = trim(strtolower(preg_replace('/[^a-zA-Z0-9]+/', '-', $title)), '-') . '-' . bin2hex(random_bytes(5));
                    $pid = DB::insert('INSERT INTO portfolio_projects(user_id,title,slug,description,project_url,repository_url,visibility,path_id,completed_on) VALUES(?,?,?,?,?,?,?,?,?)', [$u['id'],$title,$slug,$description,$url,$repo,$visibility,$path,$date ?: null]);
                }
                DB::run('DELETE FROM project_skills WHERE project_id=?', [$pid]);
                foreach ($skills as $skill) {
                    DB::run('INSERT INTO project_skills(project_id,skill) VALUES(?,?)', [$pid,$skill]);
                }if ($image) {
                    DB::run('INSERT INTO project_images(project_id,file_key,file_name,file_mime) VALUES(?,?,?,?)', [$pid,$image['key'],$image['name'],$image['mime']]);
                }return $pid;
            });
        } catch (\Throwable $e) {
            if ($image) {
                @unlink(ROOT . '/storage/uploads/' . $image['key']);
            }throw $e;
        }
        success('Your project is saved.', ['redirect' => '/portfolio/' . $pid . '/edit']);
    }
    public function deleteProject(string $id): void
    {
        $u = Auth::requireUser();
        $images = DB::all('SELECT i.file_key FROM project_images i JOIN portfolio_projects p ON p.id=i.project_id WHERE p.id=? AND p.user_id=?', [$id,$u['id']]);
        DB::run('DELETE FROM portfolio_projects WHERE id=? AND user_id=?', [$id,$u['id']]);
        foreach ($images as $image) {
            @unlink(ROOT . '/storage/uploads/' . $image['file_key']);
        }success('Project removed.', ['redirect' => '/portfolio']);
    }
    public function image(string $id): void
    {
        $u = user();
        $image = DB::one('SELECT i.*,p.user_id,p.visibility,u.status AS owner_status FROM project_images i JOIN portfolio_projects p ON p.id=i.project_id JOIN users u ON u.id=p.user_id WHERE i.id=?', [$id]);
        if (!$image || $image['owner_status'] !== 'active' || ($image['visibility'] !== 'public' && (!$u || $u['id'] !== $image['user_id']))) {
            abort(404, 'Image not found.');
        }UploadService::download($image, true);
    }
    private function blocked(int $a, int $b): bool
    {
        return (bool)DB::value("SELECT 1 FROM buddy_relationships WHERE ((requester_id=? AND recipient_id=?) OR (requester_id=? AND recipient_id=?)) AND status='blocked'", [$a,$b,$b,$a]);
    }
    private function friends(int $a, int $b): bool
    {
        return !$this->blocked($a, $b) && (bool)DB::value("SELECT 1 FROM buddy_relationships WHERE ((requester_id=? AND recipient_id=?) OR (requester_id=? AND recipient_id=?)) AND status='accepted'", [$a,$b,$b,$a]);
    }
    public function community(): void
    {
        $u = Auth::requireUser();
        $uid = (int)$u['id'];
        $buddies = DB::all("SELECT b.*,u.full_name,u.id AS other_id FROM buddy_relationships b JOIN users u ON u.id=IF(b.requester_id=?,b.recipient_id,b.requester_id) WHERE (b.requester_id=? OR b.recipient_id=?) AND u.status='active' ORDER BY b.created_at DESC LIMIT 50", [$uid,$uid,$uid]);
        $challenges = DB::all('SELECT c.*,u.full_name AS friend_name FROM friend_challenges c JOIN users u ON u.id=IF(c.creator_id=?,c.friend_id,c.creator_id) WHERE c.creator_id=? OR c.friend_id=? ORDER BY c.id DESC LIMIT 30', [$uid,$uid,$uid]);
        foreach ($challenges as &$c) {
            $c['mine'] = (int)DB::value("SELECT COUNT(*) FROM activity_events WHERE user_id=? AND kind='lesson' AND created_at>=? AND local_date<=?", [$uid,$c['created_at'],$c['deadline']]);
            $other = $c['creator_id'] === $uid ? $c['friend_id'] : $c['creator_id'];
            $c['theirs'] = $this->friends($uid, (int)$other) ? (int)DB::value("SELECT COUNT(*) FROM activity_events WHERE user_id=? AND kind='lesson' AND created_at>=? AND local_date<=?", [$other,$c['created_at'],$c['deadline']]) : null;
        }
        render('community', ['title' => 'Better, together','buddies' => $buddies,'challenges' => $challenges,'reviews' => DB::all("SELECT r.*,p.slug FROM peer_review_assignments r JOIN portfolio_projects p ON p.id=r.project_id WHERE r.reviewer_id=? AND r.status<>'hidden' ORDER BY r.id DESC LIMIT 30", [$uid]),'publicProjects' => DB::all("SELECT p.*,u.full_name FROM portfolio_projects p JOIN users u ON u.id=p.user_id WHERE p.visibility='public' AND u.status='active' ORDER BY p.id DESC LIMIT 6")]);
    }
    public function requestBuddy(): void
    {
        $u = Auth::requireUser();
        Security::throttle('buddy:' . $u['id'], 15, 3600);
        $email = V::email(input()['email'] ?? '');
        $other = DB::one("SELECT id FROM users WHERE email=? AND status='active'", [$email]);
        if ($other && $other['id'] !== $u['id'] && !$this->blocked((int)$u['id'], (int)$other['id'])) {
            DB::transaction(function () use ($u, $other) {
                        DB::all('SELECT id FROM users WHERE id IN(?,?) ORDER BY id FOR UPDATE', [$u['id'],$other['id']]);
                        $exists = DB::one('SELECT id FROM buddy_relationships WHERE (requester_id=? AND recipient_id=?) OR (requester_id=? AND recipient_id=?)', [$u['id'],$other['id'],$other['id'],$u['id']]);
                if (!$exists) {
                    DB::run('INSERT INTO buddy_relationships(requester_id,recipient_id) VALUES(?,?)', [$u['id'],$other['id']]);
                    NotificationService::notify((int)$other['id'], 'community', 'A new study buddy request', $u['full_name'] . ' would like to learn alongside you.', '/community', 'buddy:' . $u['id'] . ':' . $other['id']);
                }
            });
        }
        success('If that learner is eligible, your request is on its way.', ['reload' => true]);
    }
    public function buddyAction(string $id): void
    {
        $u = Auth::requireUser();
        $b = DB::one('SELECT * FROM buddy_relationships WHERE id=? AND (requester_id=? OR recipient_id=?)', [$id,$u['id'],$u['id']]);
        if (!$b) {
            abort(404, 'Request not found.');
        }$action = V::choice(input()['action'] ?? '', ['accepted','declined','blocked'], 'action');
        if ($action !== 'blocked' && ($b['recipient_id'] !== $u['id'] || $b['status'] !== 'pending')) {
            abort(403, 'Only the invited learner can respond to a pending request.');
        }DB::run('UPDATE buddy_relationships SET status=? WHERE id=?', [$action,$id]);
        success($action === 'blocked' ? 'This learner has been blocked.' : 'Your study buddy request is updated.', ['reload' => true]);
    }
    public function challenge(): void
    {
        $u = Auth::requireUser();
        $d = input();
        $friend = V::int($d['friend_id'] ?? 0, 'Study buddy', 1, 2147483647);
        if (!$this->friends((int)$u['id'], $friend)) {
            abort(422, 'Choose an accepted study buddy.');
        }$title = V::text($d['title'] ?? '', 'Challenge title', 3, 160);
        $target = V::int($d['target'] ?? 5, 'Lesson target', 1, 100);
        $deadline = V::text($d['deadline'] ?? '', 'Deadline', 10, 10);
        $date = \DateTimeImmutable::createFromFormat('!Y-m-d', $deadline, new \DateTimeZone($u['timezone']));
        if (!$date || $date->format('Y-m-d') !== $deadline || $deadline < \Learnow\Services\RewardService::today($u) || $date > new \DateTimeImmutable('+90 days')) {
            abort(422, 'Choose a deadline in the next 90 days.');
        }Security::throttle('challenge:' . $u['id'], 10, 3600);
        $id = DB::insert('INSERT INTO friend_challenges(creator_id,friend_id,title,target,deadline) VALUES(?,?,?,?,?)', [$u['id'],$friend,$title,$target,$deadline]);
        NotificationService::notify($friend, 'community', 'A friendly challenge', $u['full_name'] . ' invited you to ' . $title . '.', '/community', 'challenge:' . $id);
        success('Challenge invitation sent.', ['reload' => true]);
    }
    public function respondChallenge(string $id): void
    {
        $u = Auth::requireUser();
        $c = DB::one("SELECT * FROM friend_challenges WHERE id=? AND friend_id=? AND status='pending'", [$id,$u['id']]);
        if (!$c || !$this->friends((int)$u['id'], (int)$c['creator_id']) || $c['deadline'] < \Learnow\Services\RewardService::today($u)) {
            abort(422, 'This challenge is no longer available.');
        }$status = V::choice(input()['status'] ?? '', ['accepted','declined'], 'response');
        DB::run('UPDATE friend_challenges SET status=? WHERE id=?', [$status,$id]);
        success('Challenge updated.', ['reload' => true]);
    }
    public function reportUser(): void
    {
        $u = Auth::requireUser();
        Security::throttle('report:' . $u['id'], 5, 3600);
        $id = V::int(input()['user_id'] ?? 0, 'Learner', 1, 2147483647);
        if ($id === $u['id'] || !DB::value('SELECT 1 FROM users WHERE id=?', [$id])) {
            abort(422, 'Choose a valid learner.');
        }$reason = V::text(input()['reason'] ?? '', 'Reason', 10, 3000);
        DB::run('INSERT INTO community_reports(reporter_id,reported_user_id,reason) VALUES(?,?,?)', [$u['id'],$id,$reason]);
        success('Your report has been sent to the moderation team.');
    }
    public function requestReviews(string $id): void
    {
        $u = Auth::requireUser();
        Security::throttle('request-reviews:' . $u['id'], 10, 3600);
        $added = DB::transaction(function () use ($u, $id) {
            $p = DB::one('SELECT * FROM portfolio_projects WHERE id=? AND user_id=? FOR UPDATE', [$id,$u['id']]);
            if (!$p) {
                abort(404, 'Project not found.');
            }$desired = max(1, min(5, (int)setting('peer_review_count', 2)));
            $existing = (int)DB::value('SELECT COUNT(*) FROM peer_review_assignments WHERE project_id=?', [$id]);
            if ($existing >= $desired) {
                return 0;
            }
            $candidates = DB::all("SELECT u.id FROM users u JOIN roles r ON r.id=u.role_id WHERE u.status='active' AND u.id<>? AND r.name='learner' AND (SELECT COUNT(*) FROM lesson_progress lp WHERE lp.user_id=u.id)>=? AND NOT EXISTS(SELECT 1 FROM peer_review_assignments p WHERE p.project_id=? AND p.reviewer_id=u.id) AND (SELECT COUNT(*) FROM peer_review_assignments p WHERE p.reviewer_id=u.id AND p.status='assigned')<3 ORDER BY u.id LIMIT 40", [$u['id'],(int)setting('peer_review_min_lessons', 3),$id]);
            $count = 0;
            foreach ($candidates as $candidate) {
                if ($this->blocked((int)$u['id'], (int)$candidate['id'])) {
                    continue;
                }if ($existing + $count >= $desired) {
                    break;
                }$rid = DB::insert('INSERT IGNORE INTO peer_review_assignments(project_id,reviewer_id,due_at,snapshot_title,snapshot_description,snapshot_url,snapshot_repository) VALUES(?,?,DATE_ADD(UTC_TIMESTAMP(),INTERVAL 7 DAY),?,?,?,?)', [$id,$candidate['id'],$p['title'],$p['description'],$p['project_url'],$p['repository_url']]);
                if ($rid) {
                    $count++;
                    NotificationService::notify((int)$candidate['id'], 'community', 'A fresh perspective is needed', 'A learner has shared a project with you for constructive feedback.', '/community/reviews/' . $rid, 'peer-review:' . $rid);
                }
            }return $count;
        });
        success($added ? 'Your project has been shared with ' . $added . ' eligible reviewer' . ($added > 1 ? 's.' : '.') : 'No additional eligible reviewers are available yet. Your project remains saved.', ['reload' => true]);
    }
    public function reviewPage(string $id): void
    {
        $u = Auth::requireUser();
        $r = DB::one("SELECT r.*,p.user_id FROM peer_review_assignments r JOIN portfolio_projects p ON p.id=r.project_id WHERE r.id=? AND r.reviewer_id=? AND r.status<>'hidden'", [$id,$u['id']]);
        if (!$r || $this->blocked((int)$u['id'], (int)$r['user_id'])) {
            abort(404, 'Review not found.');
        }render('peer-review', ['title' => 'A fresh perspective','review' => $r,'questions' => DB::all('SELECT * FROM peer_review_questions WHERE active=1'),'responses' => DB::all('SELECT r.*,q.prompt,q.max_score FROM peer_review_responses r JOIN peer_review_questions q ON q.id=r.question_id WHERE r.review_id=?', [$id])]);
    }
    public function submitReview(string $id): void
    {
        $u = Auth::requireUser();
        $data = input()['responses'] ?? [];
        if (!is_array($data)) {
            abort(422, 'Complete the review rubric.');
        }
        DB::transaction(function () use ($u, $id, $data) {
            $r = DB::one('SELECT r.*,p.user_id FROM peer_review_assignments r JOIN portfolio_projects p ON p.id=r.project_id WHERE r.id=? AND r.reviewer_id=? FOR UPDATE', [$id,$u['id']]);
            if (!$r || $r['user_id'] === $u['id'] || $this->blocked((int)$u['id'], (int)$r['user_id'])) {
                abort(404, 'Review not found.');
            }if ($r['status'] !== 'assigned') {
                abort(422, 'This review is already submitted or unavailable.');
            }if (strtotime($r['due_at']) < time()) {
                abort(422, 'The review deadline has passed.');
            }
            foreach (DB::all('SELECT * FROM peer_review_questions WHERE active=1') as $q) {
                $answer = $data[$q['id']] ?? [];
                $score = V::int($answer['score'] ?? null, 'Rubric score', 1, (int)$q['max_score']);
                $feedback = V::text($answer['feedback'] ?? '', 'Constructive feedback', 10, 3000);
                DB::run('INSERT INTO peer_review_responses(review_id,question_id,score,feedback) VALUES(?,?,?,?)', [$id,$q['id'],$score,$feedback]);
            }
            DB::run("UPDATE peer_review_assignments SET status='submitted' WHERE id=?", [$id]);
            NotificationService::notify((int)$r['user_id'], 'feedback', 'A fresh perspective on your project', 'Your peer feedback is ready. Peer feedback is not an assignment approval.', '/portfolio/' . $r['project_id'] . '/edit', 'peer-feedback:' . $id);
        });
        success('Thank you for helping another learner grow.', ['reload' => true]);
    }
}
