<?php

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require __DIR__ . '/bootstrap.php';
use Learnow\Repositories\DB;
use Learnow\Validators\Validate as V;
if (empty($argv[1])) {
    throw new InvalidArgumentException('Usage: php bin/create-admin.php EMAIL [NAME]. Set ADMIN_PASSWORD for production.');
}
$email = V::email($argv[1]);
$name = V::text($argv[2] ?? 'Platform administrator', 'Administrator name', 2, 120);
if (env('APP_ENV') === 'production' && !env('ADMIN_PASSWORD')) {
    fwrite(STDERR, "Set ADMIN_PASSWORD explicitly when provisioning a production administrator.\n");
    exit(1);
}
$password = env('ADMIN_PASSWORD') ?: bin2hex(random_bytes(12)) . '!Aa';
V::password($password);
if (DB::value('SELECT 1 FROM users WHERE email=?', [$email])) {
    echo "That account already exists.\n";
    exit(1);
}
$id = DB::transaction(function () use ($email, $name, $password) {
    $role = DB::value("SELECT id FROM roles WHERE name='administrator'");
    if (!$role) {
        throw new RuntimeException('Run bin/migrate.php before provisioning an administrator.');
    }
    $id = DB::insert('INSERT INTO users(full_name,email,password_hash,role_id,email_verified_at,terms_accepted_at,onboarding_completed_at,timezone) VALUES(?,?,?,?,UTC_TIMESTAMP(),UTC_TIMESTAMP(),UTC_TIMESTAMP(),?)', [$name,$email,password_hash($password, PASSWORD_ARGON2ID),$role,env('DEFAULT_TIMEZONE', 'UTC')]);
    DB::run('INSERT INTO user_preferences(user_id) VALUES(?)', [$id]);
    DB::run('INSERT INTO study_schedules(user_id) VALUES(?)', [$id]);
    DB::run('INSERT INTO notification_preferences(user_id) VALUES(?)', [$id]);
    DB::run('INSERT INTO referral_codes(user_id,code) VALUES(?,?)', [$id,strtoupper(bin2hex(random_bytes(8)))]);
    audit($id, 'administrator.bootstrap', 'users', $id);
    return $id;
});
$loginUrl = route_url('/login');
$adminUrl = route_url('/admin');
$registerUrl = route_url('/register');
if (env('APP_ENV') !== 'production') {
    file_put_contents(ROOT . '/LOCAL_ACCESS.md', "# Local preview access\n\nDevelopment-only administrator account. Do not reuse in production.\n\n- Sign in: `$loginUrl`\n- Email: `$email`\n- Password: `$password`\n- Administration: `$adminUrl`\n\nRegister a separate learner at `$registerUrl` to test onboarding and learning. The learner account starts with zero progress.\n\nSMTP is disabled in this local preview. No email delivery is claimed. Production requires a configured SMTP provider, HTTPS, new secrets and a newly provisioned administrator.\n");
    chmod(ROOT . '/LOCAL_ACCESS.md', 0600);
    echo "Administrator created. Local-only credentials saved in LOCAL_ACCESS.md.\n";
} else {
    echo "Administrator created.\n";
}
