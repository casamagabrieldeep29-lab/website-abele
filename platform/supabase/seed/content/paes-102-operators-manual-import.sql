-- PAES 102:2000 "Agricultural Machinery — Operator's Manual — Content and
-- Presentation" quiz batch (41 questions, 1 topic). Every question, correct
-- answer, and distractor is drawn directly from the standard's actual
-- clauses (foreword, scope, definitions, clauses 3 and 4) as read in full
-- from the source PDF in this library — no invented facts. This topic had
-- only 9 published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes=true with paes_reference
-- set to 'PAES 102'.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Operator's Manual for AB Power and Machinery (POWER_ENERGY_MACHINERY) — 41 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'POWER_ENERGY_MACHINERY';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: POWER_ENERGY_MACHINERY';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Operator''s Manual for AB Power and Machinery' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Operator''s Manual for AB Power and Machinery';
  END IF;

  -- 1. Scope of the standard
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the scope of PAES 102:2000, "Agricultural Machinery — Operator''s Manual — Content and Presentation"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the scope of PAES 102:2000, "Agricultural Machinery — Operator''s Manual — Content and Presentation"?', 'single_choice', 'easy', 'Clause 1 (Scope) states the standard gives guidance for the content and presentation of operator''s manuals for tractors and machinery for agriculture.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It gives guidance for the content and presentation of operator''s manuals for tractors and machinery for agriculture', true, 0),
      (v_question_id, 'It specifies manufacturing tolerances for agricultural tractor engines', false, 1),
      (v_question_id, 'It sets testing procedures for agricultural machinery performance ratings', false, 2),
      (v_question_id, 'It sets safety signage requirements for agricultural structures', false, 3);
  END IF;

  -- 2. Left-hand side definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the definitions in clause 2.1 of PAES 102:2000, for a mobile machine, the "left-hand side" is the side on the left when an observer is doing what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the definitions in clause 2.1 of PAES 102:2000, for a mobile machine, the "left-hand side" is the side on the left when an observer is doing what?', 'single_choice', 'medium', 'Clause 2.1 defines left-hand side for mobile machines as the side on the left when an observer is facing in the normal forward direction of travel of the machine. The "facing the machine" phrasing instead applies to stationary machines.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Facing the machine', false, 0),
      (v_question_id, 'Facing in the normal forward direction of travel of the machine', true, 1),
      (v_question_id, 'Facing away from the machine, looking over the shoulder', false, 2),
      (v_question_id, 'Facing the control panel from the operator''s seat', false, 3);
  END IF;

  -- 3. Right-hand side definition (stationary machines)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 2.2 of PAES 102:2000, for stationary machines, the "right-hand side" is the side on the right when an observer is doing what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 2.2 of PAES 102:2000, for stationary machines, the "right-hand side" is the side on the right when an observer is doing what?', 'single_choice', 'easy', 'Clause 2.2 defines right-hand side for stationary machines as the side on the right when an observer is facing the machine.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Facing in the normal forward direction of travel', false, 0),
      (v_question_id, 'Facing away from the machine', false, 1),
      (v_question_id, 'Facing the machine', true, 2),
      (v_question_id, 'Facing the nearest exit aisle', false, 3);
  END IF;

  -- 4. Superseded standard
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 102:2000 is stated in its foreword to be a revision of which earlier standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 102:2000 is stated in its foreword to be a revision of which earlier standard?', 'single_choice', 'medium', 'The foreword states PAES 102:2000 is a revision of Standard Administrative Order (SAO) 399:1980 – "Operator Manuals and Technical Publications for Agricultural Tractors and Machines".', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PNS 01:Part 4:1998', false, 0),
      (v_question_id, 'SAO 399:1980 – "Operator Manuals and Technical Publications for Agricultural Tractors and Machines"', true, 1),
      (v_question_id, 'ISO 3600:1996', false, 2),
      (v_question_id, 'PAES 101:2000', false, 3);
  END IF;

  -- 5. ISO reference used
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In preparing PAES 102:2000, reference was made to which International Organization for Standardization (ISO) document?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In preparing PAES 102:2000, reference was made to which International Organization for Standardization (ISO) document?', 'single_choice', 'medium', 'The foreword states reference was made to ISO 3600:1996 – Tractors, machinery for agriculture and forestry, powered lawn and garden equipment – Operator''s manuals – Content and presentation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ISO 9001:2015 – Quality management systems', false, 0),
      (v_question_id, 'ISO 12100 – Safety of machinery', false, 1),
      (v_question_id, 'ISO 3600:1996 – Tractors, machinery for agriculture and forestry, powered lawn and garden equipment – Operator''s manuals – Content and presentation', true, 2),
      (v_question_id, 'ISO 3767 – Tractors and machinery for agriculture – Symbols for operator controls', false, 3);
  END IF;

  -- 6. AMTEC initiated the revision
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which center initiated the revision that became PAES 102:2000?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which center initiated the revision that became PAES 102:2000?', 'single_choice', 'medium', 'The foreword states the revision was initiated by the Agricultural Machinery Testing and Evaluation Center (AMTEC).', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bureau of Agricultural Research (BAR)', false, 0),
      (v_question_id, 'Agricultural Machinery Testing and Evaluation Center (AMTEC)', true, 1),
      (v_question_id, 'Philippine Society of Agricultural Engineers (PSAE)', false, 2),
      (v_question_id, 'National Agriculture and Fisheries Council (NAFC)', false, 3);
  END IF;

  -- 7. Funding agency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the foreword of PAES 102:2000, which agency funded the project "Enhancing the Implementation of AFMA Through Improved Agricultural Engineering Standards"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the foreword of PAES 102:2000, which agency funded the project "Enhancing the Implementation of AFMA Through Improved Agricultural Engineering Standards"?', 'single_choice', 'easy', 'The foreword states the project was funded by the Bureau of Agricultural Research (BAR) of the Department of Agriculture (DA).', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agricultural Machinery Testing and Evaluation Center (AMTEC)', false, 0),
      (v_question_id, 'Philippine Society of Agricultural Engineers (PSAE)', false, 1),
      (v_question_id, 'National Agriculture and Fisheries Council (NAFC)', false, 2),
      (v_question_id, 'Bureau of Agricultural Research (BAR) of the Department of Agriculture (DA)', true, 3);
  END IF;

  -- 8. Technical committee that reviewed the standard
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 102:2000 was reviewed by which technical committee before being circulated for comment?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 102:2000 was reviewed by which technical committee before being circulated for comment?', 'single_choice', 'hard', 'The foreword states the revised standard was reviewed by the Technical Committee for Study 1 – Development of Standards for Agricultural Production Machinery.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Technical Committee for Study 1 – Development of Standards for Agricultural Production Machinery', true, 0),
      (v_question_id, 'Technical Committee for Study 2 – Development of Standards for Post-Harvest Machinery', false, 1),
      (v_question_id, 'Technical Committee for Study 1 – Development of Standards for Irrigation Equipment', false, 2),
      (v_question_id, 'Technical Committee on Agricultural Structures', false, 3);
  END IF;

  -- 9. Clause 3.1.2 part number and date of issue
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.1.2 of PAES 102:2000, what must each operator''s manual have of its own?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.1.2 of PAES 102:2000, what must each operator''s manual have of its own?', 'single_choice', 'medium', 'Clause 3.1.2 requires each operator''s manual to have its own part number and date of issue.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An ISBN and a copyright notice', false, 0),
      (v_question_id, 'A serial number and a warranty card', false, 1),
      (v_question_id, 'A part number and date of issue', true, 2),
      (v_question_id, 'A model number and a safety rating', false, 3);
  END IF;

  -- 10. Clause 3.1.3 items NOT required
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.1.3 of PAES 102:2000, which of the following is NOT one of the items each publication should identify?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.1.3 of PAES 102:2000, which of the following is NOT one of the items each publication should identify?', 'single_choice', 'medium', 'Clause 3.1.3 lists manufacturer/distributor name and address, importer, model designation, publication name/type, part or publication number, printing/publication date, and language. The retail price of the manual is not among these items.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The name and address of the manufacturer and/or distributor', false, 0),
      (v_question_id, 'The model designation of the machine', false, 1),
      (v_question_id, 'The retail price of the manual', true, 2),
      (v_question_id, 'The language in which the manual is written', false, 3);
  END IF;

  -- 11. Clause 3.2.2 front portion content
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.2.2 of PAES 102:2000, which categories of information should an operator''s manual give in its front portion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.2.2 of PAES 102:2000, which categories of information should an operator''s manual give in its front portion?', 'single_choice', 'easy', 'Clause 3.2.2 states the operator''s manual should give safety precautions, controls, and operating instructions in the front portion.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Parts list, warranty, and alphabetical index', false, 0),
      (v_question_id, 'Safety precautions, controls, and operating instructions', true, 1),
      (v_question_id, 'Specifications, accessories, and storage instructions', false, 2),
      (v_question_id, 'Maintenance schedule, dismantling, and disposal instructions', false, 3);
  END IF;

  -- 12. Clause 3.2.3 separate publication
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.2.3 of PAES 102:2000, where may procedures that are performed only once, such as initial set-up or installation, be detailed when the work involved is complex?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.2.3 of PAES 102:2000, where may procedures that are performed only once, such as initial set-up or installation, be detailed when the work involved is complex?', 'single_choice', 'easy', 'Clause 3.2.3 allows such once-only, complex procedures to be detailed in a separate publication.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'In the alphabetical index', false, 0),
      (v_question_id, 'In the rear cover pocket only', false, 1),
      (v_question_id, 'In a separate publication', true, 2),
      (v_question_id, 'In a footnote to the parts list', false, 3);
  END IF;

  -- 13. Clause 3.3.2 serial number section completion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.3.2 of PAES 102:2000, when should the manual''s section for recording serial numbers of major components be completed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.3.2 of PAES 102:2000, when should the manual''s section for recording serial numbers of major components be completed?', 'single_choice', 'medium', 'Clause 3.3.2 states the serial-number section shall be completed at the time of delivery or installation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At the time of manufacture', false, 0),
      (v_question_id, 'At the time of delivery or installation', true, 1),
      (v_question_id, 'At the time of the first maintenance service', false, 2),
      (v_question_id, 'At the time the warranty expires', false, 3);
  END IF;

  -- 14. Clause 3.4.3 assistance statement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.4.3 of PAES 102:2000, each publication should contain a statement advising the reader of what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.4.3 of PAES 102:2000, each publication should contain a statement advising the reader of what?', 'single_choice', 'easy', 'Clause 3.4.3 requires a statement advising the reader where to get assistance if items covered in the publication are not understood.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Where to purchase replacement parts', false, 0),
      (v_question_id, 'Where to register the product warranty', false, 1),
      (v_question_id, 'Where to find the alphabetical index', false, 2),
      (v_question_id, 'Where to get assistance if items covered in the publication are not understood', true, 3);
  END IF;

  -- 15. Clause 3.4.4 safety alert symbol
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.4.4 of PAES 102:2000, attention shall be drawn to the use of what, to highlight information about potential dangers to the user?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.4.4 of PAES 102:2000, attention shall be drawn to the use of what, to highlight information about potential dangers to the user?', 'single_choice', 'easy', 'Clause 3.4.4 states attention shall be drawn to the use of the safety alert symbol to highlight information about potential dangers to the user.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The safety alert symbol', true, 0),
      (v_question_id, 'The WARNING heading in bold upper case', false, 1),
      (v_question_id, 'The list of reproduced safety signs', false, 2),
      (v_question_id, 'The machine''s serial number plate', false, 3);
  END IF;

  -- 16. Clause 3.6 content list page
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.6 of PAES 102:2000, the content list of an operator''s manual shall begin on what kind of page?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.6 of PAES 102:2000, the content list of an operator''s manual shall begin on what kind of page?', 'single_choice', 'medium', 'Clause 3.6 states the content list shall be presented clearly and simply and shall begin on a right-hand page.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A left-hand page', false, 0),
      (v_question_id, 'The inside front cover', false, 1),
      (v_question_id, 'A right-hand page', true, 2),
      (v_question_id, 'A colored divider leaf', false, 3);
  END IF;

  -- 17. Clause 3.7.2.4 replacement components
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.7.2.4 of PAES 102:2000, when new equipment components are installed during repair, what must be included?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.7.2.4 of PAES 102:2000, when new equipment components are installed during repair, what must be included?', 'single_choice', 'hard', 'Clause 3.7.2.4 requires that new components installed during repair include the current safety signs specified by the manufacturer, affixed to the replacement component.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A new serial-number sticker', false, 0),
      (v_question_id, 'An updated parts list page', false, 1),
      (v_question_id, 'A revised warranty card', false, 2),
      (v_question_id, 'The current safety signs specified by the manufacturer, affixed to the replacement component', true, 3);
  END IF;

  -- 18. Clause 3.8 performance curve
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.8 of PAES 102:2000 on operating information, what shall be provided if applicable to the machine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.8 of PAES 102:2000 on operating information, what shall be provided if applicable to the machine?', 'single_choice', 'medium', 'Clause 3.8 states that operating information should include specifications, description, identification of controls, operating instructions, troubleshooting information, and that a performance curve (if applicable) shall be provided.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A maintenance schedule table', false, 0),
      (v_question_id, 'A performance curve', true, 1),
      (v_question_id, 'A parts catalogue', false, 2),
      (v_question_id, 'A storage checklist', false, 3);
  END IF;

  -- 19. Clause 3.10.1 operator-capability tasks
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.10.1 of PAES 102:2000, the manual should be confined to maintenance tasks within the operator''s capability. Which of the following is explicitly listed as such a task?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.10.1 of PAES 102:2000, the manual should be confined to maintenance tasks within the operator''s capability. Which of the following is explicitly listed as such a task?', 'single_choice', 'medium', 'Clause 3.10.1 lists cleaning, clearing blockages, replenishment, lubrication, external visual examination, simple tests, and correction of minor deterioration as tasks within operator capability. Engine overhaul, hydraulic pump replacement, and transmission rebuilding belong in a workshop or technical manual.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Engine overhaul', false, 0),
      (v_question_id, 'Lubrication', true, 1),
      (v_question_id, 'Hydraulic pump replacement', false, 2),
      (v_question_id, 'Transmission rebuilding', false, 3);
  END IF;

  -- 20. Clause 3.10.2 tabular form
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.10.2 of PAES 102:2000, maintenance tasks required at specific intervals should be summarized in what form?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.10.2 of PAES 102:2000, maintenance tasks required at specific intervals should be summarized in what form?', 'single_choice', 'easy', 'Clause 3.10.2 states maintenance schedules at specific intervals should be summarized in tabular form, with further details in the text.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Narrative paragraph form', false, 0),
      (v_question_id, 'Tabular form', true, 1),
      (v_question_id, 'Flowchart form', false, 2),
      (v_question_id, 'Glossary form', false, 3);
  END IF;

  -- 21. Clause 3.10.4 ballasted rear wheel example
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Clause 3.10.4 of PAES 102:2000 illustrates a potential stability hazard using the removal of what from a tractor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Clause 3.10.4 of PAES 102:2000 illustrates a potential stability hazard using the removal of what from a tractor?', 'single_choice', 'medium', 'Clause 3.10.4 gives the example that if a ballasted rear wheel is to be removed from a tractor, there is a potential stability hazard during both removal and temporary storage.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The front axle', false, 0),
      (v_question_id, 'The drawbar', false, 1),
      (v_question_id, 'A ballasted rear wheel', true, 2),
      (v_question_id, 'The PTO shield', false, 3);
  END IF;

  -- 22. Clause 3.11 storage requirements list
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.11 of PAES 102:2000, besides precautions and special tools, what should a list of storage requirements include?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.11 of PAES 102:2000, besides precautions and special tools, what should a list of storage requirements include?', 'single_choice', 'medium', 'Clause 3.11 states the list of storage requirements should include information about supplies and services needed, periodic inspections, tests, and limitations on storage life.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A list of authorized dealers', false, 0),
      (v_question_id, 'Supplies and services needed, periodic inspections, tests, and limitations on storage life', true, 1),
      (v_question_id, 'A list of spare-parts prices', false, 2),
      (v_question_id, 'A list of recommended operators', false, 3);
  END IF;

  -- 23. Clause 3.12.2 reception
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.12.2 (Reception) of PAES 102:2000, which items should be specified along with unpacking instructions?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.12.2 (Reception) of PAES 102:2000, which items should be specified along with unpacking instructions?', 'single_choice', 'medium', 'Clause 3.12.2 states that lifting points, slings, and spreaders should be specified, unless unpacking will be carried out by the dealer.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fuel type and oil grade', false, 0),
      (v_question_id, 'Tire pressure and torque values', false, 1),
      (v_question_id, 'Lifting points, slings, and spreaders', true, 2),
      (v_question_id, 'Paint color and finish', false, 3);
  END IF;

  -- 24. Clause 3.12.4 installation services
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.12.4 (Installation) of PAES 102:2000, which externally provided services should be specified, with methods of connection detailed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.12.4 (Installation) of PAES 102:2000, which externally provided services should be specified, with methods of connection detailed?', 'single_choice', 'medium', 'Clause 3.12.4 states that externally provided services such as air, electricity, gas, water, and fuel should be specified and methods of connection detailed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Internet connectivity and telemetry', false, 0),
      (v_question_id, 'Insurance and financing', false, 1),
      (v_question_id, 'Air, electricity, gas, water, and fuel', true, 2),
      (v_question_id, 'Transport and customs clearance', false, 3);
  END IF;

  -- 25. Clause 3.13 interdependent system interface
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.13 (Specifications) of PAES 102:2000, if two or more machines are linked to form a system in which their functioning is interdependent, what should be provided?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.13 (Specifications) of PAES 102:2000, if two or more machines are linked to form a system in which their functioning is interdependent, what should be provided?', 'single_choice', 'hard', 'Clause 3.13 states that if two or more machines are linked to form a system in which their functioning is interdependent, the technical specifications of the interface should be provided.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A combined warranty certificate', false, 0),
      (v_question_id, 'A joint parts catalogue', false, 1),
      (v_question_id, 'The technical specifications of the interface', true, 2),
      (v_question_id, 'A single shared maintenance schedule only', false, 3);
  END IF;

  -- 26. Clause 3.16 alphabetical index threshold
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.16 of PAES 102:2000, a document of more than how many pages should have an alphabetical index?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.16 of PAES 102:2000, a document of more than how many pages should have an alphabetical index?', 'single_choice', 'medium', 'Clause 3.16 states a document of more than 32 pages should have an alphabetical index, placed at the end of the manual.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16 pages', false, 0),
      (v_question_id, '24 pages', false, 1),
      (v_question_id, '32 pages', true, 2),
      (v_question_id, '48 pages', false, 3);
  END IF;

  -- 27. Clause 3.17.1 parts list info
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 3.17.1 of PAES 102:2000, a parts list should contain sufficient information of what kind for each item, so the correct replacement part can be obtained?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 3.17.1 of PAES 102:2000, a parts list should contain sufficient information of what kind for each item, so the correct replacement part can be obtained?', 'single_choice', 'easy', 'Clause 3.17.1 states a parts list should contain sufficient information, such as part number and description, for each item so the correct replacement part can be obtained.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Weight and country of origin', false, 0),
      (v_question_id, 'Price and warranty period', false, 1),
      (v_question_id, 'Part number and description', true, 2),
      (v_question_id, 'Supplier contact and lead time', false, 3);
  END IF;

  -- 28. Clause 4.1.1 paper size for complex machines
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.1.1 of PAES 102:2000, which paper format is recommended for complex machines, to allow coverage with an acceptable number of pages?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.1.1 of PAES 102:2000, which paper format is recommended for complex machines, to allow coverage with an acceptable number of pages?', 'single_choice', 'easy', 'Clause 4.1.1 states A4 format is recommended for complex machines to allow coverage with an acceptable number of pages, and is also suitable for static equipment where there is no storage problem.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A5 format', false, 0),
      (v_question_id, '1/3 A4 format', false, 1),
      (v_question_id, 'A4 format', true, 2),
      (v_question_id, 'A3 format', false, 3);
  END IF;

  -- 29. Clause 4.1.1 NOTE A5 dimensions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the NOTE under clause 4.1.1 of PAES 102:2000, what dimensions are given for A5 format?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the NOTE under clause 4.1.1 of PAES 102:2000, what dimensions are given for A5 format?', 'single_choice', 'medium', 'The NOTE under clause 4.1.1 gives A5 as 210 mm x 148 mm (and A4 as 297 mm x 210 mm).', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '297 mm x 210 mm', false, 0),
      (v_question_id, '210 mm x 148 mm', true, 1),
      (v_question_id, '148 mm x 105 mm', false, 2),
      (v_question_id, '216 mm x 140 mm', false, 3);
  END IF;

  -- 30. Clause 4.1.2 protection for shipment
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.1.2 of PAES 102:2000, for initial shipment, the operator''s manual should be sealed inside what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.1.2 of PAES 102:2000, for initial shipment, the operator''s manual should be sealed inside what?', 'single_choice', 'medium', 'Clause 4.1.2 states that for initial shipment, the manual should be sealed inside a transparent, water-and-oil-resistant plastic envelope.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A sealed cardboard box', false, 0),
      (v_question_id, 'A laminated folder', false, 1),
      (v_question_id, 'A waterproof canvas pouch', false, 2),
      (v_question_id, 'A transparent, water-and-oil-resistant plastic envelope', true, 3);
  END IF;

  -- 31. Clause 4.3.5 minimum type size
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.3.5 of PAES 102:2000, ideally the main text type size should not be less than how many points?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.3.5 of PAES 102:2000, ideally the main text type size should not be less than how many points?', 'single_choice', 'easy', 'Clause 4.3.5 states that ideally, the type size should be such that the main text will not be less than 10 points.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 points', false, 0),
      (v_question_id, '10 points', true, 1),
      (v_question_id, '12 points', false, 2),
      (v_question_id, '6 points', false, 3);
  END IF;

  -- 32. Clause 4.3.6 inner margins
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.3.6 of PAES 102:2000, how wide should inner margins be to allow clear readability when the bound manual is open?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.3.6 of PAES 102:2000, how wide should inner margins be to allow clear readability when the bound manual is open?', 'single_choice', 'medium', 'Clause 4.3.6 states inner margins (left-hand on odd-numbered pages, right-hand on even-numbered pages) should be 10 mm to 15 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 mm to 10 mm', false, 0),
      (v_question_id, '10 mm to 15 mm', true, 1),
      (v_question_id, '15 mm to 20 mm', false, 2),
      (v_question_id, '5 mm to 8 mm', false, 3);
  END IF;

  -- 33. Clause 4.3.6 outer margins
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.3.6 of PAES 102:2000, what range is given for outer margins, to ensure page content is not cut during printing and binding?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.3.6 of PAES 102:2000, what range is given for outer margins, to ensure page content is not cut during printing and binding?', 'single_choice', 'medium', 'Clause 4.3.6 states outer margins (right-hand on odd-numbered pages, left-hand on even-numbered pages) should be sufficient, at 6 mm to 10 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 mm to 15 mm', false, 0),
      (v_question_id, '3 mm to 5 mm', false, 1),
      (v_question_id, '12 mm to 18 mm', false, 2),
      (v_question_id, '6 mm to 10 mm', true, 3);
  END IF;

  -- 34. Clause 4.3.8 heading levels
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.3.8 of PAES 102:2000, how many levels of headings are normally sufficient to avoid confusing the reader?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.3.8 of PAES 102:2000, how many levels of headings are normally sufficient to avoid confusing the reader?', 'single_choice', 'easy', 'Clause 4.3.8 states that to avoid confusing the reader, the number of heading levels should be kept to a minimum; normally three levels are sufficient.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two', false, 0),
      (v_question_id, 'Three', true, 1),
      (v_question_id, 'Four', false, 2),
      (v_question_id, 'Five', false, 3);
  END IF;

  -- 35. Clause 4.4.7 digit grouping threshold
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.4.7 of PAES 102:2000, numbers consisting of more than how many digits (except dates) should be shown in groups of three?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.4.7 of PAES 102:2000, numbers consisting of more than how many digits (except dates) should be shown in groups of three?', 'single_choice', 'medium', 'Clause 4.4.7 states numbers of more than four digits (except dates) should be shown in groups of three, counting from the decimal marker to the left.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Three digits', false, 0),
      (v_question_id, 'Four digits', true, 1),
      (v_question_id, 'Five digits', false, 2),
      (v_question_id, 'Six digits', false, 3);
  END IF;

  -- 36. Clause 4.4.7 worked example
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As a worked example under clause 4.4.7 of PAES 102:2000, which number is shown grouped in threes, counting from the decimal marker to the left?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As a worked example under clause 4.4.7 of PAES 102:2000, which number is shown grouped in threes, counting from the decimal marker to the left?', 'single_choice', 'hard', 'Clause 4.4.7 gives "21 000" as the worked example of a number shown in groups of three, which avoids confusion in areas where a comma is used as a decimal marker.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 000', false, 0),
      (v_question_id, '2 100', false, 1),
      (v_question_id, '21 000', true, 2),
      (v_question_id, '100 000', false, 3);
  END IF;

  -- 37. Clause 4.6.1 WARNING/CAUTION vs IMPORTANT
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.6.1 of PAES 102:2000, WARNING and CAUTION are used for safety-related information where personal injury may be involved, while IMPORTANT is used for instructions involving what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.6.1 of PAES 102:2000, WARNING and CAUTION are used for safety-related information where personal injury may be involved, while IMPORTANT is used for instructions involving what?', 'single_choice', 'medium', 'Clause 4.6.1 states WARNING and CAUTION are used where personal injury may be involved, while IMPORTANT is used for instructions when machine damage is involved; NOTE is used for supplementary information.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Scheduling delays', false, 0),
      (v_question_id, 'Machine damage', true, 1),
      (v_question_id, 'Cosmetic defects', false, 2),
      (v_question_id, 'Warranty voidance only', false, 3);
  END IF;

  -- 38. Clause 4.6.2 safety alert symbol margin
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.6.2 of PAES 102:2000, WARNING and CAUTION instructions should be signaled by the safety alert symbol in which margin?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.6.2 of PAES 102:2000, WARNING and CAUTION instructions should be signaled by the safety alert symbol in which margin?', 'single_choice', 'easy', 'Clause 4.6.2 states WARNING and CAUTION instructions should be placed immediately before the related text and signaled in the left-hand margin by the safety alert symbol.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The right-hand margin', false, 0),
      (v_question_id, 'The left-hand margin', true, 1),
      (v_question_id, 'The top margin', false, 2),
      (v_question_id, 'The bottom margin', false, 3);
  END IF;

  -- 39. Clause 4.7.2 page-numbering example
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the example under clause 4.7.2 of PAES 102:2000, what does the page number "Page 7-12" represent in a long manual numbered by main division?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the example under clause 4.7.2 of PAES 102:2000, what does the page number "Page 7-12" represent in a long manual numbered by main division?', 'single_choice', 'hard', 'Clause 4.7.2 gives the example that "Page 7-12" is the twelfth page of section 7, identifying pages by the number of the main division followed by a hyphen and then the page number.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The seventh page of section 12', false, 0),
      (v_question_id, 'Page 7 of a 12-page manual', false, 1),
      (v_question_id, 'The seventh edition, twelfth printing', false, 2),
      (v_question_id, 'The twelfth page of section 7', true, 3);
  END IF;

  -- 40. Clause 4.7.3 figure-numbering example
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the example under clause 4.7.3 of PAES 102:2000, if each section is page-numbered separately, how would the third figure in section 2 be labeled?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the example under clause 4.7.3 of PAES 102:2000, if each section is page-numbered separately, how would the third figure in section 2 be labeled?', 'single_choice', 'hard', 'Clause 4.7.3 gives the example that if each section is page-numbered separately, the third figure in section 2 should be "Figure 2-3" (with the first figure in section 1 being "Figure 1-1").', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Figure 3-2', false, 0),
      (v_question_id, 'Figure 2.3', false, 1),
      (v_question_id, 'Figure 2-3', true, 2),
      (v_question_id, 'Table 2-3', false, 3);
  END IF;

  -- 41. Clause 4.8.1 reference numbering sequences
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per clause 4.8.1 of PAES 102:2000, different sequences of numbering should be used for footnotes and for references cited in the text. What example does the clause give?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per clause 4.8.1 of PAES 102:2000, different sequences of numbering should be used for footnotes and for references cited in the text. What example does the clause give?', 'single_choice', 'medium', 'Clause 4.8.1 gives the example of using letters or symbols for one sequence (such as footnotes) and numerals for the other (such as text references), printed as superscripts or in parentheses/square brackets.', NULL, NULL, 'draft', false, NULL, true, 'PAES 102')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Roman numerals for both sequences', false, 0),
      (v_question_id, 'Superscripts for both, with no distinction between them', false, 1),
      (v_question_id, 'Letters or symbols for one and numerals for the other', true, 2),
      (v_question_id, 'A single combined numbering sequence for both', false, 3);
  END IF;

END $$;
