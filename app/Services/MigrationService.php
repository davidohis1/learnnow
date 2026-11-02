<?php

declare(strict_types=1);

namespace Learnow\Services;

use Learnow\Repositories\DB;
use Learnow\Helpers\ErrorHandler;

/** MySQL DDL is not transactional. Persist intent before executing and never silently rerun a partial migration. */
final class MigrationService
{
    private static function tracking(): void
    {
        DB::run('CREATE TABLE IF NOT EXISTS schema_migrations (version VARCHAR(120) PRIMARY KEY, applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, checksum CHAR(64) NULL, status VARCHAR(12) NOT NULL DEFAULT \'applied\', failure_reference CHAR(12) NULL) ENGINE=InnoDB');
        $columns = array_column(DB::all('SHOW COLUMNS FROM schema_migrations'), 'Field');
        foreach (['checksum' => 'CHAR(64) NULL', 'status' => "VARCHAR(12) NOT NULL DEFAULT 'applied'", 'failure_reference' => 'CHAR(12) NULL'] as $column => $definition) {
            if (!in_array($column, $columns, true)) {
                DB::run('ALTER TABLE schema_migrations ADD ' . $column . ' ' . $definition);
            }
        }
    }

    public static function run(?string $directory = null, bool $statusOnly = false, ?string $retry = null): array
    {
        $directory ??= ROOT . '/database/migrations';
        $lock = 'learnow:migrate:' . substr(hash('sha256', (string)DB::value('SELECT DATABASE()')), 0, 32);
        if (!DB::value('SELECT GET_LOCK(?, 0)', [$lock])) {
            throw new \RuntimeException('Another migration runner holds this database lock. Try again after it finishes.');
        }
        try {
            self::tracking();
            $files = glob($directory . '/*.sql') ?: [];
            sort($files, SORT_STRING);
            $names = array_map('basename', $files);
            if ($retry !== null && !in_array($retry, $names, true)) {
                throw new \RuntimeException('The --retry migration does not exist.');
            }
            $records = array_column(DB::all('SELECT * FROM schema_migrations'), null, 'version');
            foreach ($records as $name => $record) {
                if (!in_array($name, $names, true)) {
                    throw new \RuntimeException('An applied/attempted migration file is missing: ' . $name);
                }
            }
            $result = [];
            foreach ($files as $file) {
                $name = basename($file);
                if (!preg_match('/^\d{3}_[a-z0-9_]+\.sql$/D', $name)) {
                    throw new \RuntimeException('Invalid migration filename: ' . $name);
                }
                $hash = hash_file('sha256', $file);
                $record = $records[$name] ?? null;
                if ($record && $record['checksum'] && !hash_equals($record['checksum'], $hash)) {
                    throw new \RuntimeException('Migration checksum changed: ' . $name . '. Restore the original file; add a new migration instead.');
                }
                if ($record && !$record['checksum']) {
                    DB::run('UPDATE schema_migrations SET checksum=? WHERE version=?', [$hash, $name]);
                }
                if ($record && $record['status'] === 'applied') {
                    $result[] = ['migration' => $name, 'status' => 'already applied'];
                    continue;
                }
                if ($statusOnly) {
                    $result[] = ['migration' => $name, 'status' => $record['status'] ?? 'pending'];
                    continue;
                }
                if ($record && $retry !== $name) {
                    throw new \RuntimeException('Migration ' . $name . ' is ' . $record['status'] . '. Inspect the private diagnostic and repair/restore partial DDL before explicitly using --retry=' . $name . '.');
                }
                DB::run("INSERT INTO schema_migrations(version,checksum,status) VALUES(?,?,'running') ON DUPLICATE KEY UPDATE status='running',failure_reference=NULL", [$name, $hash]);
                try {
                    DB::pdo()->exec(file_get_contents($file));
                    DB::run("UPDATE schema_migrations SET status='applied',applied_at=UTC_TIMESTAMP(),failure_reference=NULL WHERE version=?", [$name]);
                    $result[] = ['migration' => $name, 'status' => 'applied'];
                } catch (\Throwable $error) {
                    $reference = ErrorHandler::log($error);
                    DB::run("UPDATE schema_migrations SET status='failed',failure_reference=? WHERE version=?", [$reference, $name]);
                    throw new \RuntimeException('Migration failed: ' . $name . '. Reference: ' . $reference . '. MySQL DDL can partially commit; restore or reconcile before retrying.', 0, $error);
                }
            }
            return $result;
        } finally {
            DB::value('SELECT RELEASE_LOCK(?)', [$lock]);
        }
    }
}
