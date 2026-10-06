-- Internal Combustion Engine quiz batch (26 questions, 1 topic). Every numeric
-- problem, formula, and worked answer is drawn directly from engine-theory
-- review material (engine cycles, compression ratio and displacement,
-- indicated/brake power, mechanical and thermal efficiency, firing order,
-- power strokes, fuel consumption) and from the Philippine Agricultural
-- Engineering Standards for small engines (specifications and methods of
-- test), read in full (2026-10-02). Every number was re-derived and checked
-- independently against its worked solution before being used here, no
-- invented facts. Ambiguous or internally inconsistent source items were
-- skipped.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=true with paes_reference set
-- only for questions grounded in a real PAES standard clause; all others are
-- is_paes=false / paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Internal Combustion Engine (POWER_ENERGY_MACHINERY) — 26 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Internal Combustion Engine' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Internal Combustion Engine';
  END IF;

  -- 1. Spark-ignition cycle and combustion type
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A spark-ignition (gasoline) engine operates on which thermodynamic cycle, and what kind of combustion process does that cycle assume?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A spark-ignition (gasoline) engine operates on which thermodynamic cycle, and what kind of combustion process does that cycle assume?', 'single_choice', 'easy', 'Spark ignition corresponds to the Otto cycle, which assumes constant-volume combustion. Compression ignition corresponds to the Diesel cycle, which assumes constant-pressure combustion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diesel cycle; constant volume', false, 0),
      (v_question_id, 'Diesel cycle; constant pressure', false, 1),
      (v_question_id, 'Otto cycle; constant volume', true, 2),
      (v_question_id, 'Otto cycle; constant pressure', false, 3);
  END IF;

  -- 2. Power strokes in 100 revolutions, 4-stroke single cylinder
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many power strokes (explosions) occur in a single-cylinder, four-stroke engine during 100 revolutions of the crankshaft?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many power strokes (explosions) occur in a single-cylinder, four-stroke engine during 100 revolutions of the crankshaft?', 'single_choice', 'easy', 'A four-stroke engine completes one cycle (one power stroke) every two crankshaft revolutions. Power strokes = 100 revolutions / 2 = 50.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25', false, 0),
      (v_question_id, '50', true, 1),
      (v_question_id, '100', false, 2),
      (v_question_id, '200', false, 3);
  END IF;

  -- 3. Power strokes per minute, 2-stroke 4-cylinder
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-cylinder, two-stroke engine runs at 2,000 rpm. How many power strokes does the engine deliver per minute?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A four-cylinder, two-stroke engine runs at 2,000 rpm. How many power strokes does the engine deliver per minute?', 'single_choice', 'medium', 'A two-stroke engine produces one power stroke per cylinder in every crankshaft revolution. Power strokes per minute = 2,000 rpm x 4 cylinders = 8,000.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2,000', false, 0),
      (v_question_id, '4,000', false, 1),
      (v_question_id, '8,000', true, 2),
      (v_question_id, '16,000', false, 3);
  END IF;

  -- 4. Explosions per minute of V-12 from camshaft speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A V-12, four-stroke engine with directly meshed gears has a camshaft speed of 2,000 rpm. How many explosions per minute can the engine produce?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A V-12, four-stroke engine with directly meshed gears has a camshaft speed of 2,000 rpm. How many explosions per minute can the engine produce?', 'single_choice', 'hard', 'In a four-stroke engine each cylinder fires once per camshaft revolution, so explosions per minute = camshaft speed x number of cylinders = 2,000 x 12 = 24,000.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8,000', false, 0),
      (v_question_id, '24,000', true, 1),
      (v_question_id, '36,000', false, 2),
      (v_question_id, '48,000', false, 3);
  END IF;

  -- 5. Firing interval of a 6-cylinder 4-stroke engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the firing interval, in degrees of crankshaft rotation, of a six-cylinder, four-stroke engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the firing interval, in degrees of crankshaft rotation, of a six-cylinder, four-stroke engine?', 'single_choice', 'medium', 'A four-stroke cycle spans 720 degrees of crankshaft rotation (four strokes of 180 degrees each). With six cylinders sharing that cycle, firing interval = 720 / 6 = 120 degrees, meaning one cylinder fires every 120 degrees of crankshaft rotation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60 degrees', false, 0),
      (v_question_id, '120 degrees', true, 1),
      (v_question_id, '180 degrees', false, 2),
      (v_question_id, '720 degrees', false, 3);
  END IF;

  -- 6. Common firing order of a 6-cylinder engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Firing order is the sequence in which the cylinders deliver their power strokes. Which firing order is commonly used for a six-cylinder engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Firing order is the sequence in which the cylinders deliver their power strokes. Which firing order is commonly used for a six-cylinder engine?', 'single_choice', 'easy', 'The firing order 1-5-3-6-2-4 is commonly used for six-cylinder engines because it gives a good balance of smoothness, power delivery, and reduced vibration. Firing orders can vary with engine design, vibration and balance considerations, and manufacturer preference.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1-2-3-4-5-6', false, 0),
      (v_question_id, '1-5-3-6-2-4', true, 1),
      (v_question_id, '1-4-2-6-3-5', false, 2),
      (v_question_id, '2-4-6-1-3-5', false, 3);
  END IF;

  -- 7. Compression ratio from total volume, bore and stroke
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine the compression ratio of an engine with a total volume of 70 cc, a bore of 4 cm, and a stroke of 5 cm.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Determine the compression ratio of an engine with a total volume of 70 cc, a bore of 4 cm, and a stroke of 5 cm.', 'single_choice', 'medium', 'Piston displacement PD = (pi/4) x bore^2 x stroke = (pi/4)(4 cm)^2(5 cm) = 62.83 cc. Clearance volume CV = total volume - PD = 70 - 62.83 = 7.17 cc. Compression ratio = total volume / CV = 70 / 7.17 = 9.76:1.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.02:1', false, 0),
      (v_question_id, '7.90:1', false, 1),
      (v_question_id, '8.13:1', false, 2),
      (v_question_id, '9.76:1', true, 3);
  END IF;

  -- 8. Bore from clearance volume and compression ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engine has a clearance volume of 7.18 cc, a compression ratio of 8:1, and a stroke of 4 cm. What is its bore?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An engine has a clearance volume of 7.18 cc, a compression ratio of 8:1, and a stroke of 4 cm. What is its bore?', 'single_choice', 'hard', 'Total volume = CR x CV = 8 x 7.18 = 57.44 cc. Piston displacement = total volume - CV = 57.44 - 7.18 = 50.26 cc. Since PD = (pi/4) x bore^2 x stroke, 50.26 = (pi/4)(bore^2)(4), so bore^2 = 16 and bore = 4 cm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 cm', false, 0),
      (v_question_id, '4 cm', true, 1),
      (v_question_id, '5 cm', false, 2),
      (v_question_id, '6 cm', false, 3);
  END IF;

  -- 9. Clearance volume from compression ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If the compression ratio of an engine is 17:1, what is the clearance volume for a piston displacement volume of 100 cm3?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If the compression ratio of an engine is 17:1, what is the clearance volume for a piston displacement volume of 100 cm3?', 'single_choice', 'medium', 'Compression ratio = (PD + CV) / CV = 17, so PD / CV = 16 and CV = PD / 16 = 100 / 16 = 6.25 cc.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.88 cc', false, 0),
      (v_question_id, '6.25 cc', true, 1),
      (v_question_id, '17.00 cc', false, 2),
      (v_question_id, '20.00 cc', false, 3);
  END IF;

  -- 10. Identify diesel vs Otto from dimensions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-cylinder engine has a 130.2-mm bore, a 127-mm stroke, and a clearance volume of 0.119 L in each cylinder. Based on its compression ratio, is it a diesel or an Otto-cycle engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A four-cylinder engine has a 130.2-mm bore, a 127-mm stroke, and a clearance volume of 0.119 L in each cylinder. Based on its compression ratio, is it a diesel or an Otto-cycle engine?', 'single_choice', 'hard', 'Piston displacement per cylinder = (pi/4)(0.1302 m)^2(0.127 m) = 1.6909 x 10^-3 m^3 = 1.69 L. Compression ratio = (PD + CV) / CV = (1.6909 + 0.119) / 0.119 = 15.2. Diesel engines have compression ratios of about 14 to 22, while Otto engines have about 6 to 12, so this is a diesel engine.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diesel engine', true, 0),
      (v_question_id, 'Otto-cycle engine', false, 1),
      (v_question_id, 'Cannot be determined because the engine speed is not given', false, 2),
      (v_question_id, 'Cannot be determined because the fuel type is not given', false, 3);
  END IF;

  -- 11. Indicated horsepower of 6-cylinder 4-stroke engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the indicated horsepower of a four-stroke, six-cylinder engine with a 4-inch bore and a 4-inch stroke running at 1,500 rpm, with a mean effective pressure of 80 psi? (1 hp = 33,000 ft-lb/min)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the indicated horsepower of a four-stroke, six-cylinder engine with a 4-inch bore and a 4-inch stroke running at 1,500 rpm, with a mean effective pressure of 80 psi? (1 hp = 33,000 ft-lb/min)', 'single_choice', 'hard', 'IHP = P L A N n / (33,000 x 2) for a four-stroke engine. Piston area A = (pi/4)(4 in)^2 = 12.57 in^2; stroke L = 4/12 ft. Work per power stroke = 80 psi x 12.57 in^2 x (4/12 ft) = 335.1 ft-lb. Power strokes per minute = (1,500 / 2) x 6 cylinders = 4,500. IHP = 335.1 x 4,500 / 33,000 = 45.7 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35.0 hp', false, 0),
      (v_question_id, '45.7 hp', true, 1),
      (v_question_id, '52.0 hp', false, 2),
      (v_question_id, '60.0 hp', false, 3);
  END IF;

  -- 12. Indicated horsepower, 4-cylinder gasoline engine (metric)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-cylinder, four-stroke gasoline engine has a 20-cm cylinder diameter and a 40-cm stroke, and runs at 1,500 rpm with a mean effective pressure of 8 kg/cm2. Using 1 kgf = 9.81 N and 1 hp = 746 W, what is its indicated horsepower?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A four-cylinder, four-stroke gasoline engine has a 20-cm cylinder diameter and a 40-cm stroke, and runs at 1,500 rpm with a mean effective pressure of 8 kg/cm2. Using 1 kgf = 9.81 N and 1 hp = 746 W, what is its indicated horsepower?', 'single_choice', 'hard', 'Piston area = (pi/4)(20 cm)^2 = 314.16 cm^2. Force on piston = 8 kgf/cm^2 x 314.16 cm^2 = 2,513.3 kgf. Work per power stroke = 2,513.3 kgf x 0.40 m = 1,005.3 kgf-m. Power strokes per minute = (1,500 / 2) x 4 = 3,000, so work rate = 3,015,930 kgf-m/min = 50,265 kgf-m/s = 493,100 W. IHP = 493,100 / 746 = about 661 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '461 hp', false, 0),
      (v_question_id, '661 hp', true, 1),
      (v_question_id, '761 hp', false, 2),
      (v_question_id, '861 hp', false, 3);
  END IF;

  -- 13. Piston speed of a diesel engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A three-cylinder, four-stroke diesel engine has an 89-mm bore and a 130-mm stroke, and runs at 2,000 rpm. What is its piston speed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A three-cylinder, four-stroke diesel engine has an 89-mm bore and a 130-mm stroke, and runs at 2,000 rpm. What is its piston speed?', 'single_choice', 'hard', 'The piston travels two strokes per crankshaft revolution, so piston speed = 2 x stroke x rpm = 2 x 0.130 m x 2,000 rpm = 520 m/min.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '260 m/min', false, 0),
      (v_question_id, '520 m/min', true, 1),
      (v_question_id, '672 m/min', false, 2),
      (v_question_id, '725 m/min', false, 3);
  END IF;

  -- 14. Mechanical efficiency from brake and friction horsepower
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engine operates at a brake horsepower of 10 hp, and its friction horsepower is 2.5 hp. What is its mechanical efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An engine operates at a brake horsepower of 10 hp, and its friction horsepower is 2.5 hp. What is its mechanical efficiency?', 'single_choice', 'medium', 'Indicated horsepower = brake horsepower + friction horsepower = 10 + 2.5 = 12.5 hp. Mechanical efficiency = BHP / IHP = 10 / 12.5 = 0.80 or 80%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20%', false, 0),
      (v_question_id, '75%', false, 1),
      (v_question_id, '80%', true, 2),
      (v_question_id, '125%', false, 3);
  END IF;

  -- 15. Brake thermal efficiency from fuel use per hp-hr
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the brake thermal efficiency of an engine that uses 0.6 lb of fuel per horsepower-hour, if the fuel contains 20,000 BTU/lb? (1 hp-hr = 2,545 BTU)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the brake thermal efficiency of an engine that uses 0.6 lb of fuel per horsepower-hour, if the fuel contains 20,000 BTU/lb? (1 hp-hr = 2,545 BTU)', 'single_choice', 'medium', 'Fuel energy supplied per hp-hr = 0.6 lb x 20,000 BTU/lb = 12,000 BTU. Brake thermal efficiency = useful energy / fuel energy = 2,545 / 12,000 = 0.212 or 21.2%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '21.2%', true, 0),
      (v_question_id, '34.5%', false, 1),
      (v_question_id, '46.8%', false, 2),
      (v_question_id, '60.0%', false, 3);
  END IF;

  -- 16. Thermal efficiency from fuel use per kW-hr
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the thermal efficiency of a gasoline engine that uses 0.315 kg of fuel per kW-hr? Assume the gasoline has an energy content of 47.06 MJ/kg and that 1 kW-hr = 3.6 MJ.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the thermal efficiency of a gasoline engine that uses 0.315 kg of fuel per kW-hr? Assume the gasoline has an energy content of 47.06 MJ/kg and that 1 kW-hr = 3.6 MJ.', 'single_choice', 'hard', 'Energy from fuel = 0.315 kg x 47.06 MJ/kg = 14.82 MJ per kW-hr. The useful output is 1 kW-hr = 3.6 MJ. Thermal efficiency = 3.6 / 14.82 = 0.243 or 24.3%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '11.6%', false, 0),
      (v_question_id, '24.3%', true, 1),
      (v_question_id, '31.5%', false, 2),
      (v_question_id, '40.2%', false, 3);
  END IF;

  -- 17. Torque from horsepower and speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engine crankshaft produces 30 hp at 1,700 rpm. What is the torque exerted? (1 hp = 33,000 ft-lb/min)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An engine crankshaft produces 30 hp at 1,700 rpm. What is the torque exerted? (1 hp = 33,000 ft-lb/min)', 'single_choice', 'medium', 'Power = 2 x pi x T x N, so T = P / (2 x pi x N) = (30 x 33,000 ft-lb/min) / (2 x pi x 1,700 rpm) = 92.7 ft-lb.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '53.2 ft-lb', false, 0),
      (v_question_id, '74.8 ft-lb', false, 1),
      (v_question_id, '92.7 ft-lb', true, 2),
      (v_question_id, '110.4 ft-lb', false, 3);
  END IF;

  -- 18. Brake thermal efficiency of a single-cylinder gasoline engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A single-cylinder, four-stroke gasoline engine produces 83 lb-ft of torque at 3,100 rpm while consuming 3.34 gal/hr of gasoline. The gasoline weighs 6.13 lb/gal and has a heating value of 20,380 BTU/lb. What is the brake thermal efficiency? (1 hp = 33,000 ft-lb/min; 1 hp-hr = 2,545 BTU)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A single-cylinder, four-stroke gasoline engine produces 83 lb-ft of torque at 3,100 rpm while consuming 3.34 gal/hr of gasoline. The gasoline weighs 6.13 lb/gal and has a heating value of 20,380 BTU/lb. What is the brake thermal efficiency? (1 hp = 33,000 ft-lb/min; 1 hp-hr = 2,545 BTU)', 'single_choice', 'hard', 'Brake horsepower = 2 x pi x 83 lb-ft x 3,100 rpm / 33,000 = 48.99 hp. Fuel power = 3.34 gal/hr x 6.13 lb/gal x 20,380 BTU/lb / 2,545 BTU per hp-hr = 163.95 hp. Brake thermal efficiency = 48.99 / 163.95 = 0.30.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.30', true, 0),
      (v_question_id, '0.38', false, 1),
      (v_question_id, '0.78', false, 2),
      (v_question_id, '0.82', false, 3);
  END IF;

  -- 19. Fuel consumption and specific fuel consumption of a hydro tiller
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hydro tiller powered by a 20-hp gasoline engine starts at 6 AM with a full 12-liter fuel tank. By 11 AM only 4 liters remain. What are its fuel consumption and its specific fuel consumption?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A hydro tiller powered by a 20-hp gasoline engine starts at 6 AM with a full 12-liter fuel tank. By 11 AM only 4 liters remain. What are its fuel consumption and its specific fuel consumption?', 'single_choice', 'medium', 'Fuel consumption = fuel used / operating time = (12 L - 4 L) / 5 h = 1.6 L/h. Specific fuel consumption = fuel consumption / power = 1.6 L/h / 20 hp = 0.08 L per hp-hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.4 L/h; 0.24 L/hp-hr', false, 0),
      (v_question_id, '0.8 L/h; 0.04 L/hp-hr', false, 1),
      (v_question_id, '1.6 L/h; 0.08 L/hp-hr', true, 2),
      (v_question_id, '2.4 L/h; 0.16 L/hp-hr', false, 3);
  END IF;

  -- 20. Maximum noise level of a small engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 116, the noise emitted by a small engine, measured 50 mm away from the operator''s ear level, shall not be more than how many dB(A)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 116, the noise emitted by a small engine, measured 50 mm away from the operator''s ear level, shall not be more than how many dB(A)?', 'single_choice', 'easy', 'PAES 116 limits the noise emitted by the engine, measured 50 mm from the operator''s ear level, to a maximum of 92 dB(A).', NULL, NULL, 'draft', false, NULL, true, 'PAES 116')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '85 dB(A)', false, 0),
      (v_question_id, '90 dB(A)', false, 1),
      (v_question_id, '92 dB(A)', true, 2),
      (v_question_id, '96 dB(A)', false, 3);
  END IF;

  -- 21. Minimum power attained in varying load test
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 116, what minimum percentage of the rated maximum output power shall a small engine attain during the varying load test?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 116, what minimum percentage of the rated maximum output power shall a small engine attain during the varying load test?', 'single_choice', 'medium', 'PAES 116 requires that at least 80% of the rated maximum output power be attained during the varying load test.', NULL, NULL, 'draft', false, NULL, true, 'PAES 116')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60%', false, 0),
      (v_question_id, '70%', false, 1),
      (v_question_id, '80%', true, 2),
      (v_question_id, '90%', false, 3);
  END IF;

  -- 22. Cold start requirement in the starting test
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the PAES 117 starting test, a small engine in thermal equilibrium with its environment should start within how many attempts for a cold start; otherwise, it is considered hard to start?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the PAES 117 starting test, a small engine in thermal equilibrium with its environment should start within how many attempts for a cold start; otherwise, it is considered hard to start?', 'single_choice', 'medium', 'For the cold start test, the engine, in thermal equilibrium with the environment, should start within 10 attempts, otherwise it is considered hard to start. For the hot start test, the engine should start within 5 attempts.', NULL, NULL, 'draft', false, NULL, true, 'PAES 117')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 attempts', false, 0),
      (v_question_id, '5 attempts', false, 1),
      (v_question_id, '10 attempts', true, 2),
      (v_question_id, '15 attempts', false, 3);
  END IF;

  -- 23. Valid range of the power correction factor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 117, the correction factor K applied to observed engine power to refer it to reference atmospheric conditions (20 degrees C and 1013 mb) is valid only when K lies between which values?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 117, the correction factor K applied to observed engine power to refer it to reference atmospheric conditions (20 degrees C and 1013 mb) is valid only when K lies between which values?', 'single_choice', 'hard', 'The correction formula is only valid where the correction factor is between 0.96 and 1.04. If these limits are not met, the corrected value obtained shall be given and the test conditions (temperature and pressure) shall be precisely stated in the test report.', NULL, NULL, 'draft', false, NULL, true, 'PAES 117')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.90 and 1.10', false, 0),
      (v_question_id, '0.95 and 1.05', false, 1),
      (v_question_id, '0.96 and 1.04', true, 2),
      (v_question_id, '0.98 and 1.02', false, 3);
  END IF;

  -- 24. Side valve (L-head) arrangement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 116, which valve arrangement has the intake and exhaust valves located on one side of the cylinder block?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 116, which valve arrangement has the intake and exhaust valves located on one side of the cylinder block?', 'single_choice', 'easy', 'PAES 116 defines side valves (SV), or L-head arrangement, as the arrangement in which the intake and exhaust valves are located on one side of the cylinder block. In the overhead valve (OHV), or I-head arrangement, the valves are located in the cylinder head.', NULL, NULL, 'draft', false, NULL, true, 'PAES 116')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Overhead valve (I-head) arrangement', false, 0),
      (v_question_id, 'Side valve (L-head) arrangement', true, 1),
      (v_question_id, 'Rotary valve arrangement', false, 2),
      (v_question_id, 'Sleeve valve arrangement', false, 3);
  END IF;

  -- 25. Supercharged intake air
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engine''s intake air pressure is increased by a compressor that is driven off the engine crankshaft. This engine is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An engine''s intake air pressure is increased by a compressor that is driven off the engine crankshaft. This engine is:', 'single_choice', 'easy', 'A supercharger is an air compressor driven by the engine crankshaft (through a belt, gear, or chain) that forces more air into the engine. A turbocharger, in contrast, uses the engine exhaust gases to spin a turbine that drives the compressor.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Naturally aspirated', false, 0),
      (v_question_id, 'Supercharged', true, 1),
      (v_question_id, 'Turbocharged', false, 2),
      (v_question_id, 'Crankcase compressed', false, 3);
  END IF;

  -- 26. Comparison of compression-ignition and spark-ignition engines
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly compares a compression-ignition (diesel) engine with a spark-ignition (gasoline) engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly compares a compression-ignition (diesel) engine with a spark-ignition (gasoline) engine?', 'single_choice', 'medium', 'Compression-ignition engines use a higher compression ratio (about 14:1 to 22:1) than spark-ignition engines (about 6:1 to 12:1) and generally have higher thermal efficiency. Spark-ignition engines use a spark plug and are easier to start in cold conditions.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The diesel engine has a lower compression ratio.', false, 0),
      (v_question_id, 'The diesel engine has a higher compression ratio and generally a higher thermal efficiency.', true, 1),
      (v_question_id, 'The diesel engine is easier to start in cold conditions.', false, 2),
      (v_question_id, 'The diesel engine uses a spark plug to ignite the fuel.', false, 3);
  END IF;

END $$;
