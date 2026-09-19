-- ============================================================================
-- 12. study_plans — rule-based study schedule (Feature 12)
-- ============================================================================

create table if not exists public.study_plans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  target_exam_date date not null,
  study_days text[] not null, -- e.g. {'mon','wed','fri','sat'}
  minutes_per_day int not null default 60,
  generated_plan jsonb not null, -- see study-plan/actions.ts's generatePlan()
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id) -- one active plan per user; regenerating replaces it
);

alter table public.study_plans enable row level security;

drop policy if exists "study_plans_own_or_admin" on public.study_plans;
create policy "study_plans_own_or_admin" on public.study_plans
  for all to authenticated
  using (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- ============================================================================
-- 13. user_achievements — persisted milestones (Feature 17)
-- ============================================================================
-- Persisted (not computed live) so a threshold-based badge (e.g. "90%
-- accuracy") isn't lost if later performance dips below the threshold again.

create table if not exists public.user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  achievement_code text not null,
  earned_at timestamptz not null default now(),
  unique (user_id, achievement_code)
);

alter table public.user_achievements enable row level security;

drop policy if exists "user_achievements_own_or_admin" on public.user_achievements;
create policy "user_achievements_own_or_admin" on public.user_achievements
  for select to authenticated
  using (user_id = auth.uid() or public.is_admin());

-- Checks the caller's current stats against the fixed achievement
-- thresholds (defined here, not in application code, so they can't drift
-- out of sync with what's actually been awarded) and inserts any newly
-- earned ones. Call after completing an attempt. Idempotent.
create or replace function public.check_and_award_achievements()
returns table (achievement_code text, newly_earned boolean)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_total_answered int;
  v_overall_accuracy numeric;
  v_mock_completed int;
  v_streak int := 0;
  v_check_date date := current_date;
  v_candidate text;
  v_thresholds text[] := array['FIRST_100','FIVE_HUNDRED','ONE_THOUSAND','ACCURACY_90','MOCK_COMPLETE','STREAK_7','STREAK_14'];
begin
  if v_uid is null then
    raise exception 'Not authenticated.';
  end if;

  select count(*), round(100.0 * avg(is_correct::int), 1)
    into v_total_answered, v_overall_accuracy
  from public.attempt_answers aa
  join public.attempts att on att.id = aa.attempt_id
  where att.user_id = v_uid and aa.answered_at is not null;

  select count(*) into v_mock_completed
  from public.attempts
  where user_id = v_uid and mode = 'mock' and status = 'completed';

  -- Streak: consecutive days (today or yesterday backward) with >=1 answer.
  if exists (
    select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
    where att.user_id = v_uid and aa.answered_at::date = v_check_date
  ) or exists (
    select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
    where att.user_id = v_uid and aa.answered_at::date = v_check_date - 1
  ) then
    if not exists (
      select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
      where att.user_id = v_uid and aa.answered_at::date = v_check_date
    ) then
      v_check_date := v_check_date - 1;
    end if;
    while exists (
      select 1 from public.attempt_answers aa join public.attempts att on att.id = aa.attempt_id
      where att.user_id = v_uid and aa.answered_at::date = v_check_date
    ) loop
      v_streak := v_streak + 1;
      v_check_date := v_check_date - 1;
    end loop;
  end if;

  foreach v_candidate in array v_thresholds loop
    if (
      (v_candidate = 'FIRST_100' and v_total_answered >= 100) or
      (v_candidate = 'FIVE_HUNDRED' and v_total_answered >= 500) or
      (v_candidate = 'ONE_THOUSAND' and v_total_answered >= 1000) or
      (v_candidate = 'ACCURACY_90' and v_total_answered >= 50 and v_overall_accuracy >= 90) or
      (v_candidate = 'MOCK_COMPLETE' and v_mock_completed >= 1) or
      (v_candidate = 'STREAK_7' and v_streak >= 7) or
      (v_candidate = 'STREAK_14' and v_streak >= 14)
    ) then
      insert into public.user_achievements (user_id, achievement_code)
      values (v_uid, v_candidate)
      on conflict (user_id, achievement_code) do nothing;
    end if;
  end loop;

  return query
    select ua.achievement_code, (ua.earned_at > now() - interval '5 seconds')
    from public.user_achievements ua
    where ua.user_id = v_uid;
end;
$$;

grant execute on function public.check_and_award_achievements() to authenticated;

-- ============================================================================
-- 14. Question of the Day — deterministic pick, no scheduler/table needed
-- ============================================================================
-- The question itself is picked deterministically in application code
-- (hash of today's date over the published question pool) — no table
-- needed for "which question is today's." This RPC only computes the
-- anonymized aggregate stat, and only reveals it once enough people have
-- actually answered (never fabricated, never exposes individual users).

create or replace function public.get_daily_question_stats(p_question_id uuid, p_since timestamptz)
returns table (total_answers int, correct_count int)
language sql
security definer
stable
set search_path = public
as $$
  select count(*)::int, count(*) filter (where is_correct)::int
  from public.attempt_answers
  where question_id = p_question_id and answered_at >= p_since;
$$;

grant execute on function public.get_daily_question_stats(uuid, timestamptz) to authenticated;

-- ============================================================================
-- 15. Subtopic-scoped adaptive practice support
-- ============================================================================
-- No schema change needed here — student_questions/student_choices views
-- already expose subtopic_id, and startSubtopicPracticeAttempt (app code)
-- reuses the existing weighCandidates()/weightedSample() helpers filtered by
-- subtopic_id instead of topic_id. Noted here only so the "why no new RPC"
-- question doesn't come up later.
