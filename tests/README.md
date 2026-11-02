# Regression tests

**Never run these tests against valuable/live learner data.** SQL fixtures require a database whose name ends in `_test` and refuse `APP_ENV=production`. HTTP/browser mutation suites additionally require the server's `X-Learnow-Test-Instance: isolated` marker, emitted only with `APP_ENV=testing` and an `_test` database.

## Prepare an isolated installation

Create a separate empty database named `learnow_test` and grant an appropriately scoped local test user access. Configure environment variables to select that user/database. The commands below assume the private `.env` already holds valid local development credentials with access to the test database.

```bash
APP_ENV=testing DB_DATABASE=learnow_test php bin/migrate.php
APP_ENV=testing DB_DATABASE=learnow_test php bin/seed.php
APP_ENV=testing php tests/fixtures.php
```

For a different `_test` name, set `LEARNOW_TEST_DATABASE` for the test scripts and the matching `DB_DATABASE` for migrations, seed and the HTTP server. Test SQL helpers are CLI-only. Do not expose the project root over HTTP.

In a separate terminal/supervised process, start the test-only server:

```bash
APP_ENV=testing DB_DATABASE=learnow_test APP_URL=http://127.0.0.1:8081 \
COOKIE_SECURE=false MAIL_ENABLED=false \
php -d upload_max_filesize=5M -d post_max_size=6M \
    -S 0.0.0.0:8081 -t public public/router.php
```

Install optional developer-only browser tooling (none is a runtime application dependency):

```bash
python3 -m venv .venv
. .venv/bin/activate
pip install -r tests/requirements.txt
python -m playwright install chromium
# On a minimal Linux host, install Playwright's required browser OS libraries too.
```

## Execute

```bash
APP_ENV=testing php tests/business-rules.php
APP_ENV=testing php tests/fixtures.php
APP_ENV=testing python3 tests/http_integration.py
APP_ENV=testing php tests/fixtures.php
APP_ENV=testing python3 tests/browser_checks.py
```

The browser suite now uses the same configured test base for the landing page and mutation journeys. This is necessary because absolute canonical asset URLs must match APP_URL. Override `LEARNOW_PUBLIC_URL` if no separate public instance is running, and `LEARNOW_TEST_URL` only to another isolated, marked test server. Never disable the target guard to point mutations at the main preview.

The business suite rolls back its fixture transaction. HTTP/browser suites deliberately leave **test-only** records for inspection, using distinct generated account emails. Fixtures reset authentication test accounts/limits but do not erase the database or reset every test-created setting. You may recreate the isolated test database to start clean; never copy that destructive reset into production.

Outputs include JSON assertion reports, `accessibility-results.json` and screenshots under `tests/artifacts/`. To save CLI transcripts, redirect stdout or use `set -o pipefail` with `tee`. A nonzero exit code indicates failure. Axe findings are recorded separately from browser functional assertions; inspect that JSON as well.

## Coverage

- Ownership, stage/lesson/skill graph rules, manual grading, quiz timing/lives, duplicate reward prevention, score thresholds, review assignment, certificates, referrals, privacy and audit invariants.
- Timezone rollover, DST-length local weeks, protection behaviour, report immutability and repeated jobs.
- Signed-JWT negative cases, required claims, session subject binding, refresh replay, verification/reset, CSRF, suspended accounts, role changes and private-path access.
- Registration/onboarding/notes/checklists/quiz/project/admin-builder browser journeys, responsive routes, keyboard menu dismissal, JavaScript/server-error collection and pinned axe-core audits.
- A real local SMTP connection failure and opt-out accounting—not successful external SMTP delivery.

This is meaningful regression coverage, not exhaustive concurrency, performance, security or accessibility certification. See `docs/QA.md` for the latest executed results and limits.


## URL, installation and real Apache checks

```bash
php tests/url-rules.php
node --experimental-default-type=module tests/url-rules.mjs
```

The Node command is a developer-only ES-module test runner, not an application backend or runtime requirement. Both suites use the same JSON URL cases; domains/prefixes in those fixtures are deliberate test data, not application configuration.

For a disposable database ending in `_migration_test`, grant the test user installation permissions and run:

```bash
APP_ENV=testing LEARNOW_TEST_DATABASE=learnow_migration_test php tests/installation_checks.php
```

This exercises full schema installation, all table/column/FK contracts, reruns, seeding, nested savepoints, changed checksums and an intentionally conflicting DDL migration. It creates and removes its own disposable probe tables. Never substitute a live database.

`tests/apache_setup.py` prepares private copies under `storage/qa-apache` for this workspace's Debian Apache/PHP test harness. It uses `learnow_refactor_test` and needs an already-created/seeded isolated database accessible to the current private development DB credentials. The harness requires Apache 2.4 and the PHP 8.4 Apache module; those packages are test infrastructure, not application-installation commands for shared hosting. It prepares but does not start the daemon. Start the printed command with a process supervisor, then run:

```bash
python3 tests/deployment_checks.py
```

The fixture covers a public document root, a physical nested shared-hosting installation, and a different hostname/HTTPS prefix with production cookie/header settings. Its temporary self-signed TLS certificate is used only for local protocol/cookie tests; it is not proof of publicly trusted certificate deployment. The deployment suite includes a two-request concurrent signup and a deliberately failed refresh-token insert to prove registration rollback and safe diagnostics.

To run the complete legacy journeys against a prefixed instance, set `LEARNOW_TEST_URL` to that **entire** test base and `LEARNOW_TEST_DATABASE` to its isolated database. The server must use the matching APP_URL/DB_DATABASE. Reset fixtures before each HTTP/browser suite. Results for each executed layout are preserved separately under `tests/refactor/`.

Axe audits still need separate inspection; zero findings are automated results, not formal WCAG certification. Do not claim the deliberately forced failure cases are application errors that remain unfixed: their purpose is to verify honest, safe failure handling.
