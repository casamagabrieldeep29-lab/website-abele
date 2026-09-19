# 26. BUILD CHECKLIST

Living checklist for the ABELIEVER build. Check items off as they're actually done and verified — not when code merely exists (per `00_MASTER_PROJECT_INSTRUCTIONS.md` Section 29, no fake implementation). Update this file whenever scope changes; don't let it drift out of sync with reality.

Legend: `[x]` done & verified · `[~]` in progress · `[ ]` not started

---

## Phase 1 — Foundation (architecture, auth, database)

- [x] Master instructions + project context + decision log docs
- [x] Next.js + TypeScript + Tailwind + shadcn/ui scaffold (`/platform`)
- [x] Green branding/theme applied
- [x] Public landing page (exam area overview + sign-in)
- [x] Supabase project created; schema deployed (`profiles`, `exam_areas`, `topics`, `subtopics`, `questions`, `choices`, `attempts`, `attempt_answers`, `bookmarks`)
- [x] Row-level security policies + answer-key protection (admin-only base tables, `student_questions`/`student_choices` views, `submit_attempt_answer` RPC)
- [x] Magic-link invite-only auth, working end-to-end
- [x] Route protection (`proxy.ts`)
- [x] Admin bootstrap (Gabriel promoted to `role = 'admin'`)
- [x] Admin invite flow (`/admin`, service-role `inviteUserByEmail`)
- [x] Dashboard shell (placeholder cards for Practice/Mock/Progress)
- [ ] Deploy to Vercel with a real (even if free-tier) URL — currently only runs on local dev server, which drops when the session is idle

## Phase 2 — Content Pipeline

- [x] Content extraction method proven: render PDF pages to images (poppler), manually verify against source, transcribe into structured JSON (not blind OCR/text-extraction, which loses/scrambles data on scanned or reflowed PDFs)
- [x] Reusable import tool (`scripts/import-seed-content.js`): JSON → live DB, idempotent, service-role
- [x] First batch imported: Tambong "Area 1 Part I" — 112 questions, 5 topics
- [x] Admin content review UI (`/admin/content`) — per-question and bulk publish/unpublish, verified working
- [~] Spot-check the 3 flagged discrepancies from Tambong Part I — 1 of 3 resolved (vermi cast shredder question, corrected to choice B — see `24_CHANGELOG.md`); 2 remaining (Jatropha oil expeller unit typo, duplicate RA 10915 question)
- [ ] Extract remaining Area 1 source files — `ABELE TOP 1/ATTRC/Area 1/`: ABE LAW, AUTOMATION & CONTROL SYSTEM, ENG ECON, MACHINERY & MECHANIZATION, MARKETING & MANAGEMENT, POWER ENGINEERING, PROBLEM SOLVING, plus the two FINAL COACHING folders — genuinely different-in-kind work from the coding above (render-to-image → manual verify → transcribe per the proven pipeline), not started this round
- [ ] Extract Area 2 source files — `ABELE TOP 1/ATTRC/Area 2/`: ANIMAL AND CROP SCIENCE, AQUACULTURE, CROP AND ANIMAL SCIENCE, FLUID MECHANICS, GROUNDWATER, HYDROLOGY, IRRIGATION AND DRAINAGE, MATH AND BASIC ENG, OPEN CHANNEL, PROBLEM SOLVING, PUMPS, SURVEYING — not started this round
- [ ] Reconcile source-folder topic groupings against the 8 official PRC exam areas as more content comes in (ongoing judgment call, see `01_PROJECT_CONTEXT.md` Section 9)

## Phase 3 — Practice Mode — DONE, verified end-to-end 2026-09-18

- [x] Admin: publish/unpublish questions (`/admin/content`, per-question + bulk-publish-topic)
- [x] Student: topic list page (`/practice`) showing published question counts per topic
- [x] Student: practice session flow — start attempt, one question at a time, immediate feedback via `submit_attempt_answer` RPC, next question
- [x] Practice session completion screen (score summary)
- [x] Verified in-browser end-to-end with Gabriel's real account (caught and fixed a real bug — `submit_attempt_answer` had an ambiguous column reference; see `24_CHANGELOG.md`)

## Phase 4 — Mock Exam

