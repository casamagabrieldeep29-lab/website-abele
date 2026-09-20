# 25. DECISION LOG

Architectural and product decisions, and why they were made. Append new entries at the bottom; never delete history — if a decision is reversed, add a new entry explaining the reversal instead of editing the old one.

---

### 2026-09-18 — Product name and branding direction
**Decision:** Name the platform "ABELIEVER". Green-forward color palette (agriculture association), exact shades left to implementation.
**Why:** Gabriel's choice; ABE + "believer" pun fits the target audience (ABE licensure examinees).

---

### 2026-09-18 — Initial scope: small invite-only group, not public platform
**Decision:** Build for Gabriel + a small, possibly-growing group of classmates/reviewees. Invite-only accounts via magic-link email. Gabriel is sole admin.
**Why:** Real near-term need is a small trusted group studying for a November 2026 exam, not a public product launch. Avoids building public-signup/abuse-prevention/multi-admin-permission complexity that isn't needed yet.
**How to apply:** Don't hard-code a fixed small group size anywhere (Gabriel confirmed the group could grow) — auth/db design should scale without a rewrite, even though initial usage is small.

---

### 2026-09-18 — Build sequencing: real architecture now, features shipped incrementally
**Decision:** Set up the actual database schema, auth, and project structure correctly up front (matching the full master-instructions ambition), but prioritize shipping a working Practice Mode + Mock Exam experience within weeks rather than completing every master-doc section in order first.
**Why:** November 2026 exam deadline means a usable review tool is needed soon; but Gabriel explicitly wants the "full platform" architecture, not a throwaway prototype. This sequencing gets both: no rework later, but usable value early.

---

### 2026-09-18 — Tech stack: Next.js + Supabase + Vercel, TypeScript, Tailwind + shadcn/ui
**Decision:** Next.js (TypeScript) for the app, Supabase for database/auth/storage, Vercel for hosting, Tailwind CSS + shadcn/ui for styling.
**Why:** Gabriel had no existing preference and accepted the recommendation. This stack covers auth + database + hosting on generous free tiers, fits a small-to-growing user base, and Tailwind + shadcn avoids the "glassmorphism / decorative clutter" the master doc explicitly warns against (Section 15).
**How to apply:** Don't introduce a second framework/database technology without a matching decision log entry explaining why the above no longer fits.

---

### 2026-09-18 — Repository and code location
**Decision:** Application code lives in this same repo (`website-abele`), in a dedicated `/platform` subfolder, alongside the existing docs (root) and source materials (`ABELE TOP 1/`, `OFFICIAL_SOURCE_FILES/`).
**Why:** Gabriel preferred one repo for everything over splitting code and content across repos, given the small-team/personal-project scale.

---

### 2026-09-18 — Deployment target: Vercel free URL, no custom domain yet
**Decision:** Deploy to a free `*.vercel.app` URL initially. Default to free tiers on all services; a small paid upgrade is acceptable only if a free-tier limit genuinely becomes a blocker, and only with explicit confirmation before spending.
**Why:** No domain owned yet; budget is limited but not zero.

---

### 2026-09-18 — Content strategy: transcribe existing verified Q&A rather than generate new questions
**Decision:** For the pilot content build, extract the exact questions, choices, and answers already present in the `ABELE TOP 1/` review-center materials (which include actual tests with answer keys — e.g. consolidated tests, pre/post tests, area exams), rather than having AI author new exam questions from raw lecture content.
**Why:** This is materially different from the master doc's default assumption (Section 22, content review workflow) that AI-drafted educational content needs human technical review before publishing — here the "authoring" is transcription of already-answer-keyed source material, not invention. Gabriel explicitly directed this ("use the exact questions and answers from the materials, everything is in there") and confirmed he has the right to use this content for personal + group study.
**How to apply:** Transcription accuracy (did we copy the question/choices/answer correctly from the PDF/PPTX) still needs spot-checking — OCR/manual extraction errors are a real risk even when the source is "correct." If new questions are ever authored (not transcribed) for this platform in the future, the default Section 22 human-review workflow applies again — this decision does not blanket-waive review for all future content, only for transcription of existing answer-keyed source material.
**Content boundary:** Raw source PDFs/PPTX/DOCX stay private (never served to or downloadable by end users) — only extracted, structured question/lesson data is exposed through the app, and only to invited/logged-in users, per `01_PROJECT_CONTEXT.md` Section 7.

