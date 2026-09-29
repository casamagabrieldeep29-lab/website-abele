-- Recurring, admin-scheduled popup campaigns shown to existing users on
-- login/page-load — e.g. "please add your password/school/address," twice a
-- day for a week (Gabriel's explicit request, 2026-09-29). Deliberately
-- separate from the one-shot profile_prompt_dismissed_at flow (patch 042):
-- that one is permanent-dismiss and single-purpose (academic_status only),
-- which can't represent "show N times over M days" — this is a proper
-- reusable schedule an admin can create more of later, not a bolt-on second
-- flag on profiles.

-- Tracks whether an account has ever had a password set, so a campaign can
-- target "still missing a password" the same way it targets school/address.
-- Not knowable from `profiles` alone (password lives on auth.users, which a
-- regular RLS-scoped client can't read) — this mirrors it onto profiles at
-- the two points a password can actually be set: signup (handle_new_user
-- below, checked straight off the new auth.users row) and the "complete your
-- profile" / notice-campaign forms (settings/actions.ts, updated alongside
-- this patch). Backfilled once here for every account that already has one.
alter table public.profiles
  add column if not exists has_password boolean not null default false;

comment on column public.profiles.has_password is 'True once this account has ever had a password set (vs. relying solely on emailed sign-in codes). Mirrored from auth.users.encrypted_password at the two points it can change — see handle_new_user() and saveNoticeCampaignResponse/saveProfileDetails.';

update public.profiles p
set has_password = true
from auth.users u
where u.id = p.id
  and u.encrypted_password is not null
  and not p.has_password;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, has_password)
  values (new.id, new.email, new.encrypted_password is not null)
  on conflict (id) do nothing;
  return new;
end;
$$;

-- A campaign an admin creates from /admin/announcements. `target_fields` is
-- a fixed small set (not a generic key-value form builder) — only these
-- three profile gaps exist today, and a future need this doesn't cover is
-- worth its own thought rather than blindly generalizing further.
create table if not exists public.notice_campaigns (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  message text not null,
  target_fields text[] not null default '{}'::text[] check (
    target_fields <@ array['address', 'school', 'password']::text[]
  ),
  starts_at timestamptz not null default now(),
  ends_at timestamptz not null,
  times_per_day int not null default 2 check (times_per_day > 0),
  active boolean not null default true,
  created_at timestamptz not null default now(),
  created_by uuid references public.profiles (id)
);

comment on table public.notice_campaigns is 'Admin-scheduled recurring popup campaigns shown to signed-in users on page load — see notice_campaign_views for the per-user "how many times today" tracking that enforces times_per_day.';

create index if not exists notice_campaigns_active_window_idx
  on public.notice_campaigns (active, starts_at, ends_at);

-- Insert-only log of every time a campaign was actually shown to a user.
-- Counting today's rows per (user, campaign) — rather than a single
-- last-shown timestamp/counter — keeps the "times per day" cap auditable
-- and correct across a midnight rollover without any reset job.
create table if not exists public.notice_campaign_views (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.notice_campaigns (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  shown_at timestamptz not null default now()
);

create index if not exists notice_campaign_views_user_campaign_idx
  on public.notice_campaign_views (user_id, campaign_id, shown_at);

alter table public.notice_campaigns enable row level security;
alter table public.notice_campaign_views enable row level security;

-- Any signed-in user can read a campaign that's currently in its active
-- window (needed so the (app) layout's server-rendered check can run under
-- the regular RLS-scoped client, same as profiles) — never a draft, a
-- future-scheduled one, or a past one, and never write one at all; creating
-- or editing is service-role only (requireAdmin() + createAdminClient(),
-- same pattern as every other admin action in this codebase).
create policy "notice_campaigns_select_active" on public.notice_campaigns
  for select using (active and now() between starts_at and ends_at);

-- A user can log (insert) their own view and read their own view history
-- (needed to compute today's count before deciding to show again) but never
-- see or write another user's.
create policy "notice_campaign_views_select_own" on public.notice_campaign_views
  for select using (auth.uid() = user_id);

create policy "notice_campaign_views_insert_own" on public.notice_campaign_views
  for insert with check (auth.uid() = user_id);

-- The actual campaign this patch ships for — starts the moment this
-- migration runs, ends 7 days later, twice a day, targeting the three
-- fields Gabriel asked for (2026-09-29). Deactivate early from
-- /admin/announcements if needed; no code change required either way.
insert into public.notice_campaigns (title, message, target_fields, starts_at, ends_at, times_per_day)
values (
  'A couple of things to add',
  'Take a second to fill these in — it helps us reach you and keep your account secure.',
  array['address', 'school', 'password'],
  now(),
  now() + interval '7 days',
  2
);
