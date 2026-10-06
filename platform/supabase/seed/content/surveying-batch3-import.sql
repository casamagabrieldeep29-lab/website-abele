-- Surveying quiz batch 3 (40 questions, 1 topic). Every fact, formula and
-- number is drawn from surveying review material in the repo read in full
-- (definitions, instruments, taping, leveling, compass, transit/vernier and
-- traverse formulas) - no invented facts. Every numeric problem states all of
-- its given values in the question text and was re-derived before marking the
-- answer. The topic already had questions; none are repeated here.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since this is general surveying material, not a PAES standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Surveying (LAND_WATER) - 40 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Surveying' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Surveying';
  END IF;

  -- 1.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Closed surveys in urban and rural locations made to determine and define property lines, boundaries, corners, and areas are classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Closed surveys in urban and rural locations made to determine and define property lines, boundaries, corners, and areas are classified as:', 'single_choice', 'easy', 'Cadastral surveys are closed surveys in urban and rural locations that determine and define property lines and boundaries, corners, and areas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Route survey', false, 0),
      (v_question_id, 'Topographic survey', false, 1),
      (v_question_id, 'Construction survey', false, 2),
      (v_question_id, 'Cadastral survey', true, 3);
  END IF;

  -- 2.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A stadia rod is read with a telescope whose stadia interval factor K is 100 and whose instrument constant C is 0.30 m. The upper stadia hair reads 2.150 m and the lower stadia hair reads 1.350 m. Using D = Ks + C, what is the horizontal distance from the instrument to the rod?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A stadia rod is read with a telescope whose stadia interval factor K is 100 and whose instrument constant C is 0.30 m. The upper stadia hair reads 2.150 m and the lower stadia hair reads 1.350 m. Using D = Ks + C, what is the horizontal distance from the instrument to the rod?', 'single_choice', 'medium', 'Given: K = 100, C = 0.30 m, upper hair = 2.150 m, lower hair = 1.350 m. s = 2.150 - 1.350 = 0.800 m. D = Ks + C = 100(0.800) + 0.30 = 80.30 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80.00 m', false, 0),
      (v_question_id, '8.03 m', false, 1),
      (v_question_id, '80.30 m', true, 2),
      (v_question_id, '80.60 m', false, 3);
  END IF;

  -- 3.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Surveys for shipbuilding, the construction and assembly of aircraft, and the layout and installation of heavy and complex machinery, which require very accurate dimensional layouts, are also known as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Surveys for shipbuilding, the construction and assembly of aircraft, and the layout and installation of heavy and complex machinery, which require very accurate dimensional layouts, are also known as:', 'single_choice', 'medium', 'Industrial surveys are also known as optical tooling. They serve industries that require very accurate dimensional layouts.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Optical tooling', true, 0),
      (v_question_id, 'Tachymetry', false, 1),
      (v_question_id, 'Photogrammetry', false, 2),
      (v_question_id, 'Mine surveying', false, 3);
  END IF;

  -- 4.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 2-m subtense bar is set up at a distant station. The horizontal angle subtended by its two targets, measured with a theodolite, is 1.0000°. Using D = (s/2) cot(alpha/2), what is the horizontal distance to the bar?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 2-m subtense bar is set up at a distant station. The horizontal angle subtended by its two targets, measured with a theodolite, is 1.0000°. Using D = (s/2) cot(alpha/2), what is the horizontal distance to the bar?', 'single_choice', 'medium', 'Given: s = 2 m, alpha = 1.0000°. D = (2/2) cot(0.5°) = 1 x 114.589 = 114.59 m. No slope correction is needed with the subtense bar method.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '229.18 m', false, 0),
      (v_question_id, '28.64 m', false, 1),
      (v_question_id, '57.29 m', false, 2),
      (v_question_id, '114.59 m', true, 3);
  END IF;

  -- 5.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a field survey party, which member carries the zero end of the tape ahead and is responsible for the accuracy and speed of all linear measurements made with the tape?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a field survey party, which member carries the zero end of the tape ahead and is responsible for the accuracy and speed of all linear measurements made with the tape?', 'single_choice', 'easy', 'The head tapeman carries the zero end of the tape ahead and is responsible for the accuracy and speed of linear measurements with the tape. The rear tapeman only assists him, holding the 30-m end or an intermediate mark.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Head tapeman', true, 0),
      (v_question_id, 'Pacer', false, 1),
      (v_question_id, 'Flagman', false, 2),
      (v_question_id, 'Rear tapeman', false, 3);
  END IF;

  -- 6.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A steel tape with a nominal length of 30 m is found by comparison with a standard to be 30.012 m long (too long). A distance of 245.80 m is measured with this tape. Using Corr = TL - NL, C1 = Corr(ML/NL), and CL = ML +/- C1, what is the corrected length of the line?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A steel tape with a nominal length of 30 m is found by comparison with a standard to be 30.012 m long (too long). A distance of 245.80 m is measured with this tape. Using Corr = TL - NL, C1 = Corr(ML/NL), and CL = ML +/- C1, what is the corrected length of the line?', 'single_choice', 'medium', 'Given: TL = 30.012 m, NL = 30 m, ML = 245.80 m. Corr = 30.012 - 30 = 0.012 m. C1 = 0.012(245.80/30) = 0.0983 m. The tape is too long, so measured distances are too short and the correction is added: CL = 245.80 + 0.0983 = 245.898 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '245.702 m', false, 0),
      (v_question_id, '245.812 m', false, 1),
      (v_question_id, '245.898 m', true, 2),
      (v_question_id, '246.784 m', false, 3);
  END IF;

  -- 7.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The meter was proposed in 1789 by French scientists to establish a system based on permanent natural standards. It was originally defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The meter was proposed in 1789 by French scientists to establish a system based on permanent natural standards. It was originally defined as:', 'single_choice', 'medium', 'The meter was originally defined as 1/10,000,000 of the earth''s meridional quadrant. Later definitions used a platinum-iridium bar and, in 1960, a number of wavelengths of krypton light.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,650,763.73 wavelengths of the orange-red light of krypton', false, 0),
      (v_question_id, 'One ten-millionth of the earth''s meridional quadrant', true, 1),
      (v_question_id, 'One millionth of the earth''s equatorial circumference', false, 2),
      (v_question_id, 'The distance between two engraved lines on an iron bar at 20 °C', false, 3);
  END IF;

  -- 8.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A slope distance of 30.00 m is measured along a uniform gentle slope (less than 20%) between two points whose difference in elevation is 1.50 m. Using the gentle-slope formula Ch = h^2/(2s), what is the slope correction to be subtracted from the slope distance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A slope distance of 30.00 m is measured along a uniform gentle slope (less than 20%) between two points whose difference in elevation is 1.50 m. Using the gentle-slope formula Ch = h^2/(2s), what is the slope correction to be subtracted from the slope distance?', 'single_choice', 'medium', 'Given: s = 30.00 m, h = 1.50 m. Ch = h^2/(2s) = (1.50)^2/(2 x 30.00) = 2.25/60 = 0.0375 m. The horizontal distance is 30.00 - 0.0375 = 29.9625 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0375 m', true, 0),
      (v_question_id, '1.5000 m', false, 1),
      (v_question_id, '0.0750 m', false, 2),
      (v_question_id, '0.0188 m', false, 3);
  END IF;

  -- 9.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Effective what date was the English system of measurement officially phased out in the Philippines, with only the modern metric (SI) system allowed to be used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Effective what date was the English system of measurement officially phased out in the Philippines, with only the modern metric (SI) system allowed to be used?', 'single_choice', 'easy', 'The English system was officially phased out effective January 1, 1983, following the metric conversion signed into law in 1978. Only the modern metric system based on SI was allowed afterward.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'January 1, 1990', false, 0),
      (v_question_id, 'January 1, 1975', false, 1),
      (v_question_id, 'January 1, 1983', true, 2),
      (v_question_id, 'January 1, 1978', false, 3);
  END IF;

  -- 10.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A slope distance of 50.00 m is measured along a very steep slope (greater than 30%) inclined at 20.00° to the horizontal. Using Ch = s(1 - cos theta), what is the slope correction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A slope distance of 50.00 m is measured along a very steep slope (greater than 30%) inclined at 20.00° to the horizontal. Using Ch = s(1 - cos theta), what is the slope correction?', 'single_choice', 'hard', 'Given: s = 50.00 m, theta = 20.00°. Ch = s(1 - cos theta) = 50.00(1 - 0.93969) = 50.00(0.06031) = 3.02 m. The horizontal distance is 50.00 - 3.02 = 46.98 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.92 m', false, 0),
      (v_question_id, '1.51 m', false, 1),
      (v_question_id, '17.10 m', false, 2),
      (v_question_id, '3.02 m', true, 3);
  END IF;

  -- 11.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which electronic distance measuring instrument, the world''s second EDM instrument, uses high-frequency microwave transmission and can measure distances up to 80 km day or night?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which electronic distance measuring instrument, the world''s second EDM instrument, uses high-frequency microwave transmission and can measure distances up to 80 km day or night?', 'single_choice', 'medium', 'The tellurometer is a microwave EDM instrument capable of measuring distances up to 80 km day or night, with a precision of 1/300,000. The geodimeter, in contrast, is an electro-optical device.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Odometer', false, 0),
      (v_question_id, 'Tellurometer', true, 1),
      (v_question_id, 'Geodimeter', false, 2),
      (v_question_id, 'Optical rangefinder', false, 3);
  END IF;

  -- 12.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A steel tape standardized at 20 °C is used to measure a line at an observed temperature of 35 °C. The measured length is 175.40 m, and the coefficient of linear expansion of steel is 0.0000116/°C. Using CT = alpha L (T - To), what is the corrected length of the line?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A steel tape standardized at 20 °C is used to measure a line at an observed temperature of 35 °C. The measured length is 175.40 m, and the coefficient of linear expansion of steel is 0.0000116/°C. Using CT = alpha L (T - To), what is the corrected length of the line?', 'single_choice', 'medium', 'Given: alpha = 0.0000116/°C, L = 175.40 m, T = 35 °C, To = 20 °C. CT = 0.0000116(175.40)(35 - 20) = +0.0305 m. At the higher temperature the tape is longer than its standard length, so the measured distance is too short and the correction is added: 175.40 + 0.0305 = 175.43 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '175.71 m', false, 0),
      (v_question_id, '175.40 m', false, 1),
      (v_question_id, '175.43 m', true, 2),
      (v_question_id, '175.37 m', false, 3);
  END IF;

  -- 13.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of measuring tape does not shrink or stretch with changes in temperature and humidity and is best used in the vicinity of electrical equipment?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of measuring tape does not shrink or stretch with changes in temperature and humidity and is best used in the vicinity of electrical equipment?', 'single_choice', 'easy', 'The fiberglass tape is woven with fiberglass in a longitudinal and transverse pattern. It does not shrink or stretch with temperature and humidity changes, and it is best used near electrical equipment.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Invar tape', false, 0),
      (v_question_id, 'Steel tape', false, 1),
      (v_question_id, 'Metallic (woven) tape', false, 2),
      (v_question_id, 'Fiberglass tape', true, 3);
  END IF;

  -- 14.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 100-m line is measured with a steel tape having a cross-sectional area of 0.04 cm^2 and a modulus of elasticity E = 2.10 x 10^6 kg/cm^2. The tape was standardized at a pull of 5 kg, but a pull of 9 kg was applied during the measurement. Using Cp = (P - Po)L/(AE), what is the tension correction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 100-m line is measured with a steel tape having a cross-sectional area of 0.04 cm^2 and a modulus of elasticity E = 2.10 x 10^6 kg/cm^2. The tape was standardized at a pull of 5 kg, but a pull of 9 kg was applied during the measurement. Using Cp = (P - Po)L/(AE), what is the tension correction?', 'single_choice', 'hard', 'Given: P = 9 kg, Po = 5 kg, L = 100 m, A = 0.04 cm^2, E = 2.10 x 10^6 kg/cm^2. Cp = (9 - 5)(100)/[(0.04)(2.10 x 10^6)] = 400/84,000 = 0.00476 m (about 4.8 mm), added to the measured length.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0107 m', false, 0),
      (v_question_id, '0.00476 m', true, 1),
      (v_question_id, '0.0476 m', false, 2),
      (v_question_id, '0.000476 m', false, 3);
  END IF;

  -- 15.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which taping accessory, also known as a spring scale, is used at one end of the tape to make sure the correct amount of pull is applied during precision taping?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which taping accessory, also known as a spring scale, is used at one end of the tape to make sure the correct amount of pull is applied during precision taping?', 'single_choice', 'easy', 'The tension handle (spring scale) is attached at one end of the tape to ensure the application of the correct pull during measurement. It is used in precision taping.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tension handle', true, 0),
      (v_question_id, 'Chaining pin', false, 1),
      (v_question_id, 'Plumb bob', false, 2),
      (v_question_id, 'Tape thermometer', false, 3);
  END IF;

  -- 16.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 30-m steel tape weighing 1.20 kg in total is supported only at its two ends (unsupported length 30 m) and is pulled with a tension of 6.0 kg. Using Cs = W^2 L/(24 P^2), what is the correction due to sag?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 30-m steel tape weighing 1.20 kg in total is supported only at its two ends (unsupported length 30 m) and is pulled with a tension of 6.0 kg. Using Cs = W^2 L/(24 P^2), what is the correction due to sag?', 'single_choice', 'hard', 'Given: W = 1.20 kg, L = 30 m, P = 6.0 kg. Cs = W^2 L/(24 P^2) = (1.20)^2(30)/[24(6.0)^2] = 43.2/864 = 0.050 m. Sag shortens the horizontal distance between end graduations, so this correction is subtracted when measuring.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0417 m', false, 0),
      (v_question_id, '0.300 m', false, 1),
      (v_question_id, '0.050 m', true, 2),
      (v_question_id, '0.150 m', false, 3);
  END IF;

  -- 17.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the correction due to incorrect tape length, what is the sign of the correction when a tape that is too long is used to lay out a required distance on the ground?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For the correction due to incorrect tape length, what is the sign of the correction when a tape that is too long is used to lay out a required distance on the ground?', 'single_choice', 'medium', 'For a tape that is too long, the correction is positive when measuring a line but negative when laying out a distance. The signs are reversed for a tape that is too short (negative when measuring, positive when laying out).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Positive (the correction is added), the same as when measuring', false, 0),
      (v_question_id, 'Negative (the correction is subtracted)', true, 1),
      (v_question_id, 'Zero, because laying out is not affected by the tape length', false, 2),
      (v_question_id, 'Positive when the temperature is above standard and negative otherwise', false, 3);
  END IF;

  -- 18.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Due to the combined effect of the earth''s curvature and atmospheric refraction, the line of sight departs from a level line by h'' = 0.0675 K^2, where K is the sight distance in km. By how much does a line of sight depart from a level line over a distance of 2.5 km?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Due to the combined effect of the earth''s curvature and atmospheric refraction, the line of sight departs from a level line by h'' = 0.0675 K^2, where K is the sight distance in km. By how much does a line of sight depart from a level line over a distance of 2.5 km?', 'single_choice', 'medium', 'Given: h'' = 0.0675 K^2, K = 2.5 km. h'' = 0.0675(2.5)^2 = 0.0675(6.25) = 0.422 m. The effect varies as the square of the length of the line.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.422 m', true, 0),
      (v_question_id, '0.491 m', false, 1),
      (v_question_id, '0.169 m', false, 2),
      (v_question_id, '0.196 m', false, 3);
  END IF;

  -- 19.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In taping, the pull that lengthens the tape by an amount exactly equal to the shortening caused by sag is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In taping, the pull that lengthens the tape by an amount exactly equal to the shortening caused by sag is called the:', 'single_choice', 'medium', 'Normal tension is the applied pull that lengthens the tape to equal the shortening caused by sag, so the sag and tension corrections cancel.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Temperature-compensated pull', false, 0),
      (v_question_id, 'Maximum allowable tension', false, 1),
      (v_question_id, 'Standard pull', false, 2),
      (v_question_id, 'Normal tension', true, 3);
  END IF;

  -- 20.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Starting from a bench mark of elevation 50.000 m, a differential leveling run gives these readings in order: backsight 2.40 m (first setup), foresight to a turning point 1.20 m, backsight on the turning point 1.80 m (second setup), and foresight to point P 0.60 m. What is the elevation of point P?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Starting from a bench mark of elevation 50.000 m, a differential leveling run gives these readings in order: backsight 2.40 m (first setup), foresight to a turning point 1.20 m, backsight on the turning point 1.80 m (second setup), and foresight to point P 0.60 m. What is the elevation of point P?', 'single_choice', 'medium', 'Given: BM = 50.000 m, BS1 = 2.40, FS1 = 1.20, BS2 = 1.80, FS2 = 0.60. Using HI = Elev + BS and Elev = HI - FS: HI1 = 52.40, TP = 52.40 - 1.20 = 51.20, HI2 = 51.20 + 1.80 = 53.00, P = 53.00 - 0.60 = 52.40 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '51.200 m', false, 0),
      (v_question_id, '52.400 m', true, 1),
      (v_question_id, '56.000 m', false, 2),
      (v_question_id, '47.600 m', false, 3);
  END IF;

  -- 21.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which level has no level vial and levels itself through a compensator, a pendulum-and-prism device suspended on fine, non-magnetic wires?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which level has no level vial and levels itself through a compensator, a pendulum-and-prism device suspended on fine, non-magnetic wires?', 'single_choice', 'medium', 'The automatic level has no level vial. Its ability to level itself depends on the action of a prismatic compensator suspended on fine, non-magnetic wires.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dumpy level', false, 0),
      (v_question_id, 'Builder''s level', false, 1),
      (v_question_id, 'Automatic level', true, 2),
      (v_question_id, 'Wye level', false, 3);
  END IF;

  -- 22.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Reciprocal leveling is done between points A and B, and the elevation of A is 100.000 m. The difference in elevation from A to B is taken as the rod reading on A minus the rod reading on B. With the instrument near A the readings are 1.520 m on A and 2.880 m on B. With the instrument near B the readings are 1.620 m on A and 2.960 m on B. Using TDE = [(a - b) + (a'' - b'')]/2, what is the elevation of B?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Reciprocal leveling is done between points A and B, and the elevation of A is 100.000 m. The difference in elevation from A to B is taken as the rod reading on A minus the rod reading on B. With the instrument near A the readings are 1.520 m on A and 2.880 m on B. With the instrument near B the readings are 1.620 m on A and 2.960 m on B. Using TDE = [(a - b) + (a'' - b'')]/2, what is the elevation of B?', 'single_choice', 'hard', 'Given: Elev A = 100.000 m; first set: a = 1.520, b = 2.880; second set: a'' = 1.620, b'' = 2.960. DE1 = 1.520 - 2.880 = -1.360; DE2 = 1.620 - 2.960 = -1.340. TDE = (-1.360 - 1.340)/2 = -1.350 m. Elev B = 100.000 - 1.350 = 98.650 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '98.640 m', false, 0),
      (v_question_id, '101.350 m', false, 1),
      (v_question_id, '97.300 m', false, 2),
      (v_question_id, '98.650 m', true, 3);
  END IF;

  -- 23.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which level has most of its metal parts made of invar to reduce the effects of temperature, is used in first-order leveling work, and is suited to three-wire leveling because of its stadia hairs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which level has most of its metal parts made of invar to reduce the effects of temperature, is used in first-order leveling work, and is suited to three-wire leveling because of its stadia hairs?', 'single_choice', 'medium', 'The geodetic level has most of its metal parts made of invar to reduce temperature effects. It is employed in first-order leveling where extreme precision is required, and its stadia hairs make it suitable for three-wire leveling.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Builder''s level', false, 0),
      (v_question_id, 'Geodetic level', true, 1),
      (v_question_id, 'Hand level', false, 2),
      (v_question_id, 'Laser level', false, 3);
  END IF;

  -- 24.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Point B is sighted from point A over a horizontal distance of 1,000 m with an upward vertical angle of 2.000° (tan 2.000° = 0.034921). The height of instrument at A is 1.50 m and the rod reading at B is 2.50 m. Using DE = d tan(alpha) + HI - RR + 0.0675 K^2, with K in km (the curvature and refraction effect is added for an upward sight), what is the difference in elevation from A to B?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Point B is sighted from point A over a horizontal distance of 1,000 m with an upward vertical angle of 2.000° (tan 2.000° = 0.034921). The height of instrument at A is 1.50 m and the rod reading at B is 2.50 m. Using DE = d tan(alpha) + HI - RR + 0.0675 K^2, with K in km (the curvature and refraction effect is added for an upward sight), what is the difference in elevation from A to B?', 'single_choice', 'hard', 'Given: d = 1,000 m (K = 1 km), alpha = +2.000°, HI = 1.50 m, RR = 2.50 m. DE = 1,000(0.034921) + 1.50 - 2.50 + 0.0675(1)^2 = 34.921 - 1.00 + 0.0675 = 33.99 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '33.99 m', true, 0),
      (v_question_id, '36.49 m', false, 1),
      (v_question_id, '33.85 m', false, 2),
      (v_question_id, '33.92 m', false, 3);
  END IF;

  -- 25.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which leveling rod combines the features of a self-reading rod and a target rod and is made in two sections, with the rear section sliding over the front section?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which leveling rod combines the features of a self-reading rod and a target rod and is made in two sections, with the rear section sliding over the front section?', 'single_choice', 'medium', 'The Philadelphia rod is a combination of a self-reading and a target rod made in two sections, with the rear section sliding over the front one. The Chicago rod, by contrast, has three sliding sections.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Chicago rod', false, 0),
      (v_question_id, 'Philadelphia rod', true, 1),
      (v_question_id, 'Tape rod', false, 2),
      (v_question_id, 'Geodetic rod', false, 3);
  END IF;

  -- 26.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under standard conditions the mercury column of a barometer is 76.0 cm high at sea level, and a change of 1 cm in the height of the mercury column corresponds to a difference of about 108 m in altitude. If the mercury column reads 76.0 cm at a base station at sea level and 70.5 cm at the top of a hill, what is the approximate elevation of the hilltop?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under standard conditions the mercury column of a barometer is 76.0 cm high at sea level, and a change of 1 cm in the height of the mercury column corresponds to a difference of about 108 m in altitude. If the mercury column reads 76.0 cm at a base station at sea level and 70.5 cm at the top of a hill, what is the approximate elevation of the hilltop?', 'single_choice', 'medium', 'Given: 1 cm of mercury is about 108 m of altitude; base reading 76.0 cm, summit reading 70.5 cm. Difference = 76.0 - 70.5 = 5.5 cm. Elevation = 5.5 x 108 = 594 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '648 m', false, 0),
      (v_question_id, '540 m', false, 1),
      (v_question_id, '594 m', true, 2),
      (v_question_id, '59.4 m', false, 3);
  END IF;

  -- 27.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The two-peg test in leveling is a procedure done to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The two-peg test in leveling is a procedure done to:', 'single_choice', 'easy', 'The two-peg test is performed to check and adjust the line of sight of the leveling instrument.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Check and adjust the line of sight of the level', true, 0),
      (v_question_id, 'Determine the length of the leveling rod', false, 1),
      (v_question_id, 'Establish the elevation of a permanent bench mark', false, 2),
      (v_question_id, 'Determine the local magnetic declination', false, 3);
  END IF;

  -- 28.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Five measurements of the same distance are 25.42, 25.44, 25.40, 25.46, and 25.38 m, with a mean of 25.42 m. Using PEm = +/- 0.6745 sqrt[sum(v^2)/(n(n - 1))], what is the probable error of the mean?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Five measurements of the same distance are 25.42, 25.44, 25.40, 25.46, and 25.38 m, with a mean of 25.42 m. Using PEm = +/- 0.6745 sqrt[sum(v^2)/(n(n - 1))], what is the probable error of the mean?', 'single_choice', 'hard', 'Given: n = 5, mean = 25.42 m. Residuals v = 0, +0.02, -0.02, +0.04, -0.04, so sum(v^2) = 0.0004 + 0.0004 + 0.0016 + 0.0016 = 0.0040. PEm = 0.6745 sqrt[0.0040/(5 x 4)] = 0.6745(0.01414) = +/- 0.0095 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '+/- 0.043 m', false, 0),
      (v_question_id, '+/- 0.021 m', false, 1),
      (v_question_id, '+/- 0.014 m', false, 2),
      (v_question_id, '+/- 0.0095 m', true, 3);
  END IF;

  -- 29.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which variation of magnetic declination covers a period of so many years that its exact cause and character are not thoroughly understood?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which variation of magnetic declination covers a period of so many years that its exact cause and character are not thoroughly understood?', 'single_choice', 'medium', 'Secular variation covers a period of many years, and its exact cause and character are not thoroughly understood. Daily (diurnal) variation is a 24-hour oscillation, annual variation is usually less than 1 minute of arc, and irregular variation cannot be predicted.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Secular variation', true, 0),
      (v_question_id, 'Irregular variation', false, 1),
      (v_question_id, 'Daily (diurnal) variation', false, 2),
      (v_question_id, 'Annual variation', false, 3);
  END IF;

  -- 30.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A closed traverse has a total perimeter of 1,500 m. The sum of its latitudes is +0.18 m and the sum of its departures is -0.24 m. Using LEC = sqrt[(sum Lat)^2 + (sum Dep)^2] and REC = LEC/D, what is the relative error of closure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A closed traverse has a total perimeter of 1,500 m. The sum of its latitudes is +0.18 m and the sum of its departures is -0.24 m. Using LEC = sqrt[(sum Lat)^2 + (sum Dep)^2] and REC = LEC/D, what is the relative error of closure?', 'single_choice', 'medium', 'Given: D = 1,500 m, sum Lat = +0.18 m, sum Dep = -0.24 m. LEC = sqrt(0.18^2 + 0.24^2) = sqrt(0.09) = 0.30 m. REC = 0.30/1,500 = 1/5,000.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/8,333', false, 0),
      (v_question_id, '1/6,250', false, 1),
      (v_question_id, '1/3,571', false, 2),
      (v_question_id, '1/5,000', true, 3);
  END IF;

  -- 31.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'On an isogonic chart, the lines connecting parts of the chart that have zero magnetic declination are called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'On an isogonic chart, the lines connecting parts of the chart that have zero magnetic declination are called:', 'single_choice', 'medium', 'Agonic lines connect parts of an isogonic chart with zero magnetic declination. The isogonic chart itself shows lines joining points of equal declination at a given time.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Meridian lines', false, 0),
      (v_question_id, 'Contour lines', false, 1),
      (v_question_id, 'Agonic lines', true, 2),
      (v_question_id, 'Isobars', false, 3);
  END IF;

  -- 32.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a closed traverse with a perimeter D of 600 m, the error in latitude (sum of latitudes) is 0.18 m. Using the compass rule, c_l = c_L (d/D), what is the magnitude of the latitude correction for a course 120 m long?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a closed traverse with a perimeter D of 600 m, the error in latitude (sum of latitudes) is 0.18 m. Using the compass rule, c_l = c_L (d/D), what is the magnitude of the latitude correction for a course 120 m long?', 'single_choice', 'hard', 'Given: c_L = 0.18 m, D = 600 m, d = 120 m. c_l = 0.18(120/600) = 0.036 m, applied with a sign opposite to the error.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0036 m', false, 0),
      (v_question_id, '0.036 m', true, 1),
      (v_question_id, '0.90 m', false, 2),
      (v_question_id, '0.18 m', false, 3);
  END IF;

  -- 33.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which north point is established by lines on a map that are parallel to a selected central meridian, with the symbol GN or a full arrowhead?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which north point is established by lines on a map that are parallel to a selected central meridian, with the symbol GN or a full arrowhead?', 'single_choice', 'easy', 'Grid north is established by map lines parallel to a selected central meridian and is shown by a full arrowhead or GN (or Y). True north is shown by an asterisk or TN, and magnetic north by a half arrowhead or MN.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grid north', true, 0),
      (v_question_id, 'Assumed north', false, 1),
      (v_question_id, 'True north', false, 2),
      (v_question_id, 'Magnetic north', false, 3);
  END IF;

  -- 34.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A vernier is to be fitted to a circle whose smallest main-scale division is 20 minutes, and the vernier has 40 divisions. Using LC = s/n, what is the least count of the vernier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A vernier is to be fitted to a circle whose smallest main-scale division is 20 minutes, and the vernier has 40 divisions. Using LC = s/n, what is the least count of the vernier?', 'single_choice', 'medium', 'Given: s = 20 minutes, n = 40. LC = s/n = 20 minutes/40 = 0.5 minute = 30 seconds, which is the least count of a double vernier.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 minute', false, 0),
      (v_question_id, '30 seconds', true, 1),
      (v_question_id, '20 seconds', false, 2),
      (v_question_id, '10 seconds', false, 3);
  END IF;

  -- 35.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The angle between the meridian and a line, measured in a clockwise direction from either the north or the south branch of the meridian, is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The angle between the meridian and a line, measured in a clockwise direction from either the north or the south branch of the meridian, is called the:', 'single_choice', 'easy', 'This is the azimuth. A bearing, in contrast, is the acute horizontal angle between the reference meridian and the line.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Deflection angle', false, 0),
      (v_question_id, 'Bearing', false, 1),
      (v_question_id, 'Azimuth', true, 2),
      (v_question_id, 'Interior angle', false, 3);
  END IF;

  -- 36.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A vertical angle is observed with a transit as +12°20′40″ with the telescope in the normal position and +12°20′10″ with the telescope in the reversed (plunged) position. Using alpha'' = (alpha_N + alpha_R)/2, what is the correct value of the vertical angle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A vertical angle is observed with a transit as +12°20′40″ with the telescope in the normal position and +12°20′10″ with the telescope in the reversed (plunged) position. Using alpha'' = (alpha_N + alpha_R)/2, what is the correct value of the vertical angle?', 'single_choice', 'hard', 'Given: alpha_N = 12°20′40″, alpha_R = 12°20′10″. alpha'' = (12°20′40″ + 12°20′10″)/2 = 12°20′25″. The index error is (alpha_N - alpha_R)/2 = 15″.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24°40′50″', false, 0),
      (v_question_id, '12°20′40″', false, 1),
      (v_question_id, '12°20′10″', false, 2),
      (v_question_id, '12°20′25″', true, 3);
  END IF;

  -- 37.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The compass rule (Bowditch rule) of traverse adjustment is based on the assumption that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The compass rule (Bowditch rule) of traverse adjustment is based on the assumption that:', 'single_choice', 'hard', 'The compass rule assumes that all lengths were measured with equal care and all angles were taken with approximately the same precision. The Crandall method, by contrast, is suited to cases where linear measurements are less precise than angular ones.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Linear measurements are less precise than angular measurements', false, 0),
      (v_question_id, 'All lengths were measured with equal care and all angles with approximately the same precision', true, 1),
      (v_question_id, 'The corrections depend only on the latitude and departure of each course', false, 2),
      (v_question_id, 'All angles are exact and all errors are in the lengths', false, 3);
  END IF;

  -- 38.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Offsets taken at equal intervals of 5.0 m from a straight base line to an irregular boundary are 2.0, 3.2, 4.1, 3.5, and 2.6 m. Using the trapezoidal rule, A = d[(h1 + hn)/2 + h2 + h3 + ... + h(n-1)], what is the area between the base line and the boundary?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Offsets taken at equal intervals of 5.0 m from a straight base line to an irregular boundary are 2.0, 3.2, 4.1, 3.5, and 2.6 m. Using the trapezoidal rule, A = d[(h1 + hn)/2 + h2 + h3 + ... + h(n-1)], what is the area between the base line and the boundary?', 'single_choice', 'medium', 'Given: d = 5.0 m; h = 2.0, 3.2, 4.1, 3.5, 2.6 m. A = 5.0[(2.0 + 2.6)/2 + 3.2 + 4.1 + 3.5] = 5.0[2.3 + 10.8] = 5.0(13.1) = 65.5 square meters.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '77.0 square meters', false, 0),
      (v_question_id, '13.1 square meters', false, 1),
      (v_question_id, '65.5 square meters', true, 2),
      (v_question_id, '66.0 square meters', false, 3);
  END IF;

  -- 39.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'To determine the elevation of a point located higher than the telescope of the instrument, such as a ceiling, the rod is held upside down with its base placed against the point. This procedure is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'To determine the elevation of a point located higher than the telescope of the instrument, such as a ceiling, the rod is held upside down with its base placed against the point. This procedure is called:', 'single_choice', 'medium', 'This is inverse leveling: when the point is higher than the telescope, the rod is held upside down with its base placed up at the desired point.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Barometric leveling', false, 0),
      (v_question_id, 'Profile leveling', false, 1),
      (v_question_id, 'Reciprocal leveling', false, 2),
      (v_question_id, 'Inverse leveling', true, 3);
  END IF;

  -- 40.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In altimeter surveys, which method was designed to eliminate the need to correct for the effects of temperature and relative humidity by establishing a lower base and a much higher upper base?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In altimeter surveys, which method was designed to eliminate the need to correct for the effects of temperature and relative humidity by establishing a lower base and a much higher upper base?', 'single_choice', 'hard', 'The two-base method uses a lower base at a suitable low point and an upper base at a much higher elevation, which eliminates the need to apply corrections for temperature and relative humidity. The single-base method uses two altimeters and two thermometers.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two-base method', true, 0),
      (v_question_id, 'Reciprocal method', false, 1),
      (v_question_id, 'Trigonometric method', false, 2),
      (v_question_id, 'Single-base method', false, 3);
  END IF;

END $$;
