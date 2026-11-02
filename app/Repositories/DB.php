<?php

namespace Learnow\Repositories;

use PDO;

final class DB
{
    private static ?PDO $connection = null;
    private static int $savepointCounter = 0;
    public static function pdo(): PDO
    {
        if (!self::$connection) {
            $c = require ROOT . '/config/database.php';
            self::$connection = new PDO($c['dsn'], $c['username'], $c['password'], [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES => false]);
            self::$connection->exec("SET time_zone = '+00:00'");
        }
        return self::$connection;
    }
    public static function run(string $sql, array $params = []): \PDOStatement
    {
        $s = self::pdo()->prepare($sql);
        $s->execute($params);
        return $s;
    }
    public static function all(string $sql, array $params = []): array
    {
        return self::run($sql, $params)->fetchAll();
    }
    public static function one(string $sql, array $params = []): ?array
    {
        return self::run($sql, $params)->fetch() ?: null;
    }
    public static function value(string $sql, array $params = []): mixed
    {
        return self::run($sql, $params)->fetchColumn();
    }
    public static function insert(string $sql, array $params = []): int
    {
        self::run($sql, $params);
        return (int)self::pdo()->lastInsertId();
    }
    public static function transaction(callable $fn): mixed
    {
        if (self::pdo()->inTransaction()) {
            $savepoint = 'learnow_' . ++self::$savepointCounter;
            self::pdo()->exec('SAVEPOINT ' . $savepoint);
            try {
                $result = $fn();
                self::pdo()->exec('RELEASE SAVEPOINT ' . $savepoint);
                return $result;
            } catch (\Throwable $e) {
                self::pdo()->exec('ROLLBACK TO SAVEPOINT ' . $savepoint);
                self::pdo()->exec('RELEASE SAVEPOINT ' . $savepoint);
                throw $e;
            }
        }
        self::pdo()->beginTransaction();
        try {
            $result = $fn();
            self::pdo()->commit();
            return $result;
        } catch (\Throwable $e) {
            if (self::pdo()->inTransaction()) {
                self::pdo()->rollBack();
            } throw $e;
        }
    }
}
