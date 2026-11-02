<?php $signedIn = (bool)$currentUser; ?>
<?php if (!$signedIn): ?><section class="catalogue-intro"><div class="container"><?php endif; ?>
<a href="<?= e(route_url('/skills/' . $track['category_slug'])) ?>" class="text-link small muted skill-back"><?= icon('arrow-left', 15) ?> <?= e($track['category_name']) ?></a>
<div class="skill-hero tone-orange"><span class="skill-card-icon big"><?= icon('path', 34) ?></span><div><span class="eyebrow <?= $signedIn ? '' : 'orange-text' ?>">ROADMAP</span><h1><?= e($track['title']) ?></h1><p><?= e($track['summary']) ?></p></div></div>
<?php if (!$signedIn): ?></div></section><section class="container skills-public"><?php endif; ?>
<div class="skill-layout">
  <article class="card card-pad skill-article lesson-content"><?= lessonHtml($track['article']) ?></article>
  <aside class="card card-pad skill-aside">
    <?php if ($signedIn): ?>
      <?php if ($track['chosen']): ?><span class="badge badge-completed">Your track</span><h3>You are on this roadmap.</h3><p>Finish each course to unlock the next one.</p>
      <?php else: ?><h3>Follow this roadmap</h3><p>Choose it to keep your path in one place.</p><form action="<?= e(route_url('/api/tracks/' . ((int)$track['id']) . '/choose')) ?>" method="post" data-api><?= csrfField() ?><button class="btn btn-primary btn-block">Start this track <?= icon('arrow-right', 16) ?></button></form><?php endif; ?>
    <?php else: ?><h3>Start for free</h3><p>Register to unlock the first course and track your progress.</p><a class="btn btn-primary btn-block" href="<?= e(route_url('/register')) ?>">Register to start <?= icon('arrow-right', 16) ?></a><?php endif; ?>
  </aside>
</div>
<h2 class="skill-section-title">Courses in order</h2>
<?php require ROOT . '/app/Views/components/roadmap.php'; ?>
<?php if (!$signedIn): ?></section><?php endif; ?>
