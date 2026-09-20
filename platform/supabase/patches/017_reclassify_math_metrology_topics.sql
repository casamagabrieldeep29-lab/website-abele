-- Two one-off content corrections requested by Gabriel after reviewing the
-- Practice > Area tabs:
--
-- 1. "Mathematics and Basic Engineering" was placed in Mock Exam Area 3 per
--    the Area 1/2/3 mapping agreed in 25_DECISION_LOG.md (2026-09-19). On
--    review, Gabriel wants this specific topic moved to Area 2 instead —
--    this is a topic-level exception, not a change to the general mapping
--    rule in 007_mock_exam_areas.sql, so it's applied directly here rather
--    than editing that CASE statement.
--
-- 2. "Engineering Metrology and Equipment" was left under the "Mathematics
--    and Basic Engineering Principles" official TOS subject by the 013
--    backfill (best guess at the time — 013's own comments flag exactly
--    this kind of thing as expected to need admin correction). Gabriel
--    wants it reassigned to "Agricultural and Biosystems Automation,
--    Instrumentation and Control System" instead. Since a topic's
--    exam_area_id and its official subject's exam_area_id should stay
--    consistent (both feed the same Area -> Subject -> Topic groupings in
--    Question Bank / Progress / Reviewers), this also moves the topic's
--    exam_area_id to match its new subject.
--
-- Verify affected row counts before running if you have more than one
-- topic with either of these exact names.

update public.topics
set mock_area = 'area_2'
where name = 'Mathematics and Basic Engineering';

update public.topics t
set subject_id = s.id,
    exam_area_id = s.exam_area_id
from public.subjects s
where t.name = 'Engineering Metrology and Equipment'
  and s.name = 'Agricultural and Biosystems Automation, Instrumentation and Control System';