---

### 2026-09-18 — Content build order: pilot on Area 1 + Area 2 source materials
**Decision:** Build the content extraction pipeline and first working question bank against the source folder's "Area 1" and "Area 2" materials (mapping to Power/Energy/Machinery Engineering and Land & Water Resources Engineering, both 18%-weighted per the PRC Table of Specifications), before extending to Area 3 and the remaining lower-weighted official exam areas.
**Why:** Follows official TOS weighting (highest-value areas first) per Gabriel's choice, and these two source folders have the most complete existing material to pilot against.

---

### 2026-09-18 — Skip password-protected source PDFs for now
**Decision:** Files in `ABELE TOP 1/` with "protected" in the filename are excluded from content extraction until a password is available.
**Why:** No passwords currently available; better to proceed with accessible material than block the pipeline.

---

### 2026-09-18 — New source materials organized; official laws split out
**Decision:** New review materials Gabriel added (`BPSU`, `GREEN GEARS`, `Other Files`, `PAES`, `TRANSES`, ~560MB) are kept under `ABELE TOP 1/` alongside the original set, tracked via Git LFS like everything else there. The `LAWS/` folder (Republic Acts, Executive Orders, Presidential Decrees, IRRs — e.g. RA 10912, PD 1067, National Building Code) was moved out into `OFFICIAL_SOURCE_FILES/PRC/Laws/`.
**Why:** Per the source hierarchy in `00_MASTER_PROJECT_INSTRUCTIONS.md` Section 7, official government legal texts are Level 1 primary sources — distinct in kind and authority from paid review-center materials (Level 3). They belong in the `OFFICIAL_SOURCE_FILES/` structure that was already scaffolded for exactly this purpose, not mixed in with review-center content.

---

### 2026-09-18 — Database schema, RLS, and answer-key protection design
**Decision:** Implemented the initial Supabase/Postgres schema (`platform/supabase/schema.sql`) covering profiles, exam taxonomy (exam_areas → topics → subtopics), questions/choices, attempts/attempt_answers, and bookmarks — scoped to what Practice Mode + Mock Exam actually need (per the sequencing decision above), not the full entity list in Section 20 of the master doc (no lessons/study_sessions/achievements/announcements/reports/content_reviews tables yet — add when a feature actually needs them).

Two things worth calling out specifically:

1. **Role model:** `profiles.role` (`student` | `admin`) drives all authorization, checked via a `is_admin()` SECURITY DEFINER SQL function used throughout RLS policies. A trigger (`prevent_role_self_escalation`) blocks any non-admin from changing their own or anyone's role, independent of policy correctness — defense in depth against the exact "modify records by manipulating requests" risk Section 19 warns about.
2. **Answer-key protection:** Direct `SELECT` on `questions` and `choices` is admin-only. Students read question/choice content through two purpose-built views (`student_questions`, `student_choices`) that expose only safe columns (never `choices.is_correct` or `questions.explanation`/solution fields) and filter to `status = 'published'`. Grading happens exclusively through the `submit_attempt_answer()` RPC (SECURITY DEFINER), which checks the real `choices` table server-side, records the answer, and only then returns the correct choice(s) + explanation to the client.

**Why:** Supabase's anon/authenticated Postgres role is shared by every logged-in user (admin and student alike) — there's no separate "student" vs "admin" Postgres role to lean on, so `GRANT`-based table restriction can't distinguish them. Row-level security also can't selectively hide one *column* (`is_correct`) on an otherwise-visible row. If students could query `choices` directly (even read-only), anyone could open browser dev tools, hit the Supabase REST endpoint directly, and read every answer key — trivially bypassing Practice Mode's "answer then see feedback" flow. This view+RPC pattern is the standard way to close that gap in Postgres/Supabase, and it directly serves Section 1 of the master doc's priority order (accuracy/integrity above usability/polish).

**How to apply:** Any new feature that reads question content for students must go through `student_questions`/`student_choices` (or a similarly-scoped future view/RPC) — never add a permissive student-facing `SELECT` policy directly on `questions` or `choices`. Any new graded-answer feature must go through a SECURITY DEFINER RPC that checks ownership, not a direct client `INSERT`/`UPDATE` into `attempt_answers`.

