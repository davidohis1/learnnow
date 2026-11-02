<?php $signedIn = (bool)$currentUser; $soon = $area['availability'] !== 'available'; ?>
<?php if (!$signedIn): ?><section class="catalogue-intro"><div class="container"><?php endif; ?>
<a href="<?= e(route_url('/skills')) ?>" class="text-link small muted skill-back"><?= icon('arrow-left', 15) ?> All skills</a>
<div class="skill-hero tone-<?= e($area['color']) ?>"><span class="skill-card-icon big"><?= icon($area['icon'], 34) ?></span><div><span class="eyebrow <?= $signedIn ? '' : 'orange-text' ?>"><?= $soon ? 'COMING SOON' : 'AVAILABLE NOW' ?></span><h1><?= e($area['name']) ?></h1><p><?= e($area['tagline']) ?></p></div></div>
<?php if (!$signedIn): ?></div></section><section class="container skills-public"><?php endif; ?>
<div class="skill-layout">
  <article class="card card-pad skill-article lesson-content"><?= lessonHtml($area['article']) ?></article>
  <aside class="card card-pad skill-aside">
    <?php if ($soon): ?>
      <span class="badge badge-coming_soon">Coming soon</span>
      <h3>We are building this path.</h3>
      <p><?= $signedIn ? 'It will appear in your learning space as soon as it opens.' : 'Create a free account now so it is waiting for you when it opens.' ?></p>
      <?php if (!$signedIn): ?><a class="btn btn-primary btn-block" href="<?= e(route_url('/register')) ?>">Register to get started <?= icon('arrow-right', 16) ?></a><?php endif; ?>
    <?php else: ?>
      <h3>Pick your direction</h3>
      <p>Open a roadmap below to see every course in order.</p>
      <?php if (!$signedIn): ?><a class="btn btn-primary btn-block" href="<?= e(route_url('/register')) ?>">Register to start learning <?= icon('arrow-right', 16) ?></a><?php endif; ?>
    <?php endif; ?>
  </aside>
</div>
<?php if (!$soon): ?>
<h2 class="skill-section-title">Roadmaps in <?= e($area['name']) ?></h2>
<?php if ($tracks): foreach ($tracks as $i => $track): ?>
<details class="track-panel" <?= $i === 0 ? 'open' : '' ?>>
  <summary><span class="track-panel-title"><strong><?= e($track['title']) ?></strong><small><?= e($track['summary']) ?></small></span><span class="track-panel-meta"><?= count($track['items']) ?> courses · <?= (int)$track['available_count'] ?> ready</span><span class="track-panel-chevron"><?= icon('chevron-down', 18) ?></span></summary>
  <div class="track-panel-body">
    <div class="track-article lesson-content"><?= lessonHtml($track['article']) ?></div>
    <h3 class="track-order-title">Course order</h3>
    <?php require ROOT . '/app/Views/components/roadmap.php'; ?>
    <div class="track-actions">
      <?php if ($signedIn): ?>
        <?php if ($track['chosen']): ?><a class="btn btn-primary" href="<?= e(route_url('/tracks/' . $track['slug'])) ?>">Open my roadmap <?= icon('arrow-right', 16) ?></a>
        <?php else: ?><form action="<?= e(route_url('/api/tracks/' . ((int)$track['id']) . '/choose')) ?>" method="post" data-api><?= csrfField() ?><button class="btn btn-primary">Start this track <?= icon('arrow-right', 16) ?></button></form><?php endif; ?>
      <?php else: ?><a class="btn btn-primary" href="<?= e(route_url('/register')) ?>">Register to start this track <?= icon('arrow-right', 16) ?></a><?php endif; ?>
      <a class="text-link" href="<?= e(route_url('/tracks/' . $track['slug'])) ?>">Read the full roadmap page <?= icon('arrow-up-right', 14) ?></a>
    </div>
  </div>
</details>
<?php endforeach; else: emptyState('path', 'Roadmaps are being prepared.', 'Check back soon.'); endif; endif; ?>
<?php if (!$signedIn): ?></section><?php endif; ?>
