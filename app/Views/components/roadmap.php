<?php
/** @var array $track  @var bool $signedIn */
$groups = [];
foreach ($track['items'] as $item) {
    $groups[(int)$item['step']][] = $item;
}
ksort($groups);
$stateLabel = ['completed' => 'Completed','in_progress' => 'In progress','available' => 'Ready to start','locked' => 'Locked','coming_soon' => 'Coming soon'];
$n = 0;
?>
<ol class="roadmap">
<?php foreach ($groups as $step => $items): $n++; $multi = count($items) > 1; $matches = $multi && array_filter($items, fn($i)=>!empty($i['requires_label'])); ?>
  <li class="roadmap-step">
    <span class="roadmap-number"><?= $n ?></span>
    <div class="roadmap-body">
      <?php if ($multi): ?><span class="roadmap-choice"><?= $matches ? 'Pick the one that matches your language' : 'Choose one' ?></span><?php endif; ?>
      <div class="roadmap-items <?= $multi ? 'is-multi' : '' ?>">
      <?php foreach ($items as $item): $state = $signedIn ? $item['state'] : ($item['state'] === 'coming_soon' ? 'coming_soon' : 'preview'); ?>
        <?php $link = null; if ($item['path_id']) { $link = $signedIn ? route_url('/paths/' . $item['path_slug']) : route_url('/register'); } ?>
        <<?= $link ? 'a href="' . e($link) . '"' : 'div' ?> class="roadmap-item state-<?= e($state) ?>">
          <span class="roadmap-item-icon"><?= icon($state === 'completed' ? 'check' : ($state === 'locked' ? 'lock' : ($state === 'coming_soon' ? 'clock' : 'book')), 17) ?></span>
          <span class="roadmap-item-text">
            <strong><?= e($item['label']) ?></strong>
            <small><?php if ($state === 'locked'): ?>Unlocks after <?= e(implode(' or ', $item['blockers'] ?: ['the previous course'])) ?><?php elseif ($state === 'coming_soon'): ?>Course being prepared<?php elseif ($state === 'preview'): ?>Register to start<?php else: ?><?= e($item['note']) ?><?php endif; ?></small>
          </span>
          <?php if ($state !== 'preview'): ?><span class="badge badge-<?= e($state) ?>"><?= e($stateLabel[$state] ?? $state) ?></span><?php endif; ?>
        </<?= $link ? 'a' : 'div' ?>>
      <?php endforeach; ?>
      </div>
    </div>
  </li>
<?php endforeach; ?>
</ol>
