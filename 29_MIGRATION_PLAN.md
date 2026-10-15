# Migration plan — Cloudflare + Turso + Supabase (modelled on the CSE project)

Status: PLANNING ONLY. Written 2026-10-15. The owner plans to migrate ABELIEVER the way he built the Civil Service Exam reviewer ("Reviewer ni Juan"). Related: `28_UX_UI_UPGRADE_PLAN.md` (redesign and features), `27_LANDING_REFERENCE.md`.

Owner decisions so far (2026-10-15): stop using Vercel; buy the domain **abelieverofficial.com** (looked unregistered when checked, confirm at the registrar); use Cloudflare, Turso and Supabase as in CSE. The owner will create an **official ABELIEVER Gmail** to own the new accounts (registrar/Cloudflare, Turso, GitHub). Recommended: turn on 2-step verification, add a recovery phone/email, keep the credentials only in a password manager (never in chat or commits), and later add `info@abelieverofficial.com` with Cloudflare Email Routing (free) forwarding to that Gmail.

**Status update 2026-10-16.**
- Domain done: **www.abelieverofficial.com** is live (bought on Cloudflare, attached to the Vercel project). The old addresses (abeliever.dev, www.abeliever.dev, abeliever.vercel.app) show a mandatory "we've moved" page (`src/proxy.ts`). Supabase Seoul's Site URL and redirect list use the new domain. Sydney (standby) still has the old ones.
- Accounts created by the owner on the official Gmail: Cloudflare, GitHub, Turso, Supabase (2-step verification on). Nothing is hosted or stored there yet.
- **Decision: Option B (incremental "strangler")** — keep the Next.js app on Vercel, add a Hono Worker + Turso behind it, move shared read-heavy content first (questions, choices, taxonomy, reviewers, flashcards, series) with edge caching, then per-user data, last the front end. Auth stays on Supabase (Worker verifies its JWT).
- Defaults until the owner says otherwise: before the Nov 19-20 exam do only the safe first step (shared content to Turso behind a flag, no student data moved); the hosting switch and per-user data come after the exam; stay on free plans (no $5 Workers plan without asking).
- **Phase 1 foundation built (2026-10-16) in `api/`** (repo root, so the Next.js build never sees it): Hono Worker (`/health`, `/v1/taxonomy`, `/v1/snapshot`, `/v1/questions?ids=`), Supabase-JWT check, per-IP rate limit (fails open), Cache-API edge cache, migrations as code, `npm run content:export` (Supabase -> libSQL, read-only), guard tests (auth on every route, no answers/explanations ever served, statement budgets, no table scans). Developed against a LOCAL libSQL file, so nothing needed a login yet.
- Measured on the real export: 7,971 published questions, 31,884 choices (every question has exactly 4), 9.7 MB database. Worker bundle 55.9 KiB gzip (limit 3 MiB). A 10-question session = 50 database rows, 7.8 KB; taxonomy 19 KB / 116 rows; the full id snapshot 307 KB / 7,971 rows but only on an edge-cache miss. Grading, answers and explanations deliberately stay in Supabase.
- Next: owner logs in to Turso and Cloudflare (wrangler/turso CLI, browser approval), I create the Turso DB, deploy the Worker, load the content, then switch the Next.js app's shared reads behind a flag (`CONTENT_SOURCE=turso`) with a Supabase fallback.

Reference project: `C:\Users\Gabriel\OneDrive\Pictures\Documents\CSE` — read `ARCHITECTURE.md`, `ROADMAP.md`, `HANDOFF.md`, `app/api` and `app/web`. No keys are copied here.

## How CSE is built (what to reuse)

