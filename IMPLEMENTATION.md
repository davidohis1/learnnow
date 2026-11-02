# Learnow — implementation checklist

## Build and refactor context
- The original build began in an empty workspace. This deployment refactor modified that existing application in place and preserved its main data.
- Local verification used Debian 13 with installed PHP 8.4.27, Composer 2.8.8, MariaDB 11.8.6 and Apache 2.4.69. These test installations are not requirements to run a development server on shared hosting.
- Core PHP + PDO + MariaDB, vanilla HTML/CSS/ES modules. No application frameworks.
- Preferred document root: `public/`, with private files outside it. An explicitly protected Apache root-bridge alternative is documented in docs/DEPLOYMENT.md.

## Build order
- [x] Runtime, Composer dependencies, environment configuration, migrations, repeatable development seed.
- [x] Router, error handling, validators, PDO access, HTTP/security headers, reusable layouts/components.
- [x] Short-lived, signed JWT in HttpOnly cookie; opaque rotating refresh token; revocation; current database role/account checks; CSRF; throttling; password hashing.
- [x] Registration/login/logout, password reset, optional SMTP verification with honest unavailable-service handling.
- [x] Responsive premium marketing site with no fabricated testimonials or statistics.
- [x] Persisted, multi-step onboarding and editable preferences/schedule.
- [x] Real learner dashboard, catalogue, enrolment, server-enforced stage prerequisites.
- [x] Lesson content, safe YouTube embeds, private notes, checklists, idempotent completion.
- [x] Quiz authoring and server-side assessment, attempts/limits/deadlines, manual grading queue.
- [x] Assignment submission, secured uploads, revisions/review/approval history.
- [x] Idempotent XP ledger, levels, timezone-aware goals/streaks, milestone rules.
- [x] Configurable streak protection and optional quiz lives.
- [x] Admin content hierarchy, user management, assessment review, rewards, certificates, settings and audit log.
- [x] Notifications, duplicate-safe scheduled jobs and weekly accountability reports.
- [x] Portfolio ownership/public privacy controls, peer reviews, buddies/challenges and moderation.
- [x] Conditional referral rewards, certificate eligibility and public verification.
- [x] Automated critical-path/security regression tests and desktop/mobile browser checks.
- [x] Deployment, HTTPS/cookie settings, SMTP, cron, backup/recovery, security limits and feature-status documentation.

## Decisions
- Authentication is a single JWT-cookie system, with server-tracked sessions and opaque rotating refresh tokens. No PHP login session or browser localStorage tokens.
- A learner's current role/status is loaded from the database on protected requests.
- Rules-based recommendations, never marketed as AI.
- Plain-text structured lesson content and escaped output; no unsafe HTML editor.
- Original starter curriculum may be seeded as actual published content. No fictitious learner records, social proof, video URLs, or historical activity.
- SMTP and optional external delivery are disabled until configured. In-app notifications work independently.
- Local preview is not a production deployment or security certification. Tested workflows and remaining scope are recorded in docs/QA.md and docs/REFACTOR_REPORT.md.

## Test results
See docs/QA.md and docs/REFACTOR_REPORT.md for the current, actually executed results.


## Deployment portability/refactor acceptance
- [x] APP_URL is the complete canonical base; central PHP and JavaScript URL services.
- [x] Logical routes and already-prefixed references have explicit, non-ambiguous semantics.
- [x] URL generation includes assets, forms, API calls, redirects, shares, certificates and mail.
- [x] Incoming mount normalisation preserves query data/methods/route parameters.
- [x] Registration's missing-role failure reproduced and fixed in an essential-data migration.
- [x] Account/session creation is atomic; real nested transaction savepoints implemented.
- [x] Standard CSRF HTTP status works under Apache as well as the PHP development server.
- [x] Startup/error references are safe and map to private structured diagnostics.
- [x] Migration ordering/checksums/locking/failure/retry behaviour exercised against MariaDB.
- [x] Shared-hosting entry points and private-file denial tested under real Apache.
- [x] Root, nested-prefix and HTTPS-cookie deployment checks executed; no invented provider success.
- [x] Source archive excludes live credentials, databases, uploads and temporary test installations.

External SMTP delivery, your provider's DNS/TLS/cron/permissions, off-site backups and operator-specific legal/support settings remain launch responsibilities, not completed external integrations.
