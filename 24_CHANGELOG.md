# 24. CHANGELOG

Record of major changes: what changed, why, what it touched, and how it was tested. See `25_DECISION_LOG.md` for the reasoning behind architectural choices — this file is the "what happened and when," that one is the "why we chose this."

---

## 2026-09-18 — Practice Mode working end-to-end (first verified feature)

**Change:** Practice Mode is live and confirmed working by Gabriel through a real browser session — topic selection, question-by-question practice with instant feedback, and a completion score screen.

**Affected files:**
- `platform/src/app/practice/page.tsx`, `platform/src/app/practice/actions.ts`
- `platform/src/app/practice/[attemptId]/page.tsx`, `practice-session.tsx`
- `platform/src/app/admin/content/page.tsx`, `[topicId]/page.tsx`, `actions.ts` (publish workflow, needed first since imported content starts as `draft`)
- `platform/supabase/schema.sql` (bug fix, see below)

**Database changes:** Fixed `public.submit_attempt_answer()` — the `RETURNS TABLE (is_correct boolean, ...)` clause implicitly declares `is_correct` as a variable in the function's scope, which collided with the unqualified `choices.is_correct` reference in the grading query, causing every answer submission to fail with `column reference "is_correct" is ambiguous`. Fixed by qualifying the column via a table alias. Applied directly to the live Supabase project's SQL Editor.

**Testing performed:** Full manual walkthrough by Gabriel — published a topic's questions via `/admin/content`, ran through `/practice`, hit the ambiguous-column bug on the first submission, confirmed the fix resolved it on retry. This is the first feature in the project verified through actual use rather than just build/lint passing (per `00_MASTER_PROJECT_INSTRUCTIONS.md` Section 29 — passing a build is not the same as a feature working).

**Known issues / follow-ups:**
- Content review responsibility is working as intended: Gabriel caught a real answer-key error in the imported source material during review (see below) rather than publishing it as-is.
- Mock Exam, Progress, and further content extraction are still not started — see `26_BUILD_CHECKLIST.md`.

---

## 2026-09-18 — Corrected answer key: vermi cast shredder question (Topic III, difficult)

**Change:** The question "What is the weight of agricultural waste that is needed annually to optimally operate a 26-ampere 6-kw vermi cast production shredder..." previously matched the source material's stated answer (choice C, 1,750 tonnes) despite that source's own worked solution computing 1,075 tonnes (choice B) — this was flagged for review at import time rather than silently trusted. Gabriel reviewed it and confirmed B is correct.

**Reason:** Internal inconsistency in the original source material (Tambong Area 1 Part I) between its stated answer and its own shown arithmetic. Resolved in favor of the arithmetic per Gabriel's review.

**Affected:** `choices.is_correct` flipped (B → true, C → false) for this question in the live database; `explanation` updated to record the correction; source JSON (`platform/supabase/seed/content/area1-tambong-part1.json`) updated to match, so a future re-import of this batch won't regress the fix.

**Testing performed:** Verified via direct query before/after the update; not yet re-tested through the Practice Mode UI specifically for this question.

---

## 2026-09-18 — Mock Exam working end-to-end (second flagship feature)

