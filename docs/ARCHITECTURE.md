# Architecture and domain invariants

## Request lifecycle

`public/index.php` loads Composer and the environment bootstrap, installs safe error handling and security headers, then dispatches an explicit route from `routes/web.php` or `routes/api.php`. Controllers compose view data or accept a mutation. Services enforce domain rules using the prepared PDO repository. PHP templates escape user-controlled values; small ES modules add progressive interaction.

The browser modules have distinct responsibilities:

- `url.js`: PHP-provided APP_URL, internal URL construction and mount-aware path handling.
- `api.js`: JSON/form requests, CSRF, generic errors and notifications.
- `app.js`: forms, navigation, dialogs, accessible focus handling and shared interactions.
- `onboarding.js`: step validation and server-persisted onboarding choices.
- `learning.js`: note-save ordering, checklists and quiz navigation/submission.
- `admin.js`: vanilla question and structured-content builders.

URL generation and incoming path normalisation share the contract in [URLS.md](URLS.md). The optional project-root Apache bridge is documented in [DEPLOYMENT.md](DEPLOYMENT.md).

The server remains authoritative even if JavaScript is bypassed. No browser storage contains an authentication token. There is no parallel PHP-session login implementation.

## Data model

Seven append-only migrations currently define 74 InnoDB tables, including essential installation roles and deployment-independent queued mail links. Major groups are:

| Domain | Principal tables |
|---|---|
| Identity | `users`, `roles`, `permissions`, `role_permissions`, `auth_sessions`, `refresh_tokens`, `account_tokens`, `rate_limits` |
| Preferences | `user_preferences`, `user_interests`, `study_schedules`, `study_days`, `notification_preferences`, onboarding progress |
| Curriculum | `categories`, `learning_paths`, `stages`, `stage_prerequisites`, `modules`, `lessons`, lesson prerequisites/resources/checklists, skill nodes/edges |
| Progress | `enrolments`, `lesson_progress`, `checklist_progress`, `learner_notes`, `stage_overrides` |
| Assessment | `quizzes`, `quiz_questions`, `answer_options`, `quiz_attempts`, `quiz_responses`, selected-answer links, `assignments`, `grading_rubrics`, submissions/history/feedback |
| Motivation | `activity_events`, `daily_activity`, `xp_transactions`, `coin_transactions`, levels, achievements, earned achievements, streak protection, quiz lives |
| Community | portfolio projects/skills/images, buddy relationships, friend challenges, peer assignments/questions/responses, community reports |
| Proof/referrals | certificates/verifications, referral codes/links/campaigns/rewards |
| Operations | notifications, mail outbox, weekly reports/path snapshots, system settings and audit logs |

Foreign keys, composite/unique indexes and database constraints complement validation. Dynamic SQL identifiers are taken only from fixed application metadata. Query parameter values use prepared statements.

## Transactions and idempotency

`DB::transaction` owns an outer transaction or creates a nested savepoint. Reward/assessment mutations lock the learner record before changing dependent records. Domain-level unique keys are the final duplicate barrier, not a disabled browser button.

Representative keys:

- One enrolment and one completion per learner/path or learner/lesson.
- One XP/activity record for each qualifying source event.
- One earned achievement per learner/achievement.
- One accepted-assignment reward and first quiz-pass reward, regardless of retries.
- One certificate per learner/path and one referral reward per referral.
- One weekly report per learner/local week, with captured path progress.
- One notification per learner/deduplication key.
- One peer assignment per project/reviewer.
- One explicit purchase request key per learner for virtual protection purchases.

These invariants are regression-tested. They are not a claim of completed distributed-load or every-interleaving concurrency verification.

## Progression and assessment

A published path must be enrolled before learning access. Stage access depends on all configured stage prerequisites and cross-stage skill edges. Lesson access also checks configured prerequisite lessons. Associated quizzes and assignments enforce the linked lesson’s prerequisites. The learning map renders prerequisite-locked lessons as locked.

A stage cannot complete merely because it is empty. Required published lessons, required passing quizzes and required accepted assignments must all be satisfied. Skill edges and stage dependencies are validated as a combined acyclic graph. Lesson prerequisites must belong to the same path and an accessible same/upstream stage; future inaccessible prerequisites are rejected. Administrative access overrides are audited, explained and do not grant completion or rewards.

Objective quiz questions use exact answer-set comparison. Points and percentages come from stored questions, never client-provided scores. Written responses remain pending until an authorised reviewer grades them. Attempt deadlines and optional lives are server rules. Attempted quiz questions/scoring cannot be rewritten in place.

Assignment acceptance requires a permitted submission format and a passing score. Each revision and feedback action is recorded. Location and scoring rules for an assignment with submissions are immutable. Learners cannot accept their own official work. Assigned reviewer authority is checked again inside grading transactions.

## Learning credit, goals and time

Configured lesson duration is credited once on legitimate completion. A first quiz pass grants five estimated learning minutes; an accepted assignment grants twenty. These are disclosed **learning credits**, not a background timer or measured active engagement.

Opening a lesson, visiting the dashboard, leaving a tab open or passing a schedule time adds no learning credit or XP. Daily target qualification is recorded from actual eligible activity. Event dates use the learner’s valid IANA timezone; changing timezone does not rewrite old event dates.

Protection covers a missed yesterday only when the preceding day qualified and inventory/monthly limits permit it. The monthly cap uses the protected date’s month. Protection records are distinct from study activity and grant no lesson completion. Milestones are lifetime, one-time awards in this release.

Weekly reports use the preceding local Monday–Sunday calendar interval, converted to UTC for source-event queries. DST weeks are not assumed to be 168 hours. Stored report counts and path snapshots do not silently change when new work is completed later. Suggestions are deterministic rules, not an AI integration.

## Publication and privacy

Only published content appears in learner access/catalogue queries. Portfolios start private. Public pages/images require explicit publication and an active owner. Owners explicitly request peer review; assigned reviewers receive a fixed text/link snapshot, not continuing access to a private project’s media. Official grading and peer feedback are separate systems; peer scores do not issue official completion or XP.

Publication is deliberately simpler than a full course-versioning platform. Duplicate a path or create a new assessment revision for major changes to a curriculum that already has learners. Existing certificates retain their issuance name/path snapshot and require explicit revocation if no longer valid.

## Jobs and integrations

One cron-compatible entrypoint uses a database advisory lock and bounded batches. It performs streak/milestone/referral checks, local-time study/streak/deadline reminders, weekly reports, eligible email delivery and old-session/token/rate-limit cleanup. Re-running it does not duplicate already-keyed records.

PHPMailer is used only when configured. Verification/recovery mail is direct; notification mail is queued. Queue eligibility includes current active status, verified email and email opt-in. SMTP delivery cannot be made exactly once by a database transaction; crashed `sending` records require reconciliation.

There is no push subscription service, WhatsApp API, payment processor, AI provider, object-storage service or analytics tracker in the supplied build.
