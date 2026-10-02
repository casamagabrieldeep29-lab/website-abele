-- Surveying quiz batch (10 questions, 1 topic). Every definition, formula,
-- and historical fact is drawn directly from a surveying review document
-- read in full from "ABELE TOP 1/ATTRC/Area 2/SURVEYING/
-- REVIEW-ON-SURVEYING.pdf" (2026-10-02) — no invented facts. This topic had
-- zero published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since this is general surveying review material, not a PAES standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Surveying (LAND_WATER) — 10 question(s)
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

  -- 1. Plane surveying definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the classification of surveying, "plane surveying" is defined as a type of surveying where:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the classification of surveying, "plane surveying" is defined as a type of surveying where:', 'single_choice', 'easy', 'Plane surveying is a type of surveying where the earth is considered as a flat surface, and where the distances and areas involved are of limited extent.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The earth is considered as a flat surface, for distances and areas of limited extent', true, 0),
      (v_question_id, 'The spheroidal shape of the earth is taken into account', false, 1),
      (v_question_id, 'Only underground excavations are measured', false, 2),
      (v_question_id, 'Only photographs taken from airplanes are used', false, 3);
  END IF;

  -- 2. Geodetic surveying definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of surveying is of wide extent and takes into account the spheroidal shape of the earth?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of surveying is of wide extent and takes into account the spheroidal shape of the earth?', 'single_choice', 'easy', 'Geodetic surveying covers surveys of wide extent which take into account the spheroidal shape of the earth, in contrast to plane surveying, which treats the earth as flat.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Plane surveying', false, 0),
      (v_question_id, 'Geodetic surveying', true, 1),
      (v_question_id, 'Cadastral surveying', false, 2),
      (v_question_id, 'City surveying', false, 3);
  END IF;

  -- 3. Route surveys definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of survey covers the determination of alignment, grades, earthwork quantities, and location of natural and artificial objects in connection with the planning, design, and construction of highways, railroads, pipelines, canals, and transmission lines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of survey covers the determination of alignment, grades, earthwork quantities, and location of natural and artificial objects in connection with the planning, design, and construction of highways, railroads, pipelines, canals, and transmission lines?', 'single_choice', 'medium', 'Route surveys determine alignment, grades, earthwork quantities, and location of natural and artificial objects in connection with the planning, design, and construction of highways, railroads, pipelines, canals, transmission lines, and other linear projects.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Route surveys', true, 0),
      (v_question_id, 'Hydrographic surveys', false, 1),
      (v_question_id, 'Mine surveys', false, 2),
      (v_question_id, 'Topographic surveys', false, 3);
  END IF;

  -- 4. Gunter's chain specs
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Gunter''s chain, invented by Sir Edmund Gunter in 1620 and used for taping distances, is how long and contains how many links?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Gunter''s chain, invented by Sir Edmund Gunter in 1620 and used for taping distances, is how long and contains how many links?', 'single_choice', 'medium', 'Gunter''s chain is 66 ft long and contains 100 links.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 ft long, 50 links', false, 0),
      (v_question_id, '66 ft long, 100 links', true, 1),
      (v_question_id, '100 ft long, 100 links', false, 2),
      (v_question_id, '30 ft long, 66 links', false, 3);
  END IF;

  -- 5. Error vs mistake/blunder distinction
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In surveying, an inaccuracy in measurement that occurs because the surveyor was careless, inattentive, or used poor judgment is classified as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In surveying, an inaccuracy in measurement that occurs because the surveyor was careless, inattentive, or used poor judgment is classified as a:', 'single_choice', 'medium', 'Mistakes are inaccuracies in measurements which occur because some aspect of a surveying operation is performed by the surveyor with carelessness, inattention, poor judgment, and improper execution. A large mistake is called a blunder, and mistakes are not classified as errors.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Systematic error', false, 0),
      (v_question_id, 'Mistake', true, 1),
      (v_question_id, 'Accidental error', false, 2),
      (v_question_id, 'Instrumental error', false, 3);
  END IF;

  -- 6. Most Probable Value formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Most Probable Value (MPV) of a series of repeated measurements of the same quantity is computed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Most Probable Value (MPV) of a series of repeated measurements of the same quantity is computed as:', 'single_choice', 'medium', 'MPV = X̄ = ΣX / n = (X₁ + X₂ + X₃ + ... + Xₙ) / n — the arithmetic mean of the observations, which refers to the quantity that, based on available data, has more chance of being correct than any other.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The sum of all observations divided by the number of observations (the arithmetic mean)', true, 0),
      (v_question_id, 'The largest of all observations', false, 1),
      (v_question_id, 'The difference between the largest and smallest observations', false, 2),
      (v_question_id, 'The square root of the sum of the observations', false, 3);
  END IF;

  -- 7. Stadia method formula and inventor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The stadia method of measuring horizontal distances, introduced by James Watt in 1771, computes distance using the formula D = Ks + C, where s represents:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The stadia method of measuring horizontal distances, introduced by James Watt in 1771, computes distance using the formula D = Ks + C, where s represents:', 'single_choice', 'hard', 'In D = Ks + C, K is the stadia interval factor of the instrument, s is the difference between the upper and lower stadia hair readings, and C is the distance from the center of the instrument to the principal focus (instrument constant). The stadia method has a relative precision of 1/300 to 1/1000.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The difference between the upper and lower stadia hair readings', true, 0),
      (v_question_id, 'The angle subtended by the subtense bar', false, 1),
      (v_question_id, 'The horizontal distance already measured', false, 2),
      (v_question_id, 'The length of the subtense bar', false, 3);
  END IF;

  -- 8. Invar tape composition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An invar tape, used for precise measurements because of its very low coefficient of thermal expansion, is made of an alloy of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An invar tape, used for precise measurements because of its very low coefficient of thermal expansion, is made of an alloy of:', 'single_choice', 'medium', 'An invar tape is made of an alloy of nickel (35%) and steel (65%), with a coefficient of thermal expansion only 1/30 to 1/60 that of an ordinary steel tape, making it less affected by temperature changes ("invariable").', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Nickel (35%) and steel (65%)', true, 0),
      (v_question_id, 'Copper (50%) and bronze (50%)', false, 1),
      (v_question_id, 'Pure steel only', false, 2),
      (v_question_id, 'Fiberglass and synthetic fiber', false, 3);
  END IF;

  -- 9. Transit inventor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The transit, described as the universal surveying instrument, was invented in 1830 by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The transit, described as the universal surveying instrument, was invented in 1830 by:', 'single_choice', 'medium', 'The transit, the universal surveying instrument, was invented by Young and Draper in 1830.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Young and Draper', true, 0),
      (v_question_id, 'Hipparchus', false, 1),
      (v_question_id, 'Lippershey', false, 2),
      (v_question_id, 'Pierre Vernier', false, 3);
  END IF;

  -- 10. Temperature correction coefficient for steel tapes
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the formula for correction due to temperature, CT = αL(T - To), what is the standard coefficient of linear expansion (α) used for steel tapes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the formula for correction due to temperature, CT = αL(T - To), what is the standard coefficient of linear expansion (α) used for steel tapes?', 'single_choice', 'hard', 'For steel tapes, the standard coefficient of linear expansion per degree change in temperature is α = 0.0000116 per °C.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0000116 per °C', true, 0),
      (v_question_id, '0.000116 per °C', false, 1),
      (v_question_id, '0.00116 per °C', false, 2),
      (v_question_id, '0.116 per °C', false, 3);
  END IF;

END $$;