- [x] Timed exam UI, question navigator grid, no per-question feedback (unlike Practice Mode, by design) — verified end-to-end 2026-09-18
- [x] Submission + automatic scoring — silent grading via `record_mock_answer` RPC — verified end-to-end 2026-09-18
- [x] Post-exam detailed review (`/mock/[attemptId]/results`, via `get_attempt_review` RPC) — verified end-to-end 2026-09-18
- [x] **Rebuilt 2026-09-19 to match the real PRC board exam**: three separate 100-item/3-hour Area 1/2/3 exams (replacing the old free-form question-count/topic-picker setup); patch 007 run, setup page verified in-browser with real data
- [x] Admin per-question "also relevant to Area X" tagging (`/admin/content/[topicId]`) — checkbox control built, uses the same verified update pattern as question editing below

## Phase 5 — Progress & Personalization — DONE, verified end-to-end 2026-09-18

Per the approved plan at `C:\Users\Gabriel\.claude\plans\shimmering-foraging-stardust.md` (see also `25_DECISION_LOG.md` entries on the commercial-product pivot and the mastery/recommendation/adaptive-selection algorithms).

- [x] Mastery system — `get_topic_mastery()` RPC (0.6×recent + 0.4×overall accuracy, min 5 attempts before showing a number, else "insufficient_data")
- [x] Least-mastered areas — dashboard section, top 3 by mastery ascending, "Practice this area" → adaptive session
- [x] Today's Recommendation — documented priority formula, picks highest-priority topic with ≥5 published questions, "Start 20-question session" CTA
- [x] Mistake Bank (`/mistakes`) — `get_mistake_bank()` RPC, self-corrects after one correct retry, topic filter, "Retry my mistakes" → exact-set practice session
- [x] Adaptive question selection — weighted sampling (missed=3x, unseen=1.5x, previously-correct=1x) in `startAdaptivePracticeAttempt`; existing plain `startPracticeAttempt` (full-topic, sequential) left untouched for backward compatibility
- [x] Basic real analytics on dashboard (questions answered, overall accuracy, average mastery, day streak) — all computed from `attempt_answers`, no fabricated numbers
- [x] Mock Exam "mark for review" — client-side toggle + navigator indicator + submit-confirmation summary
- [x] Verified in-browser end-to-end with Gabriel's real account
- [~] Bookmarked questions — star toggle in Practice Mode (`practice-session.tsx`), listed under "Saved / Notes" (`/notes`), `get_my_bookmarks()` RPC — `npm run build`/`lint` clean, **blocked on `supabase/patches/008_bookmarks.sql` being run** (sent to Gabriel, not yet applied), not yet manually browser-tested

## Phase 6 — Admin CMS polish — verified end-to-end 2026-09-19

