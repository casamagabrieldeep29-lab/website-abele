-- Day streak becomes a persisted counter on profiles instead of being
-- recomputed live from attempt_answers.answered_at every page load. Living
-- the way it did meant "Reset Progress" (which deletes attempt_answers so a
-- student can start their stats over) also silently zeroed their streak —
-- but a streak is a practice-consistency habit metric, not a content-mastery
-- stat derived from *which* questions were answered. Gabriel's report
-- (2026-09-25): "this shouldn't be affected" by a progress reset.

alter table public.profiles
  add column if not exists current_streak integer not null default 0,
  add column if not exists streak_last_active date;

-- One-time backfill using the same consecutive-days-back algorithm
-- study-stats.ts used to compute the streak live, so this migration doesn't
-- itself reset anyone's already-earned streak to 0.
with study_days as (
  select att.user_id, aa.answered_at::date as d
  from public.attempt_answers aa
  join public.attempts att on att.id = aa.attempt_id
  where aa.answered_at is not null
  group by att.user_id, aa.answered_at::date
),
ranked as (
  select user_id, d,
    d - (row_number() over (partition by user_id order by d desc))::int as grp
  from study_days
  where d <= current_date
),
current_run as (
  select user_id, grp, count(*) as streak_len, max(d) as last_day
  from ranked
  group by user_id, grp
),
best as (
  select distinct on (user_id) user_id, streak_len, last_day
  from current_run
  order by user_id, last_day desc
)
update public.profiles p
set current_streak = case when b.last_day >= current_date - 1 then b.streak_len else 0 end,
    streak_last_active = case when b.last_day >= current_date - 1 then b.last_day else null end
from best b
where b.user_id = p.id;

-- Bumps one user's streak by at most one per calendar day. Called from
-- submit_attempt_answer / record_mock_answer right after an answer is
-- actually recorded — a day only counts once it has real activity, never
-- bumped speculatively just from visiting a page.
create or replace function public.bump_daily_streak(p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_last date;
  v_streak int;
begin
  select streak_last_active, current_streak into v_last, v_streak
  from public.profiles where id = p_user_id
  for update;

  if v_last = current_date then
    return;
  elsif v_last = current_date - 1 then
    update public.profiles
      set current_streak = coalesce(v_streak, 0) + 1, streak_last_active = current_date
      where id = p_user_id;
  else
    update public.profiles
      set current_streak = 1, streak_last_active = current_date
      where id = p_user_id;
  end if;
end;
$$;

-- submit_attempt_answer (Practice/PAES Quizzer path) — now also bumps the
-- ATTEMPT OWNER's streak (not necessarily auth.uid(), since an admin may
-- submit on a student's behalf) once the answer is actually recorded.
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
  v_owner_id uuid;
begin
  if p_confidence is not null and p_confidence not in ('knew_it', 'not_sure', 'guessed') then
    raise exception 'Invalid confidence value: %', p_confidence;
  end if;

  select a.user_id into v_owner_id
  from public.attempts a
  where a.id = p_attempt_id
    and (a.user_id = auth.uid() or public.is_admin())
    and a.status = 'in_progress';

  if v_owner_id is null then
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

  perform public.bump_daily_streak(v_owner_id);

  return query select v_is_correct, v_correct_choice_ids, v_explanation;
end;
$$;

grant execute on function public.submit_attempt_answer(uuid, uuid, uuid[], text) to authenticated;

-- record_mock_answer (Mock Exam path) — same streak bump.
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
  v_owner_id uuid;
begin
  select att.user_id into v_owner_id
  from public.attempts att
  where att.id = p_attempt_id
    and (att.user_id = auth.uid() or public.is_admin())
    and att.status = 'in_progress';

  if v_owner_id is null then
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

  perform public.bump_daily_streak(v_owner_id);
end;
$$;

grant execute on function public.record_mock_answer(uuid, uuid, uuid[]) to authenticated;
