-- Manual Subscriber / Free-Trial distinction — no payment gateway, Gabriel
-- assigns the plan himself at invite time (per his explicit "I will still
-- be the one adding the emails in both... i just want it separated",
-- 2026-09-25). A free-trial account is blocked (see src/lib/supabase/
-- proxy.ts) once 14 days have passed since it was created; a subscriber
-- account never expires. `trial_started_at` is its own column rather than
-- reusing `created_at` so a future "extend trial" admin action has
-- somewhere to write to without overloading created_at's original meaning.

alter table public.profiles
  add column if not exists plan text not null default 'trial' check (plan in ('trial', 'subscriber')),
  add column if not exists trial_started_at timestamptz not null default now();

-- Every profile that already exists predates this feature — treat them all
-- as subscribers rather than silently locking out existing reviewees the
-- moment this migration runs. Only NEW invites default to 'trial'.
update public.profiles set plan = 'subscriber' where plan = 'trial';

comment on column public.profiles.plan is 'Manually assigned by an admin at invite time — no billing integration. ''trial'' accounts are blocked 14 days after trial_started_at unless moved to ''subscriber''.';
