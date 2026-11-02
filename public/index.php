<?php

declare(strict_types=1);

use Learnow\Helpers\{ErrorHandler, HttpError, Url};
use Learnow\Middleware\Security;

// Catch configuration and dependency failures too, before bootstrap can throw.
require_once dirname(__DIR__) . '/app/Helpers/ErrorHandler.php';
ini_set('display_errors', '0');
ob_start();
try {
    require_once dirname(__DIR__) . '/app/bootstrap.php';
    Security::headers();
    $path = Url::routePath($_SERVER['REQUEST_URI'] ?? '/');
    if ($path === null) {
        abort(404, 'This address is outside the configured application.');
    }
    if ((int)($_SERVER['CONTENT_LENGTH'] ?? 0) > 6 * 1024 * 1024) {
        abort(413, 'Maximum request size is 6 MB.');
    }
    $method = strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');
    if (\Learnow\Services\AssetService::serve($path, $method)) {
        return;
    }
    if (in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE'], true)) {
        Security::verifyCsrf();
    } else {
        csrf();
    }
    $router = new Learnow\Helpers\Router();
    require ROOT . '/routes/web.php';
    require ROOT . '/routes/api.php';
    $router->dispatch($method, $path);
} catch (HttpError $e) {
    if (wantsJson()) {
        jsonResponse(['ok' => false, 'message' => $e->getMessage(), 'fields' => $e->fields], $e->status);
    }
    http_response_code($e->status);
    try {
        render('error', ['title' => 'Let’s get you back on track', 'code' => $e->status, 'message' => $e->getMessage()], 'public');
    } catch (Throwable $renderError) {
        ErrorHandler::respond($renderError);
    }
} catch (Throwable $e) {
    ErrorHandler::respond($e);
}
