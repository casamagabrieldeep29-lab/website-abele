-- Corrects the Area 1/2/3 mapping wholesale per the official 2025 ABE
-- Table of Specifications (Annex "A"), which Gabriel provided directly.
-- The mapping decided 2026-09-19 (007_mock_exam_areas.sql) swept
-- PROJECT_MGMT_RDE and FUNDAMENTALS_SCIENCES into Area 3's catch-all, but
-- the official document's three combined exam papers place them
-- differently:
--   Area 1 (Subject A, 32%): POWER_ENERGY_MACHINERY, LAWS_ETHICS,
--                             PROJECT_MGMT_RDE
--   Area 2 (Subject B, 32%): LAND_WATER, FUNDAMENTALS_SCIENCES,
--                             MATH_BASIC_ENGG
--   Area 3 (Subject C, 36%): STRUCTURES_ENVIRONMENT, BIOPROCESS
-- This replaces 007's CASE mapping outright (not just a one-off backfill
-- of null rows) and re-applies it to every topic, since existing rows
-- were set wrong and need correcting, not just newly-null ones.

update public.topics t
set mock_area = case
  when t.exam_area_id in (
    select id from public.exam_areas where code in ('POWER_ENERGY_MACHINERY', 'LAWS_ETHICS', 'PROJECT_MGMT_RDE')
  ) then 'area_1'
  when t.exam_area_id in (
    select id from public.exam_areas where code in ('LAND_WATER', 'FUNDAMENTALS_SCIENCES', 'MATH_BASIC_ENGG')
  ) then 'area_2'
  else 'area_3'
end;

-- 019 mistakenly created a separate "Agricultural and Biosystems
-- Automation, Instrumentation and Control System" subject under
-- STRUCTURES_ENVIRONMENT and moved "Engineering Metrology and Equipment"
-- onto it. The official document (page 4, Subject A section IV, item 2:
-- "Apply metrology equipment such as weighing scale and other metrology
-- equipment...") places metrology explicitly under the EXISTING Automation
-- subject in POWER_ENERGY_MACHINERY (Area 1). Move the topic back, then
-- remove the now-unused duplicate subject row.

update public.topics t
set subject_id = s.id,
    exam_area_id = s.exam_area_id,
    mock_area = 'area_1'
from public.subjects s
join public.exam_areas ea on ea.id = s.exam_area_id
where t.name = 'Engineering Metrology and Equipment'
  and ea.code = 'POWER_ENERGY_MACHINERY'
  and s.name = 'Agricultural and Biosystems Automation, Instrumentation and Control System';

delete from public.subjects s
using public.exam_areas ea
where s.exam_area_id = ea.id
  and ea.code = 'STRUCTURES_ENVIRONMENT'
  and s.name = 'Agricultural and Biosystems Automation, Instrumentation and Control System'
  and not exists (select 1 from public.topics t where t.subject_id = s.id);
