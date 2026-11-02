<?php

namespace Learnow\Middleware;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Learnow\Repositories\DB;

final class Auth
{
    private static ?array $cached = null;
    private static bool $loaded = false;
    public static function user(): ?array
    {
        if (self::$loaded) {
            return self::$cached;
        }
        self::$loaded = true;
        $token = $_COOKIE['ln_access'] ?? '';
        $sid = null;
        $subject = null;
        if ($token) {
            try {
                $claims = JWT::decode($token, new Key(env('APP_KEY'), 'HS256'));
                if (
                    !isset($claims->iss, $claims->aud, $claims->sid, $claims->sub, $claims->exp, $claims->iat, $claims->nbf, $claims->jti)
                    || $claims->iss !== env('JWT_ISSUER', 'learnow')
                    || $claims->aud !== env('JWT_AUDIENCE', 'learnow-browser')
                    || !is_string($claims->sid) || !preg_match('/^[a-f0-9]{64}$/D', $claims->sid)
                    || !is_string($claims->sub) || !ctype_digit($claims->sub)
                    || !is_int($claims->exp) || !is_int($claims->iat) || !is_int($claims->nbf)
                    || $claims->exp > $claims->iat + 900
                    || !is_string($claims->jti) || !preg_match('/^[a-f0-9]{32}$/D', $claims->jti)
                ) {
                    return null;
                }
                $sid = $claims->sid;
                $subject = $claims->sub;
            } catch (\Firebase\JWT\ExpiredException $e) {
                $sid = self::refresh();
            } catch (\Throwable $e) {
                return null;
            }
        } elseif (!empty($_COOKIE['ln_refresh'])) {
            $sid = self::refresh();
        }
        if (!$sid) {
            return null;
        }
        $u = DB::one('SELECT u.*,r.name AS role,s.id AS auth_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN roles r ON r.id=u.role_id WHERE s.id=? AND s.revoked_at IS NULL AND s.expires_at>UTC_TIMESTAMP() AND u.status=\'active\'', [$sid]);
        if ($u && $subject !== null && (string)$u['id'] !== $subject) {
            return null;
        }
        if ($u) {
            unset($u['password_hash']);
        }
        return self::$cached = $u;
    }
    public static function requireUser(bool $verified = true): array
    {
        $u = self::user();
        if (!$u) {
            if (wantsJson()) {
                abort(401, 'Sign in to continue.');
            } redirect('/login');
        }
        if ($verified && filter_var(env('MAIL_ENABLED'), FILTER_VALIDATE_BOOL) && !$u['email_verified_at']) {
            if (wantsJson()) {
                abort(403, 'Please verify your email before continuing.');
            } redirect('/verify-email');
        }
        return $u;
    }
    public static function permission(string $permission): array
    {
        $u = self::requireUser();
        if (!DB::value('SELECT 1 FROM role_permissions rp JOIN permissions p ON p.id=rp.permission_id WHERE rp.role_id=? AND p.name=?', [$u['role_id'],$permission])) {
            abort(403, 'You do not have permission to access this area.');
        }
        return $u;
    }
    public static function issue(int $userId): void
    {
        $sid = bin2hex(random_bytes(32));
        $refresh = bin2hex(random_bytes(40));
        $expires = time() + 86400 * 14;
        DB::transaction(function () use ($userId, $sid, $refresh, $expires) {
            DB::run('INSERT INTO auth_sessions(id,user_id,expires_at) VALUES(?,?,?)', [$sid,$userId,gmdate('Y-m-d H:i:s', $expires)]);
            DB::run('INSERT INTO refresh_tokens(token_hash,session_id,expires_at) VALUES(?,?,?)', [hash('sha256', $refresh),$sid,gmdate('Y-m-d H:i:s', $expires)]);
        });
        self::accessCookie($userId, $sid);
        Security::cookie('ln_refresh', $refresh, $expires);
        self::$loaded = false;
    }
    private static function accessCookie(int $uid, string $sid): void
    {
        $now = time();
        $jwt = JWT::encode(['iss' => env('JWT_ISSUER', 'learnow'),'aud' => env('JWT_AUDIENCE', 'learnow-browser'),'iat' => $now,'nbf' => $now,'exp' => $now + 900,'sub' => (string)$uid,'sid' => $sid,'jti' => bin2hex(random_bytes(16))], env('APP_KEY'), 'HS256');
        Security::cookie('ln_access', $jwt, $now + 900);
    }
    private static function refresh(): ?string
    {
        $raw = $_COOKIE['ln_refresh'] ?? '';
        if (!$raw || strlen($raw) !== 80) {
            return null;
        }
        return DB::transaction(function () use ($raw) {
            $t = DB::one('SELECT t.*,s.user_id,s.revoked_at,s.expires_at AS session_expires,u.status FROM refresh_tokens t JOIN auth_sessions s ON s.id=t.session_id JOIN users u ON u.id=s.user_id WHERE t.token_hash=? FOR UPDATE', [hash('sha256', $raw)]);
            if (!$t || $t['revoked_at'] || $t['status'] !== 'active' || strtotime($t['expires_at']) <= time() || strtotime($t['session_expires']) <= time()) {
                return null;
            }
            if ($t['used_at']) {
                DB::run('UPDATE auth_sessions SET revoked_at=UTC_TIMESTAMP() WHERE id=?', [$t['session_id']]);
                self::clearCookies();
                return null;
            }
            DB::run('UPDATE refresh_tokens SET used_at=UTC_TIMESTAMP() WHERE token_hash=?', [hash('sha256', $raw)]);
            $fresh = bin2hex(random_bytes(40));
            DB::run('INSERT INTO refresh_tokens(token_hash,session_id,expires_at) VALUES(?,?,?)', [hash('sha256', $fresh),$t['session_id'],$t['session_expires']]);
            self::accessCookie((int)$t['user_id'], $t['session_id']);
            Security::cookie('ln_refresh', $fresh, strtotime($t['session_expires']));
            return $t['session_id'];
        });
    }
    public static function logout(): void
    {
        $u = self::user();
        if ($u) {
            DB::run('UPDATE auth_sessions SET revoked_at=UTC_TIMESTAMP() WHERE id=?', [$u['auth_id']]);
        } self::clearCookies();
        self::$cached = null;
    }
    public static function clearCookies(): void
    {
        Security::cookie('ln_access', '', time() - 3600);
        Security::cookie('ln_refresh', '', time() - 3600);
    }
}
