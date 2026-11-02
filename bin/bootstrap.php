<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
require_once dirname(__DIR__) . '/app/Helpers/ErrorHandler.php';
set_exception_handler(static function (Throwable $error): void {
    $reference = \Learnow\Helpers\ErrorHandler::log($error);
    fwrite(STDERR, \Learnow\Helpers\ErrorHandler::safeMessage($error) . "\nReference: " . $reference . ". Inspect storage/logs/application.log.\n");
    exit(1);
});
require_once dirname(__DIR__) . '/app/bootstrap.php';
