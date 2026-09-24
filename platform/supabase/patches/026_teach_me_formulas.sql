-- ============================================================================
-- get_teach_me_context: also return this topic's verified reference formulas
-- ============================================================================
-- When a question has no written explanation, "Teach Me This" previously had
-- to derive a solution from general knowledge alone. It now also receives
-- this topic's published reference formulas (the Reviewers section's own
-- verified content) as grounding, so the AI can draw the derivation from a
-- formula already vetted for this app instead of inventing its own — per
-- explicit instruction (2026-09-24): "for problem solving without
-- solutions... apply the formulas stored in review materials... draw the
-- solution from those formulas."
--
-- Uses correlated subqueries (like the existing `choices` field) rather than
-- an extra JOIN in the main FROM clause — joining reviewer_entries directly
-- alongside the existing left join choices would cross-multiply the two
-- (N choices x M formulas rows before aggregation), duplicating both.

-- Postgres can't change a function's return-row shape via CREATE OR REPLACE
-- (adding relevant_formulas below is a new OUT column) — must drop first.
drop function if exists public.get_teach_me_context(uuid, uuid);

create function public.get_teach_me_context(p_attempt_id uuid, p_question_id uuid)
returns table (
  question_text text,
  choices jsonb,
  explanation text,
  topic_name text,
  subtopic_name text,
  exam_area_name text,
  relevant_formulas jsonb
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
      (
        select coalesce(
          jsonb_agg(
            jsonb_build_object('text', c.choice_text, 'is_correct', c.is_correct)
            order by c.sort_order
          ),
          '[]'::jsonb
        )
        from public.choices c
        where c.question_id = q.id
      ),
      q.explanation,
      t.name,
      st.name,
      ea.name,
      (
        select coalesce(
          jsonb_agg(
            jsonb_build_object(
              'title', re.title,
              'formula', re.formula,
              'variables', re.variables,
              'description', re.description
            )
            order by re.title
          ),
          '[]'::jsonb
        )
        from public.reviewer_entries re
        where re.topic_id = q.topic_id and re.kind = 'formula' and re.status = 'published'
      )
    from public.questions q
    join public.topics t on t.id = q.topic_id
    join public.exam_areas ea on ea.id = t.exam_area_id
    left join public.subtopics st on st.id = q.subtopic_id
    where q.id = p_question_id;
end;
$$;

grant execute on function public.get_teach_me_context(uuid, uuid) to authenticated;
