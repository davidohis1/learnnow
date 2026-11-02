<?php

namespace Learnow\Controllers;

use Learnow\Middleware\Auth;
use Learnow\Repositories\DB;
use Learnow\Services\ChatService;
use Learnow\Validators\Validate as V;

final class ChatController
{
    private function room(int $categoryId): array
    {
        $u = Auth::requireUser();
        if (!ChatService::isMember((int)$u['id'], $categoryId)) {
            abort(403, 'Enrol in a course in this skill area to join its group chat.');
        }
        return $u;
    }
    public function messages(string $id): void
    {
        $this->room((int)$id);
        $after = max(0, (int)($_GET['after'] ?? 0));
        $rows = ChatService::messages((int)$id, $after);
        jsonResponse(['ok' => true,'messages' => $rows,'members' => count(ChatService::members((int)$id, 200))]);
    }
    public function send(string $id): void
    {
        $u = $this->room((int)$id);
        $body = V::text(input()['body'] ?? '', 'Message', 1, 500);
        $mid = ChatService::post((int)$u['id'], (int)$id, $body);
        success('Sent.', ['id' => $mid]);
    }
    public function hide(string $id): void
    {
        $u = Auth::permission('community.manage');
        ChatService::hide((int)$id);
        audit((int)$u['id'], 'chat.hide', 'chat_messages', (int)$id, []);
        success('Message hidden.', ['reload' => true]);
    }
}
