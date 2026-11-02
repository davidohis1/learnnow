# Scope, defaults and known boundaries

## Implemented foundation

The delivered platform is interactive and persists to MariaDB. Core workflows include authentication, eight-step onboarding, actual published learning paths, server-enforced prerequisites, version-checked notes, objective/manual assessments, private uploads, rewards, local-calendar streaks, scheduled work, actual weekly reports, private/public portfolios, peer feedback, study buddies, referrals, certificates, role-based administration and audit logs.

UI components are custom PHP/HTML/CSS/vanilla JavaScript. DM Sans and Manrope are served locally. The public product preview is explicitly an illustration. No fabricated users, testimonials, learner totals, ratings, achievements, completed courses or external-integration success are presented.

## Explicitly simplified or intentionally absent

| Area | Boundary |
|---|---|
| Learning time | Estimated credit for qualifying learning events, not an activity timer, attention detector or video-watch verification. |
| Personalisation | Interest/order-based recommendations and deterministic next-step suggestions, not AI. |
| Content authoring | Structured metadata/question/checklist/rubric editors and restricted text rendering; no third-party rich-text editor, SCORM/xAPI import, arbitrary HTML or drag-and-drop graph canvas. |
| Course versions | Draft duplication is supported; there is no per-enrolment immutable release/version-pinning system. Changing live requirements requires operator care. |
| Assignment deadlines | Informative/reminder deadlines; late submissions are allowed. No automatic late penalty. |
| Official rubric | Configurable criteria and one authoritative overall score; not a per-criterion gradebook with mathematical rubric score aggregation. |
| Submission history | Revisions and feedback persist; the current UI shows the timeline/current submission, not full revision diffs or older-file browsing. |
| Notes | Version-conflict detection and ordered autosave; no offline sync, collaborative editor or full historical note-version browser. |
| Certificates | Eligibility-gated public verification and browser print/save-as-PDF, not an accredited credential or separately cryptographically signed PDF artifact. |
| Reports | Persisted previous-week summary/path snapshots, generated in batches; no BI connector, CSV export builder or arbitrary historical backfill command. |
| Streaks | Lifetime milestones; protection for an eligible missed yesterday only, with inventory and calendar-month caps. No promise to repair arbitrary old streak gaps. |
| Authentication | Signed cookies and strict refresh rotation; no MFA, device/session-management screen or cross-tab refresh grace period. An authenticated password-change form exists; password reset is email-based when configured. |
| Email | PHPMailer/queue support exists; SMTP is unconfigured in the preview. External delivery success was not tested. Ambiguous `sending` rows require reconciliation. |
| Other channels | No browser push service, WhatsApp, SMS, payment processor, video-conferencing service or AI provider. |
| Community | Consented buddies, challenges, peer feedback, blocks/reports—not a chat/messaging social network. No peer-feedback XP or cash rewards. |
| Referrals | Conditional virtual rewards with unique-email/no-self/cap checks, not identity verification or comprehensive multi-account fraud detection. |
| Uploads | MIME/type/size/ownership controls, but no antivirus, content disarm, image re-encoding or per-user storage-quota service. |
| Privacy operations | Private-by-default projects/notes and access checks; no self-service account erasure/export. Legal pages require operator-specific review. |
| Production readiness | Tested foundation and deployment examples; not a managed hosting launch, independent penetration test, load certification, legal compliance certification or complete disaster-recovery service. |

## Preview defaults

- Three published starter paths, 14 original lessons and no fabricated learner activity.
- Six skill categories; categories without published paths have honest empty states.
- 30 XP per first eligible lesson completion, 50 per first quiz pass, 100 per accepted assignment.
- Seven configurable levels and one-time milestones; protection enabled with two held/two uses per month. Virtual-coin protection purchases and quiz lives are off.
- Referrals disabled; no cash rewards.
- Portfolio projects private by default.
- Email disabled, support address unset, optional integrations unconfigured.
- Test accounts, files and events belong to the isolated test database, not the public preview’s learner data.

See [QA](QA.md) for exact checks and untested areas, and [deployment](DEPLOYMENT.md) for what an operator must configure before real-world launch.

## Deployment portability

Root and nested-subdirectory deployments now share the same code. APP_URL is the full canonical base, and the shared URL service covers server/client links, assets, API requests, redirects and mail. Ordinary Apache shared hosting can use the supplied project-root bridge without editing PHP include paths. See DEPLOYMENT.md for the required rewrite/protection checks.
