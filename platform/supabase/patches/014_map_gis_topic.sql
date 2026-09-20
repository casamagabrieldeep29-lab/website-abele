-- Follow-up to 013_official_subjects.sql: "Geographic Information System"
-- (under LAND_WATER) was deliberately left unmapped there since none of
-- TOS 2's 4 official subjects was an obvious fit. Per explicit instruction,
-- mapped to Soil and Water Conservation Engineering — GIS is standard
-- tooling for land-resource inventory and watershed/conservation planning
-- in ABE curricula, the closest fit among the four.
update public.topics t
set subject_id = s.id
from public.exam_areas ea
join public.subjects s
  on s.exam_area_id = ea.id
  and s.name = 'Soil and Water Conservation Engineering'
where ea.code = 'LAND_WATER'
  and t.exam_area_id = ea.id
  and t.name = 'Geographic Information System'
  and t.subject_id is distinct from s.id;
