-- get_paes_mastery RPC — mirrors get_topic_mastery() exactly (same formula,
-- same >=5-attempt threshold, same strong/developing/needs_review bands),
-- just grouped by q.paes_reference instead of q.topic_id and filtered to
-- is_paes = true questions. PAES questions span many different topics, so
-- topic-level mastery isn't the right lens for "how well do I know PAES
-- 401" — grouping by the standard number itself is. Category buckets
-- (Animal Production, Farm Structures, etc.) are derived client-side from
-- paes_reference via the same derivePaesCategory() helper the Library and
-- Number Bank already use, rather than duplicating that logic in SQL.

create or replace function public.get_paes_mastery()
returns table (
  paes_reference text,
  sample_title text,
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
      q.paes_reference,
      q.title as q_title,
      aa.is_correct,
      aa.answered_at,
      row_number() over (partition by q.paes_reference order by aa.answered_at desc) as rn
    from public.attempt_answers aa
    join public.attempts att on att.id = aa.attempt_id
    join (select id, paes_reference, question_text as title from public.questions where is_paes = true) q
      on q.id = aa.question_id
    where att.user_id = auth.uid() and aa.answered_at is not null and q.paes_reference is not null
  ),
  agg as (
    select
      paes_reference,
      count(*) as total_attempts,
      round(100.0 * avg(is_correct::int), 1) as overall_accuracy,
      round(100.0 * avg(is_correct::int) filter (where rn <= 10), 1) as recent_accuracy,
      max(answered_at) as last_answered_at,
      min(q_title) as sample_title
    from answers
    group by paes_reference
  )
  select
    ref.paes_reference,
    a.sample_title,
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
  from (select distinct paes_reference from public.questions where is_paes = true and paes_reference is not null) ref
  left join agg a on a.paes_reference = ref.paes_reference
  order by ref.paes_reference;
$$;

grant execute on function public.get_paes_mastery() to authenticated;
