<?php /** @var array $area */ $soon = $area['availability'] !== 'available'; ?>
<a class="skill-card <?= $soon ? 'is-soon' : '' ?> tone-<?= e($area['color']) ?>" href="<?= e(route_url('/skills/' . $area['slug'])) ?>">
  <span class="skill-card-icon"><?= icon($area['icon'], 26) ?></span>
  <span class="skill-card-body">
    <span class="skill-card-top"><strong><?= e($area['name']) ?></strong><?= $soon ? '<span class="badge badge-coming_soon">Coming soon</span>' : '<span class="badge badge-available">Available now</span>' ?></span>
    <span class="skill-card-tagline"><?= e($area['tagline']) ?></span>
    <span class="skill-card-summary"><?= e($area['summary']) ?></span>
    <span class="skill-card-link"><?= $soon ? 'Read about this path' : 'See the roadmaps' ?> <?= icon('arrow-right', 15) ?></span>
  </span>
</a>
