-- PAES 114:2000 "Agricultural Machinery — Centrifugal Pump — Specifications"
-- quiz batch (25 questions, 1 topic). Every question, correct answer, and
-- distractor is drawn directly from the standard's actual clauses (read in
-- full from "ABELE TOP 1/PAES/PRODUCTION (100 S)/Centrifugal Pump
-- Specifications.pdf", 2026-10-02) — no invented facts. This topic had zero
-- published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes=true with paes_reference
-- set to 'PAES 114'.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Pumps (LAND_WATER) — 25 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Pumps' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Pumps';
  END IF;

  -- 1. Scope (clause 1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 1 (Scope), this standard specifies the requirements for construction and performance of which pump type used in agriculture?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 1 (Scope), this standard specifies the requirements for construction and performance of which pump type used in agriculture?', 'single_choice', 'easy', 'Clause 1 (Scope): PAES 114:2000 specifies the requirements for construction and performance of the centrifugal pump used in agriculture.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reciprocating pump', false, 0),
      (v_question_id, 'Centrifugal pump', true, 1),
      (v_question_id, 'Hand pump', false, 2),
      (v_question_id, 'Wind pump', false, 3);
  END IF;

  -- 2. Capacity definition (clause 3.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.1, "capacity" of a centrifugal pump is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.1, "capacity" of a centrifugal pump is defined as:', 'single_choice', 'easy', 'Clause 3.1: capacity is defined as discharge at maximum efficiency.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Discharge at maximum efficiency', true, 0),
      (v_question_id, 'Total head at zero flow', false, 1),
      (v_question_id, 'The volume of the pump casing', false, 2),
      (v_question_id, 'The rated shaft speed in rpm', false, 3);
  END IF;

  -- 3. Centrifugal pump definition (clause 3.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.2, a "centrifugal pump" draws water in through a central inlet opening and forces it out through a discharge outlet at the periphery of the housing by means of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.2, a "centrifugal pump" draws water in through a central inlet opening and forces it out through a discharge outlet at the periphery of the housing by means of:', 'single_choice', 'easy', 'Clause 3.2: a centrifugal pump has impellers rotating inside a closed casing, drawing water in through a central inlet and forcing it out at the periphery of the housing by means of centrifugal force.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Centrifugal force', true, 0),
      (v_question_id, 'Atmospheric suction alone', false, 1),
      (v_question_id, 'A reciprocating piston', false, 2),
      (v_question_id, 'Gravity flow', false, 3);
  END IF;

  -- 4. Diffuser/turbine pump (clause 3.2.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.2.1, a "diffuser pump" (also called a turbine pump) is a type of centrifugal pump wherein:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.2.1, a "diffuser pump" (also called a turbine pump) is a type of centrifugal pump wherein:', 'single_choice', 'medium', 'Clause 3.2.1: a diffuser pump (turbine pump) is a type of centrifugal pump wherein the impeller is surrounded by diffuser vanes, which have small openings near the impeller and enlarge gradually to their outer diameter.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The impeller is surrounded by diffuser vanes', true, 0),
      (v_question_id, 'The casing is shaped as a spiral or volute curve', false, 1),
      (v_question_id, 'The impeller has suction cavities on both sides', false, 2),
      (v_question_id, 'The shaft is mounted vertically', false, 3);
  END IF;

  -- 5. Volute pump (clause 3.2.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.2.2, a "volute pump" has a casing proportioned to reduce gradually the velocity of water as it flows from the impeller to the discharge, which has the effect of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.2.2, a "volute pump" has a casing proportioned to reduce gradually the velocity of water as it flows from the impeller to the discharge, which has the effect of:', 'single_choice', 'medium', 'Clause 3.2.2: a volute pump has a casing in the form of a spiral or volute curve, proportioned to reduce gradually the velocity of water as it flows from the impeller to the discharge, thus changing velocity head to pressure head.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Changing velocity head to pressure head', true, 0),
      (v_question_id, 'Increasing the rated shaft speed', false, 1),
      (v_question_id, 'Preventing cavitation at the suction inlet', false, 2),
      (v_question_id, 'Eliminating the need for priming', false, 3);
  END IF;

  -- 6. Head definition (clause 3.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.3, "head" is defined as the quantity used to express:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.3, "head" is defined as the quantity used to express:', 'single_choice', 'medium', 'Clause 3.3: head is the quantity used to express a form (or combination of forms) of the energy content of the liquid per unit weight of the liquid, referred to any arbitrary datum.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A form of the energy content of the liquid per unit weight, referred to an arbitrary datum', true, 0),
      (v_question_id, 'The volume flow rate of the pump at rated speed', false, 1),
      (v_question_id, 'The ratio of power output to power input', false, 2),
      (v_question_id, 'The minimum suction pressure needed to avoid cavitation', false, 3);
  END IF;

  -- 7. NPSHR definition (clause 3.4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.4, "net positive suction head required" (NPSHR) is the statement of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.4, "net positive suction head required" (NPSHR) is the statement of:', 'single_choice', 'medium', 'Clause 3.4: NPSHR is a performance characteristic required of the pump — the NPSH at the pump inlet. The note clarifies it is the statement of the minimum suction conditions required to prevent cavitation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The minimum suction conditions required to prevent cavitation', true, 0),
      (v_question_id, 'The maximum discharge pressure the casing can withstand', false, 1),
      (v_question_id, 'The rated power of the prime mover', false, 2),
      (v_question_id, 'The warranty period of the pump', false, 3);
  END IF;

  -- 8. Pump efficiency definition (clause 3.6)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.6, "pump efficiency" (ηp) is defined as the ratio of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.6, "pump efficiency" (ηp) is defined as the ratio of:', 'single_choice', 'easy', 'Clause 3.6: pump efficiency (ηp) is the ratio of the power output to the power input of the pump.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Power output to power input of the pump', true, 0),
      (v_question_id, 'Capacity to total head', false, 1),
      (v_question_id, 'Shaft speed to rated speed', false, 2),
      (v_question_id, 'Suction head to discharge head', false, 3);
  END IF;

  -- 9. Priming definition (clause 3.7)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 3.7, "priming" is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 3.7, "priming" is defined as:', 'single_choice', 'medium', 'Clause 3.7: priming is filling up the pump with water to displace or evacuate the entrapped air through a vent and create a liquid seal inside the casing.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Filling up the pump with water to displace entrapped air and create a liquid seal inside the casing', true, 0),
      (v_question_id, 'Lubricating the bearing housing before first use', false, 1),
      (v_question_id, 'Balancing the rotating components dynamically', false, 2),
      (v_question_id, 'Testing the pump against its rated performance curve', false, 3);
  END IF;

  -- 10. Shaft power vs water power (clause 3.8 / 3.9)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clauses 3.8 and 3.9, which term refers to the actual input power required to drive the pump shaft, as distinguished from the theoretical power required for pumping?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clauses 3.8 and 3.9, which term refers to the actual input power required to drive the pump shaft, as distinguished from the theoretical power required for pumping?', 'single_choice', 'medium', 'Clause 3.8: shaft power is the power required to drive the pump shaft — the input power to the pump. Clause 3.9: water power is the theoretical power required for pumping (head and capacity expressed in kilowatt).', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shaft power', true, 0),
      (v_question_id, 'Water power', false, 1),
      (v_question_id, 'Capacity', false, 2),
      (v_question_id, 'NPSHR', false, 3);
  END IF;

  -- 11. Open impeller use (clause 4.2.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 4.2.1, an "open" type impeller is used to pump water:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 4.2.1, an "open" type impeller is used to pump water:', 'single_choice', 'medium', 'Clause 4.2.1: an open impeller is used to pump water with considerable amount of small solids.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'With considerable amount of small solids', true, 0),
      (v_question_id, 'That is perfectly clear only', false, 1),
      (v_question_id, 'Having some suspended sediments only', false, 2),
      (v_question_id, 'At very high discharge pressure only', false, 3);
  END IF;

  -- 12. Semi-open impeller use (clause 4.2.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 4.2.2, a "semi-open" or "semi-enclosed" impeller is used to pump water:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 4.2.2, a "semi-open" or "semi-enclosed" impeller is used to pump water:', 'single_choice', 'medium', 'Clause 4.2.2: a semi-open or semi-enclosed impeller is used to pump water having some amount of suspended sediments (clause 4.2.3: an enclosed impeller is designed to pump clear water).', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Having some amount of suspended sediments', true, 0),
      (v_question_id, 'That is completely clear, with no sediments at all', false, 1),
      (v_question_id, 'With considerable amounts of small solids', false, 2),
      (v_question_id, 'Only at low shaft speeds', false, 3);
  END IF;

  -- 13. Double suction impeller (clause 4.3.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 4.3.2, a "double suction" type of pump has an impeller with:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 4.3.2, a "double suction" type of pump has an impeller with:', 'single_choice', 'easy', 'Clause 4.3.2: a double suction type of pump has an impeller which has suction cavity on both sides (clause 4.3.1: single suction has suction cavity on one side only).', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Suction cavity on both sides', true, 0),
      (v_question_id, 'Suction cavity on one side only', false, 1),
      (v_question_id, 'No suction cavity at all', false, 2),
      (v_question_id, 'Two separate discharge outlets', false, 3);
  END IF;

  -- 14. Horizontal centrifugal pump orientation (clause 4.4.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 4.4.1, a "horizontal" centrifugal pump has:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 4.4.1, a "horizontal" centrifugal pump has:', 'single_choice', 'medium', 'Clause 4.4.1: a horizontal centrifugal pump has a vertical impeller mounted on a horizontal shaft (clause 4.4.2: a vertical pump has a horizontal impeller mounted on a vertical shaft).', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A vertical impeller mounted on a horizontal shaft', true, 0),
      (v_question_id, 'A horizontal impeller mounted on a vertical shaft', false, 1),
      (v_question_id, 'No shaft at all', false, 2),
      (v_question_id, 'Two impellers mounted on parallel shafts', false, 3);
  END IF;

  -- 15. Non-self-priming pump (clause 4.5.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 4.5.1, a "non-self-priming" pump requires the system to be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 4.5.1, a "non-self-priming" pump requires the system to be:', 'single_choice', 'medium', 'Clause 4.5.1: a non-self-priming pump needs to be manually primed — the system has to be filled initially by pouring water into the pipes from a bucket, and thereafter the footvalve keeps water in the system even when the pump is not used for some time.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Filled initially by manually pouring water into the pipes, with a footvalve keeping water in afterward', true, 0),
      (v_question_id, 'Left to develop its own vacuum before use', false, 1),
      (v_question_id, 'Run dry for several minutes before priming', false, 2),
      (v_question_id, 'Disassembled before every priming cycle', false, 3);
  END IF;

  -- 16. Self-priming pump mechanism (clause 4.5.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 4.5.2, a "self-priming" pump works by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 4.5.2, a "self-priming" pump works by:', 'single_choice', 'medium', 'Clause 4.5.2: a self-priming pump develops a vacuum sufficient for atmospheric pressure to force the liquid to flow through the suction pipe into the pump casing, without priming the pump manually.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Developing a vacuum sufficient for atmospheric pressure to force liquid through the suction pipe', true, 0),
      (v_question_id, 'Requiring a bucket of water poured into the pipes before every use', false, 1),
      (v_question_id, 'Using a footvalve as the sole means of retaining water', false, 2),
      (v_question_id, 'Running the impeller in reverse to draw a vacuum', false, 3);
  END IF;

  -- 17. Performance curve content (clause 5.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 5.1, the required performance curve for a centrifugal pump shows which quantities plotted against discharge at specified shaft speed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 5.1, the required performance curve for a centrifugal pump shows which quantities plotted against discharge at specified shaft speed?', 'single_choice', 'medium', 'Clause 5.1: the performance curve shows the head, efficiency, NPSHR, and power, plotted against discharge at specified shaft speed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Head, efficiency, NPSHR, and power', true, 0),
      (v_question_id, 'Warranty period and serial number only', false, 1),
      (v_question_id, 'Casing material and impeller type only', false, 2),
      (v_question_id, 'Bearing type and shaft diameter only', false, 3);
  END IF;

  -- 18. Warranty period (clause 8.1 / 8.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clauses 8.1 and 8.2, warranty against defective materials/workmanship and against breakdown of major components shall be provided for how long from purchase by the first buyer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clauses 8.1 and 8.2, warranty against defective materials/workmanship and against breakdown of major components shall be provided for how long from purchase by the first buyer?', 'single_choice', 'medium', 'Clauses 8.1 and 8.2: warranty for parts/services (except consumable parts such as seals) and against breakdown of major components (casing, impeller, shaft, etc.) shall both be provided for six (6) months from purchase by the first buyer.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Three (3) months', false, 0),
      (v_question_id, 'Six (6) months', true, 1),
      (v_question_id, 'One (1) year', false, 2),
      (v_question_id, 'Two (2) years', false, 3);
  END IF;

  -- 19. Required hand tools (clause 9.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 9.1, each centrifugal pump unit shall be provided with which basic hand tools for repair and maintenance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 9.1, each centrifugal pump unit shall be provided with which basic hand tools for repair and maintenance?', 'single_choice', 'hard', 'Clause 9.1: two (2) pieces of open wrenches of appropriate sizes and one (1) piece adjustable wrench.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two open wrenches and one adjustable wrench', true, 0),
      (v_question_id, 'One socket set and one torque wrench', false, 1),
      (v_question_id, 'A grease gun and a pressure gauge', false, 2),
      (v_question_id, 'A spare impeller and a spare shaft seal', false, 3);
  END IF;

  -- 20. Sampling standard (clause 10)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 10, centrifugal pumps shall be sampled for testing in accordance with which standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 10, centrifugal pumps shall be sampled for testing in accordance with which standard?', 'single_choice', 'medium', 'Clause 10 (Sampling): centrifugal pumps shall be sampled for testing in accordance with PAES 103, Agricultural Machinery — Method of Sampling.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PAES 102', false, 0),
      (v_question_id, 'PAES 103', true, 1),
      (v_question_id, 'PAES 115', false, 2),
      (v_question_id, 'PAES 119', false, 3);
  END IF;

  -- 21. Test method standard (clause 11)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 11, sampled centrifugal pumps shall be tested for performance in accordance with which standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 11, sampled centrifugal pumps shall be tested for performance in accordance with which standard?', 'single_choice', 'medium', 'Clause 11 (Test Method): sampled centrifugal pumps shall be tested for performance in accordance with PAES 115, Centrifugal, Mixed-Flow and Axial Flow Water Pumps — Methods of Test.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PAES 102', false, 0),
      (v_question_id, 'PAES 103', false, 1),
      (v_question_id, 'PAES 115', true, 2),
      (v_question_id, 'PAES 118', false, 3);
  END IF;

  -- 22. Marking requirement (clause 12)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 12 (Marking and Labeling), which of the following is required to be marked on each centrifugal pump?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 12 (Marking and Labeling), which of the following is required to be marked on each centrifugal pump?', 'single_choice', 'medium', 'Clause 12 requires marking the registered trademark, brand, model, type and size, serial number, name/address of manufacturer, maximum efficiency, discharge at maximum efficiency (capacity), total head at maximum efficiency, rated shaft speed, and input/shaft power. Retail price is not a required marking.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rated shaft speed', true, 0),
      (v_question_id, 'Retail price', false, 1),
      (v_question_id, 'Name of the retail dealer', false, 2),
      (v_question_id, 'Expected resale value', false, 3);
  END IF;

  -- 23. Production date marking (clause 12, optional item)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 12, which of the following marking items is explicitly listed as OPTIONAL rather than mandatory?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 12, which of the following marking items is explicitly listed as OPTIONAL rather than mandatory?', 'single_choice', 'hard', 'Clause 12 marks "Production date (optional)" and "Name and address of the importer, if imported (optional)" as optional items, distinct from the mandatory items like brand, model, serial number, and performance ratings.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Production date', true, 0),
      (v_question_id, 'Model', false, 1),
      (v_question_id, 'Serial number', false, 2),
      (v_question_id, 'Rated shaft speed', false, 3);
  END IF;

  -- 24. Rotating components (clause 6.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 6.2 (Other Requirements), the rotating components of a centrifugal pump shall be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 6.2 (Other Requirements), the rotating components of a centrifugal pump shall be:', 'single_choice', 'medium', 'Clause 6.2: the rotating components shall be dynamically balanced.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dynamically balanced', true, 0),
      (v_question_id, 'Painted with a rust-proof coating', false, 1),
      (v_question_id, 'Replaceable without tools', false, 2),
      (v_question_id, 'Manufactured only from stainless steel', false, 3);
  END IF;

  -- 25. Castings workmanship (clause 7.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 114:2000 clause 7.1 (Workmanship and Finish), pump castings shall be free of which defects?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 114:2000 clause 7.1 (Workmanship and Finish), pump castings shall be free of which defects?', 'single_choice', 'medium', 'Clause 7.1: castings shall be free of shrink holes, blowholes, cracks, scale, blisters, and other similar injurious defects; surfaces shall be cleaned by sandblasting, shot blasting, pickling, or another standard method.', NULL, NULL, 'draft', false, NULL, true, 'PAES 114')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shrink holes, blowholes, cracks, scale, and blisters', true, 0),
      (v_question_id, 'Only color inconsistencies', false, 1),
      (v_question_id, 'Only minor dimensional tolerance deviations', false, 2),
      (v_question_id, 'Only surface fingerprints from handling', false, 3);
  END IF;

END $$;
