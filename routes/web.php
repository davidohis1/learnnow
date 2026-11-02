<?php

use Learnow\Controllers\{PublicController,AuthController,ProfileController,LearnerController,CommunityController,AdminController,SkillController,ChatController};

$router->add('GET', '/', [PublicController::class,'home']);
$router->add('GET', '/paths', [PublicController::class,'catalogue']);
$router->add('GET', '/skills', [SkillController::class,'index']);
$router->add('GET', '/skills/{slug}', [SkillController::class,'area']);
$router->add('GET', '/tracks/{slug}', [SkillController::class,'track']);
$router->add('GET', '/api/chat/{id}/messages', [ChatController::class,'messages']);
foreach (['about','help','contact','privacy','terms','guidelines'] as $slug) {
    $router->add('GET', '/' . $slug, fn()=>(new PublicController())->info($slug));
}
$router->add('GET', '/verify/{identifier}', [PublicController::class,'certificate']);
$router->add('GET', '/projects/{slug}', [PublicController::class,'project']);
$router->add('GET', '/media/{id}', [CommunityController::class,'image']);
$router->add('GET', '/login', fn()=>(new AuthController())->page('login'));
$router->add('GET', '/register', fn()=>(new AuthController())->page('register'));
$router->add('GET', '/forgot-password', fn()=>(new AuthController())->page('forgot'));
$router->add('GET', '/reset-password', fn()=>(new AuthController())->page('reset'));
$router->add('GET', '/verify-email', [AuthController::class,'verificationPage']);
$router->add('GET', '/onboarding', [ProfileController::class,'onboarding']);
$router->add('GET', '/dashboard', [LearnerController::class,'dashboard']);
$router->add('GET', '/my-learning', [LearnerController::class,'myLearning']);
$router->add('GET', '/paths/{slug}', [LearnerController::class,'path']);
$router->add('GET', '/lessons/{id}', [LearnerController::class,'lesson']);
$router->add('GET', '/quizzes/{id}', [LearnerController::class,'quiz']);
$router->add('GET', '/assignments', [LearnerController::class,'assignments']);
$router->add('GET', '/assignments/{id}', [LearnerController::class,'assignment']);
$router->add('GET', '/achievements', [LearnerController::class,'achievements']);
$router->add('GET', '/certificates', [LearnerController::class,'certificates']);
$router->add('GET', '/referrals', [LearnerController::class,'referrals']);
$router->add('GET', '/notifications', [LearnerController::class,'notifications']);
$router->add('GET', '/reports', [LearnerController::class,'reports']);
$router->add('GET', '/schedule', fn()=>(new ProfileController())->settings('schedule'));
$router->add('GET', '/settings', [ProfileController::class,'settings']);
$router->add('GET', '/downloads/submissions/{id}', [LearnerController::class,'download']);
$router->add('GET', '/portfolio', [CommunityController::class,'portfolio']);
$router->add('GET', '/portfolio/new', [CommunityController::class,'editor']);
$router->add('GET', '/portfolio/{id}/edit', [CommunityController::class,'editor']);
$router->add('GET', '/community', [CommunityController::class,'community']);
$router->add('GET', '/community/reviews/{id}', [CommunityController::class,'reviewPage']);
$router->add('GET', '/admin', [AdminController::class,'dashboard']);
$router->add('GET', '/admin/users', [AdminController::class,'users']);
$router->add('GET', '/admin/users/{id}', [AdminController::class,'userDetail']);
$router->add('GET', '/admin/reviews', [AdminController::class,'reviews']);
$router->add('GET', '/admin/reviews/{id}', [AdminController::class,'review']);
$router->add('GET', '/admin/quiz-reviews/{id}', [AdminController::class,'quizReview']);
foreach (['rewards','settings','referrals','certificates','community','audit','reports'] as $page) {
    $router->add('GET', '/admin/' . $page, [AdminController::class,$page]);
}
$router->add('GET', '/admin/content/{resource}', [AdminController::class,'content']);
$router->add('GET', '/admin/content/{resource}/new', [AdminController::class,'editor']);
$router->add('GET', '/admin/content/{resource}/{id}/edit', [AdminController::class,'editor']);
