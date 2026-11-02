<?php

namespace Learnow\Services;

use PHPMailer\PHPMailer\PHPMailer;

final class MailService
{
    public static function enabled(): bool
    {
        return filter_var(env('MAIL_ENABLED', 'false'), FILTER_VALIDATE_BOOL) && env('MAIL_HOST') !== '' && env('MAIL_FROM') !== '';
    }
    public static function send(string $to, string $name, string $subject, string $body): bool
    {
        if (!self::enabled()) {
            return false;
        }
        try {
            $m = new PHPMailer(true);
            $m->isSMTP();
            $m->Host = env('MAIL_HOST');
            $m->Port = (int)env('MAIL_PORT', '587');
            $m->SMTPAuth = env('MAIL_USERNAME') !== '';
            $m->Username = env('MAIL_USERNAME');
            $m->Password = env('MAIL_PASSWORD');
            $m->SMTPSecure = $m->Port === 465 ? PHPMailer::ENCRYPTION_SMTPS : PHPMailer::ENCRYPTION_STARTTLS;
            $m->Timeout = 15;
            $m->CharSet = 'UTF-8';
            $m->setFrom(env('MAIL_FROM'), env('MAIL_FROM_NAME', 'Learnow'));
            $m->addAddress($to, $name);
            $m->Subject = $subject;
            $m->Body = $body;
            return $m->send();
        } catch (\Throwable $e) {
            error_log("SMTP delivery failed; check server-side configuration.\n", 3, ROOT . '/storage/logs/mail.log');
            return false;
        }
    }
}
