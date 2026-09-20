-- Recalled Questions is a read-only reference document, not a practice
-- session: it deliberately shows every choice AND the correct answer up
-- front (per Gabriel: "it will just show the document...you just need to
-- scroll down and all is visible"). That's the opposite of student_questions/
-- student_choices, which deliberately hide choices.is_correct. Direct SELECT
-- on questions/choices is admin-only (questions_admin_only/choices_admin_only
-- policies), so this needs its own SECURITY DEFINER RPC — same pattern as
-- get_teach_me_context's jsonb choices aggregation — rather than a new view,
-- since only the is_recalled=true/status='published' slice should ever
-- reveal answers this way.

create or replace function public.get_recalled_questions()
returns table (
  question_id uuid,
  question_text text,
  explanation text,
  recalled_batch text,
  topic_name text,
  mock_area text,
  choices jsonb
)
language sql
security definer
stable
set search_path = public
as $$
  select
    q.id,
    q.question_text,
    q.explanation,
    q.recalled_batch,
    t.name,
    t.mock_area,
    coalesce(
      jsonb_agg(
        jsonb_build_object('text', c.choice_text, 'is_correct', c.is_correct)
        order by c.sort_order
      ) filter (where c.id is not null),
      '[]'::jsonb
    )
  from public.questions q
  join public.topics t on t.id = q.topic_id
  left join public.choices c on c.question_id = q.id
  where q.is_recalled = true and q.status = 'published'
  group by q.id, q.question_text, q.explanation, q.recalled_batch, t.name, t.mock_area
  order by t.mock_area, q.recalled_batch, t.name;
$$;

grant execute on function public.get_recalled_questions() to authenticated;