**Known limitation (labeled, not hidden):** `question_type = 'numerical'` exists as a schema value but has no working grading path yet (no tolerance-checked free-response answer comparison). Not blocking the pilot since the ATTRC source materials being transcribed are themselves multiple-choice. Treat this as a documented gap, not a silent omission, if/when free-response numerical questions are needed.

**Not yet applied:** This schema hasn't been run against a live Supabase project yet — need Gabriel's project URL + anon key (+ service role key for the admin invite flow, next) to actually deploy and test it.

---

### 2026-09-18 — Bug fix: admin bootstrap was blocked by its own safeguard
**Decision:** Changed `prevent_role_self_escalation()` to only block a role change when `auth.uid() is not null`.
**Why:** The schema went live and Gabriel hit this immediately while trying to bootstrap himself as the first admin via the SQL Editor: `update profiles set role='admin' where email=...` failed with `Only admins can change roles.` The trigger was checking `is_admin()`, which depends on `auth.uid()` — but SQL run directly in the SQL Editor (or by any service-role/direct-Postgres access) has no authenticated request context, so `auth.uid()` is `NULL` and `is_admin()` came back false, tripping the guard meant for the app's normal login path.
**How to apply:** Anyone with SQL Editor / service-role / direct-Postgres access already has full control over the database regardless of this trigger (they could just disable it), so exempting `auth.uid() IS NULL` callers doesn't open a new privilege-escalation path — it only stops the trigger from blocking the database owner's own legitimate direct access. The trigger still fully blocks a logged-in student's own session (where `auth.uid()` is their real ID) from touching `role` via the app's normal RLS-governed path, which is the actual threat it exists to stop.

---

### 2026-09-18 — Product pivot: commercial one-time-payment ABE prep platform

**Decision:** After Practice Mode and Mock Exam were both verified working, Gabriel provided a 28-feature specification (personalization, adaptive practice, mistake bank, study tools, gamification, AI assistance, invite-code/payment-ready access) with the explicit goal of eventually selling access for a one-time payment (~₱699, no subscription). He asked for an architecture/build-order plan before any code changes, and to implement in phases with "coming soon" placeholders for anything not built yet — not all 28 features at once.

**Why:** The original small-group tool has proven the core mechanics (content pipeline, auth, RLS/RPC answer-key protection, Practice/Mock). Gabriel wants to build toward a real product on that foundation rather than starting over.

