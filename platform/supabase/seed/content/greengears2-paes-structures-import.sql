-- Auto-generated from supabase/seed/content/greengears2-paes-structures.json — PAES Structures/Post-Harvest Engineering deck (200 questions, 11 topics)
-- Idempotent: safe to re-run; skips questions that already exist (matched by topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left NULL (no source attribution stored).
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Agricultural Building and Structures (STRUCTURES_ENVIRONMENT) — 68 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'STRUCTURES_ENVIRONMENT';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: STRUCTURES_ENVIRONMENT';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Building and Structures' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Building and Structures', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This gutter is recommended for collecting cattle manure.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This gutter is recommended for collecting cattle manure.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'gravity drain gutter', false, 0),
      (v_question_id, 'flush gutter', false, 1),
      (v_question_id, 'scrape gutter', false, 2),
      (v_question_id, 'step-dam gutter', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'When this type of curing is used, the pavement shall be cured initially with burlap or cotton mats, until after final set of the concrete or, in any case, for 12 hours after placing the concrete.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'When this type of curing is used, the pavement shall be cured initially with burlap or cotton mats, until after final set of the concrete or, in any case, for 12 hours after placing the concrete.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'white polyethylene sheet', false, 0),
      (v_question_id, 'waterproof paper', false, 1),
      (v_question_id, 'impervious membrane method', false, 2),
      (v_question_id, 'straw', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 409:2002, how many milking operators are required for a milking herd having 11-20 animals without a milking machine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 409:2002, how many milking operators are required for a milking herd having 11-20 animals without a milking machine?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1', false, 0),
      (v_question_id, '2', true, 1),
      (v_question_id, '3', false, 2),
      (v_question_id, '4', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Doe/Ewe of 50 kg space requirement in slotted flooring.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Doe/Ewe of 50 kg space requirement in slotted flooring.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.7 sq. m.', false, 0),
      (v_question_id, '0.9 sq. m.', true, 1),
      (v_question_id, '1.1 sq. m.', false, 2),
      (v_question_id, '2.5 sq. m.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 421:2009, the tank shall have heating device able to heat a complete charge of bituminous liquid to ___ °C.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 421:2009, the tank shall have heating device able to heat a complete charge of bituminous liquid to ___ °C.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80', false, 0),
      (v_question_id, '120', false, 1),
      (v_question_id, '180', true, 2),
      (v_question_id, '200', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 415:2001, under natural ventilating systems of greenhouse, large vent openings provide the most ventilation with total vent area that should be ____ - ____ of floor area.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 415:2001, under natural ventilating systems of greenhouse, large vent openings provide the most ventilation with total vent area that should be ____ - ____ of floor area.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15% - 30%', false, 0),
      (v_question_id, '30% - 50%', false, 1),
      (v_question_id, '25% - 50%', false, 2),
      (v_question_id, '15% - 25%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 421:2009, it is constructed to drain water from the subgrade and to collect surface water either from the roadway surface or adjacent.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 421:2009, it is constructed to drain water from the subgrade and to collect surface water either from the roadway surface or adjacent.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'roadside ditch', true, 0),
      (v_question_id, 'culvert', false, 1),
      (v_question_id, 'channel', false, 2),
      (v_question_id, 'conduit', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 408:2001, the minimum space requirement for carabao feedlot feeding shall be _____ m/animal.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 408:2001, the minimum space requirement for carabao feedlot feeding shall be _____ m/animal.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5', false, 0),
      (v_question_id, '1.0', false, 1),
      (v_question_id, '0.75', true, 2),
      (v_question_id, '1.25', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 401:2000, heaters shall be installed in creep areas to provide newborn pigs its required temperature of __°C - ___°C until they are 3 days old.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 401:2000, heaters shall be installed in creep areas to provide newborn pigs its required temperature of __°C - ___°C until they are 3 days old.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '32-35', false, 0),
      (v_question_id, '29-35', false, 1),
      (v_question_id, '30-35', false, 2),
      (v_question_id, '27-35', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In lateral and sub-lateral canal where the available roadway width is 3 meters, the carriageway width shall be 2 meters and the shoulder width shall be 0.5 meters. If the available roadway width is 4 meters, the shoulder shall expand to 1 meter.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In lateral and sub-lateral canal where the available roadway width is 3 meters, the carriageway width shall be 2 meters and the shoulder width shall be 0.5 meters. If the available roadway width is 4 meters, the shoulder shall expand to 1 meter.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'roadway on main irrigation canals', false, 0),
      (v_question_id, 'road bed lateral canals', false, 1),
      (v_question_id, 'roadway on lateral & sub lateral irrigation canals', true, 2),
      (v_question_id, 'turn-out section canals', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the layer of aggregate, soil-treated aggregate, treated soil, or soil aggregate that rests upon the subbase or if no subbase, upon the sub-grade. Treatment may include application of chemical-based soil additives such as soil-stabilizers and/or any approved method.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the layer of aggregate, soil-treated aggregate, treated soil, or soil aggregate that rests upon the subbase or if no subbase, upon the sub-grade. Treatment may include application of chemical-based soil additives such as soil-stabilizers and/or any approved method.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aggregate Base Course', false, 0),
      (v_question_id, 'Base Course', true, 1),
      (v_question_id, 'Subbase Course', false, 2),
      (v_question_id, 'Aggregate Subbase Course', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 421:2009, the minimum radius of curvature for flat, rolling and mountainous terrains respectively shall be.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 421:2009, the minimum radius of curvature for flat, rolling and mountainous terrains respectively shall be.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '75, 50 & 5 m', false, 0),
      (v_question_id, '500, 150 & 50 m', true, 1),
      (v_question_id, '150, 100 & 50 m', false, 2),
      (v_question_id, '600, 200 & 100 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Standard thickness of concrete of trapezoidal ditch w/ riprap.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Standard thickness of concrete of trapezoidal ditch w/ riprap.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.25 m', true, 0),
      (v_question_id, '0.15 m', false, 1),
      (v_question_id, '0.30 m', false, 2),
      (v_question_id, '0.20 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 420:2002, the door height shall be provided with a clearance of at least ____ m above the tallest machinery.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 420:2002, the door height shall be provided with a clearance of at least ____ m above the tallest machinery.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.3', true, 0),
      (v_question_id, '0.4', false, 1),
      (v_question_id, '0.6', false, 2),
      (v_question_id, '0.7', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Recommended stacking density for corn in terms of number of bags per cubic meter.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Recommended stacking density for corn in terms of number of bags per cubic meter.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10', false, 0),
      (v_question_id, '9', false, 1),
      (v_question_id, '12', true, 2),
      (v_question_id, '15', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 418:2002, area in sqm per ton of commodity in primary processing plant is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 418:2002, area in sqm per ton of commodity in primary processing plant is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 sqm per ton', false, 0),
      (v_question_id, '15 sqm per ton', false, 1),
      (v_question_id, '20 sqm per ton', true, 2),
      (v_question_id, '25 sqm per ton', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 411:2000, the gut room/tripery shall be provided with lighting intensity of _____ lux.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 411:2000, the gut room/tripery shall be provided with lighting intensity of _____ lux.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200', false, 0),
      (v_question_id, '220', true, 1),
      (v_question_id, '540', false, 2),
      (v_question_id, '110', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 409:2002, how many milking operators are required for a milking herd having 21-30 animals without a milking machine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 409:2002, how many milking operators are required for a milking herd having 21-30 animals without a milking machine?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1', false, 0),
      (v_question_id, '2', false, 1),
      (v_question_id, '3', true, 2),
      (v_question_id, '4', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The height of hover type brooder shall be adjustable. Hovers shall be maintained at a minimum clearance of ____ above the back of the birds.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The height of hover type brooder shall be adjustable. Hovers shall be maintained at a minimum clearance of ____ above the back of the birds.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120 mm', true, 0),
      (v_question_id, '150 mm', false, 1),
      (v_question_id, '170 mm', false, 2),
      (v_question_id, '200 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Doe/Ewe of 70 kg space requirement in Slotted Flooring.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Doe/Ewe of 70 kg space requirement in Slotted Flooring.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.7 sq. m.', false, 0),
      (v_question_id, '0.9 sq. m.', false, 1),
      (v_question_id, '1.1 sq. m.', true, 2),
      (v_question_id, '2.5 sq. m.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In housing for broiler, the width of pen shall be about ___ m.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In housing for broiler, the width of pen shall be about ___ m.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10-12', true, 0),
      (v_question_id, '12-14', false, 1),
      (v_question_id, '14-16', false, 2),
      (v_question_id, '16-18', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The fence height for Brahman and other exotic breeds in a cattle ranch shall be ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The fence height for Brahman and other exotic breeds in a cattle ranch shall be ____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.7 – 1.8 m', true, 0),
      (v_question_id, '1.8 – 2.0 m', false, 1),
      (v_question_id, '1.5 – 1.7 m', false, 2),
      (v_question_id, '2.0 – 2.2 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The lairage for small and large animals shall be located at least ___ away from the slaughterhouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The lairage for small and large animals shall be located at least ___ away from the slaughterhouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 m', false, 0),
      (v_question_id, '50 m', false, 1),
      (v_question_id, '10 m', true, 2),
      (v_question_id, '30 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Maximum allowable noise limits of a slaughterhouse during night located in a noise sensitive place is ___.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Maximum allowable noise limits of a slaughterhouse during night located in a noise sensitive place is ___.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '55 dB', false, 0),
      (v_question_id, '50 dB', false, 1),
      (v_question_id, '40 dB', false, 2),
      (v_question_id, '45 dB', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Waste management structures shall be constructed on soils with at least ___ content.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Waste management structures shall be constructed on soils with at least ___ content.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15% silt', false, 0),
      (v_question_id, '10% clay', false, 1),
      (v_question_id, '15% clay', true, 2),
      (v_question_id, '15% silt-clay', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Low portable platform made of wood or plastic or metal or combination to facilitate handling, storage, or transport of materials as a unit load using a forklift.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Low portable platform made of wood or plastic or metal or combination to facilitate handling, storage, or transport of materials as a unit load using a forklift.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'pallet bin storage', false, 0),
      (v_question_id, 'bulk storage', false, 1),
      (v_question_id, 'bin', false, 2),
      (v_question_id, 'pallet', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The recommended dimension for warehouse with 10,000-cavan capacity.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The recommended dimension for warehouse with 10,000-cavan capacity.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10m x 25m', false, 0),
      (v_question_id, '10m x 30m', true, 1),
      (v_question_id, '15m x 25m', false, 2),
      (v_question_id, '15m x 30m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 421:2009, what is the minimum carriage way of one-lane and two-lane FMR, excluding shoulders?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 421:2009, what is the minimum carriage way of one-lane and two-lane FMR, excluding shoulders?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 and 4 m', true, 0),
      (v_question_id, '4 and 6 m', false, 1),
      (v_question_id, '2.5 and 5 m', false, 2),
      (v_question_id, '3 and 6 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 402:2000, the recommended brooding temperature for 14-21 days chicks.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 402:2000, the recommended brooding temperature for 14-21 days chicks.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'provide heat when necessary', false, 0),
      (v_question_id, '29-32 °C', false, 1),
      (v_question_id, '32-35 °C', false, 2),
      (v_question_id, '27-29 °C', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the defect of wood that causes abnormal growth which occurs at the starting point of a limb or branch of a tree?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the defect of wood that causes abnormal growth which occurs at the starting point of a limb or branch of a tree?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'shake', false, 0),
      (v_question_id, 'knot', true, 1),
      (v_question_id, 'check', false, 2),
      (v_question_id, 'wane', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 410:2000, the lairage shall be provided with lighting intensity of _____ lux.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 410:2000, the lairage shall be provided with lighting intensity of _____ lux.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200', false, 0),
      (v_question_id, '100', false, 1),
      (v_question_id, '500', false, 2),
      (v_question_id, '110', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 403:2001, under the individual nest subsection, there shall be one nest for each ___ to ___ layer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 403:2001, under the individual nest subsection, there shall be one nest for each ___ to ___ layer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 – 6', true, 0),
      (v_question_id, '8 – 10', false, 1),
      (v_question_id, '7 – 8', false, 2),
      (v_question_id, '4 – 6', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What cement class is used for the construction of FMR?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What cement class is used for the construction of FMR?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'AA', false, 0),
      (v_question_id, 'A', true, 1),
      (v_question_id, 'B', false, 2),
      (v_question_id, 'C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to the National Building Code, the agricultural buildings are classified under Group ___.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'According to the National Building Code, the agricultural buildings are classified under Group ___.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'B', false, 0),
      (v_question_id, 'D', false, 1),
      (v_question_id, 'J', true, 2),
      (v_question_id, 'G', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In minimum, all culverts and storm drains used in relation with FMR should be designed using a storm of ___ and 24 hours.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In minimum, all culverts and storm drains used in relation with FMR should be designed using a storm of ___ and 24 hours.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1-year', false, 0),
      (v_question_id, '2-year', true, 1),
      (v_question_id, '3-year', false, 2),
      (v_question_id, '4-year', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The noise emitted by the large ruminant''s slaughterhouse equipment, particularly the stunning box (knocking pen) shall not be more than ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The noise emitted by the large ruminant''s slaughterhouse equipment, particularly the stunning box (knocking pen) shall not be more than ____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90 dB', false, 0),
      (v_question_id, '96 dB', true, 1),
      (v_question_id, '92 dB', false, 2),
      (v_question_id, '98 dB', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the maximum height of the stacks for warehouse when using woven polypropylene bags.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the maximum height of the stacks for warehouse when using woven polypropylene bags.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 meters', true, 0),
      (v_question_id, '6 meters', false, 1),
      (v_question_id, '12 meters', false, 2),
      (v_question_id, '9 meters', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the dimension for maximum piling of stacks to conform with the fumigating sheets in situations where warehouses cannot be made airtight.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the dimension for maximum piling of stacks to conform with the fumigating sheets in situations where warehouses cannot be made airtight.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.4 m x 20.9 m x 4.5 m', false, 0),
      (v_question_id, '7.3 m x 20.9 m x 4.5 m', false, 1),
      (v_question_id, '7.3 m x 21.9 m x 4.5 m', true, 2),
      (v_question_id, '7.4 m x 21.9 m x 4.5 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Recommended stack height for warehouse should not exceed the height of the walls and a space of at least between the tops of the stacks and the roof frame.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Recommended stack height for warehouse should not exceed the height of the walls and a space of at least between the tops of the stacks and the roof frame.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 meter', false, 0),
      (v_question_id, '5 meters', false, 1),
      (v_question_id, '7 meters', false, 2),
      (v_question_id, '1 meters', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to any building or place which is used for killing of animals where the flesh is intended for human consumption.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to any building or place which is used for killing of animals where the flesh is intended for human consumption.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Slaughter House', true, 0),
      (v_question_id, 'stunning pen', false, 1),
      (v_question_id, 'Butcher house', false, 2),
      (v_question_id, 'Meat Processing Plant', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a slaughter house with required facilities and operational procedures to serve any market.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a slaughter house with required facilities and operational procedures to serve any market.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '"A" Slaughter House', false, 0),
      (v_question_id, '"AA" Slaughter House', false, 1),
      (v_question_id, '"AAA" Slaughter House', true, 2),
      (v_question_id, 'None of the Above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the amount of water requirement of a slaughter house for large animals.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the amount of water requirement of a slaughter house for large animals.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '107 liters per day per animal', false, 0),
      (v_question_id, '227 liters per day per animal', true, 1),
      (v_question_id, '207 liters per day per animal', false, 2),
      (v_question_id, '127 liters per day per animal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the amount of water requirement of a slaughter house for small animals.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the amount of water requirement of a slaughter house for small animals.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '102 liters per day per animal', false, 0),
      (v_question_id, '114 liters per day per animal', true, 1),
      (v_question_id, '104 liters per day per animal', false, 2),
      (v_question_id, '112 liters per day per animal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the amount of water requirement of a slaughter house for swine.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the amount of water requirement of a slaughter house for swine.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 liters per day per animal', false, 0),
      (v_question_id, '54 liters per day per animal', false, 1),
      (v_question_id, '60 liters per day per animal', false, 2),
      (v_question_id, '57 liters per day per animal', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum distance required of slaughter house when it is to be located near the river, streams, or lakes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum distance required of slaughter house when it is to be located near the river, streams, or lakes.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 m from the bank', false, 0),
      (v_question_id, '15 m from the bank', false, 1),
      (v_question_id, '10 m from the bank', true, 2),
      (v_question_id, '20 m from the bank', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum pipeline pressure for water supply system in slaughter houses.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum pipeline pressure for water supply system in slaughter houses.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 psi', false, 0),
      (v_question_id, '10 psi', false, 1),
      (v_question_id, '15 psi', false, 2),
      (v_question_id, '20 psi', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the recommended height of the windows for slaughter houses.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the recommended height of the windows for slaughter houses.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.0 meters above the floor', false, 0),
      (v_question_id, '2.0 meters above the floor', false, 1),
      (v_question_id, '1.5 meters above the floor', true, 2),
      (v_question_id, '2.5 meters above the floor', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum width of doorways for slaughter houses.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum width of doorways for slaughter houses.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 meters wide', false, 0),
      (v_question_id, '20 meters wide', false, 1),
      (v_question_id, '25 meters wide', false, 2),
      (v_question_id, '15 meters wide', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the allowable space between the tops for the stocks and the roof truss of the warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the allowable space between the tops for the stocks and the roof truss of the warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.0 meter', true, 0),
      (v_question_id, '1.5 meter', false, 1),
      (v_question_id, '2.0 meter', false, 2),
      (v_question_id, '2.5 meter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the optimum recommended stock height for the paddy stored in the warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the optimum recommended stock height for the paddy stored in the warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 layers', false, 0),
      (v_question_id, '14 layers', false, 1),
      (v_question_id, '16 layers', true, 2),
      (v_question_id, '18 layers', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the optimum recommended stock height for maize stored in the warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the optimum recommended stock height for maize stored in the warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 layers', false, 0),
      (v_question_id, '14 layers', false, 1),
      (v_question_id, '16 layers', false, 2),
      (v_question_id, '18 layers', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum side space requirement between the edge of the pile and the wall of the warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum side space requirement between the edge of the pile and the wall of the warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 m', true, 0),
      (v_question_id, '0.2 m', false, 1),
      (v_question_id, '1.0 m', false, 2),
      (v_question_id, '0.3 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum recommended height of the interior between the beam and the floor of warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum recommended height of the interior between the beam and the floor of warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40 feet', false, 0),
      (v_question_id, '10 feet', false, 1),
      (v_question_id, '20 feet', true, 2),
      (v_question_id, '30 feet', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the recommended size of reinforcement bar for warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the recommended size of reinforcement bar for warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 mm diameter', false, 0),
      (v_question_id, '12 mm diameter', true, 1),
      (v_question_id, '16 mm diameter', false, 2),
      (v_question_id, '24 mm diameter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum requirement for illumination of warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum requirement for illumination of warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 watts per square meter', false, 0),
      (v_question_id, '6 watts per square meter', false, 1),
      (v_question_id, '3 watts per square meter', true, 2),
      (v_question_id, '8 watts per square meter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum distance required of slaughter house from buildings used for human habitation, factory, public road and places.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum distance required of slaughter house from buildings used for human habitation, factory, public road and places.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 m', false, 0),
      (v_question_id, '50 m', false, 1),
      (v_question_id, '75 m', false, 2),
      (v_question_id, '100 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the recommended spacing of reinforcement bar for warehouse wall.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the recommended spacing of reinforcement bar for warehouse wall.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200 mm vertical and horizontal', false, 0),
      (v_question_id, '400 mm vertical and horizontal', false, 1),
      (v_question_id, '600 mm vertical and horizontal', true, 2),
      (v_question_id, '800 mm vertical and horizontal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the recommended height of floor for warehouse to permit easy loading and unloading by trucks at the sides of the warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the recommended height of floor for warehouse to permit easy loading and unloading by trucks at the sides of the warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.0 meter above the ground', true, 0),
      (v_question_id, '1.5 meter above the ground', false, 1),
      (v_question_id, '2.0 meter above the ground', false, 2),
      (v_question_id, '2.5 meter above the ground', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the recommended height of the floor if trucks are permitted to load and unload inside the warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the recommended height of the floor if trucks are permitted to load and unload inside the warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.10 m above the ground', false, 0),
      (v_question_id, '0.20 m above the ground', false, 1),
      (v_question_id, '0.30 m above the ground', true, 2),
      (v_question_id, '0.40 m above the ground', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to the location of vents in a warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to the location of vents in a warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Near the floor level', false, 0),
      (v_question_id, 'Top of the wall near grid line', false, 1),
      (v_question_id, 'Top of the roof and the ridge', false, 2),
      (v_question_id, 'All of the Above', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the maximum recommended length for greenhouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the maximum recommended length for greenhouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 meters', false, 0),
      (v_question_id, '50 meters', true, 1),
      (v_question_id, '100 meters', false, 2),
      (v_question_id, '150 meters', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the maximum recommended width for gutter connected greenhouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the maximum recommended width for gutter connected greenhouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 meters', false, 0),
      (v_question_id, '50 meters', true, 1),
      (v_question_id, '100 meters', false, 2),
      (v_question_id, '150 meters', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is an algebraic sum of all the external forces acting parallel to cross-section of one side of the section tending to cause failure by sliding movement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is an algebraic sum of all the external forces acting parallel to cross-section of one side of the section tending to cause failure by sliding movement.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shear Force', true, 0),
      (v_question_id, 'Ultimate Strength', false, 1),
      (v_question_id, 'Shearing Stress', false, 2),
      (v_question_id, 'Shear Stress', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the amount of stress that produces failure by increasing the unit stress until breakage or rupture occurs.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the amount of stress that produces failure by increasing the unit stress until breakage or rupture occurs.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shear Force', false, 0),
      (v_question_id, 'Ultimate Strength', true, 1),
      (v_question_id, 'Shearing Stress', false, 2),
      (v_question_id, 'Shear Stress', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a stress that tends to cause two contiguous parts of a body to slide, relative to each other in a direction parallel to the plant of contact.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a stress that tends to cause two contiguous parts of a body to slide, relative to each other in a direction parallel to the plant of contact.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shear Force', false, 0),
      (v_question_id, 'Ultimate Strength', false, 1),
      (v_question_id, 'Shearing Stress', true, 2),
      (v_question_id, 'Unit Stress', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the maximum stock height for grains stored in jute bags.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the maximum stock height for grains stored in jute bags.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/2 the wall height', false, 0),
      (v_question_id, '1/4 the wall height', false, 1),
      (v_question_id, 'Wall Height', true, 2),
      (v_question_id, 'None of the Above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum stock height for grains stored in woven polypropylene bags.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum stock height for grains stored in woven polypropylene bags.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/2 the wall height', true, 0),
      (v_question_id, '1/4 the wall height', false, 1),
      (v_question_id, 'Wall Height', false, 2),
      (v_question_id, 'None of the Above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the preferred lighting fixtures for warehouse building.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the preferred lighting fixtures for warehouse building.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fluorescent Lamp', true, 0),
      (v_question_id, 'Incandescent Lamp', false, 1),
      (v_question_id, 'LED Lamp', false, 2),
      (v_question_id, 'Mercury Vapor Lamp', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Rural Electrification (STRUCTURES_ENVIRONMENT) — 2 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'STRUCTURES_ENVIRONMENT';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: STRUCTURES_ENVIRONMENT';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Rural Electrification' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Rural Electrification', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 129:2002, this indicates the maximum load that can be successfully carried by the motor if it is to operate continuously and remain within a safe temperature range.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 129:2002, this indicates the maximum load that can be successfully carried by the motor if it is to operate continuously and remain within a safe temperature range.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'service factor', true, 0),
      (v_question_id, 'breakdown torque', false, 1),
      (v_question_id, 'duty rating', false, 2),
      (v_question_id, 'locked-rotor current', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The maximum number of outlets for a 15-A circuit.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The maximum number of outlets for a 15-A circuit.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8-10 outlets', true, 0),
      (v_question_id, '10-12 outlets', false, 1),
      (v_question_id, '14-15 outlets', false, 2),
      (v_question_id, '6-8 outlets', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Environmental Engineering and Science (STRUCTURES_ENVIRONMENT) — 23 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'STRUCTURES_ENVIRONMENT';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: STRUCTURES_ENVIRONMENT';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Environmental Engineering and Science' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Environmental Engineering and Science', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The introduction of substances not found in the natural composition of water that make the water less desirable or unfit for intended use';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The introduction of substances not found in the natural composition of water that make the water less desirable or unfit for intended use', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'water pollution', false, 0),
      (v_question_id, 'contamination', true, 1),
      (v_question_id, 'impurification', false, 2),
      (v_question_id, 'deterioration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Precipitate resulting from coagulation or sedimentation of liquid waste.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Precipitate resulting from coagulation or sedimentation of liquid waste.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Slurry', false, 0),
      (v_question_id, 'Sludge', true, 1),
      (v_question_id, 'Effluent', false, 2),
      (v_question_id, 'suspended solid', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Dissolved oxygen concentrations will be the lowest within a waterbody on _____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Dissolved oxygen concentrations will be the lowest within a waterbody on _____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Afternoon', false, 0),
      (v_question_id, 'Sunrise', true, 1),
      (v_question_id, 'Sunset', false, 2),
      (v_question_id, 'Noon', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 232:2017, precautionary measures in Wastewater Re-Use for Irrigation, whic is false?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 232:2017, precautionary measures in Wastewater Re-Use for Irrigation, whic is false?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Direct contact with wastewater shall be avoided', false, 0),
      (v_question_id, 'Use of fine mist for sprinkler irrigation shall be used', true, 1),
      (v_question_id, 'Potable and wastewater lines shall not cross-connect', false, 2),
      (v_question_id, 'Irrigation with wastewater shall be stopped immediately when algal bloom occurs', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum methane content of biogas in order to operate biogas-fueled generators?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the minimum methane content of biogas in order to operate biogas-fueled generators?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50%', false, 0),
      (v_question_id, '65%', true, 1),
      (v_question_id, '85%', false, 2),
      (v_question_id, '90%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of biogas plant which have aerobic conditions in the upper layers and anaerobic processes occurring in the bottom layers, especially in the settled solids?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of biogas plant which have aerobic conditions in the upper layers and anaerobic processes occurring in the bottom layers, especially in the settled solids?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aerobic Biogas', false, 0),
      (v_question_id, 'Anaerobic Biogas', false, 1),
      (v_question_id, 'Facultative Biogas', true, 2),
      (v_question_id, 'Activated Biogas', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a wastewater, either treated or untreated, discharged from a reservoir, basin, or treatment plant.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a wastewater, either treated or untreated, discharged from a reservoir, basin, or treatment plant.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Effluent', true, 0),
      (v_question_id, 'Influent', false, 1),
      (v_question_id, 'Turbid Water', false, 2),
      (v_question_id, 'Hard Water', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is an environmental-friendly refrigerant.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is an environmental-friendly refrigerant.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'CFC', false, 0),
      (v_question_id, 'HFC', true, 1),
      (v_question_id, 'HCFC', false, 2),
      (v_question_id, 'FC', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It involves the arrangement of compost mix in long, narrow piles or windrows that are periodically turned to maintain aerobic conditions.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It involves the arrangement of compost mix in long, narrow piles or windrows that are periodically turned to maintain aerobic conditions.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aerated static pile', false, 0),
      (v_question_id, 'In-vessel system composting', false, 1),
      (v_question_id, 'Windrow composting', true, 2),
      (v_question_id, 'Bin composting', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 616:2016, precautionary measures in Wastewater Re-Use for Irrigation, which is false?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 616:2016, precautionary measures in Wastewater Re-Use for Irrigation, which is false?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Direct contact with wastewater shall be avoided', false, 0),
      (v_question_id, 'Use of fine mist for sprinkler irrigation shall be used', true, 1),
      (v_question_id, 'Potable and wastewater lines shall not cross connect', false, 2),
      (v_question_id, 'Irrigation with wastewater shall be stopped immediately when algal bloom occurs', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Stoichiometric air requirement for pyrolysis.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Stoichiometric air requirement for pyrolysis.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10-20%', true, 0),
      (v_question_id, '20-30%', false, 1),
      (v_question_id, '30-40%', false, 2),
      (v_question_id, '40-50%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The C/N Ratio of agricultural waste.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The C/N Ratio of agricultural waste.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10:20', false, 0),
      (v_question_id, '20:30', true, 1),
      (v_question_id, '30:40', false, 2),
      (v_question_id, '40:50', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The moisture content of the composting agricultural solid wastes should be maintained at ___ to nourish composting bacteria.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The moisture content of the composting agricultural solid wastes should be maintained at ___ to nourish composting bacteria.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 – 60%', true, 0),
      (v_question_id, '55 – 65%', false, 1),
      (v_question_id, '40 – 50%', false, 2),
      (v_question_id, '60 – 70%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In flocculation process, it is necessary that the water being treated must be';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In flocculation process, it is necessary that the water being treated must be', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stagnant', false, 0),
      (v_question_id, 'Agitated', true, 1),
      (v_question_id, 'Filtered', false, 2),
      (v_question_id, 'Settled', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a water treatment process aimed to destroy microorganisms that cause infectious disease.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a water treatment process aimed to destroy microorganisms that cause infectious disease.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Disinfection', true, 0),
      (v_question_id, 'Coagulation', false, 1),
      (v_question_id, 'Filtration', false, 2),
      (v_question_id, 'Sedimentation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Lesser amount of chlorine is needed for water being treated if the turbidity of water is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Lesser amount of chlorine is needed for water being treated if the turbidity of water is', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'High', false, 0),
      (v_question_id, 'medium', false, 1),
      (v_question_id, 'Low', true, 2),
      (v_question_id, 'None of the Above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the commonly practiced method of disinfecting water by households.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the commonly practiced method of disinfecting water by households.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Boiling', true, 0),
      (v_question_id, 'Chlorination', false, 1),
      (v_question_id, 'Filtration', false, 2),
      (v_question_id, 'Sedimentation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a partially lined or unlined underground pit into which raw animal or household waste water is discharged.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a partially lined or unlined underground pit into which raw animal or household waste water is discharged.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Septic Tank', false, 0),
      (v_question_id, 'Cesspool', true, 1),
      (v_question_id, 'Soak Pit', false, 2),
      (v_question_id, 'Drain Field', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the breakdown of organic matter in a water solution or suspension into simpler or more biologically-stable compounds.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the breakdown of organic matter in a water solution or suspension into simpler or more biologically-stable compounds.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fermentation', false, 0),
      (v_question_id, 'Digestion', true, 1),
      (v_question_id, 'Decomposition', false, 2),
      (v_question_id, 'Stabilization', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In sedimentation, processed water is allowed to pass through a settling chamber at';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In sedimentation, processed water is allowed to pass through a settling chamber at', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Low velocity', true, 0),
      (v_question_id, 'High velocity', false, 1),
      (v_question_id, 'Equilibrium velocity', false, 2),
      (v_question_id, 'All of the Above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'They are factors that contribute to the increasing amount of waste.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'They are factors that contribute to the increasing amount of waste.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Over population', false, 0),
      (v_question_id, 'Utilization of chemicals in Agriculture', false, 1),
      (v_question_id, 'Natural catastrophes and droughts', false, 2),
      (v_question_id, 'All of the Above', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the rapid oxidation of solids in a specifically-designed combustion chamber.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the rapid oxidation of solids in a specifically-designed combustion chamber.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Combustion', false, 0),
      (v_question_id, 'Pyrolysis', false, 1),
      (v_question_id, 'Gasification', false, 2),
      (v_question_id, 'Incineration', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is waste water flowing into a reservoir or treatment plant.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is waste water flowing into a reservoir or treatment plant.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Influent', true, 0),
      (v_question_id, 'Effluent', false, 1),
      (v_question_id, 'Leachate', false, 2),
      (v_question_id, 'Sludge', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Design and Management of AB Processing System (BIOPROCESS) — 1 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'BIOPROCESS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: BIOPROCESS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Design and Management of AB Processing System' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Design and Management of AB Processing System', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to local activity or series of activities to maintain or raise the quality or change the form or characteristics of agricultural, fishery, forestry and biological products/materials and includes, but is not limited to, cleaning, sorting, grading, treating, drying, dehydrating, grinding, mixing, milling, canning, dressing, slaughtering, freezing, pasteurizing, conditioning, packaging, repacking, transporting of agricultural, fishery, forestry and other biological products/materials.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to local activity or series of activities to maintain or raise the quality or change the form or characteristics of agricultural, fishery, forestry and biological products/materials and includes, but is not limited to, cleaning, sorting, grading, treating, drying, dehydrating, grinding, mixing, milling, canning, dressing, slaughtering, freezing, pasteurizing, conditioning, packaging, repacking, transporting of agricultural, fishery, forestry and other biological products/materials.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agricultural Process Engineering', false, 0),
      (v_question_id, 'Agricultural and Bio-Processing', true, 1),
      (v_question_id, 'Agricultural and Bioprocess Engineering', false, 2),
      (v_question_id, 'Crop Process Engineering', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Elements of Food Processing and Process Design (BIOPROCESS) — 20 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'BIOPROCESS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: BIOPROCESS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Elements of Food Processing and Process Design' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Elements of Food Processing and Process Design', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rice grain from which the hull, the germ, the outer bran layer, and the greater part of the inner bran layer have been removed, but part of the lengthwise streaks of the bran layer may still be present on more than 40% of the sample grains';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Rice grain from which the hull, the germ, the outer bran layer, and the greater part of the inner bran layer have been removed, but part of the lengthwise streaks of the bran layer may still be present on more than 40% of the sample grains', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Well-milled rice', false, 0),
      (v_question_id, 'Regular milled rice', false, 1),
      (v_question_id, 'Overmilled rice', false, 2),
      (v_question_id, 'Undermilled rice', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the milled corn kernels with particle size between 1.1 mm to 1.19 mm.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the milled corn kernels with particle size between 1.1 mm to 1.19 mm.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grit #16', false, 0),
      (v_question_id, 'Grit #18', false, 1),
      (v_question_id, 'Grit #10', false, 2),
      (v_question_id, 'Grit #14', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Product of the coefficient of hulling and the coefficient of wholeness of grains, expressed in percent.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Product of the coefficient of hulling and the coefficient of wholeness of grains, expressed in percent.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Coefficient of wholeness', false, 0),
      (v_question_id, 'Coefficient of hulling', false, 1),
      (v_question_id, 'Hulling Efficiency', true, 2),
      (v_question_id, 'Fineness Modulus', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to the extent or degree by which the bran layer of the brown rice is removed as a result of whitening.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to the extent or degree by which the bran layer of the brown rice is removed as a result of whitening.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Whitening degree', false, 0),
      (v_question_id, 'Milling degree', true, 1),
      (v_question_id, 'Milling recovery', false, 2),
      (v_question_id, 'Milling index', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a rice grain from which the hull, the germ, the outer bran layers, and the greater part of the inner bran layer have been removed, but part of the lengthwise streaks of the bran layers may still be present on less than 20% of the sample grains.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a rice grain from which the hull, the germ, the outer bran layers, and the greater part of the inner bran layer have been removed, but part of the lengthwise streaks of the bran layers may still be present on less than 20% of the sample grains.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Well-milled rice', true, 0),
      (v_question_id, 'Regular milled rice', false, 1),
      (v_question_id, 'Overmilled rice', false, 2),
      (v_question_id, 'Undermilled rice', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the milled corn kernels with particle size between 1.2 mm to 1.4 mm.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the milled corn kernels with particle size between 1.2 mm to 1.4 mm.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grit #16', true, 0),
      (v_question_id, 'Grit #18', false, 1),
      (v_question_id, 'Grit #10', false, 2),
      (v_question_id, 'Grit #14', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A grain or a piece of a grain with its length equal to or greater than three-fourths (3/4) of the average length of the whole kernels';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A grain or a piece of a grain with its length equal to or greater than three-fourths (3/4) of the average length of the whole kernels', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'paddy', false, 0),
      (v_question_id, 'head rice', true, 1),
      (v_question_id, 'well-milled rice', false, 2),
      (v_question_id, 'cargo rice', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the process or suspending the carcass for particular operation.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the process or suspending the carcass for particular operation.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sticking', false, 0),
      (v_question_id, 'Pitching', false, 1),
      (v_question_id, 'Gambrelling', true, 2),
      (v_question_id, 'Stunning', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the insertion of a rod or coiled wire through the hole in the skull of a cattle made by captive blot to destroy the brain and the spinal cord to prevent reflex muscular action and possible injury to operatives.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the insertion of a rod or coiled wire through the hole in the skull of a cattle made by captive blot to destroy the brain and the spinal cord to prevent reflex muscular action and possible injury to operatives.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sticking', false, 0),
      (v_question_id, 'Pitching', true, 1),
      (v_question_id, 'Gambrelling', false, 2),
      (v_question_id, 'Stunning', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It renders the animal insensible before it is killed.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It renders the animal insensible before it is killed.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sticking', false, 0),
      (v_question_id, 'Pitching', false, 1),
      (v_question_id, 'Gambrelling', false, 2),
      (v_question_id, 'Stunning', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the removal of hide of the carcass.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the removal of hide of the carcass.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flaying', true, 0),
      (v_question_id, 'Scalding', false, 1),
      (v_question_id, 'Sticking', false, 2),
      (v_question_id, 'blanching', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to the lowering of animal into a steam to prepare the skin for dehairing.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to the lowering of animal into a steam to prepare the skin for dehairing.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flaying', false, 0),
      (v_question_id, 'Scalding', true, 1),
      (v_question_id, 'Sticking', false, 2),
      (v_question_id, 'blanching', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to the meat requiring further examination as declared by a veterinary inspector after veterinary examination.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to the meat requiring further examination as declared by a veterinary inspector after veterinary examination.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Detained Meat', true, 0),
      (v_question_id, 'Rejected Meat', false, 1),
      (v_question_id, 'Condemned Meat', false, 2),
      (v_question_id, 'Contaminated Meat', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to the meat which is unfit for human consumption as declared by a veterinary inspector after veterinary examination.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to the meat which is unfit for human consumption as declared by a veterinary inspector after veterinary examination.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Detained Meat', false, 0),
      (v_question_id, 'Rejected Meat', false, 1),
      (v_question_id, 'Condemned Meat', true, 2),
      (v_question_id, 'Contaminated Meat', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the process of preserving food materials in a hermetically-sealed container which has been sterilized with the use of heat.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the process of preserving food materials in a hermetically-sealed container which has been sterilized with the use of heat.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pasteurization', false, 0),
      (v_question_id, 'Canning', true, 1),
      (v_question_id, 'Heat sterilization', false, 2),
      (v_question_id, 'Filtration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the process of removing the solid particles from the liquid such as wine, fruit juices, vinegar, and vegetable oil.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the process of removing the solid particles from the liquid such as wine, fruit juices, vinegar, and vegetable oil.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Filtration', true, 0),
      (v_question_id, 'Distilling', false, 1),
      (v_question_id, 'Canning', false, 2),
      (v_question_id, 'Heat sterilization', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the process of subjecting the food product to a temperature of about 65°C for 30 mins. This causes the death of many but, not all of the organisms present.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the process of subjecting the food product to a temperature of about 65°C for 30 mins. This causes the death of many but, not all of the organisms present.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pasteurization', true, 0),
      (v_question_id, 'Canning', false, 1),
      (v_question_id, 'Heat sterilization', false, 2),
      (v_question_id, 'Filtration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the termination of the entire organism in the product using heat at a temperature of about 50 to 100°C.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the termination of the entire organism in the product using heat at a temperature of about 50 to 100°C.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pasteurization', false, 0),
      (v_question_id, 'Canning', false, 1),
      (v_question_id, 'Heat sterilization', true, 2),
      (v_question_id, 'Filtration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the assembling and measuring out of the required qualities of solid raw feed materials into a batch of the desired composition.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the assembling and measuring out of the required qualities of solid raw feed materials into a batch of the desired composition.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blending', true, 0),
      (v_question_id, 'Mixing', false, 1),
      (v_question_id, 'Formulation', false, 2),
      (v_question_id, 'Weighing', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the ordinary killing of all living microorganisms with the use of heat and pressure or with the use of some chemicals.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the ordinary killing of all living microorganisms with the use of heat and pressure or with the use of some chemicals.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Disinfection', false, 0),
      (v_question_id, 'Pasteurization', false, 1),
      (v_question_id, 'Sterilization', true, 2),
      (v_question_id, 'Sanitization', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Food Engineering (BIOPROCESS) — 4 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'BIOPROCESS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: BIOPROCESS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Food Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Food Engineering', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Heat absorbed by a unit mass of a material at its boiling point to convert the material into a gas without temperature change.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Heat absorbed by a unit mass of a material at its boiling point to convert the material into a gas without temperature change.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Latent heat of sublimation', false, 0),
      (v_question_id, 'Latent heat of deposition', false, 1),
      (v_question_id, 'Latent heat of fusion', false, 2),
      (v_question_id, 'Latent heat of vaporization', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The angle measured from the horizontal at which product will start to move downwards over a smooth surface with gravity discharging the product is called a ___________.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The angle measured from the horizontal at which product will start to move downwards over a smooth surface with gravity discharging the product is called a ___________.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'angle of discharge', false, 0),
      (v_question_id, 'angle of friction', true, 1),
      (v_question_id, 'angle of repose', false, 2),
      (v_question_id, 'hopper angle', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The amount of moisture in the grain expressed as a percentage of the total weight of the samples.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The amount of moisture in the grain expressed as a percentage of the total weight of the samples.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Moisture content dry basis', false, 0),
      (v_question_id, 'Moisture content wet basis', true, 1),
      (v_question_id, 'Moisture content', false, 2),
      (v_question_id, 'Equilibrium moisture content', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the value of the work done for a closed, reversible, isometric system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the value of the work done for a closed, reversible, isometric system?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'positive', false, 0),
      (v_question_id, 'negative', false, 1),
      (v_question_id, 'zero', true, 2),
      (v_question_id, 'cannot be determined', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Agricultural Machinery Design, Fabrication/Manufacturing and Testing (POWER_ENERGY_MACHINERY) — 70 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Machinery Design, Fabrication/Manufacturing and Testing' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Machinery Design, Fabrication/Manufacturing and Testing', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 204:2015, the minimum purity of the mechanical rice thresher without sifter and with fan is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 204:2015, the minimum purity of the mechanical rice thresher without sifter and with fan is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50%', false, 0),
      (v_question_id, '65%', false, 1),
      (v_question_id, '80%', false, 2),
      (v_question_id, '95%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 201:2015, the minimum heating system efficiency for biomass fuel heated air mechanical grain dryer for indirect-fired operation.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 201:2015, the minimum heating system efficiency for biomass fuel heated air mechanical grain dryer for indirect-fired operation.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '75%', false, 1),
      (v_question_id, '65%', false, 2),
      (v_question_id, '50%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 251:2018, the minimum main product recovery of corn mill is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 251:2018, the minimum main product recovery of corn mill is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '84%', false, 0),
      (v_question_id, '86%', false, 1),
      (v_question_id, '96', false, 2),
      (v_question_id, '64%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Any entity that produces agricultural and fishery machinery from prototyping, testing, commissioning, and selling. Usually, they produce agricultural and fishery machinery depending on the order and arrangement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Any entity that produces agricultural and fishery machinery from prototyping, testing, commissioning, and selling. Usually, they produce agricultural and fishery machinery depending on the order and arrangement.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Producer', false, 0),
      (v_question_id, 'assembler', false, 1),
      (v_question_id, 'manufacturer', false, 2),
      (v_question_id, 'fabricator', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 201:2015, the minimum drying efficiency of mechanical grain dryer is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 201:2015, the minimum drying efficiency of mechanical grain dryer is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '85%', false, 1),
      (v_question_id, '80%', false, 2),
      (v_question_id, '75%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 205:2000, it is the required straw length (cm)for mechanical rice thresher testing:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 205:2000, it is the required straw length (cm)for mechanical rice thresher testing:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40-45', false, 0),
      (v_question_id, '45-50', true, 1),
      (v_question_id, '50-55', false, 2),
      (v_question_id, '55-60', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 220:2004, the maximum mechanically damage kernel for peanut sheller is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 220:2004, the maximum mechanically damage kernel for peanut sheller is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.5', true, 0),
      (v_question_id, '3.0', false, 1),
      (v_question_id, '2.0', false, 2),
      (v_question_id, '7.0', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 208:2000, the minimum shelling efficiency for corn sheller:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 208:2000, the minimum shelling efficiency for corn sheller:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '97.0', false, 0),
      (v_question_id, '99.8', false, 1),
      (v_question_id, '95.0', false, 2),
      (v_question_id, '99.5', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 202:2015, Heated air mechanical grain dryer – Methods of test, the grain to be used shall be homogeneous and the moisture content should be at least _____% for rice and corn.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 202:2015, Heated air mechanical grain dryer – Methods of test, the grain to be used shall be homogeneous and the moisture content should be at least _____% for rice and corn.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18%', false, 0),
      (v_question_id, '22%', true, 1),
      (v_question_id, '24%', false, 2),
      (v_question_id, '26%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a type of whitening machine consisting of a ribbed cylinder enclosed in a perforated steel housing.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a type of whitening machine consisting of a ribbed cylinder enclosed in a perforated steel housing.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'friction type', true, 0),
      (v_question_id, 'abrasive type', false, 1),
      (v_question_id, 'rubber roll type', false, 2),
      (v_question_id, 'cone "cono" type', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A throw-in type of thresher wherein cut plants are fed between the rotating cylinder and stationary concave, and the threshed materials/straws are discharged out of the threshing chamber tangentially.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A throw-in type of thresher wherein cut plants are fed between the rotating cylinder and stationary concave, and the threshed materials/straws are discharged out of the threshing chamber tangentially.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'radial type thresher', false, 0),
      (v_question_id, 'hold-on type thresher', false, 1),
      (v_question_id, 'axial-flow thresher', false, 2),
      (v_question_id, 'through flow thresher', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The percent of moisture content of test materials for peanut sheller.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The percent of moisture content of test materials for peanut sheller.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8%-10%, wet basis', false, 0),
      (v_question_id, '12%-14%, wet basis', true, 1),
      (v_question_id, '8%-10%, dry basis', false, 2),
      (v_question_id, '12%-14%, dry basis', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ratio of the weight of corn kernels that fell out from the machine during shelling operation to the weight of the total corn kernel input of the sheller, expressed in percent.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Ratio of the weight of corn kernels that fell out from the machine during shelling operation to the weight of the total corn kernel input of the sheller, expressed in percent.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Scattering loss', true, 0),
      (v_question_id, 'Cylinder loss', false, 1),
      (v_question_id, 'Separation loss', false, 2),
      (v_question_id, 'Blower loss', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Moisture gradient of corn and rice in mechanical dryer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Moisture gradient of corn and rice in mechanical dryer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5%', false, 0),
      (v_question_id, '1.0%', false, 1),
      (v_question_id, '2.5%', false, 2),
      (v_question_id, '2.0%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the chamber maintained under pressure for uniform distribution of the heated air through the grain mass.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the chamber maintained under pressure for uniform distribution of the heated air through the grain mass.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'dust collection system', false, 0),
      (v_question_id, 'drying chamber', false, 1),
      (v_question_id, 'plenum', true, 2),
      (v_question_id, 'tempering bin', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a type of a huller with rotating blades and utilizes pressure such as Coriolis'' force, frictional force from the blades, or impact force at collision with the blades and the peripheral surface.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a type of a huller with rotating blades and utilizes pressure such as Coriolis'' force, frictional force from the blades, or impact force at collision with the blades and the peripheral surface.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'centrifugal type', true, 0),
      (v_question_id, 'friction type', false, 1),
      (v_question_id, 'abrasive type', false, 2),
      (v_question_id, 'cono type', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 206:2015, minimum percent head rice index for rice mill is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In PAES 206:2015, minimum percent head rice index for rice mill is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.97', false, 0),
      (v_question_id, '0.98', false, 1),
      (v_question_id, '0.80', false, 2),
      (v_question_id, '0.90', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Moisture gradient for Mechanical Grain Dryer';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Moisture gradient for Mechanical Grain Dryer', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2%', true, 0),
      (v_question_id, '6%', false, 1),
      (v_question_id, '4%', false, 2),
      (v_question_id, '8%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Min. shelling recovery for Peanut Sheller';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Min. shelling recovery for Peanut Sheller', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '75%', false, 0),
      (v_question_id, '60%', false, 1),
      (v_question_id, '93%', true, 2),
      (v_question_id, '96%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Noise level for Mechanical Rice Thresher, Rice Combine and Fiber Decorticator.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Noise level for Mechanical Rice Thresher, Rice Combine and Fiber Decorticator.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80 dB', false, 0),
      (v_question_id, '75 dB', false, 1),
      (v_question_id, '85 dB', false, 2),
      (v_question_id, '95 dB', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Min. Milling Recovery of Rubber Roll & Centrifugal Type Rice Mill';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Min. Milling Recovery of Rubber Roll & Centrifugal Type Rice Mill', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '96%', false, 1),
      (v_question_id, '93%', false, 2),
      (v_question_id, '98%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For corn mill testing, the min. purity of sample is ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For corn mill testing, the min. purity of sample is ____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '65%', false, 0),
      (v_question_id, '75%', false, 1),
      (v_question_id, '85%', false, 2),
      (v_question_id, '95%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Noise Level of Corn Sheller.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Noise Level of Corn Sheller.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120dB', false, 0),
      (v_question_id, '95dB', false, 1),
      (v_question_id, '100dB', true, 2),
      (v_question_id, '80dB', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A minimum of ________engine shall be used for a rotary cutting knife cutting mechanism with ________cutting width.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A minimum of ________engine shall be used for a rotary cutting knife cutting mechanism with ________cutting width.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 hp and 2.4 m', false, 0),
      (v_question_id, '5 hp and 1.2 m', true, 1),
      (v_question_id, '3 hp and 1.4 m', false, 2),
      (v_question_id, '1.5 hp and 2 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The reaper shall be operated at the speed of_________.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The reaper shall be operated at the speed of_________.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 kph to 8 kph', false, 0),
      (v_question_id, '3 kph to 5 kph', true, 1),
      (v_question_id, '2 kph to 6 kph', false, 2),
      (v_question_id, '4 kph to 9 kph', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The rubber hardness shall be ____for press-cured rubber mixes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The rubber hardness shall be ____for press-cured rubber mixes.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '85 shore', true, 0),
      (v_question_id, '95 shore', false, 1),
      (v_question_id, '75 shore', false, 2),
      (v_question_id, '65 shore', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The modulus of elasticity of the rubber shall be ____to____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The modulus of elasticity of the rubber shall be ____to____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '482 kPa to 689 kPa', true, 0),
      (v_question_id, '462 kPa to 689 kPa', false, 1),
      (v_question_id, '472 kPa to 689 kPa', false, 2),
      (v_question_id, '492 kPa to 689 kPa', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Grains that fall with the cut stalks during delivery and release at the side of the reaper during operation.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Grains that fall with the cut stalks during delivery and release at the side of the reaper during operation.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'header loss', false, 0),
      (v_question_id, 'conveying loss', true, 1),
      (v_question_id, 'shattering loss', false, 2),
      (v_question_id, 'delivery loss', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of shelling unit with cylinder having shelling elements of knife bar or Pegtooth.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of shelling unit with cylinder having shelling elements of knife bar or Pegtooth.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'open-frame cylinder', false, 0),
      (v_question_id, 'closed-frame cylinder', false, 1),
      (v_question_id, 'disc-type', false, 2),
      (v_question_id, 'cylinder-type', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of shelling unit consisting of a vertical disc with spiked surface.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of shelling unit consisting of a vertical disc with spiked surface.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'open-frame cylinder', false, 0),
      (v_question_id, 'closed-frame cylinder', false, 1),
      (v_question_id, 'disc-type', true, 2),
      (v_question_id, 'cylinder-type', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of shelling cylinder where the shelling elements are attached to the equally spaced longitudinal bars arranged cylindrically.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of shelling cylinder where the shelling elements are attached to the equally spaced longitudinal bars arranged cylindrically.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'open-frame cylinder', true, 0),
      (v_question_id, 'closed-frame cylinder', false, 1),
      (v_question_id, 'disc-type', false, 2),
      (v_question_id, 'cylinder-type', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Mechanically Damage kernel for Corn Sheller.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Mechanically Damage kernel for Corn Sheller.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3%', true, 0),
      (v_question_id, '6%', false, 1),
      (v_question_id, '4%', false, 2),
      (v_question_id, '8%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For Mechanical Grain Dryer testing, the grain to be used shall be single variety and the moisture content shall be _________and above for rice and corn with the highest available moisture content to be used in the test.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For Mechanical Grain Dryer testing, the grain to be used shall be single variety and the moisture content shall be _________and above for rice and corn with the highest available moisture content to be used in the test.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20%', true, 0),
      (v_question_id, '25%', false, 1),
      (v_question_id, '30%', false, 2),
      (v_question_id, '15%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Total losses for Peanut Sheller.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Total losses for Peanut Sheller.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5%', false, 0),
      (v_question_id, '6%', false, 1),
      (v_question_id, '7%', true, 2),
      (v_question_id, '8%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of a huller with rotating blades and utilizes pressure such as Coriolis'' force.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of a huller with rotating blades and utilizes pressure such as Coriolis'' force.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rubber Roll type', false, 0),
      (v_question_id, 'centrifugal type', true, 1),
      (v_question_id, 'Under Runner Type', false, 2),
      (v_question_id, 'Cone type', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For rice mill, hammer mill, and rubber roll testing, the min. purity of sample is ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For rice mill, hammer mill, and rubber roll testing, the min. purity of sample is ____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '96%', false, 0),
      (v_question_id, '98%', true, 1),
      (v_question_id, '93%', false, 2),
      (v_question_id, '95%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For Corn Sheller testing, the Kernel-Ear Corn Ratio of samples is ______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For Corn Sheller testing, the Kernel-Ear Corn Ratio of samples is ______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.67 – 0.71', false, 0),
      (v_question_id, '0.77 – 0.81', true, 1),
      (v_question_id, '0.57 – 0.61', false, 2),
      (v_question_id, '0.87 – 0.91', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Grain Moisture Content for Mechanical Rice Thresher testing.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Grain Moisture Content for Mechanical Rice Thresher testing.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24% MCwb', true, 0),
      (v_question_id, '20% MCwb', false, 1),
      (v_question_id, '14% MCwb', false, 2),
      (v_question_id, '17% MCwb', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Cutting mechanism consisting of planetary type circular saw-toothed blade which rotates at the same time with the pick-up triangular frame.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Cutting mechanism consisting of planetary type circular saw-toothed blade which rotates at the same time with the pick-up triangular frame.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reciprocating cutter knife', false, 0),
      (v_question_id, 'Rotary knife', false, 1),
      (v_question_id, 'Circular saw', true, 2),
      (v_question_id, 'Rotary blade', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Cutting mechanism consisting of fixed lower knife and reciprocating upper knife wherein its movement is controlled by the crank connected to the gear box or belt drive.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Cutting mechanism consisting of fixed lower knife and reciprocating upper knife wherein its movement is controlled by the crank connected to the gear box or belt drive.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rotary knife', false, 0),
      (v_question_id, 'Reciprocating cutter knife', true, 1),
      (v_question_id, 'Rotary blade', false, 2),
      (v_question_id, 'Circular saw', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For Corn Mill Testing, the sample''s variety to be used is ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For Corn Mill Testing, the sample''s variety to be used is ____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Composite', false, 0),
      (v_question_id, 'Inbred', false, 1),
      (v_question_id, 'Open pollinated', false, 2),
      (v_question_id, 'Hybrid', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Max. Total Losses of Corn Mill.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Max. Total Losses of Corn Mill.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', false, 0),
      (v_question_id, '3%', false, 1),
      (v_question_id, '2%', false, 2),
      (v_question_id, '5%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Min. Main Product recovery of Corn Mill.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Min. Main Product recovery of Corn Mill.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12%', false, 0),
      (v_question_id, '5%', true, 1),
      (v_question_id, '10%', false, 2),
      (v_question_id, '2%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the distance between two outermost divider tips.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the distance between two outermost divider tips.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cutting width', true, 0),
      (v_question_id, 'Cutting Area', false, 1),
      (v_question_id, 'Cutting Length', false, 2),
      (v_question_id, 'Cutting Height', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The rubber roll when tested in accordance with PAES 215 shall have hulling efficiency of at least______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The rubber roll when tested in accordance with PAES 215 shall have hulling efficiency of at least______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '80%', true, 1),
      (v_question_id, '75%', false, 2),
      (v_question_id, '60%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The tensile stress of the rubber roll shall be ________to________.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The tensile stress of the rubber roll shall be ________to________.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 000 kPa to 8 268 kPa', false, 0),
      (v_question_id, '9 300 kPa to 8 268 kPa', false, 1),
      (v_question_id, '6 200 kPa to 8 268 kPa', true, 2),
      (v_question_id, '8 000 kPa to 8 268 kPa', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The specific gravity of the rubber shall be ____to_______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The specific gravity of the rubber shall be ____to_______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.2 to 1.3', true, 0),
      (v_question_id, '1.5 to 1.9', false, 1),
      (v_question_id, '1.3 to 1.6', false, 2),
      (v_question_id, '1.4 to 1.8', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This type of forage chopper usually produces the longest mean particle lengths, and the least uniformly cut particles.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This type of forage chopper usually produces the longest mean particle lengths, and the least uniformly cut particles.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'random-cut forage chopper', true, 0),
      (v_question_id, 'semi-precision-cut forage chopper', false, 1),
      (v_question_id, 'precision-cut forage chopper', false, 2),
      (v_question_id, 'random precision cut chopper', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This type of forage chopper is capable of producing the shortest and most uniformly cut particles.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This type of forage chopper is capable of producing the shortest and most uniformly cut particles.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'random-cut forage chopper', false, 0),
      (v_question_id, 'random precision cut chopper', false, 1),
      (v_question_id, 'precision-cut forage chopper', true, 2),
      (v_question_id, 'semi-precision-cut forage chopper', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The noise emitted by the hammer mill, forage chopper, and coconut decorticator shall not be more than______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The noise emitted by the hammer mill, forage chopper, and coconut decorticator shall not be more than______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90 dB', false, 0),
      (v_question_id, '96 dB', true, 1),
      (v_question_id, '92 dB', false, 2),
      (v_question_id, '98 dB', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the sum of the weight fractions retained above each sieve divided by 100.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the sum of the weight fractions retained above each sieve divided by 100.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bulk Density', false, 0),
      (v_question_id, 'Specific Gravity', false, 1),
      (v_question_id, 'Uniformity Coefficient', false, 2),
      (v_question_id, 'Fineness Modulus', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The hammer mill should be used for the desired product having a reduction ratio of at least _______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The hammer mill should be used for the desired product having a reduction ratio of at least _______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20:1', false, 0),
      (v_question_id, '30:1', false, 1),
      (v_question_id, '60:1', false, 2),
      (v_question_id, '50:1', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a cylindrical roll generally with protrusions or flutes, used to gather, compress and advance the crop into the cutterhead.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a cylindrical roll generally with protrusions or flutes, used to gather, compress and advance the crop into the cutterhead.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Feed auger', false, 0),
      (v_question_id, 'Conveyor chain', false, 1),
      (v_question_id, 'Feedroll', true, 2),
      (v_question_id, 'Gathering reel', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the adjustment clearance for rubber brakes in vertical abrasive whitening cone.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the adjustment clearance for rubber brakes in vertical abrasive whitening cone.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 to 6 mm from cone coating', false, 0),
      (v_question_id, '2 to 5 mm from cone coating', false, 1),
      (v_question_id, '2 to 4 mm from cone coating', false, 2),
      (v_question_id, '2 to 3 mm from cone coating', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to the maximum speed requirement of the vertical abrasive whitening cone machine.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to the maximum speed requirement of the vertical abrasive whitening cone machine.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 m/s', false, 0),
      (v_question_id, '13 m/s', true, 1),
      (v_question_id, '18 m/s', false, 2),
      (v_question_id, '15 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the normal setting speed of the horizontal abrasive whitener.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the normal setting speed of the horizontal abrasive whitener.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '500 rpm', false, 0),
      (v_question_id, '800 rpm', false, 1),
      (v_question_id, '1000 rpm', true, 2),
      (v_question_id, '1200 rpm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the average velocity of the hammer tip of a hammer mill.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the average velocity of the hammer tip of a hammer mill.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 m/s', false, 0),
      (v_question_id, '20 m/s', false, 1),
      (v_question_id, '100 m/s', true, 2),
      (v_question_id, '200 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the approximate speed of a horizontal type feed mixer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the approximate speed of a horizontal type feed mixer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 rpm', false, 0),
      (v_question_id, '10 rpm', false, 1),
      (v_question_id, '15 rpm', false, 2),
      (v_question_id, '25 rpm', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the optimum mixing time of a vertical-type feed mixer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the optimum mixing time of a vertical-type feed mixer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 minutes', false, 0),
      (v_question_id, '15 minutes', true, 1),
      (v_question_id, '30 minutes', false, 2),
      (v_question_id, '45 minutes', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is used to control the flow of materials in a feed milling plant to ensure that it will enter the full width of the mill chamber and at the same time, optimum capacity is obtained while the motor is overloaded.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is used to control the flow of materials in a feed milling plant to ensure that it will enter the full width of the mill chamber and at the same time, optimum capacity is obtained while the motor is overloaded.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conveyor', false, 0),
      (v_question_id, 'Feeder', true, 1),
      (v_question_id, 'Hopper', false, 2),
      (v_question_id, 'Chute', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'They are feed mixers that are characterized by high capacity, short mixing time, and high power requirement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'They are feed mixers that are characterized by high capacity, short mixing time, and high power requirement.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Horizontal mixer', true, 0),
      (v_question_id, 'Vertical mixers', false, 1),
      (v_question_id, 'Drum Mixer', false, 2),
      (v_question_id, 'Pan Mixe', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a feed mixer which has an auger that elevates the feed on top of the mixing bin and is spread evenly in the bin by gravity for another mixing cycle.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a feed mixer which has an auger that elevates the feed on top of the mixing bin and is spread evenly in the bin by gravity for another mixing cycle.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Horizontal mixer', false, 0),
      (v_question_id, 'Vertical mixers', true, 1),
      (v_question_id, 'Drum Mixer', false, 2),
      (v_question_id, 'Pan Mixe', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a mixer which consists of a U shaped bin that contains a central mixing blade or ribbon mounted on a rotating shaft.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a mixer which consists of a U shaped bin that contains a central mixing blade or ribbon mounted on a rotating shaft.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Horizontal mixer', true, 0),
      (v_question_id, 'Vertical mixers', false, 1),
      (v_question_id, 'Drum Mixer', false, 2),
      (v_question_id, 'Pan Mixe', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a feed mixer that is characterized by low capacity, longer mixing time, and low power requirement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a feed mixer that is characterized by low capacity, longer mixing time, and low power requirement.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Horizontal mixer', false, 0),
      (v_question_id, 'Vertical mixers', true, 1),
      (v_question_id, 'Drum Mixer', false, 2),
      (v_question_id, 'Pan Mixe', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum by-product recovery required in the performance criteria for corn mill.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum by-product recovery required in the performance criteria for corn mill.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '31%', true, 0),
      (v_question_id, '36%', false, 1),
      (v_question_id, '22%', false, 2),
      (v_question_id, '24%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the minimum main product recovery required in the performance criteria for corn mill.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the minimum main product recovery required in the performance criteria for corn mill.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '68%', false, 0),
      (v_question_id, '75%', false, 1),
      (v_question_id, '64%', true, 2),
      (v_question_id, '80%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the ratio of the weight of corn kernel input to the total operating time.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the ratio of the weight of corn kernel input to the total operating time.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grinding Efficiency', false, 0),
      (v_question_id, 'Milling Capacity', true, 1),
      (v_question_id, 'Milling Recovery', false, 2),
      (v_question_id, 'Output Rate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the major component of a corn mill that reduce a corn kernel into grits.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the major component of a corn mill that reduce a corn kernel into grits.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hammer Mill', false, 0),
      (v_question_id, 'Steel Roller Mill', true, 1),
      (v_question_id, 'Grinding Plate', false, 2),
      (v_question_id, 'Disc Mill', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the ratio of the weight of corn grits to the total weight of corn kernel input expressed in percent.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the ratio of the weight of corn grits to the total weight of corn kernel input expressed in percent.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grinding Efficiency', false, 0),
      (v_question_id, 'Milling Capacity', false, 1),
      (v_question_id, '% main product recovery', true, 2),
      (v_question_id, 'Output Rate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the recommended clearance setting between stones of a disk huller.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the recommended clearance setting between stones of a disk huller.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/3 of the length of the paddy', false, 0),
      (v_question_id, '1/4 of the length of the paddy', false, 1),
      (v_question_id, '1/2 of the length of the paddy', true, 2),
      (v_question_id, '1 of the length of the paddy', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Agricultural Machinery, Power Units, and Workshop Management (POWER_ENERGY_MACHINERY) — 1 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Machinery, Power Units, and Workshop Management' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Machinery, Power Units, and Workshop Management', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a welding area, a welding hood with a fan that will move air about ____ shall be provided.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For a welding area, a welding hood with a fan that will move air about ____ shall be provided.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '28-57 cu. m/min', true, 0),
      (v_question_id, '38-67 cu. m/min', false, 1),
      (v_question_id, '18-37 cu. m/min', false, 2),
      (v_question_id, '28-67 cu. m/min', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Renewable and Alternative Farm Power Sources (POWER_ENERGY_MACHINERY) — 6 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Renewable and Alternative Farm Power Sources' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Renewable and Alternative Farm Power Sources', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Burning efficiency of the biomass furnace shall be at least:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Burning efficiency of the biomass furnace shall be at least:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '98%', false, 0),
      (v_question_id, '95%', true, 1),
      (v_question_id, '90%', false, 2),
      (v_question_id, '80%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Main product of gasification.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Main product of gasification.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'CH4', false, 0),
      (v_question_id, 'CO', true, 1),
      (v_question_id, 'O2', false, 2),
      (v_question_id, 'CO2', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The heating system efficiency for rice hull direct-fired mechanical grain dryer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The heating system efficiency for rice hull direct-fired mechanical grain dryer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '95%', false, 0),
      (v_question_id, '80%', false, 1),
      (v_question_id, '90%', false, 2),
      (v_question_id, '65%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a cantilever beam that holds the gasholder/movable cover in position at the desired biogas pressure';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a cantilever beam that holds the gasholder/movable cover in position at the desired biogas pressure', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'gasholder retainer', true, 0),
      (v_question_id, 'gasholding beam', false, 1),
      (v_question_id, 'gasholder frame', false, 2),
      (v_question_id, 'biogas cover-lever', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Solar Powered Irrigation System Photovoltaic array should be facing ____ based on efficiency and performance';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Solar Powered Irrigation System Photovoltaic array should be facing ____ based on efficiency and performance', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'North', false, 0),
      (v_question_id, 'South', true, 1),
      (v_question_id, 'East', false, 2),
      (v_question_id, 'West', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a type of biogas plant where the digester is separated from the gas chamber.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a type of biogas plant where the digester is separated from the gas chamber.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fixed-Dome Type', false, 0),
      (v_question_id, 'Floating-Drum Type', false, 1),
      (v_question_id, 'Balloon-Type Plant', false, 2),
      (v_question_id, 'Split-type Plant', true, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Engineering Economy and Project Feasibility Analysis (PROJECT_MGMT_RDE) — 4 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Engineering Economy and Project Feasibility Analysis' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Engineering Economy and Project Feasibility Analysis', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In CPES rating, what is the equivalent score of very satisfactory?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In CPES rating, what is the equivalent score of very satisfactory?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '82% to 89%', false, 0),
      (v_question_id, '89% to 96%', true, 1),
      (v_question_id, '75% to 82%', false, 2),
      (v_question_id, '< 96%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'All projects shall be subjected to a minimum of ___ evaluations to be performed by the CPE during construction. Except for those projects with a duration of 90 calendar days and below which may be subjected to at least ___ visit.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'All projects shall be subjected to a minimum of ___ evaluations to be performed by the CPE during construction. Except for those projects with a duration of 90 calendar days and below which may be subjected to at least ___ visit.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,2', false, 0),
      (v_question_id, '2,1', true, 1),
      (v_question_id, '2,3', false, 2),
      (v_question_id, '3,2', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In order to become an accredited CPES evaluator, an applicant must have at least _____ years of experience in the actual implementation of project.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In order to become an accredited CPES evaluator, an applicant must have at least _____ years of experience in the actual implementation of project.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3', false, 0),
      (v_question_id, '2', false, 1),
      (v_question_id, '5', true, 2),
      (v_question_id, '7', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Defects Liability Period shall be _____ year/s from project completion up to final acceptance by the Government.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Defects Liability Period shall be _____ year/s from project completion up to final acceptance by the Government.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 year', true, 0),
      (v_question_id, '2 years', false, 1),
      (v_question_id, '3 years', false, 2),
      (v_question_id, '5 years', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Laws, Professional Standards, and Ethics (LAWS_ETHICS) — 1 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In accordance to RA 9367, (a) at least ___ % bioethanol in the annual total volume of gasoline fuel actually sold and distributed by each and every oil company in the country; (b) at least _____ % blend of biodiesel by volume, is required.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In accordance to RA 9367, (a) at least ___ % bioethanol in the annual total volume of gasoline fuel actually sold and distributed by each and every oil company in the country; (b) at least _____ % blend of biodiesel by volume, is required.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5;2', true, 0),
      (v_question_id, '10;2', false, 1),
      (v_question_id, '5;5', false, 2),
      (v_question_id, '10;5', false, 3);
  END IF;

END $$;
