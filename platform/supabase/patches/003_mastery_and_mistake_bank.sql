-- ============================================================================
-- 9. get_topic_mastery RPC — per-topic mastery for the calling user
-- ============================================================================
-- mastery = 0.6*recent_accuracy + 0.4*overall_accuracy, where recent_accuracy
-- is over the last min(10, total_attempts) graded answers. Only computed once
-- total_attempts >= 5 for that topic; below that, mastery/status is
-- 'insufficient_data' rather than showing a misleading percentage off 1-2
-- questions. Bands: >=80 strong, 60-79 developing, <60 needs_review.
--
-- SECURITY DEFINER is required here (not because this reveals answer keys —
-- it doesn't) but because `questions` is admin-only for direct SELECT, and
-- this function needs to read questions.topic_id to group attempt_answers by
-- topic. The explicit `att.user_id = auth.uid()` filter below is what keeps
-- this scoped to the caller's own data (same pattern as the RPCs above).

create or replace function public.get_topic_mastery()
returns table (
  topic_id uuid,
  topic_name text,
  exam_area_name text,
  total_attempts int,
  overall_accuracy numeric,
  recent_accuracy numeric,
  mastery int,
  status text,
  last_answered_at timestamptz
)
language sql
security definer
stable
set search_path = public
as $$
  with answers as (
    select
      q.topic_id,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by q.topic_id order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    join public.questions q on q.id = aa.question_id
    where att.user_id = auth.uid() and aa.answered_at is not null
  ),
  agg as (
    select
      topic_id,
      count(*) as total_attempts,
      round(100.0 * avg(is_correct::int), 1) as overall_accuracy,
      round(100.0 * avg(is_correct::int) filter (where rn <= 10), 1) as recent_accuracy,
      max(answered_at) as last_answered_at
    from answers
    group by topic_id
  )
  select
    t.id,
    t.name,
    ea.name,
    coalesce(a.total_attempts, 0),
    a.overall_accuracy,
    a.recent_accuracy,
    case when coalesce(a.total_attempts, 0) >= 5
      then round(0.6 * a.recent_accuracy + 0.4 * a.overall_accuracy)
      else null end,
    case
      when coalesce(a.total_attempts, 0) < 5 then 'insufficient_data'
      when round(0.6 * a.recent_accuracy + 0.4 * a.overall_accuracy) >= 80 then 'strong'
      when round(0.6 * a.recent_accuracy + 0.4 * a.overall_accuracy) >= 60 then 'developing'
      else 'needs_review'
    end,
    a.last_answered_at
  from public.topics t
  join public.exam_areas ea on ea.id = t.exam_area_id
  left join agg a on a.topic_id = t.id
  order by t.name;
$$;

grant execute on function public.get_topic_mastery() to authenticated;

-- ============================================================================
-- 10. get_mistake_bank RPC — questions the caller most recently got wrong
-- ============================================================================
-- "Self-correcting": a question drops off this list as soon as the caller's
-- MOST RECENT answer to it is correct (one clean retry clears it — a
-- simplification of "consistent mastery" documented in 25_DECISION_LOG.md).

create or replace function public.get_mistake_bank()
returns table (
  question_id uuid,
  question_text text,
  topic_id uuid,
  topic_name text,
  times_missed int,
  last_answered_at timestamptz
)
language sql
security definer
stable
set search_path = public
as $$
  with my_answers as (
    select
      aa.question_id,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by aa.question_id order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    where att.user_id = auth.uid() and aa.answered_at is not null
  ),
  latest as (
    select question_id, is_correct, answered_at
    from my_answers where rn = 1
  ),
  miss_counts as (
    select question_id, count(*) filter (where is_correct = false) as times_missed
    from my_answers
    group by question_id
  )
  select
    q.id,
    q.question_text,
    q.topic_id,
    t.name,
    mc.times_missed,
    l.answered_at
  from latest l
  join public.questions q on q.id = l.question_id
  join public.topics t on t.id = q.topic_id
  join miss_counts mc on mc.question_id = l.question_id
  where l.is_correct = false
  order by l.answered_at desc;
$$;

grant execute on function public.get_mistake_bank() to authenticated;
