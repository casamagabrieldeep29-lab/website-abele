-- Lets admins mark whether a question is a "term" (definition/concept —
-- the kind of question that's just knowledge recall) or a "solving"
-- (computation/problem-solving) question, so the Custom Quiz Builder can
-- filter by it. Neither existing field captures this: question_type is the
-- ANSWER FORMAT (single_choice/multi_choice/numerical), not content
-- category — a single_choice question can just as easily be a computation
-- problem as a definition question, which is exactly what most of the
-- existing question bank already is. Nullable: untagged questions simply
-- don't show up when "Terms only" or "Solving only" is selected (same
-- honest-rather-than-guessed behavior as series_key) until an admin tags
-- them via the question editor.
alter table public.questions add column if not exists category text check (category in ('term', 'solving'));

-- Appended at the very end, after every column the view already has (see
-- 015_question_series.sql's own fix note) — CREATE OR REPLACE VIEW only
-- allows new columns at the end of the list.
create or replace view public.student_questions as
  select
    q.id, q.topic_id, q.subtopic_id, q.question_text, q.question_type, q.difficulty, q.source,
    t.mock_area as topic_mock_area,
    q.additional_mock_areas,
    q.series_key, q.series_position,
    q.category
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where q.status = 'published';
