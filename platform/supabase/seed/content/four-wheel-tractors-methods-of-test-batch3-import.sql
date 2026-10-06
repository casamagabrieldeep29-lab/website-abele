-- Four-Wheel Tractors Methods of Test quiz batch 3 (33 questions, 1 topic). Every fact, number and formula
-- is drawn directly from the clauses and annexes of PAES 119:2001 (Agricultural Machinery -
-- Four-Wheel Tractor - Methods of Test), read in full - no invented facts. The earlier draft
-- batch for this topic covers the specifications standard (PAES 118) and the first imported
-- set covers PTO power, SFC, drawbar power, hydraulic power, the 2 percent repeat rule,
-- 15 percent wheel slip, turning-test conditions and the 18 percent parking gradient;
-- this batch avoids those angles.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=true with paes_reference set to
-- 'PAES 119:2001' because every question is about a clause or annex formula of that standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Four-Wheel Tractors Methods of Test (POWER_ENERGY_MACHINERY) -- 33 question(s)
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
    RAISE EXCEPTION 'Topic not found: Four-Wheel Tractors Methods of Test';
  END IF;

  -- 1. Purpose - verify PAES 118
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 119:2001 (Four-Wheel Tractor - Methods of Test), the tests and inspection are used to verify the requirements specified in which standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 119:2001 (Four-Wheel Tractor - Methods of Test), the tests and inspection are used to verify the requirements specified in which standard?', 'single_choice', 'easy', 'Clause 1.1 (Scope): the methods of test and inspection shall be used to verify the requirements specified in PAES 118 (Four-Wheel Tractor - Specifications) and the specifications submitted by the manufacturer.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ISO 730-1:1994 (Rear-mounted three-point linkage)', false, 0),
      (v_question_id, 'PAES 103:2000 (Method of Sampling)', false, 1),
      (v_question_id, 'PAES 118:2001 (Four-Wheel Tractor - Specifications)', true, 2),
      (v_question_id, 'IEC 60651:1979 (Sound level meters)', false, 3);
  END IF;

  -- 2. Tractor weight definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 119:2001, the "tractor weight" is defined as the total weight of the tractor excluding tools, with the fuel tank filled to what level and with what other fluids?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 119:2001, the "tractor weight" is defined as the total weight of the tractor excluding tools, with the fuel tank filled to what level and with what other fluids?', 'single_choice', 'medium', 'Clause 3.5: tractor weight is the total weight of the tractor excluding tools, with the fuel tank filled to 80 percent capacity and with normal amounts of cooling water and lubricating oil when the tractor is at work.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fuel tank filled to 100 percent capacity, with the implement attached', false, 0),
      (v_question_id, 'Fuel tank filled to 80 percent capacity, with normal amounts of cooling water and lubricating oil', true, 1),
      (v_question_id, 'Fuel tank filled to 50 percent capacity, with a 75 kg driver and liquid ballast', false, 2),
      (v_question_id, 'Fuel tank completely empty, with no cooling water or lubricating oil', false, 3);
  END IF;

  -- 3. Radius of turning circle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 119:2001, which statement correctly defines the "radius of turning circle" of a four-wheel tractor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 119:2001, which statement correctly defines the "radius of turning circle" of a four-wheel tractor?', 'single_choice', 'medium', 'Clause 3.10: the radius of turning circle is the radius of the smallest circle tangentially described by the median plane of the outermost wheel of the tractor. The radius of turning area (clearance circle, clause 3.9) is instead the radius of the smallest circle described by the outermost point of the tractor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The radius of the smallest circle tangentially described by the median plane of the outermost wheel of the tractor', true, 0),
      (v_question_id, 'One-half of the wheelbase of the tractor', false, 1),
      (v_question_id, 'The radius of the smallest circle described by the outermost point of any part of the tractor', false, 2),
      (v_question_id, 'The distance from the turning center to the midpoint of the rear axle', false, 3);
  END IF;

  -- 4. Maximum drawbar pull definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is the definition of "maximum drawbar pull" used in PAES 119:2001?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is the definition of "maximum drawbar pull" used in PAES 119:2001?', 'single_choice', 'medium', 'Clause 3.4: maximum drawbar pull is the mean maximum sustained pull of the tractor at the drawbar over a given distance, the pull being exerted horizontally and in the vertical plane containing the longitudinal axis of the tractor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The pull obtained at exactly 15 percent wheel slip regardless of distance', false, 0),
      (v_question_id, 'The highest instantaneous pull recorded at the moment the wheels lock', false, 1),
      (v_question_id, 'The pull measured at the power take-off shaft at rated engine speed', false, 2),
      (v_question_id, 'The mean maximum sustained pull at the drawbar over a given distance, exerted horizontally in the vertical plane containing the longitudinal axis of the tractor', true, 3);
  END IF;

  -- 5. Atmospheric pressure limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 119:2001, the atmospheric pressure during the tractor tests shall not be less than:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 119:2001, the atmospheric pressure during the tractor tests shall not be less than:', 'single_choice', 'easy', 'Clause 4.7: no corrections are made to the test results for atmospheric conditions, and atmospheric pressure shall not be less than 96.6 kPa. If this is not possible because of altitude, a modified injection pump setting may be used, and the details and pressure are noted in the report.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '96.6 kPa', true, 0),
      (v_question_id, '92.5 kPa', false, 1),
      (v_question_id, '101.3 kPa', false, 2),
      (v_question_id, '85.0 kPa', false, 3);
  END IF;

  -- 6. Instrument accuracy table
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to the table of minimum scale of accuracy of measuring instruments in PAES 119:2001, what are the minimum scales required for measuring distance and volume, respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to the table of minimum scale of accuracy of measuring instruments in PAES 119:2001, what are the minimum scales required for measuring distance and volume, respectively?', 'single_choice', 'hard', 'Table 1 (clause 4.8): the minimum scale of accuracy is 1 mm for distance and 10 ml for volume (also 1 kg for weight, 0.5 s for time, and 1 degree C for temperature; rotational speed, drawbar pull and pressure need 1 percent of the measured value).', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 mm for distance and 1 ml for volume', false, 0),
      (v_question_id, '1 mm for distance and 10 ml for volume', true, 1),
      (v_question_id, '1 cm for distance and 1 L for volume', false, 2),
      (v_question_id, '1 cm for distance and 10 ml for volume', false, 3);
  END IF;

  -- 7. PTO test - transmission losses
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the power take-off (PTO) performance test of PAES 119:2001, how are the torque and power values in the test report obtained with respect to losses between the PTO and the dynamometer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the power take-off (PTO) performance test of PAES 119:2001, how are the torque and power values in the test report obtained with respect to losses between the PTO and the dynamometer?', 'single_choice', 'medium', 'Clause 5.2.1.1: the torque and power values in the test report shall be obtained from the dynamometer bench without correction for losses in power transmission between the power take-off and the dynamometer bench. The connecting shaft shall not have any appreciable angularity.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'They are computed from the flywheel power measured with the PTO shaft removed', false, 0),
      (v_question_id, 'They are corrected upward using a transmission efficiency factor given by the manufacturer', false, 1),
      (v_question_id, 'They are taken from the drawbar test and converted to PTO values', false, 2),
      (v_question_id, 'They are read from the dynamometer bench without correction for transmission losses', true, 3);
  END IF;

  -- 8. Full load varying speed lower limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the PTO test at full load and varying speed, the test shall go down to an engine speed at least how much below the speed at which maximum torque occurs, or to what fraction of the rated engine speed, whichever speed is lower?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the PTO test at full load and varying speed, the test shall go down to an engine speed at least how much below the speed at which maximum torque occurs, or to what fraction of the rated engine speed, whichever speed is lower?', 'single_choice', 'hard', 'Clause 5.2.1.3: to plot the curves, the test shall go down to an engine speed at least 15 percent below the speed at which maximum torque occurs, or to an engine speed at least 50 percent of the rated engine speed, whichever is lower (subject to safe operation and any limitation agreed with the testing station).', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least 10 percent below; 60 percent of rated speed', false, 0),
      (v_question_id, 'At least 5 percent below; 40 percent of rated speed', false, 1),
      (v_question_id, 'At least 15 percent below; 50 percent of rated speed', true, 2),
      (v_question_id, 'At least 25 percent below; 75 percent of rated speed', false, 3);
  END IF;

  -- 9. Hydraulic lift test points
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In determining the lifting force at the lower hitch points, the force and hydraulic pressure are measured at a minimum of how many points through the lift range, and the measured forces are corrected to what hydraulic pressure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In determining the lifting force at the lower hitch points, the force and hydraulic pressure are measured at a minimum of how many points through the lift range, and the measured forces are corrected to what hydraulic pressure?', 'single_choice', 'hard', 'Clause 5.2.2.2.1: the lifting force and the corresponding fluid pressure are determined at a minimum of six points approximately equally spaced throughout the range of movement, including one at each extremity. The measured forces are corrected to a hydraulic pressure equivalent to 90 percent of the actual relief valve pressure setting.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Six points; 100 percent of the relief valve setting', false, 0),
      (v_question_id, 'Six points; 90 percent of the relief valve setting', true, 1),
      (v_question_id, 'Ten points; 75 percent of the relief valve setting', false, 2),
      (v_question_id, 'Four points; 100 percent of the relief valve setting', false, 3);
  END IF;

  -- 10. Coupled frame center of gravity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the lift test on a coupled frame attached to the three-point linkage, the center of gravity of the frame shall be located at what distance to the rear of the lower hitch points?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For the lift test on a coupled frame attached to the three-point linkage, the center of gravity of the frame shall be located at what distance to the rear of the lower hitch points?', 'single_choice', 'hard', 'Clause 5.2.2.2.2: the center of gravity of the frame shall be at a point 610 mm to the rear of the lower hitch points, on a line at right angles to the mast and passing through the middle of the line joining the lower hitch points.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '610 mm', true, 0),
      (v_question_id, '305 mm', false, 1),
      (v_question_id, '460 mm', false, 2),
      (v_question_id, '810 mm', false, 3);
  END IF;

  -- 11. Test surface for steel-wheeled or tracked
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the drawbar tests of PAES 119:2001, tractors that are not suitable for operation on concrete or tarmacadam, such as steel-wheeled or steel-tracked tractors, shall be tested on:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the drawbar tests of PAES 119:2001, tractors that are not suitable for operation on concrete or tarmacadam, such as steel-wheeled or steel-tracked tractors, shall be tested on:', 'single_choice', 'medium', 'Clause 5.2.3.1.2: such tractors shall be tested on flat, dry and horizontal, mown or grazed grassland, or on a horizontal track having equivalent adhesion characteristics. The type of test track shall be clearly stated in the report.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Loose sand of at least 300 mm depth', false, 0),
      (v_question_id, 'A wet, freshly plowed paddy field', false, 1),
      (v_question_id, 'A sloping gravel road with a 10 percent gradient', false, 2),
      (v_question_id, 'A flat, dry and horizontal mown or grazed grassland, or a horizontal track with equivalent adhesion', true, 3);
  END IF;

  -- 12. Track slip footnote 7 percent
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For track-laying tractors in the drawbar test, the maximum drawbar pull with its corresponding track slip, and also the point corresponding to a track slip of what value or more, shall be stated as a footnote beneath the table of drawbar power values?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For track-laying tractors in the drawbar test, the maximum drawbar pull with its corresponding track slip, and also the point corresponding to a track slip of what value or more, shall be stated as a footnote beneath the table of drawbar power values?', 'single_choice', 'hard', 'Clause 5.2.3.1.3: for track-laying tractors, the maximum drawbar pull, together with the corresponding track slip, and also the point corresponding to a track slip of 7 percent or more shall be stated as a footnote beneath the drawbar power table (for wheeled tractors, values are reported only up to 15 percent mean wheel slip).', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 percent', false, 0),
      (v_question_id, '3 percent', false, 1),
      (v_question_id, '7 percent', true, 2),
      (v_question_id, '12 percent', false, 3);
  END IF;

  -- 13. Center of gravity test conditions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 119:2001, the position of the center of gravity of the test tractor is determined with the tractor in what condition?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 119:2001, the position of the center of gravity of the test tractor is determined with the tractor in what condition?', 'single_choice', 'medium', 'Clause 5.2.5: the position is determined with full tanks and the driver replaced by a weight of 75 kg on the driver''s seat, the tractor being otherwise unballasted (procedures of ISO 789-6 may be used).', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'With full tanks, ballasted to maximum mass, and no driver weight', false, 0),
      (v_question_id, 'With full tanks and a 75 kg weight on the driver''s seat, otherwise unballasted', true, 1),
      (v_question_id, 'With empty tanks and no driver weight, fully ballasted', false, 2),
      (v_question_id, 'With half-filled tanks and liquid ballast in all tires', false, 3);
  END IF;

  -- 14. Cold brake criterion enclosed brakes
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the cold service braking test, a totally enclosed brake (including oil-immersed brakes) is deemed cold if the temperature measured on the outside of the housing is below:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For the cold service braking test, a totally enclosed brake (including oil-immersed brakes) is deemed cold if the temperature measured on the outside of the housing is below:', 'single_choice', 'hard', 'Clause 5.2.6.2.1: a brake is deemed cold if the disc or drum outside temperature is below 100 degrees C; for totally enclosed brakes, including oil-immersed brakes, the temperature on the outside of the housing is below 50 degrees C; or the brakes have not been actuated for one hour.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 degrees C', true, 0),
      (v_question_id, '35 degrees C', false, 1),
      (v_question_id, '75 degrees C', false, 2),
      (v_question_id, '100 degrees C', false, 3);
  END IF;

  -- 15. Braking test initial speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the cold service braking device test, the tractor is driven at what initial speed before the measured force is applied to the brake control?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the cold service braking device test, the tractor is driven at what initial speed before the measured force is applied to the brake control?', 'single_choice', 'medium', 'Clause 5.2.6.2.4: with the tractor traveling at its maximum speed or 50 +/- 5 km/h, whichever is less, a measured force is applied to the control of the service braking device and the resulting stopping distance is measured.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Exactly 30 km/h on an uphill road', false, 0),
      (v_question_id, 'Always 20 km/h, regardless of the tractor''s maximum speed', false, 1),
      (v_question_id, 'Its maximum speed or 50 +/- 5 km/h, whichever is less', true, 2),
      (v_question_id, 'Its maximum speed or 80 km/h, whichever is greater', false, 3);
  END IF;

  -- 16. Field test plot size
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the field performance test of a four-wheel tractor under PAES 119:2001, the field operations are done on a plot of what minimum size and shape, with at least how many replications?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For the field performance test of a four-wheel tractor under PAES 119:2001, the field operations are done on a plot of what minimum size and shape, with at least how many replications?', 'single_choice', 'medium', 'Clause 5.3.3: field operations are done on fields of not less than 2,500 m2, rectangular with sides in the ratio of 2:1 as far as possible, with at least two replications. The depth of tillage depends on the maximum recommended depth of cut of the implement.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Not less than 2,500 m2, square, with one replication', false, 0),
      (v_question_id, 'Not less than 1,000 m2, square, with one replication', false, 1),
      (v_question_id, 'Not less than 5,000 m2, rectangular with sides 3:1, with at least three replications', false, 2),
      (v_question_id, 'Not less than 2,500 m2, rectangular with sides 2:1, with at least two replications', true, 3);
  END IF;

  -- 17. Noise limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 119:2001, the noise emitted by the tractor, measured 50 mm away from the operator''s ear level, shall not be more than:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 119:2001, the noise emitted by the tractor, measured 50 mm away from the operator''s ear level, shall not be more than:', 'single_choice', 'medium', 'Clause 5.3.5.2.2: the noise measured 50 mm from the operator''s ear level shall not exceed 92 dB(A). The footnote notes this is the allowable level for six hours of continuous exposure based on the Philippine Occupational Safety and Health Standards.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '105 dB(A)', false, 0),
      (v_question_id, '92 dB(A)', true, 1),
      (v_question_id, '85 dB(A)', false, 2),
      (v_question_id, '98 dB(A)', false, 3);
  END IF;

  -- 18. Test report order
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the test report prescribed by PAES 119:2001, which item comes immediately after the "Summary"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the test report prescribed by PAES 119:2001, which item comes immediately after the "Summary"?', 'single_choice', 'easy', 'Clause 7: the report contains, in order: name of testing agency, test report number, title, summary, purpose and scope of test, methods of test, description of the four-wheel tractor, results of laboratory tests, results of field test, observations, and name and signature of test engineers.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Purpose and scope of test', true, 0),
      (v_question_id, 'Title', false, 1),
      (v_question_id, 'Results of laboratory tests', false, 2),
      (v_question_id, 'Methods of test', false, 3);
  END IF;

  -- 19. Wheel slip
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a drawbar test, the sum of the revolutions of all driving wheels over a given distance with slip is 50 rev, and the sum of the revolutions over the same distance without slip is 43 rev. What is the wheel slip? (Wheel slip = (N1 - N0)/N1 x 100, where N1 is the revolutions with slip and N0 is the revolutions without slip.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a drawbar test, the sum of the revolutions of all driving wheels over a given distance with slip is 50 rev, and the sum of the revolutions over the same distance without slip is 43 rev. What is the wheel slip? (Wheel slip = (N1 - N0)/N1 x 100, where N1 is the revolutions with slip and N0 is the revolutions without slip.)', 'single_choice', 'medium', 'Given: N1 = 50 rev, N0 = 43 rev. Wheel slip = (50 - 43)/50 x 100 = 7/50 x 100 = 14 percent.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16.3 percent', false, 0),
      (v_question_id, '86.0 percent', false, 1),
      (v_question_id, '14.0 percent', true, 2),
      (v_question_id, '7.0 percent', false, 3);
  END IF;

  -- 20. Mean deceleration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a cold service braking test, a four-wheel tractor traveling at an initial speed of 50 km/h comes to a stop after a stopping distance of 20 m. Using f = V^2/(2S), what is the mean deceleration?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a cold service braking test, a four-wheel tractor traveling at an initial speed of 50 km/h comes to a stop after a stopping distance of 20 m. Using f = V^2/(2S), what is the mean deceleration?', 'single_choice', 'medium', 'Given: V = 50 km/h = 50/3.6 = 13.89 m/s; S = 20 m. f = V^2/(2S) = (13.89)^2/(2 x 20) = 192.9/40 = 4.82 m/s2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '62.5 m/s2', false, 0),
      (v_question_id, '0.69 m/s2', false, 1),
      (v_question_id, '9.64 m/s2', false, 2),
      (v_question_id, '4.82 m/s2', true, 3);
  END IF;

  -- 21. Stopping distance from deceleration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-wheel tractor travels at 36 km/h when the driver begins to actuate the service brake, and the mean deceleration over the stop is 4 m/s2. Using f = V^2/(2S), what is the stopping distance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A four-wheel tractor travels at 36 km/h when the driver begins to actuate the service brake, and the mean deceleration over the stop is 4 m/s2. Using f = V^2/(2S), what is the stopping distance?', 'single_choice', 'hard', 'Given: V = 36 km/h = 10 m/s; f = 4 m/s2. S = V^2/(2f) = (10)^2/(2 x 4) = 100/8 = 12.5 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9.0 m', false, 0),
      (v_question_id, '12.5 m', true, 1),
      (v_question_id, '25.0 m', false, 2),
      (v_question_id, '6.25 m', false, 3);
  END IF;

  -- 22. Operating speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the field test, two poles are placed 20 m apart along the test run, and a tractor takes 9 s to travel between the lines connecting the poles. What is the operating speed in km/h?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the field test, two poles are placed 20 m apart along the test run, and a tractor takes 9 s to travel between the lines connecting the poles. What is the operating speed in km/h?', 'single_choice', 'easy', 'Given: distance = 20 m, time = 9 s. Speed = 20/9 = 2.22 m/s; multiplied by 3.6 gives 8.0 km/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.45 km/h', false, 0),
      (v_question_id, '28.8 km/h', false, 1),
      (v_question_id, '8.0 km/h', true, 2),
      (v_question_id, '2.22 km/h', false, 3);
  END IF;

  -- 23. Shaft torque T = F x L
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pony brake with an arm length of 0.8 m carries an axle (rotary shaft) load of 45 kg. Using T = F x L, what is the axle torque in kg-m?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pony brake with an arm length of 0.8 m carries an axle (rotary shaft) load of 45 kg. Using T = F x L, what is the axle torque in kg-m?', 'single_choice', 'easy', 'Given: F = 45 kg, L = 0.8 m. T = F x L = 45 x 0.8 = 36 kg-m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '45.8 kg-m', false, 0),
      (v_question_id, '0.018 kg-m', false, 1),
      (v_question_id, '56.25 kg-m', false, 2),
      (v_question_id, '36.0 kg-m', true, 3);
  END IF;

  -- 24. Fuel consumption rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a field test trial lasting 90 minutes, the tractor consumed 5.4 L of fuel as determined by refilling the tank to full after the test. What is the fuel consumption rate in L/h?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a field test trial lasting 90 minutes, the tractor consumed 5.4 L of fuel as determined by refilling the tank to full after the test. What is the fuel consumption rate in L/h?', 'single_choice', 'easy', 'Given: V = 5.4 L, t = 90 min = 1.5 h. Fc = V/t = 5.4/1.5 = 3.6 L/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.6 L/h', true, 0),
      (v_question_id, '0.06 L/h', false, 1),
      (v_question_id, '486 L/h', false, 2),
      (v_question_id, '8.1 L/h', false, 3);
  END IF;

  -- 25. Hourly fuel from SFC
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During a PTO test, an engine delivers 30 kW at a specific fuel consumption of 250 g/kW-h. If the fuel density is 830 g/L, what is the hourly fuel consumption? (SFC = Fc x density / P, where Fc is in L/h.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'During a PTO test, an engine delivers 30 kW at a specific fuel consumption of 250 g/kW-h. If the fuel density is 830 g/L, what is the hourly fuel consumption? (SFC = Fc x density / P, where Fc is in L/h.)', 'single_choice', 'hard', 'Given: P = 30 kW, SFC = 250 g/kW-h, density = 830 g/L. Fc = SFC x P / density = (250 x 30)/830 = 7,500/830 = 9.04 L/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '110.7 L/h', false, 0),
      (v_question_id, '0.11 L/h', false, 1),
      (v_question_id, '7.5 L/h', false, 2),
      (v_question_id, '9.04 L/h', true, 3);
  END IF;

  -- 26. Effective field capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rotary tiller operating behind a four-wheel tractor accomplishes an effective area of 3,600 m2 in 72 minutes. Using efc = 60 Ae / t (with t in minutes and efc in m2/h), what is the effective field capacity in ha/h?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rotary tiller operating behind a four-wheel tractor accomplishes an effective area of 3,600 m2 in 72 minutes. Using efc = 60 Ae / t (with t in minutes and efc in m2/h), what is the effective field capacity in ha/h?', 'single_choice', 'medium', 'Given: Ae = 3,600 m2, t = 72 min. efc = 60 x 3,600/72 = 3,000 m2/h = 0.30 ha/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.60 ha/h', false, 0),
      (v_question_id, '3.00 ha/h', false, 1),
      (v_question_id, '0.30 ha/h', true, 2),
      (v_question_id, '0.005 ha/h', false, 3);
  END IF;

  -- 27. Field efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a plowing test, the effective field capacity is 2,400 m2/h. The effective width of tillage is 1.2 m and the operating speed is 2.5 km/h. What is the field efficiency? (tfc = we x v, with v in m/h; f = efc/tfc x 100.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a plowing test, the effective field capacity is 2,400 m2/h. The effective width of tillage is 1.2 m and the operating speed is 2.5 km/h. What is the field efficiency? (tfc = we x v, with v in m/h; f = efc/tfc x 100.)', 'single_choice', 'medium', 'Given: efc = 2,400 m2/h, we = 1.2 m, v = 2.5 km/h = 2,500 m/h. tfc = 1.2 x 2,500 = 3,000 m2/h. f = 2,400/3,000 x 100 = 80 percent.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80 percent', true, 0),
      (v_question_id, '65 percent', false, 1),
      (v_question_id, '125 percent', false, 2),
      (v_question_id, '20 percent', false, 3);
  END IF;

  -- 28. Average swath
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rectangular plot is 60 m wide. The tractor completes 15 rounds (2 trips per round) to cover the plot width. Using S = W/(2n), what is the average swath?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rectangular plot is 60 m wide. The tractor completes 15 rounds (2 trips per round) to cover the plot width. Using S = W/(2n), what is the average swath?', 'single_choice', 'easy', 'Given: W = 60 m, n = 15 rounds, 2 trips per round. S = W/(2n) = 60/(2 x 15) = 60/30 = 2.0 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.0 m', false, 0),
      (v_question_id, '2.0 m', true, 1),
      (v_question_id, '1.0 m', false, 2),
      (v_question_id, '0.5 m', false, 3);
  END IF;

  -- 29. Overlap area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A plot is 100 m long and 50 m wide (A = L x W). A tractor with a 1.1 m wide plow completes 25 rounds (2 trips per round), each trip covering the full 100 m length. Using Ae = 2nLw and Ao = Ae - A, what is the overlap (area plowed twice)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A plot is 100 m long and 50 m wide (A = L x W). A tractor with a 1.1 m wide plow completes 25 rounds (2 trips per round), each trip covering the full 100 m length. Using Ae = 2nLw and Ao = Ae - A, what is the overlap (area plowed twice)?', 'single_choice', 'hard', 'Given: L = 100 m, W = 50 m, w = 1.1 m, n = 25. A = 100 x 50 = 5,000 m2. Ae = 2 x 25 x 100 x 1.1 = 5,500 m2. Ao = Ae - A = 5,500 - 5,000 = 500 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,500 m2', false, 0),
      (v_question_id, '500 m2', true, 1),
      (v_question_id, '50 m2', false, 2),
      (v_question_id, '250 m2', false, 3);
  END IF;

  -- 30. Unplowed area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A plot is 120 m long and 60 m wide. A tractor with a 1.4 m wide rotary tiller completes 20 rounds (2 trips per round), each trip covering the full 120 m length. Using Ae = 2nLw and Au = A - Ae, what area is left untilled?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A plot is 120 m long and 60 m wide. A tractor with a 1.4 m wide rotary tiller completes 20 rounds (2 trips per round), each trip covering the full 120 m length. Using Ae = 2nLw and Au = A - Ae, what area is left untilled?', 'single_choice', 'hard', 'Given: L = 120 m, W = 60 m, w = 1.4 m, n = 20. A = 120 x 60 = 7,200 m2. Ae = 2 x 20 x 120 x 1.4 = 6,720 m2. Since the swath (60/40 = 1.5 m) is wider than the tiller, Au = A - Ae = 7,200 - 6,720 = 480 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '240 m2', false, 0),
      (v_question_id, '960 m2', false, 1),
      (v_question_id, '6,720 m2', false, 2),
      (v_question_id, '480 m2', true, 3);
  END IF;

  -- 31. Theoretical field capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A plow with an effective width of tillage of 1.5 m is pulled at an operating speed of 5 km/h. Using tfc = we x v, what is the theoretical field capacity in ha/h?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A plow with an effective width of tillage of 1.5 m is pulled at an operating speed of 5 km/h. Using tfc = we x v, what is the theoretical field capacity in ha/h?', 'single_choice', 'medium', 'Given: we = 1.5 m, v = 5 km/h = 5,000 m/h. tfc = 1.5 x 5,000 = 7,500 m2/h = 0.75 ha/h (1 ha = 10,000 m2).', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.75 ha/h', true, 0),
      (v_question_id, '7.5 ha/h', false, 1),
      (v_question_id, '1.5 ha/h', false, 2),
      (v_question_id, '0.075 ha/h', false, 3);
  END IF;

  -- 32. Minimum tread bar height
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At the beginning of the drawbar tests, the tread bar height of the tires must not be less than 65 percent of the bar height when new. If a new tire has tread bars 32 mm high, what is the minimum acceptable tread bar height?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'At the beginning of the drawbar tests, the tread bar height of the tires must not be less than 65 percent of the bar height when new. If a new tire has tread bars 32 mm high, what is the minimum acceptable tread bar height?', 'single_choice', 'medium', 'Given: new height = 32 mm, minimum = 65 percent. Minimum = 0.65 x 32 = 20.8 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '11.2 mm', false, 0),
      (v_question_id, '24.0 mm', false, 1),
      (v_question_id, '20.8 mm', true, 2),
      (v_question_id, '28.8 mm', false, 3);
  END IF;

  -- 33. Five-hour test drawbar load
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the first five-hour drawbar test of a ballasted tractor, the drawbar load applied is 75 percent of the pull corresponding to maximum power at rated speed in the selected gear. If the pull at maximum power at rated speed is 36 kN, what drawbar load is applied?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the first five-hour drawbar test of a ballasted tractor, the drawbar load applied is 75 percent of the pull corresponding to maximum power at rated speed in the selected gear. If the pull at maximum power at rated speed is 36 kN, what drawbar load is applied?', 'single_choice', 'medium', 'Given: pull at maximum power = 36 kN; load = 75 percent. Load = 0.75 x 36 = 27 kN.', NULL, NULL, 'draft', false, NULL, true, 'PAES 119:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18 kN', false, 0),
      (v_question_id, '27 kN', true, 1),
      (v_question_id, '48 kN', false, 2),
      (v_question_id, '30.6 kN', false, 3);
  END IF;

END $$;
