-- Recalled Questions: a new dedicated study section (separate from
-- Practice/Question Bank/Mock Exam) for questions past examinees remember
-- from the actual board exam, as opposed to review-center book content.
-- Admins mark a question as recalled and optionally note which exam
-- sitting it's from; the new section filters to is_recalled = true.

alter table public.questions add column if not exists is_recalled boolean not null default false;
alter table public.questions add column if not exists recalled_batch text;

-- New columns appended at the very end of the SELECT list — inserting them
-- in the middle breaks CREATE OR REPLACE VIEW (see 015's own fix for why).
create or replace view public.student_questions as
  select
    q.id, q.topic_id, q.subtopic_id, q.question_text, q.question_type, q.difficulty, q.source,
    t.mock_area as topic_mock_area,
    q.additional_mock_areas,
    q.series_key, q.series_position,
    q.category,
    q.is_recalled, q.recalled_batch
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where q.status = 'published';
