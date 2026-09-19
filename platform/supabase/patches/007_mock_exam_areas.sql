-- ============================================================================
-- 17. Real PRC ABE board exam structure: Area 1 / Area 2 / Area 3
-- ============================================================================
-- The actual licensure exam is administered as THREE separate subject exams
-- (not the 8 official PRC Table-of-Specifications weighting categories
-- already in `exam_areas` — those stay as-is for TOS weighting/mastery
-- purposes). Mapping decided with Gabriel 2026-09-19:
--   Area 1: Power/Energy/Machinery, Laws/Ethics
--   Area 2: Land/Water Resources
--   Area 3: Structures/Environment, Bioprocess, Project Mgmt/RDE,
--           Fundamentals of Sciences, Math/Basic Engineering
-- Each topic gets exactly one default `mock_area`. A question can ALSO be
-- individually tagged into another area via `additional_mock_areas` when an
-- admin judges it topically relevant there (e.g. an Engineering Economy
-- question about machinery costs, tagged into Area 1 in addition to its
-- home Area 3) — deliberately a manual admin judgment call, not an
-- automatic keyword rule, to protect content accuracy.

alter table public.topics add column if not exists mock_area text;

update public.topics t
set mock_area = case
  when t.exam_area_id in (
    select id from public.exam_areas where code in ('POWER_ENERGY_MACHINERY', 'LAWS_ETHICS')
  ) then 'area_1'
  when t.exam_area_id in (
    select id from public.exam_areas where code = 'LAND_WATER'
  ) then 'area_2'
  else 'area_3'
end
where t.mock_area is null;

alter table public.topics alter column mock_area set not null;

alter table public.topics drop constraint if exists topics_mock_area_check;
alter table public.topics add constraint topics_mock_area_check
  check (mock_area in ('area_1', 'area_2', 'area_3'));

alter table public.questions add column if not exists additional_mock_areas text[] not null default '{}';

alter table public.questions drop constraint if exists questions_additional_mock_areas_check;
alter table public.questions add constraint questions_additional_mock_areas_check
  check (additional_mock_areas <@ array['area_1', 'area_2', 'area_3']);

-- student_questions now also exposes mock-area classification (safe
-- metadata, not an answer key) so the Mock Exam picker can select an
-- area's question pool without touching admin-only tables directly.
create or replace view public.student_questions as
  select
    q.id, q.topic_id, q.subtopic_id, q.question_text, q.question_type, q.difficulty, q.source,
    t.mock_area as topic_mock_area,
    q.additional_mock_areas
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where q.status = 'published';

grant select on public.student_questions to authenticated;
