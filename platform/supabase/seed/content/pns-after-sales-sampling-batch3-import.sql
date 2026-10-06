-- Philippine National Standards on After-Sales Service and Methods of
-- Sampling quiz batch 3 (33 questions, 1 topic). Every question, correct
-- answer, and distractor is drawn directly from the clauses and tables of the
-- standards read in full -- no invented facts. New angles only; the questions
-- already published or staged for this topic were reviewed and not repeated.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes/paes_reference set per
-- question based on the standard it is drawn from:
--   PAES 103:2000 - Agricultural Machinery - Method of Sampling
--   PAES 138:2004 - Agricultural Machinery - Guidelines on After-Sales Service
--   PNS/BAFS/PAES 192:2016 - Agricultural and Fisheries Machinery - Guidelines
--     on After-Sales Service
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Philippine National Standards on After-Sales Service and Methods of Sampling (POWER_ENERGY_MACHINERY) -- 33 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Philippine National Standards on After-Sales Service and Methods of Sampling' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Philippine National Standards on After-Sales Service and Methods of Sampling';
  END IF;

  -- 1. Acceptance test definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Method of Sampling standard for agricultural machinery, which term refers to a test carried out on samples selected from a lot for the purpose of accepting or rejecting the lot?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the Method of Sampling standard for agricultural machinery, which term refers to a test carried out on samples selected from a lot for the purpose of accepting or rejecting the lot?', 'single_choice', 'easy', 'The standard defines an acceptance test as a test carried out on samples selected from a lot for the purpose of acceptance of the lot. A routine test is done on each and every unit, and a type test proves conformity of a given type to the specification.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Acceptance test', true, 0),
      (v_question_id, 'Routine test', false, 1),
      (v_question_id, 'Field verification test', false, 2),
      (v_question_id, 'Type test', false, 3);
  END IF;

  -- 2. Type test definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which test, as defined in the Method of Sampling standard, is carried out to prove conformity to the requirements of the relevant specification and is intended to check the general qualities and design of a given type of component or equipment?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which test, as defined in the Method of Sampling standard, is carried out to prove conformity to the requirements of the relevant specification and is intended to check the general qualities and design of a given type of component or equipment?', 'single_choice', 'easy', 'The standard defines a type test as a test carried out to prove conformity to the requirements of the relevant specification; it checks the general qualities and design of a given type of component or equipment.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Routine test', false, 0),
      (v_question_id, 'Visual and dimensional test', false, 1),
      (v_question_id, 'Type test', true, 2),
      (v_question_id, 'Acceptance test', false, 3);
  END IF;

  -- 3. Lot grouping note
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A consignment has 150 units of the same kind, type and size, but 100 units are made of one material and 50 units are made of a different material. According to the note on what constitutes a lot in the Method of Sampling standard, how should these units be treated?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A consignment has 150 units of the same kind, type and size, but 100 units are made of one material and 50 units are made of a different material. According to the note on what constitutes a lot in the Method of Sampling standard, how should these units be treated?', 'single_choice', 'medium', 'To constitute a lot, all components or equipment of the same kind, type, size, and manufactured from the same material shall be grouped together. Because the materials differ, the 100 units and the 50 units belong to separate lots.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'As one lot of 150 units, because the kind, type and size are the same', false, 0),
      (v_question_id, 'As one lot of 150 units, because they were delivered in a single consignment', false, 1),
      (v_question_id, 'As one lot, provided the supplier is the same for both groups', false, 2),
      (v_question_id, 'As two separate lots, because units of the same kind, type, size and material are grouped together', true, 3);
  END IF;

  -- 4. Revised standard origin
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 103:2000, Agricultural Machinery - Method of Sampling, is a revision of which earlier Philippine National Standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 103:2000, Agricultural Machinery - Method of Sampling, is a revision of which earlier Philippine National Standard?', 'single_choice', 'easy', 'The foreword states that PAES 103:2000 is a revision of PNS 556:1992, Method of Sampling.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PNS 01:Part 4:1998', false, 0),
      (v_question_id, 'PNS 556:1992', true, 1),
      (v_question_id, 'PAES 138:2004', false, 2),
      (v_question_id, 'PAES 102:2000', false, 3);
  END IF;

  -- 5. Lot of 20 visual sample
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 20 units is submitted for acceptance sampling. Using Table 1 and Table 2 of the Method of Sampling standard, what are the sample size and the permissible number of defectives for the visual and dimensional tests?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 20 units is submitted for acceptance sampling. Using Table 1 and Table 2 of the Method of Sampling standard, what are the sample size and the permissible number of defectives for the visual and dimensional tests?', 'single_choice', 'medium', 'A lot size of 11 to 25 falls in the second row of the tables: sample size n = 2 for visual and dimensional tests, with 0 permissible defectives.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 units, with 0 permissible defectives', false, 0),
      (v_question_id, '1 unit, with 0 permissible defectives', false, 1),
      (v_question_id, '2 units, with 1 permissible defective', false, 2),
      (v_question_id, '2 units, with 0 permissible defectives', true, 3);
  END IF;

  -- 6. Lot of 400 visual sample
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 400 units is submitted for acceptance sampling. Using Table 1 and Table 2 of the Method of Sampling standard, what are the sample size and the permissible number of defectives for the visual and dimensional tests?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 400 units is submitted for acceptance sampling. Using Table 1 and Table 2 of the Method of Sampling standard, what are the sample size and the permissible number of defectives for the visual and dimensional tests?', 'single_choice', 'medium', 'A lot size of 301 to 500 gives a visual and dimensional sample size n = 32, with 3 permissible defectives.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '32 units, with 5 permissible defectives', false, 0),
      (v_question_id, '50 units, with 5 permissible defectives', false, 1),
      (v_question_id, '32 units, with 3 permissible defectives', true, 2),
      (v_question_id, '13 units, with 1 permissible defective', false, 3);
  END IF;

  -- 7. r for lot of 1200
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 1,200 units is to be sampled for visual and dimensional tests. Table 1 of the Method of Sampling standard gives a sample size n = 80 for this lot size. Using the random sampling procedure, what is the value of r?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 1,200 units is to be sampled for visual and dimensional tests. Table 1 of the Method of Sampling standard gives a sample size n = 80 for this lot size. Using the random sampling procedure, what is the value of r?', 'single_choice', 'medium', 'Given: N = 1,200 units; n = 80. r = N / n = 1,200 / 80 = 15.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15', true, 0),
      (v_question_id, '150', false, 1),
      (v_question_id, '9', false, 2),
      (v_question_id, '24', false, 3);
  END IF;

  -- 8. Other tests sample lot of 90
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 90 units has already been found conforming in the visual and dimensional tests. According to Table 1 and Table 2 of the Method of Sampling standard, what sub-sample size and permissible number of defectives apply to the tests other than visual and dimensional?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 90 units has already been found conforming in the visual and dimensional tests. According to Table 1 and Table 2 of the Method of Sampling standard, what sub-sample size and permissible number of defectives apply to the tests other than visual and dimensional?', 'single_choice', 'medium', 'A lot size of 51 to 100 requires, for tests other than visual and dimensional, a sample size n = 2 with 0 permissible defectives.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 units, with 0 permissible defectives', false, 0),
      (v_question_id, '2 units, with 0 permissible defectives', true, 1),
      (v_question_id, '2 units, with 1 permissible defective', false, 2),
      (v_question_id, '3 units, with 0 permissible defectives', false, 3);
  END IF;

  -- 9. Position of third sample
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 60 units is sampled for visual and dimensional tests. Table 1 of the Method of Sampling standard gives n = 5 for this lot size, so r = 60/5 = 12. The number drawn at random from 1 to r is z = 4. Units are counted in order 1, 2, 3, ... from the start of the lot; the 4th unit is the first sample, and counting restarts from the next unit up to r, with every r-th unit counted being withdrawn. Which unit position in the lot is the third sample?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 60 units is sampled for visual and dimensional tests. Table 1 of the Method of Sampling standard gives n = 5 for this lot size, so r = 60/5 = 12. The number drawn at random from 1 to r is z = 4. Units are counted in order 1, 2, 3, ... from the start of the lot; the 4th unit is the first sample, and counting restarts from the next unit up to r, with every r-th unit counted being withdrawn. Which unit position in the lot is the third sample?', 'single_choice', 'hard', 'Given: N = 60, n = 5, r = 12, z = 4. First sample = unit 4. Counting restarts at unit 5 and the 12th count is unit 16 (second sample). Counting restarts at unit 17 and the 12th count is unit 28 (third sample). Answer: unit 28.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Unit 16', false, 0),
      (v_question_id, 'Unit 28', true, 1),
      (v_question_id, 'Unit 24', false, 2),
      (v_question_id, 'Unit 36', false, 3);
  END IF;

  -- 10. Conformity visual lot of 1500
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 1,500 units is examined for visual and dimensional characteristics using a sample of 80 units, and 7 units in the sample fail one or more requirements. Using Table 2 of the Method of Sampling standard, what is the result?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 1,500 units is examined for visual and dimensional characteristics using a sample of 80 units, and 7 units in the sample fail one or more requirements. Using Table 2 of the Method of Sampling standard, what is the result?', 'single_choice', 'hard', 'For a lot size of 1001 and above, the sample size is 80 with 7 permissible defectives. The lot conforms if the number of defectives does not exceed the permissible number; 7 does not exceed 7, so the lot conforms for visual and dimensional characteristics and proceeds to the sub-sample for the other tests.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The lot is rejected, because any defective unit disqualifies a lot of this size', false, 0),
      (v_question_id, 'The lot is rejected, because the number of defectives reaches the permissible limit', false, 1),
      (v_question_id, 'The lot must be resampled with 50 units before a decision is made', false, 2),
      (v_question_id, 'The lot conforms, because the number of defectives does not exceed the permissible 7', true, 3);
  END IF;

  -- 11. Conformity other tests lot of 1500
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 1,500 units already conforms in the visual and dimensional tests. A sub-sample of 13 units is then tested for the requirements other than visual and dimensional, and 2 units fail one or more requirements. Using Table 2 of the Method of Sampling standard, what is the result?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of 1,500 units already conforms in the visual and dimensional tests. A sub-sample of 13 units is then tested for the requirements other than visual and dimensional, and 2 units fail one or more requirements. Using Table 2 of the Method of Sampling standard, what is the result?', 'single_choice', 'hard', 'For a lot size of 1001 and above, the sub-sample for other tests is 13 units with 1 permissible defective. Two defectives exceed the permissible number, so the lot does not conform to the requirements.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The lot conforms, because the visual and dimensional tests were already passed', false, 0),
      (v_question_id, 'The lot conforms, because 2 defectives are fewer than the sub-sample of 13', false, 1),
      (v_question_id, 'The lot does not conform, because 2 defectives exceed the permissible 1', true, 2),
      (v_question_id, 'The lot conforms, because the permissible number of defectives is 7', false, 3);
  END IF;

  -- 12. No other requirement specified
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to the note in the Conformity clause of the Method of Sampling standard, what applies if an individual product specification gives no requirement other than visual and dimensional?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to the note in the Conformity clause of the Method of Sampling standard, what applies if an individual product specification gives no requirement other than visual and dimensional?', 'single_choice', 'medium', 'The note states that if no requirement other than visual and dimensional is specified, the sub-sample columns of Table 2 and sub-clause 3.1.2.2 are not considered, and a lot that satisfies the visual and dimensional tests is considered conforming.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A lot that passes the visual and dimensional tests is considered conforming, and the sub-sample for other tests is not taken', true, 0),
      (v_question_id, 'The sub-sample for other tests is still taken using the sample size in Table 1', false, 1),
      (v_question_id, 'The lot must pass a type test before it is accepted', false, 2),
      (v_question_id, 'The visual and dimensional sample size is doubled', false, 3);
  END IF;

  -- 13. Type test sample selection
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the type test procedure of the Method of Sampling standard, who selects the test sample?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the type test procedure of the Method of Sampling standard, who selects the test sample?', 'single_choice', 'medium', 'The manufacturer or supplier furnishes one sample of product to the testing authority, and the test sample shall be selected by the testing authority with the agreement of the manufacturer or the supplier.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The supplier alone, after the testing authority has sent the specification', false, 0),
      (v_question_id, 'The buyer, at random from the dealer''s stock', false, 1),
      (v_question_id, 'The manufacturer alone, from the best unit in production', false, 2),
      (v_question_id, 'The testing authority, with the agreement of the manufacturer or the supplier', true, 3);
  END IF;

  -- 14. Repeat type test outcome
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A product fails its first type test sample, so two more samples are taken for a repeat type test. One of the two repeat samples passes every requirement, while the other fails one requirement. According to the Method of Sampling standard, what is the result?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A product fails its first type test sample, so two more samples are taken for a repeat type test. One of the two repeat samples passes every requirement, while the other fails one requirement. According to the Method of Sampling standard, what is the result?', 'single_choice', 'hard', 'In a repeat test, the product is considered eligible for type approval only if no single failure occurs. Since one sample failed, the product is disapproved, and the manufacturer or supplier is asked to improve the design and resubmit the product for type approval.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A third repeat test with two more samples is automatically conducted', false, 0),
      (v_question_id, 'The product is disapproved, and the manufacturer or supplier is asked to improve the design and resubmit it', true, 1),
      (v_question_id, 'The product is eligible for type approval, because one of the two repeat samples passed', false, 2),
      (v_question_id, 'The product is eligible for type approval, because the first sample failed only once', false, 3);
  END IF;

  -- 15. r for other tests lot of 450
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A sub-sample for the tests other than visual and dimensional is to be drawn from a lot of 450 units. Table 1 of the Method of Sampling standard gives n = 5 for this lot size and test type. What is the value of r used in selecting the sample?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A sub-sample for the tests other than visual and dimensional is to be drawn from a lot of 450 units. Table 1 of the Method of Sampling standard gives n = 5 for this lot size and test type. What is the value of r used in selecting the sample?', 'single_choice', 'medium', 'Given: N = 450 units; n = 5. r = N / n = 450 / 5 = 90.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '150', false, 0),
      (v_question_id, '35', false, 1),
      (v_question_id, '90', true, 2),
      (v_question_id, '14', false, 3);
  END IF;

  -- 16. Warranty hours limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Table 1 of the older PAES 138:2004 Guidelines on After-Sales Service, the warranty period for agricultural machinery is within six months from purchase or how many operating hours, whichever comes first?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Table 1 of the older PAES 138:2004 Guidelines on After-Sales Service, the warranty period for agricultural machinery is within six months from purchase or how many operating hours, whichever comes first?', 'single_choice', 'medium', 'Table 1 of PAES 138:2004 states that the warranty is within six months from the purchase of the machinery or 600 hours, whichever comes first.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '600 hours', true, 0),
      (v_question_id, '1,200 hours', false, 1),
      (v_question_id, '300 hours', false, 2),
      (v_question_id, '1,000 hours', false, 3);
  END IF;

  -- 17. Free mechanic radius
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 138:2004, the manufacturer/distributor/dealer shall supply the services of a mechanic free of charge for replacing parts under warranty. Within what distance does this free service include the transportation cost?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 138:2004, the manufacturer/distributor/dealer shall supply the services of a mechanic free of charge for replacing parts under warranty. Within what distance does this free service include the transportation cost?', 'single_choice', 'medium', 'Clause 4.2.1 requires free mechanic services for replacing parts under warranty, which includes the transportation cost within a 50-km radius.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50-km radius', true, 0),
      (v_question_id, '100-km radius', false, 1),
      (v_question_id, '25-km radius', false, 2),
      (v_question_id, '200-km radius', false, 3);
  END IF;

  -- 18. Small scale minimum requirements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which set of minimum after-sales service requirements in Table 1 of PAES 138:2004 applies to a small-scale manufacturer/distributor/dealer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which set of minimum after-sales service requirements in Table 1 of PAES 138:2004 applies to a small-scale manufacturer/distributor/dealer?', 'single_choice', 'medium', 'Table 1 lists, for a small-scale manufacturer/distributor/dealer: 1 service mechanic, a repair service area of 20 square meters, and 1 service vehicle.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 service mechanics, 20 square meters of repair service area, and 1 service vehicle', false, 0),
      (v_question_id, '3 service mechanics, 60 square meters of repair service area, and 3 service vehicles', false, 1),
      (v_question_id, '1 service mechanic, 20 square meters of repair service area, and 1 service vehicle', true, 2),
      (v_question_id, '1 service mechanic, 40 square meters of repair service area, and 2 service vehicles', false, 3);
  END IF;

  -- 19. Large scale tool sets
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to Table 1 of PAES 138:2004, how many sets of basic and special tools/equipment must a large-scale manufacturer/distributor/dealer have?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to Table 1 of PAES 138:2004, how many sets of basic and special tools/equipment must a large-scale manufacturer/distributor/dealer have?', 'single_choice', 'medium', 'Table 1 requires large-scale entities to have 3 sets of basic tools/equipment and 2 sets of special tools/equipment (medium scale: 2 basic and 1 special; small scale: 1 basic and an optional special set).', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 sets of basic and 1 set of special tools/equipment', false, 0),
      (v_question_id, '3 sets of basic and 3 sets of special tools/equipment', false, 1),
      (v_question_id, '1 set of basic and 2 sets of special tools/equipment', false, 2),
      (v_question_id, '3 sets of basic and 2 sets of special tools/equipment', true, 3);
  END IF;

  -- 20. Special tools classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In Table 2 of PAES 138:2004 (List of Repair and Maintenance Tools and Equipments), which of the following is classified as a special tool/equipment for manufacturers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In Table 2 of PAES 138:2004 (List of Repair and Maintenance Tools and Equipments), which of the following is classified as a special tool/equipment for manufacturers?', 'single_choice', 'medium', 'Table 2 lists the torque wrench among the special tools/equipment (with gauges, turning, bending and shearing machines, and painting/finishing equipment). Welding machine, tachometer and set of pullers are listed as basic tools/equipment.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tachometer', false, 0),
      (v_question_id, 'Torque wrench', true, 1),
      (v_question_id, 'Set of pullers', false, 2),
      (v_question_id, 'Welding machine', false, 3);
  END IF;

  -- 21. Size classification boundary
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Annex A of PAES 138:2004, a dealer is rated on 9 parameters with equivalent points of 6, 10, 6, 10, 6, 10, 6, 6 and 3. The total points score is the sum of the equivalent points divided by the number of parameters, and the rating scale is less than 4 points = small scale, 4 to 7 points = medium scale, and more than 7 points = large scale. How is the dealer classified?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Annex A of PAES 138:2004, a dealer is rated on 9 parameters with equivalent points of 6, 10, 6, 10, 6, 10, 6, 6 and 3. The total points score is the sum of the equivalent points divided by the number of parameters, and the rating scale is less than 4 points = small scale, 4 to 7 points = medium scale, and more than 7 points = large scale. How is the dealer classified?', 'single_choice', 'hard', 'Given: points 6 + 10 + 6 + 10 + 6 + 10 + 6 + 6 + 3 = 63; number of parameters = 9. Total points score = 63 / 9 = 7.0. Since 4 to 7 points is medium scale and only a score above 7 is large scale, the dealer is medium scale.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Medium scale', true, 0),
      (v_question_id, 'Large scale', false, 1),
      (v_question_id, 'Not classifiable under the rating scale', false, 2),
      (v_question_id, 'Small scale', false, 3);
  END IF;

  -- 22. Personnel partial points
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Annex A of PAES 138:2004, parameter 8 (type and number of personnel) gives 3 points for Class 1 personnel, 6 points for Class 2 and 10 points for Class 3, and the points are computed as the sum of (percent of personnel in the class x equivalent point). A firm''s staff is 60% Class 1, 30% Class 2 and 10% Class 3. What is its total point for this parameter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Annex A of PAES 138:2004, parameter 8 (type and number of personnel) gives 3 points for Class 1 personnel, 6 points for Class 2 and 10 points for Class 3, and the points are computed as the sum of (percent of personnel in the class x equivalent point). A firm''s staff is 60% Class 1, 30% Class 2 and 10% Class 3. What is its total point for this parameter?', 'single_choice', 'hard', 'Given: 60% x 3 + 30% x 6 + 10% x 10 = 1.8 + 1.8 + 1.0 = 4.6 points.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.9 points', false, 0),
      (v_question_id, '5.5 points', false, 1),
      (v_question_id, '6.3 points', false, 2),
      (v_question_id, '4.6 points', true, 3);
  END IF;

  -- 23. Annex A manufacturer-only parameters
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In Annex A (Rating Scheme for Size Classification) of PAES 138:2004, which pair of parameters is marked as applicable to manufacturers only?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In Annex A (Rating Scheme for Size Classification) of PAES 138:2004, which pair of parameters is marked as applicable to manufacturers only?', 'single_choice', 'medium', 'Annex A marks parameter 3 (production mode) and parameter 7 (equipment and manufacturing capability) as for manufacturers only.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'After-sales service, and type and number of products', false, 0),
      (v_question_id, 'Area of operation, and marketing and distribution', false, 1),
      (v_question_id, 'Production mode, and equipment and manufacturing capability', true, 2),
      (v_question_id, 'Current value, and ownership', false, 3);
  END IF;

  -- 24. Current value and ownership points
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Annex A of PAES 138:2004, current value is rated 3 points for less than P 5 million, 6 points for P 5 to P 20 million and 10 points for more than P 20 million; ownership is rated 3 points for single proprietorship, 6 points for partnership/cooperative and 10 points for corporation. A cooperative-owned dealer has a current value of P 12 million. What is the sum of its points for these two parameters?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Annex A of PAES 138:2004, current value is rated 3 points for less than P 5 million, 6 points for P 5 to P 20 million and 10 points for more than P 20 million; ownership is rated 3 points for single proprietorship, 6 points for partnership/cooperative and 10 points for corporation. A cooperative-owned dealer has a current value of P 12 million. What is the sum of its points for these two parameters?', 'single_choice', 'medium', 'Given: current value P 12 million falls in P 5 to P 20 million = 6 points; a cooperative = 6 points. Sum = 6 + 6 = 12 points.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16 points', false, 0),
      (v_question_id, '12 points', true, 1),
      (v_question_id, '9 points', false, 2),
      (v_question_id, '13 points', false, 3);
  END IF;

  -- 25. Class 2 products
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In parameter 9 (type and number of products) of Annex A of PAES 138:2004, which of the following products is listed under Class 2, worth 6 equivalent points?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In parameter 9 (type and number of products) of Annex A of PAES 138:2004, which of the following products is listed under Class 2, worth 6 equivalent points?', 'single_choice', 'medium', 'Class 2 lists dryers (under 2 tons), rice mills, drilling rigs and other products costing from P 50,000 to P 250,000. Hand tractors are Class 1, while silos and 4W tractors are Class 3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Silo', false, 0),
      (v_question_id, 'Hand tractor', false, 1),
      (v_question_id, 'Rice mill', true, 2),
      (v_question_id, 'Four-wheel tractor', false, 3);
  END IF;

  -- 26. Distributor definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 138:2004, which term is defined as a trading entity authorized by foreign and local suppliers and/or manufacturers to distribute agricultural machinery to dealers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 138:2004, which term is defined as a trading entity authorized by foreign and local suppliers and/or manufacturers to distribute agricultural machinery to dealers?', 'single_choice', 'easy', 'The standard defines a distributor as a trading entity authorized by foreign and local suppliers and/or manufacturers to distribute agricultural machinery to dealers. A dealer is the authorized representative that sells and services the machinery to end-users.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138:2004')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Distributor', true, 0),
      (v_question_id, 'Dealer', false, 1),
      (v_question_id, 'Manufacturer', false, 2),
      (v_question_id, 'Procuring entity', false, 3);
  END IF;

  -- 27. Parties receiving services 2016
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PNS/BAFS/PAES 192:2016, after-sales service consists of parts and services provided by the manufacturers/distributors/dealers to which party, replacing the term end-user used in the older PAES 138:2004?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PNS/BAFS/PAES 192:2016, after-sales service consists of parts and services provided by the manufacturers/distributors/dealers to which party, replacing the term end-user used in the older PAES 138:2004?', 'single_choice', 'medium', 'PNS/BAFS/PAES 192:2016 defines after-sales service as parts and services provided to the procuring entities (any person or entity procuring agricultural and fisheries machinery) to ensure continuous serviceability, whereas PAES 138:2004 referred to the end-user.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Accredited testing centers', false, 0),
      (v_question_id, 'Procuring entities', true, 1),
      (v_question_id, 'Licensed agricultural engineers', false, 2),
      (v_question_id, 'Local government units only', false, 3);
  END IF;

  -- 28. AFMech Law whichever more advantageous
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The foreword of PNS/BAFS/PAES 192:2016 cites Section 17 of the Agricultural and Fisheries Mechanization Law. Under it, machinery assemblers, manufacturers, importers, suppliers, distributors and dealers shall provide after-sales service and warranty in accordance with the PAES or with the manufacturer''s warranty policy, whichever is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The foreword of PNS/BAFS/PAES 192:2016 cites Section 17 of the Agricultural and Fisheries Mechanization Law. Under it, machinery assemblers, manufacturers, importers, suppliers, distributors and dealers shall provide after-sales service and warranty in accordance with the PAES or with the manufacturer''s warranty policy, whichever is:', 'single_choice', 'hard', 'Section 17 of the AFMech Law (RA 10601) requires after-sales service and warranty per the PAES or per the manufacturer''s warranty policy, whichever is more advantageous to the client.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less costly to the manufacturer', false, 0),
      (v_question_id, 'Approved first by the Board of Agricultural Engineering', false, 1),
      (v_question_id, 'Longer in the number of service visits only', false, 2),
      (v_question_id, 'More advantageous to the client', true, 3);
  END IF;

  -- 29. Benefit not stated
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The foreword of PNS/BAFS/PAES 192:2016 states the importance of after-sales service. Which of the following is NOT stated as a benefit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The foreword of PNS/BAFS/PAES 192:2016 states the importance of after-sales service. Which of the following is NOT stated as a benefit?', 'single_choice', 'medium', 'The foreword says after-sales service enhances the optimal use of the machinery, maximizes its economic life, and ensures its re-sale value, and that dealers provide it to satisfy customers and gain competitive advantage. A lower purchase price is not stated.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It reduces the purchase price of the machinery', true, 0),
      (v_question_id, 'It maximizes the economic life of the machinery', false, 1),
      (v_question_id, 'It enhances the optimal use of the machinery', false, 2),
      (v_question_id, 'It ensures the re-sale value of the machinery', false, 3);
  END IF;

  -- 30. Added warranty exclusions 2016
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following warranty exclusions appears in clause 4.1.2 of PNS/BAFS/PAES 192:2016 but is not in the three-item list of PAES 138:2004?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following warranty exclusions appears in clause 4.1.2 of PNS/BAFS/PAES 192:2016 but is not in the three-item list of PAES 138:2004?', 'single_choice', 'hard', 'PAES 138:2004 excludes accident or natural disaster, improper operation and maintenance, and unauthorized repair or non-genuine parts. The 2016 standard adds acts of violence, negligent handling and excessive load, and use of unsuitable operating materials; use of unsuitable operating materials is one of the added items.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Improper operation and maintenance of the machine', false, 0),
      (v_question_id, 'Use of unsuitable operating materials', true, 1),
      (v_question_id, 'Unauthorized repair and/or use of non-genuine parts', false, 2),
      (v_question_id, 'Accident or natural disaster', false, 3);
  END IF;

  -- 31. Training requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to clause 4.3 of PNS/BAFS/PAES 192:2016, the manufacturers/distributors/dealers shall provide training on what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to clause 4.3 of PNS/BAFS/PAES 192:2016, the manufacturers/distributors/dealers shall provide training on what?', 'single_choice', 'easy', 'Clause 4.3 requires training on the operation, repairs and maintenance of the agricultural and fisheries machinery.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Preparation of procurement documents', false, 0),
      (v_question_id, 'Marketing and pricing of the machinery', false, 1),
      (v_question_id, 'Operation, repairs and maintenance of the machinery', true, 2),
      (v_question_id, 'Accreditation of testing centers', false, 3);
  END IF;

  -- 32. Operator manual standard reference
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Clause 4.4 of PNS/BAFS/PAES 192:2016 requires an Operator''s Manual containing full information on the method of installation and operation. Which standard does it refer to for this manual?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Clause 4.4 of PNS/BAFS/PAES 192:2016 requires an Operator''s Manual containing full information on the method of installation and operation. Which standard does it refer to for this manual?', 'single_choice', 'medium', 'Clause 4.4 refers to PAES 102:2000, Agricultural Machinery - Operator''s Manual - Content and Presentation, and also requires a set of standard tools for maintenance.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PAES 101:2000', false, 0),
      (v_question_id, 'PAES 138:2004', false, 1),
      (v_question_id, 'PAES 103:2000', false, 2),
      (v_question_id, 'PAES 102:2000', true, 3);
  END IF;

  -- 33. Spare parts stock value
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PNS/BAFS/PAES 192:2016 requires maintaining spare parts of at least 10% of the average past three-year sales per product. A dealer''s sales of one product were P 6.0 million, P 7.5 million and P 4.5 million in the past three years. What is the minimum value of spare parts to maintain for this product?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PNS/BAFS/PAES 192:2016 requires maintaining spare parts of at least 10% of the average past three-year sales per product. A dealer''s sales of one product were P 6.0 million, P 7.5 million and P 4.5 million in the past three years. What is the minimum value of spare parts to maintain for this product?', 'single_choice', 'hard', 'Given: yearly sales P 6.0M, P 7.5M and P 4.5M. Average = (6.0 + 7.5 + 4.5) / 3 = P 6.0 million. Minimum spare parts = 10% x 6.0M = P 600,000.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS/PAES 192:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P 600,000', true, 0),
      (v_question_id, 'P 180,000', false, 1),
      (v_question_id, 'P 60,000', false, 2),
      (v_question_id, 'P 1,800,000', false, 3);
  END IF;
END $$;
