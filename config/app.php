<?php

return ['name' => env('APP_NAME', 'Learnow'), 'url' => \Learnow\Helpers\Url::base(), 'timezone' => env('DEFAULT_TIMEZONE', 'UTC'), 'mail_enabled' => filter_var(env('MAIL_ENABLED', 'false'), FILTER_VALIDATE_BOOL)];
