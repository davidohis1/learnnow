<?php

require __DIR__ . '/bootstrap.php';
use Learnow\Repositories\DB;
use Learnow\Helpers\Url;
$errors = [];
echo 'PHP ' . PHP_VERSION . ": required extensions and Argon2id are available.\n";
echo 'Application base: ' . Url::base() . "\n";
echo 'Cookie path: ' . (Url::basePath() ?: '') . "/\n";
echo "Private upload/log/mail directories: writable.\n";
$version = (string)DB::value('SELECT VERSION()');
$minimum = stripos($version, 'MariaDB') !== false ? '10.6' : '8.0';
if (!version_compare($version, $minimum, '>=')) {
    $errors[] = 'Unsupported database version: ' . $version;
}
echo 'Database connection: OK (' . $version . ").\n";
$tables = array_column(DB::all('SELECT TABLE_NAME AS name FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE()'), 'name');
$required = [];
foreach (glob(ROOT . '/database/migrations/*.sql') as $file) {
    preg_match_all('/CREATE TABLE(?: IF NOT EXISTS)?\s+([a-z_]+)\s*\(/i', file_get_contents($file), $matches);
    $required = array_merge($required, $matches[1]);
}
foreach (array_unique($required) as $table) {
    if (!in_array($table, $tables, true)) {
        $errors[] = 'Missing table: ' . $table;
    }
}
if (in_array('schema_migrations', $tables, true)) {
    $columns = array_column(DB::all('SHOW COLUMNS FROM schema_migrations'), 'Field');
    if (!in_array('status', $columns, true)) {
        $errors[] = 'Migration tracking must be upgraded; run bin/migrate.php.';
    } else {
        $applied = array_column(DB::all('SELECT * FROM schema_migrations'), null, 'version');
        foreach (glob(ROOT . '/database/migrations/*.sql') as $file) {
            $row = $applied[basename($file)] ?? null;
            if (!$row || $row['status'] !== 'applied' || $row['checksum'] !== hash_file('sha256', $file)) {
                $errors[] = 'Missing, incomplete or changed migration: ' . basename($file);
            }
        }
    }
}
if (in_array('roles', $tables, true)) {
    foreach (['learner', 'administrator', 'reviewer'] as $role) {
        if (!DB::value('SELECT 1 FROM roles WHERE name=?', [$role])) {
                $errors[] = 'Missing required role: ' . $role;
        }
    }
}
if ($errors) {
    foreach ($errors as $error) {
        fwrite(STDERR, 'FAIL: ' . $error . "\n");
    }
    exit(1);
}
echo count(array_unique($required)) . " required tables and all migration checksums: OK.\n";
echo "Essential authentication roles: OK.\n";
echo filter_var(env('MAIL_ENABLED'), FILTER_VALIDATE_BOOL) ? "SMTP configured; actual delivery still needs a live verification/reset test.\n" : "NOTICE: SMTP disabled. Email verification/reset delivery is unavailable.\n";
echo "Deployment preflight passed. Verify the web PHP version/upload limits, HTTPS, cron and HTTP private-file protection separately.\n";