| Layer | CSE choice |
|---|---|
| Front end | Vite + React single-page app, static files on Cloudflare Pages (project `reviewernijuan`), deployed with `wrangler pages deploy` |
| API | Hono on Cloudflare Workers (`cse-api`); tiny bundle (about 58 KiB gzip); measured p50 CPU 3.8 ms and p99 13.4 ms against the 10 ms Workers-Free limit |
| Database | Turso (SQLite/libSQL) free plan; schema kept as ordered code migrations (`src/migrations.ts`, `_migrations` table) applied automatically on deploy, so nobody pastes SQL by hand |
| Login | A Supabase project used for Auth only (email/password and Google); the Worker verifies the Supabase JWT against the project's JWKS with `jose`, so no password hashing happens on Workers |
| Payments | Manual GCash/Maya/Landbank with the Gemini receipt check (same rules as ABELIEVER); the image is discarded after the check |
| Caching | Shared question content through the Cloudflare edge cache; Turso is read only on a cache miss; ids cached, rows fetched by primary key |
| Per-user data | Running totals per user/area/topic/day; each attempt stored as one JSON row; never read a full answer history |
| Rate limiting | Cloudflare rate-limit binding per client IP, fails open, no shared fallback bucket |
| Keep-alive | Daily Cloudflare Cron pings Turso and Supabase so the free tiers do not go idle |
| Offline | Questions in IndexedDB; answers queued with a client id (`cid`) and resent on reconnect, idempotent on the server; offline use limited to a grace period that never outlives the paid year |
| Guard-rails | Tests fail if a request uses more DB statements than its budget (`budget.test.ts`) or if any query scans a whole table (`plan.test.ts`); per-request row logging |
| Deploy | `npm run deploy` = typecheck + tests + migrations + `wrangler deploy` |

## Why migrate (problems this solves for ABELIEVER)
- Supabase Free's 5 GB/month egress took the site down once; most of it was shared question/reviewer content and answer history. Turso's free quota (500M rows read, 10M written, 5 GB) is counted in rows, and the edge cache serves shared content without touching the database.
- Supabase would remain only for Auth, which is small.
- CSE's notes say Vercel's free plan is non-commercial only. ABELIEVER is a paid product currently hosted that way. Cloudflare's free plan does not have that restriction (confirm the terms before launch).
- Static serving is unlimited and free; only API calls are bounded (100,000 requests/day on Workers Free).

## What ABELIEVER has today (to be mapped)
- Next.js (App Router, server actions, server components) on Vercel; Supabase Postgres with RLS; Supabase Auth.
- About 8,000 published questions with choices, about 225k `attempt_answers` rows, about 400 users, flashcards, reviewer entries, notes, bookmarks, mock/practice attempts, payments with the receipt check, admin panels, notice campaigns, trial/subscriber rules, connected-problem series.
- Heavy logic lives in SQL functions (`get_answer_summary`, `get_latest_outcomes`, `get_mistake_bank`, `get_topic_mastery`, `submit_attempt_answer`, `record_flashcard_review`, ...) that must be re-implemented in the API or as SQLite queries and running totals.

## Options (decision needed)
- **A. Rewrite to the CSE stack** (Vite + React SPA + Hono API + Turso, Supabase for Auth only). Cleanest and cheapest, proven by CSE; the largest effort because every Next.js page, server action and SQL function is re-implemented.
- **B. Incremental "strangler" migration (recommended).** Keep the Next.js app and move pieces behind a new Hono Worker one at a time:
  1. Shared, read-heavy content first (questions, choices, taxonomy, reviewers, flashcards, series) into Turso behind the edge cache. This removes most Supabase egress immediately.
  2. Per-user learning data next (attempts, answer summaries, mastery, mistakes, bookmarks, notes, streaks) as running totals in Turso.
  3. Auth stays on Supabase throughout; the Worker verifies its JWT.
  4. Last, move the front end to static hosting (the new Vite SPA built for the UX/UI redesign) and retire Vercel.
- **C. Next.js on Cloudflare** (OpenNext adapter) as a lift-and-shift. Quick to try, but server actions and the Workers Free bundle/CPU limits need measuring, and it does not by itself fix the Supabase egress.

