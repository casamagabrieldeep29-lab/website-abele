-- ============================================================================
-- 010 — user_settings: per-user preferences for the Profile/Settings feature
-- ============================================================================
-- One row per user, created lazily on first save (app code upserts by
-- user_id). Deliberately a separate table from `profiles` rather than new
-- columns on it — profiles is the core identity row (referenced by many FKs,
-- guarded by the role-escalation trigger); preferences are a distinct,
-- purely-owned-by-the-user concern, matching the existing pattern for
-- question_notes/bookmarks/study_plans (own small table keyed on user_id).
--
-- target_exam_date here is a general preference the student can set from
-- /profile at any time. It's intentionally separate from
-- study_plans.target_exam_date, which only exists once a full plan has been
-- generated (it's required alongside study_days/minutes_per_day there). The
-- Study Plan page pre-fills its date field from this preference when no plan
-- exists yet, and generating a plan writes the chosen date back here — so
-- the two stay in sync without one table depending on the other's shape.

create table if not exists public.user_settings (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  target_exam_date date,
  default_practice_length int not null default 20
    check (default_practice_length in (10, 20, 30, 50)),
  default_practice_mode text not null default 'mixed'
    check (default_practice_mode in ('mixed', 'weak_areas', 'mistakes', 'unanswered')),
  updated_at timestamptz not null default now()
);

comment on table public.user_settings is 'Per-user Profile/Settings preferences: target exam date, default practice length/mode. See 26_BUILD_CHECKLIST.md.';

alter table public.user_settings enable row level security;

drop policy if exists "user_settings_own_or_admin" on public.user_settings;
create policy "user_settings_own_or_admin" on public.user_settings
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());
