-- Dashboard Phase 3 (2026-09-28) — Concept Mastery: extends the existing
-- Subject -> Area -> Topic mastery tree (get_topic_mastery(), patch
-- 013_official_subjects.sql) one level deeper, to Topic -> Concept, reusing
-- the `subtopics` table that already exists (already used as the innermost
-- drill-down tier in Question Bank, via startSubtopicPracticeAttempt).
--
-- The mastery formula is byte-for-byte the same as get_topic_mastery()'s —
-- same 0.6*recent + 0.4*overall weighting, same 5-attempt threshold, same
-- strong/developing/needs_review bands — just grouped by subtopic_id
-- instead of topic_id. Returns every subtopic (most with
-- status='insufficient_data' until answered enough), same pattern as
-- get_topic_mastery() returning every topic regardless of activity.

create or replace function public.get_subtopic_mastery()
returns table (
  subtopic_id uuid,
  subtopic_name text,
  topic_id uuid,
  topic_name text,
  exam_area_id uuid,
  exam_area_name text,
  subject_id uuid,
  subject_name text,
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
      q.subtopic_id,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by q.subtopic_id order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    join public.questions q on q.id = aa.question_id
    where att.user_id = auth.uid() and aa.answered_at is not null and q.subtopic_id is not null
  ),
  agg as (
    select
      subtopic_id,
      count(*) as total_attempts,
      round(100.0 * avg(is_correct::int), 1) as overall_accuracy,
      round(100.0 * avg(is_correct::int) filter (where rn <= 10), 1) as recent_accuracy,
      max(answered_at) as last_answered_at
    from answers
    group by subtopic_id
  )
  select
    st.id,
    st.name,
    t.id,
    t.name,
    ea.id,
    ea.name,
    s.id,
    s.name,
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
  from public.subtopics st
  join public.topics t on t.id = st.topic_id
  join public.exam_areas ea on ea.id = t.exam_area_id
  left join public.subjects s on s.id = t.subject_id
  left join agg a on a.subtopic_id = st.id
  order by t.name, st.name;
$$;

grant execute on function public.get_subtopic_mastery() to authenticated;
