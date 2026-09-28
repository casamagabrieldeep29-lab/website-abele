-- Mistake Bank 2.0 (Phase 2, 2026-09-28): the UI needs an attempt_id per
-- mistake so it can call the EXISTING get_teach_me_context(attempt_id,
-- question_id) RPC and the existing <TeachMeThis> component for each one —
-- reusing their already-safe ownership check and explanation/choices data
-- instead of building a new explanation-fetching path from scratch.
--
-- Postgres can't change a function's return columns via CREATE OR REPLACE,
-- so the old signature is dropped first.
drop function if exists public.get_mistake_bank();

create or replace function public.get_mistake_bank()
returns table (
  question_id uuid,
  question_text text,
  topic_id uuid,
  topic_name text,
  times_missed int,
  last_answered_at timestamptz,
  attempt_id uuid
)
language sql
security definer
stable
set search_path = public
as $$
  with my_answers as (
    select
      aa.question_id,
      aa.attempt_id,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by aa.question_id order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    where att.user_id = auth.uid() and aa.answered_at is not null
  ),
  latest as (
    select question_id, attempt_id, is_correct, answered_at
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
    l.answered_at,
    l.attempt_id
  from latest l
  join public.questions q on q.id = l.question_id
  join public.topics t on t.id = q.topic_id
  join miss_counts mc on mc.question_id = l.question_id
  where l.is_correct = false
  order by l.answered_at desc;
$$;

grant execute on function public.get_mistake_bank() to authenticated;