## Phases (written for option B; adjust once the owner chooses)
0. **Decisions and inventory:** choose the option; list every table, SQL function and route; read Cloudflare and Turso terms (commercial use, inactive-database policy, backups); decide on existing or new accounts (CSE used new, isolated accounts).
1. **Foundation:** a Worker project (`api/`), Turso database, migrations as code, Supabase JWT verification, rate limiting, keep-alive cron, budget and no-table-scan tests, one-command deploy.
2. **Content to Turso:** one-time export from Supabase (questions, choices, topics, subjects, flashcards, reviewer entries, series data); import script with checks (counts, four choices each, balanced answer positions, series intact); an `updated_at` cursor; edge-cached read endpoints; the app switched over behind a flag.
3. **Learning data:** design the running totals; convert `attempt_answers` history into aggregates (not row-for-row unless needed); move mistakes, bookmarks and notes; dual-write briefly, compare results, then cut over.
4. **Payments, trial and admin:** port subscription and trial rules, the receipt check, and the admin question and user tools; the admin "Refresh question lists" button becomes an edge-cache purge.
5. **Front end and offline:** static front end with the new UX/UI; offline question snapshot and answer queue as in CSE; push reminders.
6. **Cutover and cleanup:** domain, redirects, monitoring and a rollback plan, then retire the Supabase tables that moved (Auth stays).

## Risks and checks
- **Workers Free limits:** 10 ms CPU per request, 100,000 requests/day, 3 MiB bundle; run a load test before cutover (CSE measured about 1,390 requests with zero CPU errors).
- **Turso free:** inactive databases may be archived (keep-alive cron); read the legal terms.
- **Data correctness:** reconcile question counts, answer-key positions, series tags, flashcard topics and PAES labels; spot-check samples.
- **Auth continuity:** users keep their Supabase accounts and ids so nobody has to re-register.
- **Email limits:** Supabase's built-in sender reaches few addresses (CSE measured about 2 emails/hour for non-team addresses); confirm how ABELIEVER students sign in.
- **Secrets:** only in Worker secrets and gitignored `.dev.vars`, never in chat or commits.
- **Accounts:** CSE deliberately used separate GitHub, Cloudflare, Turso and Supabase accounts; decide whether ABELIEVER uses the existing or new ones.

## Open questions for the owner
1. Option A (rewrite), B (incremental) or C (Next.js on Cloudflare)?
2. Same accounts as CSE, or new isolated accounts for ABELIEVER?
3. Keep Supabase Postgres as a read-only archive of old data, or retire it after cutover?
4. Keep the current domain/URL, or move (CSE uses a free pages.dev address)?
5. Timing relative to the exam (Nov 19-20, 2026) and the new landing page: migrate before or after it launches?
6. Build the redesign (Vite SPA) and the migration together, so the new front end only talks to the new API?
7. Is Cloudflare's $5/month Workers plan acceptable if it saves weeks of work (needed only if Next.js on Cloudflare, option C, exceeds the free 3 MiB bundle)?
8. Should the domain be live before the Nov 19 exam, or after the migration?

---

## First steps (agreed 2026-10-15)

The domain is independent of the host, so it comes first and carries no risk.

