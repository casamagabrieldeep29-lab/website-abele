-- Auto-generated from supabase/seed/content/boardexampro-vol1.json
-- Source reference: ABELE 1st Ed Vol I Answer Key.pdf
-- Idempotent: safe to re-run; skips topics/subtopics/questions that already exist.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Internal Combustion Engine (POWER_ENERGY_MACHINERY) — 11 question(s)
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
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Internal Combustion Engine', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In internal combustion engines, as distinct from external combustion engines, mechanical power is produced when the chemical energy of the fuel is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In internal combustion engines, as distinct from external combustion engines, mechanical power is produced when the chemical energy of the fuel is:', 'single_choice', 'medium', 'The defining feature of an internal combustion engine is that combustion takes place inside the work-producing part of the engine. The fuel-air mixture before combustion and the burned products after combustion serve as the actual working fluids, and work transfers occur directly between these fluids and the mechanical components of the engine.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'transferred to steam, which then drives a piston-in-cylinder expander', false, 0),
      (v_question_id, 'released by burning or oxidizing the fuel inside the engine', true, 1),
      (v_question_id, 'converted first to electrical energy before driving the crankshaft', false, 2),
      (v_question_id, 'released in a separate combustor and delivered to the cylinder by heat exchangers', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Typical values of compression ratio are 8 to 12 for spark-ignition engines, while for compression-ignition engines they are typically in the range of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Typical values of compression ratio are 8 to 12 for spark-ignition engines, while for compression-ignition engines they are typically in the range of:', 'single_choice', 'easy', 'Diesel compression ratios are much higher than typical SI engine values, in the range of 14 to 22, depending on the type of diesel engine and whether it is naturally aspirated or turbocharged. The high compression ratio produces air temperatures of about 900 K near the end of compression, sufficient for spontaneous ignition (autoignition) of the injected fuel.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 to 10', false, 0),
      (v_question_id, '10 to 14', false, 1),
      (v_question_id, '14 to 22', true, 2),
      (v_question_id, '24 to 30', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a four-stroke cycle engine, one power stroke per cylinder is completed for every:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a four-stroke cycle engine, one power stroke per cylinder is completed for every:', 'single_choice', 'easy', 'The four-stroke cycle requires, for each engine cylinder, four strokes of its piston—intake, compression, power (expansion), and exhaust—which corresponds to two revolutions of the crankshaft for each power stroke. Consequently, in four-stroke cycle engines, the camshaft turns at one-half the crankshaft speed.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'one revolution of the crankshaft', false, 0),
      (v_question_id, 'two revolutions of the crankshaft', true, 1),
      (v_question_id, 'three revolutions of the crankshaft', false, 2),
      (v_question_id, 'four revolutions of the crankshaft', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A key operating feature of the two-stroke cycle engine is that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A key operating feature of the two-stroke cycle engine is that:', 'single_choice', 'medium', 'The two-stroke cycle produces one power stroke every crankshaft revolution and scavenges the burned gases from the cylinder with fresh charge. However, the output does not double: two-stroke outputs range from only 20% to 60% above equivalent-size four-stroke units because of poorer than ideal charging efficiency—incomplete filling of the cylinder with fresh charge due to incomplete scavenging of the residual burned gases.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a power stroke occurs every crankshaft revolution, with fresh charge scavenging the burned gases', true, 0),
      (v_question_id, 'poppet valves are always required to control both intake and exhaust', false, 1),
      (v_question_id, 'its power output per unit displaced volume is exactly twice that of a four-stroke engine', false, 2),
      (v_question_id, 'the camshaft rotates at one-half the crankshaft speed', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The primary classifying feature of internal combustion engines is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The primary classifying feature of internal combustion engines is the:', 'single_choice', 'medium', 'Method of ignition—spark ignition or compression ignition—is selected as the primary classifying feature because from it follow the important characteristics of the fuel used, method of mixture preparation, method of load control, combustion chamber design, details of the combustion process, engine emissions, and operating characteristics.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'method of cooling', false, 0),
      (v_question_id, 'basic engine configuration', false, 1),
      (v_question_id, 'method of ignition', true, 2),
      (v_question_id, 'method of mixture preparation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Maximum brake-torque (MBT) timing in a spark-ignition engine is best described as the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Maximum brake-torque (MBT) timing in a spark-ignition engine is best described as the:', 'single_choice', 'medium', 'There is an optimum spark timing which, for a given in-cylinder mass of fuel, air, and residual, gives maximum torque; more advanced (earlier) or retarded (later) timing gives lower output. MBT timing is an empirical compromise between starting combustion too early in the compression stroke, when work transfer is too low to the cylinder gases, and completing combustion too late in the expansion stroke, which lowers peak expansion-stroke pressures.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'spark timing that produces the highest exhaust gas temperature', false, 0),
      (v_question_id, 'optimum spark timing which, for a given mass of fuel, air, and residual in the cylinder, gives maximum torque', true, 1),
      (v_question_id, 'most retarded timing at which the engine will still fire', false, 2),
      (v_question_id, 'timing at which combustion is completed exactly at top center', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In compression-ignition (diesel) engine operation, load control at a given engine speed is achieved by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In compression-ignition (diesel) engine operation, load control at a given engine speed is achieved by:', 'single_choice', 'medium', 'In diesel engines, air alone is drawn into the cylinder during intake, and load control is achieved by varying the amount of fuel injected each cycle. The airflow at a given engine speed is not directly controlled and, in naturally-aspirated engines, is essentially unchanged. This is fundamentally different from the naturally-aspirated SI engine, where intake airflow is reduced by throttling when the required power is below the maximum.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'throttling the intake airflow below atmospheric pressure', false, 0),
      (v_question_id, 'varying the spark discharge duration', false, 1),
      (v_question_id, 'varying the amount of fuel injected each cycle', true, 2),
      (v_question_id, 'changing the valve overlap period', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Spark-ignition engines designed for hybrid electric vehicle propulsion systems often employ a modified four-stroke cycle, called the Atkinson cycle, in which:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Spark-ignition engines designed for hybrid electric vehicle propulsion systems often employ a modified four-stroke cycle, called the Atkinson cycle, in which:', 'single_choice', 'medium', 'In the Atkinson cycle, the volume ratio used for expansion is higher than that used for compression, achieved through variable valve timing with late intake valve closing during compression and late exhaust valve opening during expansion. The greater effective expansion than compression increases engine efficiency, which is why the cycle is used in engines designed for hybrid electric vehicles.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'the volume ratio used for expansion is higher than the volume ratio for compression', true, 0),
      (v_question_id, 'the compression ratio is made higher than the expansion ratio', false, 1),
      (v_question_id, 'combustion occurs at constant pressure rather than constant volume', false, 2),
      (v_question_id, 'the exhaust stroke is eliminated entirely', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The device that increases engine output by compressing intake air using a compressor-turbine combination powered by energy available in the engine exhaust stream is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The device that increases engine output by compressing intake air using a compressor-turbine combination powered by energy available in the engine exhaust stream is the:', 'single_choice', 'easy', 'A turbocharger is a compressor-turbine combination that uses the energy available in the exhaust stream to provide, via the turbine, the power required to compress the intake air. By contrast, a supercharger is a compressor mechanically driven by the engine. The intercooler reduces the compressed air temperature to further increase its density, while the wastegate bypasses some of the exhaust gas flow to prevent the boost pressure from becoming too high.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'supercharger', false, 0),
      (v_question_id, 'turbocharger', true, 1),
      (v_question_id, 'intercooler', false, 2),
      (v_question_id, 'wastegate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Wankel rotary engine, as the triangular rotor makes one complete rotation, the eccentric shaft rotates through three revolutions and each chamber produces one power "stroke." Therefore, for each eccentric (output) shaft revolution there is/are:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the Wankel rotary engine, as the triangular rotor makes one complete rotation, the eccentric shaft rotates through three revolutions and each chamber produces one power "stroke." Therefore, for each eccentric (output) shaft revolution there is/are:', 'single_choice', 'hard', 'Each of the three chambers defined by the rotor surfaces undergoes the full four-stroke sequence once per rotor revolution, giving three power pulses per rotor revolution. Since the eccentric shaft rotates three times for each rotor revolution, there is one torque pulse for each eccentric (output) shaft revolution. The Wankel''s attractive features are its compactness, higher engine speed, and inherent balance and smoothness, offset by higher heat transfer and gas sealing and leakage problems.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'one torque pulse', true, 0),
      (v_question_id, 'two torque pulses', false, 1),
      (v_question_id, 'three torque pulses', false, 2),
      (v_question_id, 'six torque pulses', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A diesel fuel''s ability to spontaneously ignite fast enough within the developing fuel sprays to initiate combustion at the desired point in the engine cycle is defined by its:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A diesel fuel''s ability to spontaneously ignite fast enough within the developing fuel sprays to initiate combustion at the desired point in the engine cycle is defined by its:', 'single_choice', 'easy', 'The cetane number compares the autoignition characteristics of a diesel fuel with those of defined reference fuels. Typical cetane numbers are in the 40 to 55 range; the higher the cetane number, the easier and more rapid the autoignition in the engine around top center, just after injection starts. The octane number and antiknock index, in contrast, characterize a gasoline''s resistance to knock in spark-ignition engines.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'octane number', false, 0),
      (v_question_id, 'cetane number', true, 1),
      (v_question_id, 'flash point', false, 2),
      (v_question_id, 'antiknock index', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Fuels and Lubricants (POWER_ENERGY_MACHINERY) — 17 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Fuels and Lubricants' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Fuels and Lubricants', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A naturally occurring hydrocarbon gas mixture consisting primarily of methane, with other hydrocarbons, carbon dioxide, nitrogen, and hydrogen sulfide';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A naturally occurring hydrocarbon gas mixture consisting primarily of methane, with other hydrocarbons, carbon dioxide, nitrogen, and hydrogen sulfide', 'single_choice', 'easy', 'Crude Oil is a naturally occurring flammable liquid consisting of a complex mixture of hydrocarbons with various molecular weights and of other liquid organic compounds found in geologic formation beneath the earth''s surface. Natural Gas is a naturally occurring hydrocarbon gas mixture consisting primarily of methane, with other hydrocarbons, carbon dioxide, nitrogen, and hydrogen sulfide. LPG is a flammable mixture of hydrocarbon gases used as fuel in heating appliances and vehicles, consisting of propane and butane. Coal is a combustible black or brownish-black sedimentary rock usually occurring in rock strata in layers or veins called coal beds or coal seams.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Natural Gas', true, 0),
      (v_question_id, 'LPG', false, 1),
      (v_question_id, 'Coal', false, 2),
      (v_question_id, 'Crude Oil', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are derived from crude oil except';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The following are derived from crude oil except', 'single_choice', 'easy', 'Gasoline, kerosene, and diesel are all derived from crude oil. Other petroleum products from crude oil include naphtha (used to make polymers and resins from ethylene and propylene), waxes, and lubricating oils. Biofuel is a renewable fuel which is derived from biological carbon fixation.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Naptha', false, 0),
      (v_question_id, 'Gasoline', false, 1),
      (v_question_id, 'Diesel', false, 2),
      (v_question_id, 'Biofuel', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A synthetic fuel used as a substitute for petroleum. It is extracted from biomass by subjecting the reactor to a high temperature of about 500°C and subsequently cooled.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A synthetic fuel used as a substitute for petroleum. It is extracted from biomass by subjecting the reactor to a high temperature of about 500°C and subsequently cooled.', 'single_choice', 'medium', 'Bioethanol – an alcohol made by fermentation of carbohydrates produced in sugar and starch from crops such as corn, sugar cane and cassava. Biodiesel - made from vegetable oil and animal fats; usually used as a diesel additive to reduce particulates, carbon monoxide, and hydrocarbon from diesel-powered vehicles. Bio-oil (also called pyrolysis oil or biocrude) – a synthetic fuel used as a substitute for petroleum, extracted from biomass by subjecting the reactor to a high temperature of about 500°C and subsequently cooled. [FLAGGED FOR REVIEW: The source''s own explanation describes the correct answer, Bio-oil, as ''also called pyrolysis oil or biocrude'' — yet ''Biocrude'' is listed as a separate, incorrect choice (A). This is an internal naming inconsistency in the source; the highlighted answer (D, Bio-oil) was kept as-is.]', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Biocrude', false, 0),
      (v_question_id, 'Biodiesel', false, 1),
      (v_question_id, 'Bioethanol', false, 2),
      (v_question_id, 'Bio-oil', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gaseous fuel produced by burning fuel at around 900°C with limited air, resulting in a gas rich in carbon monoxide, hydrogen, and methane that burns with a light-blue to pinkish flame?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A gaseous fuel produced by burning fuel at around 900°C with limited air, resulting in a gas rich in carbon monoxide, hydrogen, and methane that burns with a light-blue to pinkish flame?', 'single_choice', 'medium', 'Biogas – gas produced by the breakdown of organic matter in the absence of oxygen, using materials like dead plants and animals, animal feces, and kitchen waste as feedstock. Synthetic gas – when the fuel is gasified using pure oxygen, the gas is called synthetic gas.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Biogas', false, 0),
      (v_question_id, 'Producer Gas', true, 1),
      (v_question_id, 'Synthetic Gas', false, 2),
      (v_question_id, 'LPG', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following statements are correct?
I. Solid fuels are relatively higher cost compared with liquid fuels
II. Solid fuels have high production cost.
III. Liquid fuels possess higher calorific value per unit mass
IV. Gaseous fuels are highly inflammable with high chances of fire hazard.
V. Gaseous fuels need large storage tanks.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following statements are correct?
I. Solid fuels are relatively higher cost compared with liquid fuels
II. Solid fuels have high production cost.
III. Liquid fuels possess higher calorific value per unit mass
IV. Gaseous fuels are highly inflammable with high chances of fire hazard.
V. Gaseous fuels need large storage tanks.', 'single_choice', 'medium', 'Liquid fuels are relatively higher cost compared with solid fuels. Solid fuels have low production cost.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'III and IV', false, 0),
      (v_question_id, 'I, II, and V', false, 1),
      (v_question_id, 'III, IV, and V', true, 2),
      (v_question_id, 'I and II', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The degree API of gasoline with a specific gravity of 0.69 is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The degree API of gasoline with a specific gravity of 0.69 is', 'single_choice', 'hard', 'Using the formula, °API = (141.5 / SG) - 131.5, where SG = Specific Gravity (at 15°C). °API = (141.5 / 0.69) - 131.5 = 205.07246 - 131.5 = 73.57°', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '73.57°', true, 0),
      (v_question_id, '14.49°', false, 1),
      (v_question_id, '336.57°', false, 2),
      (v_question_id, '229.14°', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The specific gravity of a liquid with a degree API of 10 is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The specific gravity of a liquid with a degree API of 10 is', 'single_choice', 'hard', '°API = (141.5 / SG) - 131.5 at API = 10. 10 = (141.5 / SG) - 131.5, 10 + 131.5 = (141.5 / SG), SG = (141.5 / 141.5), SG = 1.00 (API gravity of water)', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.068', false, 0),
      (v_question_id, '1.037', false, 1),
      (v_question_id, '1.014', false, 2),
      (v_question_id, '1.00', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following statements are correct?
I. Adding alcohol to gasoline raises the octane rating of the fuel.
II. Alcohol added to gasoline emits no soot or odor in the engine.
III. Adding alcohol to gasoline burns without producing smoke or disagreeable odor.
IV. When alcohol is added to gasoline, the exhaust is free of nitrogen oxides without special clean up device.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following statements are correct?
I. Adding alcohol to gasoline raises the octane rating of the fuel.
II. Alcohol added to gasoline emits no soot or odor in the engine.
III. Adding alcohol to gasoline burns without producing smoke or disagreeable odor.
IV. When alcohol is added to gasoline, the exhaust is free of nitrogen oxides without special clean up device.', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'I, III, and IV', false, 0),
      (v_question_id, 'II and IV', false, 1),
      (v_question_id, 'I, II, III and IV', true, 2),
      (v_question_id, 'III and IV', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the temperature at which oil just ceases to flow.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'It is the temperature at which oil just ceases to flow.', 'single_choice', 'easy', 'Flash Point: The flash point of a volatile material is the lowest temperature at which vapors of the material will ignite when given an ignition source. Fire Point: The fire point of a fuel is the lowest temperature at which the vapor of the fuel will continue to burn for at least 5 seconds after ignition by an open flame. Cloud Point: Cloud point is the temperature at which oil becomes cloudy or hazy when oil is cooled at a specified rate. Pour Point: It is the temperature at which oil just ceases to flow. The pour point of the liquid is the lowest temperature at which it becomes semi-solid and loses its flow characteristics.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flash point', false, 0),
      (v_question_id, 'Fire Point', false, 1),
      (v_question_id, 'Pour Point', true, 2),
      (v_question_id, 'Cloud Point', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gasoline produced from distillation of crude oil.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A gasoline produced from distillation of crude oil.', 'single_choice', 'easy', 'Natural gas gasoline - is manufactured from the gas that is taken from oil well or is obtained from the distillation of crude oil. Straight-run gasoline or raw gasoline - is produced from distillation of crude oil. Cracked gasoline - is manufactured from heavier distillation fraction, particularly gas oil. Blended gasoline - consists of all types of natural raw or cracked gasoline and are mixed together in the refining process.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Natural gas', false, 0),
      (v_question_id, 'Straight-run', true, 1),
      (v_question_id, 'Cracked', false, 2),
      (v_question_id, 'Blended', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It occurs when too little air is supplied into the fuel resulting in the production of unburned carbon, which forms CO instead of CO2.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'It occurs when too little air is supplied into the fuel resulting in the production of unburned carbon, which forms CO instead of CO2.', 'single_choice', 'medium', 'Partial Premix - Premixed flames with non-uniform fuel oxidizing mixtures. Diffusion - Fuel and air enter process separately and are mixed at the flame front itself either through random molecular motion or turbulent eddies. Detonation - It occurs in the process of combustion of the mixture within the cylinder after ignition takes place in high compression engine.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Incomplete', true, 0),
      (v_question_id, 'Detonation', false, 1),
      (v_question_id, 'Diffusion', false, 2),
      (v_question_id, 'Partial Premix', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are the methods to control detonation, except:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The following are the methods to control detonation, except:', 'single_choice', 'medium', 'Reducing or eliminating carbon deposits (controls detonation), not increasing them.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Using cylinder head and piston materials such as aluminum alloys that provide more heat dissipation', false, 0),
      (v_question_id, 'Using properly designed spark plugs and locating it on the "hot region" preferably near the exhaust valve.', false, 1),
      (v_question_id, 'Using especially treated or so called "doped" or antiknock fuels', false, 2),
      (v_question_id, 'Increasing carbon deposits.', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is defined as the ratio between the energy released by the burnt fuel and the theoretical energy content of the fuel mass during one complete engine cycle.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'It is defined as the ratio between the energy released by the burnt fuel and the theoretical energy content of the fuel mass during one complete engine cycle.', 'single_choice', 'medium', 'Fuel Conversion Efficiency - It is defined as the ratio between the useful mechanical work produced by the engine and the theoretical energy content of the fuel mass. Thermal Conversion Efficiency - It is defined as the ratio between the work per cycle Wc [J] and the energy released by the burnt fuel.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Combustion Efficiency', true, 0),
      (v_question_id, 'Thermal conversion efficiency', false, 1),
      (v_question_id, 'Fuel conversion efficiency', false, 2),
      (v_question_id, 'Lower Heating Value', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which air-fuel ratio corresponds to a condition with excess air, making the mixture too lean to burn in a spark ignition engine??';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which air-fuel ratio corresponds to a condition with excess air, making the mixture too lean to burn in a spark ignition engine??', 'single_choice', 'medium', 'The combustible range for SI engine is between 7:1 to 20:1. If the air-fuel ratio is less than 7:1, the mixture is too rich to burn. On the other hand, if the air-fuel ratio is more than 20:1, the mixture is too lean to burn.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5:1', false, 0),
      (v_question_id, '7:1', false, 1),
      (v_question_id, '15:1', false, 2),
      (v_question_id, '24:1', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It retards the tendency of oil to thicken as temperature drops.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'It retards the tendency of oil to thicken as temperature drops.', 'single_choice', 'medium', 'Pour-point depressants - An engine oil additive which lowers the temperature at which oil will pour or flow. Detergents - An engine oil additive which cleans the engine of carbon and gums. Antiwear Agent - It is used to form lubricating films strong enough to carry the load imposed to the engine.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Detergents', false, 0),
      (v_question_id, 'Antiwear Agent', false, 1),
      (v_question_id, 'Viscosity-Index Improvers', true, 2),
      (v_question_id, 'Pour-point depressants', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Oil classification system which identifies engine oil quality and performance standards.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Oil classification system which identifies engine oil quality and performance standards.', 'single_choice', 'medium', 'SAE Viscosity Classification - Oil grading system based upon viscosity grade of engine oil taken at 0 and 210oF which indicates how the oil flows at cold and hot temperatures.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'SAE Viscosity Classification', false, 0),
      (v_question_id, 'API Engine-Oil Service Classification', true, 1),
      (v_question_id, 'ACEA Engine Oil Specifications', false, 2),
      (v_question_id, 'ILSAC Oil Rating', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are correct about SAE 5W-30 and SAE 15W-40, except:
I. Both are multigrade oil.
II. SAE 15W-40 easily flows at cold temperature compared to SAE 5W-30.
III. SAE 5W-30 is slightly thinner at higher temperature than SAE 15W-40
IV. SAE 15W-40 is slightly thicker in cold weather, while SAE 5W-30 is thinner.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The following are correct about SAE 5W-30 and SAE 15W-40, except:
I. Both are multigrade oil.
II. SAE 15W-40 easily flows at cold temperature compared to SAE 5W-30.
III. SAE 5W-30 is slightly thinner at higher temperature than SAE 15W-40
IV. SAE 15W-40 is slightly thicker in cold weather, while SAE 5W-30 is thinner.', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'II and III', false, 0),
      (v_question_id, 'II only', true, 1),
      (v_question_id, 'III only', false, 2),
      (v_question_id, 'III and IV', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Hydrology (LAND_WATER) — 25 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Hydrology' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Hydrology', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hydrologic process governed by chance and whose time series is INDEPENDENT.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A hydrologic process governed by chance and whose time series is INDEPENDENT.', 'single_choice', 'medium', 'A deterministic process follows a definite law of certainty. A probabilistic process is governed by chance and treats the time series as independent, while a stochastic process is governed by chance but is time-dependent. Most hydrologic processes are stochastic in nature, but the probabilistic assumption is adopted for simplicity when analyzing hydrologic data.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stochastic', false, 0),
      (v_question_id, 'Probabilistic', true, 1),
      (v_question_id, 'Deterministic', false, 2),
      (v_question_id, 'Hypergeometric', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Quite uniform precipitation with drops less than 0.5 mm in diameter.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Quite uniform precipitation with drops less than 0.5 mm in diameter.', 'single_choice', 'easy', 'Drizzle is a light, steady rain of fine drops smaller than 0.5 mm falling at an intensity below 1 mm/hr. Rain consists of larger condensed drops greater than 0.5 mm (up to about 6-7 mm), snow is ice crystals formed by sublimation, and sleet forms when raindrops are falling through air having a temperature below freezing.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rain', false, 0),
      (v_question_id, 'Drizzle', true, 1),
      (v_question_id, 'Snow', false, 2),
      (v_question_id, 'Sleet', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 217:2017, the water level for the Class A Pan and Colorado Sunken Pan must be';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In PAES 217:2017, the water level for the Class A Pan and Colorado Sunken Pan must be', 'single_choice', 'medium', 'PAES 217:2017 specifies that the water surface in both the Class A evaporation pan and the Colorado sunken pan is maintained at 5 to 7.5 cm below the rim to standardize pan evaporation readings.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.5 - 5 cm below the rim', false, 0),
      (v_question_id, '5 - 7.5 cm below the rim', true, 1),
      (v_question_id, '7.5 - 10 cm below the rim', false, 2),
      (v_question_id, '3 - 5 cm below the rim', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A computer-aided method wherein it averages estimated precipitation at all points of a superimposed grid.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A computer-aided method wherein it averages estimated precipitation at all points of a superimposed grid.', 'single_choice', 'medium', 'In the grid-point method, a grid is superimposed over the basin map, precipitation is estimated at every grid node (commonly by distance weighting from nearby gauges), and the areal average is taken over all grid points. It is well suited to computerized computation.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Thiessen method', false, 0),
      (v_question_id, 'Grid-point method', true, 1),
      (v_question_id, 'Isohyetal method', false, 2),
      (v_question_id, 'Inverse distance ratio method', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Standard diameter of a rain gauge.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Standard diameter of a rain gauge.', 'single_choice', 'easy', 'The standard non-recording rain gauge is a vertical cylindrical container with a top opening 203 mm (8 inches, or roughly 0.67 ft) in diameter. The inner measuring tube has one-tenth of the cross-sectional area of the catch opening, which magnifies the reading for accurate depth measurement.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '203 mm', false, 0),
      (v_question_id, '8 in', false, 1),
      (v_question_id, '0.67 ft', false, 2),
      (v_question_id, 'All of the above', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The method presumably considered as the most accurate in determining depth of rainfall.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The method presumably considered as the most accurate in determining depth of rainfall.', 'single_choice', 'medium', 'The isohyetal method is regarded as the most accurate areal rainfall method because the analyst draws lines of equal rainfall (isohyets) that can account for orographic effects and storm patterns, rather than relying on purely geometric weights as in the Thiessen or arithmetic mean methods.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Arithmetic average', false, 0),
      (v_question_id, 'Thiessen method', false, 1),
      (v_question_id, 'Isohyetal method', true, 2),
      (v_question_id, 'Mass transfer method', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 217:2017, which of the following is a correct description for constructing a Class A pan?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In PAES 217:2017, which of the following is a correct description for constructing a Class A pan?', 'single_choice', 'medium', 'The Class A pan is 25 cm deep (with a diameter of 120.7 cm). The other statements are incorrect: the pan is mounted on a wooden frame platform 15 cm above the ground, the water is renewed at least weekly, and a galvanized pan is painted annually with aluminum paint — black tar paint is used for the Colorado sunken pan.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mounted on a wooden pen frame platform 20 cm above ground level', false, 0),
      (v_question_id, 'Water is regularly renewed at least monthly', false, 1),
      (v_question_id, 'If galvanized, painted annually with black tar paint', false, 2),
      (v_question_id, 'It has a depth of 25 cm', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rainfall more or less evenly distributed throughout the year.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Rainfall more or less evenly distributed throughout the year.', 'single_choice', 'medium', 'Under the Modified Coronas classification, Type IV climate has rainfall more or less evenly distributed through the year. Areas include Batanes, north-eastern Luzon, western Camarines Norte and Camarines Sur, Albay, eastern Mindoro, Marinduque, western Leyte, northern Negros, and most of central, eastern and southern Mindanao. (PAES 217)', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type I', false, 0),
      (v_question_id, 'Type II', false, 1),
      (v_question_id, 'Type III', false, 2),
      (v_question_id, 'Type IV', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 217:2017, what velocity of wind is felt on the face and makes leaves start to rustle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In PAES 217:2017, what velocity of wind is felt on the face and makes leaves start to rustle?', 'single_choice', 'medium', 'At about 2 m/s, wind is felt on the face and leaves start to rustle. At 5 m/s, twigs move, paper blows away and flags fly; at 8 m/s, dust rises and small branches move; beyond 8 m/s, small trees start to sway and waves form on inland waters.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 m/s', true, 0),
      (v_question_id, '5 m/s', false, 1),
      (v_question_id, '8 m/s', false, 2),
      (v_question_id, '> 8 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Air is lifted through horizontal convergence of the inflow into a low-pressure area.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Air is lifted through horizontal convergence of the inflow into a low-pressure area.', 'single_choice', 'medium', 'Cyclonic precipitation is associated with air mass movement from high- to low-pressure regions and is subdivided into two kinds. Non-frontal precipitation results when air is lifted by horizontal convergence of inflow into a low-pressure area, while frontal precipitation results from the lifting of warm air over cold air at the contact zone (front) between air masses of different characteristics.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cyclonic', false, 0),
      (v_question_id, 'Convective', false, 1),
      (v_question_id, 'Non-frontal', true, 2),
      (v_question_id, 'Frontal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the basic data used in designing the capacity of a reservoir of a dam for storing annual needs of the crops. It is also used to determine the area that could be planted to different crops at a given time.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'It is the basic data used in designing the capacity of a reservoir of a dam for storing annual needs of the crops. It is also used to determine the area that could be planted to different crops at a given time.', 'single_choice', 'medium', 'Actual crop evapotranspiration reflects the water actually consumed by the crop under prevailing field conditions (soil water level, salinity, field size, and related factors). Because it represents real consumptive use, it is the basic data for sizing reservoir storage for annual crop needs and for determining the plantable area at a given time.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Actual crop evapotranspiration', true, 0),
      (v_question_id, 'Reference crop evapotranspiration', false, 1),
      (v_question_id, 'Seasonal water requirement', false, 2),
      (v_question_id, 'Crop water requirement', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Given: crop – corn; crop coefficient – 0.6; month – July; latitude – 41.5°N; average monthly temperature – 23.9°C; average monthly percentage of daytime hours of the year for July – 10.32%. Compute the monthly consumptive use.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Given: crop – corn; crop coefficient – 0.6; month – July; latitude – 41.5°N; average monthly temperature – 23.9°C; average monthly percentage of daytime hours of the year for July – 10.32%. Compute the monthly consumptive use.', 'single_choice', 'hard', 'Using the Blaney–Criddle formula U = K × t × p / 100 (with t in °F and U in inches per month): t = 23.9°C = 75.02°F, so U = [0.6 × 75.02°F × 10.32]/100 = 4.65 in ≈ 118 mm for the month of July.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '98 mm', false, 0),
      (v_question_id, '104 mm', false, 1),
      (v_question_id, '118 mm', true, 2),
      (v_question_id, '124 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'So far gives the best fit for most stations for 1-week, 2-week, 3-week and monthly rainfall totals of the country.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'So far gives the best fit for most stations for 1-week, 2-week, 3-week and monthly rainfall totals of the country.', 'single_choice', 'hard', 'Among the common frequency distributions, the gamma density function has so far given the best fit for most Philippine stations for weekly to monthly rainfall totals. The normal distribution suits roughly symmetric data, the log-normal handles skewed data, and Pearson Type III (of which log-normal is a special case) considers the skewness of log-transformed data and is preferred for flood flow frequency analysis.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Normal', false, 0),
      (v_question_id, 'Log-normal', false, 1),
      (v_question_id, 'Pearson Type III', false, 2),
      (v_question_id, 'Gamma density function', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 217:2017, what is the standard diameter of a Class A pan?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In PAES 217:2017, what is the standard diameter of a Class A pan?', 'single_choice', 'easy', 'The Class A evaporation pan has a standard diameter of 120.7 cm and a depth of 25 cm, mounted on a wooden frame platform 15 cm above the ground.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 cm', false, 0),
      (v_question_id, '92 cm', false, 1),
      (v_question_id, '46 cm', false, 2),
      (v_question_id, '120.7 cm', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Associated with the movement of air masses from high-pressure to low-pressure regions.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Associated with the movement of air masses from high-pressure to low-pressure regions.', 'single_choice', 'medium', 'Cyclonic precipitation is caused by air converging from high-pressure toward low-pressure regions (e.g., cyclones). Convective precipitation is caused by the rising of warmer, lighter air within colder, denser surroundings (local thunderstorms), while orographic precipitation results from mechanical lifting of an air mass over mountain barriers.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cyclonic', true, 0),
      (v_question_id, 'Convective', false, 1),
      (v_question_id, 'Orographic', false, 2),
      (v_question_id, 'Frontal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is used primarily for remotely measuring rainfall. The caught rainfall is funneled from the collector through a small spout to a mechanism consisting of two small buckets.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'It is used primarily for remotely measuring rainfall. The caught rainfall is funneled from the collector through a small spout to a mechanism consisting of two small buckets.', 'single_choice', 'medium', 'In a tipping bucket rain gage, rainfall drains through a funnel into one of a pair of balanced buckets; each tip corresponds to a fixed rainfall amount, and the number of tips is recorded. Both rain rate and accumulated rainfall can therefore be measured remotely. The weighing gage records the weight of collected water over time, while the float gage uses a pen actuated by a float, producing a mass diagram.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Non-recording rain gage', false, 0),
      (v_question_id, 'Tipping bucket rain gage', true, 1),
      (v_question_id, 'Float rain gage', false, 2),
      (v_question_id, 'Weighing rain gage', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following provinces has a Type II Climate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following provinces has a Type II Climate?', 'single_choice', 'medium', 'Type II climate (no dry season, very pronounced maximum rainfall from November to January) covers Catanduanes, Sorsogon, the eastern part of Albay, eastern and northern Camarines Norte, a great portion of eastern Quezon, the eastern parts of Leyte and Samar, and a large portion of eastern Mindanao.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mindoro and Negros', false, 0),
      (v_question_id, 'Eastern Samar and Sorsogon', true, 1),
      (v_question_id, 'Northern Mindanao and Masbate', false, 2),
      (v_question_id, 'Batanes and Albay', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For rolling areas and non-uniform distribution of gages, a distance factor fixed by the location of gages is used for analysis using this method.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'For rolling areas and non-uniform distribution of gages, a distance factor fixed by the location of gages is used for analysis using this method.', 'single_choice', 'medium', 'The inverse distance ratio method weights each gage''s rainfall by the inverse of its distance (or distance squared) from the point of estimate. This makes it suitable for rolling terrain and irregularly distributed gage networks where simple averaging or fixed polygons would misrepresent the areal rainfall.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Thiessen method', false, 0),
      (v_question_id, 'Arithmetic mean', false, 1),
      (v_question_id, 'Inverse distance ratio method', true, 2),
      (v_question_id, 'Isohyetal method', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The average rainfall over the area is estimated as the area-weighted average for all polygons.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The average rainfall over the area is estimated as the area-weighted average for all polygons.', 'single_choice', 'medium', 'In the Thiessen polygon method, the basin is divided into polygons such that every point in a polygon is nearer to its gage than to any other. The areal rainfall is then computed as the weighted average of gage catches, with each gage weighted by its polygon area.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Thiessen method', true, 0),
      (v_question_id, 'Arithmetic mean', false, 1),
      (v_question_id, 'Grid-point method', false, 2),
      (v_question_id, 'Isohyetal method', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rate of evapotranspiration equal to or smaller than predicted ETcrop as affected by the level of available soil water, salinity, field size, or other causes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Rate of evapotranspiration equal to or smaller than predicted ETcrop as affected by the level of available soil water, salinity, field size, or other causes.', 'single_choice', 'medium', 'Actual crop ET is the evapotranspiration under real, non-standard field conditions, so it is equal to or smaller than the predicted crop ET. Crop ET (ETc) assumes a disease-free, well-fertilized crop under optimum soil water achieving full production (ETc = ETo × Kc), while actual ET further applies a stress coefficient (ETc adj = ETo × Kc × Ks). Reference crop ET (ETo) is the rate from a hypothetical well-watered grass reference surface with a fixed surface resistance of 70 s/m and an albedo of 0.23; pan evaporation is the rate of water loss from an open pan surface.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Crop evapotranspiration', false, 0),
      (v_question_id, 'Reference crop evapotranspiration', false, 1),
      (v_question_id, 'Pan evaporation', false, 2),
      (v_question_id, 'Actual crop evapotranspiration', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'No dry season with a very pronounced maximum rainfall from November to January.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'No dry season with a very pronounced maximum rainfall from November to January.', 'single_choice', 'medium', 'Type II climate has no dry season and a very pronounced maximum rain period from November to January. This is characteristic of areas along the eastern seaboard that are directly exposed to the northeast monsoon (Amihan) and Pacific weather systems.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type I', false, 0),
      (v_question_id, 'Type II', true, 1),
      (v_question_id, 'Type III', false, 2),
      (v_question_id, 'Type IV', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The orifice of the gage should be situated approximately ______ above the ground surface.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The orifice of the gage should be situated approximately ______ above the ground surface.', 'single_choice', 'medium', 'A rain gage should be located on a flat area with its opening oriented so rainfall is measured as depth over a flat surface. As a guideline, the gage orifice is set approximately 1 m above the ground; if a shielding vane is used, its top should be only about 1 cm above the receiver funnel.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 cm', false, 0),
      (v_question_id, '1 m', true, 1),
      (v_question_id, '1.5 m', false, 2),
      (v_question_id, '2 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Allows for continuous measurements of rainfall amounts, which can then be used to determine the time duration, intensity, and amount of rainfall for a storm event, as well as the total rainfall amount in any time period.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Allows for continuous measurements of rainfall amounts, which can then be used to determine the time duration, intensity, and amount of rainfall for a storm event, as well as the total rainfall amount in any time period.', 'single_choice', 'medium', 'A recording rain gage automatically records the collected precipitation as a function of time, allowing storm duration, intensity, and accumulated depth to be determined. Non-recording (manual) gages, including the storage type, only give totals between readings; tipping-bucket, weighing, float, capacitance, and optical gages are specific kinds of recording gages.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Non-recording rain gage', false, 0),
      (v_question_id, 'Storage rain gage', false, 1),
      (v_question_id, 'Recording rain gage', true, 2),
      (v_question_id, 'Float rain gage', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'No pronounced season, relatively dry from November to April and wet during the rest of the year.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'No pronounced season, relatively dry from November to April and wet during the rest of the year.', 'single_choice', 'medium', 'Type III climate has seasons that are not very pronounced — relatively dry from November to April and wet for the rest of the year. It covers the western Mountain Province, southern Quezon, the Bondoc Peninsula, Masbate, Romblon, northeast Panay, eastern Negros, central and southern Cebu, part of northern Mindanao, and most of eastern Palawan.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type I', false, 0),
      (v_question_id, 'Type II', false, 1),
      (v_question_id, 'Type III', true, 2),
      (v_question_id, 'Type IV', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following provinces has a Type I Climate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following provinces has a Type I Climate?', 'single_choice', 'medium', 'Type I climate covers the western portions of Luzon, Mindoro, Negros, and Palawan — areas sheltered from the northeast monsoon but fully exposed to the southwest monsoon (Habagat), hence dry from November to April and wet the rest of the year. Marinduque is Type IV, Romblon is Type III, and Catanduanes is Type II.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Marinduque', false, 0),
      (v_question_id, 'Romblon', false, 1),
      (v_question_id, 'Catanduanes', false, 2),
      (v_question_id, 'Palawan', true, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Soil and Water Conservation Engineering (LAND_WATER) — 17 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Soil and Water Conservation Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Soil and Water Conservation Engineering', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fraction of sheet and rill erosion that actually reaches the reference point of discharge.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Fraction of sheet and rill erosion that actually reaches the reference point of discharge.', 'single_choice', 'medium', 'The sediment delivery ratio is the ratio of the sediment yield measured at a reference point (such as the watershed outlet) to the gross erosion produced upslope. The runoff coefficient, in contrast, is the ratio of runoff depth to the precipitation depth that produced it.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Runoff coefficient', false, 0),
      (v_question_id, 'Sediment delivery ratio', true, 1),
      (v_question_id, 'Sediment coefficient', false, 2),
      (v_question_id, 'Erosion delivery ratio', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A practical adaptation of reforestation whereby the species planted have economic value, such as mango, pili, and so on.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A practical adaptation of reforestation whereby the species planted have economic value, such as mango, pili, and so on.', 'single_choice', 'medium', 'Among the vegetative erosion control measures, agroforestry is a practical adaptation of reforestation in which the trees planted have economic value (e.g., mango, pili). Reforestation proper is the replanting of forest tree species in the watershed, strip cropping grows different crops in alternate strips across the slope, and contour cultivation performs field operations nearly on the contour to slow overland flow.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agronomy', false, 0),
      (v_question_id, 'Contour cultivation', false, 1),
      (v_question_id, 'Strip cropping', false, 2),
      (v_question_id, 'Agroforestry', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Considered as the state-of-the-art soil erosion prediction technology.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Considered as the state-of-the-art soil erosion prediction technology.', 'single_choice', 'hard', 'The Water Erosion Prediction Project (WEPP) model, developed by USDA-ARS, is a process-based, continuous-simulation model that computes infiltration, runoff, soil detachment, transport, and deposition along a hillslope. Because it models the actual erosion processes rather than relying on empirical lumped factors like USLE/RUSLE, it is regarded as the state-of-the-art erosion prediction technology.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The WEPP Model', true, 0),
      (v_question_id, 'RUSLE', false, 1),
      (v_question_id, 'MUSLE', false, 2),
      (v_question_id, 'USLE', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Terraces are used to provide erosion control by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Terraces are used to provide erosion control by', 'single_choice', 'medium', 'A terrace intercepts runoff partway down the hillside, cutting the continuous slope into shorter segments — in USLE terms, it reduces the slope length factor (L). The graded broad-based terrace, for instance, reduces slope length and conducts the intercepted runoff to an outlet at non-erosive velocity.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reducing slope steepness', false, 0),
      (v_question_id, 'Reducing slope length', true, 1),
      (v_question_id, 'Reducing rainfall impact', false, 2),
      (v_question_id, 'Increasing factor P', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is not a purpose of terracing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is not a purpose of terracing?', 'single_choice', 'medium', 'The functions of terracing are to reduce sheet and rill erosion, prevent gully formation, and conserve moisture; by detaining and safely conveying runoff, terraces also contribute to runoff and flood control at the field scale. Rejuvenating soil fertility is not a function of terracing. Fertility is addressed by agronomic measures such as cropping systems and fertilization.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reduce soil erosion', false, 0),
      (v_question_id, 'Water conservation', false, 1),
      (v_question_id, 'Flood control', false, 2),
      (v_question_id, 'Soil fertility rejuvenation', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A term adapted to measures utilizing both or in combination with the biological and engineering measures.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A term adapted to measures utilizing both or in combination with the biological and engineering measures.', 'single_choice', 'hard', 'Vengineering (from vegetative + engineering) is the term adapted for erosion control measures that combine biological/vegetative measures with engineering measures. For example, a structural measure stabilized with vegetation.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drop structures', false, 0),
      (v_question_id, 'Conservation structures', false, 1),
      (v_question_id, 'Intake structures', false, 2),
      (v_question_id, 'Vengineering', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Alternate planting of different crops on successive planting seasons.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Alternate planting of different crops on successive planting seasons.', 'single_choice', 'medium', 'Crop rotation is planting different crops one after the other, season after season, on the same field. It differs from multiple or mixed cropping, where different crops are planted simultaneously in the same field and season, and from strip cropping, where different crops occupy alternate strips across the slope at the same time.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stripcropping', false, 0),
      (v_question_id, 'Crop rotation', true, 1),
      (v_question_id, 'Intercropping', false, 2),
      (v_question_id, 'Multiple cropping', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The depth of water in inches to be removed in a 24-hour period from the drainage area.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The depth of water in inches to be removed in a 24-hour period from the drainage area.', 'single_choice', 'medium', 'The drainage coefficient is defined as the depth of water, in inches, to be removed from the drainage area within 24 hours (expressed in inches per day). It is the basic design parameter for sizing the capacity of surface and subsurface drainage systems.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Effective depth', false, 0),
      (v_question_id, 'Drainage coefficient', true, 1),
      (v_question_id, 'Drainage depth', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Structures constructed along a channel to dissipate safely the energy of water by letting the water fall freely for a certain height.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Structures constructed along a channel to dissipate safely the energy of water by letting the water fall freely for a certain height.', 'single_choice', 'medium', 'Drop structures are conservation structures built along a channel or waterway that convey water from a higher to a lower level, letting it fall freely over a controlled height so its energy is dissipated safely. Commonly with a stilling basin or apron to cushion the impact. Chute spillways serve a similar energy-dissipation purpose but carry the flow down an inclined surface instead of a free fall.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drop structures', true, 0),
      (v_question_id, 'Conservation structures', false, 1),
      (v_question_id, 'Intake structures', false, 2),
      (v_question_id, 'Vengineering', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The BSWM under DA described that arable lands are those with slope less than or equal to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The BSWM under DA described that arable lands are those with slope less than or equal to', 'single_choice', 'medium', 'The Bureau of Soils and Water Management classifies lands with slopes of 18% and below as arable and suitable for cultivation. This ties in with Philippine land classification policy (PD 705, the Revised Forestry Code), under which lands steeper than 18% are generally classified as forest land and are not alienable and disposable for agriculture.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15%', false, 0),
      (v_question_id, '21%', false, 1),
      (v_question_id, '18%', true, 2),
      (v_question_id, '12%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Improved version of the USLE for predicting sheet and rill erosion.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Improved version of the USLE for predicting sheet and rill erosion.', 'single_choice', 'medium', 'RUSLE, the Revised Universal Soil Loss Equation, retains the USLE factor structure (A = R×K×LS×C×P) but improves how each factor is evaluated — time-varying K, subfactor-based C, updated R values, and computerized computation. MUSLE, by contrast, is the Modified USLE, which replaces the rainfall factor with a runoff energy term to estimate sediment yield per storm event.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The WEPP Model', false, 0),
      (v_question_id, 'RUSLE', true, 1),
      (v_question_id, 'MUSLE', false, 2),
      (v_question_id, 'USLE', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are the effects of vegetation, except:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The following are the effects of vegetation, except:', 'single_choice', 'medium', 'Vegetation intercepts falling rain and absorbs raindrop energy, decreases soil moisture through transpiration (increasing storage capacity), binds the soil through its root system, promotes infiltration through cavities left by decayed roots, and enhances biological activity and soil tilth. Its effect on runoff is the opposite of the last choice: increased surface friction from vegetation reduces, not increases, runoff velocity.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Interception of falling rain', false, 0),
      (v_question_id, 'Retards erosion through the binding effect of roots', false, 1),
      (v_question_id, 'Increases biological activity in the soil', false, 2),
      (v_question_id, 'Increases runoff velocity', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For design purposes of grassed waterways, the average flow velocity shall be';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'For design purposes of grassed waterways, the average flow velocity shall be', 'single_choice', 'medium', 'The permissible velocity in a grassed waterway depends on the ability of the vegetation to resist erosion; for design purposes, an average of 1.5 m/s to 2 m/s is used. Grassed waterways serve as outlets for terraces and graded bunds and as emergency spillways for farm ponds, so the flow must stay below the erosive threshold of the grass lining.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1-2 m/s', false, 0),
      (v_question_id, '1 m/s', false, 1),
      (v_question_id, '1.5-2 m/s', true, 2),
      (v_question_id, '10 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The third stage of gully development.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The third stage of gully development.', 'single_choice', 'medium', 'Gully development follows four stages: (1) channel formation by downward scour of the topsoil; (2) headward (upstream) movement of the gully head with enlargement in width and depth; (3) the healing stage, when vegetation begins to grow in the channel and active cutting declines; and (4) the stabilization stage, when the gully reaches a stable gradient and vegetation anchors the soil (Schwab et al., 1992)', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stabilization stage', false, 0),
      (v_question_id, 'Healing stage', true, 1),
      (v_question_id, 'Downward scour of top soil', false, 2),
      (v_question_id, 'Upstream movement of gully head and enlargement', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Alternate planting of 2 or more different crops along the contours.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Alternate planting of 2 or more different crops along the contours.', 'single_choice', 'medium', 'Strip cropping is the practice of growing different crops, typically alternating clean-cultivated and close-growing crops, in alternate strips laid out across the slope (on the contour) so the close-growing strips act as barriers that filter runoff and trap sediment. Contouring alone refers to performing tillage and planting operations along the contour without alternating crop strips.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stripcropping', true, 0),
      (v_question_id, 'Contouring', false, 1),
      (v_question_id, 'Intercropping', false, 2),
      (v_question_id, 'Hedgerows', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The most widely used equation designed to predict average sheet erosion rates.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The most widely used equation designed to predict average sheet erosion rates.', 'single_choice', 'medium', 'The Universal Soil Loss Equation (Wischmeier and Smith), A = R×K×LS×C×P, is the most widely used tool for predicting long-term average annual sheet and rill erosion, where R is rainfall erosivity, K is soil erodibility, LS the slope length and steepness factors, C the cropping management factor, and P the conservation practice factor. Its later refinements (RUSLE) and event-based modification (MUSLE) build on this original equation.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The WEPP Model', false, 0),
      (v_question_id, 'RUSLE', false, 1),
      (v_question_id, 'MUSLE', false, 2),
      (v_question_id, 'USLE', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are the standard conditions for a soil erosion (unit) plot, except:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The following are the standard conditions for a soil erosion (unit) plot, except:', 'single_choice', 'hard', 'The USLE unit plot is defined as 72.6 ft (22.13 m) long on a uniform 9% slope, maintained in continuous bare fallow tilled up and down the slope (the reference condition at which the L, S, C, and P factors all equal 1.0). There is no "height" specification for the plot, so "7.26 ft high" is not a standard condition. (Note: the plot length is 72.6 ft; the standard plot width used by Wischmeier was 6 ft, with area of about 0.01 acre.)', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bare fallow', false, 0),
      (v_question_id, '9% slope', false, 1),
      (v_question_id, '72.6 ft long', false, 2),
      (v_question_id, '7.26 ft high', true, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Design and Construction of Agricultural Buildings and Facilities (STRUCTURES_ENVIRONMENT) — 19 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_mcdp uuid;
  v_sub_rpc_vtcpc uuid;
  v_sub_swine_housing uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'STRUCTURES_ENVIRONMENT';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: STRUCTURES_ENVIRONMENT';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Design and Construction of Agricultural Buildings and Facilities' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Design and Construction of Agricultural Buildings and Facilities', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_mcdp FROM public.subtopics WHERE name = 'Multi-Crop Drying Pavement (MCDP)' AND topic_id = v_topic_id;
  IF v_sub_mcdp IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Multi-Crop Drying Pavement (MCDP)') RETURNING id INTO v_sub_mcdp;
  END IF;

  SELECT id INTO v_sub_rpc_vtcpc FROM public.subtopics WHERE name = 'Rice Processing Center (RPC) and Village-Type Corn Processing Center (VTCPC)' AND topic_id = v_topic_id;
  IF v_sub_rpc_vtcpc IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Rice Processing Center (RPC) and Village-Type Corn Processing Center (VTCPC)') RETURNING id INTO v_sub_rpc_vtcpc;
  END IF;

  SELECT id INTO v_sub_swine_housing FROM public.subtopics WHERE name = 'Biosecure Finisher Swine Housing Facility' AND topic_id = v_topic_id;
  IF v_sub_swine_housing IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Biosecure Finisher Swine Housing Facility') RETURNING id INTO v_sub_swine_housing;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum area requirement for a Multi-Crop Drying Pavement (MCDP)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'What is the minimum area requirement for a Multi-Crop Drying Pavement (MCDP)?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '300 square meters (10 m × 30 m)', false, 0),
      (v_question_id, '420 square meters (15 m × 28 m)', true, 1),
      (v_question_id, '500 square meters (20 m × 25 m)', false, 2),
      (v_question_id, '550 square meters (22 m × 25 m)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What slab thickness is recommended for the improved MCDP design?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'What slab thickness is recommended for the improved MCDP design?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 inches', false, 0),
      (v_question_id, '5 inches', false, 1),
      (v_question_id, '6 inches', true, 2),
      (v_question_id, '8 inches', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which concrete class and mix proportion is specified for the 6" thick MCDP?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'Which concrete class and mix proportion is specified for the 6" thick MCDP?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Class A, 3,000 psi (1:2:3:0.5)', true, 0),
      (v_question_id, 'Class B, 2,500 psi (1:2.5:5)', false, 1),
      (v_question_id, 'Class A, 4,000 psi (1:1.5:3)', false, 2),
      (v_question_id, 'Class C, 2,000 psi (1:3:6)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the specified reinforcement detail for the 6" thick MCDP slab?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'What is the specified reinforcement detail for the 6" thick MCDP slab?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 mm diameter RSB spaced at 400 mm on center', false, 0),
      (v_question_id, '12 mm diameter RSB spaced at 500 mm on center', true, 1),
      (v_question_id, '16 mm diameter RSB spaced at 600 mm on center', false, 2),
      (v_question_id, '12 mm diameter RSB spaced at 300 mm on center', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on the design analysis, what is the load capacity of the 6" thick MCDP?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'Based on the design analysis, what is the load capacity of the 6" thick MCDP?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2,400 kg', false, 0),
      (v_question_id, '3,000 kg', false, 1),
      (v_question_id, '4,100 kg', true, 2),
      (v_question_id, '7,257 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which vehicle is NOT allowed on the 6" thick MCDP based on the slab-on-grade analysis?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'Which vehicle is NOT allowed on the 6" thick MCDP based on the slab-on-grade analysis?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4WD tractor', false, 0),
      (v_question_id, 'Combine harvester', false, 1),
      (v_question_id, 'Closed delivery van with load', false, 2),
      (v_question_id, 'Trailer truck', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the MCDP design analysis, how was the axial (post/wheel) load P of each vehicle computed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_mcdp, 'In the MCDP design analysis, how was the axial (post/wheel) load P of each vehicle computed?', 'single_choice', 'medium', 'Sheet A-5 and Table 2 of the Bureau of Agricultural and Fisheries Engineering (2022) Technical Bulletin No. 1, Series of 2022, apply the relation P = 0.4WL, taking 40% of the gross vehicle weight as the governing axial load transmitted to the slab. For example, the elf truck with load (22,500 lb) yields an axial load of 9,000 lb. Reference: Bureau of Agricultural and Fisheries Engineering. (2022). Technical Bulletin No. 1, Series of 2022: Guidelines in the design and construction of multi-crop drying pavement (MCDP). Department of Agriculture.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P = 0.4 × wheel load (0.4WL) of the gross vehicle weight', true, 0),
      (v_question_id, 'P = 0.6 × gross vehicle weight', false, 1),
      (v_question_id, 'P = full gross vehicle weight divided by four wheels', false, 2),
      (v_question_id, 'P = 1.2 × gross vehicle weight as impact allowance', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum warehouse floor area required for an RPC II facility?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_rpc_vtcpc, 'What is the minimum warehouse floor area required for an RPC II facility?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '300 square meters', false, 0),
      (v_question_id, '375 square meters', false, 1),
      (v_question_id, '500 square meters', false, 2),
      (v_question_id, '550 square meters', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the recommended height between the eaves line and the floor of the RPC warehouse?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_rpc_vtcpc, 'What is the recommended height between the eaves line and the floor of the RPC warehouse?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 m', false, 0),
      (v_question_id, '6 m', false, 1),
      (v_question_id, '7 m', true, 2),
      (v_question_id, '9 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on the National Building Code, the slope of the warehouse ramp shall not be more than:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_rpc_vtcpc, 'Based on the National Building Code, the slope of the warehouse ramp shall not be more than:', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1:6', false, 0),
      (v_question_id, '1:8', true, 1),
      (v_question_id, '1:10', false, 2),
      (v_question_id, '1:12', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the required lighting intensity for inspection areas within the processing facility?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_rpc_vtcpc, 'What is the required lighting intensity for inspection areas within the processing facility?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '110 lux', false, 0),
      (v_question_id, '220 lux', false, 1),
      (v_question_id, '400 lux', false, 2),
      (v_question_id, '540 lux', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What provision protects the base of the warehouse walls from rain erosion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_rpc_vtcpc, 'What provision protects the base of the warehouse walls from rain erosion?', 'single_choice', 'medium', 'Reference: Bureau of Agricultural and Fisheries Engineering. (2021). Technical Bulletin No. 2, Series of 2021: Construction and rehabilitation of rice processing center (RPC) and village-type corn processing center (VTCPC). Department of Agriculture.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A 0.5 m gravel bed around the perimeter', false, 0),
      (v_question_id, 'A 1 m concrete strip laid around the warehouse', true, 1),
      (v_question_id, 'A 2 m grass buffer strip', false, 2),
      (v_question_id, 'A continuous steel flashing at the wall base', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the proper orientation of the finisher building in the Philippine setting?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'What is the proper orientation of the finisher building in the Philippine setting?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Front side facing north, back side facing south', false, 0),
      (v_question_id, 'Front side facing east, back side facing west', true, 1),
      (v_question_id, 'Front side facing south, back side facing north', false, 2),
      (v_question_id, 'Front side facing west, back side facing east', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum land area required for the biosecure finisher swine housing facility site?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'What is the minimum land area required for the biosecure finisher swine housing facility site?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,000 square meters', false, 0),
      (v_question_id, '1,500 square meters', false, 1),
      (v_question_id, '2,000 square meters', true, 2),
      (v_question_id, '3,000 square meters', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum required roof overhang of the finisher building?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'What is the minimum required roof overhang of the finisher building?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 m', false, 0),
      (v_question_id, '0.75 m', false, 1),
      (v_question_id, '1.0 m', true, 2),
      (v_question_id, '1.5 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum ceiling height measured from the finish floor line?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'What is the minimum ceiling height measured from the finish floor line?', 'single_choice', 'easy', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.0 m', false, 0),
      (v_question_id, '2.4 m', true, 1),
      (v_question_id, '2.7 m', false, 2),
      (v_question_id, '3.0 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What floor slope is required for solid concrete floors toward the gutter, canal, pit, or drain?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'What floor slope is required for solid concrete floors toward the gutter, canal, pit, or drain?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5% to 1%', false, 0),
      (v_question_id, '1% to 2%', false, 1),
      (v_question_id, '2% to 4%', true, 2),
      (v_question_id, '5% to 8%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum space requirement per animal in the finishing pen, and the maximum number of finishers per pen?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'What is the minimum space requirement per animal in the finishing pen, and the maximum number of finishers per pen?', 'single_choice', 'medium', NULL, 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.50 m² per animal; 30 finishers per pen', false, 0),
      (v_question_id, '0.85 m² per animal; 25 finishers per pen', true, 1),
      (v_question_id, '1.00 m² per animal; 20 finishers per pen', false, 2),
      (v_question_id, '1.25 m² per animal; 15 finishers per pen', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For evaporative cooling pad sizing in a tunnel-ventilated finisher building, what is the recommended air velocity through the pads?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_swine_housing, 'For evaporative cooling pad sizing in a tunnel-ventilated finisher building, what is the recommended air velocity through the pads?', 'single_choice', 'medium', 'Reference: Bureau of Agricultural and Fisheries Engineering. (2022). Technical Bulletin No. 3, Series of 2022: Guidelines in the preparation on the design of biosecure finisher swine housing facility. Department of Agriculture.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100-150 ft/min', false, 0),
      (v_question_id, '200-300 ft/min', true, 1),
      (v_question_id, '350-450 ft/min', false, 2),
      (v_question_id, '500-600 ft/min', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Agricultural and Bioprocess Engineering (BIOPROCESS) — 16 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural and Bioprocess Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural and Bioprocess Engineering', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice particle with a length of 6/8 or more of the length of the whole unbroken milled rice kernel is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A rice particle with a length of 6/8 or more of the length of the whole unbroken milled rice kernel is classified as:', 'single_choice', 'medium', 'Milled rice fractions are graded by kernel length relative to the whole kernel. A head rice grain measures 6/8 (three-fourths) or more of the whole unbroken milled kernel; a large broken grain is 3/8 or more but shorter than 6/8; and small brokens are shorter than 3/8 but retained on a 1.4 mm round-perforated sieve.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Head rice grain', true, 0),
      (v_question_id, 'Large broken milled grain', false, 1),
      (v_question_id, 'Small broken milled grain', false, 2),
      (v_question_id, 'Brewer''s rice', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rice particles that will NOT pass through a perforated sieve with a round perforation of 1.4 mm but whose length is shorter than 3/8 of the whole kernel are termed:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Rice particles that will NOT pass through a perforated sieve with a round perforation of 1.4 mm but whose length is shorter than 3/8 of the whole kernel are termed:', 'single_choice', 'medium', 'The 1.4 mm round-perforated sieve is the dividing screen. Small brokens are retained on it (length shorter than 3/8 of the whole kernel), while brewer''s rice is the finer fraction that passes through the 1.4 mm perforations.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Head rice grain', false, 0),
      (v_question_id, 'Large broken milled grain', false, 1),
      (v_question_id, 'Small broken milled grain', true, 2),
      (v_question_id, 'Brewer''s rice', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A paddy lot in which 80% of the whole brown rice kernels have a length of 6.5 mm or more but shorter than 7.5 mm is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A paddy lot in which 80% of the whole brown rice kernels have a length of 6.5 mm or more but shorter than 7.5 mm is classified as:', 'single_choice', 'medium', 'Paddy is classed by the length of whole brown rice: Extremely long ≥ 7.5 mm; Long ≥ 6.5 mm but < 7.5 mm; Medium ≥ 5.5 mm but < 6.5 mm; Short < 5.5 mm (using the 80% criterion).', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Extremely long', false, 0),
      (v_question_id, 'Long', true, 1),
      (v_question_id, 'Medium', false, 2),
      (v_question_id, 'Short', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A whole brown rice kernel with a length/width (L/W) ratio equal to or greater than 2 but less than 3 is described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A whole brown rice kernel with a length/width (L/W) ratio equal to or greater than 2 but less than 3 is described as:', 'single_choice', 'medium', 'Grain shape by L/W ratio of whole brown rice: Slender ≥ 3.0; Bold ≥ 2.0 but < 3.0; Round < 2.0.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Slender', false, 0),
      (v_question_id, 'Bold', true, 1),
      (v_question_id, 'Round', false, 2),
      (v_question_id, 'Regular', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The reported bulk density of rice (paddy) is approximately:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The reported bulk density of rice (paddy) is approximately:', 'single_choice', 'easy', 'Among the physical characteristics of paddy, bulk density is 576 kg/m³. (Related listed values: voids/air space 48%, kernel specific gravity 1.11, angle of repose 36°.)', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '125 kg/m³', false, 0),
      (v_question_id, '245 kg/m³', false, 1),
      (v_question_id, '576 kg/m³', true, 2),
      (v_question_id, '783 kg/m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Relative humidity is best defined as the ratio of the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Relative humidity is best defined as the ratio of the:', 'single_choice', 'medium', 'Relative humidity (RH) is the ratio of the actual partial pressure exerted by the water vapor to the partial pressure that would be exerted if the air were saturated at the same temperature, expressed as a percentage. It should not be confused with the saturation (percentage) ratio, which compares humidity ratios.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'actual partial pressure of the water vapor to the partial pressure at saturation at the same temperature', true, 0),
      (v_question_id, 'mass of water vapor to the mass of dry air', false, 1),
      (v_question_id, 'actual humidity ratio to the humidity ratio at saturation', false, 2),
      (v_question_id, 'mass of water vapor per unit volume of air', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The expression of the mass of water vapor per unit mass of dry air, also called specific humidity, is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The expression of the mass of water vapor per unit mass of dry air, also called specific humidity, is the:', 'single_choice', 'medium', 'The humidity ratio (specific humidity) is the mass of water vapor per unit mass of dry air, W = 0.622 × ps/(pt − ps). Absolute humidity, by contrast, is the mass of water vapor per unit volume of air (vapor density).', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Relative humidity', false, 0),
      (v_question_id, 'Humidity ratio', true, 1),
      (v_question_id, 'Saturation ratio', false, 2),
      (v_question_id, 'Absolute humidity', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The ratio of the actual humidity ratio to the humidity ratio at saturation for the same air sample at the same temperature is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The ratio of the actual humidity ratio to the humidity ratio at saturation for the same air sample at the same temperature is called the:', 'single_choice', 'medium', 'The saturation ratio (percentage humidity) = W/W1 × 100, where W is the actual humidity ratio and W1 is the humidity ratio at saturation for the same air at the same temperature. It differs from RH, which is a ratio of partial pressures.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Relative humidity', false, 0),
      (v_question_id, 'Humidity ratio', false, 1),
      (v_question_id, 'Saturation ratio', true, 2),
      (v_question_id, 'Absolute humidity', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The temperature at which the water vapor in the air becomes saturated is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The temperature at which the water vapor in the air becomes saturated is the:', 'single_choice', 'medium', 'The dew point temperature is the temperature at which the water vapor in the air is saturated; further cooling produces condensation. The dry bulb temperature is read by an ordinary thermometer, while the wet bulb temperature is read by a thermometer with a wetted wick.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dry bulb temperature', false, 0),
      (v_question_id, 'Wet bulb temperature', false, 1),
      (v_question_id, 'Dew point temperature', true, 2),
      (v_question_id, 'Adiabatic saturation temperature', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During the ______, drying takes place from the surface of the grain, similar to the evaporation of moisture from a free water surface.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'During the ______, drying takes place from the surface of the grain, similar to the evaporation of moisture from a free water surface.', 'single_choice', 'medium', 'In the constant rate period, moisture at the surface behaves like a free water surface. Its rate depends on the exposed area, the humidity difference between the air stream and the wet surface, the mass-transfer coefficient, and the air velocity. It continues until the critical moisture content is reached.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Constant rate period', true, 0),
      (v_question_id, 'Falling rate period', false, 1),
      (v_question_id, 'Equilibrium period', false, 2),
      (v_question_id, 'Transition period', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The drying period that follows the constant rate period and is controlled largely by movement of moisture within the material to the surface by liquid diffusion is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The drying period that follows the constant rate period and is controlled largely by movement of moisture within the material to the surface by liquid diffusion is the:', 'single_choice', 'medium', 'The falling rate period comes after the constant rate period. It is governed by the product itself and involves (a) movement of moisture within the material to the surface by liquid diffusion and (b) removal of moisture from the surface. The drying rate declines because internal moisture migration becomes limiting.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Constant rate period', false, 0),
      (v_question_id, 'Falling rate period', true, 1),
      (v_question_id, 'Induction period', false, 2),
      (v_question_id, 'Saturation period', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a simple vapor-compression system, the component that provides the heat-transfer surface through which heat passes from the refrigerated space into the vaporizing refrigerant is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a simple vapor-compression system, the component that provides the heat-transfer surface through which heat passes from the refrigerated space into the vaporizing refrigerant is the:', 'single_choice', 'medium', 'The evaporator provides the surface through which heat passes from the refrigerated product into the vaporizing refrigerant, where the liquid vaporizes at constant pressure and temperature. The condenser rejects heat as vapor condenses; the compressor raises vapor pressure and temperature; the flow control meters and expands the liquid.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Evaporator', true, 0),
      (v_question_id, 'Condenser', false, 1),
      (v_question_id, 'Compressor', false, 2),
      (v_question_id, 'Refrigerant flow control', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The refrigerant whose greatest use is in large industrial and low-temperature installations, such as frozen-food and dairy plants, is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The refrigerant whose greatest use is in large industrial and low-temperature installations, such as frozen-food and dairy plants, is:', 'single_choice', 'medium', 'Ammonia is used mainly in large industrial and low-temperature installations. Although R22 and R12 have challenged it in some low-temperature applications, new ammonia systems continue to be installed each year. R11 suits centrifugal-compressor service, and CO2 is now limited to the low-temperature stage of cascade systems.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Carbon dioxide', false, 0),
      (v_question_id, 'Refrigerant 11 (R11)', false, 1),
      (v_question_id, 'Refrigerant 12 (R12)', false, 2),
      (v_question_id, 'Ammonia', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The most widely used refrigerant, employed primarily with reciprocating compressors in household refrigeration, and having convenient operating pressures, low power requirement per ton, and being nontoxic and noncorrosive, is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The most widely used refrigerant, employed primarily with reciprocating compressors in household refrigeration, and having convenient operating pressures, low power requirement per ton, and being nontoxic and noncorrosive, is:', 'single_choice', 'medium', 'R12 is described as the most widely used refrigerant, used mainly with reciprocating compressors for household refrigeration and commercial/industrial air conditioning. Its desirable properties include convenient operating pressures, low power requirement per ton, and being nontoxic and noncorrosive.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ammonia', false, 0),
      (v_question_id, 'Refrigerant 11 (R11)', false, 1),
      (v_question_id, 'Refrigerant 12 (R12)', true, 2),
      (v_question_id, 'Carbon dioxide', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A sample of air has a dry-bulb temperature of 30 °C and a wet-bulb (adiabatic saturation) temperature of 25 °C. The barometric (total) pressure is 101 kPa. The relevant air and water properties are: specific heat of dry air cp = 1.0 kJ/kg·K; constant in humidity-ratio equation = 0.622; enthalpy of saturated vapor at 30 °C, hg1 = 2556.4 kJ/kg; enthalpy of saturated vapor at 25 °C, hg2 = 2547.3 kJ/kg; enthalpy of saturated liquid at 25 °C, hf = 125.66 kJ/kg; saturation pressure of water at 25 °C, ps,25 = 3.171 kPa; saturation pressure of water at 30 °C, ps,30 = 4.246 kPa. Calculate the humidity ratio (W2) of the air if it is adiabatically saturated.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A sample of air has a dry-bulb temperature of 30 °C and a wet-bulb (adiabatic saturation) temperature of 25 °C. The barometric (total) pressure is 101 kPa. The relevant air and water properties are: specific heat of dry air cp = 1.0 kJ/kg·K; constant in humidity-ratio equation = 0.622; enthalpy of saturated vapor at 30 °C, hg1 = 2556.4 kJ/kg; enthalpy of saturated vapor at 25 °C, hg2 = 2547.3 kJ/kg; enthalpy of saturated liquid at 25 °C, hf = 125.66 kJ/kg; saturation pressure of water at 25 °C, ps,25 = 3.171 kPa; saturation pressure of water at 30 °C, ps,30 = 4.246 kPa. Calculate the humidity ratio (W2) of the air if it is adiabatically saturated.', 'single_choice', 'hard', 'When the air is adiabatically saturated it leaves saturated at 25 °C, so W2 comes from the humidity ratio equation, using the saturation pressure at 25 °C: W2 = 0.622 ps,25 / (pt − ps,25) = (0.622)(3.171) / (101 − 3.171) = 1.9723 / 97.829 = 0.0201 kg/kg.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0165 kg/kg', false, 0),
      (v_question_id, '0.0180 kg/kg', false, 1),
      (v_question_id, '0.0201 kg/kg', true, 2),
      (v_question_id, '0.0224 kg/kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A sample of air has a dry-bulb temperature of 30 °C and a wet-bulb (adiabatic saturation) temperature of 25 °C. The barometric (total) pressure is 101 kPa. The relevant air and water properties are: specific heat of dry air cp = 1.0 kJ/kg·K; constant in humidity-ratio equation = 0.622; enthalpy of saturated vapor at 30 °C, hg1 = 2556.4 kJ/kg; enthalpy of saturated vapor at 25 °C, hg2 = 2547.3 kJ/kg; enthalpy of saturated liquid at 25 °C, hf = 125.66 kJ/kg; saturation pressure of water at 25 °C, ps,25 = 3.171 kPa; saturation pressure of water at 30 °C, ps,30 = 4.246 kPa. Calculate the enthalpy (h2) of the air if it is adiabatically saturated at 25 °C.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A sample of air has a dry-bulb temperature of 30 °C and a wet-bulb (adiabatic saturation) temperature of 25 °C. The barometric (total) pressure is 101 kPa. The relevant air and water properties are: specific heat of dry air cp = 1.0 kJ/kg·K; constant in humidity-ratio equation = 0.622; enthalpy of saturated vapor at 30 °C, hg1 = 2556.4 kJ/kg; enthalpy of saturated vapor at 25 °C, hg2 = 2547.3 kJ/kg; enthalpy of saturated liquid at 25 °C, hf = 125.66 kJ/kg; saturation pressure of water at 25 °C, ps,25 = 3.171 kPa; saturation pressure of water at 30 °C, ps,30 = 4.246 kPa. Calculate the enthalpy (h2) of the air if it is adiabatically saturated at 25 °C.', 'single_choice', 'hard', 'Apply the enthalpy of moist air equation at the saturated state: t2 = 25 °C, W2 = 0.0201 kg/kg, hg2 = 2547.3 kJ/kg. h2 = cp·t2 + W2·hg2 = (1.0)(25) + (0.0201)(2547.3) = 25 + 51.2 = 76.2 kJ/kg.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '51.2 kJ/kg', false, 0),
      (v_question_id, '71.0 kJ/kg', false, 1),
      (v_question_id, '76.2 kJ/kg', true, 2),
      (v_question_id, '80.9 kJ/kg', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Rural Electrification (STRUCTURES_ENVIRONMENT) — 21 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Capacitance is measured in';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Capacitance is measured in', 'single_choice', 'easy', 'Capacitance (C = q/E) is measured in farad (F), named after Michael Faraday. The distractors are units of other quantities: the siemens (or mho) is the unit of conductance, the weber is the unit of magnetic flux, and the ampere is the unit of current.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Siemens', false, 0),
      (v_question_id, 'Weber', false, 1),
      (v_question_id, 'Ampere', false, 2),
      (v_question_id, 'Farad', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The amount of electrical charge on a single electron.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The amount of electrical charge on a single electron.', 'single_choice', 'medium', 'The elementary charge unit (ECU) is the amount of electrical charge carried by a single electron. The coulomb is the practical unit for measuring quantity of charge and is approximately equal to 6.24 × 10^18 ECU, while current is the rate at which charge flows (one ampere = one coulomb per second).', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Current', false, 0),
      (v_question_id, 'Coulomb', false, 1),
      (v_question_id, 'ECU', true, 2),
      (v_question_id, 'Farad', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '1 kWh is equivalent to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, '1 kWh is equivalent to', 'single_choice', 'medium', 'One watt-hour equals 3,600 watt-seconds or 3,600 joules, so one kilowatt-hour equals 3,600,000 J or 3,600 kJ (3.6 MJ). A kilowatt-hour is the energy consumed when a power of one kilowatt is used steadily for one hour. For reference, 1 joule = 1 N·m and 1 calorie = 4.184 J.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.184 J', false, 0),
      (v_question_id, '1 N·m', false, 1),
      (v_question_id, '3600 kJ', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Devices that use up chemical elements or compounds to produce electrical energy.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Devices that use up chemical elements or compounds to produce electrical energy.', 'single_choice', 'medium', 'Both batteries and fuel cells rely on chemical action, but a fuel cell continuously consumes (uses up) externally supplied chemical elements or compounds — such as hydrogen and oxygen — to generate electricity, whereas a battery stores its reactants internally and simply converts stored chemical energy to electrical energy. Photocells convert radiant energy, and thermopiles are connected thermocouples that convert heat.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Thermopile', false, 0),
      (v_question_id, 'Photocell', false, 1),
      (v_question_id, 'Fuel cells', true, 2),
      (v_question_id, 'Battery', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The reciprocal of resistance (G = 1/R), measured in mho.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The reciprocal of resistance (G = 1/R), measured in mho.', 'single_choice', 'medium', 'Conductance G is the reciprocal of resistance, G = 1/R, measured in mho or siemens (S); it expresses how readily a material allows current flow. Conductivity is the reciprocal of resistivity (a material property), and impedance is the total opposition to current in AC circuits, combining resistance and reactance.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conductance', true, 0),
      (v_question_id, 'Impedance', false, 1),
      (v_question_id, 'Capacitance', false, 2),
      (v_question_id, 'Electromotive force', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'States that when a current flows in a conductor, the amount of heat generated is proportional to current, resistance, and time in the current flowing.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'States that when a current flows in a conductor, the amount of heat generated is proportional to current, resistance, and time in the current flowing.', 'single_choice', 'medium', 'Joule''s law governs the heating effect of current: the heat (energy) generated is W = I²Rt, proportional to the square of the current, the resistance, and the time of flow. Kirchhoff''s Current Law states that since charge is conserved, the sum of currents at a node is zero; Kirchhoff''s Voltage Law states that the net voltage around a closed circuit is zero.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Kirchhoff''s Voltage Law', false, 0),
      (v_question_id, 'Kirchhoff''s Current Law', false, 1),
      (v_question_id, 'Joule''s Law', true, 2),
      (v_question_id, 'Ohm''s Law', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following materials has the highest resistivity value?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following materials has the highest resistivity value?', 'single_choice', 'easy', 'Glass is an insulator with resistivity of about 10^7 to 10^10 Ω·m — many orders of magnitude higher than the others. Silver (1.63 × 10^-8 Ω·m) and aluminum (2.83 × 10^-8 Ω·m) are conductors, while carbon/graphite (1.5 × 10^-5 Ω·m) is a semiconductor with intermediate resistivity. The lower the resistivity, the better the conductor.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aluminum', false, 0),
      (v_question_id, 'Silver', false, 1),
      (v_question_id, 'Glass', true, 2),
      (v_question_id, 'Carbon', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The concept is closely related to resistors in parallel. The current divides in inverse proportion to the resistance of the individual parallel elements.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The concept is closely related to resistors in parallel. The current divides in inverse proportion to the resistance of the individual parallel elements.', 'single_choice', 'medium', 'In a current divider, the total current entering parallel resistors splits among the branches in inverse proportion to their resistances — the smaller the branch resistance, the larger its share of the current. Its counterpart, the voltage divider, applies to series resistors, where the voltage across each resistor is directly proportional to the ratio of its resistance to the total series resistance.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Voltage divider', false, 0),
      (v_question_id, 'Current divider', true, 1),
      (v_question_id, 'Thevenin''s Theorem', false, 2),
      (v_question_id, 'Norton''s Theorem', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a farmhouse, every load is switched off except a water pump motor. An observer counts the revolutions of the kilowatt-hour meter disk for 12 minutes and records 24 revolutions. The meter nameplate shows a Kh factor of 3.0. What is the power input to the pump motor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a farmhouse, every load is switched off except a water pump motor. An observer counts the revolutions of the kilowatt-hour meter disk for 12 minutes and records 24 revolutions. The meter nameplate shows a Kh factor of 3.0. What is the power input to the pump motor?', 'single_choice', 'hard', 'Compute the energy registered during the counting period. The Kh factor means each disk revolution corresponds to 3.0 watt-hours of energy passing through the meter: W = Kh × no. of revolutions = 3.0 Wh/rev × 24 rev = 72 Wh. Convert the counting period into hours: t = 12 min × (1 hr/60 min) = 0.2 hr. Power is energy divided by time: P = W/t = 72 Wh / 0.2 hr = 360 W.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '300 W', false, 0),
      (v_question_id, '360 W', true, 1),
      (v_question_id, '432 W', false, 2),
      (v_question_id, '720 W', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'States that the current flowing in a circuit varies directly with the electrical pressure and inversely with the opposition.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'States that the current flowing in a circuit varies directly with the electrical pressure and inversely with the opposition.', 'single_choice', 'easy', 'Ohm''s Law, I = E/R, states that current varies directly with the electrical pressure (voltage or EMF) and inversely with the opposition (resistance). It is the fundamental relation for computing E, I, or R when the other two are known, and it underlies the power formulas P = IE = I²R = E²/R.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Kirchhoff''s Voltage Law', false, 0),
      (v_question_id, 'Kirchhoff''s Current Law', false, 1),
      (v_question_id, 'Joule''s Law', false, 2),
      (v_question_id, 'Ohm''s Law', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are thermocouples connected together, used for devices like flame detectors, safety valves, and thermometers.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'These are thermocouples connected together, used for devices like flame detectors, safety valves, and thermometers.', 'single_choice', 'medium', 'A thermopile is a group of thermocouples connected together (usually in series) to multiply the small thermoelectric voltage produced when the junction of two unlike metals is heated. Thermopiles are used in flame detectors, gas safety valves, and radiation thermometers where a usable voltage must be generated purely from heat.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Battery', false, 0),
      (v_question_id, 'Thermopile', true, 1),
      (v_question_id, 'Photocell', false, 2),
      (v_question_id, 'Fuel cells', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Defined as the proportional change in resistance per degree temperature difference from some reference temperature.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Defined as the proportional change in resistance per degree temperature difference from some reference temperature.', 'single_choice', 'medium', 'The temperature coefficient of resistance (α, per °C) expresses the proportional change in resistance per degree of temperature difference from a reference temperature, used in the relation Rt = Ri(1 + αΔT). For copper, α ≈ 3.93 × 10^-3 per °C at 20°C, which is why conductor resistance rises noticeably as wires heat up.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Temperature coefficient of resistance', true, 0),
      (v_question_id, 'Thermal coefficient', false, 1),
      (v_question_id, 'Resistivity thermal coefficient', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A phenomenon when conductors lose their resistance in extreme cold.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A phenomenon when conductors lose their resistance in extreme cold.', 'single_choice', 'easy', 'Superconductivity is the phenomenon in which conductors lose their electrical resistance entirely when cooled to extremely low (cryogenic) temperatures, below a critical temperature characteristic of the material. It is the extreme opposite of the normal behavior of conductors, whose resistance increases with temperature.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Psychroconductivity', false, 0),
      (v_question_id, 'Subconductivity', false, 1),
      (v_question_id, 'Superconductivity', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is not true about power factor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is not true about power factor?', 'single_choice', 'medium', 'The false statement is the first one. The power factor depends precisely on the kind of opposition offered. When the opposition is pure resistance (heaters, electric ranges, incandescent lamps), voltage and current are in phase and pf = 1. When inductance or capacitance is present as in electric motors, typically pf = 0.6 to 0.8, a phase shift occurs and pf = cos θ drops below 1. Power factor can never exceed 1, since true power cannot exceed apparent power.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The value of the power factor does not depend on the kind of opposition offered', true, 0),
      (v_question_id, 'It is never greater than 1', false, 1),
      (v_question_id, 'Power factor is equal to one (1) for heaters, electric ranges and incandescent lamps', false, 2),
      (v_question_id, 'Power factor is between 0.6 to 0.8 for electric motors', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Most ________ increase in resistance with an increase in temperature.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Most ________ increase in resistance with an increase in temperature.', 'single_choice', 'medium', 'Most conductors increase their electrical resistance as temperature increases, following Rt = Ri(1 + αΔT) with a positive temperature coefficient. Increased atomic vibration impedes electron flow. Semiconductors and insulators generally behave oppositely. Their resistance tends to decrease with rising temperature as more charge carriers become available.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conductors', true, 0),
      (v_question_id, 'Conductors and insulators', false, 1),
      (v_question_id, 'Insulators and semiconductors', false, 2),
      (v_question_id, 'Insulators', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If the chemical reaction is irreversible, it is a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'If the chemical reaction is irreversible, it is a', 'single_choice', 'medium', 'In a primary cell, the chemical reaction is irreversible. Once the reactants are exhausted, the cell is discarded (e.g., ordinary dry cells). In a secondary cell, the reaction is reversible, so the cell can be recharged by passing current through it in the opposite direction (e.g., lead-acid storage batteries).', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fuel cell', false, 0),
      (v_question_id, 'Battery', false, 1),
      (v_question_id, 'Primary cell', true, 2),
      (v_question_id, 'Secondary cell', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Refers to the design, construction and installation of electrical power source, wiring and lighting and electric system for farm production and processing of farm products, including off-grid farm electrification using stand-alone power systems with renewable energy technologies and hybrid systems.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Refers to the design, construction and installation of electrical power source, wiring and lighting and electric system for farm production and processing of farm products, including off-grid farm electrification using stand-alone power systems with renewable energy technologies and hybrid systems.', 'single_choice', 'medium', 'This is the definition of farm electrification under Section 4.1(t) of the draft IRR of R.A. 10915 (the Agricultural and Biosystems Engineering Act of 2016). The modern definition expands the older concept in R.A. 3927 (the 1964 Agricultural Engineering Law), which covered rural wiring and lighting, electric systems for agriculture, and generators and motors for farm power, to explicitly include off-grid, stand-alone systems using renewable energy and hybrid generation-distribution setups.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rural Electrification', false, 0),
      (v_question_id, 'Farm Electrification', true, 1),
      (v_question_id, 'Agricultural Electrification and Energy', false, 2),
      (v_question_id, 'Agricultural Electrification', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the room index of the workshop.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the room index of the workshop.', 'single_choice', 'hard', 'Mounting height (measured from floor to luminaire): the floor cavity height is hfc = 1 m (floor to work plane) and the room cavity height hrc = 3 m (work plane to bottom of luminaire), so Hm = hfc + hrc = 1 + 3 = 4 m. RI = L×B / ((L+B) × Hm) = 12×6 / ((12+6)×4) = 72/72 = 1.0.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.75', false, 0),
      (v_question_id, '1.00', true, 1),
      (v_question_id, '1.33', false, 2),
      (v_question_id, '1.50', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the number of luminaires required.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the number of luminaires required.', 'single_choice', 'hard', 'Given: Room dimensions L = 12 m, W = 6 m; required illumination E = 200 lux; lumen output per luminaire Ln = 4,500 lumens; coefficient of utilization CU = 0.51; light loss factor LLF = 0.7 (industrial environment). N = A×E / (Ln×CU×LLF) = (12×6)×200 / (4500×0.51×0.7) = 14,400 / 1,606.5 = 8.963 ≈ 9 luminaires.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7', false, 0),
      (v_question_id, '8', false, 1),
      (v_question_id, '9', true, 2),
      (v_question_id, '10', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the area per luminaire.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the area per luminaire.', 'single_choice', 'hard', 'Area per luminaire = total room area / number of luminaires = 72 / 9 = 8 m².', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 m²', false, 0),
      (v_question_id, '8 m²', true, 1),
      (v_question_id, '9 m²', false, 2),
      (v_question_id, '12 m²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the spacing between fixtures. Round to the nearest whole number.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An industrial workshop measuring 12 m × 6 m is to be provided with an illumination level of 200 lux using 2×40 W industrial fluorescent fixtures with vitreous enamel reflectors, each having an initial lamp lumen output of 4,500 lumens. The workshop has a wall reflectance of 50%, ceiling reflectance of 70%, and floor reflectance of 10%. The floor cavity height is 1 m, the ceiling cavity height is 2.5 m, and the room cavity height is 3 m. From the coefficient of utilization chart, the CU corresponding to the computed room index and the given reflectances is 0.51. The light loss factor for an industrial environment may be taken as 0.7, and the maximum spacing-to-mounting-height ratio is 1.5. Determine the spacing between fixtures. Round to the nearest whole number.', 'single_choice', 'hard', 'S = sqrt(Area per luminaire) = sqrt(8) = 2.828 m ≈ 3 m.', 'Board Exam Pro', 'ABELE 1st Ed Vol I Answer Key.pdf', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 m', false, 0),
      (v_question_id, '3 m', true, 1),
      (v_question_id, '4 m', false, 2),
      (v_question_id, '5 m', false, 3);
  END IF;
END $$;

