<?php
use Learnow\Repositories\DB;
use Learnow\Services\ChatService;
$chatRooms = ChatService::rooms((int)$currentUser['id']);
$activeRoom = null;
foreach ($chatRooms as $r) {
    if ((int)$r['id'] === (int)($_GET['room'] ?? 0)) { $activeRoom = $r; }
}
$activeRoom = $activeRoom ?: ($chatRooms[0] ?? null);
$canModerate = (bool)DB::value("SELECT 1 FROM role_permissions rp JOIN permissions p ON p.id=rp.permission_id WHERE rp.role_id=? AND p.name='community.manage'", [$currentUser['role_id']]);
?>
<section class="card chat-card" id="group-chat">
<?php if (!$activeRoom): ?>
  <div class="chat-empty"><span class="icon-tile purple"><?= icon('users', 22) ?></span><div><h2>Your learning group chat</h2><p>Start a course or follow a track to join the group chat for that skill, meet other learners and cheer each other on.</p></div><a class="btn btn-primary" href="<?= e(route_url('/skills')) ?>">Choose a skill <?= icon('arrow-right', 16) ?></a></div>
<?php else:
  $chatMessages = ChatService::messages((int)$activeRoom['id']);
  $chatMembers = ChatService::members((int)$activeRoom['id']);
  $lastId = $chatMessages ? (int)end($chatMessages)['id'] : 0;
  $kindIcon = ['level' => 'bolt','achievement' => 'award','course' => 'check-circle','joined' => 'users'];
?>
  <div class="chat-header"><div><span class="eyebrow">GROUP CHAT</span><h2><?= e($activeRoom['name']) ?> learners</h2><p><?= (int)$activeRoom['member_count'] ?> <?= (int)$activeRoom['member_count'] === 1 ? 'learner' : 'learners' ?> in this group. Level-ups, achievements and finished courses appear here.</p></div>
  <?php if (count($chatRooms) > 1): ?><div class="tab-list chat-tabs"><?php foreach ($chatRooms as $r): ?><a href="<?= e(route_url('/community', ['room' => (int)$r['id']], 'group-chat')) ?>" class="<?= (int)$r['id'] === (int)$activeRoom['id'] ? 'active' : '' ?>"><?= e($r['name']) ?></a><?php endforeach; ?></div><?php endif; ?></div>
  <div class="chat-layout" id="chat-root" data-room="<?= (int)$activeRoom['id'] ?>" data-feed-url="<?= e(route_url('/api/chat/' . (int)$activeRoom['id'] . '/messages')) ?>" data-send-url="<?= e(route_url('/api/chat/' . (int)$activeRoom['id'] . '/messages')) ?>" data-last="<?= $lastId ?>" data-me="<?= (int)$currentUser['id'] ?>" data-moderate="<?= $canModerate ? 1 : 0 ?>" data-hide-base="<?= e(route_url('/api/chat/messages/')) ?>">
    <div class="chat-main">
      <div class="chat-feed" id="chat-feed" role="log" aria-live="polite" aria-label="Group chat messages">
        <?php if (!$chatMessages): ?><p class="chat-placeholder">No messages yet. Say hello and start the conversation.</p><?php endif; ?>
        <?php foreach ($chatMessages as $m): ?>
          <?php if ($m['kind'] === 'message'): $mine = (int)$m['user_id'] === (int)$currentUser['id']; ?>
          <div class="chat-msg <?= $mine ? 'mine' : '' ?>" data-id="<?= (int)$m['id'] ?>"><span class="avatar avatar-small"><?= e(initials($m['full_name'] ?? '?')) ?></span><div class="chat-bubble"><div class="chat-meta"><strong><?= e($m['full_name'] ?? 'Learner') ?></strong><time data-utc="<?= e($m['created_at']) ?>"><?= e(substr($m['created_at'], 11, 5)) ?></time><?php if ($canModerate): ?><button type="button" class="chat-hide" data-api-button="<?= e(route_url('/api/chat/messages/' . (int)$m['id'] . '/hide')) ?>" data-confirm="Hide this message for everyone?" aria-label="Hide message"><?= icon('x', 12) ?></button><?php endif; ?></div><p><?= e($m['body']) ?></p></div></div>
          <?php else: ?>
          <div class="chat-highlight kind-<?= e($m['kind']) ?>" data-id="<?= (int)$m['id'] ?>"><span class="chat-highlight-icon"><?= icon($kindIcon[$m['kind']] ?? 'sparkles', 16) ?></span><span><strong><?= e($m['full_name'] ?? 'A learner') ?></strong> <?= e($m['body']) ?></span><time data-utc="<?= e($m['created_at']) ?>"><?= e(substr($m['created_at'], 11, 5)) ?></time></div>
          <?php endif; ?>
        <?php endforeach; ?>
      </div>
      <form class="chat-form" id="chat-form" autocomplete="off"><label class="sr-only" for="chat-input">Write a message</label><input id="chat-input" name="body" maxlength="500" required placeholder="Write a message to the group…"><button class="btn btn-primary" type="submit">Send <?= icon('arrow-right', 15) ?></button></form>
    </div>
    <aside class="chat-members" aria-label="Learners in this group"><h3>Learners <span id="chat-count"><?= count($chatMembers) ?></span></h3><ul><?php foreach ($chatMembers as $mem): ?><li><span class="avatar avatar-small"><?= e(initials($mem['full_name'])) ?></span><div><strong><?= e($mem['full_name']) ?><?= (int)$mem['id'] === (int)$currentUser['id'] ? ' (you)' : '' ?></strong><small>Level <?= (int)$mem['level'] ?> · <?= e($mem['level_title']) ?></small></div></li><?php endforeach; ?></ul></aside>
  </div>
  <script type="module" src="<?= e(route_url('/assets/js/chat.js')) ?>"></script>
<?php endif; ?>
</section>
