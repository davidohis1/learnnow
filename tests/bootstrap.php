<?php
if (PHP_SAPI !== 'cli') { http_response_code(404); exit; }
// Test SQL/service helpers must never inherit live SMTP delivery settings.
putenv('MAIL_ENABLED=false');
putenv('DB_DATABASE='.(getenv('LEARNOW_TEST_DATABASE')?:'learnow_test'));
require dirname(__DIR__).'/app/bootstrap.php';
if(!str_ends_with(env('DB_DATABASE'),'_test'))throw new RuntimeException('Tests require an isolated database ending in _test.');
if(env('APP_ENV')==='production')throw new RuntimeException('Never run these tests with production configuration.');
function fixtureUser(string $label,string $role='learner',string $timezone='Africa/Lagos'):int{
    $email=strtolower(preg_replace('/[^a-z0-9]+/i','-',$label)).'-'.bin2hex(random_bytes(4)).'@test.learnow.invalid';
    $uid=\Learnow\Repositories\DB::insert('INSERT INTO users(full_name,email,password_hash,role_id,terms_accepted_at,timezone,onboarding_completed_at) VALUES(?,?,?,?,UTC_TIMESTAMP(),?,UTC_TIMESTAMP())',[$label,$email,password_hash('Test-Only-Learnow-2026!',PASSWORD_ARGON2ID),\Learnow\Repositories\DB::value('SELECT id FROM roles WHERE name=?',[$role]),$timezone]);
    \Learnow\Repositories\DB::run('INSERT INTO user_preferences(user_id) VALUES(?)',[$uid]);\Learnow\Repositories\DB::run('INSERT INTO study_schedules(user_id) VALUES(?)',[$uid]);\Learnow\Repositories\DB::run('INSERT INTO notification_preferences(user_id) VALUES(?)',[$uid]);\Learnow\Repositories\DB::run('INSERT INTO referral_codes(user_id,code) VALUES(?,?)',[$uid,strtoupper(bin2hex(random_bytes(5)))]);return $uid;
}
