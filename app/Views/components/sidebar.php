<?php
$isAdmin=$isAdmin??false;$uri=route_path();
$links=$isAdmin?[
 ['Overview','/admin','grid','admin.access'],['Learning content','/admin/content/paths','book','content.manage'],['Learners','/admin/users','users','users.manage'],['Reviews & grading','/admin/reviews','briefcase','review.manage'],['Rewards & levels','/admin/rewards','bolt','settings.manage'],['Certificates','/admin/certificates','award','certificates.manage'],['Referrals','/admin/referrals','gift','settings.manage'],['Community','/admin/community','message','community.manage'],['Reports','/admin/reports','chart','reports.view'],['Audit log','/admin/audit','shield','reports.view']
]:[
 ['Overview','/dashboard','grid'],['My learning','/my-learning','book'],['Explore paths','/skills','path'],['Assignments','/assignments','briefcase'],['Study schedule','/schedule','calendar'],['Achievements','/achievements','award'],['My portfolio','/portfolio','folder'],['Community','/community','users'],['Certificates','/certificates','file'],['Invite friends','/referrals','gift'],['Weekly reports','/reports','chart']
];
$permissions=$isAdmin?array_column(\Learnow\Repositories\DB::all('SELECT p.name FROM permissions p JOIN role_permissions rp ON rp.permission_id=p.id WHERE rp.role_id=?',[$currentUser['role_id']]),'name'):[];
?>
<aside class="sidebar" id="app-sidebar"><div class="sidebar-brand"><?= logo() ?><button class="icon-button sidebar-close" data-toggle-nav="app-sidebar" aria-label="Close navigation"><?= icon('x') ?></button></div>
<div class="workspace-label"><span class="workspace-icon"><?= icon($isAdmin?'shield':'sparkles',15) ?></span><?= $isAdmin?'ADMIN WORKSPACE':'YOUR LEARNING SPACE' ?></div>
<nav class="sidebar-nav" aria-label="<?= $isAdmin?'Administration':'Learner navigation' ?>">
<?php foreach($links as $i=>$link): if($isAdmin && !in_array($link[3],$permissions,true)) continue;$active=$uri===$link[1] || (!in_array($link[1],['/admin','/dashboard','/paths'],true) && str_starts_with($uri,$link[1].'/')) || ($link[1]==='/admin/content/paths' && str_starts_with($uri,'/admin/content/'));if(!$isAdmin && $i===5) echo '<span class="nav-section-label">GROW TOGETHER</span>'; ?>
<a href="<?= e(route_url(($link[1]))) ?>" class="sidebar-link <?= $active?'active':'' ?>" <?= $active?'aria-current="page"':'' ?>><?= icon($link[2],19) ?><span><?= $link[0] ?></span><?php if($link[0]==='Invite friends'): ?><span class="nav-tiny-dot"></span><?php endif; ?></a>
<?php endforeach; ?></nav>
<div class="sidebar-bottom"><?php if(!$isAdmin): ?><div class="sidebar-motivation"><span class="mini-spark"><?= icon('sparkles',22) ?></span><strong>Small steps. Big things.</strong><p>Your next skill is closer<br>than you think.</p><a href="<?= e(route_url('/paths')) ?>">Find your next path <?= icon('arrow-right',15) ?></a></div><?php endif; ?>
<?php if(!$isAdmin || in_array('settings.manage',$permissions,true)): ?><a class="sidebar-link <?= str_ends_with($uri,'/settings')?'active':'' ?>" href="<?= e(route_url(($isAdmin?'/admin/settings':'/settings'))) ?>"><?= icon('settings',19) ?><span>Settings</span></a><?php endif; ?>
<a class="sidebar-link" href="<?= e(route_url(($isAdmin?'/dashboard':'/help'))) ?>"><?= icon($isAdmin?'arrow-left':'help',19) ?><span><?= $isAdmin?'Learner workspace':'Help & support' ?></span></a>
<?php if(!$isAdmin && in_array($currentUser['role'],['administrator','reviewer'],true)): ?><a class="sidebar-link" href="<?= e(route_url('/admin')) ?>"><?= icon('shield',19) ?><span>Admin workspace</span><?= icon('arrow-up-right',14) ?></a><?php endif; ?>
<div class="sidebar-profile"><span class="avatar"><?= e(initials($currentUser['full_name'])) ?></span><div><strong><?= e($currentUser['full_name']) ?></strong><small><?= $isAdmin?ucfirst($currentUser['role']):'Lifelong learner' ?></small></div><form action="<?= e(route_url('/api/auth/logout')) ?>" method="post" data-api><?= csrfField() ?><button class="icon-button" title="Sign out" aria-label="Sign out"><?= icon('logout',18) ?></button></form></div></div></aside>
<div class="nav-backdrop" data-close-nav></div>
