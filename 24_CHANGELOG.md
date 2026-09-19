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
