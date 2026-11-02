<?php

declare(strict_types=1);

namespace Learnow\Helpers;

/** Internal application URLs only. External links and filesystem paths never enter this class. */
final class Url
{
    public static function base(): string
    {
        $raw = Environment::get('APP_URL');
        if (!is_string($raw) || $raw === '' || preg_match('/[\x00-\x20\x7f\\\\]/', $raw)) {
            throw new \InvalidArgumentException('APP_URL must be an absolute HTTP(S) application URL without whitespace.');
        }
        $p = parse_url($raw);
        if (
            $p === false || !isset($p['scheme'], $p['host']) || !in_array(strtolower($p['scheme']), ['http', 'https'], true)
            || isset($p['user']) || isset($p['pass']) || isset($p['query']) || isset($p['fragment'])
        ) {
            throw new \InvalidArgumentException('APP_URL must include its HTTP(S) scheme and host, with an optional path but no credentials, query or fragment.');
        }
        $host = strtolower($p['host']);
        if (!filter_var(trim($host, '[]'), FILTER_VALIDATE_IP) && !filter_var($host, FILTER_VALIDATE_DOMAIN, FILTER_FLAG_HOSTNAME)) {
            throw new \InvalidArgumentException('APP_URL has an invalid hostname. Use an ASCII/punycode hostname.');
        }
        $scheme = strtolower($p['scheme']);
        $port = $p['port'] ?? null;
        if ($port !== null && ($port < 1 || $port > 65535)) {
            throw new \InvalidArgumentException('APP_URL has an invalid port.');
        }
        $portText = $port && $port !== ($scheme === 'https' ? 443 : 80) ? ':' . $port : '';
        return $scheme . '://' . $host . $portText . rtrim(self::normalisePath($p['path'] ?? '/'), '/');
    }

    public static function basePath(): string
    {
        return parse_url(self::base(), PHP_URL_PATH) ?: '';
    }

    public static function origin(): string
    {
        $base = self::base();
        return substr($base, 0, strlen($base) - strlen(self::basePath()));
    }

    private static function normalisePath(string $path): string
    {
        if (preg_match('/[\x00-\x20\x7f\\\\]|%(?![0-9a-f]{2})/i', $path)) {
            throw new \InvalidArgumentException('Invalid URL path. Encode spaces and Unicode path segments.');
        }
        $segments = [];
        foreach (explode('/', $path) as $segment) {
            if ($segment === '') {
                continue;
            }
            $decoded = rawurldecode($segment);
            if ($decoded === '.' || $decoded === '..' || preg_match('/[\x00-\x1f\x7f\/\\\\]/', $decoded)) {
                throw new \InvalidArgumentException('Traversal and encoded path separators are not permitted.');
            }
            $segments[] = rawurlencode($decoded);
        }
        $result = '/' . implode('/', $segments);
        return $result !== '/' && str_ends_with($path, '/') ? $result . '/' : $result;
    }

    /** Returns a logical route, or null when the request is outside this installation. */
    public static function routePath(string $uri): ?string
    {
        if ($uri === '' || $uri[0] !== '/' || str_starts_with($uri, '//') || preg_match('/[\x00-\x1f\x7f]/', $uri)) {
            return null;
        }
        try {
            $path = self::normalisePath(explode('?', explode('#', $uri, 2)[0], 2)[0]);
        } catch (\InvalidArgumentException) {
            return null;
        }
        $base = self::basePath();
        if ($base === '') {
            return $path;
        }
        if ($path === $base || $path === $base . '/') {
            return '/';
        }
        return str_starts_with($path, $base . '/') ? substr($path, strlen($base)) : null;
    }

    public static function currentPath(): string
    {
        return self::routePath($_SERVER['REQUEST_URI'] ?? '/') ?? '/';
    }

    private static function query(string $original, array $extra): string
    {
        if (!$extra) {
            return $original;
        }
        $pairs = $original === '' ? [] : explode('&', $original);
        $pairs = array_filter($pairs, static function (string $pair) use ($extra): bool {
            $key = urldecode(explode('=', $pair, 2)[0]);
            $root = explode('[', $key, 2)[0];
            return !array_key_exists($root, $extra);
        });
        $addition = http_build_query($extra, '', '&', PHP_QUERY_RFC3986);
        if ($addition !== '') {
            $pairs[] = $addition;
        }
        return implode('&', $pairs);
    }

    public static function to(string $reference = '', array $query = [], ?string $fragment = null, bool $logicalRoute = false): string
    {
        if (preg_match('/[\x00-\x1f\x7f\\\\]/', $reference) || str_starts_with($reference, '//')) {
            throw new \InvalidArgumentException('Unsafe internal URL reference.');
        }
        $base = self::base();
        $p = parse_url($reference);
        if ($p === false || isset($p['user']) || isset($p['pass'])) {
            throw new \InvalidArgumentException('Invalid internal URL.');
        }
        if (isset($p['scheme']) || isset($p['host'])) {
            if (!in_array(strtolower($p['scheme'] ?? ''), ['http', 'https'], true) || !isset($p['host'])) {
                throw new \InvalidArgumentException('Only internal HTTP(S) URLs are allowed.');
            }
            $port = $p['port'] ?? null;
            $scheme = strtolower($p['scheme']);
            $origin = $scheme . '://' . strtolower($p['host']) . ($port && $port !== ($scheme === 'https' ? 443 : 80) ? ':' . $port : '');
            if ($origin !== self::origin() || self::routePath($p['path'] ?? '/') === null) {
                throw new \InvalidArgumentException('External or out-of-application URLs are not internal routes.');
            }
        }
        if ($reference !== '' && ($reference[0] === '?' || $reference[0] === '#')) {
            $path = self::currentPath();
            if ($reference[0] === '#' && !isset($p['query'])) {
                $p['query'] = parse_url($_SERVER['REQUEST_URI'] ?? '', PHP_URL_QUERY) ?: '';
            }
        } else {
            $path = self::normalisePath($p['path'] ?? '/');
            $prefix = self::basePath();
            if (!$logicalRoute && $prefix !== '' && ($path === $prefix || str_starts_with($path, $prefix . '/'))) {
                $path = substr($path, strlen($prefix)) ?: '/';
            }
        }
        $qs = self::query($p['query'] ?? '', $query);
        $hash = $fragment !== null ? rawurlencode($fragment) : ($p['fragment'] ?? '');
        return $base . '/' . ltrim($path, '/') . ($qs !== '' ? '?' . $qs : '') . ($hash !== '' ? '#' . $hash : '');
    }

    /** Logical route names are unambiguous even if APP_URL ends in /admin or /api. */
    public static function route(string $route = '', array $query = [], ?string $fragment = null): string
    {
        $absolute = preg_match('~^[a-z][a-z0-9+.-]*:~i', $route);
        return self::to($route, $query, $fragment, !$absolute);
    }

    public static function asset(string $path): string
    {
        return self::route('assets/' . ltrim($path, '/'));
    }
}