**Change:** Mock Exam is live and confirmed working by Gabriel — configurable question count/topic filter/time limit, timed session with a question navigator (jump between questions freely, unlike Practice Mode's linear flow), no per-question feedback during the exam, submission with automatic scoring, and a post-exam per-question review.

**Affected files:**
- `platform/src/app/mock/page.tsx`, `actions.ts`
- `platform/src/app/mock/[attemptId]/page.tsx`, `mock-exam-session.tsx`
- `platform/src/app/mock/[attemptId]/results/page.tsx`
- `platform/supabase/schema.sql` — two new functions: `record_mock_answer()` (grades silently, no reveal — Mock Exam must not leak correctness mid-exam the way Practice Mode intentionally does) and `get_attempt_review()` (reveals full answer key + explanation, but only for the caller's own attempts once `status = 'completed'`)
- `platform/src/lib/supabase/proxy.ts` — route protection list had `/exam` (a route that was never built) instead of `/mock` (the one that was); fixed.

**Database changes:** Applied via `platform/supabase/patches/002_mock_exam_functions.sql`, run directly in the Supabase SQL Editor (the browser session I'd been using to apply small fixes directly had logged out by this point, so this one went back to the manual copy-paste path).

**Testing performed:** Full manual walkthrough by Gabriel — configured an exam, answered questions while jumping around via the navigator, submitted, confirmed the results/review page. No bugs reported this time.

**Milestone:** Both features named in the original build-sequencing decision (`25_DECISION_LOG.md`, "real architecture now, ship Practice + Mock Exam first") are now done and verified. Next per `26_BUILD_CHECKLIST.md`: Vercel deployment (so the group can actually reach this without a local dev server) and continued content extraction.

---

## 2026-09-18 — Personalization features (mastery, recommendations, mistake bank, adaptive practice) working end-to-end

**Change:** Following Gabriel's decision to evolve the product toward a commercial, personalized ABE prep platform (see `25_DECISION_LOG.md`), built and verified the first real personalization round: dashboard with real computed analytics (questions answered, accuracy, average mastery, day streak), per-topic mastery scoring, "Today's Recommendation," "Least Mastered Areas," a self-correcting Mistake Bank, weighted-adaptive practice-session generation, and a "mark for review" control in Mock Exam. The dashboard also now shows "Coming soon" cards for every feature from Gabriel's 28-feature spec that wasn't built this round — the full future shape of the product, with zero fake data behind any of it.

**Affected files:**
- `platform/src/app/dashboard/page.tsx` (full rewrite of the dashboard)
- `platform/src/app/practice/actions.ts` (added `startAdaptivePracticeAttempt`, `startMistakeRetryAttempt`, `weightedSample` — existing `startPracticeAttempt` untouched)
- `platform/src/app/practice/[attemptId]/page.tsx` (now respects `attempt.config.question_ids` when present, for adaptive/mistake-retry sessions; unchanged behavior when absent)
- `platform/src/app/mistakes/page.tsx`, `mistake-bank-view.tsx` (new)
- `platform/src/app/mock/[attemptId]/mock-exam-session.tsx` (mark-for-review)
- `platform/src/lib/supabase/proxy.ts` (added `/mistakes` to protected routes)

**Database changes:** Two new SECURITY DEFINER functions, `get_topic_mastery()` and `get_mistake_bank()` (`platform/supabase/patches/003_mastery_and_mistake_bank.sql`), applied by Gabriel via the SQL Editor.

**Testing performed:** Full manual walkthrough by Gabriel — dashboard numbers, mistake bank list + retry, mark-for-review in a mock exam. Confirmed working, no bugs reported.

**Follow-up:** Plan file at `C:\Users\Gabriel\.claude\plans\shimmering-foraging-stardust.md` and `26_BUILD_CHECKLIST.md` Phase 8 track the remaining 28-feature scope (Quick Practice, Custom Quiz Builder, Study Plan, Concept hierarchy, Notes, Question of the Day, persisted Achievements, AI features, invite-code/payment architecture) — deferred, placeholders only, to be built one phase at a time on request.

---

## 2026-09-18 — Quick Practice, Custom Quiz Builder, and Personal Notes working end-to-end

**Change:** Three more Phase 8 items built and verified: Quick Practice (`/quick` — 10/20/50 adaptive sessions drawn from every published topic, not scoped to one), Custom Quiz Builder (`/quiz-builder` — filter by topic/difficulty/source [all, previously-incorrect, unanswered], never pads with duplicate questions if the filtered pool is smaller than requested — the session page shows a plain notice when that happens instead of silently serving fewer questions), and Personal Notes (a private per-question note in Practice Mode only — deliberately excluded from Mock Exam, which should feel like a real timed test — plus a `/notes` page to review/edit/delete everything saved).

**Affected files:**
- `platform/src/app/practice/actions.ts` — extracted shared `weighCandidates()` helper from the existing adaptive-topic logic; added `startQuickPractice`, `startCustomQuiz` (form-based, not object-based, specifically to avoid a `redirect()`-inside-`try/catch` footgun in a client component — see below), `startMistakeRetryAttempt` was already there
- `platform/src/app/practice/notes-actions.ts` (new), `platform/src/app/practice/[attemptId]/practice-session.tsx` (note UI), `platform/src/app/practice/[attemptId]/page.tsx` (fetches notes + shows the "adjusted count" banner via a `?requested=` search param)
- `platform/src/app/quick/page.tsx`, `platform/src/app/quiz-builder/page.tsx` + `quiz-builder-form.tsx`, `platform/src/app/notes/page.tsx` + `notes-list.tsx` (all new)
- `platform/src/lib/supabase/proxy.ts` — added `/quick`, `/quiz-builder`, `/notes` to protected routes
- `platform/src/app/dashboard/page.tsx` — these three moved from "Coming soon" to real linked cards

**Database changes:** New `question_notes` table (plain RLS, own-row only) + `get_my_notes()` SECURITY DEFINER function (needed to join in `question_text`, since `questions` stays admin-only for direct SELECT). Applied via `platform/supabase/patches/004_question_notes.sql`.

**Design note (not a bug, a deliberate fix while building):** The Custom Quiz Builder was first written with an object-argument server action (`startCustomQuiz(filters)`) called directly from a client component with a `try/catch` around it. That's a real footgun — `redirect()` inside a Next.js server action throws a special control-flow error, and a blanket `catch` around a direct call can mistake a *successful* redirect for a thrown error. Rewrote it as a form-based action (`FormData` in, same pattern as the already-working Mock Exam setup form) before it ever shipped, so this never actually broke in front of Gabriel — noted here so the same mistake isn't repeated for a future object-style action.

**Testing performed:** Full manual walkthrough by Gabriel — Quick Practice pulled from all topics, Custom Quiz Builder's filters worked, notes saved/edited/deleted correctly and showed up on `/notes`. Confirmed working, no bugs reported.

---

## 2026-09-18 — Dashboard/UI redesign (sidebar shell, typography fix, hero, Progress page)

**Change:** Full presentation-layer redesign per Gabriel's request — the app looked "too plain, text-heavy, like a university portal" and he wanted a premium EdTech feel. No backend logic, data, RLS, or routes changed; this was scoped and executed via plan mode (`C:\Users\Gabriel\.claude\plans\shimmering-foraging-stardust.md`), approved before implementation.

**Real bug found and fixed, not just a style choice:** `globals.css` had `--font-sans: var(--font-sans);` — a self-referencing CSS variable that never resolved, silently breaking Tailwind's `font-sans` utility and causing the browser's default (serif, in most contexts) fallback everywhere. This is what Gabriel was actually seeing as "heavy serif typography." Fixed to `--font-geist-sans` (the variable `next/font/google` already provides in `layout.tsx`) — zero new dependencies, Geist Sans now actually renders. Visually confirmed on the public landing page.

**Affected files:**
- `platform/src/app/globals.css` (the font-variable fix)
- `platform/src/components/app-sidebar.tsx` (new), `platform/src/app/(app)/layout.tsx` (new) — a route-group shell (sidebar + top bar) wrapping the "hub" pages, added via `npx shadcn add sidebar avatar dropdown-menu sheet skeleton`
- Moved (not rewritten) into the `(app)` group: `dashboard/`, `practice/page.tsx`, `mock/page.tsx`, `mistakes/page.tsx`, `quick/page.tsx`, `quiz-builder/page.tsx`, `notes/page.tsx` — each had its per-page inline `<header>` removed (now provided once by the shell) and imports to sibling files that stayed in place (e.g. `practice/actions.ts`) switched to the `@/app/...` absolute alias
- **Deliberately left outside the shell**, per the redesign's own "exam mode should feel focused, not busy" requirement: `practice/[attemptId]/*`, `mock/[attemptId]/*` (+ `/results`) — these keep their own minimal header, restyled (larger, bolder answer-choice buttons) but logic untouched
- `platform/src/app/(app)/dashboard/page.tsx` — rewritten as a real hero + prominent recommendation card + compact stat row (small bar indicators instead of giant number boxes) + severity-colored Least Mastered + a genuinely new "Continue Reviewing" backed by a new recent-attempts query (`attempts` table, own-row RLS, no new RPC) + a Quick Actions strip + a trimmed "Coming soon" list
- `platform/src/app/(app)/progress/page.tsx` (new) — the deeper analytics page split out of the dashboard: full per-topic mastery bars, a hand-built weekly accuracy trend (bucketing the same `attempt_answers` rows already being fetched — **no new charting dependency**, honest empty state under ~10 answers), recent mock exam history
- `platform/src/hooks/use-mobile.ts` — this shadcn-generated file had its own real lint violation (`react-hooks/set-state-in-effect`, calling `setState` synchronously in an effect body); fixed with a lazy `useState` initializer instead of suppressing the rule

**Database changes:** None. No schema, RLS, or RPC changes at all in this round — confirmed by the plan's own inspection findings before starting.

**Testing performed:** `npm run build` + `npm run lint` clean. Visually confirmed the font fix on the (unauthenticated) public landing page. **The full authenticated experience — sidebar nav, dashboard, new Progress page, Practice/Mock session polish, and mobile layout — has not yet been tested in a real browser** (no authenticated session available on my end this round); handed off to Gabriel to walk through on both desktop and phone before this is considered done.

---

## 2026-09-18 — Phase 8 continued: Study Plan, Question Bank, Question of the Day, persisted Achievements

**Change:** Built the remaining rule-based (non-AI) Phase 8 items: a Study Plan Generator (`/study-plan` — cycles a fixed 7-slot activity list across user-chosen weekdays up to a target exam date, resolving weak-area slots against live mastery data at generation time), a Question Bank browse page (`/question-bank` — Area → Topic → Subtopic drill-down with published-question counts, the "concept-level hierarchy" item, reusing existing `subtopics` rather than adding new schema), a deterministic Question of the Day (same question for everyone each day — hash of the day-number over the published question pool, no scheduler/table needed — with an anonymized aggregate "% answered correctly" stat once ≥5 people have answered), and persisted Achievements (awarded via a SECURITY DEFINER RPC on attempt completion, not live-computed, so a threshold badge like 90% accuracy isn't lost if performance later dips).

**Affected files:**
- `platform/src/app/study-plan/actions.ts`, `platform/src/app/(app)/study-plan/page.tsx` (new)
- `platform/src/app/(app)/question-bank/page.tsx` (new)
- `platform/src/lib/daily-question.ts` (new — `pickDailyQuestionId`, `todayStartIso`), `platform/src/lib/achievements.ts` (new — `ACHIEVEMENTS` display metadata)
- `platform/src/app/practice/actions.ts` — added `startSubtopicPracticeAttempt`, `startDailyQuestion`; `completePracticeAttempt`/`platform/src/app/mock/actions.ts`'s `completeMockExam` both now also call `check_and_award_achievements()`
- `platform/src/app/practice/[attemptId]/page.tsx` — new session labels for `concept`/`daily` attempt kinds
- `platform/src/components/app-sidebar.tsx` — Question Bank + Study Plan added as real nav items, "Resources" placeholder group removed
- `platform/src/app/(app)/dashboard/page.tsx` — real Question of the Day card and Achievements badges wired in; "Coming soon" trimmed down accordingly
- `platform/src/lib/supabase/proxy.ts` — added `/question-bank`, `/study-plan` to protected routes

**Database changes:** `study_plans` table (one row per user, `unique(user_id)` so regenerating replaces it), `user_achievements` table + `check_and_award_achievements()` RPC (7 threshold codes: FIRST_100, FIVE_HUNDRED, ONE_THOUSAND, ACCURACY_90, MOCK_COMPLETE, STREAK_7, STREAK_14; idempotent via `unique(user_id, achievement_code)` + `on conflict do nothing`), `get_daily_question_stats()` RPC. Applied via `platform/supabase/patches/005_phase8_continued.sql`.

**Scope correction mid-round:** An access-code/purchase-tracking schema section was drafted for the "invite-code + payment-ready architecture" checklist item, then fully removed before this patch was finalized — Gabriel clarified payment/access will be handled entirely manually via GCash, outside the app; no invite-code redemption or payment schema/UI should exist. See the decision log entry below.

**Testing performed:** `npm run build` + `npm run lint` clean. **Not yet manually browser-tested** — handed off to Gabriel.

---

## 2026-09-18 — "Teach Me This" + AI Study Assistant, powered by Google Gemini

**Change:** Built the two AI features that had been blocked pending a provider API key. Gabriel supplied a Gemini key (not Anthropic, per his own direction) and a detailed spec: server-only key, a small provider abstraction (not permanently tied to one vendor), the database as the source of truth for correctness (Gemini only explains verified answers, never decides them), an explicit anti-hallucination system prompt (no invented PRC rules/laws/standards/citations), a per-user daily request limit, and friendly error messages with no leaked provider errors.

**"Teach Me This":** inline in Practice Mode's post-answer feedback and Mock Exam's post-completion review — a collapsed "🤖 Teach me this" link that, on click, sends the question's verified context (question, choices, correct answer, official explanation, topic/subtopic/exam-area) to Gemini and renders a structured explanation (Concept / Why the answer is correct / Why the other choices are wrong / Remember), plus follow-up quick actions (Explain simpler, Give an example, Quiz me on this concept).

**AI Study Assistant:** a small chat box on `/progress` ("Ask about your progress…") that answers questions about the user's own real analytics (mastery per topic, overall accuracy, mistake-bank size) — every number in the prompt comes from the same RPCs/queries the rest of the app already uses; the deterministic recommendation/mastery engine itself is untouched, Gemini only explains its output.

**Affected files:**
- `platform/src/lib/ai/types.ts`, `gemini.ts`, `index.ts` (provider abstraction + factory — swapping providers later means one new file implementing `AIProvider`, not touching call sites), `prompts.ts` (system instructions + prompt builders, anti-hallucination rules shared by both features)
- `platform/src/app/api/ai/teach-me/route.ts`, `platform/src/app/api/ai/study-assistant/route.ts` (new — the app's first API routes; auth check, rate-limit check, verified-context fetch, Gemini call, friendly-error mapping)
- `platform/src/components/teach-me-this.tsx`, `study-assistant.tsx` (new client components)
- `platform/src/app/practice/[attemptId]/practice-session.tsx`, `platform/src/app/mock/[attemptId]/results/page.tsx` — `<TeachMeThis>` wired into the existing feedback/review blocks
- `platform/src/app/(app)/progress/page.tsx` — `<StudyAssistant>` added above the existing trend chart
- `platform/src/app/(app)/dashboard/page.tsx` — the last "Coming soon" placeholder (Teach Me This) removed, now real

**Dependencies:** added `@google/genai` (current official Google Gen AI SDK). No Anthropic SDK was ever added to this project — there was nothing to remove or migrate away from.

**Database changes:** `ai_usage` table (per-user per-day request count) + `check_and_log_ai_usage(p_daily_limit)` RPC (atomic check-and-increment via row lock, SECURITY DEFINER, `auth.uid()`-scoped — a user can't burn another user's quota) and `get_teach_me_context(p_attempt_id, p_question_id)` RPC (the only way the app fetches a question's real answer key/explanation for an AI prompt — verifies, same as `get_attempt_review`, that the caller owns the attempt and has actually already answered that question, so it can't be used to peek at an unanswered question's answer key). Applied via `platform/supabase/patches/006_ai_gemini_usage.sql`.

**Environment:** `GEMINI_API_KEY` (server-only, never `NEXT_PUBLIC_*`), `GEMINI_MODEL` (default `gemini-3.1-flash-lite` — updated 2026-09-19 after `gemini-2.5-flash` returned 404 "no longer available to new users" and its suggested replacement `gemini-3.6-flash` was itself intermittently 503 "high demand"; `gemini-3.1-flash-lite` tested clean across 8 consecutive calls before adopting), `AI_DAILY_LIMIT` (default 15/user/day) — all in `.env.local`, all gitignored.

**Security self-check performed:** grepped the codebase to confirm `GEMINI_API_KEY` is referenced in exactly one place (`lib/ai/index.ts`, `server-only`-guarded); confirmed no client component or API response ever includes the key; confirmed both routes 401 unauthenticated requests and use the same ownership-checked RPC pattern as the rest of the app for any per-user or per-attempt data.

**Testing performed:** `npm run build` + `npm run lint` clean (including the two new API routes compiling). **Not yet manually tested against a live Gemini response in-browser** — the schema patch needs to be run in Supabase first (see `26_BUILD_CHECKLIST.md`), then Gabriel should click through "Teach Me This" on a real question and try the Study Assistant on `/progress`.

---

## 2026-09-19 — Login reliability fixes, dashboard/UI color pass, and Mock Exam rebuilt to match the real board exam

**Login fixes:** Diagnosed and fixed three separate real bugs blocking login end-to-end: (1) a corrupted Next.js/Turbopack install (missing internal font-loader module) that 500'd every page — fixed with a clean `node_modules` reinstall; (2) Supabase's default built-in email sender hitting its rate limit — fixed by configuring Gmail SMTP (Gabriel's own account, app password) as custom SMTP in Supabase; (3) the magic-link `redirect_to` not matching Supabase's allowed Redirect URLs list, silently dropping the `/auth/callback` path — fixed by adding the correct URLs to the allow-list and switching `NEXT_PUBLIC_SITE_URL` to `localhost` for local testing. Also added a numeric one-time-code fallback (`verifyOtpCode` in `platform/src/app/login/actions.ts`, UI in `login-form.tsx`) alongside the magic link, since email clients that pre-fetch links to scan them for safety silently burn the link's single-use code before the user clicks it — the code requires manual entry, so it can't be pre-fetched away.

**Dashboard/UI color pass:** Per Gabriel's feedback that plain-white cards read as flat, added a harmonized color-accent system across Dashboard, Practice, Question Bank, Progress, and Mistake Bank — deliberately avoiding blues/purples/reds that would clash with the green brand identity. Shared palette: primary green, teal, emerald, amber/gold for general status and category color-coding (`platform/src/lib/harmonized-accents.ts`, deterministic hash-by-exam-area so the same area is always the same color); a real red is reserved specifically for the Mistake Bank's actual recorded-mistake lists (both the dashboard card and `/mistakes` itself), kept distinct from the softer amber/orange used for general "needs review" mastery status, per Gabriel's explicit request to keep that one alarming and the rest calm.

**Mock Exam rebuilt to match the real PRC ABE board exam:** Replaced the free-form question-count/time-limit/topic-checkbox setup with the actual exam format — three separate 100-item, 3-hour subject exams (Area 1/2/3), taken one at a time. See `25_DECISION_LOG.md` for the full Area 1/2/3 ↔ 8-TOS-category mapping decided with Gabriel, and the new per-question `additional_mock_areas` admin override (checkbox control added to `/admin/content/[topicId]`) for cross-cutting questions.

**Affected files:** `platform/src/app/(app)/mock/page.tsx` (rewritten), `platform/src/app/mock/actions.ts` (`startAreaMockExam` replaces `startMockExam`), `platform/src/app/mock/[attemptId]/page.tsx` (area label + reduced-count banner), `platform/src/app/admin/content/[topicId]/page.tsx` + `actions.ts` (additional-area tagging), `platform/src/lib/harmonized-accents.ts` (new), `platform/src/app/(app)/dashboard/page.tsx`, `platform/src/app/(app)/practice/page.tsx`, `platform/src/app/(app)/question-bank/page.tsx`, `platform/src/app/(app)/progress/page.tsx`, `platform/src/app/mistakes/mistake-bank-view.tsx`, `platform/src/app/login/actions.ts` + `login-form.tsx`, `platform/.env.local`.

**Database changes:** `topics.mock_area`, `questions.additional_mock_areas`, `student_questions` view extended to expose both — applied via `platform/supabase/patches/007_mock_exam_areas.sql` (sent to Gabriel, not yet run against the live database as of this entry).

**Testing performed:** `npm run build` + `npm run lint` clean throughout. Login fixes verified end-to-end in-browser (magic link, OTP fallback, admin access all confirmed working). Color pass verified visually across all five pages. Mock Exam rebuild passed build/lint but **cannot be manually tested until patch 007 is run** — the page queries columns that don't exist in the live database yet.

---

## 2026-09-19 — Preparation Profile, Admin CMS (question editing, topic management, group performance, content quality), Bookmarks

**Preparation Profile** (`/progress`): a real objective coverage summary — questions completed, overall accuracy, recent accuracy (last 30 answered), mock exam average (across ALL completed mocks, not just the 5 shown in the history list below), topic coverage %, mastery distribution, weakest areas, and a recent-trend delta computed from the existing weekly accuracy buckets. Explicitly not a pass/fail prediction, per Gabriel's spec. **Real bug caught and fixed during verification:** "weakest areas" was originally sorting ALL scored topics ascending by mastery and taking the bottom 3 — with only 2 scored topics (one Strong at 80%, one Needs Review at 16%), the 80% "Strong" topic showed up under "weakest areas." Fixed by filtering out `status === "strong"` before sorting.

**Admin Quality Tooling** (`/admin/quality`): flags questions with no explanation, no choice marked correct, multiple correct choices on a single-choice question, and possible exact-text duplicates (after trim/case-fold). Nothing auto-fixed — every flag links to the relevant topic's content-review page. Verified against real content: correctly flagged 91 questions missing explanations, correctly reported zero for the other three checks.

**Admin Group Performance** (`/admin/performance`): aggregate accuracy by topic across everyone invited (lowest first), and most-missed questions group-wide. No new RPC — admin's existing RLS bypass on `attempts`/`attempt_answers` already permits reading every user's rows, same policy Practice/Mock already use for the caller's own. Verified with real data.

**Admin Topics & Subtopics management** (`/admin/topics`): add/rename/delete topics and subtopics, and set each topic's real-board-exam `mock_area` (Area 1/2/3) — the 8 official PRC exam areas themselves stay fixed (Table of Specifications). Deleting a topic that still has questions is blocked with a friendly message instead of a raw FK error. **Real bug caught and fixed during in-browser testing:** a delete button's `<form>` was nested inside the rename `<form>` for both topics and subtopics — invalid HTML (`<form>` cannot be a descendant of `<form>`), causing a hydration error. Fixed by making them sibling forms inside a wrapping `<div>`. Verified end-to-end: created a test subtopic, confirmed it appeared, deleted it, confirmed it was gone, no console errors on a fresh page load.

**Real question editing/creation/archiving** (`/admin/content/[topicId]`): each question now has a collapsible "Edit question" form (text, difficulty, explanation, and per-choice text + correct-checkbox), Archive/Restore buttons (`status = 'archived'`, hidden from the default list behind a "Show archived" toggle, cascades correctly through the existing publish/unpublish flow), and an "Add a new question" form (4 choice slots, starts as draft). Verified end-to-end against real content: edited a real question's explanation and confirmed it persisted correctly with all four choices and the correct-choice flag intact; created a test question via the UI, confirmed via direct DB query that the question, its two choices, and the correct-choice flag were all created exactly as entered, then deleted the test question to leave no residue. Archive/Restore was not tested against real content (to avoid leaving live questions in an unintended archived state) — it's the same single-field-update pattern as the already-proven publish/unpublish actions.

**Bookmarks** (`/notes` "Saved Questions" section, star toggle in Practice Mode): `setBookmark()` action (direct insert/delete against `bookmarks`' existing plain RLS) and a new `get_my_bookmarks()` SECURITY DEFINER RPC (same pattern as `get_my_notes()`, needed because `questions` stays admin-only for direct SELECT).

**Affected files:** `platform/src/app/(app)/progress/page.tsx`, `platform/src/app/admin/quality/page.tsx` (new), `platform/src/app/admin/performance/page.tsx` (new), `platform/src/app/admin/topics/page.tsx` + `actions.ts` (new), `platform/src/app/admin/content/[topicId]/page.tsx` + `../actions.ts`, `platform/src/app/admin/page.tsx` (new hub cards), `platform/src/app/practice/bookmarks-actions.ts` (new), `platform/src/app/practice/[attemptId]/practice-session.tsx` + `page.tsx` (bookmark star), `platform/src/app/notes/bookmarks-list.tsx` (new) + `(app)/notes/page.tsx`.

**Database changes:** `get_my_bookmarks()` RPC — applied via `platform/supabase/patches/008_bookmarks.sql` (sent to Gabriel, **not yet run against the live database** as of this entry — Bookmarks cannot be tested until it is).

**Security self-check performed:** see `25_DECISION_LOG.md` 2026-09-19 entry — confirmed every new admin action calls `requireAdmin()`, confirmed Preparation Profile only reads the caller's own `auth.uid()`-scoped data, confirmed Bookmarks follows the same ownership pattern as Notes.

**Testing performed:** `npm run build` + `npm run lint` clean throughout. Preparation Profile, Admin Quality Tooling, Admin Group Performance, Admin Topics management, and question editing/creation all verified end-to-end in-browser with real data (two real bugs found and fixed in the process, see above). Bookmarks built and build/lint-clean but not yet manually tested — blocked on patch 008.

---

## 2026-09-19 — Reviewers, Flashcards, Mistake Bank reorganization, two-column question layout, dark mode

Full context and the taxonomy-reuse rationale in `25_DECISION_LOG.md`.

**Theme system:** Light/Dark/System toggle in the sidebar footer (`theme-provider.tsx`, `theme-toggle.tsx`), persisted via `localStorage`, applied via `useLayoutEffect` (no SSR blocking script — see decision log for why). Dark palette reuses the CSS variables already present in `globals.css` from the original shadcn scaffold, never wired to anything until now. Verified end-to-end in-browser: toggled dark, confirmed the whole dashboard (including every harmonized accent color from the earlier color pass) stays readable and polished, confirmed persistence across a full page reload.

**Two-column Practice layout:** `practice-session.tsx` now shows the question/choices/submit on the left and a Solution panel (correct/incorrect, explanation, Teach Me This) on the right on desktop/tablet — sticky and independently scrollable so a long explanation doesn't push the page down. Falls back to the original stacked order on mobile (question → choices → submit → solution). Verified end-to-end at both desktop (1280px) and mobile (375px) widths with a real practice attempt: answer submission, correctness tracking, mistake tracking, and a full "Teach Me This" round-trip all confirmed still working inside the new layout.

**Mistake Bank reorganized:** `/mistakes` is now an Area → Topic → Questions drill-down (breadcrumb navigation) instead of one flat list, with sort (most recent / most repeated) and an "incorrect multiple times" filter, plus a "Practice My Mistakes" button scoped to whatever level you're currently viewing. No new mistake-tracking system — still reads from the existing `get_mistake_bank()` RPC; area grouping comes from a plain `topics`/`exam_areas` join done in the page, matching the pattern already used on `/question-bank`. Verified end-to-end with real data: 19 real mistakes correctly grouped into 2 real areas, drill-down into topic showing individual missed questions, "incorrect multiple times" filter correctly narrowing to just the repeated one.

**Reviewer/Reference materials (new):** `/reviewers` (student browse/search, tabbed Tables/Formulas/Constants) and `/admin/reviewers` (CRUD). One `reviewer_entries` table with a `kind` discriminator rather than three separate tables. No content populated — none fabricated, per the explicit instruction; the page's empty state and error state (missing-table, since the patch hasn't run yet) were both verified in-browser.

**Flashcards (new):** `/flashcards` (mode picker: Quick 10/20, Random, By Area, By Topic, Review My Weak Areas, Practice My Mistakes, Saved) → `/flashcards/study` (flip card, Know it / Still learning / Don't know, Next/Previous, save toggle) and `/admin/flashcards` (CRUD). Weak-Area and Mistakes modes pull topic IDs from the EXISTING `get_topic_mastery()`/`get_mistake_bank()` RPCs — no second, fabricated mastery number. `flashcard_progress` tracks real seen/known counts via a `record_flashcard_review()` RPC. No content populated yet, same as Reviewers; empty state verified in-browser.

**Cross-feature navigation + dashboard integration:** Question Bank topic rows and the dashboard's "Today's Recommendation" / "Needs Your Attention" cards now link to Flashcards and Reviewers scoped to that specific topic (via a `?q=` search param on Reviewers, and the existing `startFlashcardsByTopic` action). Sidebar nav and Quick Actions both updated with Flashcards/Reviewers entries. No fake recommendations added — these are links attached to the existing, already-computed recommendation.

**Affected files (partial — see the round's diff for the full list):** `platform/src/app/layout.tsx`, `platform/src/components/theme-provider.tsx` + `theme-toggle.tsx` (new), `platform/src/components/app-sidebar.tsx`, `platform/src/app/practice/[attemptId]/practice-session.tsx` + `page.tsx`, `platform/src/app/(app)/mistakes/page.tsx` + `platform/src/app/mistakes/mistake-bank-view.tsx`, `platform/src/app/(app)/reviewers/*` (new), `platform/src/app/admin/reviewers/*` (new), `platform/src/app/(app)/flashcards/*` + `platform/src/app/flashcards/actions.ts` (new), `platform/src/app/admin/flashcards/*` (new), `platform/src/app/(app)/question-bank/page.tsx`, `platform/src/app/(app)/dashboard/page.tsx`, `platform/src/lib/supabase/proxy.ts`, `platform/src/app/admin/page.tsx`.

**Database changes:** `reviewer_entries`, `flashcards`, `flashcard_progress` tables + `record_flashcard_review()` RPC — applied via `platform/supabase/patches/009_reviewers_and_flashcards.sql` (sent to Gabriel, **not yet run against the live database** as of this entry). Mistake Bank reorg and the two-column layout needed no schema changes at all.

**Testing performed:** `npm run build` + `npm run lint` clean throughout every stage. Theme system, two-column Practice layout, and Mistake Bank reorganization all fully verified end-to-end in-browser with real data (these needed no new schema). Reviewers and Flashcards verified for correct build/lint and graceful empty/error states, but their actual content flow **cannot be tested until patch 009 is run** — no reviewer materials or flashcards exist yet, and none were fabricated to fake a populated UI.

---

## Documentation gap, 2026-09-20 through 2026-09-24 (flagged, not backfilled)

This file was not updated across roughly 40 commits spanning several sessions/accounts in that window — Recalled Questions (662 transcribed questions), "Publish All Drafts" + Flagged Questions admin tooling, the Area 1/2/3 ↔ TOS mapping correction (see `25_DECISION_LOG.md` 2026-09-21 entry — the authoritative record of that change), the Mock Exam redesign (scrollable page, on-page subject breakdown, TOS-accurate per-subject sampling — see the `feedback_mock_exam_tos_sampling` memory), several AI-provider fallback additions (Mistral/NVIDIA NIM/SambaNova) and LaTeX-rendering fixes, PAES content added then hidden again, and the Green Gears 377-question transcription (`greengears-area1/2/3/law.json`) all landed without a changelog entry. `git log --oneline` is the accurate record for that period; this note exists so the gap itself isn't silently invisible. Not backfilling in detail here — out of scope for the entry below, which picks up from the actual current session.

---

## 2026-09-24 — iOS 15.8.8 Safari fix, Reviewers redesign + 266 formulas, Green Gears QC audit, and two direct content corrections

**iOS Safari fix (Practice unresponsive on iPad Air 2 / iPadOS 15.8.8):** A real user reported Practice Mode answer buttons not registering taps. Root-caused to `practice-session.tsx`'s two-column Solution layout switching to `lg:sticky` at exactly 1024px — iPad landscape width — where old Safari's known `position: sticky`-in-grid bugs likely overlapped the answer buttons. Fixed by moving the breakpoint to `xl:` (1280px), so any tablet stays in the safer single-column stacked layout; desktop behavior (≥1280px) is unchanged. Also added a `color-mix()` PostCSS fallback (`@csstools/postcss-color-mix-function`, `preserve: true`) for the app's own literal `color-mix()` usages (glow/shadow effects) — verified in the compiled CSS output that modern browsers are unaffected (cascade-overridden by the live value) while old Safari gets a static approximation instead of nothing. Note: Tailwind v4's own auto-generated opacity-modifier utilities (`bg-primary/10` etc.) are already self-guarded behind `@supports (color: color-mix(...))` by Tailwind itself, so those were never the cause of the tap failure — just a cosmetic gap (missing tint) on unsupported browsers, left as-is. Committed `c071f62`, pushed and deployed.

**Reviewer content: 266 formulas transcribed from private TRANSES review notes.** Built `platform/scripts/import-reviewer-content.js` (idempotent, mirrors `import-seed-content.js`'s topic/subtopic matching, sets `topics.mock_area` for any newly-created topic). Transcribed formulas (not tables/constants — deferred) from 17 TRANSES source PDFs into `reviewer_entries`, landing under a mix of existing topics (Hydrology, Irrigation and Drainage Engineering, Surveying, Engineering Economy, etc.) and 3 newly-created ones (Pumps, Fluid Mechanics, Marketing and Management). All imported as `status: draft`; Gabriel published all 266 himself via a new **Publish All Drafts** button added to `/admin/reviewers` (`publishAllReviewerDrafts` action, same expand+confirm pattern as the question bank's).

**Standing privacy rule established and enforced twice over:** the source material's own page footers carry the original author's initials/branding. Per explicit instruction, **no source attribution is shown or stored anywhere in the app, student or admin view** — not even a generic non-identifying label. Caught and fixed a partial miss (removed the "Source: ..." line from the student-facing Reviewers card, but missed that the admin create/edit forms for both Reviewers and Flashcards still had a visible, populated "Source / reference" input): removed the input from all four forms, cleared existing `source` values in the database (266 `reviewer_entries` + 528 `flashcards` rows), and changed the import script to always write `source: null`. Saved as a standing memory (`feedback_no_source_attribution`) so this isn't re-missed on a future content type.

**Reviewers page redesign (presentation only, zero content/topic changes):** widened the container (`max-w-3xl` → `max-w-6xl`), switched each TOS group's entries to a responsive 2-column grid, rebuilt the card as compact custom markup instead of the oversized shadcn `Card`, and added real `<sub>`/`<sup>` rendering for formula subscripts/superscripts (`P_abs` → true "Pₐᵦₛ"). Deliberately did **not** route formulas through full KaTeX/LaTeX math-mode after sampling the live data and finding many formulas mix in plain English ("confined aquifer," "water delivered from source") that would render broken under math-mode parsing — targeted `<sub>`/`<sup>` tag substitution is always safe regardless of content and needed no data changes. Verified in-browser: desktop 2-col grid, mobile 1-col with no overflow, dark mode, all via existing semantic tokens (so it also works under the Ocean/Forest themes). Committed `1aecba6`, pushed and deployed.

**Green Gears 344-question QC audit (emergency, content already live to students):** Discovered the 377 Green Gears questions committed Sep 24 (`greengears-area1/2/3/law.json`) had been bulk-published without individual technical review (344 of 377 matched live rows — the other 33 were skipped as duplicates by the import script's own idempotency check). Given Gabriel's explicit strict QC rubric (accuracy > completeness, never guess, actually re-solve computational questions, single-defensible-answer check, flag rather than force), **immediately pulled all 344 back from `published` to `review` status** to stop showing unreviewed content to real students, then ran the full rubric via 5 parallel background agents (one full agent retry round needed after a rate-limit interruption — verified all 5 output files were actually complete despite the "failed" status, since the failure landed after the file write, during final-summary generation). Result: **217 ACCEPT** (republished), **98 FLAG** (`review` status, reason appended to `explanation`, visible via `/admin/content/flagged`), **29 REJECT** (`archived`, not deleted). Concrete catches: a tractor-braking question with the physics backwards (declutching coasts, doesn't brake), an irrigation-water-chemistry remedy that would worsen the problem it claims to fix, a piston-speed calculation matching no offered choice, an ETo reference-crop-height using a non-standard value, a coordinate-geometry distance not matching the marked choice.

**Second pass — determined which of the 127 flagged/rejected were safely fixable** (again via parallel agents, same "never invent new content" discipline: only flipping to an *already-offered* choice, or fixing an unambiguous typo/OCR/unit error — explicitly never supplying a missing fact or picking among multiple equally-plausible corrections). **16 of 127 were fixable** and were corrected, verified (each has exactly one correct choice, no double-marking), and republished with a `[CORRECTED after review: ...]` explanation note. **111 stay excluded** — mostly unverifiable PAES/regulatory citations and a few cases where the textbook-correct answer isn't among the offered choices at all (same shape as the classic "gypsum isn't an offered choice for the bicarbonate remedy" example). Final state: **1,622 total questions — 1,492 published, 90 in review, 40 archived.** All of this was direct database operations (Supabase service-role key) — no code changes, nothing to commit/push for this part.

**Two direct corrections from Gabriel's own review of Recalled Questions content** (screenshots of live app cards, not part of the Green Gears batch above — these are in the separate `recalled-area-1/2/3.json` dataset from 2026-09-21):
- Internal Combustion Engine — reworded "What is the condition where the piston is at the top dead center called?" to "The space remaining inside the combustion chamber when the piston reaches top dead center is known as what?" (question id `28f0dc6c-cb57-4d89-897d-2875ce4dfd72`) — same correct answer (Clearance volume), wording only.
- Marketing/Management market-structure question (id `6b3f0402-5f89-454d-b815-d0cd9bb810c5`) — the stem (many independent sellers, differentiated products) is the textbook definition of monopolistic competition, but none of the 4 offered choices said that; the choice "perfect monopoly" (not a real economics term) was corrected to "monopolistic competition" and marked correct, flipped from the previously-marked "monopoly" (a single-seller market, wrong for this stem).

**Not yet done / picks up here:** Gabriel identified that Recalled Questions has the same kind of issues as Green Gears **plus** duplicate/near-duplicate questions phrased differently with conflicting marked answers (e.g. three separately-worded "rice hull furnace efficiency" questions with three different value ranges; a "cooperative import cost" question appearing twice with the Roman-numeral items reordered and different marked answers). **Next step, in progress as of this entry: apply the full QC rubric (same as the Green Gears pass above) to the entire Recalled Questions dataset (662 questions, `recalled-area-1/2/3.json`), including an explicit duplicate-detection/ground-truth-reconciliation pass** before the per-question accuracy check — this hasn't started yet, this entry is being written first so a session switch mid-audit doesn't lose context.

---

## 2026-09-24 (continued, new session) — Recalled Questions QC audit completed (641 questions)

**Picked up the handoff above.** A prior session had already pulled all 637 non-exempt Recalled Questions back from `published` to `review` (the safety step) but the accuracy audit itself had only produced a handful of verdicts (5 `FLAGGED FOR REVIEW`, 3 `CORRECTED after review`, 2 `DUPLICATE` markers applied) before it hit a session limit — confirmed by a fresh live-database read (not by trusting the changelog note alone) before doing anything further. Live impact at that point: **637 of 641 recalled questions were invisible to real students** — the Recalled Questions feature was effectively empty. Gabriel explicitly authorized continuing via direct database writes (service-role key), a departure from this session's earlier read-only/SQL-handoff posture.

**Audit scope and method:** exported all 641 recalled questions (id, topic, question text, choices, explanation) via the service-role key, grouped into 9 batches by topic (so duplicate/near-duplicate questions on the same subject would land in the same agent's context), and ran the same rubric as the Green Gears pass — re-solve every computational question from first principles, verify the single defensible answer for definitional ones, flag rather than guess on anything relying on an unverifiable PAES/regulatory numeric citation — via 9 parallel background agents, this time also tasked with in-batch duplicate-cluster detection (pick the best version, archive the rest).

**Result — 641 verdicts, zero missing/duplicate, cross-checked against the source data before any write:**
- **446 ACCEPT** (republished as-is)
- **25 FIX** (marked answer was wrong but a different offered choice was correct — corrected and republished with a `[CORRECTED after review: ...]` note; verified after the fact that every FIX target text matched an actual offered choice verbatim, and that every question still has exactly one correct choice)
- **116 FLAG** (stays `review`, reason appended to `explanation`, visible via `/admin/content/flagged` — mostly unverifiable PAES standard citations, e.g. exact freeboard/thickness/temperature thresholds from specific PAES documents, plus a few genuinely ambiguous term choices)
- **11 REJECT** (archived — correct answer isn't among the 4 offered choices, or the question is unanswerable as stated, e.g. one "how many tractors are needed" question that omits the target time/quantity)
- **43 DUPLICATE** (archived — same underlying question reworded, including several pairs with *conflicting* marked answers that the source data itself never resolved, e.g. two rice-hull-furnace-efficiency questions marked 90% and 95% for the same fact)

**Final state: 641 total — 471 published, 116 review, 54 archived, 0 draft.**

**Two bugs caught and fixed during verification, not left in production:**
1. One transcription typo on my end (a topic-C question id had one hex group mistyped when I saved an agent's output to disk) — caught by a validator that checks every verdict id exists in the exported master set, not by assuming the copy was clean.
2. A quieter one: 2 of the 3 questions that were already `archived` from a much earlier, smaller pass got fresh `FLAG` verdicts from this audit. Since a FLAG-only write patches just `explanation` (by design, to not silently un-reject something), these 2 stayed `archived` instead of moving to `review` — which would have made them permanently invisible to both students and the flagged-question admin queue despite the audit's own verdict saying "uncertain, not rejected." Caught by re-querying live status counts against the plan's expected numbers (114 review / 56 archived instead of the planned 116 / 54) rather than assuming the bulk write matched the plan just because zero HTTP requests failed. Patched both to `review` directly.

**Verified before declaring done:** re-queried live status counts until they matched the plan exactly; confirmed zero `published` rows carry a `FLAGGED`/`REJECTED`/`DUPLICATE` marker (the one failure mode that would matter — a bad question staying visible to students); re-fetched all 641 questions' choices and confirmed every one still has exactly one `is_correct = true` choice after the 50 answer-key flips.

**Still open, not touched this round (flagged, not fixed):** spot-checking the live `questions` table during this audit surfaced that Recalled Questions rows still carry populated `source`/`source_reference` values (e.g. "Iligan Review Center (ABELE 2025 Compiled Recalled Questions)", "AREA 2_RECALLED 2011-2024.pdf...") — the same standing no-source-attribution issue already fixed for `reviewer_entries` and `flashcards` earlier this session (see the entry above), just not yet applied to this table. Out of scope for this audit pass; flagged to Gabriel rather than silently expanded into.

**Testing performed:** no application code was touched this round — this was entirely direct database writes (service-role key) plus this changelog entry. All verification was done via live read-only queries against the production database (status-count reconciliation, marker-consistency checks, choice-count sanity check), not by trusting the write script's own success log.

---

## 2026-09-25 — `questions.source`/`source_reference` cleared, closing the last gap in the no-source-attribution rule

Picked up the one open item flagged at the end of the previous entry: `questions.source`/`source_reference` still carried real attribution (e.g. a full name, `"Arthur It. Tambong, FPSAE"`, from the original Area 1 transcription, plus various PDF filenames) even though `reviewer_entries` and `flashcards` had already been cleared. Not displayed anywhere in the student or admin UI currently (no `admin/content` form exposes a `source` input), but stored data violates the letter of the standing `feedback_no_source_attribution` rule, so cleared it anyway rather than leaving it "safe because unused."

**Database:** nulled `source` and `source_reference` on all 606 `questions` rows that had either populated. Verified zero remain afterward.

**Code:** `platform/scripts/import-seed-content.js` and `platform/scripts/generate-import-sql.js` both used to write `source: data._meta.author` / `source_reference: <sourceRef arg>` on every inserted question — changed both to always write `null` (mirroring the fix already applied to `import-reviewer-content.js`), and removed the now-dead `author` variable from `generate-import-sql.js`. Any future re-run of either script will no longer reintroduce attribution.

**Testing performed:** `npm run lint` clean (0 errors). No UI changes — this was a database cleanup plus two import-script edits, not a page/feature change.

---

## 2026-09-25 — Reviewers "Tables" tab: real HTML tables instead of raw pipe text

**Root cause found:** `TableEntryCard` (`platform/src/app/(app)/reviewers/reviewers-browser.tsx`) already had a proper markdown-table parser (`parseMarkdownTable`), but it requires a header row + a `---` separator row, and **256 of 277 published table-kind reviewer entries** (92%) were authored as plain `A | B` lines with neither — a glossary/classification list transcribed directly, no markdown table syntax at all. The parser correctly rejected all of them and fell back to a raw `<pre>` block, which is why nearly every "table" looked like a gray code box of pipe-separated text. Also found 14 entries that aren't tables at all — genuine formula reference sheets (chained equations, no `|` anywhere) mistagged as `kind: table`, also falling into the same `<pre>` fallback.

**Fix (rendering-only, zero database changes):**
- `parseLooseTable()`: recognizes uniform pipe-delimited rows with no separator row, and decides whether row 0 is a real header versus itself a data row by comparing whether its cells read as descriptive text while the rows below are numeric/measurement-shaped (per-column, not per-table) — real headers are kept verbatim from the source (confirmed correct against the PAES 401/402/404/409/411/415 standards tables, which do have genuine header rows), and only when there's truly no header in the source is a safe generic one used (`Item`/`Description`/...), never a fabricated domain term. A genuinely malformed entry (PAES 413 Table 4 — header row has 8 columns, every data row only 7, a real transcription gap) correctly still falls through to plain text rather than the parser guessing a missing value.
- Formula-shaped `table_content` (no `|`, contains `=`) now renders through the same boxed formula styling used elsewhere (`FormulaCard`'s treatment) instead of flat `<pre>`, including correct subscript/superscript rendering via the existing `renderFormula` helper.
- Long cell text now wraps instead of forcing every column to `nowrap`-driven horizontal scroll; wide multi-column tables still scroll horizontally within their own bounded card, verified the page itself never overflows at 375px width (`document.documentElement.scrollWidth === window.innerWidth`, checked directly, not eyeballed from a screenshot).
- `kind: formula` entries (a separate, untouched code path/component) confirmed unaffected — spot-checked "FWR"/"DWR" render identically to before.

**Testing performed:** verified against real live data (not synthetic examples) across all four shapes — a 2-column glossary entry, a real-header PAES table, a formula-reference-sheet entry, and the one malformed 7-vs-8-column entry — plus mobile-width overflow check. `npm run lint` and `npm run build` both clean. Committed `c4323f8`, pushed and deployed.

---

## 2026-09-25 — Default theme dashboard depth/atmosphere pass (site-wide, Ocean/Forest untouched)

Gabriel asked for a visual-only redesign of the plain-white dashboard: subtle tinted page background instead of white, better card elevation/hierarchy, a demoted "days countdown" so it reads as metadata not a competing heading, and — critically — **strictly scoped to the Default theme only**, never touching Ocean or Forest.

**`platform/src/app/globals.css`:**
- `:root { --background }` changed `#f8f9f7` → `#f4f7f7` (cooler teal tint, still effectively off-white — cards stay `#ffffff` so they visibly separate from the page).
- New rules, all gated by `html:not(.theme-ocean):not(.theme-forest)` so Ocean/Forest (and their existing photo-background/glassmorphism rules) are never touched:
  - A very low-opacity grid + radial gradient painted on `[data-slot="sidebar-inset"]` (the actual opaque content-area element, not `body` — `body`'s background is already covered by sidebar-inset's own `bg-background` fill in Default, same reasoning documented in the existing Ocean/Forest comment block). No `background-attachment: fixed` — deliberately avoided given that `position: sticky` + certain paint/scroll interactions caused the iPadOS 15.8.8 Safari bug fixed earlier this session; this is cheap flat gradients anyway, not a blurred photo, so there was no performance reason to reach for `fixed`.
  - A soft two-layer `box-shadow` on every `[data-slot="card"]`, layered under the existing hairline `ring-1 ring-foreground/10`, so white surfaces read as gently elevated rather than just outlined.
  - A quiet gradient-wash treatment for `.dashboard-hero` (the greeting band) — small padding, hairline border, faint primary-tinted gradient — not a hero banner.
- All new rules use `color-mix(in srgb, var(...) X%, transparent)`, matching the existing project pattern (glow/gradient tokens), with the `@csstools/postcss-color-mix-function` fallback already in `postcss.config.mjs` from the earlier iOS-compat fix.

**`platform/src/app/(app)/dashboard/page.tsx`:**
- Supporting greeting line demoted to `text-sm`.
- The "55 DAYS · ABELE" block rebuilt as a small bordered/muted metadata chip ("ABELE COUNTDOWN" label + smaller number) instead of a same-weight second heading competing with the greeting.
- Quick-action cards (Continue Studying/TOS/Practice/Flashcards/Mock Exams): fixed a real (pre-existing, unrelated to this redesign) dead hover state — `hover:border-primary/50` was a no-op because the shared `Card` component has no `border` utility, only `ring-1`, so border-color-only overrides never rendered. Replaced with `hover:ring-primary/40` plus a small `hover:-translate-y-0.5 hover:shadow-sm` lift, which now actually shows on hover.
- "Your Next Study Session" (the primary CTA card): same dead-`border` bug — `border-primary/30` was invisible — replaced with `ring-2 ring-primary/25` plus `shadow-sm`, so the featured card now visibly stands out from the other cards as intended.
- Question of the Day: icon moved into a small filled circle, tightened padding, so it reads as a compact daily prompt rather than a full-size generic card.

**Testing performed:** used the existing local magic-link + temporary server-side `/api/dev-login` route technique (created, used, then deleted — confirmed via `git status` never tracked) to log in as the owner account and visually verify in the browser: Default light (dashboard + Reviewers page, confirming the effect is site-wide), Default dark, Ocean (confirmed still glass-on-photo, completely unaffected), Forest (same), and mobile width 375px (2-column card grid stacks correctly, `document.documentElement.scrollWidth === window.innerWidth`, no horizontal overflow). `npm run lint` clean (2 pre-existing unrelated warnings in `settings/actions.ts`, 0 errors).

---

## 2026-09-25 — Light theme gets its own identity: warm ivory + deep teal-green palette

Gabriel's follow-up to the depth pass above: the Light theme still read as "Dark theme but white" rather than having its own designed identity. Full palette replacement plus atmosphere/glass refinements, still strictly scoped to Default (Ocean/Forest/Dark untouched) per his explicit instruction.

**`platform/src/app/globals.css` — `:root` (Light) palette replaced wholesale:**
- Background `#f4f7f7` → `#f3f5ee` (warm ivory, not cool gray-teal)
- Card/popover `#ffffff` → `#fffdf7` (warm off-white, not stark white)
- Foreground `#172121` → `#172522`, muted-foreground `#657272` → `#60716d` (both slightly warmer)
- Primary `#0f5b5a` → `#075b58`, added a distinct secondary teal `#287c72` (now used for `--ring` and `--chart-2`, giving hover/focus states their own hue instead of reusing primary)
- Gold `#d9a441` → `#d6a84f` — still scarce, unchanged usage (Question of the Day / streaks / achievements only, never in the generic `accent` token)
- Border `#dde4e2` → `#dce5e0`, secondary/accent `#e4f1f0` → `#e3efeb`
- Sidebar stays the same deep-teal family (`#0a4141`) as instructed, but its active/hover surface (`--sidebar-accent`) now uses the new secondary teal `#287c72` instead of duplicating `--sidebar-primary`, so an active nav item is visibly a lighter teal rather than identical to the logo color.
- New token `--surface-featured` (`#f7faf4` in Light) — a second, slightly green-tinted card surface one step warmer than `--card`, wired into `@theme inline` as `--color-surface-featured` (Tailwind utility `bg-surface-featured`) and given a same-family fallback value in `.dark`, `.theme-ocean`, and `.theme-forest` so it never resolves to nothing outside Light.

**Atmosphere/grid, still gated to `html:not(.theme-ocean):not(.theme-forest)`:**
- Replaced the single upper-left primary glow with two low-opacity radial glows (teal upper-right, secondary-teal lower-left) per the "soft teal glow / green-teal glow" spec, plus widened the grid spacing (64px → 72px) and switched its line color from neutral foreground-gray to teal (`--primary` at 3%) so it reads as a technical/engineering grid rather than plain graph paper.
- Added restrained glassmorphism to Light's floating overlays only (`[data-slot="dialog-content"]`, `dropdown-menu-content`, `select-content`) — a 94%-opaque tint plus an 8px blur. Deliberately NOT applied to `[data-slot="card"]` (there can be 15-20+ on screen at once — same performance/legibility reasoning already documented for why Ocean/Forest reserve full glass for single-instance surfaces).
- Explicitly skipped the optional paper/noise texture from the spec — an SVG-turbulence data-URI layer was judged not reliably practical (cross-browser rendering risk, added complexity) against the "omit if not clearly performant/practical" clause in the request; the two-layer glow + grid already carries the atmosphere.

**`platform/src/app/(app)/dashboard/page.tsx`:** the "Next Study Session" featured card's background changed from a generic `bg-gradient-to-br from-primary/5` wash to `bg-surface-featured`, so it now uses the dedicated featured-surface token everywhere instead of an ad hoc gradient.

**Testing performed:** same local magic-link + temporary `/api/dev-login` technique (created, used, deleted; confirmed untracked via `git status`) to visually verify as the owner account: Light (dashboard, scrolled progress section), Ocean (unaffected — still its own photo/glass/aqua palette), Forest (unaffected — confirmed `bg-surface-featured` correctly resolves to Forest's own dark-green fallback, no Light-theme color leaking through), Dark (unaffected, still teal-black), and mobile 375px (no horizontal overflow). `npm run lint` and `npm run build` both clean.

Follow-up same day: the "ABELE Countdown" chip was unboxed per feedback — replaced the bordered/filled container with a plain right-aligned stack behind a thin divider, and the number size bumped `text-lg` → `text-4xl`/`text-5xl` so it reads as a real number rather than small metadata. Commit `87a81b7`.

---

## 2026-09-25 — Dashboard desktop composition: fix dead space at wide viewports

Gabriel's next request: the dashboard read as "sidebar | empty space | narrow website | empty space" at real desktop widths (1440–2560px) because the content column was capped at `max-w-5xl` (896px) regardless of viewport. A parallel request for a responsive-button audit arrived mid-task; folded in below.

**`platform/src/app/(app)/layout.tsx`:** header and content-wrapper horizontal padding both changed from a flat `p-4 sm:p-6` to a shared responsive scale (`px-4 sm:px-6 lg:px-8 2xl:px-10`) so the header's left edge and the page content's left edge stay aligned at every breakpoint, not just coincidentally at the one they happened to share before.

**`platform/src/app/(app)/dashboard/page.tsx`:**
- Container widened: `mx-auto max-w-5xl` → `mx-auto w-full max-w-6xl 2xl:max-w-[1680px]`. Nothing inside is an unconstrained full-width paragraph (the hero subtext and footer note both wrap at their own natural length), so widening the container doesn't create "enormous text lines" — only the card grids gain the extra room.
- "Next Study Session" card: reworked to split horizontally at `xl:` (1280px+) — topic/meta on the left, the CTA button row on the right, `items-start` (not centered) so a long-wrapped title never visually collides with the CTA block. **Caught and fixed a real regression during testing**: the first pass used the `lg:` breakpoint (1024px), which left too little width for real topic names (e.g. "Agricultural Machinery Design, Fabrication/Manufacturing and Testing") — the title wrapped 5 lines deep and the vertically-centered CTA block ended up floating mid-paragraph. Moved the breakpoint to `xl:` and switched to top-alignment; re-tested at 1024/1280/1440/1920px to confirm the fix.
- Lower dashboard sections ("Recent Activity" + "Quick Access"/"Achievements") now sit in an `xl:grid-cols-[1.7fr_1fr]` two-column split instead of stacking full-width one under another — the single biggest source of unused horizontal space below the fold at wide viewports. "Needs Your Attention" and "Upcoming Study Plan" stay full-width above it.
- Hero greeting gains `lg:text-4xl` so it holds up as the visual anchor at the new width.

**`platform/src/components/app-sidebar.tsx`:** added `gap-2` between nav groups (Main / Study Tools / Admin) — the only sidebar change; structure and active-state treatment were already solid.

**Button-system audit (no code changes needed):** grepped the whole `src/` tree for `Button` elements with `w-full`/fixed-width classes — every `w-full` hit is a button that's the sole action inside its own narrow card (Practice/Mock/PAES/Quiz-builder/Study-plan "Start" CTAs, login form) or one half of an intentional 2-button row, never an arbitrary desktop stretch. No fixed-pixel widths found anywhere. The shared `Button` component already has `whitespace-nowrap` (prevents awkward text wrap) and per-size fixed heights independent of label length, and every action group already uses `flex flex-wrap gap-*`. The system already matched the request; nothing to change.

**Testing performed:** visually verified at 1920, 1440, 1280, 1024px, and 375px mobile as the owner account — no horizontal overflow at any width (`scrollWidth === innerWidth` checked via JS at each), confirmed the `xl:` breakpoint fix for the featured card, confirmed the 2-column lower-section split collapses to one column below `xl`. `npm run lint` and `npm run build` both clean.
