<?php

namespace Learnow\Controllers;

use Learnow\Services\{LearningService,TrackService};
use Learnow\Repositories\DB;

final class PublicController
{
    public function home(): void
    {
        render('landing', ['title' => 'Learn today. Build tomorrow.','paths' => array_slice(LearningService::catalogue(), 0, 3),'areas' => TrackService::areas(),'categories' => DB::all('SELECT * FROM categories WHERE active=1 ORDER BY id')], 'public');
    }
    public function catalogue(): void
    {
        render('catalogue', ['title' => 'Find your next skill','paths' => LearningService::catalogue(user()['id'] ?? null, mb_substr((string)($_GET['q'] ?? ''), 0, 150), (string)($_GET['category'] ?? '')),'categories' => DB::all('SELECT * FROM categories WHERE active=1 ORDER BY id')], user() ? 'app' : 'public');
    }
    public function info(string $slug): void
    {
        $pages = require ROOT . '/config/pages.php';
        if (!isset($pages[$slug])) {
            abort(404, 'This page could not be found.');
        }render('info', ['title' => $pages[$slug]['title'],'page' => $pages[$slug]], 'public');
    }
    public function certificate(string $identifier): void
    {
        $c = DB::one('SELECT * FROM certificates WHERE identifier=?', [$identifier]);
        if (!$c) {
            abort(404, 'No certificate matches this identifier.');
        }\Learnow\Middleware\Security::throttle('cert-check:' . \Learnow\Middleware\Security::ip(), 120, 3600);
        DB::run('INSERT INTO certificate_verifications(certificate_id) VALUES(?)', [$c['id']]);
        render('certificate', ['title' => 'Certificate verification','certificate' => $c], 'public');
    }
    public function project(string $slug): void
    {
        $p = DB::one("SELECT p.*,u.full_name FROM portfolio_projects p JOIN users u ON u.id=p.user_id WHERE p.slug=? AND p.visibility='public' AND u.status='active'", [$slug]);
        if (!$p) {
            abort(404, 'This project is private or no longer published.');
        } render('project', ['title' => $p['title'],'project' => $p,'skills' => DB::all('SELECT skill FROM project_skills WHERE project_id=?', [$p['id']]),'images' => DB::all('SELECT id FROM project_images WHERE project_id=?', [$p['id']])], 'public');
    }
}
