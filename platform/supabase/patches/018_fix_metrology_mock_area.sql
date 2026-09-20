-- Follow-up to 017: reassigning "Engineering Metrology and Equipment" to the
-- "Agricultural and Biosystems Automation, Instrumentation and Control
-- System" official TOS subject (under POWER_ENERGY_MACHINERY) only updated
-- subject_id/exam_area_id — it left the topic's mock_area untouched, so it
-- kept showing under whichever Mock Exam Area it had before. Per the
-- Area 1/2/3 mapping in 25_DECISION_LOG.md ("Area 1: Power/Energy/
-- Machinery, Laws/Professional Standards/Ethics"), a topic under this
-- subject belongs in Area 1.

update public.topics
set mock_area = 'area_1'
where name = 'Engineering Metrology and Equipment';
