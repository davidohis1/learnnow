<?php

declare(strict_types=1);

namespace Learnow\Helpers;

final class ErrorHandler
{
    public static function safeMessage(\Throwable $error): string
    {
        $message = $error->getMessage();
        foreach (['APP_KEY', 'DB_PASSWORD', 'MAIL_PASSWORD', 'ADMIN_PASSWORD'] as $key) {
            $secret = class_exists(Environment::class, false) ? Environment::get($key) : (function_exists('getenv') ? getenv($key) : false);
            if (is_string($secret) && $secret !== '') {
                $message = str_replace($secret, '[redacted]', $message);
            }
        }
        return $message;
    }

    public static function log(\Throwable $error): string
    {
        $reference = bin2hex(random_bytes(6));
        $frames = array_map(static fn(array $f): array => array_intersect_key($f, array_flip(['file', 'line', 'class', 'function'])), $error->getTrace());
        $record = json_encode(['at' => gmdate('c'), 'reference' => $reference, 'type' => get_class($error), 'code' => $error->getCode(), 'message' => self::safeMessage($error), 'file' => $error->getFile(), 'line' => $error->getLine(), 'trace' => $frames], JSON_UNESCAPED_SLASHES | JSON_INVALID_UTF8_SUBSTITUTE) . "\n";
        $root = defined('ROOT') ? ROOT : dirname(__DIR__, 2);
        $dir = $root . '/storage/logs';
        if (!is_dir($dir)) {
            @mkdir($dir, 0700, true);
        }
        $written = is_dir($dir) && is_writable($dir) ? @file_put_contents($dir . '/application.log', $record, FILE_APPEND | LOCK_EX) : false;
        if ($written === false) {
            error_log($record);
        } else {
            @chmod($dir . '/application.log', 0600);
        }
        return $reference;
    }

    /** No database, template, configuration or dependency is needed to render a startup failure. */
    public static function respond(\Throwable $error): never
    {
        $reference = self::log($error);
        while (ob_get_level() > 0) {
            if (!@ob_end_clean()) {
                break;
            }
        }
        http_response_code(500);
        header('Cache-Control: no-store');
        header('X-Content-Type-Options: nosniff');
        $message = 'Something went wrong. Please try again. Reference: ' . $reference;
        $json = str_contains($_SERVER['HTTP_ACCEPT'] ?? '', 'application/json') || preg_match('~(?:^|/)api(?:/|$)~', explode('?', $_SERVER['REQUEST_URI'] ?? '', 2)[0]);
        if ($json) {
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode(['ok' => false, 'message' => $message, 'reference' => $reference]);
        } else {
            header('Content-Type: text/html; charset=utf-8');
            header("Content-Security-Policy: default-src 'none'; style-src 'unsafe-inline'; base-uri 'none'; frame-ancestors 'self'");
            echo '<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>A little pause · Learnow</title><body style="margin:0;background:#fff9f5;color:#191919;font:18px/1.7 system-ui"><main style="max-width:580px;margin:12vh auto;padding:30px"><strong style="color:#c24712">learnow.</strong><h1>A little pause.</h1><p>' . $message . '</p><p>If this continues, share the reference with the platform administrator.</p></main></body></html>';
        }
        exit;
    }
}
