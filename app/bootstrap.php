<?php

declare(strict_types=1);

if (!defined('ROOT')) {
    define('ROOT', dirname(__DIR__));
}
if (!is_file(ROOT . '/vendor/autoload.php')) {
    throw new RuntimeException('Production dependencies are missing. Run composer install --no-dev.');
}
require_once ROOT . '/vendor/autoload.php';
Learnow\Helpers\Environment::load(ROOT . '/.env');
date_default_timezone_set('UTC');
require_once ROOT . '/app/Helpers/functions.php';
Learnow\Helpers\Environment::validate();
