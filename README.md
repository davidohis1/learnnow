# Learnow
## Learn today. Build tomorrow.

A database-backed learning platform built with **core PHP 8.2+, PDO, MySQL/MariaDB, vanilla JavaScript and custom CSS**. No application framework or Node backend.

## Portable deployment

**`APP_URL` is the full canonical application base URL.** Domain-root and nested-subdirectory installations use the same application files. Changing the configured host, scheme or path prefix does not require editing templates, JavaScript or route definitions.

```dotenv
APP_URL=https://example.com
# or:
APP_URL=https://example.com/academy/skills
```

Internal links, form actions, redirects, API calls, canonical metadata, shares, certificate verification and email links use the central URL service. The router removes the configured prefix before matching logical routes. Cookies use that installation's path. Relative CSS font references and ES-module imports resolve beneath the centrally generated stylesheet/script URLs.

### Requirements

- PHP **8.2 or newer**, with `pdo`, `pdo_mysql`, `mbstring`, `ctype`, `fileinfo`, OpenSSL and **Argon2id** support.
- MySQL **8+** or MariaDB **10.6+**, InnoDB and `utf8mb4`.
- HTTPS in production.
- Apache **2.4+** with `mod_rewrite` and `AllowOverride FileInfo` for the included `.htaccess` layouts; an example Nginx configuration is also included.
- PHP CLI for installation, maintenance and scheduled jobs. Composer can run on the host or on a compatible build machine.

### Install

```bash
composer install --no-dev --prefer-dist --optimize-autoloader
cp .env.example .env
php -r 'echo bin2hex(random_bytes(48)), PHP_EOL;'
```

Edit `.env`: set the full `APP_URL`, paste the generated secret into `APP_KEY`, and supply your actual database credentials. Production requires `APP_ENV=production`, `COOKIE_SECURE=true` and an HTTPS URL. Do not copy the preview's private `.env` or credentials.

```bash
mkdir -p storage/uploads storage/logs storage/mail
chmod 600 .env
chmod 700 storage/uploads storage/logs storage/mail
php bin/migrate.php
php bin/check.php
```

**Registration/login work after migrations alone.** Essential roles/permissions are part of migration `006_installation_baseline.sql`, not a hidden dependency on optional starter content.

Optionally install the original curriculum on a new installation:

```bash
php bin/seed.php
```

The repeatable seed creates three original paths/14 lessons, categories and configurable rules. It creates **no learners, completed work or fabricated activity**. Without the seed, onboarding/dashboard/catalogue show honest empty states, and an administrator can author content.

### Provision an administrator

No production default administrator/password is created. In a Bash terminal:

```bash
read -r -s -p 'Administrator password (12+ characters): ' ADMIN_PASSWORD; echo
export ADMIN_PASSWORD
php bin/create-admin.php owner@example.com "Platform administrator"
unset ADMIN_PASSWORD
```

Use your own email and a unique password. Sign in at `APP_URL` followed by `/login`; administration is at `/admin` under the same base. Development-only credentials, when generated, are written to the private `LOCAL_ACCESS.md`; it is excluded from distributions.

### Choose one hosting layout

**Preferred:** set the website's document root to the project's `public/` directory. All other files remain outside the web root. Keep `public/.htaccess`.

**Ordinary Apache shared hosting with a fixed web root:** upload the complete project into the site's document root, or into the desired physical subdirectory. Keep the root **`.htaccess` and `index.php`**, then set `APP_URL` to the matching public address. The root entry point delegates to `public/index.php`; rewrite rules deny private files/directories, and the validated asset handler serves public assets. **No PHP path editing or hardcoded RewriteBase is required.** This alternative relies on `.htaccess` actually being honoured: verify `.env`, `app/`, `storage/`, `vendor/` and `bin/` return 403/404 before launch. Do not use this alternative on Nginx or a host that ignores `.htaccess`.

See [the exact shared-hosting/deployment instructions](docs/DEPLOYMENT.md).

### Recurring work

Run every five minutes, using your hosting account's PHP 8.2+ CLI path and the actual project directory:

```bash
php bin/scheduled-jobs.php
```

This processes reminders, reports, eligible rewards, notification mail and cleanup. The worker uses a database-scoped advisory lock and duplicate-resistant writes. Configure a real cron job; the PHP development server and port 8080 are **not** required in production.

### Email

Email is disabled until you configure actual `MAIL_*` values. There is no invented integration success. Enabling mail also enables verification-gated learning access. Test verification, password reset and notification delivery with your provider before depending on them. Queued notification links resolve the current `APP_URL` at send time.

## Features preserved

Responsive public marketing; eight-step persisted onboarding; actual catalogue and learner dashboard; server-enforced stage/skill/lesson prerequisites; private version-checked notes; checklists; objective and manually graded quizzes; assignment uploads/revisions/review; XP/levels/timezone goals/streaks/protection; schedules/reports; private/public portfolios; eligible peer feedback; consent-based buddies/challenges; conditional virtual referrals; verifiable/revocable printable certificates; administration and audit logs.

The product illustration is labelled. No fabricated testimonials, learner counts or successes are shown. Recommendations are rules-based, not an AI service. Credits are estimated learning credit, not a background attention timer.

## Verification and handoff

- [Refactoring results and actual test evidence](docs/REFACTOR_REPORT.md)
- [Exact changed-file manifest](docs/CHANGED_FILES.md)
- [Executed QA results](docs/QA.md)
- [URL/routing contract](docs/URLS.md)
- [Deployment, upgrades and backups](docs/DEPLOYMENT.md)
- [Security](docs/SECURITY.md), [architecture](docs/ARCHITECTURE.md), [operator guide](docs/OPERATIONS.md), [feature boundaries](docs/FEATURES.md)
- [Test reproduction](tests/README.md)

`Learnow-deployment.zip` contains portable source, the lockfile, migrations, documentation and test code/evidence. It excludes real environment files, administrator credentials, databases, private uploads, backups, logs, temporary Apache fixtures and installed dependencies. Run Composer after extracting, or install dependencies on a compatible machine and upload its `vendor/` directory.

This is a tested foundation, not an independently certified security/accessibility assessment or a managed production-hosting launch. Your own DNS, TLS, SMTP, cron, backups, legal/support copy and hosting permissions still require operator configuration.
