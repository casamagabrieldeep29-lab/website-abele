-- ============================================================================
-- get_mock_exam_subject_breakdown RPC — per-official-subject score rollup
-- for a completed Mock Exam attempt, used to build the emailed results
-- report (Area 1/2/3 exams are graded per the real board exam's TOS
-- subjects — see 25_DECISION_LOG.md's Area mapping entry and
-- OFFICIAL_SUBJECT_ITEM_TARGETS in mock/actions.ts).
--
-- Same ownership gate as get_attempt_review (002_mock_exam_functions.sql):
-- only a completed attempt's own owner (or an admin) can read it.
-- ============================================================================

create or replace function public.get_mock_exam_subject_breakdown(p_attempt_id uuid)
returns table (
  exam_area_name text,
  subject_name text,
  total int,
  correct int
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not exists (
    select 1 from public.attempts att
    where att.id = p_attempt_id
      and (att.user_id = auth.uid() or public.is_admin())
      and att.status = 'completed'
  ) then
    raise exception 'Attempt not found, not yours, or not yet completed.';
  end if;

  return query
    select
      ea.name,
      coalesce(s.name, 'Other'),
      count(*)::int,
      count(*) filter (where aa.is_correct)::int
    from public.attempt_answers aa
    join public.questions q on q.id = aa.question_id
    join public.topics t on t.id = q.topic_id
    join public.exam_areas ea on ea.id = t.exam_area_id
    left join public.subjects s on s.id = t.subject_id
    where aa.attempt_id = p_attempt_id
    group by ea.sort_order, ea.name, s.name
    order by ea.sort_order, s.name;
end;
$$;

grant execute on function public.get_mock_exam_subject_breakdown(uuid) to authenticated;
