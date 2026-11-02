<?php

declare(strict_types=1);

namespace Learnow\Services;

/** Secure fallback for shared-hosting/root bridges and arbitrary APP_URL path prefixes. */
final class AssetService
{
    public static function serve(string $route, string $method): bool
    {
        if (!str_starts_with($route, '/assets/')) {
            return false;
        }
        if (!in_array($method, ['GET', 'HEAD'], true)) {
            header('Allow: GET, HEAD');
            abort(405, 'This asset only supports GET and HEAD.');
        }
        $directory = realpath(ROOT . '/public/assets');
        $file = realpath(ROOT . '/public' . rawurldecode($route));
        $types = ['css' => 'text/css', 'js' => 'text/javascript', 'svg' => 'image/svg+xml', 'png' => 'image/png', 'jpg' => 'image/jpeg', 'jpeg' => 'image/jpeg', 'webp' => 'image/webp', 'gif' => 'image/gif', 'ico' => 'image/x-icon', 'ttf' => 'font/ttf', 'woff' => 'font/woff', 'woff2' => 'font/woff2', 'txt' => 'text/plain'];
        $extension = strtolower(pathinfo($file ?: '', PATHINFO_EXTENSION));
        if (!$directory || !$file || !str_starts_with($file, $directory . DIRECTORY_SEPARATOR) || !is_file($file) || !isset($types[$extension]) || preg_match('~(?:^|/)\.~', $route)) {
            abort(404, 'Asset not found.');
        }
        $etag = '"' . hash_file('sha256', $file) . '"';
        header('Content-Type: ' . $types[$extension]);
        header('X-Content-Type-Options: nosniff');
        header('Cache-Control: public, max-age=300, must-revalidate');
        header('ETag: ' . $etag);
        if (($_SERVER['HTTP_IF_NONE_MATCH'] ?? '') === $etag) {
            http_response_code(304);
            return true;
        }
        header('Content-Length: ' . filesize($file));
        if ($method !== 'HEAD') {
            readfile($file);
        }
        return true;
    }
}
