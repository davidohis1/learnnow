<?php $signedIn = (bool)$currentUser; ?>
<?php if (!$signedIn): ?><section class="catalogue-intro"><div class="container"><?php else: ?><div class="page-header"><div><?php endif; ?>
<span class="eyebrow <?= $signedIn ? '' : 'orange-text' ?>">EXPLORE SKILLS</span>
<h1>Choose a skill to master.</h1>
<p>Pick a skill area, follow its roadmap and unlock each course in order. New areas are opening soon.</p>
<?php if (!$signedIn): ?></div></section><section class="container skills-public"><?php else: ?></div><span class="icon-tile orange"><?= icon('path', 24) ?></span></div><?php endif; ?>
<?php if ($areas): ?>
<div class="skill-grid"><?php foreach ($areas as $area) require ROOT . '/app/Views/components/skill-card.php'; ?></div>
<?php else: emptyState('path', 'Skill areas are being prepared.', 'Check back soon, or browse every published course in the meantime.', '/paths', 'Browse all courses'); endif; ?>
<?php if (!$signedIn): ?><div class="skills-cta"><h2>Ready to begin?</h2><p>Create a free account, choose your direction and start with your first course.</p><a class="btn btn-primary" href="<?= e(route_url('/register')) ?>">Create your free account <?= icon('arrow-right', 17) ?></a></div></section><?php endif; ?>
