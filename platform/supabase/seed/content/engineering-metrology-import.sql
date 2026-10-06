-- Engineering Metrology and Equipment quiz batch (37 questions, 1 topic).
-- Every definition, classification, unit, and figure is drawn directly from
-- review material read in full; no invented facts. Questions cover metrology
-- fundamentals, measurement terminology, accuracy/precision and measurement
-- errors, the SI system, and common measuring instruments.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- except the questions grounded in a PAES standard, which carry the standard
-- number.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Engineering Metrology and Equipment (POWER_ENERGY_MACHINERY) — 37 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Engineering Metrology and Equipment' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Engineering Metrology and Equipment';
  END IF;

  -- 1. NOT a main activity of metrology
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT one of the three main activities covered by metrology?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT one of the three main activities covered by metrology?', 'single_choice', 'medium', 'Metrology covers three main activities: the definition of internationally accepted units of measurement, the realization of units of measurement, and the establishment of traceability chains. Manufacturing measuring instruments for retail sale is not one of them.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The establishment of traceability chains', false, 0),
      (v_question_id, 'The manufacture of measuring instruments for retail sale', true, 1),
      (v_question_id, 'The definition of internationally accepted units of measurement', false, 2),
      (v_question_id, 'The realization of units of measurement', false, 3);
  END IF;

  -- 2. Scientific metrology
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which subfield of metrology is the basis of all other subfields and concerns the development of new measurement methods, the realization of measurement standards, and the transfer of these standards to users?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which subfield of metrology is the basis of all other subfields and concerns the development of new measurement methods, the realization of measurement standards, and the transfer of these standards to users?', 'single_choice', 'easy', 'Scientific metrology is the basis of all subfields; it concerns the development of new measurement methods, the realization of measurement standards, and the transfer of these standards to users.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Scientific metrology', true, 0),
      (v_question_id, 'Applied metrology', false, 1),
      (v_question_id, 'Industrial metrology', false, 2),
      (v_question_id, 'Legal metrology', false, 3);
  END IF;

  -- 3. Applied metrology
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The subfield of metrology in which measurement science is developed toward manufacturing and other processes, ensuring the suitability of measurement instruments, their calibration, and quality control, is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The subfield of metrology in which measurement science is developed toward manufacturing and other processes, ensuring the suitability of measurement instruments, their calibration, and quality control, is called', 'single_choice', 'medium', 'Applied metrology develops measurement science toward manufacturing and other processes, ensuring the suitability of measurement instruments, their calibration, and quality control.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Regulatory metrology', false, 0),
      (v_question_id, 'Scientific metrology', false, 1),
      (v_question_id, 'Legal metrology', false, 2),
      (v_question_id, 'Applied metrology', true, 3);
  END IF;

  -- 4. Legal metrology
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which subfield of metrology concerns regulatory requirements of well-established measurements and measuring instruments for the protection of consumers and fair trade?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which subfield of metrology concerns regulatory requirements of well-established measurements and measuring instruments for the protection of consumers and fair trade?', 'single_choice', 'easy', 'Legal metrology concerns regulatory requirements of well-established measurements and measuring instruments for the protection of consumers and fair trade.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Applied metrology', false, 0),
      (v_question_id, 'Scientific metrology', false, 1),
      (v_question_id, 'Legal metrology', true, 2),
      (v_question_id, 'Fundamental metrology', false, 3);
  END IF;

  -- 5. NML under ITDI
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The National Metrology Laboratory (NML), the national metrology institute of the Philippines, operates under which institute of the Department of Science and Technology?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The National Metrology Laboratory (NML), the national metrology institute of the Philippines, operates under which institute of the Department of Science and Technology?', 'single_choice', 'medium', 'The NML operates under the Industrial Technology Development Institute (ITDI), one of the agencies of the Department of Science and Technology (DOST).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bureau of Philippine Standards (BPS)', false, 0),
      (v_question_id, 'Industrial Technology Development Institute (ITDI)', true, 1),
      (v_question_id, 'Bureau of Agriculture and Fisheries Standards (BAFS)', false, 2),
      (v_question_id, 'Philippine Atmospheric, Geophysical and Astronomical Services Administration (PAGASA)', false, 3);
  END IF;

  -- 6. RA 9236 title
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Republic Act No. 9236 is also known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Republic Act No. 9236 is also known as', 'single_choice', 'easy', 'Republic Act No. 9236 is "The National Metrology Act of 2003."', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The National Metrology Act of 2003', true, 0),
      (v_question_id, 'The Philippine Weights and Measures Act of 1998', false, 1),
      (v_question_id, 'The National Standards Development Act of 2003', false, 2),
      (v_question_id, 'The Agricultural and Fisheries Mechanization (AFMech) Law of 2013', false, 3);
  END IF;

  -- 7. NMIS
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The National Metrology Act of 2003 (RA 9236) is an act establishing which system for standards and measurements?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The National Metrology Act of 2003 (RA 9236) is an act establishing which system for standards and measurements?', 'single_choice', 'medium', 'RA 9236 is "An Act Establishing a National Measurement Infrastructure System (NMIS) for Standards and Measurements, and for Other Purposes."', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'National Calibration and Inspection Network', false, 0),
      (v_question_id, 'National Industrial Testing System', false, 1),
      (v_question_id, 'National Quality Assurance System', false, 2),
      (v_question_id, 'National Measurement Infrastructure System (NMIS)', true, 3);
  END IF;

  -- 8. ISO 17025 accredited laboratory
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the National Metrology Act of 2003, an accredited laboratory is one that has complied with the requirements of which ISO standard, titled "General Requirements for the Competence of Testing and Calibration Laboratories"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the National Metrology Act of 2003, an accredited laboratory is one that has complied with the requirements of which ISO standard, titled "General Requirements for the Competence of Testing and Calibration Laboratories"?', 'single_choice', 'medium', 'An accredited laboratory has been evaluated and has complied with ISO 17025, "General Requirements for the Competence of Testing and Calibration Laboratories," and is accredited by the national accrediting body.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ISO 9001', false, 0),
      (v_question_id, 'ISO 14001', false, 1),
      (v_question_id, 'ISO 17025', true, 2),
      (v_question_id, 'ISO 22000', false, 3);
  END IF;

  -- 9. Calibration definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The set of operations that establishes, under specified conditions, the relationship between the values indicated by a measuring instrument or measuring system and the corresponding known values of the measure is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The set of operations that establishes, under specified conditions, the relationship between the values indicated by a measuring instrument or measuring system and the corresponding known values of the measure is called', 'single_choice', 'easy', 'Calibration is the set of operations establishing, under specified conditions, the relationship between values indicated by a measuring instrument or measuring system (or values represented by a material measure) and its corresponding known values of measure.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type approval', false, 0),
      (v_question_id, 'Calibration', true, 1),
      (v_question_id, 'Accreditation', false, 2),
      (v_question_id, 'Verification', false, 3);
  END IF;

  -- 10. Verification definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A confirmation by examination of evidence that measuring equipment fulfills specified requirements is termed';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A confirmation by examination of evidence that measuring equipment fulfills specified requirements is termed', 'single_choice', 'medium', 'Verification is a confirmation by examination of evidence that the measuring equipment fulfills specified requirements.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Verification', true, 0),
      (v_question_id, 'Type approval', false, 1),
      (v_question_id, 'Traceability', false, 2),
      (v_question_id, 'Calibration', false, 3);
  END IF;

  -- 11. Type approval
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The approved evaluation of conformity of measuring equipment based on one or more specimens of a product is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The approved evaluation of conformity of measuring equipment based on one or more specimens of a product is called', 'single_choice', 'medium', 'Type approval on measuring equipment is the approved evaluation of conformity based on one or more specimens of a product.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Verification', false, 0),
      (v_question_id, 'Calibration', false, 1),
      (v_question_id, 'Accreditation', false, 2),
      (v_question_id, 'Type approval', true, 3);
  END IF;

  -- 12. Primary standard
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A standard that has the highest metrological quality in a specified field is called a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A standard that has the highest metrological quality in a specified field is called a', 'single_choice', 'easy', 'A primary standard is a standard which has the highest metrological quality in a specified field.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Regulated standard', false, 0),
      (v_question_id, 'Secondary standard', false, 1),
      (v_question_id, 'Primary standard', true, 2),
      (v_question_id, 'Working standard', false, 3);
  END IF;

  -- 13. Secondary standard
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A standard whose value is fixed by comparison with a primary standard is called a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A standard whose value is fixed by comparison with a primary standard is called a', 'single_choice', 'medium', 'A secondary standard is one whose value is fixed by comparison with a primary standard.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Accredited standard', false, 0),
      (v_question_id, 'Secondary standard', true, 1),
      (v_question_id, 'Regulated standard', false, 2),
      (v_question_id, 'Primary standard', false, 3);
  END IF;

  -- 14. Metrology controls
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type approval, verification, calibration, and other processes and means of checking the accuracy and reliability of measurement standards and measuring equipment are collectively referred to as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Type approval, verification, calibration, and other processes and means of checking the accuracy and reliability of measurement standards and measuring equipment are collectively referred to as', 'single_choice', 'medium', 'Metrology controls refer to type approval, verification, calibration, and other processes and means of checking the accuracy and reliability of measurement standards and measuring equipment.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Metrology controls', true, 0),
      (v_question_id, 'Board-authorized units', false, 1),
      (v_question_id, 'Measurement infrastructure', false, 2),
      (v_question_id, 'Regulated areas of application', false, 3);
  END IF;

  -- 15. Measurand
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The physical quantity that is subject to measurement in metrology is called the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The physical quantity that is subject to measurement in metrology is called the', 'single_choice', 'easy', 'The measurand, or measured quantity, is the physical quantity in metrology that is subject to measurement.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tolerance', false, 0),
      (v_question_id, 'Resolution', false, 1),
      (v_question_id, 'Standard', false, 2),
      (v_question_id, 'Measurand', true, 3);
  END IF;

  -- 16. Precise not accurate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gauge block of known length 25.00 mm is measured four times with a worn caliper, giving 24.20, 24.21, 24.19 and 24.20 mm. The measurements are';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gauge block of known length 25.00 mm is measured four times with a worn caliper, giving 24.20, 24.21, 24.19 and 24.20 mm. The measurements are', 'single_choice', 'medium', 'Precision is how close measurements agree with each other (the readings are tightly grouped), while accuracy is how closely measurements agree with the known value (the readings are far from 25.00 mm). The measurements are therefore precise but not accurate.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Both accurate and precise', false, 0),
      (v_question_id, 'Accurate but not precise', false, 1),
      (v_question_id, 'Precise but not accurate', true, 2),
      (v_question_id, 'Neither accurate nor precise', false, 3);
  END IF;

  -- 17. Least precise measurement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'When measured values are used in a calculation, the result can only be as precise as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'When measured values are used in a calculation, the result can only be as precise as', 'single_choice', 'medium', 'Precision is more important in calculations: when using measured values in a calculation, you can only be as precise as your least precise measurement. This is the main idea behind significant figures.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The average precision of all the measurements', false, 0),
      (v_question_id, 'Your least precise measurement', true, 1),
      (v_question_id, 'The known true value of the quantity', false, 2),
      (v_question_id, 'Your most precise measurement', false, 3);
  END IF;

  -- 18. Correction factor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If repeated shots at a target all fall consistently to the left of the center, the accuracy of future measurements can be improved by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If repeated shots at a target all fall consistently to the left of the center, the accuracy of future measurements can be improved by', 'single_choice', 'medium', 'Accuracy can be improved in future measurements by factoring in a correction factor, for example by shifting the aim to the right if all shots go to the left. Accuracy is something that can be fixed in future measurements.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Factoring in a correction factor', true, 0),
      (v_question_id, 'Taking fewer measurements', false, 1),
      (v_question_id, 'Ignoring the readings that are far from the center', false, 2),
      (v_question_id, 'Using a better measuring tool only', false, 3);
  END IF;

  -- 19. Systematic errors affect accuracy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Systematic (determinate) errors in a measurement primarily affect the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Systematic (determinate) errors in a measurement primarily affect the', 'single_choice', 'easy', 'Systematic errors affect the accuracy of the measurement, or the closeness of the result to the true value, whereas random errors affect the precision of the measurements.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Resolution of the instrument', false, 0),
      (v_question_id, 'Range of the instrument', false, 1),
      (v_question_id, 'Precision of the measurements', false, 2),
      (v_question_id, 'Accuracy of the measurement', true, 3);
  END IF;

  -- 20. Random errors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of error is always present during any measurement, cannot be controlled for, and arises from minor differences in how people read a scale or from electrical noise?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of error is always present during any measurement, cannot be controlled for, and arises from minor differences in how people read a scale or from electrical noise?', 'single_choice', 'medium', 'Random (indeterminate) errors are always present during any measurement and cannot be controlled for. They arise from minor differences in sampling between different people, from how people read a buret or interpret an endpoint color, and even from electrical noise.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Systematic error', false, 0),
      (v_question_id, 'Method error', false, 1),
      (v_question_id, 'Random error', true, 2),
      (v_question_id, 'Sampling error', false, 3);
  END IF;

  -- 21. Positive systematic bias
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Measurements that are consistently higher than the true value indicate';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Measurements that are consistently higher than the true value indicate', 'single_choice', 'medium', 'Systematic errors are characterized by measurements that are consistently higher than the true value (positive systematic bias) or consistently lower than the true value (negative systematic bias).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Negative systematic bias', false, 0),
      (v_question_id, 'Positive systematic bias', true, 1),
      (v_question_id, 'Random error only', false, 2),
      (v_question_id, 'Perfect accuracy', false, 3);
  END IF;

  -- 22. Sampling errors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of systematic error arises when a collected sample does not represent the environment being sampled?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of systematic error arises when a collected sample does not represent the environment being sampled?', 'single_choice', 'medium', 'Sampling errors arise when a collected sample does not represent the environment being sampled.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sampling error', true, 0),
      (v_question_id, 'Method error', false, 1),
      (v_question_id, 'Personal error', false, 2),
      (v_question_id, 'Instrument error', false, 3);
  END IF;

  -- 23. Minimize systematic errors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is a recommended way to minimize systematic errors?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is a recommended way to minimize systematic errors?', 'single_choice', 'hard', 'Ways to minimize systematic errors include collecting representative samples, analyzing standard reference materials whose concentrations are known, analyzing blank samples, using multiple methods to make measurements, participating in a round-robin study with other labs, and varying the sample size.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Keeping the sample size fixed in every trial', false, 0),
      (v_question_id, 'Using only a single method of measurement', false, 1),
      (v_question_id, 'Collecting the sample from one convenient spot only', false, 2),
      (v_question_id, 'Analyzing standard reference materials whose concentrations are known', true, 3);
  END IF;

  -- 24. Estimating random error
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The contribution of random error to a measurement can be estimated by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The contribution of random error to a measurement can be estimated by', 'single_choice', 'hard', 'The contribution of random error can be estimated through error propagation methods, by measuring the standard deviation of a series of measurements that show a normal distribution, and by monitoring the behavior of a piece of equipment over time.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Analyzing blank samples', false, 0),
      (v_question_id, 'Participating in a round-robin study with other laboratories', false, 1),
      (v_question_id, 'Measuring the standard deviation of a series of measurements', true, 2),
      (v_question_id, 'Collecting representative samples', false, 3);
  END IF;

  -- 25. Systematic exceeds random
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In general, which type of measurement error has the greater magnitude, so that analysts typically focus their attention on it to minimize overall error in a process?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In general, which type of measurement error has the greater magnitude, so that analysts typically focus their attention on it to minimize overall error in a process?', 'single_choice', 'medium', 'In general, the magnitude of systematic errors greatly exceeds that of random errors, so that is where analysts typically focus their attention to minimize overall error in a process.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Random errors', false, 0),
      (v_question_id, 'Systematic errors', true, 1),
      (v_question_id, 'Both are always equal', false, 2),
      (v_question_id, 'Neither; analysts focus on the instrument cost', false, 3);
  END IF;

  -- 26. Seven SI base quantities
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The International System of Units (SI) defines how many base quantities and units of measure as the basic set from which all other SI units are derived?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The International System of Units (SI) defines how many base quantities and units of measure as the basic set from which all other SI units are derived?', 'single_choice', 'easy', 'The SI defines seven quantities and their units of measure as a basic set from which all other SI units are derived: mass, length, time, electric current, thermodynamic temperature, amount of substance, and luminous intensity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Seven', true, 0),
      (v_question_id, 'Nine', false, 1),
      (v_question_id, 'Five', false, 2),
      (v_question_id, 'Six', false, 3);
  END IF;

  -- 27. Kelvin
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the SI base unit for thermodynamic temperature?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the SI base unit for thermodynamic temperature?', 'single_choice', 'medium', 'Among the seven SI base units, thermodynamic temperature is expressed in the kelvin (K). The degree Celsius is listed among the commonly used SI derived units.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rankine', false, 0),
      (v_question_id, 'Degree Celsius', false, 1),
      (v_question_id, 'Degree Fahrenheit', false, 2),
      (v_question_id, 'Kelvin', true, 3);
  END IF;

  -- 28. Pascal
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is the SI derived unit of pressure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is the SI derived unit of pressure?', 'single_choice', 'easy', 'In the SI table of commonly used derived units, pressure is expressed in the pascal (Pa). The bar is only a non-SI unit accepted for use with the SI.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hertz', false, 0),
      (v_question_id, 'Newton', false, 1),
      (v_question_id, 'Pascal', true, 2),
      (v_question_id, 'Watt', false, 3);
  END IF;

  -- 29. Hectare non-SI
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is a non-SI unit accepted for use with the SI for expressing land area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is a non-SI unit accepted for use with the SI for expressing land area?', 'single_choice', 'medium', 'The hectare (ha) is listed among the non-SI units accepted by the SI for area. The square metre is an SI derived unit, not a non-SI unit.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Square metre', false, 0),
      (v_question_id, 'Hectare', true, 1),
      (v_question_id, 'Square kilometre', false, 2),
      (v_question_id, 'Cubic metre', false, 3);
  END IF;

  -- 30. Moisture meter for rice
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which metrology tool is most appropriate for determining the moisture content of harvested rice before storage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which metrology tool is most appropriate for determining the moisture content of harvested rice before storage?', 'single_choice', 'easy', 'A moisture meter is the appropriate metrology tool for determining the moisture content of harvested rice before storage.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Moisture meter', true, 0),
      (v_question_id, 'Thermometer', false, 1),
      (v_question_id, 'Weighing scale', false, 2),
      (v_question_id, 'pH meter', false, 3);
  END IF;

  -- 31. Digital caliper use
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A digital caliper is primarily used in agriculture to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A digital caliper is primarily used in agriculture to', 'single_choice', 'easy', 'A digital caliper is used to measure the thickness or diameter of small machine parts.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Measure the flow rate of irrigation water', false, 0),
      (v_question_id, 'Weigh fertilizers before application', false, 1),
      (v_question_id, 'Monitor ambient greenhouse temperature', false, 2),
      (v_question_id, 'Measure the thickness or diameter of small machine parts', true, 3);
  END IF;

  -- 32. Thermometer for composting
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following instruments is essential in ensuring safe and effective composting?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following instruments is essential in ensuring safe and effective composting?', 'single_choice', 'easy', 'A thermometer is the instrument essential in ensuring safe and effective composting (monitoring compost temperature).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'GPS', false, 0),
      (v_question_id, 'Caliper', false, 1),
      (v_question_id, 'Thermometer', true, 2),
      (v_question_id, 'pH meter', false, 3);
  END IF;

  -- 33. Coordinate-system measurement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which class of metrology equipment is a slow, contact-based method that uses a physical probe to measure an object''s exact dimensions?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which class of metrology equipment is a slow, contact-based method that uses a physical probe to measure an object''s exact dimensions?', 'single_choice', 'medium', 'Coordinate-system measurement is a slow, contact-based method using a physical probe to measure an object''s exact dimensions. In contrast, CT scanners use X-rays for internal structure, blue-light 3D scanners use structured light for non-contact surface data, and laser scanners give rapid non-contact surface scanning.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'CT scanner', false, 0),
      (v_question_id, 'Coordinate-system measurement', true, 1),
      (v_question_id, 'Laser scanner', false, 2),
      (v_question_id, 'Blue-light 3D scanner', false, 3);
  END IF;

  -- 34. Blue-light 3D scanner
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which metrology technology uses structured light patterns, in a non-contact optical manner, to capture high-resolution 3D surface data?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which metrology technology uses structured light patterns, in a non-contact optical manner, to capture high-resolution 3D surface data?', 'single_choice', 'hard', 'Blue-light 3D scanners are a non-contact optical technology using structured light patterns to capture high-resolution 3D surface data. CT scanners use X-rays to visualize internal structure.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blue-light 3D scanner', true, 0),
      (v_question_id, 'Coordinate-system measurement with a physical probe', false, 1),
      (v_question_id, 'Moisture meter', false, 2),
      (v_question_id, 'CT scanner', false, 3);
  END IF;

  -- 35. PAES 189 tachometer
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the test procedure for a coffee grinder, the speed of the rotating shafts of the major components is taken using a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the test procedure for a coffee grinder, the speed of the rotating shafts of the major components is taken using a', 'single_choice', 'easy', 'The method of test for coffee grinders requires the speed of the rotating shafts of the major components to be taken using a tachometer, with measurements taken with and without load.', NULL, NULL, 'draft', false, NULL, true, 'PAES 189')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Power meter', false, 0),
      (v_question_id, 'Noise level meter', false, 1),
      (v_question_id, 'Stop watch', false, 2),
      (v_question_id, 'Tachometer', true, 3);
  END IF;

  -- 36. PAES 189 noise distance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the test procedure for a coffee grinder, the noise level, expressed in dB(A), is measured at the location of the operators at approximately what distance from the ear level of the operators?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the test procedure for a coffee grinder, the noise level, expressed in dB(A), is measured at the location of the operators at approximately what distance from the ear level of the operators?', 'single_choice', 'hard', 'The noise level is measured with a noise level meter at the location of the operators, expressed in decibel [dB(A)], approximately 50 mm away from the ear level of the operators.', NULL, NULL, 'draft', false, NULL, true, 'PAES 189')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 000 mm', false, 0),
      (v_question_id, '5 mm', false, 1),
      (v_question_id, '50 mm', true, 2),
      (v_question_id, '500 mm', false, 3);
  END IF;

  -- 37. PAES 189 stopwatch
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The minimum list of field test equipment for the coffee grinder method of test specifies a stop watch with a resolution of';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The minimum list of field test equipment for the coffee grinder method of test specifies a stop watch with a resolution of', 'single_choice', 'medium', 'The minimum list of field test equipment specifies a stop watch with a resolution of 0.1 second.', NULL, NULL, 'draft', false, NULL, true, 'PAES 189')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 second', false, 0),
      (v_question_id, '0.1 second', true, 1),
      (v_question_id, '0.01 second', false, 2),
      (v_question_id, '0.5 second', false, 3);
  END IF;

END $$;
