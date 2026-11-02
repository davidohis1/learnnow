# Administrator and operator guide

## Accounts and permissions

Open `/admin` using a privately provisioned administrator account. Keep a separate ordinary learner account for content checks. Reviewer accounts have the review permission and only see official submissions/attempts assigned to them; ordinary learners cannot enter the admin workspace.

The user management screen supports searching, role changes, suspension/reactivation and named access overrides with a required explanation. Suspension and role changes revoke sessions. You cannot remove the final active administrator. An override unlocks access only: it does not forge completion, scores, XP or certificates.

Administrators do not have a learner-private-notes explorer. Account deletion/export and MFA are not implemented as self-service features; define appropriate support and privacy procedures before public launch.

## Publish a learning path

1. Create or select a skill category. Category **names and slugs are unique**.
2. Create a draft learning path with a clear description, objectives, difficulty and certificate rules.
3. Add stages, then modules and lessons. Positions control presentation order, not access rights by themselves.
4. Add explicit stage prerequisites and optional branching skill-node edges. Set lesson prerequisites where one lesson must precede another. Cycle and future-stage checks reject impossible progressions.
5. Add practical objectives, takeaways, resource links and checklist items. Enable the required-checklist rule only when those tasks are meaningful.
6. Add quizzes/assignments where needed; confirm all required assessments are possible to complete.
7. Publish the intended lessons/assessments and then the path. Test it with a normal learner, not an access-overridden administrator.

Lesson content is deliberately restricted: plain paragraphs, `##` headings and triple-backtick code blocks. It is not an arbitrary HTML/Markdown CMS. Video is optional; supply a valid YouTube URL/ID for material you are permitted to use, and verify its actual availability. The seed intentionally contains no made-up video links.

Existing stage/module/lesson/quiz hierarchy parents cannot be reparented in place. This protects progress and prerequisites. Create a new record or duplicate the path. A duplicate includes stages, modules, lessons, dependencies, assessments and skill nodes/edges, starts as draft content, and does **not** copy learners, attempts or rewards.

Changing requirements of a live course can change its current eligibility calculations. There is no per-enrolment course-version pinning. Prefer a duplicate/new published revision for substantive changes and review whether existing certificates need explicit revocation.

## Quizzes and official assignment review

- The question builder supports single choice, multiple choice, true/false and written responses. Objective questions need valid correct options; written responses require manual review.
- Configure passing score, attempt/time limits, answer visibility and optional lives. Attempted question sets/scoring cannot be rewritten; create a new quiz revision instead.
- Opening or starting an attempt does not pass it or award XP. An abandoned expired attempt remains failed/timed out when resolved; it is not treated as completion.
- Submission format switches are enforced server-side. Permitted files are private PDF/TXT/JPG/PNG up to 5 MB. Due dates are displayed as accountability/reminder dates; late work is accepted rather than automatically rejected.
- Reviewers receive an explicit assignment from an administrator. They cannot grade unrelated work or grant themselves access.
- Use a factual score and constructive feedback. Acceptance requires the configured passing score. Revision requests preserve history. Official acceptance and first quiz passes award once; feedback or page refresh cannot re-award them.
- The current learner UI lists status history and feedback. Old revision data/files are retained privately for audit/recovery, but there is no full visual diff or old-file browsing interface.

## Rewards, lives and referrals

Use Rewards & rules to set future lesson/quiz/assignment XP, level thresholds, achievements, protection limits and optional lives. Seed defaults are 30/50/100 XP, seven levels, lifetime streak milestones and no lives-based blocking. Virtual protection purchasing is disabled initially.

XP and virtual coins are separate ledgers. Virtual coins and streak protections have **no cash value**. Do not promise real-money rewards, payouts or purchase/payment support; none is integrated.

Referral campaigns are disabled initially. If enabling one, set an actual date window, eligibility thresholds, verification requirements, per-referrer cap and virtual reward amounts. Only qualifying activity counts. The unique-email/no-self/cap rules cannot fully detect a human operating many accounts; review suspicious activity and define campaign terms.

## Portfolios and community

Projects begin private. Publication is an explicit owner action. An owner can request feedback without publicly publishing; selected eligible peers receive a frozen text/link snapshot. Private images remain private. Peer reviews have structured criteria and written feedback, are limited by eligibility/assignment caps and cannot create official course completion or XP.

Study-buddy requests require acceptance. Challenges require an accepted buddy and separate challenge acceptance; they count actual lesson completions in their period and do not create automatic rewards. Blocking and reporting are available. Administrators can resolve reports and hide abusive peer reviews. There is no general chat or live video-class system.

## Certificates

A learner requests a certificate after completing the enrolled path’s required published lessons and assessments and meeting its configured required-quiz average. The server checks eligibility; a browser-supplied completion flag is ignored.

Issued certificates capture the learner name and path title with a random verification identifier. Their public page is printable on A4 and can be saved as PDF by the browser. It is not a separately signed downloadable PDF or a claim of external accreditation.

An administrator may revoke a certificate with a factual explanation. The public verifier shows revocation; repeating a revocation cannot erase its original reason. Issuance is unique per learner/path, so a revoked certificate is not silently replaced by requesting again.

## Reminders, reports and email

Learners choose study days, local time, timezone and notification preferences. The worker—not merely the elapsed schedule—creates eligible reminders. Report pages initially explain when the first real report will be available; they do not fabricate a previous week.

Set up the five-minute cron task and monitor it. Reports are generated for the immediately preceding local week. The worker is not an arbitrary all-history backfill command.

SMTP is disabled in this preview. Account verification/reset and notification emails require your own provider. Ports 587/other configured ports use STARTTLS; port 465 uses implicit TLS. Run an actual delivery/verification/reset test and confirm SPF/DKIM/DMARC and provider limits before relying on mail. Queue error handling was tested locally; external successful delivery was not.

Browser notifications/push and WhatsApp are not connected. The application makes no permission request or delivery promise for those channels. In-app reminders and configured email are the supported notification channels.

## Routine maintenance

- Review system reports, audit events, unresolved community reports and pending official reviews.
- Monitor cron success, private logs, queue errors, disk capacity and upload growth.
- Apply PHP/database/Composer updates through staging and rerun regression checks.
- Rotate logs, enforce backup retention and perform recurring isolated restore drills.
- Review published links/material and content rights. Review legal/support copy and retention decisions with qualified advisers as needed.
- Do not run tests against the live database. The supplied test bootstrap and HTTP/browser target marker enforce a separate `_test` environment.
