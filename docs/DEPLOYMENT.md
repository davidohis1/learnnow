# Deployment, upgrades and recovery

These instructions supersede the earlier root-only deployment advice. **No application code changes are required for a different domain or installation subdirectory.** `APP_URL` is the full public base, including any prefix.

## 1. Requirements

- PHP 8.2+ for **both web and CLI**, with PDO/PDO MySQL, mbstring, ctype, fileinfo, OpenSSL and Argon2id password support.
- MySQL 8+ or MariaDB 10.6+, InnoDB, `utf8mb4` and a scoped database user.
- HTTPS in production; an actual domain/subdomain mapped to your hosting account.
- Apache 2.4+ with `mod_rewrite` and `.htaccess` permitted (`AllowOverride FileInfo` is sufficient for the supplied rules).
- CLI access through Terminal/SSH, a service manager, or assistance from the hosting provider. No root access or Node service is needed by the application.
- Cron support for reminders/reports/maintenance. SMTP is needed for real email verification/reset/notification delivery.

Composer can be run on the host or on a compatible build machine. If you install locally, upload the resulting `vendor/` directory with the project. Do not upload databases, real `.env` files, `LOCAL_ACCESS.md`, private uploads, test artifacts or backups from a development environment.

## 2. Choose a public-entry-point layout

### A — Preferred: document root is `public/`

Place the project outside the served directory and point the domain's document root at its `public/` folder. Keep `public/.htaccess`. All application/configuration/storage/dependency files stay outside the document root.

For a mounted prefix, have the web server map or forward that request URI to the same front controller while preserving the prefix. The application handles prefix normalisation and fallback assets. No RewriteBase or application-path edits are necessary.

### B — Fixed-root Apache shared hosting

If your primary domain must use `public_html`, upload the complete project there. For a physical subdirectory installation, upload it into that subdirectory instead. Keep the **root `index.php` and root `.htaccess`** as well as `public/`; do not move files or edit PHP include paths.

Examples (replace the domain and physical folder with your actual choices):

| Files uploaded into | APP_URL |
|---|---|
| Your domain's document root | `https://example.com` |
| Its `academy` subdirectory | `https://example.com/academy` |
| Its `academy/skills` subdirectory | `https://example.com/academy/skills` |

The root entry point delegates to `public/index.php`. The root rewrite configuration denies private directories/dotfiles and routes requests through the front controller. Public assets are served by the constrained asset handler, not by exposing the entire `public/` tree under a second URL.

**Security condition:** this alternative depends on Apache actually reading `.htaccess`. If `AllowOverride None` is used, its protection is ignored. Before accepting traffic, explicitly request `.env`, `app/bootstrap.php`, `storage/logs/application.log`, `vendor/autoload.php` and `bin/migrate.php` beneath your application URL and confirm 403/404 with no file contents. If that check fails, stop deployment and use layout A or ask the host to correct its configuration. Do not rely on a hidden filename alone.

The rules need Apache 2.4 `END`, but contain no `Options`, `php_value`, absolute filesystem paths, hostnames or hardcoded RewriteBase. A host that disallows rewriting must enable it; no PHP rewrite hack should expose private files.

### Nginx/other servers

`.htaccess` has no effect on Nginx. Use a `public/` document root and an equivalent front-controller configuration. See `deployment/nginx.conf.example`; substitute your infrastructure's directory, hostname, TLS files and PHP-FPM socket. Do not use the project-root bridge without equivalent explicit server-side protection.

DNS, TLS certificates and a provider's document-root mapping are infrastructure configuration, not values PHP can create by changing APP_URL.

## 3. Configure a new environment

From the project directory:

```bash
composer install --no-dev --prefer-dist --optimize-autoloader
cp .env.example .env
php -r 'echo bin2hex(random_bytes(48)), PHP_EOL;'
```

Edit `.env` privately. A minimal production configuration is:

```dotenv
APP_NAME=Learnow
APP_ENV=production
APP_URL=https://YOUR_DOMAIN/YOUR_OPTIONAL_PREFIX
APP_KEY=PASTE_THE_NEW_RANDOM_SECRET
COOKIE_SECURE=true
JWT_ISSUER=learnow
JWT_AUDIENCE=learnow-browser
DB_SOCKET=
DB_HOST=YOUR_DATABASE_HOST
DB_PORT=3306
DB_DATABASE=YOUR_DATABASE_NAME
DB_USERNAME=YOUR_DATABASE_USERNAME
DB_PASSWORD=YOUR_DATABASE_PASSWORD
MAIL_ENABLED=false
DEFAULT_TIMEZONE=Africa/Lagos
```

