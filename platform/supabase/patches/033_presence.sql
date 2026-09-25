-- "Who's active" admin indicator — a lightweight heartbeat rather than real
-- Supabase Realtime presence channels (which would need new subscription/
-- connection-lifecycle infrastructure on both the student and admin side
-- for what's mostly a cosmetic green dot on a study app people use in short
-- bursts). The client pings this timestamp roughly once a minute while a
-- tab is visible; admin treats "pinged in the last 2 minutes" as online.

alter table public.profiles
  add column if not exists last_seen_at timestamptz;

comment on column public.profiles.last_seen_at is 'Updated by a client-side heartbeat (~every 60s while a tab is visible). "Online" = pinged within the last ~2 minutes.';
