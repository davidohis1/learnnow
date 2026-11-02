<?php

namespace Learnow\Controllers;

use Learnow\Repositories\DB;
use Learnow\Validators\Validate as V;
use Learnow\Middleware\{Auth,Security};
use Learnow\Services\MailService;

final class AuthController
{
    public function page(string $mode = 'login'): void
    {
        if (user() && in_array($mode, ['login','register'], true)) {
            redirect($this->destination(user()));
        } render('auth', ['title' => match ($mode) {
            'register'=>'Your next chapter starts here','forgot'=>'Reset your password','reset'=>'Choose a new password',default=>'Welcome back'
        },'mode' => $mode], 'auth');
    }
    private function destination(array $u): string
    {
        return $u['role'] === 'administrator' ? '/admin' : ($u['onboarding_completed_at'] ? '/dashboard' : '/onboarding');
    }
    public function register(): void
    {
        Security::throttle('register:' . Security::ip(), 10, 3600);
        $d = input();
        $name = V::text($d['full_name'] ?? '', 'Full name', 2, 120);
        $email = V::email($d['email'] ?? '');
        $password = V::password($d['password'] ?? '');
        if (!is_string($d['password_confirmation'] ?? null) || !hash_equals($password, $d['password_confirmation'])) {
            abort(422, 'The passwords do not match.');
        }
        if (!in_array($d['terms'] ?? false, [true, 1, '1', 'on'], true)) {
            abort(422, 'Please accept the Terms of Service and Privacy Policy.');
        }
        if (DB::value('SELECT id FROM users WHERE email=?', [$email])) {
            abort(422, 'We couldn’t create an account with these details. Try signing in or resetting your password.');
        }
        try {
            $uid = DB::transaction(function () use ($name, $email, $password, $d) {
                        $role = DB::value("SELECT id FROM roles WHERE name='learner'");
                if (!$role) {
                    throw new \RuntimeException('Required learner role is missing. Run all database migrations, including the installation baseline.');
                }
                        $uid = DB::insert('INSERT INTO users(full_name,email,password_hash,role_id,terms_accepted_at,timezone) VALUES(?,?,?,?,UTC_TIMESTAMP(),?)', [$name,$email,password_hash($password, PASSWORD_ARGON2ID),$role,env('DEFAULT_TIMEZONE', 'UTC')]);
                        DB::run('INSERT INTO user_preferences(user_id) VALUES(?)', [$uid]);
                DB::run('INSERT INTO study_schedules(user_id) VALUES(?)', [$uid]);
                DB::run('INSERT INTO notification_preferences(user_id) VALUES(?)', [$uid]);
                DB::run("INSERT INTO onboarding_responses(user_id,responses) VALUES(?,'{}')", [$uid]);
                        DB::run('INSERT INTO referral_codes(user_id,code) VALUES(?,?)', [$uid,strtoupper(bin2hex(random_bytes(8)))]);
                if (!empty($d['referral_code'])) {
                    $code = V::text($d['referral_code'], 'Referral code', 1, 20);
                    $ref = DB::value('SELECT r.user_id FROM referral_codes r JOIN users u ON u.id=r.user_id WHERE r.code=? AND u.status=\'active\'', [$code]);
                    if ($ref && (int)$ref !== $uid) {
                        DB::run('INSERT INTO referrals(referrer_id,referred_id) VALUES(?,?)', [$ref,$uid]);
                    }
                }
                Auth::issue($uid);
                return $uid;
            });
        } catch (\PDOException $e) {
            if (($e->errorInfo[1] ?? null) === 1062 && DB::value('SELECT id FROM users WHERE email=?', [$email])) {
                abort(422, 'We couldn’t create an account with these details. Try signing in.');
            } throw $e;
        }
        $message = 'Your learning journey starts now.';
        if (filter_var(env('MAIL_ENABLED'), FILTER_VALIDATE_BOOL)) {
            $sent = $this->sendToken($uid, 'verify');
            $message = $sent ? 'Check your inbox to verify your email.' : 'Your account is ready, but verification email delivery failed. You can try resending from the verification page.';
        }
        success($message, ['redirect' => filter_var(env('MAIL_ENABLED'), FILTER_VALIDATE_BOOL) ? '/verify-email' : '/onboarding'], 201);
    }
    public function login(): void
    {
        $d = input();
        Security::throttle('login-ip:' . Security::ip(), 30, 900);
        $email = V::email($d['email'] ?? '');
        Security::throttle('login-email:' . $email, 10, 900);
        $u = DB::one('SELECT u.*,r.name AS role FROM users u JOIN roles r ON r.id=u.role_id WHERE email=?', [$email]);
        // A non-account Argon2id hash keeps the comparison algorithm consistent.
        $hash = $u['password_hash'] ?? '$argon2id$v=19$m=65536,t=4,p=1$Q0JRT0FwNjZsNnJXZVFERA$NqPNa+vFciq5YHPXOETC1DOodtXGJMZ0bIlssDAUxcU';
        if (!password_verify((string)($d['password'] ?? ''), $hash) || !$u || $u['status'] !== 'active') {
            abort(401, 'The email or password is incorrect, or this account is unavailable.');
        }
        if (password_needs_rehash($hash, PASSWORD_ARGON2ID)) {
            DB::run('UPDATE users SET password_hash=? WHERE id=?', [password_hash((string)$d['password'], PASSWORD_ARGON2ID),$u['id']]);
        }
        Auth::issue((int)$u['id']);
        success('Welcome back. Let’s keep growing.', ['redirect' => $this->destination($u)]);
    }
    public function logout(): void
    {
        Auth::logout();
        success('You are safely signed out.', ['redirect' => '/']);
    }
    private function sendToken(int $uid, string $purpose): bool
    {
        $u = DB::one('SELECT full_name,email FROM users WHERE id=?', [$uid]);
        $token = bin2hex(random_bytes(32));
        DB::run('UPDATE account_tokens SET used_at=UTC_TIMESTAMP() WHERE user_id=? AND purpose=? AND used_at IS NULL', [$uid,$purpose]);
        DB::run('INSERT INTO account_tokens(user_id,token_hash,purpose,expires_at) VALUES(?,?,?,?)', [$uid,hash('sha256', $token),$purpose,gmdate('Y-m-d H:i:s', time() + ($purpose === 'reset' ? 1800 : 86400))]);
        $url = route_url($purpose === 'reset' ? '/reset-password' : '/verify-email', ['token' => $token]);
        return MailService::send($u['email'], $u['full_name'], $purpose === 'reset' ? 'Reset your Learnow password' : 'Verify your Learnow email', "Hello " . $u['full_name'] . ",\n\n" . ($purpose === 'reset' ? 'Choose a new password. This link expires in 30 minutes.' : 'Verify your email address. This link expires in 24 hours.') . "\n\n" . $url . "\n\nIf you didn’t request this, you can ignore this email.\nThe Learnow team");
    }
    public function forgot(): void
    {
        Security::throttle('reset-ip:' . Security::ip(), 5, 3600);
        $email = V::email(input()['email'] ?? '');
        Security::throttle('reset-email:' . $email, 3, 3600);
        if (!MailService::enabled()) {
            abort(503, 'Email delivery is not configured on this installation. Please contact the platform administrator to recover your account.');
        }
        $u = DB::one('SELECT id FROM users WHERE email=? AND status=\'active\'', [$email]);
        if ($u) {
            $this->sendToken((int)$u['id'], 'reset');
        }
        success('If an eligible account uses that email, a password-reset link will be sent. Check your inbox and spam folder.');
    }
    public function reset(): void
    {
        Security::throttle('reset-submit:' . Security::ip(), 10, 3600);
        $d = input();
        $password = V::password($d['password'] ?? '');
        if ($password !== ($d['password_confirmation'] ?? '')) {
            abort(422, 'The passwords do not match.');
        }
        DB::transaction(function () use ($d, $password) {
            $t = DB::one("SELECT * FROM account_tokens WHERE token_hash=? AND purpose='reset' AND used_at IS NULL AND expires_at>UTC_TIMESTAMP() FOR UPDATE", [hash('sha256', (string)($d['token'] ?? ''))]);
            if (!$t) {
                abort(422, 'This reset link is invalid or expired. Request a new one.');
            } DB::run('UPDATE users SET password_hash=? WHERE id=?', [password_hash($password, PASSWORD_ARGON2ID),$t['user_id']]);
            DB::run('UPDATE account_tokens SET used_at=UTC_TIMESTAMP() WHERE user_id=? AND purpose=\'reset\' AND used_at IS NULL', [$t['user_id']]);
            DB::run('UPDATE auth_sessions SET revoked_at=UTC_TIMESTAMP() WHERE user_id=?', [$t['user_id']]);
        });
        Auth::clearCookies();
        success('Your password has been changed. Sign in with your new password.', ['redirect' => '/login']);
    }
    public function verificationPage(): void
    {
        $u = Auth::requireUser(false);
        if (!filter_var(env('MAIL_ENABLED'), FILTER_VALIDATE_BOOL) || $u['email_verified_at']) {
            redirect('/onboarding');
        } render('verify-email', ['title' => 'One last inbox check','token' => $_GET['token'] ?? ''], 'auth');
    }
    public function verify(): void
    {
        $u = Auth::requireUser(false);
        Security::throttle('verify:' . $u['id'], 10, 3600);
        DB::transaction(function () use ($u) {
            $t = DB::one("SELECT * FROM account_tokens WHERE token_hash=? AND user_id=? AND purpose='verify' AND used_at IS NULL AND expires_at>UTC_TIMESTAMP() FOR UPDATE", [hash('sha256', (string)(input()['token'] ?? '')),$u['id']]);
            if (!$t) {
                abort(422, 'This verification link is invalid or expired.');
            } DB::run('UPDATE users SET email_verified_at=UTC_TIMESTAMP() WHERE id=?', [$u['id']]);
            DB::run('UPDATE account_tokens SET used_at=UTC_TIMESTAMP() WHERE id=?', [$t['id']]);
        });
        success('Email verified. You’re ready to learn.', ['redirect' => '/onboarding']);
    }
    public function resend(): void
    {
        $u = Auth::requireUser(false);
        Security::throttle('verify-resend:' . $u['id'], 3, 3600);
        if ($u['email_verified_at']) {
            success('Your email is already verified.');
        } if (!$this->sendToken((int)$u['id'], 'verify')) {
            abort(503, 'Email delivery is unavailable. Please try again later or contact the administrator.');
        } success('A fresh verification link is on its way.');
    }
}
