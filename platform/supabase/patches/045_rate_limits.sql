-- Postgres-backed fixed-window rate limiter for public-facing routes that
-- had NO throttling at all (signup, login, payment submission, AI bursts) —
-- flagged as a public-launch blocker on 2026-09-28 since these were
-- scriptable at any volume. Vercel's serverless functions are ephemeral and
-- multi-instance, so an in-memory counter wouldn't be a shared source of
-- truth across invocations/regions; this reuses the exact same proven
-- shape as public.ai_usage's daily counter (insert-on-conflict-do-nothing,
-- then select-for-update, then branch) rather than a cleverer single
-- UPSERT, since that pattern is already known to work correctly here.
--
-- `key` is an arbitrary caller-chosen string so one mechanism covers both
-- unauthenticated call sites (IP-keyed, e.g. "signup:203.0.113.4") and
-- authenticated ones (user-id-keyed, e.g. "payment:<uuid>"). Deliberately
-- NOT granted to authenticated/anon — only ever called via the service-role
-- client (src/lib/rate-limit.ts), since end users must never be able to
-- call this directly and reset/inspect their own counter.
create table if not exists public.rate_limits (
  key text primary key,
  window_start timestamptz not null default now(),
  count int not null default 0
);

alter table public.rate_limits enable row level security;
-- No policies — service-role bypasses RLS entirely, and nothing else should
-- ever touch this table.

create or replace function public.check_rate_limit(p_key text, p_limit int, p_window_seconds int)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_window_start timestamptz;
  v_count int;
  v_now timestamptz := now();
begin
  insert into public.rate_limits (key, window_start, count)
  values (p_key, v_now, 0)
  on conflict (key) do nothing;

  select window_start, count into v_window_start, v_count
  from public.rate_limits
  where key = p_key
  for update;

  if v_window_start < v_now - make_interval(secs => p_window_seconds) then
    update public.rate_limits set window_start = v_now, count = 1 where key = p_key;
    return true;
  end if;

  if v_count >= p_limit then
    return false;
  end if;

  update public.rate_limits set count = count + 1 where key = p_key;
  return true;
end;
$$;