Replace **all** placeholders. Omit `/YOUR_OPTIONAL_PREFIX` for a root installation. APP_KEY is generated separately per installation; do not use the literal example value. On cPanel, database/user names commonly contain an account prefix: use the complete names shown by the panel. `DB_SOCKET` overrides TCP settings and should normally remain empty on shared hosting.

The loader preserves quoted values, `#` inside secrets, empty values, equals signs and optional comments. It does not execute shell code or require `putenv()`. Process/server environment values take precedence over `.env`; remove stale server overrides if they conflict with the edited file.

Production validates HTTPS, Secure cookies, secret length/obvious placeholders, required database settings, valid ports/timezone/extensions and configured SMTP fields when mail is enabled. The URL base cannot include credentials, a query string, fragment, traversal or encoded slash/backslash. These checks do not prove your DNS/provider credentials are valid; preflight and actual requests do that.

## 4. Storage, database and installation

Create an empty UTF-8 database and scoped user in your host's control panel. Installation needs schema-changing permissions on **that database only**. A separate restricted runtime principal can use SELECT/INSERT/UPDATE/DELETE after installation; use a migration principal again for upgrades.

```bash
mkdir -p storage/uploads storage/logs storage/mail
chmod 600 .env
chmod 700 storage/uploads storage/logs storage/mail
php bin/migrate.php
php bin/check.php
```

PHP must own or have appropriate group access to writable private directories. Adjust ownership/group access for your handler rather than using 777. The bootstrap can create missing private directories, but cannot override filesystem permissions.

`bin/check.php` actually connects to the database, checks its version, inspects all required tables, verifies migration state/checksums and checks essential roles. It is not a superficial “files exist” check.

Registration/login are operational after migrations alone. Migration 006 supplies the essential roles/permissions that registration previously expected from an optional seed. Without curriculum, onboarding can finish and the dashboard stays honestly empty.

### Optional starter curriculum

```bash
php bin/seed.php
```

Run on a new installation before authoring content if you want the three original paths and 14 lessons. A seed-version guard makes a repeat invocation a no-op. It creates no learners or fake learning activity. Do not use it as a tool to overwrite a customised curriculum.

### Administrator provisioning

No default production password is provided. In Bash:

```bash
read -r -s -p 'Administrator password (12–128 characters): ' ADMIN_PASSWORD; echo
export ADMIN_PASSWORD
php bin/create-admin.php YOUR_REAL_EMAIL "Platform administrator"
unset ADMIN_PASSWORD
```

Production requires the explicit password and email; it does not write a credentials file. Sign in at the configured base plus `/login`, then use `/admin` under that same base.

If your plan lacks Terminal/SSH, install dependencies on a compatible machine and ask the provider to run the CLI setup commands. Do not make `bin/` public or remove CLI guards to run installation through a browser.

## 5. Web PHP and HTTPS

Use the host's SSL/AutoSSL facility and force HTTP-to-HTTPS redirection. The site is intended to be used at its configured canonical address. Configure your proxy/web server to reject unexpected hostnames and preserve the original request URI. Rate limits use the server-vetted REMOTE_ADDR; behind a trusted proxy, configure its real-client-IP handling at the web-server/provider layer rather than blindly trusting arbitrary forwarded headers.

Set web PHP limits using the host's PHP settings or supported `.user.ini` facility, not unsupported `.htaccess` php_value directives:

```ini
upload_max_filesize = 5M
post_max_size = 6M
display_errors = Off
log_errors = On
expose_php = Off
```

The server rejects oversized requests/uploads. JSON errors return safe messages/reference IDs. Private structured diagnostics are appended to `storage/logs/application.log`, with a PHP-system-log fallback if private logging itself is unavailable. They exclude request bodies, cookies, trace arguments and configured secrets.

## 6. Configure scheduled work

In cPanel Cron Jobs, choose the schedule `*/5 * * * *` and enter a command using **your actual** PHP CLI executable and project directory:

```bash
cd /ABSOLUTE/PATH/TO/PROJECT && /PATH/TO/PHP bin/scheduled-jobs.php >> storage/logs/cron.log 2>&1
```

These are deployment-command placeholders, not values to copy literally. Verify the CLI PHP version separately from the web handler. Do not run PHP's development server or a Node process on shared hosting.

Workers are database-locked against overlap and use unique/transactional deduplication for reports, notifications and rewards. Monitor process exit status, `last_job_run`, private logs and queue counts; rotate logs and alert on failures.

SMTP delivery is not exactly once. A crash or ambiguous SMTP response can leave a row as `sending`; reconcile it with provider delivery records before manually retrying. Failed deliveries have a three-attempt ceiling. Inactive, unverified or opted-out accounts are not selected for notification email.

## 7. SMTP and final smoke tests

Set your real `MAIL_HOST`, `MAIL_PORT`, `MAIL_USERNAME`, `MAIL_PASSWORD`, `MAIL_FROM` and `MAIL_FROM_NAME` before enabling `MAIL_ENABLED=true`. Port 465 uses implicit TLS; other configured ports use STARTTLS. Verification-gated access is enabled when mail is enabled.

Test an actual verification email, password-reset email and queued notification with your provider. Account verification links are account-bound: if opened in another browser, sign in to that account and reopen the link. The delivered automated checks exercised failure accounting and authentication/token rules, **not successful delivery through your external provider**.

Before public launch, test registration/login, empty onboarding or the seeded curriculum, notes, a quiz, an assignment upload/review, certificate verification, admin permissions, private-path denial and cron. Complete your operator-specific support details/legal/retention policies. No push, WhatsApp, payment, MFA or antivirus service is supplied.

## 8. Upgrades and failed migrations

Before an existing installation upgrade, back up the database and private uploads. Use an access-proxy maintenance window for schema-changing releases, install the committed lockfile and run:

```bash
php bin/migrate.php --status
php bin/migrate.php
php bin/check.php
```

The runner sorts files, acquires a database-scoped advisory lock, tracks SHA-256 checksums and persists `running` before executing SQL. Only successful migrations become `applied`. Historical five-migration installations have their existing records upgraded with checksums; this adoption cannot retroactively prove the integrity of files applied before checksums existed.

**MySQL/MariaDB DDL can implicitly commit.** A failure can leave partial schema changes. A `failed` or crash-stranded `running` record blocks ordinary re-execution. Read its diagnostic reference, inspect the actual schema and restore/reconcile from a known-good backup. Only after that operator review may you explicitly retry the **unchanged** file:

```bash
php bin/migrate.php --retry=NNN_migration_name.sql
```

Do not edit an already-applied/attempted migration or delete tracking rows to conceal a failure. Add new migrations for new changes. There are no automated down-migrations or promises of transactional DDL rollback. Clear deployment asset/opcache caches and rerun smoke tests before reopening traffic.

## 9. Backups and restore drills

Back up both the database and `storage/uploads`, using a protected database-client option file rather than exposing passwords in command arguments:

```bash
umask 077
mariadb-dump --defaults-extra-file=/SECURE/PATH/backup.cnf \
  --single-transaction --routines --triggers --events --default-character-set=utf8mb4 \
  YOUR_DATABASE | gzip > /SECURE/BACKUPS/database.sql.gz
tar -czf /SECURE/BACKUPS/uploads.tar.gz -C /ABSOLUTE/PATH/TO/PROJECT/storage uploads
```

Use a read-only/maintenance window or coordinated snapshot for an exactly matched database/filesystem backup. Keep credentials/secrets in a separate protected secret-management backup. Encrypt backups with separately managed keys, keep an off-host copy and define retention. Gzip is compression, not encryption; copying a running raw MariaDB data directory is not a consistent logical backup.

Restore into an isolated empty database and isolated upload directory first. Compare migration versions, exact table counts and selected records/relationships, then test authentication, private-file permissions and representative workflows before switching production. Revoke old authentication sessions when account integrity or secrets may be compromised.

A database backup/restore drill was previously run successfully in the workspace; the refactor additionally tested fresh migrations, every declared schema column/foreign key, checksum protection and a real partial-DDL failure/recovery. These are not a substitute for your own encrypted off-site retention and disaster-recovery drills.