Owner (this week, about 30 minutes; Claude cannot buy domains or log in to accounts):
1. Buy **abelieverofficial.com** on Cloudflare (Domain Registration), on a personal email (CSE's notes warn about using the school account). Turn on auto-renew.
2. Point it at the current site: in Vercel add the domain and set the two DNS records Cloudflare shows; keep them "DNS only" at first so Vercel can issue its certificate.
3. Update every place that knows the old address: Supabase Authentication URL settings (site URL, redirect URLs); Google sign-in authorised origins; the site address setting in the app; Facebook and TikTok bio links.
4. Check that login, signup, a practice session and a mock work on the new address, then tell Claude.

Claude, after the domain is live:
5. App-side change (site address setting) and a login test on the new domain.
6. **Feasibility check** of moving the app off Vercel: build for Cloudflare, measure the bundle against the free limits (Workers Free: 3 MiB, 10 ms CPU, 100,000 requests/day), list what breaks (Next.js `unstable_cache`/`revalidateTag` shared caches and the admin "Refresh question lists" button must work on the new host). Report which option (A, B or C) is realistic.
7. Phase 1 foundation from this plan: Worker, Turso, Supabase JWT check, rate limiting, keep-alive cron, budget and no-table-scan tests, one-command deploy.

Not yet: moving the actual hosting or the data. The exam is Nov 19-20, 2026; keep the working site untouched until the foundation is tested.

## Realistic timeline (calibrated on the owner's real pace)

Evidence from the git history:
- ABELIEVER: scaffold 2026-09-18; the whole student platform (practice, mocks, mistakes, flashcards, admin, settings) on 2026-09-20 with 74 commits that day.
- CSE: on 2026-10-14, from 14:44 to 20:22 (about 6 hours), it went from Phase 0 to a deployed API with tests, Google login, landing page, full signup with receipt check, design system, legal pages and brand assets (about 80 commits that day, 33 more the next morning).

So the earlier "4 to 6 weeks" guess was too pessimistic. Re-estimated, where a "day" is one long working day like those two:

| Piece | Realistic time |
|---|---|
| Domain live, login working on it | A few hours (mostly the owner's DNS steps) |
| New landing page and signup | About 1 day (CSE's equivalent took roughly 3 to 4 hours, plus rounds of feedback) |
| Worker, Turso, login verification, guard tests | About 2 to 3 hours, as in CSE |
| Shared content (about 8,000 questions, flashcards, reviewers) moved to Turso with caching | Half a day |
| Per-user data and the ported SQL functions | 1 to 2 days |
| Whole student app and admin on the new stack | 2 to 3 days |
| Streaks and goals, spaced review, offline, leaderboard | 2 to 3 days |

Summary:
- **One day:** domain live, new landing and signup, foundation, and shared content on Turso (this alone removes the Supabase egress risk).
- **Fully off Vercel** with the student app and admin on the new setup: about 3 to 4 days of focused work.
- **Everything including the new features:** about 5 to 7 days.
- **Not in one day:** the full migration with student progress carried over. ABELIEVER is much bigger than CSE (225k answers, about 400 users, 15+ SQL functions, 12+ admin pages) and a mistake costs real students their progress.

What can slow it down: the owner's account and DNS steps, Claude's usage limit (a batch of work stopped on it on 2026-10-14), and testing with real students.

Before the Nov 19 exam: domain live, new landing and signup, shared content on Turso. After the exam: hosting switch, per-user data, community features.

## Status 2026-10-16: Worker is LIVE (phase 1, read-only, not yet used by the app)

- Deployed `abeliever-api` to Cloudflare at **https://api.abelieverofficial.com** (custom domain on the project's own zone, workers.dev disabled), daily keep-alive cron. Turso database `abeliever` (AWS ap-northeast-1) holds the shared content: 7,971 published questions, 31,884 choices, taxonomy. Secrets (TURSO_URL/TURSO_TOKEN) set with `wrangler secret bulk`; nothing secret in the repo (`api/.dev.vars` is git-ignored).
- Live check with a real Supabase login (throwaway account, deleted after): taxonomy 19 KB, id snapshot 307 KB (cold 2.8 s, then edge-cached), 10 questions 7.8 KB in 113 ms (cached 53 ms), 4 choices each, no answer/explanation fields. No/bad token -> 401 on every /v1 route; foreign origins get no CORS header.
- Known: Cloudflare's cache adds `max-age=14400` (4 h) for browsers on cached copies, so an edited question can look stale for up to 4 h on a device that already fetched it; the admin "Refresh question lists" button must also purge the edge cache (and ideally the Worker should send `max-age` itself).
- Next: add `CONTENT_SOURCE=turso` flag in the Next.js app for shared reads (taxonomy, snapshot, question text+choices) with automatic Supabase fallback; test on a Vercel preview first; keep grading/answers in Supabase.
