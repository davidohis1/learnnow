<?php

use Learnow\Controllers\{AuthController,ProfileController,LearningApiController,CommunityController,AdminApiController,SkillController,ChatController};

foreach (['register','login','logout','forgot','reset','verify','resend'] as $action) {
    $router->add('POST', '/api/auth/' . $action, [AuthController::class,$action]);
}
$router->add('POST', '/api/onboarding', [ProfileController::class,'saveOnboarding']);
$router->add('POST', '/api/settings', [ProfileController::class,'saveSettings']);
$router->add('POST', '/api/settings/password', [ProfileController::class,'password']);
$router->add('POST', '/api/settings/notifications', [ProfileController::class,'notifications']);
$router->add('POST', '/api/paths/{id}/enrol', [LearningApiController::class,'enrol']);
$router->add('POST', '/api/tracks/{id}/choose', [SkillController::class,'choose']);
$router->add('POST', '/api/chat/{id}/messages', [ChatController::class,'send']);
$router->add('POST', '/api/chat/messages/{id}/hide', [ChatController::class,'hide']);
$router->add('POST', '/api/lessons/{id}/notes', [LearningApiController::class,'note']);
$router->add('POST', '/api/checklist/{id}', [LearningApiController::class,'checklist']);
$router->add('POST', '/api/lessons/{id}/complete', [LearningApiController::class,'complete']);
$router->add('POST', '/api/quizzes/{id}/start', [LearningApiController::class,'startQuiz']);
$router->add('POST', '/api/attempts/{id}/submit', [LearningApiController::class,'submitQuiz']);
$router->add('POST', '/api/assignments/{id}', [LearningApiController::class,'assignment']);
$router->add('POST', '/api/certificates/{id}', [LearningApiController::class,'certificate']);
$router->add('POST', '/api/notifications/read', [LearningApiController::class,'notifications']);
$router->add('POST', '/api/protection/buy', [LearningApiController::class,'protection']);
$router->add('POST', '/api/reports/generate', [LearningApiController::class,'report']);
$router->add('POST', '/api/projects/{id}', [CommunityController::class,'saveProject']);
$router->add('POST', '/api/projects/{id}/delete', [CommunityController::class,'deleteProject']);
$router->add('POST', '/api/projects/{id}/reviews', [CommunityController::class,'requestReviews']);
$router->add('POST', '/api/buddies', [CommunityController::class,'requestBuddy']);
$router->add('POST', '/api/buddies/{id}', [CommunityController::class,'buddyAction']);
$router->add('POST', '/api/challenges', [CommunityController::class,'challenge']);
$router->add('POST', '/api/challenges/{id}', [CommunityController::class,'respondChallenge']);
$router->add('POST', '/api/community/report', [CommunityController::class,'reportUser']);
$router->add('POST', '/api/reviews/{id}', [CommunityController::class,'submitReview']);
$router->add('POST', '/api/admin/content/{resource}/{id}', [AdminApiController::class,'saveContent']);
$router->add('POST', '/api/admin/content/{resource}/{id}/archive', [AdminApiController::class,'archive']);
$router->add('POST', '/api/admin/paths/{id}/duplicate', [AdminApiController::class,'duplicate']);
$router->add('POST', '/api/admin/quizzes/{id}/questions', [AdminApiController::class,'questions']);
$router->add('POST', '/api/admin/users/{id}', [AdminApiController::class,'userUpdate']);
$router->add('POST', '/api/admin/users/{id}/override', [AdminApiController::class,'override']);
$router->add('POST', '/api/admin/reviews/{id}', [AdminApiController::class,'review']);
$router->add('POST', '/api/admin/quiz-reviews/{id}', [AdminApiController::class,'grade']);
$router->add('POST', '/api/admin/assign-reviewer/{kind}/{id}', [AdminApiController::class,'assignReviewer']);
$router->add('POST', '/api/admin/rewards', [AdminApiController::class,'rewardRules']);
$router->add('POST', '/api/admin/settings', [AdminApiController::class,'settings']);
$router->add('POST', '/api/admin/campaign', [AdminApiController::class,'campaign']);
$router->add('POST', '/api/admin/referrals/{id}', [AdminApiController::class,'resolveReferral']);
$router->add('POST', '/api/admin/certificates/{id}/revoke', [AdminApiController::class,'revoke']);
$router->add('POST', '/api/admin/moderate/{kind}/{id}', [AdminApiController::class,'moderate']);
