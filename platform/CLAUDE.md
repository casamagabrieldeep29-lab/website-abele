@AGENTS.md

# Question content rules (hard rules)

- **Every given value goes in the question text.** A computation problem must state all its data (numbers, units, rates, years, table values) in `question_text`, so a student can solve it from the question alone. The explanation may restate them as "Given: ...", but it must never be the only place they appear. "...the streams shown" with nothing shown is a defect.
- Applies to all new content (seed JSON/SQL, admin editor, AI-authored batches) and to anything edited. `src/lib/question-givens.ts` flags the pattern (admin card warning) and `question-givens.test.ts` fails CI if a seed file in `supabase/seed/content/` breaks it.
- New questions stay `status = 'draft'`; no source attribution is ever shown or stored in student/admin UI.

# Supabase egress budget (hard rule)

The Supabase project is on the **Free plan: 5 GB egress per month**. In Oct 2026 pages that re-downloaded whole tables on every view used the entire allowance and took the site down for every student. Do not repeat it.

- **Never read a whole shared table per request.** The published question list, reviewer entries (~1.4 MB of text) and the topic/subject taxonomy are identical for every student — read them only through the shared caches in `src/lib/published-counts.ts` and `src/lib/shared-content.ts`. Add new shared reads there (cached + tagged); expire the tag from the matching admin action.
- **Never download a student's whole answer history.** Use the SQL functions `get_answer_summary()` / `get_latest_outcomes()` (patch 048) through `fetchAnswerSummary` / `fetchLatestOutcomes`.
- **Counts: use `head: true, count: "exact"`**, never fetch rows just to take `.length`.
- **Budget:** about 10 MB per user per month (500 users ≈ 5 GB). Aim for under ~15 KB of Supabase response per page view.
- **Measure:** set `SUPABASE_EGRESS_LOG=1` (`src/lib/supabase/egress-log.ts`) to log the size of every Supabase response from server code.
- `src/lib/egress-guard.test.ts` fails CI on the worst patterns. If it trips, fix the code, don't loosen the test.
- Read-only pages verify login locally with `getSessionUser` (no Auth request). Actions that change data keep `auth.getUser()`.
