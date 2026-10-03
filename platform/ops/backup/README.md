# Backup + standby copy (free)

Supabase Free has **no backups**. Two GitHub Actions jobs, both in a **PRIVATE repo**
(this repo is public; the data holds student emails and payment references):

| File | What it does |
|---|---|
| `backup.yml` | Weekly encrypted copy of the database, kept 30 days as a private artifact. |
| `copy-to-standby.yml` | Copies the whole database (data, logins, functions, policies) into the standby Supabase project, on demand + weekly. |

## One-time setup
1. Create a private GitHub repo (e.g. `abeliever-backup`).
2. Put `backup.yml` and `copy-to-standby.yml` in its `.github/workflows/` folder.
3. In that repo: Settings → Secrets and variables → Actions → New repository secret:
   - `SOURCE_DB_URL` — PRODUCTION project → Connect → **Session pooler** string (port 5432), with the database password filled in. Pooler, not "Direct": GitHub runners have no IPv6.
   - `TARGET_DB_URL` — same, but from the **STANDBY** project (in the standby org).
   - `BACKUP_PASSPHRASE` — a long random passphrase; also save it in your password manager.
4. Actions → "Copy to standby" → Run workflow → type `COPY`. Then run "Database backup" once.

The copy job refuses to run if the two URLs point at the same project, so it can never overwrite production.

## What is NOT copied
Receipt images in Storage (payment screenshots) and the passwords of Vercel/Google/etc. Students' ABELIEVER logins are copied.

## Switching to the standby (only if Supabase production is down for long)
Vercel → Settings → Environment Variables: change `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY` (or publishable key) and `SUPABASE_SERVICE_ROLE_KEY` to the standby's values, then Redeploy. Students must log in again; data is as of the last copy.

## Restore a backup by hand
```
gpg --decrypt abeliever-YYYY-MM-DD.tar.gpg | tar -x
pg_restore --no-owner --data-only -d "<DB_URL>" auth.dump
pg_restore --no-owner --clean --if-exists -d "<DB_URL>" public.dump
```

## Egress cost
Each run downloads about the database size from production and counts against the 5 GB/month. Two jobs ≈ 2× the DB size per week. Check Database size in the dashboard before making it nightly.
