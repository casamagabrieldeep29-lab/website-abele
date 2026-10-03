-- 048: compact per-user functions (cut Supabase egress): get_answer_summary, get_latest_outcomes, get_topic_mastery_compact, get_subtopic_mastery_compact
--
-- Dashboard, Progress, Profile and the AI study assistant each used to
-- download EVERY row of the signed-in student's attempt_answers history
-- (~130 bytes/row incl. the embedded attempts join) just to compute a total,
-- an accuracy %, a weekly trend and "days studied". A student with 2,000
-- answers pulled ~260 KB per page view. This returns the same information
-- as a few KB of aggregates: lifetime totals, the accuracy of the most recent
-- N answers, and per-day (UTC) counts for the last p_days days.
--
-- Idempotent (create or replace). Runs as the caller (security invoker) and
-- additionally filters on auth.uid(), so an admin calling it still only gets
-- their own numbers (attempt_answers' SELECT policy lets admins read all rows).
-- Paste into the Supabase SQL Editor and run.

create or replace function public.get_answer_summary(
  p_recent_window int default 30,
  p_days int default 120
)
returns jsonb
language sql
stable
security invoker
set search_path = public
as $$
  with mine as (
    select aa.answered_at, aa.is_correct
    from public.attempt_answers aa
    join public.attempts a on a.id = aa.attempt_id
    where a.user_id = auth.uid()
      and aa.answered_at is not null
  ),
  recent as (
    select is_correct
    from mine
    order by answered_at desc
    limit greatest(p_recent_window, 0)
  ),
  daily as (
    select (answered_at at time zone 'utc')::date as d,
           count(*) as n,
           count(*) filter (where is_correct) as c
    from mine
    where answered_at >= now() - make_interval(days => greatest(p_days, 0))
    group by 1
  )
  select jsonb_build_object(
    'total',          (select count(*) from mine),
    'correct',        (select count(*) filter (where is_correct) from mine),
    'recent_total',   (select count(*) from recent),
    'recent_correct', (select count(*) filter (where is_correct) from recent),
    'days', coalesce(
      (select jsonb_agg(jsonb_build_object('d', d, 'n', n, 'c', c) order by d) from daily),
      '[]'::jsonb
    )
  );
$$;

grant execute on function public.get_answer_summary(int, int) to authenticated;

-- ---------------------------------------------------------------------------
-- get_latest_outcomes(): the student's latest result per question as two small
-- id lists. Practice/Quick/Custom session start used to download the student's
-- ENTIRE answer history (twice, with the attempts join) just to know which
-- questions were last answered correctly / incorrectly / never. This returns
-- at most one uuid per distinct question the student has answered.
-- ---------------------------------------------------------------------------
create or replace function public.get_latest_outcomes()
returns jsonb
language sql
stable
security invoker
set search_path = public
as $$
  with latest as (
    select distinct on (aa.question_id) aa.question_id, aa.is_correct
    from public.attempt_answers aa
    join public.attempts a on a.id = aa.attempt_id
    where a.user_id = auth.uid()
      and aa.answered_at is not null
      and aa.is_correct is not null
    order by aa.question_id, aa.answered_at desc
  )
  select jsonb_build_object(
    'correct',   coalesce((select jsonb_agg(question_id) from latest where is_correct), '[]'::jsonb),
    'incorrect', coalesce((select jsonb_agg(question_id) from latest where not is_correct), '[]'::jsonb)
  );
$$;

grant execute on function public.get_latest_outcomes() to authenticated;

-- ---------------------------------------------------------------------------
-- Compact mastery: get_topic_mastery() returns 42 rows x 12 columns every call
-- (~20 KB), repeating long topic/area/subject NAMES that every student already
-- gets from the cached taxonomy, and get_subtopic_mastery() another ~29 KB.
-- They run on Dashboard, Progress, Profile, Mistakes, AI chat and session
-- starts. These wrappers call the originals (so the scoring logic is unchanged)
-- and return only the numeric columns, only for topics/subtopics the student
-- has actually answered. The app rebuilds the full rows from cached names.
-- ---------------------------------------------------------------------------
create or replace function public.get_topic_mastery_compact()
returns jsonb
language sql
stable
security invoker
set search_path = public
as $$
  select coalesce(
    jsonb_agg(jsonb_build_array(
      topic_id, total_attempts, overall_accuracy, recent_accuracy, mastery, status, last_answered_at
    )),
    '[]'::jsonb
  )
  from public.get_topic_mastery()
  where total_attempts > 0;
$$;

grant execute on function public.get_topic_mastery_compact() to authenticated;

create or replace function public.get_subtopic_mastery_compact()
returns jsonb
language sql
stable
security invoker
set search_path = public
as $$
  select coalesce(
    jsonb_agg(jsonb_build_array(
      subtopic_id, total_attempts, overall_accuracy, recent_accuracy, mastery, status, last_answered_at
    )),
    '[]'::jsonb
  )
  from public.get_subtopic_mastery()
  where total_attempts > 0;
$$;

grant execute on function public.get_subtopic_mastery_compact() to authenticated;
