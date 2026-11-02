<?php

namespace Learnow\Middleware;

use Learnow\Repositories\DB;

final class Security
{
    public static function headers(): void
    {
        if (env('APP_ENV') === 'testing' && str_ends_with(env('DB_DATABASE'), '_test')) {
            header('X-Learnow-Test-Instance: isolated');
        }
        header('X-Content-Type-Options: nosniff');
        header('Referrer-Policy: strict-origin-when-cross-origin');
        header('Permissions-Policy: camera=(), microphone=(), geolocation=()');
        header('Cache-Control: no-store, private');
        $csp = "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self'; connect-src 'self'; frame-src https://www.youtube-nocookie.com; object-src 'none'; base-uri 'self'; form-action 'self'";
        if (env('APP_ENV') === 'production') {
            $csp .= "; frame-ancestors 'self'";
            header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
        }
        header('Content-Security-Policy: ' . $csp);
    }
    public static function cookie(string $name, string $value, int $expires): void
    {
        setcookie($name, $value, ['expires' => $expires,'path' => (\Learnow\Helpers\Url::basePath() ?: '') . '/','secure' => filter_var(env('COOKIE_SECURE', 'true'), FILTER_VALIDATE_BOOL),'httponly' => true,'samesite' => 'Lax']);
        $_COOKIE[$name] = $value;
    }
    public static function csrfToken(): string
    {
        $token = $_COOKIE['ln_csrf'] ?? '';
        $parts = explode('.', $token);
        if (count($parts) !== 2 || !hash_equals(hash_hmac('sha256', $parts[0], env('APP_KEY')), $parts[1])) {
            $random = bin2hex(random_bytes(32));
            $token = $random . '.' . hash_hmac('sha256', $random, env('APP_KEY'));
            self::cookie('ln_csrf', $token, time() + 86400);
        }
        return $token;
    }
    public static function verifyCsrf(): void
    {
        $token = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? (input()['_csrf'] ?? '');
        if (!is_string($token) || !isset($_COOKIE['ln_csrf']) || !hash_equals(self::csrfToken(), $token)) {
            abort(403, 'Your security token expired. Refresh this page and try again.');
        }
        if (($_SERVER['HTTP_SEC_FETCH_SITE'] ?? '') === 'cross-site') {
            abort(403, 'Cross-site requests are not allowed.');
        }
    }
    public static function throttle(string $key, int $max, int $window): void
    {
        $key = hash_hmac('sha256', $key, env('APP_KEY'));
        $now = time();
        DB::transaction(function () use ($key, $max, $window, $now) {
            DB::run('INSERT IGNORE INTO rate_limits(bucket,attempts,resets_at) VALUES(?,0,?)', [$key,$now + $window]);
            $r = DB::one('SELECT * FROM rate_limits WHERE bucket=? FOR UPDATE', [$key]);
            if ($r['resets_at'] <= $now) {
                DB::run('UPDATE rate_limits SET attempts=0,resets_at=? WHERE bucket=?', [$now + $window,$key]);
                $r['attempts'] = 0;
            }
            if ($r['attempts'] >= $max) {
                header('Retry-After: ' . max(1, $r['resets_at'] - $now));
                abort(429, 'Too many attempts. Please wait a few minutes and try again.');
            }
            DB::run('UPDATE rate_limits SET attempts=attempts+1 WHERE bucket=?', [$key]);
        });
    }
    public static function ip(): string
    {
        return $_SERVER['REMOTE_ADDR'] ?? 'cli';
    }
}
