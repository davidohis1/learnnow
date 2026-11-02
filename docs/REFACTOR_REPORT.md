# Learnow — refactoring and deployment handoff
**Completed in the existing project files · 25 October 2026**

## Result

The application now treats **APP_URL as its complete canonical base URL**, including scheme, hostname, optional port and arbitrary installation prefix. PHP views/controllers and vanilla JavaScript share that contract. Root and nested installations use the same application code, and the original design, branding, features and main data were retained.

The final functional runs produced **1,660 passed assertions, zero failures** across URL, installation, business, HTTP/browser and Apache deployment suites. Another 12 static source guards passed. All 106 PHP files and six browser modules passed syntax checks. Composer production installation/platform/audit checks passed, with no reported dependency advisory. The 81 automated axe page audits recorded zero violations; this is not formal accessibility certification.

**Deliverables:**
- `Learnow-deployment.zip` — portable source, lockfile, migrations, documentation and test code/evidence; no live `.env`, credentials, database, uploads, backups, logs, temporary test installations or `vendor/`.
- `docs/CHANGED_FILES.md` — complete source-change manifest and separately identified test/evidence changes.
- `docs/DEPLOYMENT.md` — exact hosting, setup, upgrade, permission, cron, SMTP and backup instructions.
- `docs/QA.md` — executed test matrix, proof and explicit limits.
- `docs/URLS.md` — URL/helper/router contract for future maintenance.

## Problems identified and repaired

### 1. Registration failed on a migrations-only installation

**Reproduced cause:** the old migrations did not install the learner role. Only the optional curriculum seed created it. The role lookup returned no value; insertion attempted an empty `users.role_id`, producing SQLSTATE **22007 / 1366** and the generic 500. Diagnostic reference **`c61163720711`** identified the failing insert.

**Repair:** migration `006_installation_baseline.sql` installs essential roles/permissions using name-based mappings. Registration checks the role explicitly and creates the account, preferences/referral data and authentication session atomically. Genuine duplicate-email races return a validation response instead of a generic error. Confirmation/terms input types were tightened and referral entropy increased.

**Actual proof:** registration → empty-content onboarding → dashboard → logout → login succeeded on a nested, migrations-only installation before optional seeding. Concurrent same-email Apache requests produced one 201/one 422 and one user. A deliberately failed refresh-token insert rolled back the whole account and returned a safe referenced error; no fake registration success was returned.

This demonstrates a concrete fresh-install cause and repair. It does not claim that an unavailable remote hosting account's logs were inspected.

### 2. Internal addresses assumed a domain-root installation

Added a central PHP `Url` service and matching vanilla-JS URL module. Converted navigation, view/form attributes, assets, API requests, authentication destinations, pagination/filter links, admin links, referral sharing, certificate links and generated mail addresses. Canonical metadata and the frontend `app-url` configuration use the same validated base.

Logical routes (`route_url`) and potentially already-prefixed references (`url`) have explicit semantics. This prevents ambiguous/double prefixes, including an installation whose own prefix is `/admin` or `/api`. Query/fragment handling, repeated keys, spaces/Unicode encoding and unsafe/external redirects are covered by shared parity fixtures. External resource/project URLs, same-document fragments, data payloads and filesystem paths were not blindly prefixed.

CSS fonts and JS imports are intentionally file-relative and inherit their centrally generated parent asset URLs. No preview hostname, current workspace directory or preview origin remains in application logic.

### 3. Incoming paths and static assets did not support nested mounts consistently

The front controller now normalises the request against the configured mount before route matching, without discarding the original query/method. HEAD and decoded route parameters are handled consistently. Invalid/outside-mount paths are rejected.

Added a constrained public asset fallback with extension/realpath checks, correct MIME/HEAD/cache/ETag behaviour. Added a root entry-point bridge and portable Apache rules without a hardcoded RewriteBase. The preferred `public/` document root and a physical nested whole-project shared-hosting layout both passed real Apache tests.

### 4. CSRF responses differed under Apache

Actual mod_php testing exposed nonstandard HTTP **419** being translated into a server **500**. Invalid CSRF now returns standard **403**, preserving a safe actionable response across SAPIs. The final Apache matrix passed all 219 assertions.

Cookie paths now follow the mount; Secure/HttpOnly/SameSite behaviour remains intact. Production HTTPS tests also confirmed HSTS, anti-framing policy and the absence of test-instance markers.

### 5. Setup and database failures were difficult to diagnose safely

Added validated environment loading, early runtime/production checks, safe bootstrap error handling and private structured reference diagnostics. Logs omit request bodies/cookies/trace arguments and redact configured secrets; a system-error-log fallback remains if private logging is unavailable. Startup buffering reduces the chance of a partial page preceding a safe error.

Added tracked ordered/checksummed migrations, a database-scoped lock, explicit applied/running/failed states and a controlled retry after operator reconciliation. Tests induced real partial DDL commits: these are **not** described as automatically reversible transactions. Nested application transactions now use real savepoints.

Added `bin/check.php`, which verifies an actual database connection/version, all required tables, migration status/checksums, essential roles and writable private storage. Composer and the documented runtime requirements now include ctype explicitly.

### 6. Deployment-bound queued links and setup assumptions were stale

Migration 007 separates logical notification destinations from queued message bodies. Views/queued delivery resolve links against the current APP_URL. Existing already-delivered mail/printed links cannot be remotely rewritten; keep redirects when moving a live installation.

