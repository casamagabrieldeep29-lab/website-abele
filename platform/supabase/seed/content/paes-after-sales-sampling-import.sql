-- Philippine National Standards on After-Sales Service and Methods of
-- Sampling quiz batch (25 questions, 1 topic). Every question, correct
-- answer, and distractor is drawn directly from the standards' actual
-- clauses -- no invented facts. This topic had only 20 published questions
-- before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes/paes_reference set per
-- question based on which actual standard it's drawn from:
--   PAES 103:2000 - Agricultural Machinery - Method of Sampling
--   PAES 138:2004 - Agricultural Machinery - Guidelines on After-Sales Service
--   PNS/BAFS/PAES 192:2016 - Agricultural and Fisheries Machinery - Guidelines
--     on After-Sales Service (cancels and replaces PNS/PAES 138:2005)
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Philippine National Standards on After-Sales Service and Methods of Sampling (POWER_ENERGY_MACHINERY) -- 25 question(s)
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

  -- 1. PAES 103 scope
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The standard on Method of Sampling for agricultural machinery prescribes sampling procedures for which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The standard on Method of Sampling for agricultural machinery prescribes sampling procedures for which of the following?', 'single_choice', 'easy', 'The scope states the standard prescribes procedures for sampling agricultural machinery and its components, unless specified in the respective product specification, and applies to finished products in the production line.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Raw materials awaiting delivery to a factory', false, 0),
      (v_question_id, 'Finished agricultural machinery products and their components in the production line', true, 1),
      (v_question_id, 'Only imported second-hand agricultural machinery', false, 2),
      (v_question_id, 'Agricultural machinery already in use by farmers for more than a year', false, 3);
  END IF;

  -- 2. Definition of lot
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Method of Sampling standard, how is a "lot" defined?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Method of Sampling standard, how is a "lot" defined?', 'single_choice', 'easy', 'Clause 2.2 defines lot as "in any consignment, all components or equipment under study," with a note that to constitute a lot, all components or equipment must be of the same kind, type, size, and manufactured from the same material.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Any single unit chosen at random for testing', false, 0),
      (v_question_id, 'In any consignment, all components or equipment under study, grouped together if of the same kind, type, size, and material', true, 1),
      (v_question_id, 'A fixed batch of exactly 100 units regardless of type', false, 2),
      (v_question_id, 'The total annual production output of a manufacturer', false, 3);
  END IF;

  -- 3. Acceptance test vs routine test vs type test
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which test, per the Method of Sampling standard, is "carried out on each and every component or equipment to check the specifications which are likely to vary during production"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which test, per the Method of Sampling standard, is "carried out on each and every component or equipment to check the specifications which are likely to vary during production"?', 'single_choice', 'medium', 'Clause 2.3 defines the routine test this way, distinguishing it from the acceptance test (2.1, carried out on samples selected from a lot) and the type test (2.4, carried out to prove conformity to the relevant specification).', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Acceptance test', false, 0),
      (v_question_id, 'Routine test', true, 1),
      (v_question_id, 'Type test', false, 2),
      (v_question_id, 'Lot test', false, 3);
  END IF;

  -- 4. Table 1 scale of sampling, lot size 101-300
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 1 (Scale of Sampling) of the Method of Sampling standard, for a lot size of 101 to 300 units, what sample size is required for visual and dimensional tests?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 1 (Scale of Sampling) of the Method of Sampling standard, for a lot size of 101 to 300 units, what sample size is required for visual and dimensional tests?', 'single_choice', 'medium', 'Table 1 lists a sample size of 13 for visual and dimensional tests when the lot size (N) is 101 to 300, versus a sample size of 3 for other tests at the same lot size.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3', false, 0),
      (v_question_id, '5', false, 1),
      (v_question_id, '13', true, 2),
      (v_question_id, '32', false, 3);
  END IF;

  -- 5. Table 1 scale of sampling, lot size 1001 and above, other tests
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 1 of the Method of Sampling standard, for a lot size of 1001 and above, what sample size applies for tests other than visual and dimensional tests?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 1 of the Method of Sampling standard, for a lot size of 1001 and above, what sample size applies for tests other than visual and dimensional tests?', 'single_choice', 'medium', 'Table 1 lists a sample size of 13 "for other tests" when N is 1001 and above, compared to 80 for visual and dimensional tests at that same lot size.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8', false, 0),
      (v_question_id, '13', true, 1),
      (v_question_id, '50', false, 2),
      (v_question_id, '80', false, 3);
  END IF;

  -- 6. Table 2 permissible defectives, lot size 501-1000, visual/dimensional
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 2 (Scale of Sampling and Permissible Number of Defectives) of the Method of Sampling standard, for a lot size of 501 to 1000 under visual and dimensional tests, what is the permissible number of defectives?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 2 (Scale of Sampling and Permissible Number of Defectives) of the Method of Sampling standard, for a lot size of 501 to 1000 under visual and dimensional tests, what is the permissible number of defectives?', 'single_choice', 'hard', 'Table 2 shows a sample size of 50 with a permissible number of defectives of 5 for visual and dimensional tests when N is 501 to 1000.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0', false, 0),
      (v_question_id, '1', false, 1),
      (v_question_id, '3', false, 2),
      (v_question_id, '5', true, 3);
  END IF;

  -- 7. Table 2 permissible defectives, lot size 26-50
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 2 of the Method of Sampling standard, when the lot size is 26 to 50, what is the permissible number of defectives for both visual/dimensional tests and other tests?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 2 of the Method of Sampling standard, when the lot size is 26 to 50, what is the permissible number of defectives for both visual/dimensional tests and other tests?', 'single_choice', 'medium', 'Table 2 shows a permissible number of defectives of 0 for lot size 26 to 50 under both the visual/dimensional test column and the other tests column.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0', true, 0),
      (v_question_id, '1', false, 1),
      (v_question_id, '2', false, 2),
      (v_question_id, '3', false, 3);
  END IF;

  -- 8. Formula for r
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the random sampling procedure of the Method of Sampling standard, the value r (the upper limit of the set of numbers used in selecting the sample) is computed using which equation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the random sampling procedure of the Method of Sampling standard, the value r (the upper limit of the set of numbers used in selecting the sample) is computed using which equation?', 'single_choice', 'medium', 'Sub-clause 3.1.1.1.1 gives r = N / n, where N is the size of the lot and n is the sample size for a given lot size from Table 1.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'r = n / N', false, 0),
      (v_question_id, 'r = N / n', true, 1),
      (v_question_id, 'r = N x n', false, 2),
      (v_question_id, 'r = N + n', false, 3);
  END IF;

  -- 9. Worked example r value
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Method of Sampling standard''s worked example, a lot size (N) of 20 has a sample size (n) of 2 from Table 1. What is the resulting value of r?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the Method of Sampling standard''s worked example, a lot size (N) of 20 has a sample size (n) of 2 from Table 1. What is the resulting value of r?', 'single_choice', 'easy', 'The worked example computes r = N/n = 20/2 = 10.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2', false, 0),
      (v_question_id, '10', true, 1),
      (v_question_id, '18', false, 2),
      (v_question_id, '20', false, 3);
  END IF;

  -- 10. Worked example: drawing z and first sample
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Method of Sampling standard''s worked example (r = 10), the number 8 is drawn at random from 1 to r as z. Counting components in order as 1, 2, 3... from the start of the lot, which lettered component becomes the first sample?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the Method of Sampling standard''s worked example (r = 10), the number 8 is drawn at random from 1 to r as z. Counting components in order as 1, 2, 3... from the start of the lot, which lettered component becomes the first sample?', 'single_choice', 'hard', 'In the example, components are counted A=1, B=2, C=3, D=4, E=5, F=6, G=7, H=8, so component H (the 8th component) is the first sample, since z = 8.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Component G', false, 0),
      (v_question_id, 'Component H', true, 1),
      (v_question_id, 'Component I', false, 2),
      (v_question_id, 'Component R', false, 3);
  END IF;

  -- 11. Worked example: second sample
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Continuing the Method of Sampling standard''s worked example, after component H is taken as the first sample, counting continues from component I up to the 10th count. Which component becomes the second sample?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Continuing the Method of Sampling standard''s worked example, after component H is taken as the first sample, counting continues from component I up to the 10th count. Which component becomes the second sample?', 'single_choice', 'hard', 'Starting the count again from component I (count 1) up to count 10, the example shows component R lands on the 10th count, making R the second sample. Every rth (here, 10th) component is withdrawn after the first.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Component Q', false, 0),
      (v_question_id, 'Component R', true, 1),
      (v_question_id, 'Component S', false, 2),
      (v_question_id, 'Component T', false, 3);
  END IF;

  -- 12. Sub-sample for conformity (other than visual/dimensional)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per sub-clause 3.1.2.2 of the Method of Sampling standard, when a lot already conforms to the visual and dimensional requirements, how is the sub-sample for tests other than visual and dimensional selected?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per sub-clause 3.1.2.2 of the Method of Sampling standard, when a lot already conforms to the visual and dimensional requirements, how is the sub-sample for tests other than visual and dimensional selected?', 'single_choice', 'medium', 'Sub-clause 3.1.2.2 states the sub-sample (sized per column 4 of Table 2) is taken at random from the component or equipment already selected in sub-clause 3.1.2.1, and each unit in the sub-sample is tested for the requirements other than visual and dimensional.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A fresh sample is drawn at random from the entire original lot, independent of the earlier sample', false, 0),
      (v_question_id, 'The sub-sample is taken at random from the component or equipment already selected for the visual and dimensional tests', true, 1),
      (v_question_id, 'Every unit in the lot is retested without any sampling', false, 2),
      (v_question_id, 'The manufacturer chooses which units to submit for the sub-sample', false, 3);
  END IF;

  -- 13. Type test procedure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the type test procedure of the Method of Sampling standard, how many samples must the manufacturer or supplier initially furnish to the testing authority?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the type test procedure of the Method of Sampling standard, how many samples must the manufacturer or supplier initially furnish to the testing authority?', 'single_choice', 'easy', 'Sub-clause 3.3.1 states the manufacturer or supplier shall furnish to the testing authority one sample of the product, selected by the testing authority with the agreement of the manufacturer or supplier.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One sample', true, 0),
      (v_question_id, 'Two samples', false, 1),
      (v_question_id, 'Three samples', false, 2),
      (v_question_id, 'As many as the testing authority wants, with no limit', false, 3);
  END IF;

  -- 14. Type test: if initial sample fails
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Method of Sampling standard''s type test procedure, if the initial type test sample fails, what happens next?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Method of Sampling standard''s type test procedure, if the initial type test sample fails, what happens next?', 'single_choice', 'medium', 'Sub-clause 3.3.3 states that if the sample fails, two more samples shall be taken and tested for all requirements; if no failure occurs in the repeat test, the product is eligible for type approval, but if it fails again, the product is disapproved and the manufacturer/supplier must improve the design and resubmit.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The product is disapproved immediately with no retest allowed', false, 0),
      (v_question_id, 'Two more samples are taken and tested; passing both means eligibility for type approval, while another failure means disapproval and a redesign/resubmission', true, 1),
      (v_question_id, 'The lot is simply relabeled as a routine test lot', false, 2),
      (v_question_id, 'The testing authority waives the requirement that failed', false, 3);
  END IF;

  -- 15. Routine test definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the Method of Sampling standard, what is required of a component or equipment under routine tests?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the Method of Sampling standard, what is required of a component or equipment under routine tests?', 'single_choice', 'easy', 'Sub-clause 3.2 states that each component or equipment shall be tested for routine tests, with the specific tests to be conducted as given in the relevant specification.', NULL, NULL, 'draft', false, NULL, true, 'PAES 103')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Only a random sample from the lot needs testing', false, 0),
      (v_question_id, 'Each and every component or equipment shall be tested, per the relevant specification', true, 1),
      (v_question_id, 'Only the first unit produced in a production run is tested', false, 2),
      (v_question_id, 'Routine tests are optional and left to the manufacturer''s discretion', false, 3);
  END IF;

  -- 16. PAES 138 definition of after-sales services
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Guidelines on After-Sales Service standard for agricultural machinery, how is "after-sales services" defined?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Guidelines on After-Sales Service standard for agricultural machinery, how is "after-sales services" defined?', 'single_choice', 'easy', 'Clause 2.1 defines after-sales services as consisting of parts and services provided by the manufacturers/distributors/dealers to the end-user to ensure continuous serviceability of agricultural machinery.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Parts and services provided by manufacturers/distributors/dealers to the end-user to ensure continuous serviceability of the machinery', true, 0),
      (v_question_id, 'Marketing promotions given to new buyers at the point of sale only', false, 1),
      (v_question_id, 'A one-time free inspection performed before the machine is delivered', false, 2),
      (v_question_id, 'Insurance coverage purchased separately by the end-user', false, 3);
  END IF;

  -- 17. PAES 138 warranty period
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Guidelines on After-Sales Service standard for agricultural machinery, within what period from purchase must a warranty against defective materials and workmanship be provided for brand new products?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Guidelines on After-Sales Service standard for agricultural machinery, within what period from purchase must a warranty against defective materials and workmanship be provided for brand new products?', 'single_choice', 'medium', 'Sub-clause 4.1.1 requires warranty against defective materials and workmanship for parts and services, except for normal wear and tear of expendable/consumable maintenance parts, within six months from the purchase of the machinery for brand new products; Table 1 restates this as "within six months from the purchase of agricultural machinery or 600 hours, whichever comes first."', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Three months from purchase', false, 0),
      (v_question_id, 'Six months from purchase, or 600 hours, whichever comes first', true, 1),
      (v_question_id, 'One year from purchase, or 1,000 hours, whichever comes first', false, 2),
      (v_question_id, 'No fixed period -- it is entirely at the dealer''s discretion', false, 3);
  END IF;

  -- 18. PAES 138 warranty exclusions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Guidelines on After-Sales Service standard for agricultural machinery, which of the following is NOT listed as a condition excluded from warranty coverage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Guidelines on After-Sales Service standard for agricultural machinery, which of the following is NOT listed as a condition excluded from warranty coverage?', 'single_choice', 'medium', 'Sub-clause 4.1.2 excludes damage from (a) accident or natural disaster, (b) improper operation and maintenance of the machine, and (c) unauthorized repair and/or use of non-genuine parts. "Failure during normal use and maintenance conditions" is, by contrast, exactly what the warranty is meant to cover, not an excluded condition.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Accident or natural disaster', false, 0),
      (v_question_id, 'Improper operation and maintenance of the machine', false, 1),
      (v_question_id, 'Unauthorized repair and/or use of non-genuine parts', false, 2),
      (v_question_id, 'Failure or damage from normal use and maintenance conditions', true, 3);
  END IF;

  -- 19. PAES 138 spare parts inventory requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Guidelines on After-Sales Service standard for agricultural machinery, what minimum spare-parts inventory must manufacturers/distributors/dealers maintain per product?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Guidelines on After-Sales Service standard for agricultural machinery, what minimum spare-parts inventory must manufacturers/distributors/dealers maintain per product?', 'single_choice', 'medium', 'Sub-clause 4.2.3 requires maintaining spare parts of at least 10% of their average past three-year sales per product to ensure adequate inventory of spare parts.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least 5% of their average past three-year sales per product', false, 0),
      (v_question_id, 'At least 10% of their average past three-year sales per product', true, 1),
      (v_question_id, 'At least 25% of their average past three-year sales per product', false, 2),
      (v_question_id, 'Exactly 1 unit of every part regardless of sales volume', false, 3);
  END IF;

  -- 20. PAES 138 Table 1 service mechanics by scale
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 1 (Minimum After-Sales Services Requirement) of the Guidelines on After-Sales Service standard for agricultural machinery, how many service mechanics must a large-scale manufacturer/distributor/dealer have at minimum?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 1 (Minimum After-Sales Services Requirement) of the Guidelines on After-Sales Service standard for agricultural machinery, how many service mechanics must a large-scale manufacturer/distributor/dealer have at minimum?', 'single_choice', 'medium', 'Table 1 specifies a minimum of 1 service mechanic for small scale, 2 for medium scale, and 3 for large scale manufacturers/distributors/dealers.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1', false, 0),
      (v_question_id, '2', false, 1),
      (v_question_id, '3', true, 2),
      (v_question_id, '5', false, 3);
  END IF;

  -- 21. PAES 138 Table 1 repair service area, medium scale
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 1 of the Guidelines on After-Sales Service standard for agricultural machinery, what minimum repair service area (in square meters) is required for a medium-scale manufacturer/distributor/dealer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 1 of the Guidelines on After-Sales Service standard for agricultural machinery, what minimum repair service area (in square meters) is required for a medium-scale manufacturer/distributor/dealer?', 'single_choice', 'medium', 'Table 1 lists a minimum repair service area of 20 m2 for small scale, 40 m2 for medium scale, and 60 m2 for large scale.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 m2', false, 0),
      (v_question_id, '40 m2', true, 1),
      (v_question_id, '60 m2', false, 2),
      (v_question_id, '100 m2', false, 3);
  END IF;

  -- 22. PAES 138 Annex A size classification rating
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Annex A (Rating Scheme for Size Classification) of the Guidelines on After-Sales Service standard for agricultural machinery, a manufacturer/distributor/dealer with a total points score greater than 7 is classified as which scale?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Annex A (Rating Scheme for Size Classification) of the Guidelines on After-Sales Service standard for agricultural machinery, a manufacturer/distributor/dealer with a total points score greater than 7 is classified as which scale?', 'single_choice', 'hard', 'Annex A''s rating scale classifies entities as: less than 4 points = small scale; 4 to 7 points = medium scale; greater than 7 points = large scale, with the total points score computed as the average of equivalent points across all nine rating parameters.', NULL, NULL, 'draft', false, NULL, true, 'PAES 138')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Small scale', false, 0),
      (v_question_id, 'Medium scale', false, 1),
      (v_question_id, 'Large scale', true, 2),
      (v_question_id, 'Micro scale', false, 3);
  END IF;

  -- 23. PNS/BAFS/PAES 192:2016 scope expansion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The 2016 revision of the Guidelines on After-Sales Service standard (which cancelled and replaced the earlier 2005 version) expanded the scope to explicitly cover which additional category of machinery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The 2016 revision of the Guidelines on After-Sales Service standard (which cancelled and replaced the earlier 2005 version) expanded the scope to explicitly cover which additional category of machinery?', 'single_choice', 'medium', 'PNS/BAFS/PAES 192:2016, titled "Agricultural and Fisheries Machinery -- Guidelines on After-Sales Service," specifies guidelines on after-sales service for agricultural AND fisheries machinery, expanding beyond the earlier standard''s agricultural-machinery-only scope, per its foreword citing the Agricultural and Fisheries Mechanization Law (RA 10601).', NULL, NULL, 'draft', false, NULL, true, 'PAES 192')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fisheries machinery', true, 0),
      (v_question_id, 'Construction machinery', false, 1),
      (v_question_id, 'Mining equipment', false, 2),
      (v_question_id, 'Household appliances', false, 3);
  END IF;

  -- 24. PNS/BAFS/PAES 192:2016 warranty period
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PNS/BAFS/PAES 192:2016 (Guidelines on After-Sales Service for agricultural and fisheries machinery), for how long, at minimum, must the warranty against defective materials and workmanship run from acceptance of the machinery by the procuring entity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PNS/BAFS/PAES 192:2016 (Guidelines on After-Sales Service for agricultural and fisheries machinery), for how long, at minimum, must the warranty against defective materials and workmanship run from acceptance of the machinery by the procuring entity?', 'single_choice', 'medium', 'Sub-clause 4.1.1 requires the warranty to run for at least one (1) year upon the acceptance of the procuring entity of the machinery -- longer than the six-months-or-600-hours warranty in the earlier 2004/2005 version of the standard.', NULL, NULL, 'draft', false, NULL, true, 'PAES 192')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Six (6) months', false, 0),
      (v_question_id, 'At least one (1) year', true, 1),
      (v_question_id, 'Two (2) years', false, 2),
      (v_question_id, 'Five (5) years', false, 3);
  END IF;

  -- 25. PNS/BAFS/PAES 192:2016 repair turnaround time
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PNS/BAFS/PAES 192:2016 (Guidelines on After-Sales Service for agricultural and fisheries machinery), within how many hours of receipt of a complaint must the repair of defective units and other after-sales services be undertaken?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PNS/BAFS/PAES 192:2016 (Guidelines on After-Sales Service for agricultural and fisheries machinery), within how many hours of receipt of a complaint must the repair of defective units and other after-sales services be undertaken?', 'single_choice', 'hard', 'Sub-clause 4.2.5 requires that repair of defective units and provision of other after-sales services shall be undertaken within 72 hours upon the receipt of complaints -- a specific turnaround requirement not present in the earlier 2004/2005 version.', NULL, NULL, 'draft', false, NULL, true, 'PAES 192')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 hours', false, 0),
      (v_question_id, '48 hours', false, 1),
      (v_question_id, '72 hours', true, 2),
      (v_question_id, '7 days (168 hours)', false, 3);
  END IF;

END $$;
