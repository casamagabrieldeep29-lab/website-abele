-- ============================================================================
-- 7. record_mock_answer RPC — like submit_attempt_answer, but for Mock Exam.
-- ============================================================================
-- Mock Exam does NOT give per-question feedback (that would defeat the point
-- of a timed simulated exam). This grades silently and stores the result;
-- nothing about correctness is returned to the client until the exam is
-- completed and get_attempt_review() is called.

create or replace function public.record_mock_answer(
  p_attempt_id uuid,
  p_question_id uuid,
  p_selected_choice_ids uuid[]
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_correct_choice_ids uuid[];
  v_is_correct boolean;
begin
  if not exists (
    select 1 from public.attempts att
    where att.id = p_attempt_id
      and (att.user_id = auth.uid() or public.is_admin())
      and att.status = 'in_progress'
  ) then
    raise exception 'Attempt not found, not yours, or no longer in progress.';
  end if;

  select array_agg(c.id order by c.id) into v_correct_choice_ids
  from public.choices c
  where c.question_id = p_question_id and c.is_correct = true;

  v_is_correct := (
    array_length(p_selected_choice_ids, 1) is not null
    and (
      select array_agg(x order by x) from unnest(p_selected_choice_ids) x
    ) = v_correct_choice_ids
  );

  insert into public.attempt_answers
    (attempt_id, question_id, selected_choice_ids, is_correct, answered_at)
  values
    (p_attempt_id, p_question_id, p_selected_choice_ids, v_is_correct, now())
  on conflict (attempt_id, question_id) do update
    set selected_choice_ids = excluded.selected_choice_ids,
        is_correct = excluded.is_correct,
        answered_at = excluded.answered_at;
end;
$$;

grant execute on function public.record_mock_answer(uuid, uuid, uuid[]) to authenticated;

-- ============================================================================
-- 8. get_attempt_review RPC — post-completion answer review (Practice or Mock)
-- ============================================================================
-- Only returns data for COMPLETED attempts owned by the caller (or admin).
-- Reveals full choice list with is_correct, the student's own selection, and
-- the explanation — this is the answer-key reveal, gated on the attempt
-- actually being finished so a Mock Exam can't be peeked at mid-run.

create or replace function public.get_attempt_review(p_attempt_id uuid)
returns table (
  question_id uuid,
  question_text text,
  choices jsonb,
  selected_choice_ids uuid[],
  is_correct boolean,
  explanation text
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
      q.id,
      q.question_text,
      (
        select jsonb_agg(
          jsonb_build_object('id', c.id, 'text', c.choice_text, 'is_correct', c.is_correct)
          order by c.sort_order
        )
        from public.choices c
        where c.question_id = q.id
      ),
      aa.selected_choice_ids,
      aa.is_correct,
      q.explanation
    from public.attempt_answers aa
    join public.questions q on q.id = aa.question_id
    where aa.attempt_id = p_attempt_id
    order by aa.answered_at;
end;
$$;

grant execute on function public.get_attempt_review(uuid) to authenticated;

-- ============================================================================
-- Note on future schema changes
-- ============================================================================
-- This file is the CURRENT full schema, not a migration history. Once the
-- pilot is live with real data, switch to timestamped migration files
-- (supabase/migrations/<timestamp>_<name>.sql, applied via `supabase db
-- push` or the SQL Editor) instead of re-running/editing this file, so
-- existing data and applied changes aren't clobbered.
