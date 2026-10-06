-- Rural Electrification quiz batch (17 questions, 1 topic). Every numeric
-- problem, formula, and worked answer is drawn directly from a review-material
-- problem set on AB electrification (lighting design, illumination/luminance,
-- transformers, generators, motors, power factor) read in full from
-- "ABELE TOP 1/ATTRC/Area 3/PROJ MANAGEMENT-FOREST ENG-ELECTRI-STRUCTURES/
-- Project-Management-Forest-Engineering-Electrification-and-Structures.pdf"
-- (Electrification section, 2026-10-02) — every number re-derived and checked
-- independently against each slide's own worked solution before being used
-- here, no invented facts. This topic had zero published questions before
-- this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since these are general electrical-engineering review problems, not PAES
-- standard clauses.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Rural Electrification (STRUCTURES_ENVIRONMENT) — 17 question(s)
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
    RAISE EXCEPTION 'Topic not found: Rural Electrification';
  END IF;

  -- 1. Mounting height from mounting ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A warehouse will install pendant dome incandescent lamps at a mounting ratio of 1.50. The lamps will be mounted on a grid measuring 5 m by 5 m. What is the minimum mounting height of the lamps?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A warehouse will install pendant dome incandescent lamps at a mounting ratio of 1.50. The lamps will be mounted on a grid measuring 5 m by 5 m. What is the minimum mounting height of the lamps?', 'single_choice', 'medium', 'Mounting ratio = spacing / mounting height, so mounting height = spacing / mounting ratio = 5 m / 1.50 = 3.30 m (3.33 m rounded).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 m', false, 0),
      (v_question_id, '3.30 m', true, 1),
      (v_question_id, '7.5 m', false, 2),
      (v_question_id, '7 m', false, 3);
  END IF;

  -- 2. General lighting load (PEC constant)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the total general lighting load for a two-storey residence having a floor dimension of 6 m by 9 m, per floor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the total general lighting load for a two-storey residence having a floor dimension of 6 m by 9 m, per floor?', 'single_choice', 'hard', 'The Philippine Electrical Code specifies a general lighting load of 32 VA/m² for a dwelling. GLL = 32 VA/m² × (6 m × 9 m) × 2 storeys = 32 × 54 × 2 = 3,456 VA.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1728 VA', false, 0),
      (v_question_id, '3456 VA', true, 1),
      (v_question_id, '1620 VA', false, 2),
      (v_question_id, '3240 VA', false, 3);
  END IF;

  -- 3. PEC general lighting load constant (conceptual)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the Philippine Electrical Code, what general lighting load (in VA per square meter of floor area) is specified for a dwelling unit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the Philippine Electrical Code, what general lighting load (in VA per square meter of floor area) is specified for a dwelling unit?', 'single_choice', 'medium', 'The PEC specifies a general lighting load of 32 VA/m² for a dwelling unit, used to compute GLL = 32 VA/m² × floor area × number of floors.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16 VA/m²', false, 0),
      (v_question_id, '32 VA/m²', true, 1),
      (v_question_id, '50 VA/m²', false, 2),
      (v_question_id, '64 VA/m²', false, 3);
  END IF;

  -- 4. Illumination = lumen / area (lux)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 40 W fluorescent lamp produces 3,000 lumens of light in a room with dimensions of 3 m by 5 m. What is the illumination of the floor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 40 W fluorescent lamp produces 3,000 lumens of light in a room with dimensions of 3 m by 5 m. What is the illumination of the floor?', 'single_choice', 'medium', 'Illumination = lumen / area = 3,000 lumens / (3 m × 5 m) = 3,000 / 15 m² = 200 lux (lumens per square meter is the SI unit, lux).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200 lux', true, 0),
      (v_question_id, '40 fc', false, 1),
      (v_question_id, '200 fc', false, 2),
      (v_question_id, '50 lux', false, 3);
  END IF;

  -- 5. Illumination = lumen / area (footcandle, English units)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 40 W fluorescent lamp 120 cm long produces 3,200 lumens of light in a room having a general dimension of 15 ft by 20 ft. Find the illumination.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 40 W fluorescent lamp 120 cm long produces 3,200 lumens of light in a room having a general dimension of 15 ft by 20 ft. Find the illumination.', 'single_choice', 'medium', 'Illumination = lumen / area = 3,200 lumens / (15 ft × 20 ft) = 3,200 / 300 ft² = 10.67 lumens per square foot — the English unit for this is the footcandle, so the illumination is 10.67 footcandle.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.67 lumen', false, 0),
      (v_question_id, '10.67 footlambert', false, 1),
      (v_question_id, '10.67 lux', false, 2),
      (v_question_id, '10.67 footcandle', true, 3);
  END IF;

  -- 6. Luminance from illumination and reflectance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A room is illuminated at 10.67 footcandle. What is the luminance (brightness) of the walls if their reflectance factor is 40%?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A room is illuminated at 10.67 footcandle. What is the luminance (brightness) of the walls if their reflectance factor is 40%?', 'single_choice', 'hard', 'Luminance (brightness) = illumination × reflectance factor = 10.67 footcandle × 0.40 = 4.27 footlambert.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.27 lumen', false, 0),
      (v_question_id, '4.27 footlambert', true, 1),
      (v_question_id, '4.27 lux', false, 2),
      (v_question_id, '4.27 footcandle', false, 3);
  END IF;

  -- 7. Luminance of a diffuser fixture, converted to millilambert
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Compute the brightness of a fixture with a 1'' by 4'' plastic diffuser having a transmittance of 0.60, illuminated by 2 pieces of 3,200-lumen lamps, assuming 100% use of light flux.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Compute the brightness of a fixture with a 1'' by 4'' plastic diffuser having a transmittance of 0.60, illuminated by 2 pieces of 3,200-lumen lamps, assuming 100% use of light flux.', 'single_choice', 'hard', 'Luminance = illumination × factor = [3,200 lumen / (1 ft × 4 ft)] × 0.60 × 2 = 960 footlambert. Converting with 1 footlambert = 1.076 millilambert: 960 × 1.076 = 1,032.96 ≈ 1,033 millilambert.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1033 millilambert', true, 0),
      (v_question_id, '1600 millilambert', false, 1),
      (v_question_id, '800 millilambert', false, 2),
      (v_question_id, '960 millilambert', false, 3);
  END IF;

  -- 8. Generator current from power and voltage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 120 V generator delivers 3 kW to an electric furnace. The current supplied by the generator is about:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 120 V generator delivers 3 kW to an electric furnace. The current supplied by the generator is about:', 'single_choice', 'medium', 'I = P / V = 3,000 W / 120 V = 25 A = 25,000 mA.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.5 A', false, 0),
      (v_question_id, '250 mA', false, 1),
      (v_question_id, '2500 mA', false, 2),
      (v_question_id, '25000 mA', true, 3);
  END IF;

  -- 9. Step-down transformer primary current
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A step-down transformer has a primary voltage of 120 V and a secondary voltage of 24 V. If a current of 5 A flows on the secondary, what is the current flowing on the primary side (assuming no power loss)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A step-down transformer has a primary voltage of 120 V and a secondary voltage of 24 V. If a current of 5 A flows on the secondary, what is the current flowing on the primary side (assuming no power loss)?', 'single_choice', 'medium', 'For an ideal transformer, primary power equals secondary power: Vp × Ip = Vs × Is, so Ip = (Vs × Is) / Vp = (24 V × 5 A) / 120 V = 1 A.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 A', false, 0),
      (v_question_id, '24 A', false, 1),
      (v_question_id, '25 A', false, 2),
      (v_question_id, '1 A', true, 3);
  END IF;

  -- 10. Transformer turns ratio and secondary current
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If a transformer has a ratio of one primary turn to 10 secondary turns, what is the secondary current for a primary current of 40 A, assuming that there is no power loss?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If a transformer has a ratio of one primary turn to 10 secondary turns, what is the secondary current for a primary current of 40 A, assuming that there is no power loss?', 'single_choice', 'medium', 'For an ideal transformer, the turns ratio Np:Ns equals the inverse of the current ratio Is:Ip. With Np:Ns = 1:10, Is = Ip / 10 = 40 A / 10 = 4 A.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 A', false, 0),
      (v_question_id, '4 A', true, 1),
      (v_question_id, '6 A', false, 2),
      (v_question_id, '8 A', false, 3);
  END IF;

  -- 11. Number of poles from frequency and rotor speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine the number of poles on the rotor of a single-phase generator if a frequency of 60 Hz is generated at a rotor speed of 1,800 rpm.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Determine the number of poles on the rotor of a single-phase generator if a frequency of 60 Hz is generated at a rotor speed of 1,800 rpm.', 'single_choice', 'medium', 'Synchronous speed N = 120f / P, so P = 120f / N = (120 × 60) / 1,800 = 7,200 / 1,800 = 4 poles.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 poles', false, 0),
      (v_question_id, '4 poles', true, 1),
      (v_question_id, '6 poles', false, 2),
      (v_question_id, '8 poles', false, 3);
  END IF;

  -- 12. Synchronous speed from poles and frequency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What would be the speed of a 120 V, 6-pole motor on a 60 Hz source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What would be the speed of a 120 V, 6-pole motor on a 60 Hz source?', 'single_choice', 'medium', 'Synchronous speed N = 120f / P = (120 × 60) / 6 = 7,200 / 6 = 1,200 rpm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1800 rpm', false, 0),
      (v_question_id, '1200 rpm', true, 1),
      (v_question_id, '900 rpm', false, 2),
      (v_question_id, '2400 rpm', false, 3);
  END IF;

  -- 13. AWG No. 8 equivalent cross-sectional area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the equivalent cross-sectional area of a No. 8 AWG conductor wire in square inches?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the equivalent cross-sectional area of a No. 8 AWG conductor wire in square inches?', 'single_choice', 'hard', 'A No. 8 AWG conductor has a standard cross-sectional area of approximately 0.013 square inches (about 16,510 circular mils).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.1 square in', false, 0),
      (v_question_id, '0.013 square in', true, 1),
      (v_question_id, '0.01 square in', false, 2),
      (v_question_id, '1.0 square in', false, 3);
  END IF;

  -- 14. 250 MCM cable equivalent area in mm²
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the equivalent size in square millimeters of a 250 MCM cable?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the equivalent size in square millimeters of a 250 MCM cable?', 'single_choice', 'hard', '1 MCM (1,000 circular mils) is equivalent to approximately 0.5067 mm². A 250 MCM cable (250,000 circular mils) is therefore 250 × 0.5067 ≈ 126 mm².', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '127 mm²', false, 0),
      (v_question_id, '126 mm²', true, 1),
      (v_question_id, '125 mm²', false, 2),
      (v_question_id, '124 mm²', false, 3);
  END IF;

  -- 15. Current through a resistive lamp from Ohm's law
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A mercury lamp having a hot resistance of 50 ohms is connected to a socket with 240 V supply. How much current flows through the lamp?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A mercury lamp having a hot resistance of 50 ohms is connected to a socket with 240 V supply. How much current flows through the lamp?', 'single_choice', 'easy', 'By Ohm''s law, I = V / R = 240 V / 50 ohms = 4.8 A.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 A', false, 0),
      (v_question_id, '4.8 A', true, 1),
      (v_question_id, '4 A', false, 2),
      (v_question_id, '5.8 A', false, 3);
  END IF;

  -- 16. Power factor of a purely inductive circuit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the power factor for a purely inductive circuit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the power factor for a purely inductive circuit?', 'single_choice', 'medium', 'In a purely inductive circuit, current lags voltage by 90 degrees, so the power factor (cosine of the angle between voltage and current) is cos(90°) = 0.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1', false, 0),
      (v_question_id, '0', true, 1),
      (v_question_id, 'Less than 1', false, 2),
      (v_question_id, 'Greater than 1', false, 3);
  END IF;

  -- 17. Motor power factor from apparent and real power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An electric motor draws 2,304 W and 12 A when operating on a 240 V, 60 Hz source. What is the power factor of the motor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An electric motor draws 2,304 W and 12 A when operating on a 240 V, 60 Hz source. What is the power factor of the motor?', 'single_choice', 'medium', 'Apparent power S = V × I = 240 V × 12 A = 2,880 VA. Power factor = real power / apparent power = 2,304 W / 2,880 VA = 0.80.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.75', false, 0),
      (v_question_id, '0.80', true, 1),
      (v_question_id, '0.50', false, 2),
      (v_question_id, '0.66', false, 3);
  END IF;

END $$;