- [x] Question editing UI (`/admin/content/[topicId]` — inline edit: text/difficulty/explanation/choices; archive/restore; add new question) — verified via real create+edit+cleanup in-browser
- [x] Subject/topic management UI (`/admin/topics` — add/rename/delete topics and subtopics, set each topic's mock exam area; the 8 official PRC exam areas stay fixed) — verified via real create/rename/delete in-browser (caught and fixed a real nested-`<form>` hydration bug in the process)
- [x] Group performance visibility for admin (`/admin/performance` — accuracy by topic across everyone invited, most-missed questions group-wide; no new RPC needed, admin's existing RLS bypass already covers this) — verified with real data

## Phase 7 — Cross-cutting polish (ongoing, not a one-time pass)

- [ ] Mobile responsiveness check on each new feature (per Section 16)
- [ ] Accessibility pass (Section 17: semantic HTML, keyboard nav, contrast, focus states)
- [ ] Performance check as content volume grows (Section 18)

## Phase 8 — Premium product features (commercial pivot, 2026-09-18 spec)

Full context in `25_DECISION_LOG.md` and the approved plan file above.

- [x] Quick Practice presets (`/quick`, 10/20/50, adaptive across all topics) — built and verified end-to-end 2026-09-18
- [x] Custom Quiz Builder (`/quiz-builder`, topic/difficulty/source filters, no duplicate-question padding) — built and verified end-to-end 2026-09-18
- [x] Personal Notes on questions (`/notes` + inline in Practice Mode only, not Mock Exam) — built and verified end-to-end 2026-09-18
- [x] Study Plan Generator (`/study-plan`, rule-based 7-slot cycle resolved against live mastery data) — confirmed working by Gabriel 2026-09-19
- [x] Concept-level hierarchy (`/question-bank`, Area → Topic → Subtopic drill-down) — confirmed working by Gabriel 2026-09-19
- [x] Question of the Day (deterministic daily pick, dashboard card, anonymized aggregate stat once ≥5 responses) — confirmed working by Gabriel 2026-09-19
- [x] Streaks/Achievements as persisted history — `user_achievements` table + `check_and_award_achievements()` RPC, dashboard display — confirmed working by Gabriel 2026-09-19
- [ ] Performance trend chart (needs weeks of real history to be meaningful — currently only has a few days)
- [x] "Teach Me This" grounded explainer + AI Study Assistant — Gemini-backed (`@google/genai`, model `gemini-3.1-flash-lite`), provider abstraction, per-user daily rate limit, wired into Practice/Mock review + `/progress` — verified end-to-end in-browser 2026-09-19: real question → verified DB context → Gemini response → correct grounded explanation, follow-ups, and a Retry path for transient provider errors (see `24_CHANGELOG.md`)
- [x] Preparation Profile (`/progress` — questions completed, overall/recent accuracy, mock average, topic coverage %, mastery distribution, weakest areas, recent-trend delta; explicitly NOT a pass/fail prediction) — verified end-to-end 2026-09-19 with real data (caught and fixed a real bug in the process: "weakest areas" was including the single strongest topic when too few topics had enough data)
- [x] Admin quality tooling (`/admin/quality` — no explanation, no correct choice marked, multiple correct choices on a single-choice question, possible exact-text duplicates) — verified with real data: correctly flagged 91 real questions missing explanations, correctly reported 0 for the other three checks
- [x] Security audit pass — see `25_DECISION_LOG.md` 2026-09-19 entry

Payment/access is explicitly handled manually by Gabriel via GCash outside the app — no invite-code or payment schema/UI is being built (see `25_DECISION_LOG.md`).

---

## Not in scope right now (explicitly deferred, see `25_DECISION_LOG.md`)

- Free-response numerical question grading (schema has the placeholder, no working UI/grading path)
- Multiple admins/reviewers (Gabriel is sole admin for now)
- Custom domain (using local dev / eventual Vercel free URL)
- Formal multi-reviewer content-review workflow (bypassed for transcribed source-verified content; would apply to any newly-authored, non-transcribed questions)

---

## Phase 9 — Reviewers, Flashcards, Mistake Bank drill-down, two-column layout, dark mode (2026-09-19 spec)

Reuses the existing taxonomy (`exam_areas → topics → subtopics`) throughout — no parallel "Subject" hierarchy was created. See `25_DECISION_LOG.md`.

- [x] Theme system (Light/Dark/System, persisted via localStorage) — verified end-to-end in-browser: toggled dark, confirmed polished/readable across dashboard, sidebar, and harmonized accent colors; persisted across reload
- [x] Two-column question+solution layout in Practice (`practice-session.tsx`) — verified end-to-end: desktop shows side-by-side with a sticky/scrollable solution panel, mobile correctly stacks (Question → choices → submit → Solution); answer submission, correctness tracking, mistake tracking, and Teach Me This all confirmed still working inside the new layout
- [x] Mistake Bank reorganized into Area → Topic → Questions drill-down with sort/filter (`/mistakes`) — verified end-to-end with real data (19 real mistakes, correct area/topic counts, "Incorrect multiple times" filter narrowing correctly, "Practice My Mistakes" scoped to current drill-down level)
- [~] Reviewer/Reference system (`/reviewers`, admin CRUD at `/admin/reviewers`) — schema + UI built, `npm run build`/`lint` clean, empty-state and error-state verified in-browser; **blocked on `supabase/patches/009_reviewers_and_flashcards.sql` being run** for actual content flow, no content populated yet (none fabricated, per instruction)
- [~] Flashcards (`/flashcards` + study session, admin CRUD at `/admin/flashcards`) — schema + UI built, weak-area/mistake-linked modes reuse the existing `get_topic_mastery()`/`get_mistake_bank()` RPCs (no fabricated mastery), `npm run build`/`lint` clean, empty-state verified in-browser; **same patch-009 blocker**, no content populated yet
- [x] Cross-feature navigation — Question Bank topic rows and the dashboard's Today's Recommendation / Needs Your Attention cards now link to Flashcards and Reviewers scoped to that topic; verified rendering with real data (flashcard/reviewer links won't return content until patch 009 is run and content is added)

Payment/access remains explicitly out of scope (manual GCash, per earlier decision) — untouched by this round.
