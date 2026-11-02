# Changed-file manifest — Learnow portability/deployment refactor

## Verified application/configuration/documentation changes

Compared file contents against `tests/refactor/before-hashes.json`, captured before the refactor: **90 modified files, 16 added files, 0 deleted files** in the source/configuration/documentation scope. Unchanged files are omitted. Private environment/data files, installed dependencies, logs, backups and generated screenshots are not source-code changes and are not distributed.

The JSON companion at `tests/refactor/changed-files.json` includes before/after SHA-256 values where available. This manifest deliberately omits its own self-referential checksum.

| Status | File |
|---|---|
| Modified | `.env.example` |
| Modified | `.gitignore` |
| Added | `.htaccess` |
| Modified | `IMPLEMENTATION.md` |
| Modified | `README.md` |
| Modified | `app/Controllers/AdminApiController.php` |
| Modified | `app/Controllers/AuthController.php` |
| Added | `app/Helpers/Environment.php` |
| Added | `app/Helpers/ErrorHandler.php` |
| Modified | `app/Helpers/Router.php` |
| Added | `app/Helpers/Url.php` |
| Modified | `app/Helpers/functions.php` |
| Modified | `app/Helpers/icons.php` |
| Modified | `app/Middleware/Auth.php` |
| Modified | `app/Middleware/Security.php` |
| Modified | `app/Repositories/DB.php` |
| Modified | `app/Services/AdminContentService.php` |
| Added | `app/Services/AssetService.php` |
| Modified | `app/Services/AssignmentService.php` |
| Modified | `app/Services/JobService.php` |
| Added | `app/Services/MigrationService.php` |
| Modified | `app/Services/NotificationService.php` |
| Modified | `app/Services/QuizService.php` |
| Modified | `app/Services/ReportService.php` |
| Modified | `app/Views/components/admin-content-tabs.php` |
| Modified | `app/Views/components/head.php` |
| Modified | `app/Views/components/path-card.php` |
| Modified | `app/Views/components/sidebar.php` |
| Modified | `app/Views/layouts/admin.php` |
| Modified | `app/Views/layouts/app.php` |
| Modified | `app/Views/layouts/auth.php` |
| Modified | `app/Views/layouts/onboarding.php` |
| Modified | `app/Views/layouts/public.php` |
| Modified | `app/Views/pages/achievements.php` |
| Modified | `app/Views/pages/admin-audit.php` |
| Modified | `app/Views/pages/admin-certificates.php` |
| Modified | `app/Views/pages/admin-community.php` |
| Modified | `app/Views/pages/admin-content.php` |
| Modified | `app/Views/pages/admin-dashboard.php` |
| Modified | `app/Views/pages/admin-editor.php` |
| Modified | `app/Views/pages/admin-quiz-review.php` |
| Modified | `app/Views/pages/admin-referrals.php` |
| Modified | `app/Views/pages/admin-reports.php` |
| Modified | `app/Views/pages/admin-review.php` |
| Modified | `app/Views/pages/admin-reviews.php` |
| Modified | `app/Views/pages/admin-rewards.php` |
| Modified | `app/Views/pages/admin-settings.php` |
| Modified | `app/Views/pages/admin-user.php` |
| Modified | `app/Views/pages/admin-users.php` |
| Modified | `app/Views/pages/assignment.php` |
| Modified | `app/Views/pages/assignments.php` |
| Modified | `app/Views/pages/auth.php` |
| Modified | `app/Views/pages/catalogue.php` |
| Modified | `app/Views/pages/certificate.php` |
| Modified | `app/Views/pages/certificates.php` |
| Modified | `app/Views/pages/community.php` |
| Modified | `app/Views/pages/dashboard.php` |
| Modified | `app/Views/pages/error.php` |
| Modified | `app/Views/pages/info.php` |
| Modified | `app/Views/pages/landing.php` |
| Modified | `app/Views/pages/lesson.php` |
| Modified | `app/Views/pages/my-learning.php` |
| Modified | `app/Views/pages/notifications.php` |
| Modified | `app/Views/pages/onboarding.php` |
| Modified | `app/Views/pages/path.php` |
| Modified | `app/Views/pages/peer-review.php` |
| Modified | `app/Views/pages/portfolio.php` |
| Modified | `app/Views/pages/project-editor.php` |
| Modified | `app/Views/pages/project.php` |
| Modified | `app/Views/pages/quiz.php` |
| Modified | `app/Views/pages/referrals.php` |
| Modified | `app/Views/pages/reports.php` |
| Modified | `app/Views/pages/settings.php` |
| Modified | `app/Views/pages/verify-email.php` |
| Modified | `app/bootstrap.php` |
| Added | `bin/bootstrap.php` |
| Added | `bin/check.php` |
| Modified | `bin/create-admin.php` |
| Modified | `bin/migrate.php` |
| Modified | `bin/scheduled-jobs.php` |
| Modified | `bin/seed.php` |
| Modified | `composer.json` |
| Modified | `composer.lock` |
| Modified | `config/app.php` |
| Modified | `config/database.php` |
| Added | `database/migrations/006_installation_baseline.sql` |
| Added | `database/migrations/007_outbox_logical_links.sql` |
| Modified | `deployment/nginx.conf.example` |
| Modified | `docs/ARCHITECTURE.md` |
| Added | `docs/CHANGED_FILES.md` |
| Modified | `docs/DEPLOYMENT.md` |
| Modified | `docs/FEATURES.md` |
| Added | `docs/QA.md` |
| Added | `docs/REFACTOR_REPORT.md` |
| Modified | `docs/SECURITY.md` |
| Added | `docs/URLS.md` |
| Added | `index.php` |
| Modified | `public/.htaccess` |
| Modified | `public/assets/css/fonts.css` |
| Modified | `public/assets/js/api.js` |
| Modified | `public/assets/js/app.js` |
| Modified | `public/assets/js/learning.js` |
| Modified | `public/assets/js/onboarding.js` |
| Added | `public/assets/js/url.js` |
| Modified | `public/index.php` |
| Modified | `public/router.php` |

