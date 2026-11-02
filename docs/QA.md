# Executed verification — 25 October 2026

This file records completed checks, not a proposed test plan. Final runtime/application changes were in place for the full sequential root/prefix/Apache regression runs. Later changes were documentation, release metadata, an Nginx example and a test-only SMTP isolation guard; business/installation checks, syntax checks and Composer validation were refreshed afterwards.

## Environment actually used

- PHP **8.4.27**, Composer **2.8.8**.
- MariaDB **11.8.6**, real PDO connections and migrations.
- Apache **2.4.69** with the PHP 8.4 module, rewrite support and a local TLS listener.
- Playwright/Chromium plus local axe-core **4.10.3**. Python/Node are test tooling only; the application uses core PHP and vanilla ES modules.
- Main application data was not used as a mutation-test target. Dedicated `_test` databases and explicit test-instance markers guarded the HTTP/browser suites.

## Final results

| Executed check | Passed | Failed | Evidence under `tests/refactor/` |
|---|---:|---:|---|
| PHP URL rules | 228 | 0 | `url-php-results.txt`, `.json` |
| Browser-module URL parity and invalid bases | 193 | 0 | `url-js-results.txt`, `.json` |
| Fresh/schema installation, migration/seed/configuration checks | 105 | 0 | `installation-results.txt`, `.json` |
| Server-authoritative business rules | 72 | 0 | `business-results.txt` |
| Complete HTTP journeys — root | 218 | 0 | `http-root-results.txt`, `.json` |
| Complete HTTP journeys — nested PHP-server prefix | 218 | 0 | `http-prefix-results.txt`, `.json` |
| Complete HTTP journeys — physical Apache shared-host prefix | 218 | 0 | `http-apache-results.txt`, `.json` |
| Browser journeys — root | 63 | 0 | `browser-root-results.txt`, `.json` |
| Browser journeys — nested PHP-server prefix | 63 | 0 | `browser-prefix-results.txt`, `.json` |
| Browser journeys — physical Apache shared-host prefix | 63 | 0 | `browser-apache-results.txt`, `.json` |
| Apache public-root/shared-prefix/production-HTTPS matrix | 219 | 0 | `deployment-results.txt`, `.json` |
| **Subtotal: functional assertions across these runs** | **1,660** | **0** | Repeated layout assertions are counted separately, not presented as unique test cases. |
| Static URL/configuration bypass guards | 12 | 0 | `source-audit.txt`, `.json` — 109 source files scanned |

Additional completed checks:

- **106 PHP source/test files** passed `php -l`; **six vanilla ES modules** passed Node's syntax check.
- Composer strict validation, production `--no-dev --prefer-dist --optimize-autoloader` installation, platform checks and security audit all passed. **No advisory was reported** for the installed dependencies. Logs are in `composer-*.txt`.
- **81 axe page audits**: 27 in each full browser layout, **zero recorded violations**. The browser suites recorded no uncaught JavaScript or HTTP-500 failures. Audit JSON is saved separately as `accessibility-{root,prefix,apache}.json`.
- Screenshots from the final Apache browser run were inspected at desktop and 360px mobile widths; the existing orange branding, typography and responsive composition remain intact. Automated no-overflow checks also cover 390px and 768px layouts and signed-in/admin screens.
- `php bin/check.php` passed against the existing main installation: runtime/extensions/Argon2id, writable private directories, actual database/version, **74 required tables**, applied migration checksums and essential roles. It explicitly reported that SMTP was disabled.
- The scheduled-job CLI ran twice on the main installation: zero learners checked, zero notifications/reports/emails created, email delivery disabled. This verifies the entry point and honest empty state, not a claim of live email delivery. Nonempty/duplicate-prevention job behaviour is separately covered by the transactional business suite. Outputs are `jobs-first.json` and `jobs-second.json`.

## Actual deployment matrix

