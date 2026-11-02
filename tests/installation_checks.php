<?php

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
// Explicit opt-in to this disposable database; never substitute the live name.
if (!str_ends_with(getenv('LEARNOW_TEST_DATABASE') ?: '', '_migration_test')) {
    throw new RuntimeException('Use LEARNOW_TEST_DATABASE=learnow_migration_test for this isolated installation test.');
}
require __DIR__ . '/bootstrap.php';
use Learnow\Repositories\DB;
use Learnow\Services\MigrationService;
use Learnow\Helpers\Environment;
$checks = [];
function installationCheck(bool $ok, string $name): void
{
    global $checks;
    $checks[] = ['passed' => $ok,'name' => $name];
    echo ($ok ? 'PASS ' : 'FAIL ') . $name . "\n";
}
function commandCheck(array $args, array $changes = []): array
{
    $process = proc_open($args, [0 => ['pipe','r'],1 => ['pipe','w'],2 => ['pipe','w']], $pipes, ROOT, array_merge(getenv(), $changes));
    fclose($pipes[0]);
    $out = stream_get_contents($pipes[1]);
    $err = stream_get_contents($pipes[2]);
    fclose($pipes[1]);
    fclose($pipes[2]);
    return [proc_close($process),$out,$err];
}
function columnsFrom(string $body): array
{
    $parts = [];
    $start = 0;
    $depth = 0;
    $quote = null;
    for ($i = 0; $i < strlen($body); $i++) {
        $c = $body[$i];
        if ($quote !== null) {
            if ($c === '\\') {
                $i++;
                continue;
            }if ($c === $quote) {
                $quote = null;
            }continue;
        }
        if ($c === "'" || $c === '"') {
            $quote = $c;
            continue;
        }
        if ($c === '(') {
            $depth++;
        } elseif ($c === ')') {
            $depth--;
        } elseif ($c === ',' && $depth === 0) {
            $parts[] = substr($body, $start, $i - $start);
            $start = $i + 1;
        }
    }
    $parts[] = substr($body, $start);
    return $parts;
}
try {
    $before = (int)DB::value('SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE()');
    $run = MigrationService::run();
    installationCheck(count($run) === 7 && count(array_filter($run, fn($r)=>in_array($r['status'], ['applied','already applied'], true))) === 7, 'All seven migrations run in sorted order');
    installationCheck($before === 0 || count(array_filter($run, fn($r)=>$r['status'] === 'already applied')) === 7, 'Fresh schema or an explicitly repeatable isolated installation');
    $again = MigrationService::run();
    installationCheck(count(array_filter($again, fn($r)=>$r['status'] === 'already applied')) === 7, 'A second migration run does not rerun completed files');
    installationCheck((int)DB::value('SELECT COUNT(*) FROM schema_migrations WHERE status=\'applied\' AND LENGTH(checksum)=64') === 7, 'Applied migrations retain checksums and completion state');
    installationCheck((int)DB::value("SELECT COUNT(*) FROM roles WHERE name IN ('learner','administrator','reviewer')") === 3, 'Migrations install essential roles without curriculum seeding');
    installationCheck((int)DB::value("SELECT COUNT(*) FROM role_permissions rp JOIN roles r ON r.id=rp.role_id WHERE r.name='administrator'") === 9, 'Administrator permissions use actual role IDs');
    $source = implode("\n", array_map('file_get_contents', glob(ROOT . '/database/migrations/*.sql')));
    preg_match_all('/CREATE TABLE(?: IF NOT EXISTS)?\s+([a-z_]+)\s*\((.*?)\);/is', $source, $matches, PREG_SET_ORDER);
    $expected = [];
    foreach ($matches as $m) {
        foreach (columnsFrom($m[2]) as $part) {
            if (preg_match('/^\s*([a-z_]+)\s+/i', $part, $c) && !in_array(strtoupper($c[1]), ['PRIMARY','FOREIGN','UNIQUE','CHECK','INDEX','CONSTRAINT','KEY'], true)) {
                $expected[$m[1]][] = $c[1];
            }
        }
    }
    preg_match_all('/ALTER TABLE\s+([a-z_]+)\s+(.*?);/is', $source, $alters, PREG_SET_ORDER);
    foreach ($alters as $alter) {
        foreach (columnsFrom($alter[2]) as $part) {
            if (preg_match('/^\s*ADD\s+(?:COLUMN\s+)?([a-z_]+)\s+/i', $part, $m) && strtoupper($m[1]) !== 'CONSTRAINT') {
                $expected[$alter[1]][] = $m[1];
            }
        }
    }
    $expected['schema_migrations'] = array_merge($expected['schema_migrations'], ['checksum','status','failure_reference']);
    foreach ($expected as $table => $columns) {
        $actual = array_column(DB::all('SHOW COLUMNS FROM `' . $table . '`'), 'Field');
        sort($columns);
        sort($actual);
        installationCheck($columns === $actual, 'Migration/schema column contract: ' . $table);
    }
    installationCheck((int)DB::value('SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE()') === count($expected), 'No missing or unexpected application tables');
    preg_match_all('/FOREIGN KEY\s*\(/i', $source, $foreign);
    installationCheck((int)DB::value('SELECT COUNT(*) FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA=DATABASE()') === count($foreign[0]), 'All declared foreign-key relationships are installed');
    [$status] = commandCheck([PHP_BINARY,'bin/seed.php']);
    installationCheck($status === 0, 'Optional curriculum seed succeeds after baseline migrations');
    $paths = (int)DB::value('SELECT COUNT(*) FROM learning_paths');
    $lessons = (int)DB::value('SELECT COUNT(*) FROM lessons');
    [$status] = commandCheck([PHP_BINARY,'bin/seed.php']);
    installationCheck($status === 0 && $paths === (int)DB::value('SELECT COUNT(*) FROM learning_paths') && $lessons === (int)DB::value('SELECT COUNT(*) FROM lessons'), 'Repeated curriculum seed preserves existing content');
    installationCheck($paths === 3 && $lessons === 14 && (int)DB::value('SELECT COUNT(*) FROM users') === 0 && (int)DB::value('SELECT COUNT(*) FROM activity_events') === 0, 'Starter content contains no fabricated users or learning activity');
    $dir = ROOT . '/storage/qa-migrations';
    if (!is_dir($dir)) {
        mkdir($dir, 0700, true);
    }foreach (glob($dir . '/*.sql') as $f) {
        unlink($f);
    }
    foreach (glob(ROOT . '/database/migrations/*.sql') as $file) {
        copy($file, $dir . '/' . basename($file));
    }
    file_put_contents($dir . '/003_reviewers.sql', "\n-- unexpected edit", FILE_APPEND);
    $blocked = false;
    try {
        MigrationService::run($dir);
    } catch (RuntimeException $e) {
        $blocked = str_contains($e->getMessage(), 'checksum');
    }
    installationCheck($blocked, 'Changed migration checksum is rejected');
    copy(ROOT . '/database/migrations/003_reviewers.sql', $dir . '/003_reviewers.sql');
    DB::run('CREATE TABLE qa_conflict(id INT PRIMARY KEY)');
    file_put_contents($dir . '/008_failure_probe.sql', 'CREATE TABLE qa_partial(id INT PRIMARY KEY); CREATE TABLE qa_conflict(id INT PRIMARY KEY);');
    $failed = false;
    try {
        MigrationService::run($dir);
    } catch (RuntimeException $e) {
        $failed = str_contains($e->getMessage(), 'Migration failed');
    }
    installationCheck($failed && DB::value("SELECT status FROM schema_migrations WHERE version='008_failure_probe.sql'") === 'failed', 'Partial DDL failure is recorded, not falsely marked applied');
    installationCheck((bool)DB::value("SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='qa_partial'"), 'The test exercises real MySQL implicit DDL commits');
    installationCheck((bool)preg_match('/^[0-9a-f]{12}$/D', (string)DB::value("SELECT failure_reference FROM schema_migrations WHERE version='008_failure_probe.sql'")), 'Failed migration retains its private diagnostic reference');
    $blocked = false;
    try {
        MigrationService::run($dir);
    } catch (RuntimeException $e) {
        $blocked = str_contains($e->getMessage(), 'before explicitly');
    }
    installationCheck($blocked, 'A failed migration is not silently rerun');
    // Reconcile only these two disposable test tables, then retry the unchanged file.
    DB::run('DROP TABLE qa_partial');
    DB::run('DROP TABLE qa_conflict');
    MigrationService::run($dir, retry:'008_failure_probe.sql');
    installationCheck(DB::value("SELECT status FROM schema_migrations WHERE version='008_failure_probe.sql'") === 'applied', 'Explicit retry succeeds after a reconciled partial DDL failure');
    DB::run('DROP TABLE qa_partial');
    DB::run('DROP TABLE qa_conflict');
    DB::run("DELETE FROM schema_migrations WHERE version='008_failure_probe.sql'");
    unlink($dir . '/008_failure_probe.sql');
    DB::pdo()->beginTransaction();
    DB::transaction(function () {
        DB::run("INSERT INTO categories(name,slug,description) VALUES('QA outer before','qa-before','test')");
        try {
            DB::transaction(function () {
                DB::run("INSERT INTO categories(name,slug,description) VALUES('QA inner rollback','qa-inner','test')");
                throw new RuntimeException('expected inner rollback');
            });
        } catch (RuntimeException) {
        }DB::run("INSERT INTO categories(name,slug,description) VALUES('QA outer after','qa-after','test')");
    });
    installationCheck((int)DB::value("SELECT COUNT(*) FROM categories WHERE slug IN ('qa-before','qa-after')") === 2 && !DB::value("SELECT 1 FROM categories WHERE slug='qa-inner'"), 'Nested transactions use real savepoint rollback while preserving outer work');
    DB::pdo()->rollBack();
    [$status] = commandCheck([PHP_BINARY,'-d','disable_functions=putenv','-r','require "app/bootstrap.php"; echo route_url("/login");']);
    installationCheck($status === 0, 'Bootstrap works on hosts with putenv disabled');
    foreach (
        [
        ['APP_ENV' => 'production','APP_URL' => 'http://example.test','COOKIE_SECURE' => 'true'],
        ['APP_ENV' => 'production','APP_URL' => 'https://example.test','COOKIE_SECURE' => 'false'],
        ['APP_KEY' => 'short'],['APP_KEY' => str_repeat('a', 64)],['DEFAULT_TIMEZONE' => 'Invalid/Zone'],['DB_PORT' => 'abc'],['APP_URL' => 'https://example.test/?query=1'],['MAIL_ENABLED' => 'true','MAIL_HOST' => '','MAIL_FROM' => ''],['DB_DATABASE' => ''],['APP_ENV' => 'not-a-mode']
        ] as $i => $changes
    ) {
        $code = '';
        foreach ($changes as $key => $value) {
            if ($value === '') {
                $code .= 'putenv(' . var_export($key . '=', true) . ');';
            }
        }$code .= 'require "app/bootstrap.php";';
        [$status] = commandCheck([PHP_BINARY,'-r',$code], $changes);
        installationCheck($status !== 0, 'Invalid configuration fails closed: case ' . ($i + 1));
    }
    [$status] = commandCheck([PHP_BINARY,'bin/check.php']);
    installationCheck($status === 0, 'Deployment preflight performs a real schema/database check');
    $file = ROOT . '/storage/qa-env-test';
    file_put_contents($file, "\xEF\xBB\xBF# environment parser test\nQA_VALUE=\"with # and = signs\" # trailing comment with \"quotes\"\nQA_LITERAL='dollar $ and # stay literal'\nQA_EMPTY=\n");
    Environment::load($file);
    installationCheck(Environment::get('QA_VALUE') === 'with # and = signs' && Environment::get('QA_LITERAL') === 'dollar $ and # stay literal' && Environment::get('QA_EMPTY', 'fallback') === '', 'Environment parsing preserves quoted secrets, comments, BOM and empty values');
    Environment::load(ROOT . '/.env');
    unlink($file);
} catch (Throwable $e) {
    if (DB::pdo()->inTransaction()) {
        DB::pdo()->rollBack();
    }
    installationCheck(false, 'Unexpected installation-test exception: ' . $e->getMessage());
} finally {
    $passed = count(array_filter($checks, fn($c)=>$c['passed']));
    $failed = count($checks) - $passed;
    file_put_contents(__DIR__ . '/refactor/installation-results.json', json_encode(['passed' => $passed,'failed' => $failed,'checks' => $checks], JSON_PRETTY_PRINT));
    echo "\n$passed passed; $failed failed.\n";
    exit($failed ? 1 : 0);
}
