-- Auto-generated from supabase/seed/content/boardexampro-vol2-part1.json
-- Source reference: ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)
-- Idempotent: safe to re-run; skips topics/subtopics/questions that already exist.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Four-Wheel Tractors Methods of Test (POWER_ENERGY_MACHINERY) — 8 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Four-Wheel Tractors Methods of Test' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Four-Wheel Tractors Methods of Test', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During a power take-off performance test, the dynamometer registers an equivalent shaft torque of 320 N·m at the standard PTO speed of 540 rpm. What is the PTO power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'During a power take-off performance test, the dynamometer registers an equivalent shaft torque of 320 N·m at the standard PTO speed of 540 rpm. What is the PTO power?', 'single_choice', 'hard', 'P = 2πTN/60 = 2π(320 N·m)(540 rpm)/60 = 1,085,734/60 = 18,095.6 W = 18.10 kW', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.88 kW', false, 0),
      (v_question_id, '9.05 kW', false, 1),
      (v_question_id, '18.10 kW', true, 2),
      (v_question_id, '1,085.73 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The tractor in Item 1 consumes diesel at 6.2 L/h during the same test run. The fuel used has a density of 850 g/L. What is the specific fuel consumption?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The tractor in Item 1 consumes diesel at 6.2 L/h during the same test run. The fuel used has a density of 850 g/L. What is the specific fuel consumption?', 'single_choice', 'hard', 'SFC = (Fe × ρe)/P = (6.2 L/h)(850 g/L)/18.096 kW = 5,270 g/h / 18.096 kW = 291.2 g/kW·h', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.34 g/kW·h', false, 0),
      (v_question_id, '217.3 g/kW·h', false, 1),
      (v_question_id, '291.2 g/kW·h', true, 2),
      (v_question_id, '342.6 g/kW·h', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a drawbar power test on a ballasted four-wheel tractor, the dynamometer car registers a sustained pull of 12.5 kN while the tractor travels at a forward speed of 6.0 km/h. What is the drawbar power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a drawbar power test on a ballasted four-wheel tractor, the dynamometer car registers a sustained pull of 12.5 kN while the tractor travels at a forward speed of 6.0 km/h. What is the drawbar power?', 'single_choice', 'hard', 'Pe = FS/3.6 = (12.5 kN)(6.0 km/h)/3.6 = 75/3.6 = 20.83 kW', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.08 kW', false, 0),
      (v_question_id, '20.83 kW', true, 1),
      (v_question_id, '75.00 kW', false, 2),
      (v_question_id, '270.00 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hydraulic power test is conducted at the auxiliary service coupling of a four-wheel tractor whose relief valve pressure setting is 17.5 MPa. At the flow rate corresponding to the pressure required by the Standard, the measured delivery is 42 L/min. What is the hydraulic power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A hydraulic power test is conducted at the auxiliary service coupling of a four-wheel tractor whose relief valve pressure setting is 17.5 MPa. At the flow rate corresponding to the pressure required by the Standard, the measured delivery is 42 L/min. What is the hydraulic power?', 'single_choice', 'hard', 'Clause 7.2.3.c requires the hydraulic power to be reported at 90% of the actual relief valve pressure setting: Pv = 0.90(17.5 MPa) = 15.75 MPa; Q = 42 L/min ÷ 60 = 0.70 L/s; Ph = (15,750 kPa)(0.70 L/s)/1000 = 11.03 kW', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '11.03 kW', true, 0),
      (v_question_id, '12.25 kW', false, 1),
      (v_question_id, '661.50 kW', false, 2),
      (v_question_id, '735.00 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the maximum power test for the PTO, the tractor operates for two hours with the governor control set for maximum power at rated speed, and the reported maximum power is the average of the readings taken. Under what condition shall the test be repeated?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the maximum power test for the PTO, the tractor operates for two hours with the governor control set for maximum power at rated speed, and the reported maximum power is the average of the readings taken. Under what condition shall the test be repeated?', 'single_choice', 'easy', 'Clause 7.1.2: if the power variation deviates by more than 2% from the average, the test shall be repeated. A minimum of six readings taken at equal intervals is required within the two-hour test period.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The power variation deviates by more than 1% from the average', false, 0),
      (v_question_id, 'The power variation deviates by more than 2% from the average', true, 1),
      (v_question_id, 'The power variation deviates by more than 5% from the average', false, 2),
      (v_question_id, 'The power variation deviates by more than 10% from the average', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For wheeled tractors undergoing the drawbar power test, performance values up to what mean wheel slip shall be reported?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'For wheeled tractors undergoing the drawbar power test, performance values up to what mean wheel slip shall be reported?', 'single_choice', 'easy', 'Clause 7.3.1: for wheeled tractors, performance values of up to 15% mean wheel slip shall be reported, since non-slip distance varies with tire wear and must be checked regularly.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7%', false, 0),
      (v_question_id, '10%', false, 1),
      (v_question_id, '15%', true, 2),
      (v_question_id, '20%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following correctly describes the conditions required for the turning area and turning circle test?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following correctly describes the conditions required for the turning area and turning circle test?', 'single_choice', 'medium', 'Clause 7.7.1 requires measurements on a test track with the tractor unballasted and moving slowly at approximately 2 km/h. Under 7.7.2, tests are made turning both right and left without using the steering brakes; front-wheel-drive tractors are tested with the front-wheel drive disengaged.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The tractor is ballasted to its maximum mass and moves at approximately 2 km/h', false, 0),
      (v_question_id, 'The tractor is unballasted and moves at approximately 2 km/h', true, 1),
      (v_question_id, 'The tractor is unballasted and moves at approximately 10 km/h', false, 2),
      (v_question_id, 'The tractor is ballasted and the steering brakes are used to obtain the smallest radius', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the parking braking device test, the tractor is ballasted to its maximum weight and the force needed to hold it stationary facing up and down a slope is measured. What gradient is specified for this test?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the parking braking device test, the tractor is ballasted to its maximum weight and the force needed to hold it stationary facing up and down a slope is measured. What gradient is specified for this test?', 'single_choice', 'easy', 'Clause 7.8.3 requires the force needed to hold the tractor stationary facing up and down an 18% gradient to be measured, either on a sloping road or by applying a pull on a level road.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', false, 0),
      (v_question_id, '12%', false, 1),
      (v_question_id, '15%', false, 2),
      (v_question_id, '18%', true, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Philippine National Standards on After-Sales Service and Methods of Sampling (POWER_ENERGY_MACHINERY) — 18 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_after_sales uuid;
  v_sub_sampling uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'POWER_ENERGY_MACHINERY';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: POWER_ENERGY_MACHINERY';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Philippine National Standards on After-Sales Service and Methods of Sampling' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Philippine National Standards on After-Sales Service and Methods of Sampling', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_after_sales FROM public.subtopics WHERE name = 'After-Sales Service' AND topic_id = v_topic_id;
  IF v_sub_after_sales IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'After-Sales Service') RETURNING id INTO v_sub_after_sales;
  END IF;

  SELECT id INTO v_sub_sampling FROM public.subtopics WHERE name = 'Methods of Sampling' AND topic_id = v_topic_id;
  IF v_sub_sampling IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Methods of Sampling') RETURNING id INTO v_sub_sampling;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum warranty duration for agricultural and fishery machinery under PNS/BAFS 192:2024?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'What is the minimum warranty duration for agricultural and fishery machinery under PNS/BAFS 192:2024?', 'single_choice', 'easy', 'Clause 4.1.2 requires the warranty duration to be at least one year; the MFADDIE shall also issue a warranty certificate or card under Clause 4.1.1.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Six months', false, 0),
      (v_question_id, 'One year', true, 1),
      (v_question_id, 'Two years', false, 2),
      (v_question_id, 'Three years', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For machinery acquired through government procurement, when does the warranty period commence?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'For machinery acquired through government procurement, when does the warranty period commence?', 'single_choice', 'medium', 'Clause 4.1.2 distinguishes two modes: for government procurement, warranty commences upon acceptance by the procuring entity; for privately purchased machinery, upon receipt by the end-user.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Upon issuance of the notice to proceed', false, 0),
      (v_question_id, 'Upon delivery of the machinery to the project site', false, 1),
      (v_question_id, 'Upon acceptance of the machinery by the procuring entity', true, 2),
      (v_question_id, 'Upon receipt of the machinery by the end-user', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Warranty against defective materials and workmanship shall be provided for parts and services, except for which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'Warranty against defective materials and workmanship shall be provided for parts and services, except for which of the following?', 'single_choice', 'medium', 'Clause 4.1.3 excludes normal wear and tear of expendable or consumable maintenance parts such as belts, tires, hoses, filters, and electric parts, since these are consumed in ordinary operation.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Normal wear and tear of expendable or consumable maintenance parts', true, 0),
      (v_question_id, 'Defective castings discovered during the warranty period', false, 1),
      (v_question_id, 'Workmanship defects in welded frames', false, 2),
      (v_question_id, 'Parts that failed under normal operating load', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'All of the following conditions void warranty coverage under PNS/BAFS 192:2024 EXCEPT:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'All of the following conditions void warranty coverage under PNS/BAFS 192:2024 EXCEPT:', 'single_choice', 'medium', 'Clause 4.1.6: the warranty covers only failure or damages arising from normal use and maintenance conditions. Exclusions are accident, acts of violence/natural disaster; improper storage/operation/maintenance; negligent handling/transportation/excessive load; unsuitable operating materials; and unauthorized major repair or non-genuine parts.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Use of unsuitable operating materials', false, 0),
      (v_question_id, 'Failure occurring under normal use and maintenance conditions', true, 1),
      (v_question_id, 'Unauthorized major repair using non-genuine parts', false, 2),
      (v_question_id, 'Negligent handling, transportation, and excessive load', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The terms of the warranty issued by the MFADDIE shall comply with which legal provision?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'The terms of the warranty issued by the MFADDIE shall comply with which legal provision?', 'single_choice', 'easy', 'Clause 4.1.5 requires warranty terms to comply with Article 68 of RA No. 7394, in clear and understandable language, identifying the warrantor, covered components, resolution process, and period.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Article 68 of RA No. 7394 (Consumer Act of the Philippines)', true, 0),
      (v_question_id, 'Section 32 of RA No. 10601 (AFMech Law)', false, 1),
      (v_question_id, 'Rule 21.2 of the IRR of RA No. 10601', false, 2),
      (v_question_id, 'RA No. 9184 (Government Procurement Reform Act)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A procuring entity may claim replacement or refund of a machine still under warranty if it experiences recurring technical problems of what frequency after repair by authorized technicians?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'A procuring entity may claim replacement or refund of a machine still under warranty if it experiences recurring technical problems of what frequency after repair by authorized technicians?', 'single_choice', 'medium', 'Clause 4.3.1 allows replacement/refund for a defective unit found on delivery, or for recurring technical problems more than three times within a week interval after repair by authorized technicians (Clause 4.3.2, per Section 32 of RA No. 10601).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'More than two times within a one-month interval', false, 0),
      (v_question_id, 'More than three times within a week interval', true, 1),
      (v_question_id, 'More than five times within the warranty period', false, 2),
      (v_question_id, 'Any single recurrence after the first authorized repair', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The MFADDIE and its accredited service center shall maintain a stock level of spare parts equivalent to at least what proportion of their average past three-year sales per product line?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'The MFADDIE and its accredited service center shall maintain a stock level of spare parts equivalent to at least what proportion of their average past three-year sales per product line?', 'single_choice', 'easy', 'Clause 4.2.2.b requires a spare parts stock level of at least 10% of average past three-year sales per product line, to ensure adequate inventory of fast-moving parts.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5%', false, 0),
      (v_question_id, '10%', true, 1),
      (v_question_id, '15%', false, 2),
      (v_question_id, '20%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Within what period upon receipt of a complaint or request shall the MFADDIE provide after-sales service, whether through virtual customer service, repair, or replacement of parts?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'Within what period upon receipt of a complaint or request shall the MFADDIE provide after-sales service, whether through virtual customer service, repair, or replacement of parts?', 'single_choice', 'easy', 'Clause 4.2.2.c requires after-sales services to be provided within three working days of receipt of complaints or requests, whether via virtual customer service, or repair/replacement of parts.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Twenty-four hours', false, 0),
      (v_question_id, 'Three working days', true, 1),
      (v_question_id, 'Five working days', false, 2),
      (v_question_id, 'Seven calendar days', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For imported machines, the brand should have an inventory or be in existence in the Philippine market for at least how many years with a good track record?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'For imported machines, the brand should have an inventory or be in existence in the Philippine market for at least how many years with a good track record?', 'single_choice', 'easy', 'Clause 4.2.1.a: for imported machines, the brand shall have an inventory or be in existence in the Philippine market for at least ten years with a good track record; this may be waived for localized/new-emerging-technology machines that comply with applicable standards.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Three years', false, 0),
      (v_question_id, 'Five years', false, 1),
      (v_question_id, 'Ten years', true, 2),
      (v_question_id, 'Fifteen years', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Upon request of the procuring entity or end-user, how many maintenance visits should be provided within the warranty period?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_after_sales, 'Upon request of the procuring entity or end-user, how many maintenance visits should be provided within the warranty period?', 'single_choice', 'easy', 'Clause 4.2.1.c lists provision of at least two maintenance visits, upon request, within the warranty period, among the considerations when purchasing agricultural and fishery machinery.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least one', false, 0),
      (v_question_id, 'At least two', true, 1),
      (v_question_id, 'At least three', false, 2),
      (v_question_id, 'At least four', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PNS/BAFS 391:2024 prescribes sampling procedures for conformity purposes. Which of the following is expressly excepted from its scope?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'PNS/BAFS 391:2024 prescribes sampling procedures for conformity purposes. Which of the following is expressly excepted from its scope?', 'single_choice', 'medium', 'Clause 1 applies the Standard to sampling for conformity (AMTEC testing, ATC testing, field test, acceptance test), except system test, since a system test validates several complete integrated machines/facilities and a lot-based sampling scheme does not apply to it.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Field test', false, 0),
      (v_question_id, 'Acceptance test', false, 1),
      (v_question_id, 'System test', true, 2),
      (v_question_id, 'Accredited Testing Center (ATC) test', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which term refers to a defined quantity of machines of the same model, size, and design, manufactured from the same batch and materials, and categorized as a group?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'Which term refers to a defined quantity of machines of the same model, size, and design, manufactured from the same batch and materials, and categorized as a group?', 'single_choice', 'easy', 'Clause 3.3 defines a lot as a defined quantity of machines of the same model, size, and design, manufactured from the same batch and materials. The lot size, N, is the entry point into Table 1 for determining sample size.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Lot', true, 0),
      (v_question_id, 'Sample', false, 1),
      (v_question_id, 'Sub-sample', false, 2),
      (v_question_id, 'Consignment', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A production lot of 250 units of a mechanical rice transplanter is submitted for testing. Based on the PNS/BAFS 391:2024, what is the sample size and permissible number of defectives for the visual and dimensional test?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'A production lot of 250 units of a mechanical rice transplanter is submitted for testing. Based on the PNS/BAFS 391:2024, what is the sample size and permissible number of defectives for the visual and dimensional test?', 'single_choice', 'medium', 'A lot size of 250 falls within the 101-300 bracket of Table 1, giving a sample size of 13 units and one permissible defective for the visual and dimensional test; under Clause 5.1.2 the lot conforms if defectives in the sample do not exceed this figure.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'n = 3, with 0 permissible defectives', false, 0),
      (v_question_id, 'n = 13, with 0 permissible defectives', false, 1),
      (v_question_id, 'n = 13, with 1 permissible defective', true, 2),
      (v_question_id, 'n = 32, with 3 permissible defectives', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 100 units is to be sampled for visual and dimensional testing. What is the value of r?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'A lot of 100 units is to be sampled for visual and dimensional testing. What is the value of r?', 'single_choice', 'hard', 'Given: N = 100 units; from Table 1, lot sizes 51-100 require a visual/dimensional sample size of n = 5. Solution: r = N/n = 100/5 = 20. A number z is drawn at random from 1 to r; the unit corresponding to z becomes the first sample, and every rth unit thereafter is withdrawn until the required sample size is obtained.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5', false, 0),
      (v_question_id, '7.7', false, 1),
      (v_question_id, '20', true, 2),
      (v_question_id, '50', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of 800 units is submitted for testing. What is the sample size and permissible number of defectives for the laboratory and performance test?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'A lot of 800 units is submitted for testing. What is the sample size and permissible number of defectives for the laboratory and performance test?', 'single_choice', 'medium', 'A lot size of 800 falls within the 501-1000 bracket of Table 1; the laboratory and performance test sample size is 8 units with one permissible defective — the first bracket at which the performance test permits any defective at all.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'n = 8, with 0 permissible defectives', false, 0),
      (v_question_id, 'n = 8, with 1 permissible defective', true, 1),
      (v_question_id, 'n = 13, with 1 permissible defective', false, 2),
      (v_question_id, 'n = 50, with 5 permissible defectives', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the visual and dimensional test, when is a machine in the sample considered defective?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'In the visual and dimensional test, when is a machine in the sample considered defective?', 'single_choice', 'easy', 'Clause 5.1.1: machines failing to satisfy at least one of the specification requirements shall be considered defective. Clause 5.2.2 applies the same single-failure rule to the laboratory and performance test.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'When it fails to satisfy at least one of the specification requirements', true, 0),
      (v_question_id, 'When it fails to satisfy the majority of the specification requirements', false, 1),
      (v_question_id, 'When it fails to satisfy all of the specification requirements', false, 2),
      (v_question_id, 'When it fails any requirement that the test applicant has declared critical', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Where is the sub-sample for the laboratory and performance test drawn from?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'Where is the sub-sample for the laboratory and performance test drawn from?', 'single_choice', 'medium', 'Clause 5.2.1: if the lot conforms to the visual and dimensional requirements, a sub-sample (sized per column 4 of Table 1) shall be taken at random from the machines already selected in Clause 5.1, and tested for characteristics other than visual/dimensional ones.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At random from the entire lot, independently of the earlier sample', false, 0),
      (v_question_id, 'At random from the machines already selected for the visual and dimensional test', true, 1),
      (v_question_id, 'At random from the units remaining in the lot after the first sample was withdrawn', false, 2),
      (v_question_id, 'From the units the test applicant nominates as representative', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the additional requirements for AMTEC and ATC testing, who selects the test sample and on what basis?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_sampling, 'Under the additional requirements for AMTEC and ATC testing, who selects the test sample and on what basis?', 'single_choice', 'medium', 'Clause 5.3.2 requires the test sample to be selected using any applicable procedure in Clause 4, by the testing authority with the agreement of the test applicant. Clause 5.3.1 obliges the applicant to furnish all serial numbers of identical brand/model machines in their warehouse, and Clause 5.3.3 requires the selected sample to comply with all declared specification requirements before it is eligible for testing.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The test applicant, subject to confirmation by the testing authority', false, 0),
      (v_question_id, 'The testing authority, with the agreement of the test applicant', true, 1),
      (v_question_id, 'The procuring entity, from units already delivered', false, 2),
      (v_question_id, 'The manufacturer, from the current production run', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Agricultural Machinery, Power Units, and Workshop Management (POWER_ENERGY_MACHINERY) — 17 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_field_capacity uuid;
  v_sub_housekeeping uuid;
  v_sub_troubleshooting uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'POWER_ENERGY_MACHINERY';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: POWER_ENERGY_MACHINERY';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Machinery, Power Units, and Workshop Management' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Machinery, Power Units, and Workshop Management', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_field_capacity FROM public.subtopics WHERE name = 'Agricultural Power and Field Capacity' AND topic_id = v_topic_id;
  IF v_sub_field_capacity IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Agricultural Power and Field Capacity') RETURNING id INTO v_sub_field_capacity;
  END IF;

  SELECT id INTO v_sub_housekeeping FROM public.subtopics WHERE name = '5S Housekeeping System' AND topic_id = v_topic_id;
  IF v_sub_housekeeping IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, '5S Housekeeping System') RETURNING id INTO v_sub_housekeeping;
  END IF;

  SELECT id INTO v_sub_troubleshooting FROM public.subtopics WHERE name = 'Engine Troubleshooting' AND topic_id = v_topic_id;
  IF v_sub_troubleshooting IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Engine Troubleshooting') RETURNING id INTO v_sub_troubleshooting;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A six-cylinder engine has a bore of 85 mm and a stroke of 90 mm. What is the total piston displacement of the engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_field_capacity, 'A six-cylinder engine has a bore of 85 mm and a stroke of 90 mm. What is the total piston displacement of the engine?', 'single_choice', 'hard', 'PD = (πd²/4) × L × N = [π(8.5 cm)²/4] × 9.0 cm × 6 = 56.745 cm² × 9.0 cm = 3,064.2 cm³', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '510.7 cm³', false, 0),
      (v_question_id, '3,064.2 cm³', true, 1),
      (v_question_id, '3,244.5 cm³', false, 2),
      (v_question_id, '12,256.9 cm³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engine cylinder has a piston displacement of 45 in³ and operates at a compression ratio of 9.5. What is the clearance volume of the cylinder?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_field_capacity, 'An engine cylinder has a piston displacement of 45 in³ and operates at a compression ratio of 9.5. What is the clearance volume of the cylinder?', 'single_choice', 'hard', 'CR = (PD + CV)/CV → 9.5 CV = 45 + CV → 8.5 CV = 45 → CV = 45/8.5 = 5.29 in³', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.29 in³', false, 0),
      (v_question_id, '4.74 in³', false, 1),
      (v_question_id, '5.29 in³', true, 2),
      (v_question_id, '5.63 in³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A single-cylinder, four-stroke cycle engine delivers a brake power of 75 kW at a mechanical efficiency of 84%. What is the indicated power of the engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_field_capacity, 'A single-cylinder, four-stroke cycle engine delivers a brake power of 75 kW at a mechanical efficiency of 84%. What is the indicated power of the engine?', 'single_choice', 'medium', 'ME = BP/IP → IP = BP/ME = 75 kW/0.84 = 89.29 kW', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12.00 kW', false, 0),
      (v_question_id, '14.29 kW', false, 1),
      (v_question_id, '63.00 kW', false, 2),
      (v_question_id, '89.29 kW', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using the engine in Item 3, the crankshaft speed is 400 rpm and the mean effective pressure is 760 kPa. If the engine is square (bore equals stroke), what is the bore of the cylinder?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_field_capacity, 'Using the engine in Item 3, the crankshaft speed is 400 rpm and the mean effective pressure is 760 kPa. If the engine is square (bore equals stroke), what is the bore of the cylinder?', 'single_choice', 'hard', 'For a four-stroke cycle, n = 400/(60×2) = 3.3333 power strokes/s. L×A = IP/(P×n) = 89.29 kW/(760 kPa × 3.3333/s) = 0.035245 m³. Since L=D and A=πD²/4: πD³/4 = 0.035245 → D³ = 0.044875 m³ → D = 0.3552 m = 35.5 cm', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '28.2 cm', false, 0),
      (v_question_id, '33.5 cm', false, 1),
      (v_question_id, '35.5 cm', true, 2),
      (v_question_id, '44.8 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farmer plows 8 hectares in 9.5 hours using a four-bottom, 41-cm moldboard plow operating at a forward speed of 6.5 km/hr. What is the field efficiency of the operation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_field_capacity, 'A farmer plows 8 hectares in 9.5 hours using a four-bottom, 41-cm moldboard plow operating at a forward speed of 6.5 km/hr. What is the field efficiency of the operation?', 'single_choice', 'medium', 'TFC = S×W = (6,500 m/hr)(1.64 m) = 1.066 ha/hr; EFC = 8 ha/9.5 hr = 0.8421 ha/hr; FE = EFC/TFC = 0.8421/1.066 = 0.7900 or 79.0%', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '79.0%', true, 0),
      (v_question_id, '84.2%', false, 1),
      (v_question_id, '106.6%', false, 2),
      (v_question_id, '126.6%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the plowing operation in Item 5, the measured draft is 15 kN. What is the drawbar power developed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_field_capacity, 'For the plowing operation in Item 5, the measured draft is 15 kN. What is the drawbar power developed?', 'single_choice', 'medium', 'S = 6.5 km/hr ÷ 3.6 = 1.8056 m/s; DP = F×S = (15 kN)(1.8056 m/s) = 27.08 ≈ 27.1 kW', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '21.4 kW', false, 0),
      (v_question_id, '27.1 kW', true, 1),
      (v_question_id, '36.3 kW', false, 2),
      (v_question_id, '97.5 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the 5S principles refers to eliminating anything that is unnecessary for the equipment to work properly?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_housekeeping, 'Which of the 5S principles refers to eliminating anything that is unnecessary for the equipment to work properly?', 'single_choice', 'easy', 'Seiri (Sort) means eliminating anything unnecessary for the equipment to work properly; its neglect makes needed items hard to find and increases maintenance cost.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Seiri', true, 0),
      (v_question_id, 'Seiton', false, 1),
      (v_question_id, 'Seiso', false, 2),
      (v_question_id, 'Seiketsu', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The principle "a place for everything and everything in its place" is the guiding statement of which S?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_housekeeping, 'The principle "a place for everything and everything in its place" is the guiding statement of which S?', 'single_choice', 'easy', 'Seiton eliminates pointless searching by identifying a fixed place for each item, arranged from most used to least used, with labels signifying where materials belong.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Seiri (Sort)', false, 0),
      (v_question_id, 'Seiton (Straightening)', true, 1),
      (v_question_id, 'Seiketsu (Standardize)', false, 2),
      (v_question_id, 'Shitsuke (Sustain)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the red tag technique, items whose necessity is doubtful are placed in the red tag area to allow staff to reevaluate them. How long should these wavering items be held before disposal is decided?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_housekeeping, 'Under the red tag technique, items whose necessity is doubtful are placed in the red tag area to allow staff to reevaluate them. How long should these wavering items be held before disposal is decided?', 'single_choice', 'easy', 'Wavering items are placed in the red tag area for one week; at the end of the week, items found to be needed are returned to their owners.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One day', false, 0),
      (v_question_id, 'One week', true, 1),
      (v_question_id, 'One month', false, 2),
      (v_question_id, 'Three months', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The litmus test for a properly implemented 5S program states that any needed item, including electronic records, must be located within what maximum period?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_housekeeping, 'The litmus test for a properly implemented 5S program states that any needed item, including electronic records, must be located within what maximum period?', 'single_choice', 'easy', 'The 30-second rule: if 5S is properly implemented, any required item, including electronic records, must be locatable within 30 seconds.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15 seconds', false, 0),
      (v_question_id, '30 seconds', true, 1),
      (v_question_id, '60 seconds', false, 2),
      (v_question_id, '5 minutes', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Seiketsu emphasizes keeping the four M''s intact, since a lapse in any one of them causes the loss of the remaining three. Which of the following is one of these four M''s?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_housekeeping, 'Seiketsu emphasizes keeping the four M''s intact, since a lapse in any one of them causes the loss of the remaining three. Which of the following is one of these four M''s?', 'single_choice', 'easy', 'Seiketsu requires keeping the four M''s intact: Man, Machine, Material, and Method. A lapse in any one causes the loss of the remaining three.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Money', false, 0),
      (v_question_id, 'Measurement', false, 1),
      (v_question_id, 'Method', true, 2),
      (v_question_id, 'Management', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In Shitsuke, the situation is evaluated through an in-depth audit based on a precise questionnaire that assesses the previous 4S and may lead to site certification. After what period is this audit conducted?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_housekeeping, 'In Shitsuke, the situation is evaluated through an in-depth audit based on a precise questionnaire that assesses the previous 4S and may lead to site certification. After what period is this audit conducted?', 'single_choice', 'easy', 'Under Shitsuke, after 3 to 6 months (depending on workshop size/complexity), the situation is evaluated by an in-depth audit assessing the previous 4S, which if successful leads to site certification.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 to 2 months', false, 0),
      (v_question_id, '3 to 6 months', true, 1),
      (v_question_id, '6 to 12 months', false, 2),
      (v_question_id, '12 to 24 months', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An operator reports that a diesel engine emits blue-white exhaust gas during operation. Which of the following is the most likely cause?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_troubleshooting, 'An operator reports that a diesel engine emits blue-white exhaust gas during operation. Which of the following is the most likely cause?', 'single_choice', 'medium', 'White or blue exhaust gas indicates lubricating oil entering the combustion chamber and burning; causes include excessive engine oil, worn/stuck piston rings and liner, incorrect injection timing, and deficient compression.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Overloading of the engine', false, 0),
      (v_question_id, 'Use of low-grade fuel', false, 1),
      (v_question_id, 'Worn or stuck piston rings and liner', true, 2),
      (v_question_id, 'Clogged air cleaner', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor engine discharges black to dark gray exhaust gas under normal field load. Which condition best explains this observation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_troubleshooting, 'A tractor engine discharges black to dark gray exhaust gas under normal field load. Which condition best explains this observation?', 'single_choice', 'medium', 'Black or dark gray exhaust indicates incomplete combustion from an improper air-fuel ratio or excessive fueling; causes include overload, low-grade fuel, a clogged fuel filter, and a clogged air cleaner.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Excessive engine oil entering the combustion chamber', false, 0),
      (v_question_id, 'Clogged fuel filter or air cleaner', true, 1),
      (v_question_id, 'Deficient compression in the cylinder', false, 2),
      (v_question_id, 'Loose battery terminals', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'All of the following are recognized causes of engine overheating EXCEPT:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_troubleshooting, 'All of the following are recognized causes of engine overheating EXCEPT:', 'single_choice', 'medium', 'Recognized causes of engine overheating are an elongated/damaged fan belt, low water level in the radiator, a closed radiator shutter, an improperly adjusted carburetor/diesel injection system, the wrong grade of lubricating oil, and overloading.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fan belt elongated or damaged', false, 0),
      (v_question_id, 'Radiator shutter closed', false, 1),
      (v_question_id, 'Wrong grade of oil used in lubrication', false, 2),
      (v_question_id, 'Fuel tank empty', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engine produces a distinct knocking sound during operation. Which of the following is a recognized cause of engine knock?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_troubleshooting, 'An engine produces a distinct knocking sound during operation. Which of the following is a recognized cause of engine knock?', 'single_choice', 'medium', 'Engine knock results from combustion at the wrong point in the cycle; causes include an overheated engine, spark timing or fuel injection too far advanced, a carburetor set too lean, excessive carbon deposit, and incorrect fuel/spark plug type.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Spark timing or fuel injection too far advanced', true, 0),
      (v_question_id, 'Loose battery terminals', false, 1),
      (v_question_id, 'Air in the fuel system', false, 2),
      (v_question_id, 'Low water level in the radiator', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A mechanic observes that an engine consumes an abnormally large volume of lubricating oil. Which of the following is a cause of excessive oil consumption rather than excessive fuel consumption?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_troubleshooting, 'A mechanic observes that an engine consumes an abnormally large volume of lubricating oil. Which of the following is a cause of excessive oil consumption rather than excessive fuel consumption?', 'single_choice', 'medium', 'Excessive oil consumption is traced to the wrong grade of oil, excessive engine temperature, piston rings whose gaps face the same direction (forming a continuous path for oil into the combustion chamber), a worn/stuck oil ring, worn piston ring groove, worn piston/liner, and worn crankshaft bearing/connecting rod.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fuel line leaks', false, 0),
      (v_question_id, 'Carburetor adjusted too rich', false, 1),
      (v_question_id, 'Piston rings'' gaps facing the same direction', true, 2),
      (v_question_id, 'Dirty air cleaner', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Agricultural Project Planning and Analysis (PROJECT_MGMT_RDE) — 9 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'PROJECT_MGMT_RDE';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: PROJECT_MGMT_RDE';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Project Planning and Analysis' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Project Planning and Analysis', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An independent team is convened after the detailed project report is completed. The team re-examines the technical, institutional, commercial, financial, economic, and social soundness of the proposal, and may recommend that further preparation work be done because certain assumptions appear faulty. Which stage of the project cycle is being described?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An independent team is convened after the detailed project report is completed. The team re-examines the technical, institutional, commercial, financial, economic, and social soundness of the proposal, and may recommend that further preparation work be done because certain assumptions appear faulty. Which stage of the project cycle is being described?', 'single_choice', 'medium', 'Appraisal is the critical review by an independent team after preparation is complete and before approval; it re-examines every module for feasibility/soundness/appropriateness and outputs a decision to approve, reject, or send back for further preparation (ex-ante analysis).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Identification', false, 0),
      (v_question_id, 'Preparation', false, 1),
      (v_question_id, 'Appraisal', true, 2),
      (v_question_id, 'Evaluation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A solar bubble dryer investment is expected to generate an incremental net benefit at the end of Year 4. Compute the present value of that benefit at the stated discount rate.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A solar bubble dryer investment is expected to generate an incremental net benefit at the end of Year 4. Compute the present value of that benefit at the stated discount rate.', 'single_choice', 'hard', 'Given: B4 = PHP 250,000; r = 12%/year; base year = Year 0. DF = 1/(1.12)^4 = 1/1.5735 = 0.6355; PV = 250,000 × 0.6355 = PHP 158,879.52 ≈ PHP 158,880', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PHP 158,880', true, 0),
      (v_question_id, 'PHP 168,919', false, 1),
      (v_question_id, 'PHP 177,945', false, 2),
      (v_question_id, 'PHP 393,380', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Evaluate the financial worth of a small mechanized drying facility using the net present value criterion, and state whether the investment should be accepted.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Evaluate the financial worth of a small mechanized drying facility using the net present value criterion, and state whether the investment should be accepted.', 'single_choice', 'hard', 'Given: Initial investment (Year 0) = PHP 500,000; incremental net benefits Year 1-3 = 150,000/250,000/300,000; r = 10%. PV of benefits = 136,363.64+206,611.57+225,394.44 = 568,369.65; NPV = 568,369.65 − 500,000 = PHP 68,370 (>0, therefore accept).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PHP 68,370; accept the project', true, 0),
      (v_question_id, 'PHP 113,824; accept the project', false, 1),
      (v_question_id, 'PHP 200,000; accept the project', false, 2),
      (v_question_id, 'PHP 568,370; accept the project', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rural farm-to-market road project has the cost and benefit streams shown. Compute the benefit-cost ratio and apply the selection principle.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A rural farm-to-market road project has the cost and benefit streams shown. Compute the benefit-cost ratio and apply the selection principle.', 'single_choice', 'hard', 'Given: Cost Year0=800,000, Year1=200,000; Gross benefit Year1=400,000, Year2=600,000, Year3=500,000; r=10%. PV of benefits = 363,636.36+495,867.77+375,657.40 = 1,235,161.53; PV of costs = 800,000+181,818.18 = 981,818.18; B/C = 1,235,161.53/981,818.18 = 1.258 ≈ 1.26 (>1, therefore accept).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.79; reject the project', false, 0),
      (v_question_id, '1.26; accept the project', true, 1),
      (v_question_id, '1.50; accept the project', false, 2),
      (v_question_id, '0.26; reject the project', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During appraisal of an irrigation project, the analyst computes the net present value at two trial discount rates. Estimate the internal rate of return by linear interpolation.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'During appraisal of an irrigation project, the analyst computes the net present value at two trial discount rates. Estimate the internal rate of return by linear interpolation.', 'single_choice', 'hard', 'Given: at r=12%, NPV=+84,000; at r=16%, NPV=−28,000; STP rate=10%. IRR ≈ rL + (rh−rL)×[NPVL/(NPVL+|NPVh|)] = 12% + (4×0.75) = 12%+3.0% = 15.0% (IRR>STP, therefore accept).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '13.0%', false, 0),
      (v_question_id, '14.0%', false, 1),
      (v_question_id, '15.0%', true, 2),
      (v_question_id, '16.0%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A proposed grain terminal will pay PHP 1.2 million in import duties on machinery, PHP 800,000 in loan interest, and has already absorbed PHP 400,000 in a completed feasibility study. In converting the financial accounts into economic accounts, how should these three amounts be treated?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A proposed grain terminal will pay PHP 1.2 million in import duties on machinery, PHP 800,000 in loan interest, and has already absorbed PHP 400,000 in a completed feasibility study. In converting the financial accounts into economic accounts, how should these three amounts be treated?', 'single_choice', 'medium', 'Taxes/duties/tariffs and debt service (interest and principal) are transfer payments in economic analysis, excluded because they shift income within the economy without consuming real resources. Sunk costs (the completed feasibility study) are excluded on a separate ground, since cost-benefit analysis compares only future returns against future costs.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'All three are excluded; duties and interest are transfer payments and the study is a sunk cost', true, 0),
      (v_question_id, 'All three are retained as economic costs because they are real cash outflows', false, 1),
      (v_question_id, 'Duties and interest are retained; only the feasibility study is excluded', false, 2),
      (v_question_id, 'Only the import duties are excluded; interest and the study remain economic costs', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A research activity in an agricultural R&D project has uncertain duration, so the planner applies the three-time probabilistic model. Compute the expected activity duration.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A research activity in an agricultural R&D project has uncertain duration, so the planner applies the three-time probabilistic model. Compute the expected activity duration.', 'single_choice', 'hard', 'Given: to=6 days, tm=10 days, tp=20 days. te = (to+4tm+tp)/6 = (6+40+20)/6 = 66/6 = 11 days. PERT weights the most likely estimate four times and each extreme once, for research with a range of durations; CPM by contrast is deterministic.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 days', false, 0),
      (v_question_id, '11 days', true, 1),
      (v_question_id, '12 days', false, 2),
      (v_question_id, '16 days', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An appraised watershed rehabilitation project shows the discounted streams below. Determine the switching value for gross benefits.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An appraised watershed rehabilitation project shows the discounted streams below. Determine the switching value for gross benefits.', 'single_choice', 'hard', 'Given: PV of gross benefits = PHP 8.4 million; PV of gross costs = PHP 7.0 million; discount rate held constant. NPV = 8.4−7.0 = PHP 1.4 million; acceptability limit is where NPV=0; switching value = NPV/PV of benefits × 100 = (1.4/8.4)×100 = 16.67% ≈ 16.7%. A switching value shows how far one element must move unfavorably before the project no longer meets minimum acceptability.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '14.0%', false, 0),
      (v_question_id, '16.7%', true, 1),
      (v_question_id, '20.0%', false, 2),
      (v_question_id, '83.3%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A parcel of agricultural land currently planted to maize is to be converted into a public grains terminal. The land has a quoted market price, but the region''s land market is thin and distorted by a long-standing land use restriction. For the economic analysis, how should the land be valued?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A parcel of agricultural land currently planted to maize is to be converted into a public grains terminal. The land has a quoted market price, but the region''s land market is thin and distorted by a long-standing land use restriction. For the economic analysis, how should the land be valued?', 'single_choice', 'medium', 'Economic analysis values inputs at their opportunity cost. For land withdrawn from maize production, that value is the discounted stream of net output forgone — a shadow price used because the market price diverges from true economic value due to market failure/distortion.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At its quoted market price, since that is the price actually paid by the proponent', false, 0),
      (v_question_id, 'At the discounted net output forgone from continued maize production', true, 1),
      (v_question_id, 'At zero, since the land is already owned by the implementing agency', false, 2),
      (v_question_id, 'At its replacement cost plus the transfer taxes payable on the sale', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment (POWER_ENERGY_MACHINERY) — 11 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In this type of gasifier bed, the biomass feedstock is gasified as it gradually moves down the reactor and is fed in as the char is discharged. It gives a lesser power output because of its limited capacity, but permits continuous operation. Which type of bed is described?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In this type of gasifier bed, the biomass feedstock is gasified as it gradually moves down the reactor and is fed in as the char is discharged. It gives a lesser power output because of its limited capacity, but permits continuous operation. Which type of bed is described?', 'single_choice', 'medium', 'Fixed bed: fuel bed held stationary, batch loading/unloading, not continuous. Fluidized bed: feedstock moves in a stream with inert gases, needs accurate feeding and close temperature control. Entrained-flow bed is not among the three bed types (fixed, moving, fluidized) recognized in the Technical Bulletin.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fixed bed', false, 0),
      (v_question_id, 'Fluidized bed', false, 1),
      (v_question_id, 'Moving bed', true, 2),
      (v_question_id, 'Entrained-flow bed', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A designer must supply producer gas directly to an internal combustion engine and therefore wants the gas produced with the lowest tar content. Which mode of gasification should be specified?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A designer must supply producer gas directly to an internal combustion engine and therefore wants the gas produced with the lowest tar content. Which mode of gasification should be specified?', 'single_choice', 'medium', 'Updraft: air passes upward, producing large amounts of tar/smoke requiring thorough cleaning. Cross draft: air introduced perpendicular to the fire zone, unpredictable gas production. Semi-continuous is a mode of operation, not of gasification.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Downdraft', true, 0),
      (v_question_id, 'Updraft', false, 1),
      (v_question_id, 'Cross draft', false, 2),
      (v_question_id, 'Semi-continuous', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which location of fuel ignition is effective for a continuous-type moving-bed gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which location of fuel ignition is effective for a continuous-type moving-bed gasifier?', 'single_choice', 'medium', 'Top lit is effective for the downdraft-type gasifier (less tar/smoke) but not prescribed for continuous-type moving bed. Side lit is not a recognized ignition location. Ignition location does affect performance (tar/smoke production and suitability for continuous operation).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Top lit', false, 0),
      (v_question_id, 'Bottom lit', true, 1),
      (v_question_id, 'Side lit', false, 2),
      (v_question_id, 'Any of the above; ignition location has no effect', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biomass gasifier is being designed to drive a rice mill with a brake power requirement of 20 hp. The parasitic loads are a fan at 2 hp, a blower at 2 hp, a conveyor at 1.5 hp, and an elevator at 3 hp. What is the design power required for the engine drive?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A biomass gasifier is being designed to drive a rice mill with a brake power requirement of 20 hp. The parasitic loads are a fan at 2 hp, a blower at 2 hp, a conveyor at 1.5 hp, and an elevator at 3 hp. What is the design power required for the engine drive?', 'single_choice', 'hard', 'Pd = Pm + Pp = 20 hp + (2+2+1.5+3) hp = 20 + 8.5 = 28.5 hp. This computed design power is carried into the next computation, though in practice the next higher rated engine (e.g. 30 hp) would be purchased.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20.0 hp', false, 0),
      (v_question_id, '22.5 hp', false, 1),
      (v_question_id, '25.0 hp', false, 2),
      (v_question_id, '28.5 hp', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using a 30 hp design power, a brake thermal efficiency of 30 percent, and a transmission efficiency of 80 percent, what is the required engine power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Using a 30 hp design power, a brake thermal efficiency of 30 percent, and a transmission efficiency of 80 percent, what is the required engine power?', 'single_choice', 'hard', 'Pe = Pd/(ξbt × ξt) = 30 hp/(0.30×0.80) = 30/0.24 = 125 hp. 30% brake thermal efficiency falls within the 30-40% range for a compression ignition engine, while 80% transmission efficiency corresponds to a belt drive (80-85%).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '37.5 hp', false, 0),
      (v_question_id, '100 hp', false, 1),
      (v_question_id, '125 hp', true, 2),
      (v_question_id, '150 hp', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The engine power required is 125 hp and the heating value of the producer gas is 1,000 kcal/m³. Using 0.746 kW/hp and 0.0012 kW per kcal/hr, what is the engine piston displacement rate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The engine power required is 125 hp and the heating value of the producer gas is 1,000 kcal/m³. Using 0.746 kW/hp and 0.0012 kW per kcal/hr, what is the engine piston displacement rate?', 'single_choice', 'hard', 'PDR = Pe/HVG = (125 hp × 0.746 kW/hp)/(0.0012 kW per kcal/hr × 1,000 kcal/m³) = 93.25 kW/1.2 kW per m³/hr = 77.7 m³/hr', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '51.8 m³/hr', false, 0),
      (v_question_id, '77.7 m³/hr', true, 1),
      (v_question_id, '93.3 m³/hr', false, 2),
      (v_question_id, '104.2 m³/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'With a gas flow rate of 77.7 m³/hr, a gas-to-air ratio of 1.5, and an air density of 1.2 kg/m³, what is the airflow rate of the gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'With a gas flow rate of 77.7 m³/hr, a gas-to-air ratio of 1.5, and an air density of 1.2 kg/m³, what is the airflow rate of the gasifier?', 'single_choice', 'hard', 'AFR = (GFR/GAR) × δa = (77.7 m³/hr / 1.5) × 1.2 kg air/m³ = 51.8 m³/hr × 1.2 kg air/m³ = 62.16 kg air/hr', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '62.16 kg air/hr', true, 0),
      (v_question_id, '51.80 kg air/hr', false, 1),
      (v_question_id, '93.24 kg air/hr', false, 2),
      (v_question_id, '116.55 kg air/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The fuel consumption rate of a rice husk gasifier is 41.33 kg/hr and a pocket-type grate with a specific gasification rate of 100 kg/hr-m² is selected. What is the computed diameter of the reactor inner cylinder?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The fuel consumption rate of a rice husk gasifier is 41.33 kg/hr and a pocket-type grate with a specific gasification rate of 100 kg/hr-m² is selected. What is the computed diameter of the reactor inner cylinder?', 'single_choice', 'hard', 'Ar = FCR/SGR = 41.33 kg/hr / 100 kg/hr-m² = 0.41 m²; Di = (1.27 × Ar)^0.5 = (1.27×0.41)^0.5 = (0.5207)^0.5 = 0.72 m. In practice the Technical Bulletin adopts 0.7 m as the fabricated inner diameter.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.41 m', false, 0),
      (v_question_id, '0.64 m', false, 1),
      (v_question_id, '0.99 m', false, 2),
      (v_question_id, '0.72 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A reactor has a fuel consumption rate of 41.33 kg/hr, a rice husk density of 100 kg/m³, a cross-sectional area of 0.41 m², and an inner cylinder height of 1.6 m. Approximately how long will it take for the fire zone to reach the middle of the reactor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A reactor has a fuel consumption rate of 41.33 kg/hr, a rice husk density of 100 kg/m³, a cross-sectional area of 0.41 m², and an inner cylinder height of 1.6 m. Approximately how long will it take for the fire zone to reach the middle of the reactor?', 'single_choice', 'hard', 'FZR = FCR/(60 × δf × Ar) = [(41.33 kg/hr ÷ 60 min/hr)/(100 kg/m³ × 0.41 m²)] × 100 cm/m = (0.689 kg/min / 41 kg/m) × 100 cm/m = 1.7 cm/min. Middle of a 1.6 m reactor = 80 cm; t = 80 cm / 1.7 cm/min ≈ 47 minutes.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 minutes', false, 0),
      (v_question_id, '47 minutes', true, 1),
      (v_question_id, '80 minutes', false, 2),
      (v_question_id, '94 minutes', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on the allowable amount of particulates in the gas stream, what is the maximum allowable tar content of the producer gas?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Based on the allowable amount of particulates in the gas stream, what is the maximum allowable tar content of the producer gas?', 'single_choice', 'easy', 'Table 1 of the Technical Bulletin sets allowable particulates at 50 mg/m³ and below for dust (preferably 5 mg/m³), 500 mg/m³ and below for tar, and 50 mg/m³ and below for acids.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 mg/m³ and below', false, 0),
      (v_question_id, '50 mg/m³ and below', false, 1),
      (v_question_id, '500 mg/m³ and below', true, 2),
      (v_question_id, '1,000 mg/m³ and below', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Section 18 of Republic Act No. 10601, otherwise known as the Agricultural and Fisheries Mechanization (AFMech) Law, which entity must test a biomass gasifier model before it can be assembled, manufactured, and commercially sold in the market?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under Section 18 of Republic Act No. 10601, otherwise known as the Agricultural and Fisheries Mechanization (AFMech) Law, which entity must test a biomass gasifier model before it can be assembled, manufactured, and commercially sold in the market?', 'single_choice', 'easy', 'Section 18 of RA No. 10601 requires machinery models (and modifications) to be tested by AMTEC and pass prescribed quality/performance standards before assembly, manufacture, and commercial sale; under DA Memorandum Order No. 35, s. 2018, testing is conducted after complete on-site installation.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agricultural Machinery Testing and Evaluation Center (AMTEC)', true, 0),
      (v_question_id, 'Bureau of Agricultural and Fisheries Engineering (BAFE)', false, 1),
      (v_question_id, 'Philippine Rice Research Institute (PhilRice)', false, 2),
      (v_question_id, 'Regional Agricultural Engineering Division (RAED)', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Farm Machinery and Mechanization, Economics, Management, and Marketing (POWER_ENERGY_MACHINERY) — 15 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_mechanization uuid;
  v_sub_econ_mgmt uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'POWER_ENERGY_MACHINERY';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: POWER_ENERGY_MACHINERY';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Farm Machinery and Mechanization, Economics, Management, and Marketing' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Farm Machinery and Mechanization, Economics, Management, and Marketing', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_mechanization FROM public.subtopics WHERE name = 'Farm Machinery and Mechanization' AND topic_id = v_topic_id;
  IF v_sub_mechanization IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Farm Machinery and Mechanization') RETURNING id INTO v_sub_mechanization;
  END IF;

  SELECT id INTO v_sub_econ_mgmt FROM public.subtopics WHERE name = 'Farm Economics, Management, and Marketing' AND topic_id = v_topic_id;
  IF v_sub_econ_mgmt IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Farm Economics, Management, and Marketing') RETURNING id INTO v_sub_econ_mgmt;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rotavator mounted on a four-wheel tractor cuts and pulverizes the soil in a single pass, leaving the field ready for planting. Under the classification of tillage, this operation is best described as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'A rotavator mounted on a four-wheel tractor cuts and pulverizes the soil in a single pass, leaving the field ready for planting. Under the classification of tillage, this operation is best described as', 'single_choice', 'medium', 'General-purpose tillage combines primary and secondary tillage in one operation; rotavators and floating tillers are the implements named for it, cutting the soil to a depth of up to 6 inches.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'general-purpose tillage', true, 0),
      (v_question_id, 'secondary tillage', false, 1),
      (v_question_id, 'primary tillage', false, 2),
      (v_question_id, 'deep tillage', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In plowing, what term is given to the trench left in the field, equal in width to two furrows, when the furrowslices are thrown on opposite sides?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'In plowing, what term is given to the trench left in the field, equal in width to two furrows, when the furrowslices are thrown on opposite sides?', 'single_choice', 'medium', 'A deadfurrow is the trench left equal to two furrows when the furrowslices are thrown on opposite sides — where two adjacent lands are finished by plowing away from each other.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Backfurrow', false, 0),
      (v_question_id, 'Furrowslice', false, 1),
      (v_question_id, 'Furrow wall', false, 2),
      (v_question_id, 'Deadfurrow', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A disc plow is being set up for field operation. Which combination of angles is within the normal range given for a disc plow?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'A disc plow is being set up for field operation. Which combination of angles is within the normal range given for a disc plow?', 'single_choice', 'medium', 'Tilt angle (with the vertical, governing penetration depth) normally ranges 15 to 25 degrees. Disc angle (with the direction of travel, governing width of cut and rotation) normally ranges 42 to 45 degrees.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tilt angle 42 to 45 degrees; disc angle 15 to 25 degrees', false, 0),
      (v_question_id, 'Tilt angle 15 to 25 degrees; disc angle 42 to 45 degrees', true, 1),
      (v_question_id, 'Tilt angle 0 degrees; disc angle 15 to 25 degrees', false, 2),
      (v_question_id, 'Tilt angle 30 to 40 degrees; disc angle 30 to 40 degrees', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor pulling three 40-cm moldboard bottoms operates at 5.0 kph with a field efficiency of 80 percent. How many hectares can be plowed in 8 hours?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'A tractor pulling three 40-cm moldboard bottoms operates at 5.0 kph with a field efficiency of 80 percent. How many hectares can be plowed in 8 hours?', 'single_choice', 'hard', 'C = S×W×Eff/10 = (5.0)(1.20)(0.80)/10 = 0.48 ha/h; area = 0.48 ha/h × 8 h = 3.84 ha', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.20 ha', false, 0),
      (v_question_id, '3.84 ha', true, 1),
      (v_question_id, '4.80 ha', false, 2),
      (v_question_id, '6.00 ha', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-bottom moldboard plow with 30-cm bottoms operates at a depth of 20 cm and a speed of 6.4 kph in clay loam soil with a specific draft of 0.42 kg/cm². Using the increase in draft due to speed, what is the draft horsepower requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'A four-bottom moldboard plow with 30-cm bottoms operates at a depth of 20 cm and a speed of 6.4 kph in clay loam soil with a specific draft of 0.42 kg/cm². Using the increase in draft due to speed, what is the draft horsepower requirement?', 'single_choice', 'hard', 'Static draft Ds = 0.42 kg/cm² × 120 cm × 20 cm = 1,008 kg. Adjusted for speed at 6.4 kph (142% increase): Da = 1,008 × 1.42 = 1,431 kg. Hp = Da×S/274 = (1,431)(6.4)/274 = 33.4 hp', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '23.5 hp', false, 0),
      (v_question_id, '33.4 hp', true, 1),
      (v_question_id, '41.8 hp', false, 2),
      (v_question_id, '52.3 hp', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A knapsack sprayer is calibrated and found to have a discharge rate of 1.2 L/min, an effective swath of 1.5 m, and an average walking speed of 25 m/min. What is the application rate in liters per hectare?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'A knapsack sprayer is calibrated and found to have a discharge rate of 1.2 L/min, an effective swath of 1.5 m, and an average walking speed of 25 m/min. What is the application rate in liters per hectare?', 'single_choice', 'hard', 'A = W×S = (1.5 m)(25 m/min) = 37.5 m²/min; T = 10,000 m²/ha ÷ 37.5 m²/min = 266.67 min/ha; Q = q×T = (1.2 L/min)(266.67 min/ha) = 320 L/ha', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '180 L/ha', false, 0),
      (v_question_id, '267 L/ha', false, 1),
      (v_question_id, '320 L/ha', true, 2),
      (v_question_id, '500 L/ha', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly defines field efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'Which statement correctly defines field efficiency?', 'single_choice', 'easy', 'Field efficiency is the ratio of effective field capacity to theoretical field capacity, expressed as a percent; it may also be stated as the ratio of theoretical time to total time actually spent, including proportional and non-proportional time losses.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The percentage of effectiveness of performance of a machine, such as the recovery of grain in a thresher', false, 0),
      (v_question_id, 'The reciprocal of the theoretical field capacity, expressed in hours per hectare', false, 1),
      (v_question_id, 'The ratio of effective field capacity to theoretical field capacity, expressed as a percent', true, 2),
      (v_question_id, 'The ratio of the actual width of cut to the rated width of the implement', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In appraising an investment in farm machinery, at what point does the internal rate of return occur?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mechanization, 'In appraising an investment in farm machinery, at what point does the internal rate of return occur?', 'single_choice', 'medium', 'The internal rate of return is the maximum interest rate the project can pay for the use of money if it is to break even; at that rate NPV is zero and B/C is one. The decision rule is that IRR should be higher than the prevailing bank interest rate.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Where the net present value equals zero and the benefit-cost ratio equals one', true, 0),
      (v_question_id, 'Where the payback period is shortest', false, 1),
      (v_question_id, 'Where the benefit-cost ratio is at its maximum', false, 2),
      (v_question_id, 'Where the break-even point is lowest', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cooperative is deciding whether to replace an old thresher with a new unit. In the analysis, the original purchase price of the old thresher should be treated as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A cooperative is deciding whether to replace an old thresher with a new unit. In the analysis, the original purchase price of the old thresher should be treated as', 'single_choice', 'easy', 'A sunk cost has already occurred in the past and has no relevance to estimates of future costs and revenues related to an alternative course of action; the purchase cost of the old machine is generally treated as a sunk cost.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a sunk cost', true, 0),
      (v_question_id, 'an opportunity cost', false, 1),
      (v_question_id, 'a variable cost', false, 2),
      (v_question_id, 'an indirect cost', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rural bank quotes a loan at 12 percent per year compounded monthly. What is the effective annual interest rate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A rural bank quotes a loan at 12 percent per year compounded monthly. What is the effective annual interest rate?', 'single_choice', 'hard', 'Given: r=12%/year nominal, M=12. ia = (1+r/M)^M − 1 = (1.01)^12 − 1 = 1.1268−1 = 0.1268, or 12.68%', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12.00 percent', false, 0),
      (v_question_id, '12.36 percent', false, 1),
      (v_question_id, '12.68 percent', true, 2),
      (v_question_id, '12.75 percent', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice mill acquires a dryer for 850,000 pesos with an estimated salvage value of 100,000 pesos at the end of a 10-year depreciable life. Using the straight-line method, what is its book value at the end of the fourth year?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A rice mill acquires a dryer for 850,000 pesos with an estimated salvage value of 100,000 pesos at the end of a 10-year depreciable life. Using the straight-line method, what is its book value at the end of the fourth year?', 'single_choice', 'hard', 'Annual depreciation dk = (850,000−100,000)/10 = 75,000 pesos/year. Cumulative depreciation through year 4 = 4×75,000 = 300,000 pesos. Book value = 850,000−300,000 = 550,000 pesos.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '510,000 pesos', false, 0),
      (v_question_id, '550,000 pesos', true, 1),
      (v_question_id, '640,000 pesos', false, 2),
      (v_question_id, '700,000 pesos', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm manager reorganizes the harvesting crew so that the same area is covered using fewer labor-hours and less fuel. In management terms, the manager has demonstrated';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A farm manager reorganizes the harvesting crew so that the same area is covered using fewer labor-hours and less fuel. In management terms, the manager has demonstrated', 'single_choice', 'medium', 'Efficiency is doing things right, an input-output concept expressed as output divided by input, promoted by the same input for more output, less input for the same output, or less input for more output. Covering the same area with fewer labor-hours and less fuel is the second of these.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'effectiveness, because the right objective was chosen', false, 0),
      (v_question_id, 'controlling, because performance was measured against a standard', false, 1),
      (v_question_id, 'leading, because subordinates were influenced to act', false, 2),
      (v_question_id, 'efficiency, because resource use was minimized for the output achieved', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A corn farmer agrees today to sell his coming harvest at a price fixed now, with delivery to be made three months later. Which method of reducing risk is he using?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A corn farmer agrees today to sell his coming harvest at a price fixed now, with delivery to be made three months later. Which method of reducing risk is he using?', 'single_choice', 'easy', 'A futures contract sells the product at a current or agreed price with delivery at some future time, protecting the farmer against risks from the unpredictability of market conditions.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diversification', false, 0),
      (v_question_id, 'Flexibility', false, 1),
      (v_question_id, 'Liquidity', false, 2),
      (v_question_id, 'Futures contract', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A small number of firms control the market for farm tractors in a country, and they exert particular influence over pricing. This competitive structure is best described as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A small number of firms control the market for farm tractors in a country, and they exert particular influence over pricing. This competitive structure is best described as', 'single_choice', 'easy', 'An oligopoly exists when a small number of marketers control the market, particularly its pricing elements.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a monopoly', false, 0),
      (v_question_id, 'monopolistic competition', false, 1),
      (v_question_id, 'an oligopoly', true, 2),
      (v_question_id, 'pure competition', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dealer lowers the price of a grain moisture meter and finds that total revenue rises. The demand for the product is best described as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_econ_mgmt, 'A dealer lowers the price of a grain moisture meter and finds that total revenue rises. The demand for the product is best described as', 'single_choice', 'medium', 'Elastic demand is the price-demand relationship in which lowering the price leads to greater total revenue, because the resulting increase in quantity bought more than offsets the lower price per unit.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'elastic', true, 0),
      (v_question_id, 'perfectly inelastic', false, 1),
      (v_question_id, 'inelastic', false, 2),
      (v_question_id, 'perfectly elastic', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Geographic Information System (LAND_WATER) — 10 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAND_WATER';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Geographic Information System' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Geographic Information System', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In map algebra, an operation that computes the value of each output cell from the values of the input cells falling within a defined neighborhood, such as a 3 × 3 moving window centered on that cell, is classified as a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In map algebra, an operation that computes the value of each output cell from the values of the input cells falling within a defined neighborhood, such as a 3 × 3 moving window centered on that cell, is classified as a', 'single_choice', 'medium', 'A focal (neighborhood) operation reads a defined window (rectangular, circular, annular, or wedge) around each cell and applies a statistic such as mean, maximum, majority, or standard deviation. Slope, aspect, curvature, and smoothing/edge-detection filters are all focal operations.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Local operation', false, 0),
      (v_question_id, 'Focal operation', true, 1),
      (v_question_id, 'Zonal operation', false, 2),
      (v_question_id, 'Global operation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In raster-based watershed delineation, the outlet cell from which the contributing drainage area is traced upslope is termed the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In raster-based watershed delineation, the outlet cell from which the contributing drainage area is traced upslope is termed the', 'single_choice', 'medium', 'The standard delineation sequence is fill sinks, compute flow direction, compute flow accumulation, extract the stream network by an accumulation threshold, then define the watershed upslope of a specified pour point (typically snapped to the cell of maximum flow accumulation within a small search radius).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pour point', true, 0),
      (v_question_id, 'Sink', false, 1),
      (v_question_id, 'Saddle', false, 2),
      (v_question_id, 'Confluence', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The area of a terrain surface that can be seen from a single specified observation point, given a defined observer height and search radius, is called the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The area of a terrain surface that can be seen from a single specified observation point, given a defined observer height and search radius, is called the', 'single_choice', 'medium', 'A viewshed is computed against an elevation surface and returned as a binary raster of visible/not-visible cells, sensitive to observer offset, target offset, search radius, and azimuth/vertical-angle limits; Earth curvature and refraction corrections matter over long sightlines.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Viewshed', true, 0),
      (v_question_id, 'Line of sight', false, 1),
      (v_question_id, 'Cumulative viewshed', false, 2),
      (v_question_id, 'Watershed', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The process of converting a street address into a point location by matching it against a reference street layer and interpolating its position within the address range stored for that block is known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The process of converting a street address into a point location by matching it against a reference street layer and interpolating its position within the address range stored for that block is known as', 'single_choice', 'medium', 'Geocoding (address matching) requires a reference database with from-address/to-address values per street segment; the candidate address is parsed, matched, and placed by linear interpolation within that segment''s range.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Georeferencing', false, 0),
      (v_question_id, 'Geocoding', true, 1),
      (v_question_id, 'Rubber sheeting', false, 2),
      (v_question_id, 'Dynamic segmentation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A method of associating attributes with portions of a linear feature by referencing measured distances along that feature, without physically splitting the underlying line geometry, is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A method of associating attributes with portions of a linear feature by referencing measured distances along that feature, without physically splitting the underlying line geometry, is called', 'single_choice', 'medium', 'Dynamic segmentation is built on linear referencing: a route carries an m-value (measure) at each vertex, so any position is a single distance from the route origin. Attributes are held in separate event tables (point events, or line events with a from-measure and to-measure), letting many independent attribute sets be draped on the same geometry and edited independently.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Line simplification', false, 0),
      (v_question_id, 'Vectorization', false, 1),
      (v_question_id, 'Dynamic segmentation', true, 2),
      (v_question_id, 'Snapping', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During digitizing, an arc endpoint that fails to connect to any other arc — the result of an overshoot or an undershoot at an intended junction — is referred to as a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'During digitizing, an arc endpoint that fails to connect to any other arc — the result of an overshoot or an undershoot at an intended junction — is referred to as a', 'single_choice', 'medium', 'A dangling node terminates an arc that connects to nothing else, breaking connectivity. Editors detect dangles by a dangle length tolerance, which flags dangling arcs shorter than a stated distance so genuine cul-de-sacs/dead-end canals are not deleted along with the errors.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sliver polygon', false, 0),
      (v_question_id, 'Pseudo node', false, 1),
      (v_question_id, 'Dangling node', true, 2),
      (v_question_id, 'Label point', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In building a triangulated irregular network (TIN), a line feature that is enforced as a series of triangle edges so that an abrupt change in the surface, such as a road embankment, a levee, or a stream channel, is preserved, is called a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In building a triangulated irregular network (TIN), a line feature that is enforced as a series of triangle edges so that an abrupt change in the surface, such as a road embankment, a levee, or a stream channel, is preserved, is called a', 'single_choice', 'medium', 'A TIN represents a surface as non-overlapping triangles built from mass points, normally via Delaunay triangulation, which maximizes the minimum interior angle and can smooth away sharp features. Breaklines are inserted as constrained edges the triangulation cannot cross; hard breaklines represent abrupt discontinuities, soft breaklines mark features whose slope changes gradually.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Contour', false, 0),
      (v_question_id, 'Breakline', true, 1),
      (v_question_id, 'Delaunay edge', false, 2),
      (v_question_id, 'Isoline', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'On a topographic map with a representative fraction of 1:50,000, the distance between a proposed pump house and a diversion weir measures 4.7 cm. What is the corresponding ground distance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'On a topographic map with a representative fraction of 1:50,000, the distance between a proposed pump house and a diversion weir measures 4.7 cm. What is the corresponding ground distance?', 'single_choice', 'hard', 'Dg = dm × scale denominator = 4.7 cm × 50,000 = 235,000 cm = 2,350 m = 2.35 km', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.235 km', false, 0),
      (v_question_id, '1.06 km', false, 1),
      (v_question_id, '2.35 km', true, 2),
      (v_question_id, '23.50 km', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A DEM shows that the elevation drops 45 m between a ridge point and a stream outlet separated by a horizontal distance of 300 m. Express the average slope of this hillside as a percentage and in degrees.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A DEM shows that the elevation drops 45 m between a ridge point and a stream outlet separated by a horizontal distance of 300 m. Express the average slope of this hillside as a percentage and in degrees.', 'single_choice', 'hard', 'S% = (Δh/L)×100 = (45/300)×100 = 15.00%. θ = arctan(Δh/L) = arctan(0.15) = 8.5308° ≈ 8.53°', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.67% and 3.81°', false, 0),
      (v_question_id, '15.00% and 8.53°', true, 1),
      (v_question_id, '15.00% and 15.00°', false, 2),
      (v_question_id, '33.33% and 18.43°', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A soil-suitability layer and an irrigation-service-area layer are to be combined so that the output retains only the ground common to both layers, with the attributes of both carried into the result. Which vector overlay operation accomplishes this?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A soil-suitability layer and an irrigation-service-area layer are to be combined so that the output retains only the ground common to both layers, with the attributes of both carried into the result. Which vector overlay operation accomplishes this?', 'single_choice', 'medium', 'Intersect preserves only the geometric overlap of the input and overlay layers (a logical AND), and the output attribute table inherits fields of both inputs — the standard tool for suitability analysis where a candidate site must satisfy two or more spatial conditions at once.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Union', false, 0),
      (v_question_id, 'Intersect', true, 1),
      (v_question_id, 'Identity', false, 2),
      (v_question_id, 'Symmetrical Difference', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Laws, Professional Standards, and Ethics (LAWS_ETHICS) — 15 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAWS_ETHICS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAWS_ETHICS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Laws, Professional Standards, and Ethics' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Laws, Professional Standards, and Ethics', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which law is regarded as the first Philippine statute to regulate the practice of agricultural engineering, having been approved on 18 June 1964?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which law is regarded as the first Philippine statute to regulate the practice of agricultural engineering, having been approved on 18 June 1964?', 'single_choice', 'easy', 'RA 3927, the Philippine Agricultural Engineering Law, approved 18 June 1964, contained 31 sections and defined agricultural engineering as applying mechanical, civil, and electrical engineering to agriculture. RA 8559 (1998) and RA 10915 (2016) are later replacement statutes.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Republic Act No. 8559', false, 0),
      (v_question_id, 'Republic Act No. 10915', false, 1),
      (v_question_id, 'Republic Act No. 3927', true, 2),
      (v_question_id, 'Presidential Decree No. 2032', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Philippine Agricultural Engineering Act of 1998 is composed of how many articles and sections?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The Philippine Agricultural Engineering Act of 1998 is composed of how many articles and sections?', 'single_choice', 'easy', 'RA 8559, approved 26 February 1998, is organized into five articles and 35 sections. Seven articles/47 sections describe RA 10915 (2016); 31 sections without article divisions describe RA 3927 (1964).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Five articles, 35 sections', true, 0),
      (v_question_id, 'Seven articles, 47 sections', false, 1),
      (v_question_id, 'Four articles, 31 sections', false, 2),
      (v_question_id, 'Six articles, 42 sections', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Section 42 of Republic Act No. 10915, a person convicted of violating the provisions of the Act may be penalized by a fine of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under Section 42 of Republic Act No. 10915, a person convicted of violating the provisions of the Act may be penalized by a fine of:', 'single_choice', 'easy', 'Section 42 imposes, in addition to administrative sanctions, a fine of not less than P100,000.00 but not more than P500,000.00, or imprisonment of not less than six months but not more than five years, or both, at the court''s discretion.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Not less than P100,000.00 but not more than P500,000.00', true, 0),
      (v_question_id, 'Not less than P50,000.00 but not more than P100,000.00', false, 1),
      (v_question_id, 'Not less than P500,000.00 but not more than P1,000,000.00', false, 2),
      (v_question_id, 'Not less than P10,000.00 but not more than P50,000.00', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which issuance serves as the Implementing Rules and Regulations of the Agriculture and Fisheries Modernization Act?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which issuance serves as the Implementing Rules and Regulations of the Agriculture and Fisheries Modernization Act?', 'single_choice', 'medium', 'DA AO No. 6, s. 1998, issued 10 July 1998, is the IRR of RA 8435 (AFMA). DA Circular No. 1, s. 2013 implements the AFMech Law (RA 10601); the Joint Memorandum Circular implements the Rice Tariffication Law (RA 11203); DENR AO 2001-34 implements the Ecological Solid Waste Management Act (RA 9003).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Department of Agriculture Circular No. 1, Series of 2013', false, 0),
      (v_question_id, 'Department of Agriculture Administrative Order No. 6, Series of 1998', true, 1),
      (v_question_id, 'DA-NEDA-DBM Joint Memorandum Circular No. 01-2019', false, 2),
      (v_question_id, 'DENR Administrative Order No. 2001-34', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the principles of AFMA, which one refers specifically to the availability, adequacy, accessibility, and affordability of food supplies to all at all times';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Among the principles of AFMA, which one refers specifically to the availability, adequacy, accessibility, and affordability of food supplies to all at all times', 'single_choice', 'medium', 'Food security under DA AO No. 6, s. 1998 is defined by the four attributes of availability, adequacy, accessibility, and affordability of food supplies. The other principles concern equitable resource access, efficient resource use, and ecosystem preservation, respectively.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Poverty alleviation and social equity', false, 0),
      (v_question_id, 'Rational use of resources', false, 1),
      (v_question_id, 'Food security', true, 2),
      (v_question_id, 'Sustainable development', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the production and marketing support services component of AFMA, the Strategic Agriculture and Fisheries Development Zones (SAFDZ) are identified within the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under the production and marketing support services component of AFMA, the Strategic Agriculture and Fisheries Development Zones (SAFDZ) are identified within the:', 'single_choice', 'medium', 'AFMA directs the identification of SAFDZ within the NPAAD, the land-use framework protecting areas for agriculture and agro-industrial development. NAFMIP is the 2021-2030 sector plan, NAFMP is the mechanization program under RA 10601, and NAFES is the education system under AFMA.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Network of Protected Areas for Agricultural and Agro-Industrial Development (NPAAD)', true, 0),
      (v_question_id, 'National Agriculture and Fisheries Modernization and Industrialization Plan (NAFMIP)', false, 1),
      (v_question_id, 'National Agri-Fishery Mechanization Program (NAFMP)', false, 2),
      (v_question_id, 'National Agriculture and Fisheries Education System (NAFES)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under RA 10601, which agency is mandated to develop standards for agricultural and fisheries machinery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under RA 10601, which agency is mandated to develop standards for agricultural and fisheries machinery?', 'single_choice', 'easy', 'BAFS is tasked with developing standards for AF machinery. BAFE monitors NAFMP implementation and mechanization infrastructure; AMTEC is the premier testing center assisting BAFS; PHilMech leads overall R&D and extension in AF mechanization.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bureau of Agriculture and Fisheries Standards (BAFS)', true, 0),
      (v_question_id, 'Bureau of Agricultural and Fisheries Engineering (BAFE)', false, 1),
      (v_question_id, 'Agricultural Machinery Testing and Evaluation Center (AMTEC)', false, 2),
      (v_question_id, 'Philippine Center for Postharvest Development and Mechanization (PHilMech)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT among the prohibited acts enumerated under the AFMech Law?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT among the prohibited acts enumerated under the AFMech Law?', 'single_choice', 'medium', 'Prohibited acts under RA 10601 are selling/mortgaging/leasing AF machinery without BAFE registration; selling without warranty/after-sales service; claiming ownership of machinery not properly registered; and operating a testing center without accreditation. Procuring machinery from a duly accredited supplier is precisely the practice encouraged by DA Circular No. 17, s. 2018 (NAMDAC), so it is not prohibited.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Selling, mortgaging, or leasing AF machinery without being registered with the BAFE', false, 0),
      (v_question_id, 'Importing agricultural machinery for personal farm use through an accredited dealer', true, 1),
      (v_question_id, 'Selling AF machinery without warranty or after-sales service', false, 2),
      (v_question_id, 'Operating a testing center without proper accreditation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The preparation of the National Agri-Fishery Mechanization Program (NAFMP) is spearheaded by which agency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The preparation of the National Agri-Fishery Mechanization Program (NAFMP) is spearheaded by which agency?', 'single_choice', 'easy', 'NAFMP preparation is spearheaded by the Bureau of Agricultural and Fisheries Engineering; the program was approved on 7 April 2017 and guides national planning, budgeting, implementation, monitoring, and regulation of AF mechanization.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PHilMech', false, 0),
      (v_question_id, 'BFAR', false, 1),
      (v_question_id, 'AMTEC', false, 2),
      (v_question_id, 'BAFE', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'DA Department Circular No. 17, Series of 2018, which established the NAMDAC guidelines, was principally intended to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'DA Department Circular No. 17, Series of 2018, which established the NAMDAC guidelines, was principally intended to:', 'single_choice', 'medium', 'DA DC No. 17, s. 2018 covers classification and accreditation of AF machinery assemblers, manufacturers, importers, distributors, and dealers (NAMDAC), issued to prevent the proliferation of fly-by-night suppliers and guide procurement from duly accredited suppliers. Testing center accreditation is covered by DC No. 04, s. 2017; national testing/evaluation guidelines by DC No. 05, s. 2017; LGU ABE group strengthening by DA-DBM-CSC-DILG JMC No. 02, s. 2020.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Accredit agricultural and fisheries machinery testing centers', false, 0),
      (v_question_id, 'Prevent the proliferation of fly-by-night suppliers of AF machinery', true, 1),
      (v_question_id, 'Set the national guidelines on testing and evaluation of AF machinery', false, 2),
      (v_question_id, 'Strengthen the ABE groups of local government units', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Rice Tariffication Law, the Rice Competitiveness Enhancement Fund (RCEF) is allocated with the largest share going to which component?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under the Rice Tariffication Law, the Rice Competitiveness Enhancement Fund (RCEF) is allocated with the largest share going to which component?', 'single_choice', 'easy', 'RA 11203 creates the RCEF with a P10 billion annual appropriation for six years, allocated as 50% mechanization, 30% seed development, 10% credit, and 10% extension services.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mechanization at 50%', true, 0),
      (v_question_id, 'Seed development at 30%', false, 1),
      (v_question_id, 'Credit at 10%', false, 2),
      (v_question_id, 'Extension services at 10%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which law replaced quantitative import restrictions on agricultural products, except rice, with tariffs and created the Agricultural Competitiveness Enhancement Fund (ACEF)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which law replaced quantitative import restrictions on agricultural products, except rice, with tariffs and created the Agricultural Competitiveness Enhancement Fund (ACEF)?', 'single_choice', 'medium', 'RA 8178, the Agricultural Tariffication Law approved 28 March 1996, implemented the WTO Uruguay Round Agreement on Agriculture, exempted rice from tariffication until 2005, and created ACEF. RA 11203 later lifted the quantitative restriction on rice and created RCEF; RA 10659 is the Sugarcane Industry Development Act; RA 8435 is AFMA.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Republic Act No. 11203', false, 0),
      (v_question_id, 'Republic Act No. 10659', false, 1),
      (v_question_id, 'Republic Act No. 8178', true, 2),
      (v_question_id, 'Republic Act No. 8435', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Comprehensive Agrarian Reform Program Extension with Reforms (CARPER) Law, which amended Republic Act No. 6657, is properly identified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The Comprehensive Agrarian Reform Program Extension with Reforms (CARPER) Law, which amended Republic Act No. 6657, is properly identified as:', 'single_choice', 'medium', 'RA 9700 was approved on 7 August 2009 and strengthened CARP by extending land acquisition and distribution. RA 6657, the Comprehensive Agrarian Reform Law of 1988, was approved 10 June 1988 and took effect 15 June 1988. RA 9729 is the Climate Change Act of 2009.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Republic Act No. 9700, approved 15 June 1988', false, 0),
      (v_question_id, 'Republic Act No. 6657, approved 10 June 1988', false, 1),
      (v_question_id, 'Republic Act No. 9729, approved 23 October 2009', false, 2),
      (v_question_id, 'Republic Act No. 9700, approved 7 August 2009', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Biofuels Act of 2006 mandates a minimum bioethanol blend in the gasoline mix sold and distributed of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The Biofuels Act of 2006 mandates a minimum bioethanol blend in the gasoline mix sold and distributed of:', 'single_choice', 'easy', 'RA 9367, approved 12 January 2007, introduced mandatory biofuel use, requiring a minimum of 5% bioethanol within two years and a minimum of 10% within four years. Its IRR is DC 2007-05-006 issued by the Department of Energy on 17 May 2007.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10% within two years and 20% within four years', false, 0),
      (v_question_id, '5% within two years and 10% within four years', true, 1),
      (v_question_id, '2% within two years and 5% within four years', false, 2),
      (v_question_id, '5% within four years and 10% within six years', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Ecological Solid Waste Management Act mandates local government units to achieve what level of waste reduction through an integrated solid waste management plan based on the 3Rs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The Ecological Solid Waste Management Act mandates local government units to achieve what level of waste reduction through an integrated solid waste management plan based on the 3Rs?', 'single_choice', 'easy', 'RA 9003, approved 26 January 2001, mandates LGUs to achieve 25% waste reduction through an integrated solid waste management plan based on reduce, reuse, and recycle. Its IRR is DENR Administrative Order No. 2001-34, issued 20 December 2001.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', false, 0),
      (v_question_id, '50%', false, 1),
      (v_question_id, '25%', true, 2),
      (v_question_id, '75%', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Engineering Metrology and Equipment (MATH_BASIC_ENGG) — 8 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'MATH_BASIC_ENGG';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: MATH_BASIC_ENGG';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Engineering Metrology and Equipment' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Engineering Metrology and Equipment', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A finished shaft is measured and its diameter is compared against the limits stated on the design drawing in order to decide whether the part may be accepted or rejected. In engineering metrology, this procedure is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A finished shaft is measured and its diameter is compared against the limits stated on the design drawing in order to decide whether the part may be accepted or rejected. In engineering metrology, this procedure is called', 'single_choice', 'easy', 'Inspection is the examination of a part or product characteristic to determine whether it conforms to the design specification; it is a judgment passed on the workpiece, with an accept-or-reject output.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Validation', false, 0),
      (v_question_id, 'Inspection', true, 1),
      (v_question_id, 'Monitoring', false, 2),
      (v_question_id, 'Calibration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The pointer of a dial indicator sweeps 10 scale divisions when its plunger is displaced by 0.02 mm. The ratio of the change in instrument indication to the change in the quantity being measured is termed';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The pointer of a dial indicator sweeps 10 scale divisions when its plunger is displaced by 0.02 mm. The ratio of the change in instrument indication to the change in the quantity being measured is termed', 'single_choice', 'medium', 'Sensitivity is the ratio of the change in instrument response (output) to the change in the measurand (input): sensitivity = 10 divisions ÷ 0.02 mm = 500 divisions per millimetre.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Range', false, 0),
      (v_question_id, 'Precision', false, 1),
      (v_question_id, 'Sensitivity', true, 2),
      (v_question_id, 'Accuracy', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The property of a measurement result whereby it can be related to a national or international standard through a documented, unbroken chain of comparisons, each carrying a stated uncertainty, is known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The property of a measurement result whereby it can be related to a national or international standard through a documented, unbroken chain of comparisons, each carrying a stated uncertainty, is known as', 'single_choice', 'easy', 'Traceability establishes the pedigree of a measurement: working standards are compared against secondary standards, secondary against primary, and primary against the definition of the unit at the national metrology institute, with documented uncertainty at every link.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Repeatability', false, 0),
      (v_question_id, 'Traceability', true, 1),
      (v_question_id, 'Reproducibility', false, 2),
      (v_question_id, 'Sensitivity', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A technician takes readings from a steel rule while viewing the graduations at an oblique angle instead of perpendicular to the scale. The error introduced is best classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A technician takes readings from a steel rule while viewing the graduations at an oblique angle instead of perpendicular to the scale. The error introduced is best classified as', 'single_choice', 'medium', 'Parallax error arises from the apparent displacement of the index relative to the scale when the observer''s line of sight is not normal to the scale surface. Because the cause is identifiable and eliminable, it is a systematic, controllable error.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Zero error', false, 0),
      (v_question_id, 'Datum error', false, 1),
      (v_question_id, 'Parallax error', true, 2),
      (v_question_id, 'Random error', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Method of measurement in which the difference between the unknown quantity and a known quantity of the same kind is reduced to zero, the instrument serving only as a detector of imbalance:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Method of measurement in which the difference between the unknown quantity and a known quantity of the same kind is reduced to zero, the instrument serving only as a detector of imbalance:', 'single_choice', 'medium', 'In the null method the instrument indicates only whether the difference is zero, so accuracy rests on the known standard rather than instrument linearity/graduation. Classic examples: the equal-arm balance and the Wheatstone bridge.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Deflection method', false, 0),
      (v_question_id, 'Substitution method', false, 1),
      (v_question_id, 'Null measurement method', true, 2),
      (v_question_id, 'Coincidence method', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the hierarchy of measurement standards, those issued to shop-floor operators for routine, day-to-day dimensional checks are classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the hierarchy of measurement standards, those issued to shop-floor operators for routine, day-to-day dimensional checks are classified as', 'single_choice', 'medium', 'Working standards occupy the lowest tier, deliberately of rugged construction and moderate accuracy since they are handled continuously in production. Primary standards define the unit; secondary standards are close copies used for calibration; tertiary standards are national physical laboratory reference standards for laboratories/workshops.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Primary standards', false, 0),
      (v_question_id, 'Secondary standards', false, 1),
      (v_question_id, 'Tertiary standards', false, 2),
      (v_question_id, 'Working standards', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Slip gauges are wrung together to build up a required dimension. Wringing is associated with which class of length measurement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Slip gauges are wrung together to build up a required dimension. Wringing is associated with which class of length measurement?', 'single_choice', 'medium', 'End standards define a length by the distance between two flat, parallel, lapped faces (slip gauges, end bars, micrometer anvils). Wringing is the adhesion of two such lapped faces, meaningful only for end standards, which are free of parallax error but suffer wear on the measuring faces.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Line measurement', false, 0),
      (v_question_id, 'End measurement', true, 1),
      (v_question_id, 'Both line and end measurement', false, 2),
      (v_question_id, 'Neither line nor end measurement', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A specialised telescope projects a collimated beam onto a plane reflector mounted on the workpiece and measures the lateral displacement of the returned image, thereby resolving very small angular deviations. The instrument is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A specialised telescope projects a collimated beam onto a plane reflector mounted on the workpiece and measures the lateral displacement of the returned image, thereby resolving very small angular deviations. The instrument is the', 'single_choice', 'medium', 'The autocollimator combines a collimator and telescope in one optical head; a tilt θ of the reflector displaces the returned image by d=2fθ, resolving down to a fraction of a second of arc. It is standard for checking straightness, flatness, squareness, and slideway alignment. (The angle dekkor is a small variation used as a comparator; the clinometer is a turnable level measuring larger angles; the sine bar sets angles using slip gauges, limited to about 45°.)', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Clinometer', false, 0),
      (v_question_id, 'Sine bar', false, 1),
      (v_question_id, 'Autocollimator', true, 2),
      (v_question_id, 'Angle dekkor', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Operator's Manual for AB Power and Machinery (POWER_ENERGY_MACHINERY) — 9 question(s)
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
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Operator''s Manual for AB Power and Machinery', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PNS/BAFS 390:2024 was developed after a Table Review conducted by the DA-BAFS Technical Working Group. Which standard does it cancel and replace?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'PNS/BAFS 390:2024 was developed after a Table Review conducted by the DA-BAFS Technical Working Group. Which standard does it cancel and replace?', 'single_choice', 'easy', 'The Foreword states that in 2024 DA-BAFS conducted a Table Review of PAES 102:2000 and, on the TWG''s recommendation, revised it; the resulting PNS/BAFS 390:2024 therefore cancels and replaces PAES 102:2000.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PAES 101:2000 — Agricultural machinery — Technical means for ensuring safety', false, 0),
      (v_question_id, 'PAES 102:2000 — Agricultural machinery — Operator''s manual — Content and presentation', true, 1),
      (v_question_id, 'PAES 104:2000 — Agricultural machinery — Location and method of operation of operator''s controls', false, 2),
      (v_question_id, 'ISO 3600:2022 — Operator''s manuals — Content and format', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which term refers to the activities necessary to restore a machine to operable condition after a failure has occurred?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which term refers to the activities necessary to restore a machine to operable condition after a failure has occurred?', 'single_choice', 'easy', 'Clause 3.6 defines repair as the activities necessary to restore a machine to operable condition after a failure has occurred.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Maintenance', false, 0),
      (v_question_id, 'Repair', true, 1),
      (v_question_id, 'Service', false, 2),
      (v_question_id, 'Replacement part', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In organizing the categories of information in an operator''s manual, which group of information shall be provided at the front portion of the manual?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In organizing the categories of information in an operator''s manual, which group of information shall be provided at the front portion of the manual?', 'single_choice', 'medium', 'Clause 4.2.2 requires safety precautions, controls, and operating instructions to be provided at the front portion of the manual, since these are the items the operator needs before the machine is ever run.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Parts list, warranty, and alphabetical index', false, 0),
      (v_question_id, 'Safety precautions, controls, and operating instructions', true, 1),
      (v_question_id, 'Machine identification, specifications, and storage instructions', false, 2),
      (v_question_id, 'Maintenance schedules, troubleshooting, and disposal instructions', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An alphabetical index should be placed at the last portion of the manual when the manual exceeds how many pages?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An alphabetical index should be placed at the last portion of the manual when the manual exceeds how many pages?', 'single_choice', 'easy', 'Clause 4.17: a manual with more than 32 pages should have an alphabetical index at the last portion, listing all major topics with the page number where indexed information is located.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16 pages', false, 0),
      (v_question_id, '24 pages', false, 1),
      (v_question_id, '32 pages', true, 2),
      (v_question_id, '50 pages', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which paper size does the standard recommend for printing an operator''s manual in most cases?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which paper size does the standard recommend for printing an operator''s manual in most cases?', 'single_choice', 'easy', 'Clause 5.1.1.1 states the manual should be printed in A5 size because it is suitable for most cases.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A3 (297 mm x 420 mm)', false, 0),
      (v_question_id, 'A4 (210 mm x 297 mm)', false, 1),
      (v_question_id, 'A5 (148.5 mm x 210 mm)', true, 2),
      (v_question_id, 'One-half A4 (99 mm x 210 mm)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum type size prescribed for the main text of the manual?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'What is the minimum type size prescribed for the main text of the manual?', 'single_choice', 'easy', 'Clause 5.3.5 provides that the type size of the main text should be 10 points or greater; smaller type sizes may be appropriate only for manuals printed on A5 or smaller paper.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 points', false, 0),
      (v_question_id, '10 points', true, 1),
      (v_question_id, '11 points', false, 2),
      (v_question_id, '12 points', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which signal word shall be used for instructions that must be followed precisely to avoid damaging the product, the process, or its surroundings?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which signal word shall be used for instructions that must be followed precisely to avoid damaging the product, the process, or its surroundings?', 'single_choice', 'medium', 'Clause 5.6.1 assigns each signal word to a distinct level of consequence; IMPORTANT is used when machine damage is involved, and Clause 5.6.3.1 confirms these are instructions to be followed precisely to avoid damaging the product, process, or surroundings.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'WARNING', false, 0),
      (v_question_id, 'CAUTION', false, 1),
      (v_question_id, 'IMPORTANT', true, 2),
      (v_question_id, 'NOTE', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Where should WARNING and CAUTION instructions be positioned in the manual?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Where should WARNING and CAUTION instructions be positioned in the manual?', 'single_choice', 'medium', 'Clause 5.6.2.2 requires WARNING and CAUTION instructions to be placed immediately before the text to which they apply and signaled in the left-hand margin by the safety alert symbol; they should also be placed near any illustration they concern, with a heading in bold upper-case type.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Consolidated at the end of each section, in italics', false, 0),
      (v_question_id, 'Immediately before the text to which they apply, signaled in the left-hand margin by the safety alert symbol', true, 1),
      (v_question_id, 'Only in the safety section at the front of the manual, so that they appear once', false, 2),
      (v_question_id, 'As footnotes at the bottom of the page, set in a smaller type size', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which sentence conforms to the text conventions of the standard on measurements, quantities, and numbers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which sentence conforms to the text conventions of the standard on measurements, quantities, and numbers?', 'single_choice', 'medium', 'Clause 5.4.6 requires measurements/quantities to be expressed in SI units, followed where appropriate by the customary-unit equivalent in parentheses. Clause 5.4.7.2 requires numbers of more than four digits to be shown in groups of three counted from the decimal marker, using a space rather than a comma.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The tank capacity is 12,500 L.', false, 0),
      (v_question_id, 'The tank capacity is 12 500 L (3 302 gal).', true, 1),
      (v_question_id, 'The tank capacity is 3 302 gal (12 500 L).', false, 2),
      (v_question_id, 'The tank capacity is 12500 liters.', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Process Control in Agricultural Process Engineering (BIOPROCESS) — 7 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_fundamentals uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'BIOPROCESS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: BIOPROCESS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Process Control in Agricultural Process Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Process Control in Agricultural Process Engineering', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_fundamentals FROM public.subtopics WHERE name = 'Control System Fundamentals and Process Dynamics' AND topic_id = v_topic_id;
  IF v_sub_fundamentals IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Control System Fundamentals and Process Dynamics') RETURNING id INTO v_sub_fundamentals;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A mechanical grain dryer maintains a plenum air temperature of 43 °C by modulating the fuel valve of its burner. Midway through the drying run, a rain shower lowers the ambient air temperature entering the burner. With respect to the control system, the ambient air temperature is classified as the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'A mechanical grain dryer maintains a plenum air temperature of 43 °C by modulating the fuel valve of its burner. Midway through the drying run, a rain shower lowers the ambient air temperature entering the burner. With respect to the control system, the ambient air temperature is classified as the', 'single_choice', 'medium', 'A disturbance input is an undesired, unavoidable, uncontrolled flow of energy or material into a process. Ambient air temperature shifts the plenum temperature, but the operator has no authority over it — the definition of a disturbance.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'manipulated input', false, 0),
      (v_question_id, 'controlled output', false, 1),
      (v_question_id, 'disturbance input', true, 2),
      (v_question_id, 'setpoint', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is best classified as a tracking system rather than a regulator?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'Which of the following is best classified as a tracking system rather than a regulator?', 'single_choice', 'medium', 'A tracking system is one whose controlled output follows a command input that changes with time. In a programmed drying schedule the setpoint itself is a function of time, so the controller must continuously make the product temperature chase a moving target.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A laboratory oven held at 105 °C for gravimetric moisture determination', false, 0),
      (v_question_id, 'A pasta dryer programmed to follow a descending drying-temperature profile over the drying period', true, 1),
      (v_question_id, 'A float valve that maintains a constant water level in an overhead storage tank', false, 2),
      (v_question_id, 'A thermostat that holds a cold storage room at 4 °C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A closed-loop control system is distinguished from an open-loop control system by the presence of';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'A closed-loop control system is distinguished from an open-loop control system by the presence of', 'single_choice', 'medium', 'The defining feature of a closed loop (feedback control) is the measurement path: the controlled output is measured, compared with the desired output, and the result of that comparison drives the manipulated variable. Removing the measurement branch collapses the diagram back to an open loop.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a final control element that converts the control signal into a manipulated input', false, 0),
      (v_question_id, 'a controller that receives information about the desired value of the controlled output', false, 1),
      (v_question_id, 'a measurement device that returns the controlled output for comparison with the setpoint', true, 2),
      (v_question_id, 'a disturbance input acting on the process', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two process streams are blended at a mixing tee. Stream 1 carries component A at 2 g/L and flows at 15 L/min; Stream 2 carries component A at 6 g/L and flows at 25 L/min. Assuming constant density and no reaction, the concentration of component A in the blended stream is nearest to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'Two process streams are blended at a mixing tee. Stream 1 carries component A at 2 g/L and flows at 15 L/min; Stream 2 carries component A at 6 g/L and flows at 25 L/min. Assuming constant density and no reaction, the concentration of component A in the blended stream is nearest to', 'single_choice', 'hard', 'Mass balance on A: Ca1v1 + Ca2v2 = Ca3v3; overall balance: v3 = 15+25 = 40 L/min. (2)(15)+(6)(25) = 30+150 = 180 = Ca3(40) → Ca3 = 180/40 = 4.5 g/L', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.5 g/L', false, 0),
      (v_question_id, '4.0 g/L', false, 1),
      (v_question_id, '4.5 g/L', true, 2),
      (v_question_id, '8.0 g/L', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the float-and-linkage error detection mechanism of a water-level control system, the float is pinned at A, the fulcrum is at B, and the valve stem is connected at C. The link segments measure AB = 60 mm and BC = 20 mm. If the float detects a level error of 4.0 cm, the control signal produced by the linkage at the valve stem is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'In the float-and-linkage error detection mechanism of a water-level control system, the float is pinned at A, the fulcrum is at B, and the valve stem is connected at C. The link segments measure AB = 60 mm and BC = 20 mm. If the float detects a level error of 4.0 cm, the control signal produced by the linkage at the valve stem is', 'single_choice', 'hard', 'From similar triangles AA''C and BB''C: e/(l2+l1) = u/l1; u = [l1/(l1+l2)]×e = [20/(20+60)]×4.0 cm = 0.25×4.0 cm = 1.0 cm. The linkage is a purely proportional element; relocating the fulcrum is the mechanical equivalent of retuning a controller''s proportional gain.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.0 cm', true, 0),
      (v_question_id, '3.0 cm', false, 1),
      (v_question_id, '4.0 cm', false, 2),
      (v_question_id, '12.0 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the closed-loop temperature control system for the insulated stirred tank, which element compares the measured temperature with the setpoint and generates the error signal?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'In the closed-loop temperature control system for the insulated stirred tank, which element compares the measured temperature with the setpoint and generates the error signal?', 'single_choice', 'medium', 'The comparator receives the setpoint TR and the measured variable Tm and outputs ε = TR−Tm. Because Tm enters the summing point with a negative sign, the loop is negative feedback: the difference TR−Tm drives the final control element toward reducing the error.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Final control element', false, 0),
      (v_question_id, 'Comparator', true, 1),
      (v_question_id, 'Measuring element', false, 2),
      (v_question_id, 'Process block', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine the time constant of a well-mixed, insulated heated tank operating under the conditions below. Given: liquid density ρ = 1000 kg/m³; tank liquid volume V = 0.50 m³; mass flow rate in and out, w = 50 kg/min';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fundamentals, 'Determine the time constant of a well-mixed, insulated heated tank operating under the conditions below. Given: liquid density ρ = 1000 kg/m³; tank liquid volume V = 0.50 m³; mass flow rate in and out, w = 50 kg/min', 'single_choice', 'hard', 'τ = ρV/w = (1000 kg/m³)(0.50 m³)/(50 kg/min) = 10 min. τ is the residence time of the liquid in the tank (holdup ρV = 500 kg divided by throughput 50 kg/min); it depends only on the physical tank and flow, not on the heater or controller.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.10 min', false, 0),
      (v_question_id, '10 min', true, 1),
      (v_question_id, '500 min', false, 2),
      (v_question_id, '0.010 min', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Philippine National Standards on Technical Means for Ensuring Safety (POWER_ENERGY_MACHINERY) — 9 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Philippine National Standards on Technical Means for Ensuring Safety' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Philippine National Standards on Technical Means for Ensuring Safety', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice mill is fitted with a guard that prevents contact with the dangerous part from all sides, contains the major parts of the machine, is load bearing, and can only be removed during major repairs. Under the guard classifications of the standard, this guard is a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A rice mill is fitted with a guard that prevents contact with the dangerous part from all sides, contains the major parts of the machine, is load bearing, and can only be removed during major repairs. Under the guard classifications of the standard, this guard is a', 'single_choice', 'medium', 'Clause 6.2 describes the casing as a guard preventing contact from all sides and containing major parts of the machine. It is more permanent, is considered an integral part of the machinery, and can only be removed during major repairs, and should be load bearing.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'shield or cover', false, 0),
      (v_question_id, 'casing', true, 1),
      (v_question_id, 'enclosure', false, 2),
      (v_question_id, 'barrier rail', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which parts of an agri-fishery machine shall be treated as dangerous?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which parts of an agri-fishery machine shall be treated as dangerous?', 'single_choice', 'medium', 'Clause 5 states in general terms that all moving parts, including their fasteners and supports, shall be treated as dangerous during operation, then draws attention to specific items such as shafts, pulleys, belts, chains, and pinching/shearing points.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Only the exposed rotating shafts, pulleys, and belts', false, 0),
      (v_question_id, 'All moving parts, including their fasteners and supports', true, 1),
      (v_question_id, 'Only the parts located within the reach of the operator at the normal operating position', false, 2),
      (v_question_id, 'Only the parts that rotate faster than the rated speed of the prime mover', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For unguarded machinery components located above the operator, what is the minimum safety distance for upward reach for people standing upright?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'For unguarded machinery components located above the operator, what is the minimum safety distance for upward reach for people standing upright?', 'single_choice', 'easy', 'Clause 8.2.1 fixes the safety distance for upward reach at not less than 2 500 mm for people standing upright, measured for unguarded components located above the operator.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 000 mm', false, 0),
      (v_question_id, '2 000 mm', false, 1),
      (v_question_id, '2 400 mm', false, 2),
      (v_question_id, '2 500 mm', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the provisions on sideward or downward reach over barriers to apply, the barrier shall have a height of at least how much above the location a person can occupy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'For the provisions on sideward or downward reach over barriers to apply, the barrier shall have a height of at least how much above the location a person can occupy?', 'single_choice', 'easy', 'Clause 8.3.1 requires the height of barriers to be at least 1 000 mm above the location a person can occupy; values below 1 000 mm do not increase the reach and create a danger of falling toward the danger source.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '850 mm', false, 0),
      (v_question_id, '1 000 mm', true, 1),
      (v_question_id, '1 100 mm', false, 2),
      (v_question_id, '1 200 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A guard is provided with rectangular slots 28 mm wide. What is the minimum safety distance from the opening to the danger source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A guard is provided with rectangular slots 28 mm wide. What is the minimum safety distance from the opening to the danger source?', 'single_choice', 'hard', 'Given: width of aperture a = 28 mm (rectangular opening/slot). An aperture width of 28 mm falls within the range 20 < a < 40 mm, corresponding to hand access; the required safety distance to the danger source is therefore b > 230 mm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'b > 15 mm', false, 0),
      (v_question_id, 'b > 120 mm', false, 1),
      (v_question_id, 'b > 230 mm', true, 2),
      (v_question_id, 'b > 850 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum separation distance required at a pinching point so that it will not be considered dangerous to the leg?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'What is the minimum separation distance required at a pinching point so that it will not be considered dangerous to the leg?', 'single_choice', 'easy', 'The minimum separation distance at a pinching point so it is not considered dangerous to the leg is 180 mm. Clause 8.7 adds that the design must also ensure the next bigger part of the body cannot pass through.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 mm', false, 0),
      (v_question_id, '120 mm', false, 1),
      (v_question_id, '180 mm', true, 2),
      (v_question_id, '500 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An operator is exposed to the noise of a corn mill for four hours per day. What is the maximum permissible sound level for that exposure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An operator is exposed to the noise of a corn mill for four hours per day. What is the maximum permissible sound level for that exposure?', 'single_choice', 'easy', 'Clause 9 requires compliance with the Permissible Noise Level Exposure of the DOLE Occupational Safety and Health standards; for a four-hour daily exposure the maximum permissible sound level is 95 dB(A).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90 dB(A)', false, 0),
      (v_question_id, '92 dB(A)', false, 1),
      (v_question_id, '95 dB(A)', true, 2),
      (v_question_id, '100 dB(A)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which combination of guard rail details complies with the requirements for an operator''s standing platform?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which combination of guard rail details complies with the requirements for an operator''s standing platform?', 'single_choice', 'medium', 'Clause 12.2.2.2 requires a rail of not less than 1 000 mm and not more than 1 100 mm above the platform, an intermediate rail such that the vertical distance between any two rails does not exceed 500 mm, and a rail diameter of at least 10 mm. Only the 1 050 mm / 450 mm / 12 mm combination meets all three conditions.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rail height 900 mm; vertical distance between rails 600 mm; rail diameter 8 mm', false, 0),
      (v_question_id, 'Rail height 1 050 mm; vertical distance between rails 450 mm; rail diameter 12 mm', true, 1),
      (v_question_id, 'Rail height 1 200 mm; vertical distance between rails 500 mm; rail diameter 10 mm', false, 2),
      (v_question_id, 'Rail height 1 000 mm; vertical distance between rails 550 mm; rail diameter 10 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which requirement applies to the stopping device fitted to the power source of an agri-fishery machine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which requirement applies to the stopping device fitted to the power source of an agri-fishery machine?', 'single_choice', 'medium', 'Clause 12.5.4.1 requires the stopping device to stop the power source immediately, operate without depending on sustained manual effort, and prevent restart while in the stop position unless reset manually. Clause 12.5.4.3 requires the control to be red in color, preferably contrasting with the background and other controls.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It shall be green in color and shall remain effective only while it is being held down by the operator.', false, 0),
      (v_question_id, 'It shall be red in color, shall not depend on sustained manual effort, and shall require manual resetting before the power source can be started again.', true, 1),
      (v_question_id, 'It shall be yellow in color and shall reset automatically once the power source has come to a complete stop.', false, 2),
      (v_question_id, 'It may be of any color provided that it is mounted only on the power source itself and away from the operating control position.', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Selection of Tractor Size, Implements, and Other Specifications (POWER_ENERGY_MACHINERY) — 11 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Selection of Tractor Size, Implements, and Other Specifications' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Selection of Tractor Size, Implements, and Other Specifications', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the said Technical Bulletin, what is the resistance of the soil to tillage operation called?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under the said Technical Bulletin, what is the resistance of the soil to tillage operation called?', 'single_choice', 'easy', 'Draft is defined as the resistance of the soil to tillage operation. It should not be confused with drawbar power (power available at the drawbar or implement attachment point); torque and specific fuel consumption are not the terms defined.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Torque', false, 0),
      (v_question_id, 'Draft', true, 1),
      (v_question_id, 'Drawbar power', false, 2),
      (v_question_id, 'Specific fuel consumption', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-wheel tractor with four-wheel drive (4WD) can deliver up to what percentage of its rated engine power at the drawbar?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A four-wheel tractor with four-wheel drive (4WD) can deliver up to what percentage of its rated engine power at the drawbar?', 'single_choice', 'easy', 'A 4WD tractor receives tractive power from both rear and front wheels, so a greater share of rated engine power reaches the drawbar (up to 60%). A 2WD tractor, powered from the rear axle only, can deliver up to 50%.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40%', false, 0),
      (v_question_id, '50%', false, 1),
      (v_question_id, '60%', true, 2),
      (v_question_id, '75%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on Table 1 of the Technical Bulletin, what is the specific draft of clay loam soil?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Based on Table 1 of the Technical Bulletin, what is the specific draft of clay loam soil?', 'single_choice', 'easy', 'Specific draft is the force required to cut a cross-sectional area of soil; clay loam falls at 0.42 to 0.56 kg/cm² (6 to 8 lbs/in²). Sandy loam is 0.21-0.42, silty loam 0.35-0.49, and heavy clay 0.70-0.77.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.21-0.42 kg/cm²', false, 0),
      (v_question_id, '0.35-0.49 kg/cm²', false, 1),
      (v_question_id, '0.42-0.56 kg/cm²', true, 2),
      (v_question_id, '0.70-0.77 kg/cm²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At a working speed of 7.0 kph, what is the corresponding increase in draft?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'At a working speed of 7.0 kph, what is the corresponding increase in draft?', 'single_choice', 'medium', 'Higher forward speeds generate additional resistance during turning and pulverization, so this increase must be accounted for when estimating tractor size. Speed is characterized as slow at 2 kph, medium at 5 kph, and fast at 7 kph, giving increases of 130% (5.0 kph), 138% (6.0 kph), 147% (7.0 kph), and 156% (8.0 kph).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '130%', false, 0),
      (v_question_id, '138%', false, 1),
      (v_question_id, '147%', true, 2),
      (v_question_id, '156%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In computing field capacity and implement width, what field efficiency is recommended by the Technical Bulletin?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In computing field capacity and implement width, what field efficiency is recommended by the Technical Bulletin?', 'single_choice', 'easy', 'Field efficiency accounts for time lost to turning at headlands, overlapping of passes, and other non-productive activity during field operation; the bulletin recommends 80% field efficiency.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60%', false, 0),
      (v_question_id, '70%', false, 1),
      (v_question_id, '80%', true, 2),
      (v_question_id, '90%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Primary tillage implements such as disc plows, moldboard plows, chisel plows, and subsoilers cut the soil to a depth of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Primary tillage implements such as disc plows, moldboard plows, chisel plows, and subsoilers cut the soil to a depth of:', 'single_choice', 'easy', 'Primary tillage covers the initial soil-working operations of cutting, breaking, and inversion, designed to reduce soil strength, cover plant materials, and rearrange aggregates, cutting to a depth of 15 cm to 90 cm. It requires the most power of all operations, so primary tillage equipment must be identified first during tractor sizing.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7 cm to 15 cm', false, 0),
      (v_question_id, '10 cm to 50 cm', false, 1),
      (v_question_id, '15 cm to 90 cm', true, 2),
      (v_question_id, '20 cm to 100 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Secondary tillage implements such as disc, spike-tooth, and spring-tooth harrows prepare the soil to a depth of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Secondary tillage implements such as disc, spike-tooth, and spring-tooth harrows prepare the soil to a depth of:', 'single_choice', 'easy', 'Secondary tillage covers subsequent breaking, pulverization, and leveling of the soil to control weed growth and create seedbed surface configurations, to a depth of 7 cm to 15 cm — shallower and lower power than primary tillage.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 cm to 10 cm', false, 0),
      (v_question_id, '7 cm to 15 cm', true, 1),
      (v_question_id, '15 cm to 30 cm', false, 2),
      (v_question_id, '15 cm to 90 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Tractor trailers classified as hauling implements should have a capacity ranging from:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Tractor trailers classified as hauling implements should have a capacity ranging from:', 'single_choice', 'easy', 'Hauling implements allow transport of products, materials, or other equipment to and from the field; trailer capacity is tied to tractor weight (1.0 to 1.5 times) to maintain stability and safe traction during hauling.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 to 1.0 times the weight of the pulling tractor', false, 0),
      (v_question_id, '1.0 to 1.5 times the weight of the pulling tractor', true, 1),
      (v_question_id, '1.5 to 2.0 times the weight of the pulling tractor', false, 2),
      (v_question_id, '2.0 to 2.5 times the weight of the pulling tractor', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As a minimum, how many implements shall each distributed tractor be coupled with?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'As a minimum, how many implements shall each distributed tractor be coupled with?', 'single_choice', 'easy', 'The required composition is at least one unit of tillage implement (primary, secondary, or general-purpose), at least one unit of other implements (earth-moving, hauling, or PTO-driven), and a third implement of any type deemed necessary at the validated project site — three implements minimum.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One (1)', false, 0),
      (v_question_id, 'Two (2)', false, 1),
      (v_question_id, 'Three (3)', true, 2),
      (v_question_id, 'Four (4)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A disc plow with a working width of 90 cm operates at a depth of cut of 20 cm in silty loam soil having a specific draft of 0.42 kg/cm². The working speed is 5 kph, corresponding to a 130% increase in draft. Determine the recommended size of a two-wheel drive (2WD) tractor for this operation.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A disc plow with a working width of 90 cm operates at a depth of cut of 20 cm in silty loam soil having a specific draft of 0.42 kg/cm². The working speed is 5 kph, corresponding to a 130% increase in draft. Determine the recommended size of a two-wheel drive (2WD) tractor for this operation.', 'single_choice', 'hard', 'D(a) = D(s)×W×D×%increase = (0.42 kg/cm²)(90 cm)(20 cm)(1.30) = 982.80 kg. DHP = D(a)×S/274 = (982.80)(5)/274 = 17.93 hp. Rated Power = DHP/Power Factor = 17.93/0.50 = 35.87 ≈ 36 hp (two-wheel drive power factor 50%).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18 hp', false, 0),
      (v_question_id, '30 hp', false, 1),
      (v_question_id, '36 hp', true, 2),
      (v_question_id, '72 hp', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor is to serve a 200-hectare area, operating 8 hours per day, 30 days per month, over a 2-month season. Assuming a working speed of 5 kph and a field efficiency of 80%, determine the required width of implement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A tractor is to serve a 200-hectare area, operating 8 hours per day, 30 days per month, over a 2-month season. Assuming a working speed of 5 kph and a field efficiency of 80%, determine the required width of implement.', 'single_choice', 'hard', 'Total hours = (8)(30)(2) = 480 h. FC = Service area/Total hours = 200 ha/480 h = 0.42 ha/h. Width = (FC×10)/(S×Eff) = [(0.42)(10)]/[(5)(0.80)] = 1.04 m', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.83 m', false, 0),
      (v_question_id, '1.04 m', true, 1),
      (v_question_id, '1.25 m', false, 2),
      (v_question_id, '2.08 m', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Irrigation and Drainage Engineering (LAND_WATER) — 24 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_spis uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAND_WATER';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Irrigation and Drainage Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Irrigation and Drainage Engineering', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_spis FROM public.subtopics WHERE name = 'Design Preparation and Implementation of SPIS' AND topic_id = v_topic_id;
  IF v_sub_spis IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Design Preparation and Implementation of SPIS') RETURNING id INTO v_sub_spis;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the selection criteria of the said Technical Bulletin, what is the minimum service area required for an SPIS project intended for high value crops?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'Under the selection criteria of the said Technical Bulletin, what is the minimum service area required for an SPIS project intended for high value crops?', 'single_choice', 'easy', 'High value crops require a minimum service area of 3 hectares (organized farmers or a group willing to organize, holding at least 3 hectares irrigable area), while rice and corn require a minimum of 10 hectares with at least 15 organized/registered members.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 ha', false, 0),
      (v_question_id, '3 ha', true, 1),
      (v_question_id, '5 ha', false, 2),
      (v_question_id, '10 ha', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the design of an SPIS, which of the following is the correct sequence of the general design approach?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'In the design of an SPIS, which of the following is the correct sequence of the general design approach?', 'single_choice', 'medium', 'The design proceeds from demand to hardware: water requirement establishes the required flow rate, total dynamic head establishes the pressure the system must overcome; together these determine pump size, which drives PV array sizing, then the inverter, and finally wire sizing.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pump sizing → Water requirement → TDH → PV array → Inverter → Wire sizing', false, 0),
      (v_question_id, 'Water requirement → Pump sizing → TDH → Inverter → PV array → Wire sizing', false, 1),
      (v_question_id, 'Water requirement → TDH → Pump sizing → PV array → Inverter → Wire sizing', true, 2),
      (v_question_id, 'TDH → Water requirement → PV array → Pump sizing → Wire sizing → Inverter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT among the factors considered in the Field Water Balance for determining the irrigation water requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'Which of the following is NOT among the factors considered in the Field Water Balance for determining the irrigation water requirement?', 'single_choice', 'medium', 'The four Field Water Balance factors specified by the bulletin are rainfall at 80% dependability, type of crops and cropping pattern, soil type, and evaporation rate. Wind velocity and direction are collected in the Site Validation Form under meteorological/cropping data, but are not listed among the Field Water Balance factors.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rainfall (80% dependable)', false, 0),
      (v_question_id, 'Type of crops and cropping pattern', false, 1),
      (v_question_id, 'Soil type', false, 2),
      (v_question_id, 'Wind velocity', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In general, the maximum total head of an SPIS should not exceed:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'In general, the maximum total head of an SPIS should not exceed:', 'single_choice', 'easy', 'When pumping head is very high, multi-stage pumping may be used, but total head should generally remain within 200 meters. Total dynamic head is the sum of static head (vertical distance between intake and delivery water surfaces) and friction head loss through pipes/fittings.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 m', false, 0),
      (v_question_id, '100 m', false, 1),
      (v_question_id, '150 m', false, 2),
      (v_question_id, '200 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of pump is designed for high head and medium flow rates, but is very sensitive to dry run?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'Which type of pump is designed for high head and medium flow rates, but is very sensitive to dry run?', 'single_choice', 'medium', 'A submersible pump is very sensitive to dry running, so sustainability of the water source must be ensured; a float switch may regulate reservoir water level to prevent dry running. A surface pump is mounted above water level, suited for shallow wells with high flow/low head.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Surface pump', false, 0),
      (v_question_id, 'Submersible pump', true, 1),
      (v_question_id, 'Centrifugal pump', false, 2),
      (v_question_id, 'Booster pump', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Solar PV modules for an SPIS should be installed facing south with an angle of inclination of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'Solar PV modules for an SPIS should be installed facing south with an angle of inclination of:', 'single_choice', 'easy', 'This inclination (10-15°) optimizes the direct solar radiation received while remaining steep enough to allow rainfall to run off the panel surface for self-cleaning. The array must be installed unshaded at any time of year, with uniform PV module type/specifications throughout.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5-10°', false, 0),
      (v_question_id, '10-15°', true, 1),
      (v_question_id, '15-20°', false, 2),
      (v_question_id, '20-30°', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For cooling purposes, what is the recommended minimum spacing between solar PV strings?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'For cooling purposes, what is the recommended minimum spacing between solar PV strings?', 'single_choice', 'easy', 'Spacing between strings permits air movement around the modules, reducing the heat buildup that would otherwise derate array output — the same physical concern addressed by the temperature derating factor applied during array sizing.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 cm', false, 0),
      (v_question_id, '20 cm', true, 1),
      (v_question_id, '30 cm', false, 2),
      (v_question_id, '50 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In selecting wire size based on ampacity, the wire should be at least how much greater than the maximum load current flowing through it?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'In selecting wire size based on ampacity, the wire should be at least how much greater than the maximum load current flowing through it?', 'single_choice', 'easy', 'This margin (25%) prevents overheating of the conductor under sustained operation. A related requirement in the same section states that circuit conductors and overcurrent devices shall be sized to carry not less than 125% of the maximum current. The second factor in wire selection is voltage drop, significant in low-voltage, high-current applications.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', false, 0),
      (v_question_id, '15%', false, 1),
      (v_question_id, '20%', false, 2),
      (v_question_id, '25%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a reservoir constructed as part of an SPIS, the flooring of the tank should have a slope of at least:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'For a reservoir constructed as part of an SPIS, the flooring of the tank should have a slope of at least:', 'single_choice', 'easy', 'The slope (2%) allows complete drainage of the tank during cleaning and maintenance. The reservoir must also have inlet, outlet, drain, and overflow pipes, plus an access ladder inside and outside with a safe landing and handrail.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1%', false, 0),
      (v_question_id, '2%', true, 1),
      (v_question_id, '3%', false, 2),
      (v_question_id, '4%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An SPIS is designed for a total daily water requirement of 168 m³. The site has an average peak sun hour (PSH) of 5 hours, and the system uses a piped distribution network with an irrigation efficiency of 0.70. Determine the required daily flow rate of the system.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'An SPIS is designed for a total daily water requirement of 168 m³. The site has an average peak sun hour (PSH) of 5 hours, and the system uses a piped distribution network with an irrigation efficiency of 0.70. Determine the required daily flow rate of the system.', 'single_choice', 'hard', 'Q = Total daily water requirement / (Average PSH × n) = 168 m³ / [(5 h)(0.70)] = 168 m³ / 3.5 h = 48.00 m³/h', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '33.6 m³/h', false, 0),
      (v_question_id, '42.0 m³/h', false, 1),
      (v_question_id, '48.0 m³/h', true, 2),
      (v_question_id, '52.5 m³/h', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pump with a capacity of 5 hp is selected for an SPIS based on market availability. Using a safety factor of 1.6, determine the required total power of the solar PV array and the minimum capacity of the inverter.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_spis, 'A pump with a capacity of 5 hp is selected for an SPIS based on market availability. Using a safety factor of 1.6, determine the required total power of the solar PV array and the minimum capacity of the inverter.', 'single_choice', 'hard', 'P(pump) = (5 hp)(0.746 kW/hp) = 3.73 kW. P(SA) = P(pump)×SF = (3.73)(1.6) = 5.97 kW. P(inverter) = P(pump)×1.25 = (3.73)(1.25) = 4.66 kW', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Psa = 5.97 kW; Pinv = 4.66 kW', true, 0),
      (v_question_id, 'Psa = 5.97 kW; Pinv = 3.73 kW', false, 1),
      (v_question_id, 'Psa = 3.73 kW; Pinv = 5.97 kW', false, 2),
      (v_question_id, 'Psa = 8.00 kW; Pinv = 6.25 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Groundwater Irrigation) Among the shallow tubewell types, this one is driven into unconsolidated formations and must be avoided where large gravel or boulders are present because the drive point may be damaged. (PNS/BAFS/PAES 231:2017)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Groundwater Irrigation) Among the shallow tubewell types, this one is driven into unconsolidated formations and must be avoided where large gravel or boulders are present because the drive point may be damaged. (PNS/BAFS/PAES 231:2017)', 'single_choice', 'medium', 'Driven well: installed in unconsolidated formations with shallow water tables that do not contain too many rocks; the drive point is hammered down, so gravel/boulders will damage it. Dug well: used in unconsolidated formations, large diameters permit storage. Bored (augered) well: very shallow water table, formation does not cave. Jetted well: formed by the cutting action of a downward-directed stream of water.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dug well', false, 0),
      (v_question_id, 'Bored (augered) well', false, 1),
      (v_question_id, 'Driven well', true, 2),
      (v_question_id, 'Jetted well', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Groundwater Irrigation) This site investigation technique measures the physical properties of the earth''s crust, and the findings are interpreted in terms of rock type and porosity, water content, and water quality. (PNS/BAFS/PAES 231:2017)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Groundwater Irrigation) This site investigation technique measures the physical properties of the earth''s crust, and the findings are interpreted in terms of rock type and porosity, water content, and water quality. (PNS/BAFS/PAES 231:2017)', 'single_choice', 'medium', 'Geophysical exploration (surface): uses scientific measurement of physical properties of the earth''s crust for mineral deposit/geologic structure investigation. Geologic investigation: preliminary basis for groundwater potential. Remote sensing: determines groundwater conditions from aircraft/satellite imagery. Geophysical logging (subsurface): lowers sensing devices into the borehole for formation characteristics and groundwater quantity/quality/movement.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geologic investigation', false, 0),
      (v_question_id, 'Remote sensing', false, 1),
      (v_question_id, 'Geophysical exploration', true, 2),
      (v_question_id, 'Geophysical logging', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Principles of Fluid Mechanics) Open channel flow in which inertia forces dominate gravity forces, so that the Froude number exceeds unity, is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Principles of Fluid Mechanics) Open channel flow in which inertia forces dominate gravity forces, so that the Froude number exceeds unity, is called', 'single_choice', 'medium', 'Supercritical (rapid/shooting) flow occurs when Fr > 1; surface disturbances cannot travel upstream and are swept downstream. Critical flow occurs at Fr=1, subcritical at Fr<1. Laminar/turbulent flow are classified by Reynolds number, not Froude number.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'critical flow', false, 0),
      (v_question_id, 'subcritical flow', false, 1),
      (v_question_id, 'supercritical flow', true, 2),
      (v_question_id, 'laminar flow', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Principles of Fluid Mechanics) In this regime the flow is slow enough that surface waves are able to travel upstream against the current. It is also described as tranquil or streaming flow.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Principles of Fluid Mechanics) In this regime the flow is slow enough that surface waves are able to travel upstream against the current. It is also described as tranquil or streaming flow.', 'single_choice', 'medium', 'Subcritical flow (Fr < 1) is tranquil/streaming; flow velocity is less than wave celerity, so disturbances propagate upstream. In supercritical flow, disturbances cannot move upstream. Turbulent flow is characterized by pulsatory cross-current velocities, Reynolds number 4,000 or more.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Critical flow', false, 0),
      (v_question_id, 'Subcritical flow', true, 1),
      (v_question_id, 'Supercritical flow', false, 2),
      (v_question_id, 'Turbulent flow', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Irrigation Efficiencies) Expressed in percent, this is the ratio of the water stored in the soil root zone during irrigation to the water actually delivered to the farm.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Irrigation Efficiencies) Expressed in percent, this is the ratio of the water stored in the soil root zone during irrigation to the water actually delivered to the farm.', 'single_choice', 'medium', 'Application efficiency measures how much of the water delivered to the farm is retained in the root zone where the crop can use it. Conveyance efficiency = water delivered to farm over water diverted from source. Water-storage efficiency = water stored in root zone over water needed in root zone prior to irrigation. Consumptive-use efficiency = normal consumptive use over net amount depleted from root zone soil.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Application efficiency', true, 0),
      (v_question_id, 'Conveyance efficiency', false, 1),
      (v_question_id, 'Water-storage efficiency', false, 2),
      (v_question_id, 'Consumptive-use efficiency', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Irrigation Efficiencies) Losses through seepage and evaporation along the main canal and laterals are accounted for by which efficiency term?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Irrigation Efficiencies) Losses through seepage and evaporation along the main canal and laterals are accounted for by which efficiency term?', 'single_choice', 'medium', 'Conveyance efficiency is the ratio between water delivered to the farm and water diverted from a river/reservoir, reflecting transit losses of the delivery system. Application efficiency deals with losses within the farm during actual irrigation; water-storage efficiency compares water stored against water required.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Application efficiency', false, 0),
      (v_question_id, 'Conveyance efficiency', true, 1),
      (v_question_id, 'Water-storage efficiency', false, 2),
      (v_question_id, 'Distribution efficiency', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Fluid Mechanics) When a moving fluid is brought to rest at a point, the pressure at that point equals the sum of the static and dynamic pressures. This pressure is termed';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Fluid Mechanics) When a moving fluid is brought to rest at a point, the pressure at that point equals the sum of the static and dynamic pressures. This pressure is termed', 'single_choice', 'medium', 'Stagnation pressure = static pressure + dynamic pressure. Total pressure is the sum of static, dynamic, and hydrostatic pressures. Hydrostatic pressure accounts for the effect of elevation on the pressure of a fluid at rest.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'stagnation pressure', true, 0),
      (v_question_id, 'total pressure', false, 1),
      (v_question_id, 'hydrostatic pressure', false, 2),
      (v_question_id, 'potential pressure', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Fluid Mechanics) Water flows through an 80-mm diameter pipe under a gauge pressure of 4.0 bar at a mean velocity of 2.0 m/s. Neglecting friction, determine the total head if the pipe lies 6 meters above the datum line.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Fluid Mechanics) Water flows through an 80-mm diameter pipe under a gauge pressure of 4.0 bar at a mean velocity of 2.0 m/s. Neglecting friction, determine the total head if the pipe lies 6 meters above the datum line.', 'single_choice', 'hard', 'Given: D=80mm; p=4.0 bar=4.0×10^5 N/m²; v=2.0 m/s; Z=6 m; γ=9,810 N/m³. By Bernoulli''s equation: H = Z + v²/2g + p/γ = 6 + (2.0)²/(2×9.81) + (4.0×10^5)/9,810 = 6 + 0.204 + 40.775 = 46.98 m. The velocity head is small compared with the pressure head; pipe diameter is extraneous since velocity is already given.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40.98 m', false, 0),
      (v_question_id, '44.50 m', false, 1),
      (v_question_id, '46.98 m', true, 2),
      (v_question_id, '52.30 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Pump Size Determination and Specification) The impeller speed of a centrifugal pump is raised from 1 750 rpm to 2 100 rpm. By what factor will the power requirement increase?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Pump Size Determination and Specification) The impeller speed of a centrifugal pump is raised from 1 750 rpm to 2 100 rpm. By what factor will the power requirement increase?', 'single_choice', 'hard', 'By the affinity laws, power varies with the cube of speed: P2/P1 = (N2/N1)³ = (2,100/1,750)³ = (1.20)³ = 1.728. Discharge varies directly with speed (1.20) and head with the square of speed (1.44).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.200', false, 0),
      (v_question_id, '1.440', false, 1),
      (v_question_id, '1.728', true, 2),
      (v_question_id, '2.074', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Pump Size Determination and Specification) Compute the brake horsepower of a pump required to lift a fluid (ρ = 1.2 g/cc) at 250 gpm against a total head of 8 meters. Assume a pump efficiency of 65%.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Pump Size Determination and Specification) Compute the brake horsepower of a pump required to lift a fluid (ρ = 1.2 g/cc) at 250 gpm against a total head of 8 meters. Assume a pump efficiency of 65%.', 'single_choice', 'hard', 'γ = 1.2 g/cm³ × 62.3 lb/ft³ per g/cm³ = 74.8 lb/ft³. Q = 250 gal/min × (1 ft³/7.48 gal) = 33.42 ft³/min. H = 8 m × 3.28 ft/m = 26.24 ft. BHP = γQH/(33,000η) = (74.8)(33.42)(26.24)/[33,000(0.65)] = 65,594/21,450 = 3.06 hp', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.65 hp', false, 0),
      (v_question_id, '3.06 hp', true, 1),
      (v_question_id, '3.58 hp', false, 2),
      (v_question_id, '4.71 hp', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Irrigation and Drainage Systems) For a 12 m × 12 m sprinkler spacing, what design sprinkler throw is required to obtain a 50% overlap?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Irrigation and Drainage Systems) For a 12 m × 12 m sprinkler spacing, what design sprinkler throw is required to obtain a 50% overlap?', 'single_choice', 'hard', 'Throw = radius of sprinkler + radius × %overlap = 12/2 + (12/2)(0.50) = 6.0 + 3.0 = 9.0 m. The overlap allowance ensures uniform distribution where wetted circles of adjacent sprinklers meet.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.0 m', false, 0),
      (v_question_id, '7.2 m', false, 1),
      (v_question_id, '9.0 m', true, 2),
      (v_question_id, '12.0 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Irrigation and Drainage Systems) For an 8 m × 8 m sprinkler spacing, what is the design sprinkler throw for a 40% overlap?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Irrigation and Drainage Systems) For an 8 m × 8 m sprinkler spacing, what is the design sprinkler throw for a 40% overlap?', 'single_choice', 'hard', 'Throw = 8/2 + (8/2)(0.40) = 4.00 + 1.60 = 5.60 m. A lower percent overlap gives a shorter required throw, but distribution uniformity also drops, particularly under windy conditions.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.00 m', false, 0),
      (v_question_id, '5.60 m', true, 1),
      (v_question_id, '6.40 m', false, 2),
      (v_question_id, '11.20 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '(Irrigation and Drainage Systems) How many sprinklers spaced 8 m × 8 m are needed to irrigate a rectangular field 120 m × 200 m if the laterals are laid parallel to the longer side of the field?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '(Irrigation and Drainage Systems) How many sprinklers spaced 8 m × 8 m are needed to irrigate a rectangular field 120 m × 200 m if the laterals are laid parallel to the longer side of the field?', 'single_choice', 'hard', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 1-70)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '300', false, 0),
      (v_question_id, '360', false, 1),
      (v_question_id, '375', true, 2),
      (v_question_id, '384', false, 3);
  END IF;
END $$;

