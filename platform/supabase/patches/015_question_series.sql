-- Lets admins mark a group of questions as a connected series (e.g. a
-- multi-part problem where each question depends on shared given data or
-- continues the same scenario) that must never be split apart or reordered
-- when a practice/quiz/mock-exam session shuffles or samples questions.
--
-- series_key is a plain admin-chosen label, not a generated id, so it's
-- easy to set by hand in the admin question editor: any two questions with
-- the SAME non-null series_key belong to the same series, shown in
-- series_position order (1, 2, 3, ...). Both nullable — most questions
-- have neither.
alter table public.questions add column if not exists series_key text;
alter table public.questions add column if not exists series_position int;

create index if not exists questions_series_key_idx on public.questions (series_key) where series_key is not null;

create or replace view public.student_questions as
  select
    q.id, q.topic_id, q.subtopic_id, q.question_text, q.question_type, q.difficulty, q.source,
    q.series_key, q.series_position,
    t.mock_area as topic_mock_area,
    q.additional_mock_areas
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where q.status = 'published';
