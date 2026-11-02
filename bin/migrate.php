<?php

require __DIR__ . '/bootstrap.php';
$status = false;
$retry = null;
foreach (array_slice($argv, 1) as $option) {
    if ($option === '--status') {
        $status = true;
    } elseif (str_starts_with($option, '--retry=')) {
        $retry = substr($option, 8);
    } else {
        throw new InvalidArgumentException('Usage: php bin/migrate.php [--status] [--retry=NNN_name.sql]');
    }
}
foreach (\Learnow\Services\MigrationService::run(statusOnly: $status, retry: $retry) as $row) {
    echo $row['migration'] . ': ' . $row['status'] . "\n";
}
