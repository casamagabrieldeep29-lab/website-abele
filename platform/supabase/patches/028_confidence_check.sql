-- Confidence self-rating on quiz answers ("Knew it" / "Not sure" / "Guessed")
-- for the PAES Quizzer's post-answer confidence check (Phase 2). Generic on
-- attempt_answers, not PAES-specific, so any quiz mode could adopt it later
-- — but only the PAES Quizzer UI captures it for now, and it's purely
-- diagnostic (never affects grading). Nullable/optional: every existing
-- caller of submit_attempt_answer keeps working completely unchanged, since
-- Postgres allows CREATE OR REPLACE FUNCTION to append a new parameter with
-- a default value without touching the existing 3-arg call shape.

alter table public.attempt_answers add column if not exists confidence text
  check (confidence in ('knew_it', 'not_sure', 'guessed'));

create or replace function public.submit_attempt_answer(
  p_attempt_id uuid,
  p_question_id uuid,
  p_selected_choice_ids uuid[],
  p_confidence text default null
)
returns table (
  is_correct boolean,
  correct_choice_ids uuid[],
  explanation text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_correct_choice_ids uuid[];
  v_is_correct boolean;
  v_explanation text;
begin
  if p_confidence is not null and p_confidence not in ('knew_it', 'not_sure', 'guessed') then
    raise exception 'Invalid confidence value: %', p_confidence;
  end if;

  -- Ownership check: only the attempt's own owner (or admin) may submit.
  if not exists (
    select 1 from public.attempts a
    where a.id = p_attempt_id
      and (a.user_id = auth.uid() or public.is_admin())
      and a.status = 'in_progress'
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

  select q.explanation into v_explanation
  from public.questions q
  where q.id = p_question_id;

  insert into public.attempt_answers
    (attempt_id, question_id, selected_choice_ids, is_correct, answered_at, confidence)
  values
    (p_attempt_id, p_question_id, p_selected_choice_ids, v_is_correct, now(), p_confidence)
  on conflict (attempt_id, question_id) do update
    set selected_choice_ids = excluded.selected_choice_ids,
        is_correct = excluded.is_correct,
        answered_at = excluded.answered_at,
        confidence = excluded.confidence;

  return query select v_is_correct, v_correct_choice_ids, v_explanation;
end;
$$;

grant execute on function public.submit_attempt_answer(uuid, uuid, uuid[], text) to authenticated;
