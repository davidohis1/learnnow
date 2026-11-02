# Security model and operational limits

This is an engineering description, not a penetration-test certificate or a guarantee of security.

## Authentication

- Passwords use `password_hash` / `password_verify` with Argon2id. Email is trimmed, lowercased and database-unique. Terms consent is required.
- A maintained Firebase JWT library signs/verifies **HS256 only** using a random environment secret. Issuer, audience, subject/session binding, token identifiers and required time claims are validated. Access lifetime is 15 minutes.
- JWTs and opaque 14-day refresh tokens live in HttpOnly, SameSite=Lax cookies; production requires the Secure flag. No login PHP session or localStorage token exists. JavaScript sessionStorage is used only for short success notices across redirects.
- Authentication sessions are persisted server-side. Every protected request loads the current database user, role and active status. A signed token does not freeze old permissions.
- Refresh-token hashes are stored, rotated and marked used under a transaction lock. Reuse revokes the affected session. Logout, suspension, role changes and password reset revoke server-side sessions.
- **Strict refresh-replay detection is intentional:** concurrently replaying an expired refresh token from multiple stale browser tabs can also force reauthentication. There is no replay grace window or trusted-device/MFA system in this version.
- Verification and reset tokens are high-entropy, account/purpose-bound, hash-stored, expiring and single-use. SMTP credentials are private environment values. Disabled email is reported honestly, never as successful delivery.

## Request and output safety

- Mutations require a signed double-submit CSRF token and reject a cross-site `Sec-Fetch-Site` signal. SameSite cookies are not the only CSRF defence.
- Login, registration, recovery, verification and selected abuse-prone actions are database-throttled. Application throttles supplement, not replace, a reverse-proxy/WAF abuse policy.
- PDO uses native prepared statements and exceptions. Dynamic table/field names come from fixed internal resource metadata, not arbitrary request input.
- HTML output is escaped. Lesson content is an intentionally restricted text renderer supporting paragraphs, `##` headings and fenced code; no raw learner/admin HTML is rendered. Client-side builders escape their dynamic values.
- JavaScript is local ES modules; CSP does not allow inline script execution or `eval`. Device permissions are denied. Errors return a reference ID while details go to private logs.
- Private paths are outside `public/`. In the preferred document-root layout they are outside the served tree; the optional project-root Apache layout additionally depends on verified `.htaccess` denial. Neither application router exposes `.env`, database files, dependencies, backups or arbitrary storage paths.

## Authorisation and invariants

Ownership checks apply to notes, attempts, submissions, portfolio editors and private images. Administrators can review authorised submissions but are not given a private-notes browser. Reviewers can access only explicitly assigned official work; grading services recheck the assignment under their transaction lock.

Stage/lesson/skill dependencies, completion, question scoring, assignment acceptance, certificate eligibility and referral eligibility are server decisions. Browser-provided scores, rewards, owner IDs and role IDs cannot override them.

Unique database keys protect enrolments, progress, activity/reward ledgers, earned achievements, referral rewards, certificates, peer assignments, report weeks and notification deduplication. Privileged operations record audit entries. There is no audit-edit/delete application endpoint; a database operator is still a trusted privileged actor.

## Uploads and links

- Uploads are limited to 5 MB and inspected by actual MIME type. PDF/TXT/JPG/PNG are allowed for enabled assignment fields; portfolio images accept JPG/PNG only. Image dimensions are bounded.
- Files get random storage keys and restrictive permissions in private storage, never in `public/assets`. The preferred layout keeps storage outside the web root; the root-bridge layout requires verified HTTP denial. Downloads pass ownership/role checks; attachments are forced as downloads with no-sniff and a sandboxed content policy.
- Public project images require a public project and an active owner. Publishing is explicit. Peer review shares a text/link snapshot only after the owner requests it; private images are not implicitly published.
- URL fields accept HTTP(S), reject embedded credentials and never fetch user-provided URLs server-side. External project/resources can still contain malicious or misleading content; learners and moderators must exercise care.
- There is **no antivirus scanner, content-disarm service or image re-encoding pipeline**. Add appropriate scanning/quarantine, storage quotas and moderation for a public deployment.

## Important boundaries

- No independent penetration test, large-load/concurrency certification, formal WCAG certification, MFA, device management UI or automated account-erasure/export workflow is included.
- Generic authentication/recovery messages and throttles reduce account enumeration, but network/SMTP timing and sophisticated multi-account abuse still need production threat modelling.
- Normalised unique email, verification conditions, caps and auditability mitigate referral abuse. They cannot establish that different email addresses belong to different humans.
- First-party HTTPS operation is the supported sign-in context. Some embedded browsers block third-party cookies. Open the preview in a separate tab; do not disable security flags as a workaround.
- Content is not a fully versioned immutable course-publication system. Use draft duplication/new assessment revisions for substantive changes to an in-use curriculum. Completed records are preserved; existing certificates require an explicit administrative revocation when appropriate.
- Admin settings can change future reward conditions. Issued XP/referral ledger records are not silently rewritten. No cash payouts or external accreditation exist.
- Strict refresh rotation can require a user to sign in again after concurrent stale requests. SMTP cannot guarantee exactly-once delivery; reconcile ambiguous `sending` records manually.
- Secure the host, backups, database privileges, reverse proxy, package updates and operator accounts. Application checks do not substitute for infrastructure security.

## Key rotation and incident response

1. Restrict access and preserve relevant private audit/application logs.
2. Rotate compromised environment secrets and provider credentials.
3. If rotating `APP_KEY` because of compromise, also revoke existing `auth_sessions`. Changing the JWT key alone is not a complete refresh-session revocation procedure.
4. Invalidate affected one-time tokens, investigate suspicious grants/reviews/referrals and revoke certificates only with a documented factual reason.
5. Restore/test from a known-good backup as necessary, notify affected users according to applicable obligations, and review root causes before reopening access.

## Portability/security changes

Internal URLs use the validated APP_URL service, not the request Host header. Cookie paths follow the application mount. Path scoping reduces accidental collisions; it is not isolation from a compromised application on the same origin. Use separate origins for mutually untrusted applications.

Invalid CSRF uses standard HTTP 403 rather than nonstandard 419, which PHP under Apache can turn into HTTP 500. Registration stores its account, related records and authentication session in one transaction with real nested savepoints. Essential roles are installed by migrations. Errors before or after bootstrap produce a safe reference; private structured logs exclude request bodies, cookies, passwords and trace arguments and redact configured secrets.

Migration checksums, a database-scoped runner lock and persisted running/failed/applied states prevent silent repetition of partial DDL. This cannot make MySQL DDL transactional: failed migrations require an operator-led restore/reconciliation before explicit retry.
