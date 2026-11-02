<?php

namespace Learnow\Controllers;

use Learnow\Middleware\Auth;
use Learnow\Services\TrackService;

final class SkillController
{
    public function index(): void
    {
        render('skills', ['title' => 'Choose a skill to master','areas' => TrackService::areas()], user() ? 'app' : 'public');
    }
    public function area(string $slug): void
    {
        $area = TrackService::area($slug);
        if (!$area) {
            abort(404, 'This skill area could not be found.');
        }
        $uid = user()['id'] ?? null;
        render('skill', ['title' => $area['name'],'area' => $area,'tracks' => $area['availability'] === 'available' ? TrackService::tracks((int)$area['id'], $uid ? (int)$uid : null) : []], $uid ? 'app' : 'public');
    }
    public function track(string $slug): void
    {
        $uid = user()['id'] ?? null;
        $track = TrackService::track($slug, $uid ? (int)$uid : null);
        if (!$track) {
            abort(404, 'This track could not be found.');
        }
        render('track', ['title' => $track['title'],'track' => $track], $uid ? 'app' : 'public');
    }
    public function choose(string $id): void
    {
        $u = Auth::requireUser();
        $t = TrackService::choose((int)$u['id'], (int)$id);
        success('Track selected. Your roadmap is ready.', ['redirect' => '/tracks/' . $t['slug']]);
    }
}
