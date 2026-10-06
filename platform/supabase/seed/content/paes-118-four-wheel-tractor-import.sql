-- PAES 118:2001 "Agricultural Machinery — Four-Wheel Tractor — Specifications"
-- quiz batch (25 questions, 1 topic). Every question, correct answer, and
-- distractor is drawn directly from the standard's actual clauses (read in
-- full from "ABELE TOP 1/PAES/PRODUCTION (100 S)/Four-Wheel Tractor
-- Specifications.pdf", 2026-10-02) — no invented facts. This topic had zero
-- published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes=true with paes_reference
-- set to 'PAES 118'.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Four-Wheel Tractors Methods of Test (POWER_ENERGY_MACHINERY) — 25 question(s)
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

  -- 1. Scope / net power range (clause 1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001, the standard for four-wheel tractor specifications is applicable to two-wheel drive and four-wheel drive tractors within what net power range?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001, the standard for four-wheel tractor specifications is applicable to two-wheel drive and four-wheel drive tractors within what net power range?', 'single_choice', 'medium', 'Clause 1 (Scope): PAES 118:2001 is applicable to two-wheel drive and four-wheel drive tractors with a net power range of 4 kW to 400 kW.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 kW to 100 kW', false, 0),
      (v_question_id, '4 kW to 400 kW', true, 1),
      (v_question_id, '10 kW to 500 kW', false, 2),
      (v_question_id, '15 kW to 300 kW', false, 3);
  END IF;

  -- 2. Drawbar definition (clause 3.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.1, how is a "drawbar" defined?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.1, how is a "drawbar" defined?', 'single_choice', 'easy', 'Clause 3.1: a drawbar is the bar at the rear of a tractor to which implements are hitched.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The bar at the rear of a tractor to which implements are hitched', true, 0),
      (v_question_id, 'The shaft that transmits rotational power to implements', false, 1),
      (v_question_id, 'The frame supporting the operator''s seat', false, 2),
      (v_question_id, 'The bar connecting the front axle to the steering column', false, 3);
  END IF;

  -- 3. Four-wheel drive vs two-wheel drive (clause 3.3.1 / 3.3.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.3.2, a "two-wheel drive" four-wheel tractor is one where:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.3.2, a "two-wheel drive" four-wheel tractor is one where:', 'single_choice', 'medium', 'Clause 3.3.2: two-wheel drive is the type of four-wheel tractor where power is transmitted to the rear wheels, with the small front wheels being pushed along. (Clause 3.3.1: four-wheel drive transmits power to all wheels.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Power is transmitted to all wheels', false, 0),
      (v_question_id, 'Power is transmitted to rear wheels, with small front wheels being pushed along', true, 1),
      (v_question_id, 'Power is transmitted to front wheels only', false, 2),
      (v_question_id, 'Power alternates between front and rear wheels automatically', false, 3);
  END IF;

  -- 4. ROPS definition (clause 3.9)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.9, a roll-over protective structure (ROPS) is primarily used to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.9, a roll-over protective structure (ROPS) is primarily used to:', 'single_choice', 'easy', 'Clause 3.9: ROPS (also called a roll-over protective device or safety frame) is a two- or four-post structural frame primarily used to protect a seat-belted operator from being crushed in case the machine rolls over.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Protect a seat-belted operator from being crushed if the machine rolls over', true, 0),
      (v_question_id, 'Shield the operator from engine exhaust fumes', false, 1),
      (v_question_id, 'Improve the tractor''s fuel efficiency', false, 2),
      (v_question_id, 'Increase the tractor''s drawbar power rating', false, 3);
  END IF;

  -- 5. Three-point linkage definition (clause 3.10)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.10, a "three-point linkage" is defined as a combination of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.10, a "three-point linkage" is defined as a combination of:', 'single_choice', 'medium', 'Clause 3.10: a three-point linkage is a combination of one upper link and two lower links, each articulated to the tractor and the implement at opposite ends, in order to connect the implement to the tractor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One upper link and two lower links', true, 0),
      (v_question_id, 'Two upper links and one lower link', false, 1),
      (v_question_id, 'Three equal lower links', false, 2),
      (v_question_id, 'One drawbar and two stabilizer chains', false, 3);
  END IF;

  -- 6. Three-point linkage category by drawbar power (Table 1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 1 of PAES 118:2001 (Three-point Linkage Categories), which category covers a maximum drawbar power range of 60-168 kW?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 1 of PAES 118:2001 (Three-point Linkage Categories), which category covers a maximum drawbar power range of 60-168 kW?', 'single_choice', 'hard', 'Table 1: Category 1 covers 15-35 kW, Category 2 covers 30-75 kW, Category 3 covers 60-168 kW, and Category 4 covers 135-300 kW.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Category 1', false, 0),
      (v_question_id, 'Category 2', false, 1),
      (v_question_id, 'Category 3', true, 2),
      (v_question_id, 'Category 4', false, 3);
  END IF;

  -- 7. Drawbar hole diameter (clause 5.4.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.4.2, the diameter of the hole in a four-wheel tractor''s clevis-type drawbar should be approximately:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.4.2, the diameter of the hole in a four-wheel tractor''s clevis-type drawbar should be approximately:', 'single_choice', 'hard', 'Clause 5.4.2: the drawbar shall be situated in the longitudinal mid-plane of the tractor; the diameter of the hole in the drawbar should be 33 mm, and the thickness of the drawbar shall be not more than 32 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 mm', false, 0),
      (v_question_id, '33 mm', true, 1),
      (v_question_id, '40 mm', false, 2),
      (v_question_id, '45 mm', false, 3);
  END IF;

  -- 8. PTO Type 1 characteristics (Table 3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 3 of PAES 118:2001 (Characteristics of PTO Types), PTO Type 1 has a nominal diameter of 35 mm, 6 straight splines, and a rated speed of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 3 of PAES 118:2001 (Characteristics of PTO Types), PTO Type 1 has a nominal diameter of 35 mm, 6 straight splines, and a rated speed of:', 'single_choice', 'hard', 'Table 3: PTO Type 1 is 35 mm nominal diameter, 6 straight splines, rated at 540 rpm. Type 2 is 35 mm, 21 involute splines, 1000 rpm. Type 3 is 45 mm, 20 involute splines, 1000 rpm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '540 rpm', true, 0),
      (v_question_id, '750 rpm', false, 1),
      (v_question_id, '1000 rpm', false, 2),
      (v_question_id, '1200 rpm', false, 3);
  END IF;

  -- 9. PTO Type 3 nominal diameter (Table 3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 3 of PAES 118:2001, PTO Type 3 (20 involute splines, 1000 rpm) has a nominal diameter of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 3 of PAES 118:2001, PTO Type 3 (20 involute splines, 1000 rpm) has a nominal diameter of:', 'single_choice', 'hard', 'Table 3: PTO Type 3 has a nominal diameter of 45 mm, with 20 involute splines rated at 1000 rpm — distinct from Type 2, which is 35 mm with 21 involute splines also at 1000 rpm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35 mm', false, 0),
      (v_question_id, '40 mm', false, 1),
      (v_question_id, '45 mm', true, 2),
      (v_question_id, '50 mm', false, 3);
  END IF;

  -- 10. Allowable wheel slip, four-wheel drive firm soil (Table 4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 4 of PAES 118:2001 (Acceptable Level of Wheel Slip), what is the allowable wheel slip range for a four-wheel drive tractor on firm soil?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 4 of PAES 118:2001 (Acceptable Level of Wheel Slip), what is the allowable wheel slip range for a four-wheel drive tractor on firm soil?', 'single_choice', 'hard', 'Table 4: on firm soil, two-wheel drive allows 7-11% slip and four-wheel drive allows 6-10%; on tilled/soft soil, two-wheel drive allows 10-15% and four-wheel drive allows 8-13%.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6% - 10%', true, 0),
      (v_question_id, '7% - 11%', false, 1),
      (v_question_id, '8% - 13%', false, 2),
      (v_question_id, '10% - 15%', false, 3);
  END IF;

  -- 11. Tractor speed during field operations (clause 6.4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 6.4, the tractor shall be able to pull field implements up to what speed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 6.4, the tractor shall be able to pull field implements up to what speed?', 'single_choice', 'easy', 'Clause 6.4 (Tractor speed during field operations): the tractor shall be able to pull field implements up to 8 km/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 km/h', false, 0),
      (v_question_id, '8 km/h', true, 1),
      (v_question_id, '12 km/h', false, 2),
      (v_question_id, '15 km/h', false, 3);
  END IF;

  -- 12. Drawbar power / field performance test standard (clause 6.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 6.1, drawbar power and field performance of the four-wheel tractor shall be tested in accordance with which standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 6.1, drawbar power and field performance of the four-wheel tractor shall be tested in accordance with which standard?', 'single_choice', 'medium', 'Clause 6.1: drawbar power and field performance shall be tested in accordance with PAES 119 — Agricultural Machinery, Four-Wheel Tractor, Methods of Test.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PAES 102', false, 0),
      (v_question_id, 'PAES 104', false, 1),
      (v_question_id, 'PAES 119', true, 2),
      (v_question_id, 'ISO 730-1', false, 3);
  END IF;

  -- 13. Hydraulic lift force measurement distance (clause 6.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 6.3, the minimum hydraulic lift force capacity (Table 5) is specified at what distance beyond the lower hitch points?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 6.3, the minimum hydraulic lift force capacity (Table 5) is specified at what distance beyond the lower hitch points?', 'single_choice', 'hard', 'Clause 6.3: the tractor equipped with three-point linkage shall have the minimum hydraulic lift force capacity available throughout the power range, at a distance of 610 mm beyond the lower hitch points (without external assist hydraulic cylinders).', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '305 mm', false, 0),
      (v_question_id, '457 mm', false, 1),
      (v_question_id, '610 mm', true, 2),
      (v_question_id, '850 mm', false, 3);
  END IF;

  -- 14. Lift force per drawbar power, ≤65 kW (Table 5)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 5 of PAES 118:2001 (Hydraulic Lift Force Capacity), for a maximum drawbar power of 65 kW and below, what is the lift force per drawbar power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 5 of PAES 118:2001 (Hydraulic Lift Force Capacity), for a maximum drawbar power of 65 kW and below, what is the lift force per drawbar power?', 'single_choice', 'hard', 'Table 5: for 65 kW and below, the lift force per drawbar power is 0.31 kN/kW; above 65 kW, it is 20.15 plus 0.155 kN/kW for the succeeding drawbar power.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.15 kN/kW', false, 0),
      (v_question_id, '0.31 kN/kW', true, 1),
      (v_question_id, '0.55 kN/kW', false, 2),
      (v_question_id, '1.0 kN/kW', false, 3);
  END IF;

  -- 15. Planetary gear components (clause 5.5.2.4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.5.2.4, which transmission gear type is composed of a sun gear, planetary gears, a carrier, and a ring gear?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.5.2.4, which transmission gear type is composed of a sun gear, planetary gears, a carrier, and a ring gear?', 'single_choice', 'medium', 'Clause 5.5.2.4: planetary gears are composed of a sun gear fixed on the driving shaft, planetary gears meshed with it, a carrier that supports them, and a ring gear with an internal-mesh brake for locking.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sliding mesh gears', false, 0),
      (v_question_id, 'Constant mesh gears', false, 1),
      (v_question_id, 'Synchronous mesh gears', false, 2),
      (v_question_id, 'Planetary gears', true, 3);
  END IF;

  -- 16. Dual clutch, first stage (clause 5.5.1.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.5.1.2, in a dual clutch, the FIRST stage of stepping on the clutch pedal:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.5.1.2, in a dual clutch, the FIRST stage of stepping on the clutch pedal:', 'single_choice', 'hard', 'Clause 5.5.1.2: the first stage of stepping on the clutch pedal disengages the main clutch while the PTO clutch remains engaged. The second, deeper stage disengages both the main clutch and the PTO clutch.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Disengages the main clutch while the PTO clutch stays engaged', true, 0),
      (v_question_id, 'Disengages the PTO clutch while the main clutch stays engaged', false, 1),
      (v_question_id, 'Disengages both the main clutch and the PTO clutch at once', false, 2),
      (v_question_id, 'Has no effect until fully depressed', false, 3);
  END IF;

  -- 17. Differential lock purpose (clause 5.5.4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.5.4, what is the purpose of the differential lock?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.5.4, what is the purpose of the differential lock?', 'single_choice', 'medium', 'Clause 5.5.4: the differential lock applies a restraining force to the differential gears in case one of the wheels goes into an idle spin, so that the differential yoke shafts are rotated together as one unit.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To restrain the differential gears so the yoke shafts rotate as one unit when a wheel spins idly', true, 0),
      (v_question_id, 'To increase the tractor''s top speed on paved roads', false, 1),
      (v_question_id, 'To reduce fuel consumption during idling', false, 2),
      (v_question_id, 'To automatically shift gears without clutching', false, 3);
  END IF;

  -- 18. Brake classification by force application (clause 5.7.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.7.1, brake systems classified by manner of applying braking force are of how many types?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.7.1, brake systems classified by manner of applying braking force are of how many types?', 'single_choice', 'medium', 'Clause 5.7.1: three types by manner of applying braking force — internal expansion type (5.7.1.1), external contraction type (5.7.1.2), and disc type (5.7.1.3).', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two', false, 0),
      (v_question_id, 'Three', true, 1),
      (v_question_id, 'Four', false, 2),
      (v_question_id, 'Five', false, 3);
  END IF;

  -- 19. Brake classification by force transmission (clause 5.7.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.7.2, brake systems classified by the manner of transmitting force from the control are of what two types?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.7.2, brake systems classified by the manner of transmitting force from the control are of what two types?', 'single_choice', 'medium', 'Clause 5.7.2: mechanical brake (5.7.2.1 — brake rod/lever rotates the brake cam) and hydraulic brake (5.7.2.2 — stepping force converted to hydraulic force by a master cylinder, transmitted to the wheel cylinder).', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mechanical and hydraulic', true, 0),
      (v_question_id, 'Pneumatic and electric', false, 1),
      (v_question_id, 'Internal expansion and external contraction', false, 2),
      (v_question_id, 'Disc and drum', false, 3);
  END IF;

  -- 20. Construction materials (clause 5.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.1, the four-wheel tractor shall generally be made of what materials?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.1, the four-wheel tractor shall generally be made of what materials?', 'single_choice', 'easy', 'Clause 5.1 (Materials): the tractor shall be generally made of cast iron and steel materials.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cast iron and steel', true, 0),
      (v_question_id, 'Aluminum and fiberglass', false, 1),
      (v_question_id, 'Reinforced plastic composites', false, 2),
      (v_question_id, 'Stainless steel only', false, 3);
  END IF;

  -- 21. PTO safety requirement (clause 7.7.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 7.7.1 (Safety Requirements), when the PTO is NOT in use, what shall be provided?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 7.7.1 (Safety Requirements), when the PTO is NOT in use, what shall be provided?', 'single_choice', 'medium', 'Clause 7.7.1: when the PTO is in use, a cover or casing protecting its sides shall be fitted; an additional non-rotating casing shall also be provided when the PTO is not in use, enclosing the PTO shaft completely and fixed to the tractor body.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An additional non-rotating casing enclosing the PTO shaft completely, fixed to the tractor body', true, 0),
      (v_question_id, 'A padlock on the PTO shift lever only', false, 1),
      (v_question_id, 'No additional protection, since the PTO is idle', false, 2),
      (v_question_id, 'A warning horn that sounds continuously', false, 3);
  END IF;

  -- 22. Wheel tread definition (clause 3.11)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.11, "wheel tread" is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.11, "wheel tread" is defined as:', 'single_choice', 'easy', 'Clause 3.11: wheel tread is the center-to-center distance between two front or rear wheels.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The center-to-center distance between two front or rear wheels', true, 0),
      (v_question_id, 'The depth of the tire tread pattern', false, 1),
      (v_question_id, 'The distance from the front axle to the rear axle', false, 2),
      (v_question_id, 'The diameter of a single wheel', false, 3);
  END IF;

  -- 23. Sliding mesh gears mechanism (clause 5.5.2.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 5.5.2.1, how do sliding mesh transmission gears engage different gear ratios?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 5.5.2.1, how do sliding mesh transmission gears engage different gear ratios?', 'single_choice', 'medium', 'Clause 5.5.2.1 (Sliding mesh gears): gears on the main shaft are meshed with the other gears on the counter shaft selectively, by sliding them along the splined part of the gear.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'By sliding gears along the splined part of the main shaft to mesh selectively with counter-shaft gears', true, 0),
      (v_question_id, 'By using a hydrostatic pump and motor with no mechanical gears', false, 1),
      (v_question_id, 'By engaging a cone clutch between hub and mating gears', false, 2),
      (v_question_id, 'By locking a ring gear while a sun gear is driven', false, 3);
  END IF;

  -- 24. Four-wheel tractor definition (clause 3.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.3, a "four-wheel tractor" is defined as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.3, a "four-wheel tractor" is defined as a:', 'single_choice', 'easy', 'Clause 3.3: a four-wheel tractor is a self-propelled, wheeled vehicle having two axles, designed to carry, pull, or propel agricultural implements and machines.', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Self-propelled, wheeled vehicle with two axles, designed to carry, pull, or propel agricultural implements and machines', true, 0),
      (v_question_id, 'Any towed implement with four wheels', false, 1),
      (v_question_id, 'A stationary power unit used to drive belt-connected equipment', false, 2),
      (v_question_id, 'A tracked vehicle used for plowing', false, 3);
  END IF;

  -- 25. Hitch point definition (clause 3.10.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 118:2001 clause 3.10.1, a "hitch point" in a three-point linkage is defined as the articulated connection between:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 118:2001 clause 3.10.1, a "hitch point" in a three-point linkage is defined as the articulated connection between:', 'single_choice', 'medium', 'Clause 3.10.1: hitch point is the articulated connection between a link and the implement. (Clause 3.10.3, by contrast, defines "link point" as the articulated connection between a link and the tractor.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 118')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A link and the implement', true, 0),
      (v_question_id, 'A link and the tractor', false, 1),
      (v_question_id, 'The drawbar and the hitch hook', false, 2),
      (v_question_id, 'The PTO shaft and the gearbox', false, 3);
  END IF;

END $$;
