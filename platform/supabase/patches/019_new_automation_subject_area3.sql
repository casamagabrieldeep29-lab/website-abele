-- 017/018 mistakenly reassigned "Engineering Metrology and Equipment" to
-- the EXISTING "Agricultural and Biosystems Automation, Instrumentation
-- and Control System" subject, which belongs to POWER_ENERGY_MACHINERY
-- (Mock Exam Area 1). Gabriel wants this topic under Area 3 instead, in a
-- subject with that same name but classified under STRUCTURES_ENVIRONMENT
-- (his call) — not the Area 1 one. Since no such subject exists yet under
-- STRUCTURES_ENVIRONMENT, this creates it (sort_order 4, after the existing
-- three) rather than reusing the Area 1 row.
--
-- Note: this adds an 18th subjects row beyond the 17 documented in
-- 00_MASTER_PROJECT_INSTRUCTIONS.md's original TOS breakdown (013's own
-- comment flags that list as not to be added to without updating that doc
-- first) — update the master doc to match if this is meant to stick.

insert into public.subjects (exam_area_id, name, sort_order)
select ea.id, 'Agricultural and Biosystems Automation, Instrumentation and Control System', 4
from public.exam_areas ea
where ea.code = 'STRUCTURES_ENVIRONMENT'
  and not exists (
    select 1 from public.subjects s
    where s.exam_area_id = ea.id
      and s.name = 'Agricultural and Biosystems Automation, Instrumentation and Control System'
  );

update public.topics t
set subject_id = s.id,
    exam_area_id = s.exam_area_id,
    mock_area = 'area_3'
from public.subjects s
join public.exam_areas ea on ea.id = s.exam_area_id
where t.name = 'Engineering Metrology and Equipment'
  and ea.code = 'STRUCTURES_ENVIRONMENT'
  and s.name = 'Agricultural and Biosystems Automation, Instrumentation and Control System';