**Approach taken:** Entered plan mode, produced a full architecture review (current state, reusable pieces, what's new, technical risks, phased build order) at `C:\Users\Gabriel\.claude\plans\shimmering-foraging-stardust.md`, got explicit approval before writing any code. First round scope: dashboard reshape with real "Coming soon" placeholders for the full 28-feature shape (Phase 0), Mock Exam mark-for-review (Phase 1 gap-close), and Personalization built for real — mastery, least-mastered areas, today's recommendation, mistake bank, adaptive question selection, basic analytics (Phase 2/5).

**How to apply:** Future phases (Quick Practice, Custom Quiz Builder, Study Plan Generator, Concept-level hierarchy, Notes, Question of the Day, persisted Achievements, AI features, invite-code/payment architecture, admin quality tooling) stay as dashboard placeholders — see `26_BUILD_CHECKLIST.md` Phase 8 — until Gabriel asks to build each one, following the same plan-then-approve-then-build-then-verify rhythm as everything else in this project.

---

### 2026-09-18 — Mastery, recommendation, and adaptive-selection algorithms

**Decision:** Documented, non-random formulas (not opaque/arbitrary), enforced at the database/server level:

- **Mastery** (`get_topic_mastery()`): `0.6 × recent_accuracy + 0.4 × overall_accuracy`, where recent = last min(10, n) graded answers in that topic. Only computed once a topic has ≥5 graded attempts; below that, `status = 'insufficient_data'` and no percentage is shown at all. Bands: ≥80 Strong, 60–79 Developing, <60 Needs Review.
- **Today's Recommendation** (dashboard): `priority = (100 - effective_mastery) + min(days_since_last_practiced, 14)×2 + (insufficient_data ? 15 : 0)`, where `effective_mastery` defaults to 50 when there isn't enough data yet. Highest-priority topic with ≥5 published questions wins. Documented inline in `dashboard/page.tsx`.
- **Mistake Bank** (`get_mistake_bank()`): a question is "currently a mistake" if the caller's *most recent* answer to it was wrong — self-corrects after one clean retry. This is a simplified reading of the spec's "remove after consistent mastery" (single retry, not N-in-a-row); noted here as an explicit interpretation, not an oversight.
- **Adaptive selection** (`startAdaptivePracticeAttempt`): weighted random sample without replacement — weight 3 for a question the user most recently got wrong, 1.5 for never-attempted, 1 for previously-correct.

**Why:** Gabriel's spec explicitly required "do NOT make the recommendation random" and "create a sensible... algorithm... document how it's calculated" for multiple features. Keeping the formulas simple, linear, and code-commented (rather than a black-box ML model) makes them auditable and cheap to recompute on every dashboard load at the current data scale.

**How to apply:** These weights/thresholds are tunable constants, not fixed forever — if they produce bad recommendations once there's more real usage data, adjust the constants (documented in `schema.sql` and `dashboard/page.tsx`) rather than the overall approach. Revisit the mistake-bank "one retry clears it" simplification if Gabriel wants stricter "N consecutive correct" behavior later.

**Known limitation:** All of this operates at topic granularity only — there's no concept-level tagging yet (Phase 8), so "adaptive" selection currently can't target something as specific as "centrifugal pumps," only "the whole topic containing pumps." Documented, not silently omitted.

---

### 2026-09-18 — Payment/access handled manually by Gabriel, not built into the app

**Decision:** Removed the "invite-code + payment-ready access architecture" item from Phase 8 scope entirely. No `access_codes`/`purchases` tables, redemption flow, or payment-status UI exist or will be built.

**Why:** Gabriel explicitly said access will be sold via direct communication with him (GCash payment, manually granted) rather than through any in-app code/payment flow — mid-round, after an `access_codes`/`purchases` schema draft had already been added to `schema.sql`; that draft was fully removed before the accompanying patch file was finalized.

**How to apply:** Do not reintroduce invite-code redemption, payment tracking, or subscription/access-tier schema unless Gabriel explicitly asks for it again. The existing invite-only magic-link auth (Gabriel manually invites each paying user via `/admin`) already covers "only people who paid get an account" — that's the actual access-control mechanism, and it needs no further building.

---

### 2026-09-18 — AI provider: Google Gemini, not Anthropic

**Decision:** "Teach Me This" and the AI Study Assistant (both previously blocked pending a provider API key) are built on Google Gemini via `@google/genai`, behind a small `AIProvider` interface (`platform/src/lib/ai/types.ts`) rather than calling the Gemini SDK directly from route handlers.

**Why:** Gabriel supplied a Gemini key, not an Anthropic one, with an explicit instruction not to build a vendor-specific dead end — a future switch to a different provider should mean writing one new file that implements `AIProvider`, not rewriting the routes/UI that call it. There was no pre-existing Anthropic integration in this codebase to migrate away from (confirmed by grep before starting — no Anthropic SDK dependency, no `ANTHROPIC_API_KEY` usage, no AI routes of any kind existed yet); this was a net-new build, not a migration.

**How to apply:** Any new AI-backed feature should call `getAIProvider()` from `lib/ai/index.ts` and go through a route handler under `app/api/ai/*`, not instantiate a Gemini client directly. The anti-hallucination system-prompt rules and per-user daily rate limit (`check_and_log_ai_usage`, configurable via `AI_DAILY_LIMIT`) are shared infrastructure — reuse them rather than writing feature-specific copies. The AI layer only ever explains data the deterministic backend (mastery/recommendation/grading RPCs) already computed — it must never be given authority to decide correctness or invent a statistic not present in the verified context passed to it.

---

### 2026-09-19 — Mock Exam rebuilt to match the real PRC ABE board exam structure (Area 1/2/3)

**Decision:** Replaced the free-form Mock Exam setup (pick any question count/time limit/topic mix) with the actual board exam format: three separate subject exams — Area 1, Area 2, Area 3 — each a fixed 100-item, 3-hour timed exam, taken one at a time. This is a different grouping from the 8 official PRC Table-of-Specifications `exam_areas` already in the schema (those stay as-is for TOS weighting/mastery purposes); Area 1/2/3 is the actual exam-day subject split.

**Mapping agreed with Gabriel** (topics get exactly one default `mock_area`):
- Area 1: Power/Energy/Machinery, Laws/Professional Standards/Ethics
- Area 2: Land and Water Resources
- Area 3: Structures/Environment, Bioprocess, Project Mgmt/Feasibility/RDE, Fundamentals of Sciences, Math/Basic Engineering

**Why:** This project's own earlier notes (`01_PROJECT_CONTEXT.md` Section 9) already flagged that the review-center source materials' own "Area 1/2/3" folders don't map 1:1 to the 8 TOS categories and would need reconciling — this is that reconciliation, done directly with Gabriel rather than guessed, because getting this wrong means simulating the wrong exam.

**Question-level override:** A question can also be individually tagged into an *additional* area (`questions.additional_mock_areas`) when an admin judges it topically relevant there too (Gabriel's example: an Engineering Economy question about machinery costs, tagged into Area 1 in addition to its home Area 3). This is deliberately a manual per-question admin call (new checkbox control in `/admin/content/[topicId]`), not an automatic keyword rule — content accuracy over convenience, same principle as the rest of this project's content pipeline.

**How to apply:** Any future question import/authoring should set (or leave to the topic default) `mock_area`, and use `additional_mock_areas` sparingly and deliberately — don't auto-tag by keyword matching. If the real board exam's Area 1/2/3 subject split is ever confirmed to have changed, update the `case` mapping in `supabase/patches/007_mock_exam_areas.sql` and re-run the backfill, don't hand-edit individual topics.

---

### 2026-09-19 — Security audit pass (Admin CMS, Bookmarks, Preparation Profile)

**Decision:** Self-reviewed everything added in this round — Preparation Profile, Admin Quality Tooling, Admin Group Performance, Admin Topics/Subtopics management, real question editing/creation/archiving, and Bookmarks. No new RLS or admin-bypass mechanism was needed; every new admin page/action either calls the existing `requireAdmin()` guard or relies on RLS policies that already permit `is_admin()` to bypass (e.g. Group Performance reads `attempts`/`attempt_answers` across all users using the same policy Practice/Mock already rely on for the caller's own rows).

**Findings:**
- All new admin server actions (`admin/content/actions.ts`, `admin/topics/actions.ts`) call `requireAdmin()` first — confirmed by direct read of every new function, not just spot-checked.
- Preparation Profile reads only the caller's own data (`auth.uid()`-scoped via existing RLS and `get_topic_mastery()`), so there's no cross-user leakage risk in that feature.
- Bookmarks toggling uses direct client calls against `bookmarks`' existing plain RLS (own-row); listing goes through a new SECURITY DEFINER RPC (`get_my_bookmarks()`) scoped to `auth.uid()`, same pattern as `get_my_notes()` — verified by comparing the two function bodies side by side.
- Topic/subtopic deletion is guarded against orphaning published content: deleting a topic with any questions still attached is blocked by the existing FK (`on delete restrict`) and surfaced as a friendly error rather than a raw Postgres error; subtopic deletion is safe by design (`on delete set null` on `questions.subtopic_id`).
- A real bug was caught and fixed during in-browser testing (not a security issue, but caught by the same "test everything, don't trust code review alone" discipline): nested `<form>` elements in `/admin/topics` (a delete button's form nested inside a rename form) — invalid HTML, caused a hydration error. Fixed by making them sibling forms.

**Not covered by this pass:** the new admin CMS doesn't add its own additional safeguard against a single admin fat-fingering a bulk delete — acceptable for now since Gabriel is sole admin and every destructive action requires an explicit per-row click, not a bulk operation.

**How to apply:** Any future admin-only page/action must call `requireAdmin()` as its first line — this is now the established, audited pattern; don't introduce a new authorization check without a reason to deviate.

---

### 2026-09-19 — Reviewers, Flashcards, Mistake Bank drill-down, two-column layout, dark mode: reused the existing taxonomy, no parallel hierarchy

**Decision:** The spec for these features described an ideal `Subject → Area → Topic → Concept` hierarchy. The real schema only has three levels (`exam_areas` → `topics` → `subtopics`), with no separate "Subject" tier. Rather than add one, Reviewer entries and Flashcards both FK directly to `topic_id` (required) + `subtopic_id` (optional), exactly mirroring how `questions` already works — `exam_areas` doubles as both "Subject" and "Area" from the spec, `subtopics` as "Concept."

**Why:** The spec itself said "if the current taxonomy is implemented differently, inspect it first and adapt rather than creating a parallel taxonomy" — a 4th level existing only for two new content types, while every other feature (questions, mistakes, mastery, mock exam areas) stays on 3 levels, would fragment the data model for no real benefit at this content scale.

**Schema:** `reviewer_entries` is one flexible table with a `kind` discriminator (`formula`/`table`/`constant`) rather than three near-duplicate tables, since they share most fields. Neither `reviewer_entries` nor `flashcards` needed a "safe view" the way `questions`/`choices` do — there's no secret answer key to protect (a flashcard's back and a formula's value are both meant to be readable once published), so RLS is just admin-write / published-read. `flashcard_progress` tracks real per-user state (seen/known counts, last state, saved) — Weak-Area and Mistakes-linked study modes pull topic IDs from the EXISTING `get_topic_mastery()`/`get_mistake_bank()` RPCs, never a new/fabricated mastery number.

**Theme system quirk (Next.js 16.3.5):** The standard flash-of-wrong-theme prevention pattern (a blocking inline `<script>` in the root layout, or even `next/script` with `strategy="beforeInteractive"` placed as a sibling of `<body>` per the bundled docs example) both triggered real Next.js dev-mode errors in this version — "Encountered a script tag while rendering React component," compounding to multiple errors when following the docs' exact placement. Resolved by dropping the blocking script entirely and using `useLayoutEffect` (fires before paint) in the theme provider instead — a well-understood, standard trade-off (no flash for most users, a brief one on first load only for users who've overridden system preference) rather than fighting framework internals further. Flagged here per `AGENTS.md`'s own warning that this Next.js version has breaking changes from training-data expectations.

**Known pre-existing issue, not introduced by this work:** the shadcn Sidebar's `useIsMobile()` hook causes a dev-only hydration-mismatch warning at viewport widths right around the mobile breakpoint (confirmed reproducible on a completely fresh tab, present before any of this round's changes, cosmetic/dev-overlay-only). Not fixed — out of scope for this round and risky to alter working navigation without being asked.

**How to apply:** Any future content type needing topic/area classification should FK to `topics`/`subtopics` the same way, not introduce a new grouping level. Any future weak-area or mistake-linked feature should call the existing mastery/mistake RPCs, never compute or store a second mastery number.

---

### 2026-09-21 — Area 1/2/3 mapping corrected from the official 2025 ABE Table of Specifications (Annex "A")

**Decision:** The 2026-09-19 Area 1/2/3 mapping entry above is **superseded**. Gabriel supplied the actual signed PRC document (`2025 ABE Table of Specifications Annex.pdf`), which lays out the exam as three combined subject papers, not the mapping guessed on 2026-09-19:
- **Area 1 / Subject A (32%):** POWER_ENERGY_MACHINERY, LAWS_ETHICS, **PROJECT_MGMT_RDE**
- **Area 2 / Subject B (32%):** LAND_WATER, **FUNDAMENTALS_SCIENCES**, MATH_BASIC_ENGG
- **Area 3 / Subject C (36%):** STRUCTURES_ENVIRONMENT, BIOPROCESS

The two changes from the old mapping: Project Management/Feasibility/RDE moves from Area 3 to Area 1, and Fundamentals of Agricultural/Fishery/Ecological/Environmental Sciences moves from Area 3 to Area 2. Math/Basic Engineering's move to Area 2 (already applied ad hoc in `017_reclassify_math_metrology_topics.sql`) is confirmed correct by the same document.

**Why:** The 2026-09-19 mapping was reconciled by inference (review-center folder structure vs. the 8 TOS categories) without the actual board document in hand. Gabriel later provided the real Annex "A", which states the three-paper split explicitly and even names "metrology equipment" as a competency under Subject A's Automation/Instrumentation section (page 4, item IV.2) — confirming "Engineering Metrology and Equipment" belongs under the existing Area 1 Automation subject, not a new Area 3 one (`019_new_automation_subject_area3.sql` had briefly created a duplicate for this before the document surfaced; `020_correct_area_mapping_from_official_tos.sql` reverts it and removes the duplicate subject).

**How to apply:** `007_mock_exam_areas.sql`'s original CASE mapping is now wrong and should not be re-run as-is; `020_correct_area_mapping_from_official_tos.sql` is the current source of truth for the Area 1/2/3 <-> TOS-category mapping. If the real board exam's structure is ever confirmed to change again, get the actual PRC document first rather than reconciling by inference — that's what caused this round of back-and-forth.
