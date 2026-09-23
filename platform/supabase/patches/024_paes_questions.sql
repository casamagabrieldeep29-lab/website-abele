-- PAES (Philippine Agricultural Engineering Standards) quiz support: lets
-- admins tag a question as testing a specific PAES standard, and the new
-- /paes section pool a quiz from just those questions, mirroring is_recalled/
-- recalled_batch (022_recalled_questions.sql) exactly.

alter table public.questions add column if not exists is_paes boolean not null default false;
alter table public.questions add column if not exists paes_reference text;

-- New columns appended at the very end of the SELECT list — inserting them
-- in the middle breaks CREATE OR REPLACE VIEW (see 015's own fix for why).
create or replace view public.student_questions as
  select
    q.id, q.topic_id, q.subtopic_id, q.question_text, q.question_type, q.difficulty, q.source,
    t.mock_area as topic_mock_area,
    q.additional_mock_areas,
    q.series_key, q.series_position,
    q.category,
    q.is_recalled, q.recalled_batch,
    q.is_paes, q.paes_reference
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where q.status = 'published';