## Test tools

Test scripts were not included in the initial 134-file source hash snapshot. The following existing test tools were updated for isolated-database targeting, safe SMTP defaults, absolute URL assertions, prefixed/browser form handling and the new standard CSRF status. No unavailable historical checksum is invented for them.

- Updated: `tests/bootstrap.php`
- Updated: `tests/fixtures.php`
- Updated: `tests/business-rules.php`
- Updated: `tests/http_integration.py`
- Updated: `tests/browser_checks.py`
- Updated: `tests/README.md`

New test tools:

- Added: `tests/url-rules.php`
- Added: `tests/url-rules.mjs`
- Added: `tests/installation_checks.php`
- Added: `tests/apache_setup.py`
- Added: `tests/deployment_checks.py`
- Added: `tests/url_source_audit.py`

## Generated evidence

These generated inputs/reports are separately identified, rather than described as application logic. Generic top-level test results and screenshots are also refreshed by the runners; the layout-specific evidence below preserves the final comparable results.

- `tests/refactor/accessibility-apache.json`
- `tests/refactor/accessibility-prefix.json`
- `tests/refactor/accessibility-root.json`
- `tests/refactor/before-hashes.json`
- `tests/refactor/browser-apache-results.json`
- `tests/refactor/browser-apache-results.txt`
- `tests/refactor/browser-prefix-results.json`
- `tests/refactor/browser-prefix-results.txt`
- `tests/refactor/browser-root-results.json`
- `tests/refactor/browser-root-results.txt`
- `tests/refactor/business-results.txt`
- `tests/refactor/composer-audit.txt`
- `tests/refactor/composer-install.txt`
- `tests/refactor/composer-platform.txt`
- `tests/refactor/composer-validate.txt`
- `tests/refactor/deployment-results.json`
- `tests/refactor/deployment-results.txt`
- `tests/refactor/http-apache-results.json`
- `tests/refactor/http-apache-results.txt`
- `tests/refactor/http-prefix-results.json`
- `tests/refactor/http-prefix-results.txt`
- `tests/refactor/http-root-results.json`
- `tests/refactor/http-root-results.txt`
- `tests/refactor/installation-results.json`
- `tests/refactor/installation-results.txt`
- `tests/refactor/jobs-first.json`
- `tests/refactor/jobs-second.json`
- `tests/refactor/php-lint.txt`
- `tests/refactor/registration-after.json`
- `tests/refactor/registration-before.json`
- `tests/refactor/source-audit.json`
- `tests/refactor/source-audit.txt`
- `tests/refactor/template-url-changes.json`
- `tests/refactor/url-cases.json`
- `tests/refactor/url-invalid-bases.json`
- `tests/refactor/url-inventory-before.json`
- `tests/refactor/url-js-results.json`
- `tests/refactor/url-js-results.txt`
- `tests/refactor/url-php-results.json`
- `tests/refactor/url-php-results.txt`

- `tests/refactor/changed-files.json` — this source-change inventory, with provenance.
- `Learnow-deployment.zip` — secret-free distributable generated after verification, plus its external SHA-256 file.

Existing main data was preserved. Applied schema additions are migrations 006/007 and the runner's migration-tracking metadata; there is no fabricated learner activity in the main database. Mandatory role/permission data is separate from the optional curriculum seed.