| Test base | Entry point / mode |
|---|---|
| `http://127.0.0.1:8081` | PHP server, document root `public/`, isolated testing mode |
| `http://127.0.0.1:8082/academy/skills` | Same application through a nested logical mount |
| `http://127.0.0.1:8083` | Real Apache, preferred `public/` document root |
| `http://127.0.0.1:8084/classroom/skills` | Real Apache, whole project in a physical nested shared-hosting directory |
| `https://localhost:8443/college` | Real Apache, different hostname, HTTPS and nested virtual prefix, production settings |

Test origins/prefixes above are deliberate fixtures, not hardcoded application destinations. URL-unit cases also cover nine configured bases, ports, encoded Unicode/spaces, reserved-name prefixes, repeat slashes, existing prefixes, query/fragment references, repeated query keys, external-redirect rejection and traversal/invalid-base rejection.

The local TLS fixture used a **self-signed certificate with client trust verification disabled**. It verifies HTTPS protocol behaviour, secure/scoped cookies, HSTS, production framing policy and absent testing markers. It does **not** verify a public CA chain, live DNS or your hosting provider.

## Registration proof and transaction checks

A fresh database with only migrations 001–005 reproduced the reported generic registration failure. Reference **`c61163720711`** mapped to SQLSTATE **22007 / 1366**, with an empty `users.role_id`. Essential roles existed only in the optional curriculum seed. A missing learner-role lookup became an empty integer value during insertion.

Migration 006 now installs essential role/permission identities independently of curriculum. Registration validates the role explicitly and atomically creates its account, preferences/referral data and authentication session. A migrations-only nested installation successfully registered, completed empty-content onboarding, opened its dashboard, logged out and logged in **before starter curriculum was later installed for the broader suites**. Saved evidence: `registration-before.json` and `registration-after.json`.

Real multiprocess Apache checks also demonstrated:

- Two simultaneous same-email signups produced **one 201 and one 422**, with exactly one persisted user.
- A deliberately failing refresh-token insert produced a safe referenced 500, a useful private diagnostic and **no persisted account**. The trigger was removed in a finally block.
- CSRF rejection initially exposed Apache/PHP translating nonstandard status 419 into 500. The application now uses standard **403**. The final 219-check deployment suite passes.

This is a reproduced installation cause and a verified repair, not a claim that logs on an unavailable remote host were inspected.

## Installation/migration coverage

The installation suite exercised all seven migrations against a disposable MariaDB database, all declared table/column contracts and foreign keys, correct essential-role mappings, repeated migration/seed invocations and the absence of fabricated users/activity. It deliberately changed a copied migration checksum, induced a real partially committed DDL failure, verified its persisted failed/reference state, verified automatic reruns were blocked, reconciled the two disposable tables and successfully retried the unchanged file explicitly. It also proved inner-savepoint rollback preserves outer transaction work.

Configuration cases include HTTPS/Secure-cookie production requirements, invalid/weak secrets, missing database settings, invalid ports/timezones/base URLs/mail settings, dotenv BOM/quoted secrets/comments/empty values, and bootstrap with `putenv()` disabled.

## Boundaries: not executed or not certified

- No deployment to the user's actual cPanel/shared-hosting account, live domain, public certificate or external database endpoint was performed.
- No successful external SMTP verification/reset/notification delivery was claimed. Provider credentials and deliverability are still required.
- The supplied Nginx configuration is an example; the executed web-server matrix was Apache. PHP 8.2 and MySQL 8 are declared minimum-compatible targets; the actual run used PHP 8.4/MariaDB 11.8.
- No independent penetration test, manual assistive-technology certification or formal WCAG certification was performed. Zero axe findings do not establish full accessibility compliance.
- A prior isolated backup/restore drill matched all 74 table counts. The refactor did not configure off-site encrypted backups or a production recovery service.
- Full cross-tab refresh-race grace handling, malware scanning, MFA, web push/WhatsApp and provider delivery reconciliation are not supplied by this refactor. Existing documented boundaries remain in `FEATURES.md` and `SECURITY.md`.

See `tests/README.md` for reproducible commands and the test-target safety guards.
