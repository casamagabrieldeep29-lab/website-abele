-- Auto-generated from supabase/seed/content/paes-601-616-irrigation.json — PAES 601-616 Irrigation and Drainage Engineering quiz batch (89 questions, 1 topic)
-- Covers PAES 601-616 (all 5 source extraction batches merged: 601-604, 605-607, 608-609, 610-612, 613-616).
-- Idempotent: safe to re-run; skips questions that already exist (matched by topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left NULL (no source attribution stored),
-- and is_paes=true with paes_reference set to the specific PAES standard number the question tests.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Irrigation and Drainage Engineering (LAND_WATER) — 89 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Irrigation and Drainage Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Irrigation and Drainage Engineering', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 601, which term is defined as ''the vertical distance measured from the top of the dam down to the bedrock''?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 601, which term is defined as ''the vertical distance measured from the top of the dam down to the bedrock''?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 601')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dam height', false, 0),
      (v_question_id, 'Designed height', false, 1),
      (v_question_id, 'Finished height', false, 2),
      (v_question_id, 'Structural height', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which term does PAES 601 define as ''the ratio of the horizontal to vertical dimension of the channel wall''?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which term does PAES 601 define as ''the ratio of the horizontal to vertical dimension of the channel wall''?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 601')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Channel bed slope', false, 0),
      (v_question_id, 'Side slope', true, 1),
      (v_question_id, 'Hydraulic depth', false, 2),
      (v_question_id, 'Hydraulic radius', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 601, which term refers to ''water escaping below or out from water conveyance facilities such as open ditches, canals, natural channels, and waterway''?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 601, which term refers to ''water escaping below or out from water conveyance facilities such as open ditches, canals, natural channels, and waterway''?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 601')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Percolation', false, 0),
      (v_question_id, 'Conveyance loss', false, 1),
      (v_question_id, 'Seepage', true, 2),
      (v_question_id, 'Leaching', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 601, ''application efficiency'' is best described as which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 601, ''application efficiency'' is best described as which of the following?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 601')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ratio between water received at the inlet for a block of fields to that released at the project''s headwork', false, 0),
      (v_question_id, 'Ratio of the particle size at 60% passing to that at 10% passing', false, 1),
      (v_question_id, 'Numerical value on the uniformity of application for agricultural irrigation systems', false, 2),
      (v_question_id, 'Ratio of the average depth of irrigation water infiltrated and stored in the root zone to the average depth of irrigation water applied', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 601, which canal structure is defined as a ''closed conduit designed to convey canal water in full and under pressure running condition, to convey canal water by gravity under roadways, railways, drainage channels and local depressions''?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 601, which canal structure is defined as a ''closed conduit designed to convey canal water in full and under pressure running condition, to convey canal water by gravity under roadways, railways, drainage channels and local depressions''?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 601')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drop', false, 0),
      (v_question_id, 'Elevated flume', false, 1),
      (v_question_id, 'Equipment crossing', false, 2),
      (v_question_id, 'Inverted siphon', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on PAES 602 Table 4, what is the crop coefficient (Kc) for lowland rice during the 40-70% growth stage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Based on PAES 602 Table 4, what is the crop coefficient (Kc) for lowland rice during the 40-70% growth stage?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 602')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.05', false, 0),
      (v_question_id, '0.95', false, 1),
      (v_question_id, '0.61', false, 2),
      (v_question_id, '1.10', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 602 Table 5, what is the percolation rate for clay loam soil?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 602 Table 5, what is the percolation rate for clay loam soil?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 602')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 mm/day', false, 0),
      (v_question_id, '1.75 mm/day', true, 1),
      (v_question_id, '1.5 mm/day', false, 2),
      (v_question_id, '1.25 mm/day', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 602 Table 6 (USDA values), what is the field application efficiency for light soils under surface irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 602 Table 6 (USDA values), what is the field application efficiency for light soils under surface irrigation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 602')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.60', false, 0),
      (v_question_id, '0.55', true, 1),
      (v_question_id, '0.70', false, 2),
      (v_question_id, '0.32', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 602 Table 7, what conveyance efficiency value corresponds to a continuous water supply system with no substantial change in flow?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 602 Table 7, what conveyance efficiency value corresponds to a continuous water supply system with no substantial change in flow?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 602')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.65', false, 0),
      (v_question_id, '0.9', true, 1),
      (v_question_id, '0.8', false, 2),
      (v_question_id, '0.7', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 602 Table B.16, what is the diameter of a Class A evaporation pan?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 602 Table B.16, what is the diameter of a Class A evaporation pan?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 602')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '46 cm', false, 0),
      (v_question_id, '120.7 cm', true, 1),
      (v_question_id, '100 cm', false, 2),
      (v_question_id, '92 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 602 Table B.16, what is the depth of a Class A pan?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 602 Table B.16, what is the depth of a Class A pan?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 602')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '92 cm', false, 0),
      (v_question_id, '46 cm', false, 1),
      (v_question_id, '25 cm', true, 2),
      (v_question_id, '15 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 603 Table 1, what is the maximum permissible velocity for an unlined canal excavated in clay loam?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 603 Table 1, what is the maximum permissible velocity for an unlined canal excavated in clay loam?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 603')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.80 m/s', true, 0),
      (v_question_id, '0.60 m/s', false, 1),
      (v_question_id, '0.70 m/s', false, 2),
      (v_question_id, '0.90 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 603 Table 2, what is the mean roughness coefficient (Manning''s n) for a concrete-lined canal?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 603 Table 2, what is the mean roughness coefficient (Manning''s n) for a concrete-lined canal?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 603')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0130', true, 0),
      (v_question_id, '0.0300', false, 1),
      (v_question_id, '0.0220', false, 2),
      (v_question_id, '0.0320', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on PAES 603 Table 3, what is the recommended stable side slope for an unlined channel in cutting reaches through hard rock?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Based on PAES 603 Table 3, what is the recommended stable side slope for an unlined channel in cutting reaches through hard rock?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 603')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1:1 to 1.5:1', false, 0),
      (v_question_id, '1/4:1 to 1/2:1', true, 1),
      (v_question_id, '1/4:1 to 1:1', false, 2),
      (v_question_id, '1.5:1 to 2:1', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For lined channels, what side slope does PAES 603 recommend (Section 5.4.1.1)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For lined channels, what side slope does PAES 603 recommend (Section 5.4.1.1)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 603')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5:1', true, 0),
      (v_question_id, '2:1 to 3:1', false, 1),
      (v_question_id, '2:1', false, 2),
      (v_question_id, '1:1 to 1.5:1', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 603 Table 4, for a channel discharge of 20 m3/s in an unlined channel, what is the recommended range of bed-width-to-depth (b/d) ratio?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 603 Table 4, for a channel discharge of 20 m3/s in an unlined channel, what is the recommended range of bed-width-to-depth (b/d) ratio?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 603')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.00-4.00', false, 0),
      (v_question_id, '3.00-5.50', false, 1),
      (v_question_id, '3.75-6.50', true, 2),
      (v_question_id, '4.00-7.00', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 604 Table 1, what is the seepage and percolation value for silty clay loam soil?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 604 Table 1, what is the seepage and percolation value for silty clay loam soil?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 604')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5 mm/day', false, 0),
      (v_question_id, '1.75 mm/day', true, 1),
      (v_question_id, '1.25 mm/day', false, 2),
      (v_question_id, '2 mm/day', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 604, what is the minimum required length of the test section (pond) for the ponding method?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 604, what is the minimum required length of the test section (pond) for the ponding method?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 604')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16.49 m', false, 0),
      (v_question_id, '11 m', false, 1),
      (v_question_id, '10 m', true, 2),
      (v_question_id, '1.5 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 604, what is the recommended buffer zone span provided at each end of the test section?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 604, what is the recommended buffer zone span provided at each end of the test section?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 604')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.73 m', false, 0),
      (v_question_id, '11 m', false, 1),
      (v_question_id, '1.5 m', true, 2),
      (v_question_id, '1.83 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 604, at what percentage of channel depth should the pond and buffer zones be filled with water (normal operating capacity)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 604, at what percentage of channel depth should the pond and buffer zones be filled with water (normal operating capacity)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 604')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80%', true, 0),
      (v_question_id, '55%', false, 1),
      (v_question_id, '70%', false, 2),
      (v_question_id, '40%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 604, how is the change in water depth in the pond (deltaH) calculated?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 604, how is the change in water depth in the pond (deltaH) calculated?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 604')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'deltaH = Hi + Hf', false, 0),
      (v_question_id, 'deltaH = Hi - Hf', true, 1),
      (v_question_id, 'deltaH = Hf - Hi', false, 2),
      (v_question_id, 'deltaH = (Hi+Hf)/2', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 605, what is the minimum recommended length of channel section (with uniform cross-section and grade) between the inflow and outflow measuring points for determining conveyance loss?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 605, what is the minimum recommended length of channel section (with uniform cross-section and grade) between the inflow and outflow measuring points for determining conveyance loss?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 605')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 m', true, 0),
      (v_question_id, '75 m', false, 1),
      (v_question_id, '150 m', false, 2),
      (v_question_id, '100 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 605, the seepage and percolation loss rate in the inflow-outflow method is computed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 605, the seepage and percolation loss rate in the inflow-outflow method is computed as:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 605')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '(Qi - Qo) / L', true, 0),
      (v_question_id, 'Qi x Qo / L', false, 1),
      (v_question_id, '(Qo - Qi) / L', false, 2),
      (v_question_id, '(Qi + Qo) / L', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the discharge equation for a Cipoletti weir according to PAES 605?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the discharge equation for a Cipoletti weir according to PAES 605?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 605')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Q = C Ha^n', false, 0),
      (v_question_id, 'Q = 1.84 (L - 0.2H) H^(3/2)', false, 1),
      (v_question_id, 'Q = (8/15) sqrt(2gCd) H^(5/2)', false, 2),
      (v_question_id, 'Q = 1.86 L H^(3/2)', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 605 Annex B, what is the free flow limit (Hb/Ha) for a Parshall flume with a throat width between 30.5 cm and 244 cm (1 ft to 8 ft)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 605 Annex B, what is the free flow limit (Hb/Ha) for a Parshall flume with a throat width between 30.5 cm and 244 cm (1 ft to 8 ft)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 605')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80%', false, 0),
      (v_question_id, '60%', false, 1),
      (v_question_id, '25%', false, 2),
      (v_question_id, '70%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 605 Table B.7, what is the discharge coefficient (Cd) for free flow through a circular sharp-edged orifice with a diameter of 0.075 m or greater?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 605 Table B.7, what is the discharge coefficient (Cd) for free flow through a circular sharp-edged orifice with a diameter of 0.075 m or greater?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 605')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.60', true, 0),
      (v_question_id, '0.64', false, 1),
      (v_question_id, '0.61', false, 2),
      (v_question_id, '0.57', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the maximum allowable velocity for a box culvert conduit according to PAES 606 Table 2?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the maximum allowable velocity for a box culvert conduit according to PAES 606 Table 2?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 606')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.50 m/s', false, 0),
      (v_question_id, '1.20 m/s', true, 1),
      (v_question_id, '2.00 m/s', false, 2),
      (v_question_id, '1.00 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 606 Table 1, what is the actual diameter of an RCP with a nominal diameter of 60 cm (24 in)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 606 Table 1, what is the actual diameter of an RCP with a nominal diameter of 60 cm (24 in)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 606')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '61 cm', true, 0),
      (v_question_id, '45 cm', false, 1),
      (v_question_id, '76 cm', false, 2),
      (v_question_id, '46 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum recommended clearance between the road and culvert for a railroad or road crossing per PAES 606?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the minimum recommended clearance between the road and culvert for a railroad or road crossing per PAES 606?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 606')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.20 m', false, 0),
      (v_question_id, '0.60 m', false, 1),
      (v_question_id, '0.90 m', true, 2),
      (v_question_id, '1.00 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 606, what is the recommended initial velocity in the flume section of an elevated flume?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 606, what is the recommended initial velocity in the flume section of an elevated flume?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 606')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5 m/s to 2.0 m/s', false, 0),
      (v_question_id, '1.2 m/s to 1.5 m/s', true, 1),
      (v_question_id, '1.00 m/s', false, 2),
      (v_question_id, '1.20 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 606, above what elevation difference must an inclined drop or chute be used instead of other drop structure types?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 606, above what elevation difference must an inclined drop or chute be used instead of other drop structure types?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 606')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.5 m', false, 0),
      (v_question_id, '5 m', true, 1),
      (v_question_id, '0.90 m', false, 2),
      (v_question_id, '1 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 607 Table 6, what is the recommended furrow spacing for coarse sand soil?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 607 Table 6, what is the recommended furrow spacing for coarse sand soil?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 607')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 cm', true, 0),
      (v_question_id, '60 cm', false, 1),
      (v_question_id, '75 cm', false, 2),
      (v_question_id, '150 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 607, what is the maximum flow rate assigned to a single outlet in basin irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 607, what is the maximum flow rate assigned to a single outlet in basin irrigation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 607')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.21 m3/s', false, 0),
      (v_question_id, '0.3 m3/s', false, 1),
      (v_question_id, '0.4 m3/s', true, 2),
      (v_question_id, '0.06 m3/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum design application efficiency required for basin irrigation per PAES 607?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the minimum design application efficiency required for basin irrigation per PAES 607?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 607')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60%', false, 0),
      (v_question_id, '80%', false, 1),
      (v_question_id, '70%', true, 2),
      (v_question_id, '25%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 607 Table 1, what is the recommended slope range for border irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 607 Table 1, what is the recommended slope range for border irrigation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 607')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '<= 0.1%', false, 0),
      (v_question_id, '0.05% to 3.0%', false, 1),
      (v_question_id, '< 0.5%', false, 2),
      (v_question_id, '2.0% to 5.0%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 607, what is the recommended default stream size for furrow irrigation when the furrows are not too long?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 607, what is the recommended default stream size for furrow irrigation when the furrows are not too long?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 607')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 L/s', true, 0),
      (v_question_id, '1.2 L/s', false, 1),
      (v_question_id, '3.0 L/s', false, 2),
      (v_question_id, '2.5 L/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 608 Part A, what is the maximum allowable velocity in the main line of a sprinkler irrigation system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 608 Part A, what is the maximum allowable velocity in the main line of a sprinkler irrigation system?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.0 m/s', false, 0),
      (v_question_id, '2.0 m/s', true, 1),
      (v_question_id, '2.5 m/s', false, 2),
      (v_question_id, '1.5 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 608 Part A, the allowable friction loss in the laterals of a sprinkler irrigation system shall not exceed what percentage of the average pressure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 608 Part A, the allowable friction loss in the laterals of a sprinkler irrigation system shall not exceed what percentage of the average pressure?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30%', false, 0),
      (v_question_id, '20%', true, 1),
      (v_question_id, '10%', false, 2),
      (v_question_id, '40%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 608 Part A, sprinkler irrigation is not suitable for soils with an intake rate below what value?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 608 Part A, sprinkler irrigation is not suitable for soils with an intake rate below what value?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 mm/hr', false, 0),
      (v_question_id, '3 mm/hr', true, 1),
      (v_question_id, '16 mm/hr', false, 2),
      (v_question_id, '8 mm/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on Table 3 of PAES 608 Part A, what is the sprinkler discharge (q) for a 4.0 mm nozzle operating at 300 kPa?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Based on Table 3 of PAES 608 Part A, what is the sprinkler discharge (q) for a 4.0 mm nozzle operating at 300 kPa?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.82 m3/h', false, 0),
      (v_question_id, '1.32 m3/h', false, 1),
      (v_question_id, '1.08 m3/h', true, 2),
      (v_question_id, '0.57 m3/h', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to Annex B of PAES 608 Part A, what is the minimum working pressure (PN) for quick-coupling aluminum pipes used in sprinkler systems?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to Annex B of PAES 608 Part A, what is the minimum working pressure (PN) for quick-coupling aluminum pipes used in sprinkler systems?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.0 bars', false, 0),
      (v_question_id, '4.0 bars', false, 1),
      (v_question_id, '12.0 bars', false, 2),
      (v_question_id, '7.0 bars', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 608 Part B, what manufacturer''s coefficient of variation (Cv) range is classified as ''excellent'' for a point-source emitter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 608 Part B, what manufacturer''s coefficient of variation (Cv) range is classified as ''excellent'' for a point-source emitter?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.05 to 0.07', false, 0),
      (v_question_id, 'Less than 0.05', true, 1),
      (v_question_id, 'Less than 0.10', false, 2),
      (v_question_id, '0.07 to 0.11', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 608 Part B, which emitter type has a discharge exponent (x) of 0, making its flow least affected by pressure variation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 608 Part B, which emitter type has a discharge exponent (x) of 0, making its flow least affected by pressure variation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Long-path emitter', false, 0),
      (v_question_id, 'Orifice type emitter', false, 1),
      (v_question_id, 'Fully-compensating emitter', true, 2),
      (v_question_id, 'Tortuous-path emitter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the design emission uniformity (EU) equation given in PAES 608 Part B, which symbol represents the number of emitters per plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the design emission uniformity (EU) equation given in PAES 608 Part B, which symbol represents the number of emitters per plant?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'qa', false, 0),
      (v_question_id, 'qm', false, 1),
      (v_question_id, 'Np', true, 2),
      (v_question_id, 'Cv', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 2 of PAES 608 Part B, what is the maximum EC_e (electrical conductivity of saturated soil extract, dS/m) value listed for cotton, at which crop yield is reduced to zero?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 2 of PAES 608 Part B, what is the maximum EC_e (electrical conductivity of saturated soil extract, dS/m) value listed for cotton, at which crop yield is reduced to zero?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '19 dS/m', false, 0),
      (v_question_id, '24 dS/m', false, 1),
      (v_question_id, '27 dS/m', true, 2),
      (v_question_id, '13 dS/m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to Table 4 of PAES 608 Part B, what is the discharge exponent (x) range for a tortuous-path emitter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to Table 4 of PAES 608 Part B, what is the discharge exponent (x) range for a tortuous-path emitter?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 608')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.4', false, 0),
      (v_question_id, '0.5 to 0.7', true, 1),
      (v_question_id, '0.7 to 0.8', false, 2),
      (v_question_id, '0', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 609, what is the minimum required reservoir area at normal water level for a small water impounding system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 609, what is the minimum required reservoir area at normal water level for a small water impounding system?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 609')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 ha', false, 0),
      (v_question_id, '0.5 ha', false, 1),
      (v_question_id, '1 ha', true, 2),
      (v_question_id, '5 ha', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 609, what is the maximum recommended slope for the watershed of a small water impounding system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 609, what is the maximum recommended slope for the watershed of a small water impounding system?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 609')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40%', false, 0),
      (v_question_id, '18%', true, 1),
      (v_question_id, '5%', false, 2),
      (v_question_id, '10%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 609, the soil at a dam site shall be well-graded and shall contain at least what percentage of clay?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 609, the soil at a dam site shall be well-graded and shall contain at least what percentage of clay?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 609')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5%', false, 0),
      (v_question_id, '70%', false, 1),
      (v_question_id, '10%', false, 2),
      (v_question_id, '30%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 609, dead storage volume in a small water impounding reservoir is computed based on how many years of sediment accumulation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 609, dead storage volume in a small water impounding reservoir is computed based on how many years of sediment accumulation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 609')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 years', false, 0),
      (v_question_id, '25 years', true, 1),
      (v_question_id, '10 years', false, 2),
      (v_question_id, '15 years', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 609 Annex B, what riprap factor (C) is used for dumped riprap when sizing rock or stone for embankment slope protection?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 609 Annex B, what riprap factor (C) is used for dumped riprap when sizing rock or stone for embankment slope protection?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 609')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.80', true, 0),
      (v_question_id, '0.70', false, 1),
      (v_question_id, '0.54', false, 2),
      (v_question_id, '0.90', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 610, a small farm reservoir is defined as a system with an earth dam embankment height of less than what value?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 610, a small farm reservoir is defined as a system with an earth dam embankment height of less than what value?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 610')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 m', false, 0),
      (v_question_id, '35 m', false, 1),
      (v_question_id, '15 m', false, 2),
      (v_question_id, '5 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the recommended inside slope (upstream face) of a small farm reservoir embankment, per PAES 610?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the recommended inside slope (upstream face) of a small farm reservoir embankment, per PAES 610?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 610')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1:1.8 to 1:2 (H:V)', false, 0),
      (v_question_id, '3:1 (H:V)', true, 1),
      (v_question_id, '2:1 (H:V)', false, 2),
      (v_question_id, '1:2.5 to 1:2.75 (H:V)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the required crest width range (Bt) for a small farm reservoir embankment under PAES 610?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the required crest width range (Bt) for a small farm reservoir embankment under PAES 610?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 610')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 m minimum', false, 0),
      (v_question_id, '0.75 m minimum', false, 1),
      (v_question_id, '2 m to 3 m', true, 2),
      (v_question_id, '4 m minimum', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 610, what is the minimum required depth of the diversion channel around a small farm reservoir?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 610, what is the minimum required depth of the diversion channel around a small farm reservoir?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 610')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 m', false, 0),
      (v_question_id, '1 m', false, 1),
      (v_question_id, '5 m', false, 2),
      (v_question_id, '0.75 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 610 Table 2, what is the minimum size of catchment area required per 1000 m² of reservoir capacity for terraced land use?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 610 Table 2, what is the minimum size of catchment area required per 1000 m² of reservoir capacity for terraced land use?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 610')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.0 ha', false, 0),
      (v_question_id, '0.6 ha', false, 1),
      (v_question_id, '0.2 ha', true, 2),
      (v_question_id, '0.5 ha', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 610, what soil texture is required within 1.5 m of the soil profile at a small farm reservoir site?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 610, what soil texture is required within 1.5 m of the soil profile at a small farm reservoir site?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 610')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Peat soils and heavy clays', false, 0),
      (v_question_id, 'Loam, sandy loam, clay loam, or sandy clay loam', true, 1),
      (v_question_id, 'Saline or alkaline soils', false, 2),
      (v_question_id, 'Sodic soils only', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 611, what is the dam height range that defines a small reservoir irrigation system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 611, what is the dam height range that defines a small reservoir irrigation system?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 611')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 5 m', false, 0),
      (v_question_id, '5 m to 15 m', false, 1),
      (v_question_id, '15 m to 35 m', true, 2),
      (v_question_id, '35 m to 50 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 611, what is the minimum number of boreholes required along the dam axis, and the minimum number of drill holes required for the spillway and diversion outlet, respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 611, what is the minimum number of boreholes required along the dam axis, and the minimum number of drill holes required for the spillway and diversion outlet, respectively?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 611')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 and 3', true, 0),
      (v_question_id, '5 and 5', false, 1),
      (v_question_id, '3 and 5', false, 2),
      (v_question_id, '3 and 3', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 611 Annex B, what increase in seepage flow quantity (not related to rainfall) is considered unusual and must be reported to higher authorities?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 611 Annex B, what increase in seepage flow quantity (not related to rainfall) is considered unusual and must be reported to higher authorities?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 611')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.05 percent', false, 0),
      (v_question_id, '40 percent', false, 1),
      (v_question_id, '20 percent', false, 2),
      (v_question_id, '10 percent', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 611 Annex B, how frequently should total pressure cells and settlement/deflection instrumentation typically be read?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 611 Annex B, how frequently should total pressure cells and settlement/deflection instrumentation typically be read?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 611')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Daily', false, 0),
      (v_question_id, 'During a strong earthquake', false, 1),
      (v_question_id, 'Every six months', true, 2),
      (v_question_id, 'Monthly or weekly', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 611, which term is defined as ''the maximum average contact pressure between the foundation and the soil which should not produce shear failure in the soil''?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 611, which term is defined as ''the maximum average contact pressure between the foundation and the soil which should not produce shear failure in the soil''?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 611')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Design irrigable area', false, 0),
      (v_question_id, 'Permeability test', false, 1),
      (v_question_id, 'Seismicity', false, 2),
      (v_question_id, 'Bearing capacity', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 611 Annex B, which type of dam instrumentation measures internal settlements in an embankment dam and its foundation using horizontally placed cross-arms along a vertical tubing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 611 Annex B, which type of dam instrumentation measures internal settlements in an embankment dam and its foundation using horizontally placed cross-arms along a vertical tubing?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 611')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Seismic instruments', false, 0),
      (v_question_id, 'Total pressure cells', false, 1),
      (v_question_id, 'Piezometers', false, 2),
      (v_question_id, 'Cross-arm settlement devices', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 612, what is the recommended minimum width of a rockfill dam crest?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 612, what is the recommended minimum width of a rockfill dam crest?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 612')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 m', false, 0),
      (v_question_id, '4 m', true, 1),
      (v_question_id, '5 m', false, 2),
      (v_question_id, '2 m to 3 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 612 Table 1, which formula is used by the USBR method to determine dam crest width (W) in terms of dam height (H)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 612 Table 1, which formula is used by the USBR method to determine dam crest width (W) in terms of dam height (H)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 612')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.6 H^(1/3) - 1.5', true, 0),
      (v_question_id, '0.2 H + 1.5', false, 1),
      (v_question_id, '1.1 H^(1/2) + 0.6', false, 2),
      (v_question_id, '3.6 H^(1/3) - 3.0', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 612 Table 2, what is the recommended upstream slope range for a rockfill dam with a central earth-core?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 612 Table 2, what is the recommended upstream slope range for a rockfill dam with a central earth-core?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 612')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1:1.6 to 1:1.7', false, 0),
      (v_question_id, '1:1.3 to 1:1.4', false, 1),
      (v_question_id, '1:1.8 to 1:2', true, 2),
      (v_question_id, '1:2.5 to 1:2.75', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 612 Section 14, what is the acceptable leakage volume for the horizontal drain, expressed as a percentage of the reservoir''s storage capacity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 612 Section 14, what is the acceptable leakage volume for the horizontal drain, expressed as a percentage of the reservoir''s storage capacity?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 612')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.05%', true, 0),
      (v_question_id, '20%', false, 1),
      (v_question_id, '10%', false, 2),
      (v_question_id, '40%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 612, for a sound rock foundation, what is the minimum required depth and width of the cutoff?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 612, for a sound rock foundation, what is the minimum required depth and width of the cutoff?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 612')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 m to 3 m', false, 0),
      (v_question_id, '4 m', false, 1),
      (v_question_id, '0.75 m', false, 2),
      (v_question_id, '1 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 612, which term is defined as ''internal erosion induced by regressive erosion of particles from downstream and along the upstream line towards an outside environment''?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 612, which term is defined as ''internal erosion induced by regressive erosion of particles from downstream and along the upstream line towards an outside environment''?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 612')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Seepage', false, 0),
      (v_question_id, 'Rockfill dam', false, 1),
      (v_question_id, 'Filter zone', false, 2),
      (v_question_id, 'Piping', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 613, what is the height range specified for a diversion dam?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 613, what is the height range specified for a diversion dam?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 613')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 m to 5 m', true, 0),
      (v_question_id, '1.50 m to 4 m', false, 1),
      (v_question_id, '5 m to 10 m', false, 2),
      (v_question_id, '0.50 m to 1 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of diversion dam is specifically suited for rivers or creeks with heavy sediment loads during floods that must be allowed to pass through gate openings, per PAES 613 Table 1?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of diversion dam is specifically suited for rivers or creeks with heavy sediment loads during floods that must be allowed to pass through gate openings, per PAES 613 Table 1?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 613')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Vertical Drop dam', false, 0),
      (v_question_id, 'Ogee dam', false, 1),
      (v_question_id, 'Trapezoidal dam', false, 2),
      (v_question_id, 'Gated dam', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 613 Table 2, what is the allowable maximum flood concentration for a foundation of sand and gravel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 613 Table 2, what is the allowable maximum flood concentration for a foundation of sand and gravel?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 613')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 m3/s/m', false, 0),
      (v_question_id, '5 m3/s/m', false, 1),
      (v_question_id, '15 m3/s/m', true, 2),
      (v_question_id, '10 m3/s/m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 613 Table 3, what is the recommended formula for the length of the downstream apron when the Froude number is less than 4.5 (Type I basin with dentated end sills)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 613 Table 3, what is the recommended formula for the length of the downstream apron when the Froude number is less than 4.5 (Type I basin with dentated end sills)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 613')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'La = 1.5(L - La)', false, 0),
      (v_question_id, 'La = 5(d2 - d1)', true, 1),
      (v_question_id, 'La = 3.5 d2', false, 2),
      (v_question_id, 'La = 4 d2', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum length of riprap protection required downstream of a diversion dam, per PAES 613?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the minimum length of riprap protection required downstream of a diversion dam, per PAES 613?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 613')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 m', false, 0),
      (v_question_id, '1.50 m', false, 1),
      (v_question_id, '0.50 m', false, 2),
      (v_question_id, '10 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the spillway formula Q = CLD^(3/2), what value of coefficient C applies to gabion and cement masonry check dams, per PAES 614?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the spillway formula Q = CLD^(3/2), what value of coefficient C applies to gabion and cement masonry check dams, per PAES 614?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 614')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.6', false, 0),
      (v_question_id, '1.8', true, 1),
      (v_question_id, '0.4', false, 2),
      (v_question_id, '3.0', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 614 Table 1, what is the maximum dam height allowed for a Brushwood check dam?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 614 Table 1, what is the maximum dam height allowed for a Brushwood check dam?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 614')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 m', false, 0),
      (v_question_id, '0.5 m', false, 1),
      (v_question_id, '1.5 m', false, 2),
      (v_question_id, '1 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which formula does PAES 614 specify (the Hoffman formula) for the base thickness of a masonry check dam with a total height of 2 m to 6 m?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which formula does PAES 614 specify (the Hoffman formula) for the base thickness of a masonry check dam with a total height of 2 m to 6 m?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 614')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'k = 0.4H', false, 0),
      (v_question_id, 'd = 0.462H', true, 1),
      (v_question_id, 'k = (1 + 10H)/10', false, 2),
      (v_question_id, 'd = 0.6H', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 614, what is the minimum foundation depth required for the first masonry check dam if it is not built on solid rock?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 614, what is the minimum foundation depth required for the first masonry check dam if it is not built on solid rock?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 614')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.6 m', false, 0),
      (v_question_id, '1 m', true, 1),
      (v_question_id, '0.4 m', false, 2),
      (v_question_id, '0.5 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For 2 m long box gabions in a gabion check dam, per PAES 614, how many parallel ties should be placed between the inner and outer sides once the box is one-third full?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For 2 m long box gabions in a gabion check dam, per PAES 614, how many parallel ties should be placed between the inner and outer sides once the box is one-third full?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 614')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3', false, 0),
      (v_question_id, '5', true, 1),
      (v_question_id, '10', false, 2),
      (v_question_id, '4', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 615, what is the maximum depth generally used to classify a well as a shallow tubewell?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 615, what is the maximum depth generally used to classify a well as a shallow tubewell?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 615')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 3 m', false, 0),
      (v_question_id, 'Less than 4.6 m', false, 1),
      (v_question_id, 'Less than 15 m', true, 2),
      (v_question_id, 'Less than 9 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 615 Table 3, which design discharge requires a pipe diameter of 100 mm (4 in) as the sole recommended size in a rice-based cropping system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 615 Table 3, which design discharge requires a pipe diameter of 100 mm (4 in) as the sole recommended size in a rice-based cropping system?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 615')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '>7.6 lps', true, 0),
      (v_question_id, '<3.8 lps', false, 1),
      (v_question_id, '3.8 lps', false, 2),
      (v_question_id, '7.6 lps', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of well requires Schedule 40 GI pipe material, per PAES 615 Table 4?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of well requires Schedule 40 GI pipe material, per PAES 615 Table 4?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 615')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Naturally developed with a relatively soft confining layer', false, 0),
      (v_question_id, 'Naturally developed with a hard confining layer', true, 1),
      (v_question_id, 'Naturally developed with design depth of <= 9 m (30 ft)', false, 2),
      (v_question_id, 'Artificially developed', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What pump efficiency is assumed in the brake horsepower formula (BHP = TDH x Qd / (102 x Ep)), per PAES 615?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What pump efficiency is assumed in the brake horsepower formula (BHP = TDH x Qd / (102 x Ep)), per PAES 615?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 615')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100%', false, 0),
      (v_question_id, '55%', true, 1),
      (v_question_id, '50%', false, 2),
      (v_question_id, '15%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 615 Annex A, what is the minimum aquifer thickness for it to be considered a good confined aquifer during well logging?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 615 Annex A, what is the minimum aquifer thickness for it to be considered a good confined aquifer during well logging?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 615')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15 m', false, 0),
      (v_question_id, '9 m', false, 1),
      (v_question_id, '4.6 m', false, 2),
      (v_question_id, '3 m (10 ft)', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 616 Table 1, what is the maximum allowable pH for treated wastewater used in irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 616 Table 1, what is the maximum allowable pH for treated wastewater used in irrigation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 616')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8.0', true, 0),
      (v_question_id, '4.0', false, 1),
      (v_question_id, '8.5', false, 2),
      (v_question_id, '5.5', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 616 Table 1, what is the maximum limit for Biochemical Oxygen Demand (BOD5) in treated wastewater used for irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 616 Table 1, what is the maximum limit for Biochemical Oxygen Demand (BOD5) in treated wastewater used for irrigation?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 616')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '140 mg/L', false, 0),
      (v_question_id, '150 mg/L', true, 1),
      (v_question_id, '30 mg/L', false, 2),
      (v_question_id, '500 mg/L', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 616 Table 2, what is the maximum concentration limit for Mercury as a trace element in irrigation water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 616 Table 2, what is the maximum concentration limit for Mercury as a trace element in irrigation water?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 616')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.01 mg/L', false, 0),
      (v_question_id, '0.75 mg/L', false, 1),
      (v_question_id, '0.10 mg/L', false, 2),
      (v_question_id, '0.002 mg/L', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 616 Table 4, what is the required setback distance from potable water supply wells when irrigating food crops eaten raw and not commercially processed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 616 Table 4, what is the required setback distance from potable water supply wells when irrigating food crops eaten raw and not commercially processed?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 616')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 m', false, 0),
      (v_question_id, '25 m', true, 1),
      (v_question_id, '30 m', false, 2),
      (v_question_id, '90 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 616 Table 3, what is the intake rate range for silty clay soil when irrigating with re-used wastewater?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 616 Table 3, what is the intake rate range for silty clay soil when irrigating with re-used wastewater?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL, true, 'PAES 616')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.01 - 0.8 cm/h', false, 0),
      (v_question_id, '2.0 - 6.0 cm/h', false, 1),
      (v_question_id, '0.8 - 2.0 cm/h', true, 2),
      (v_question_id, '6.0 - 12.0 cm/h', false, 3);
  END IF;
END $$;
