<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;

final class NotificationService
{
    public static function notify(int $uid, string $kind, string $title, string $body, string $link, string $key): void
    {
        $prefs = DB::one('SELECT * FROM notification_preferences WHERE user_id=?', [$uid]);
        if ($prefs && isset($prefs[$kind]) && !$prefs[$kind]) {
            return;
        }
        $changed = DB::run('INSERT IGNORE INTO notifications(user_id,kind,title,body,link,dedup_key) VALUES(?,?,?,?,?,?)', [$uid,$kind,$title,$body,$link,$key])->rowCount();
        if ($changed && $prefs && $prefs['email'] && MailService::enabled()) {
            DB::run('INSERT IGNORE INTO mail_outbox(user_id,subject,body,link,dedup_key) VALUES(?,?,?,?,?)', [$uid,$title,$body,$link,$uid . ':' . $key]);
        }
    }
}
