-- ============================================================================
-- 16. AI features (Gemini-powered "Teach Me This" / Study Assistant)
-- ============================================================================
-- The AI provider only ever explains verified data already in this schema —
-- it never decides correctness. check_and_log_ai_usage() is the server-side
-- daily rate limit (limit itself lives in the app's AI_DAILY_LIMIT env var,
-- passed in as a parameter, not hardcoded here). get_teach_me_context() is
-- the ONLY way the app fetches a question's real answer key/explanation for
-- an AI prompt, and it only does so for a question the caller has actually
-- already answered in an attempt they own (same ownership pattern as
-- get_attempt_review) — so it can never be used to peek at unanswered
-- questions.

create table if not exists public.ai_usage (
  user_id uuid not null references public.profiles (id) on delete cascade,
  usage_date date not null default current_date,
  request_count int not null default 0,
  primary key (user_id, usage_date)
);

alter table public.ai_usage enable row level security;

drop policy if exists "ai_usage_own_or_admin" on public.ai_usage;
create policy "ai_usage_own_or_admin" on public.ai_usage
  for select to authenticated
  using (user_id = auth.uid() or public.is_admin());

create or replace function public.check_and_log_ai_usage(p_daily_limit int)
returns table (allowed boolean, remaining int)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count int;
begin
  insert into public.ai_usage (user_id, usage_date, request_count)
  values (auth.uid(), current_date, 0)
  on conflict (user_id, usage_date) do nothing;

  select request_count into v_count
  from public.ai_usage
  where user_id = auth.uid() and usage_date = current_date
  for update;

  if v_count >= p_daily_limit then
    return query select false, 0;
  else
    update public.ai_usage
    set request_count = request_count + 1
    where user_id = auth.uid() and usage_date = current_date;
    return query select true, greatest(0, p_daily_limit - v_count - 1);
  end if;
end;
$$;

grant execute on function public.check_and_log_ai_usage(int) to authenticated;

create or replace function public.get_teach_me_context(p_attempt_id uuid, p_question_id uuid)
returns table (
  question_text text,
  choices jsonb,
  explanation text,
  topic_name text,
  subtopic_name text,
  exam_area_name text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_ok boolean;
begin
  select exists (
    select 1
    from public.attempts a
    join public.attempt_answers aa
      on aa.attempt_id = a.id and aa.question_id = p_question_id
    where a.id = p_attempt_id
      and (a.user_id = auth.uid() or public.is_admin())
      and aa.is_correct is not null
  ) into v_ok;

  if not v_ok then
    raise exception 'This question has not been answered in that attempt, or the attempt is not yours.';
  end if;

  return query
    select
      q.question_text,
      coalesce(
        jsonb_agg(
          jsonb_build_object('text', c.choice_text, 'is_correct', c.is_correct)
          order by c.sort_order
        ),
        '[]'::jsonb
      ),
      q.explanation,
      t.name,
      st.name,
      ea.name
    from public.questions q
    join public.topics t on t.id = q.topic_id
    join public.exam_areas ea on ea.id = t.exam_area_id
    left join public.subtopics st on st.id = q.subtopic_id
    left join public.choices c on c.question_id = q.id
    where q.id = p_question_id
    group by q.question_text, q.explanation, t.name, st.name, ea.name;
end;
$$;

grant execute on function public.get_teach_me_context(uuid, uuid) to authenticated;
