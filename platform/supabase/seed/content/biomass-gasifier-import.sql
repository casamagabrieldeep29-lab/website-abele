-- Design of Biomass Gasifier as Power Source of Various Farm Machinery and
-- Equipment quiz batch (23 questions, 1 topic). Every fact/specification is
-- drawn directly from a biomass gasification exam-review slide deck (4 slides,
-- 24 answer-keyed multiple-choice items covering gasification chemistry,
-- equivalence ratios, gas composition, gasifier zones/types, superficial
-- velocity limits, and gasifier sizing calculations) read in full
-- (2026-10-02) — no invented facts. One source item ("amount of air needed in
-- gasifying biomass") was dropped because its marked answer was ambiguous
-- between two choices in the source. This topic had only 18 published
-- questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- unless a question is grounded in an actual PAES standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment (POWER_ENERGY_MACHINERY) — 23 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment';
  END IF;

  -- 1. Biomass classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among common agricultural residues and fuel sources, which of the following is NOT considered a biomass material: corn cobs, rice husks, or peat?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among common agricultural residues and fuel sources, which of the following is NOT considered a biomass material: corn cobs, rice husks, or peat?', 'single_choice', 'easy', 'Corn cobs, rice husks, and peat are all classified as biomass materials; none of the three is excluded from this classification.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Corn cobs', false, 0),
      (v_question_id, 'Rice husks', false, 1),
      (v_question_id, 'Peat', false, 2),
      (v_question_id, 'None of the above', true, 3);
  END IF;

  -- 2. Product of thermo-chemical conversion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What product results from subjecting biomass to a thermo-chemical reaction such as gasification?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What product results from subjecting biomass to a thermo-chemical reaction such as gasification?', 'single_choice', 'easy', 'Thermo-chemical conversion of biomass yields producer gas; biodiesel, bioethanol, and biogas are products of other (chemical or biochemical) conversion routes.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Producer gas', true, 0),
      (v_question_id, 'Biodiesel', false, 1),
      (v_question_id, 'Bioethanol', false, 2),
      (v_question_id, 'Biogas', false, 3);
  END IF;

  -- 3. Process for high carbon yield
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If a high percentage of carbon (char) is desired from biomass, which thermo-chemical conversion process should be used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If a high percentage of carbon (char) is desired from biomass, which thermo-chemical conversion process should be used?', 'single_choice', 'medium', 'Pyrolysis is the thermo-chemical process recommended when a high carbon (char) yield from biomass is required, since it uses very limited air and favors solid carbon residue over gas production.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Direct combustion', false, 0),
      (v_question_id, 'Pyrolysis', true, 1),
      (v_question_id, 'Gasification', false, 2),
      (v_question_id, 'All of the above', false, 3);
  END IF;

  -- 4. Heating value of producer gas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The heating value of producer gas from biomass gasification is typically at approximately ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The heating value of producer gas from biomass gasification is typically at approximately ____.', 'single_choice', 'medium', 'Producer gas generated from biomass gasification typically has a heating value of around 1,200 kcal per cubic meter.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,200 kcal/m3', true, 0),
      (v_question_id, '2,245 kcal/m3', false, 1),
      (v_question_id, '3,000 kcal/m3', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 5. Engines fueled by producer gas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type(s) of engine can be fueled with producer gas from a biomass gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type(s) of engine can be fueled with producer gas from a biomass gasifier?', 'single_choice', 'easy', 'Producer gas can fuel gas engines, diesel engines (in dual-fuel mode), and gasoline engines, making all of the listed engine types usable with producer gas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gas engine', false, 0),
      (v_question_id, 'Diesel engine', false, 1),
      (v_question_id, 'Gasoline engine', false, 2),
      (v_question_id, 'All of the above', true, 3);
  END IF;

  -- 6. Biomass-gas engine base
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biomass-gas engine used for farm power generation is basically a modified ____ engine.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A biomass-gas engine used for farm power generation is basically a modified ____ engine.', 'single_choice', 'easy', 'A biomass-gas engine is fundamentally a modified diesel engine adapted to run on producer gas, typically in dual-fuel mode.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gasoline', false, 0),
      (v_question_id, 'Diesel', true, 1),
      (v_question_id, 'Steam', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 7. Percent diesel replaced
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What percentage of diesel fuel can typically be replaced when a diesel engine is converted to run in dual-fuel mode with gas producer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What percentage of diesel fuel can typically be replaced when a diesel engine is converted to run in dual-fuel mode with gas producer?', 'single_choice', 'medium', 'A diesel engine operating in dual-fuel mode with gas producer can typically replace about 50 to 70 percent of its diesel fuel consumption with producer gas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20-40%', false, 0),
      (v_question_id, '50-70%', true, 1),
      (v_question_id, '90-100%', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 8. Power output reduction
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At a given engine speed, by how much is the power output of a diesel engine reduced when it is powered with gas producer instead of straight diesel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'At a given engine speed, by how much is the power output of a diesel engine reduced when it is powered with gas producer instead of straight diesel?', 'single_choice', 'medium', 'Powering a diesel engine with gas producer at a given speed typically reduces its power output by about 10 to 20 percent compared to straight diesel operation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10-20%', true, 0),
      (v_question_id, '30-50%', false, 1),
      (v_question_id, '50-70%', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 9. Producer gas composition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which gases make up the main combustible components of producer gas?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which gases make up the main combustible components of producer gas?', 'single_choice', 'medium', 'Producer gas is composed mainly of carbon monoxide (CO), hydrogen (H2), and methane (CH4), which provide its combustible energy content.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'CO2 and CH4', false, 0),
      (v_question_id, 'CO, H2, and CH4', true, 1),
      (v_question_id, 'CO2 only', false, 2),
      (v_question_id, 'All of the above', false, 3);
  END IF;

  -- 10. Air needed in pyrolysis
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What amount of air, relative to the stoichiometric air requirement, is needed when pyrolyzing biomass?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What amount of air, relative to the stoichiometric air requirement, is needed when pyrolyzing biomass?', 'single_choice', 'medium', 'Pyrolysis of biomass is conducted with below 30 percent of the stoichiometric air requirement, since the process is meant to minimize combustion and favor char formation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Below 30% of stoichiometric air', true, 0),
      (v_question_id, '30 to 40% of stoichiometric air', false, 1),
      (v_question_id, 'Above 40% of stoichiometric air', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 11. Equivalence ratio for pyrolyzers
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the typical equivalence ratio used for pyrolyzers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the typical equivalence ratio used for pyrolyzers?', 'single_choice', 'hard', 'Pyrolyzers operate at an equivalence ratio of up to 0.2, reflecting the very limited air supplied during pyrolysis compared to gasification.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Up to 0.2', true, 0),
      (v_question_id, '0.2 - 0.4', false, 1),
      (v_question_id, '0.4 and above', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 12. Equivalence ratio for gasifiers
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the typical equivalence ratio range used for biomass gasifiers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the typical equivalence ratio range used for biomass gasifiers?', 'single_choice', 'medium', 'Biomass gasifiers are designed to operate at an equivalence ratio of 0.2 to 0.4, higher than that of pyrolyzers but still well below full stoichiometric combustion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0 - 0.2', false, 0),
      (v_question_id, '0.2 - 0.4', true, 1),
      (v_question_id, '0.4 and above', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 13. Airflow calculation (rice husk, 40 kg/hr)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gasifier consumes 40 kg per hour of rice husk fuel. If the stoichiometric air requirement of rice husk is 4.7 kg air per kg fuel and the gasifier operates at an equivalence ratio of 0.3, what airflow is required to gasify the fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gasifier consumes 40 kg per hour of rice husk fuel. If the stoichiometric air requirement of rice husk is 4.7 kg air per kg fuel and the gasifier operates at an equivalence ratio of 0.3, what airflow is required to gasify the fuel?', 'single_choice', 'hard', 'Required airflow equals fuel rate times stoichiometric air requirement times equivalence ratio: 40 kg/hr x 4.7 kg air/kg fuel x 0.3 = 56 kg of air per hour.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '56 kg of air per hour', true, 0),
      (v_question_id, '70 kg of air per hour', false, 1),
      (v_question_id, '86 kg of air per hour', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 14. Cause of channel formation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Channel formation at the fuel bed inside a gasifier reactor is basically the result of ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Channel formation at the fuel bed inside a gasifier reactor is basically the result of ____.', 'single_choice', 'medium', 'Channeling in the fuel bed is basically caused by a high superficial gas velocity through the char/fuel bed, which carves preferential flow paths through the bed.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'High superficial velocity', true, 0),
      (v_question_id, 'Overloading of fuel during operation', false, 1),
      (v_question_id, 'Reactor operating at a low temperature', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 15. Superficial velocity limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'To minimize channel formation inside the gasifier reactor, the superficial gas velocity in the char bed should not exceed ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'To minimize channel formation inside the gasifier reactor, the superficial gas velocity in the char bed should not exceed ____.', 'single_choice', 'hard', 'Keeping the superficial gas velocity in the char bed at or below 20 to 23 cm per second helps minimize channel formation inside the gasifier reactor.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8-9 cm/sec', false, 0),
      (v_question_id, '15-20 cm/sec', false, 1),
      (v_question_id, '20-23 cm/sec', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 16. Definition of gasification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the term for the conversion process of solid biomass into a combustible gaseous fuel through a thermo-chemical reaction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the term for the conversion process of solid biomass into a combustible gaseous fuel through a thermo-chemical reaction?', 'single_choice', 'easy', 'Gasification is the thermo-chemical conversion of solid biomass into a combustible gaseous fuel, namely producer gas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Digestion', false, 0),
      (v_question_id, 'Carbonization', false, 1),
      (v_question_id, 'Gasification', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 17. Primary gas produced
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the primary gas produced during the gasification of biomass?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the primary gas produced during the gasification of biomass?', 'single_choice', 'medium', 'Carbon monoxide is the primary gas produced during biomass gasification, forming the main combustible component of producer gas alongside hydrogen and methane.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Methane', false, 0),
      (v_question_id, 'Carbon dioxide', false, 1),
      (v_question_id, 'Carbon monoxide', true, 2),
      (v_question_id, 'All of the above', false, 3);
  END IF;

  -- 18. Corn cob airflow calculation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Corn cob fuel has a stoichiometric air requirement of 5.7 kg air per kg fuel. If 30 kg of corn cobs are burned per hour at an equivalence ratio of 0.25, how much air (in cubic meters per hour) is required for the system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Corn cob fuel has a stoichiometric air requirement of 5.7 kg air per kg fuel. If 30 kg of corn cobs are burned per hour at an equivalence ratio of 0.25, how much air (in cubic meters per hour) is required for the system?', 'single_choice', 'hard', 'Converting the required air mass flow (fuel rate x stoichiometric air requirement x equivalence ratio) to a volumetric airflow using standard air density gives a required airflow of approximately 34.2 cubic meters per hour.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30.68 m3/hr', false, 0),
      (v_question_id, '31.28 m3/hr', false, 1),
      (v_question_id, '34.2 m3/hr', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 19. Gasifier zone
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a gasifier reactor, in which zone does the actual gasification reaction take place?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a gasifier reactor, in which zone does the actual gasification reaction take place?', 'single_choice', 'medium', 'The reduction zone of the gasifier reactor is where the actual gasification reactions occur, producing combustible gases such as carbon monoxide and hydrogen.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drying zone', false, 0),
      (v_question_id, 'Distillation zone', false, 1),
      (v_question_id, 'Reduction zone', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 20. Gasification rate of rice hull
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The gasification rate of rice hull typically ranges from ____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The gasification rate of rice hull typically ranges from ____.', 'single_choice', 'medium', 'Rice hull is gasified at a specific gasification rate typically ranging from 110 to 210 kg per square meter per hour.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90-105 kg/m2-hr', false, 0),
      (v_question_id, '110-210 kg/m2-hr', true, 1),
      (v_question_id, '125-140 kg/m2-hr', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 21. Gasifier diameter calculation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier operates at a fuel rate of 20 kg per hour. If the designed specific gasification rate is 160 kg per hour per square meter, what reactor diameter is required for the gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier operates at a fuel rate of 20 kg per hour. If the designed specific gasification rate is 160 kg per hour per square meter, what reactor diameter is required for the gasifier?', 'single_choice', 'hard', 'The required reactor cross-sectional area equals the fuel rate divided by the specific gasification rate (20 kg/hr / 160 kg/hr-m2 = 0.125 m2); solving for the diameter of that circular cross-section gives a required gasifier diameter of about 0.39 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.20 m', false, 0),
      (v_question_id, '0.25 m', false, 1),
      (v_question_id, '0.39 m', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 22. Gasifier type for continuous rice husk operation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of gasifier is suitable for a rice husk gasifier operating in continuous mode?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of gasifier is suitable for a rice husk gasifier operating in continuous mode?', 'single_choice', 'medium', 'A moving-bed gasifier design is suitable for rice husk gasifiers intended to operate continuously, since fuel can be fed in and ash/char can be removed continuously as the bed moves.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fixed bed', false, 0),
      (v_question_id, 'Moving-bed', true, 1),
      (v_question_id, 'Fluidized bed', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 23. Engine suitable for biomass producer gas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type(s) of engine are suitable for fueling with biomass producer gas?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type(s) of engine are suitable for fueling with biomass producer gas?', 'single_choice', 'easy', 'Biomass producer gas can fuel gasoline engines, diesel engines (in dual-fuel mode), and gas engines, making all of these engine types suitable.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gasoline engine', false, 0),
      (v_question_id, 'Diesel engine', false, 1),
      (v_question_id, 'Gas engine', false, 2),
      (v_question_id, 'All of the above', true, 3);
  END IF;

END $$;