Starter curriculum is optional and repeat-safe. Empty-content onboarding/dashboard states work. Administrator provisioning requires an explicit email and a production password; there is no production default account. Remaining filter/onboarding form actions were centralised and onboarding includes CSRF. Deployment and architecture documentation were refreshed to remove the old requirement to edit PHP include paths for shared hosting.

## Install on your hosting account

### Required environment

Copy `.env.example` to `.env` and supply real values:

```dotenv
APP_ENV=production
APP_URL=https://YOUR_DOMAIN/YOUR_OPTIONAL_PREFIX
APP_KEY=PASTE_A_NEW_RANDOM_SECRET
COOKIE_SECURE=true
DB_SOCKET=
DB_HOST=YOUR_DATABASE_HOST
DB_PORT=3306
DB_DATABASE=YOUR_DATABASE_NAME
DB_USERNAME=YOUR_DATABASE_USERNAME
DB_PASSWORD=YOUR_DATABASE_PASSWORD
MAIL_ENABLED=false
```

Use a root URL without the optional suffix, or the entire nested base. Generate the secret with the command below; do not use the literal placeholder. The example file also documents JWT identity, timezone and SMTP fields. Production needs HTTPS, PHP 8.2+ with the required extensions/Argon2id and MySQL 8+/MariaDB 10.6+.

### Exact commands

From the uploaded project directory:

```bash
composer install --no-dev --prefer-dist --optimize-autoloader
cp .env.example .env
php -r 'echo bin2hex(random_bytes(48)), PHP_EOL;'
```

Edit `.env` with your full URL, generated secret and real database credentials, then:

```bash
mkdir -p storage/uploads storage/logs storage/mail
chmod 600 .env
chmod 700 storage/uploads storage/logs storage/mail
php bin/migrate.php
php bin/check.php
php bin/seed.php    # optional starter curriculum on a new installation
```

For an existing installation, **back up first and keep its existing .env**; do not overwrite it using the copy command. Install the locked dependencies, migrate and check. Do not edit previously applied migrations or hide failed migration rows.

To create an administrator in Bash without putting its password into shell history:

```bash
read -r -s -p 'Administrator password: ' ADMIN_PASSWORD; echo
export ADMIN_PASSWORD
php bin/create-admin.php YOUR_REAL_EMAIL "Platform administrator"
unset ADMIN_PASSWORD
```

The password must be 12–128 characters. Configure cron every five minutes to run `php bin/scheduled-jobs.php` using your host's actual CLI executable/project directory. Composer may be run on a compatible build machine and the resulting vendor directory uploaded if your plan has no Composer command. Ask the provider to run CLI migration/setup if Terminal/SSH is unavailable; do not expose installation scripts to browsers.

### Hosting configuration

**Preferred:** set the website's document root to `public/`; keep `public/.htaccess`, with private files outside the web root.

**Fixed-root Apache shared hosting:** upload the whole project into the actual document root or physical nested application folder. Keep the root `.htaccess` and `index.php`, and set APP_URL to that public address. No PHP/bootstrap/rewrite-prefix editing is needed. This option requires Apache 2.4/mod_rewrite and `.htaccess` support. Verify `.env`, `app/`, `storage/`, `vendor/` and `bin/` requests return 403/404 with no contents **before launch**. A host that ignores `.htaccess` is not safe for this layout.

Use `docs/DEPLOYMENT.md` for permissions, web PHP limits, Nginx example caveats, migration recovery, cron commands and backup/restore procedures.

## What was actually tested

| Area | Result |
|---|---:|
| PHP + JavaScript URL handling | 228 + 193 passed |
| Installation/configuration/migration contract | 105 passed |
| Server-authoritative business rules | 72 passed |
| Full HTTP journeys: root, nested PHP, nested Apache | 218 each |
| Full browser journeys: those three layouts | 63 each |
| Apache root/shared-prefix/alternate-host production HTTPS | 219 passed |
| Static URL bypass guards | 12 passed over 109 files |
| PHP / JS syntax | 106 PHP files / six modules passed |
| Automated axe audits | 81 page audits, zero findings |
| Composer production/platform/audit | Passed; no reported advisory |

The Apache HTTPS fixture used a self-signed local certificate; trust verification was disabled only in that test client. The runtime actually exercised was PHP 8.4.27/MariaDB 11.8.6/Apache 2.4.69. See `docs/QA.md` for every result file and the exact matrix.

## Remaining launch work / boundaries

No failing automated application check remains. Production operation still requires:

1. **Your actual host:** configure/verify DNS, trusted TLS, compatible web/CLI PHP, database credentials, rewrite handling, permissions and private-file denial. The local Apache results are not a claim of deployment to your provider.
2. **Real SMTP:** successful external verification/reset/notification delivery was not performed. Email-disabled operation is honest; enable verification-gated access only with a working provider and a tested delivery path.
3. **Operations:** configure and monitor cron, logs, encrypted off-site backups/restore drills, and final operator-specific support/legal/retention settings.
4. **Known scope limits:** no managed push/WhatsApp/payment integration, MFA, antivirus service or formal external security/accessibility certification is claimed. Strict refresh replay handling has no cross-tab grace mechanism. Ambiguous SMTP sends require provider-led reconciliation rather than an exactly-once delivery promise.

The existing application remains available in its original preview; disposable verification servers are not production dependencies. The source package does not contain the preview's environment or administrator credentials.
