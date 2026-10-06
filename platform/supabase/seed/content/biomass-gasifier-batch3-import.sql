-- Biomass Gasifier batch 3 (33 questions, 1 topic). Facts are drawn from
-- biomass gasification review material and the gasifier design procedure
-- (power, engine, airflow, reactor and fire-zone computations, gas quality limits).
-- Computation items state every given in the question text.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false, paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Design of Biomass Gasifier as Power Source of Various Farm Machinery and Equipment (POWER_ENERGY_MACHINERY) — 33 question(s)
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

  -- 1. Design power with parasitic loads
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biomass gasifier is being designed to power a machine that requires 15 hp. The parasitic loads of the system are a fan at 1.5 hp, a blower at 1.5 hp, a conveyor at 2.0 hp, and an elevator at 1.0 hp. What is the design power required for the engine drive?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A biomass gasifier is being designed to power a machine that requires 15 hp. The parasitic loads of the system are a fan at 1.5 hp, a blower at 1.5 hp, a conveyor at 2.0 hp, and an elevator at 1.0 hp. What is the design power required for the engine drive?', 'single_choice', 'easy', 'Given: Pm = 15 hp; parasitic loads = 1.5 + 1.5 + 2.0 + 1.0 = 6.0 hp. Design power is the machine power plus the parasitic power: Pd = Pm + Pp = 15 + 6.0 = 21.0 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20.0 hp', false, 0),
      (v_question_id, '36.0 hp', false, 1),
      (v_question_id, '15.0 hp', false, 2),
      (v_question_id, '21.0 hp', true, 3);
  END IF;

  -- 2. Engine power from design power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The design power of an engine drive for a gasifier-powered machine is 24 hp. If the brake thermal efficiency of the compression ignition engine is 40 percent and the transmission efficiency is 80 percent, what is the required engine power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The design power of an engine drive for a gasifier-powered machine is 24 hp. If the brake thermal efficiency of the compression ignition engine is 40 percent and the transmission efficiency is 80 percent, what is the required engine power?', 'single_choice', 'hard', 'Given: Pd = 24 hp; brake thermal efficiency = 0.40; transmission efficiency = 0.80. Engine power is the design power divided by the product of the two efficiencies: Pe = Pd / (0.40 x 0.80) = 24 / 0.32 = 75 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.68 hp', false, 0),
      (v_question_id, '75 hp', true, 1),
      (v_question_id, '60 hp', false, 2),
      (v_question_id, '30 hp', false, 3);
  END IF;

  -- 3. Piston displacement rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The engine power required by a gasifier-engine system is 75 hp and the heating value of the producer gas is 1,100 kcal/m3. Using 0.746 kW/hp and 0.0012 kW per kcal/hr, what is the engine piston displacement rate (gas flow rate)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The engine power required by a gasifier-engine system is 75 hp and the heating value of the producer gas is 1,100 kcal/m3. Using 0.746 kW/hp and 0.0012 kW per kcal/hr, what is the engine piston displacement rate (gas flow rate)?', 'single_choice', 'hard', 'Given: Pe = 75 hp; heating value of gas = 1,100 kcal/m3; 0.746 kW/hp; 0.0012 kW per kcal/hr. Piston displacement rate = engine power / heating value of gas, with consistent units: PDR = (75 x 0.746 kW) / (0.0012 x 1,100 kW per m3/hr) = 55.95 / 1.32 = 42.4 m3/hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '73.9 m3/hr', false, 0),
      (v_question_id, '56.8 m3/hr', false, 1),
      (v_question_id, '42.4 m3/hr', true, 2),
      (v_question_id, '50.9 m3/hr', false, 3);
  END IF;

  -- 4. Blower flow rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gasifier-engine system requires a gas flow rate of 60 m3/hr. If the gas-to-air ratio of the gasifier is 1.5, what volumetric flow rate must the suction blower be able to deliver?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gasifier-engine system requires a gas flow rate of 60 m3/hr. If the gas-to-air ratio of the gasifier is 1.5, what volumetric flow rate must the suction blower be able to deliver?', 'single_choice', 'hard', 'Given: gas flow rate GFR = 60 m3/hr; gas-to-air ratio GAR = 1.5. The volumetric air (blower) flow rate is the gas flow rate divided by the gas-to-air ratio: 60 / 1.5 = 40 m3/hr. Multiplying by the air density would give the mass flow rate in kg/hr instead.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '48 m3/hr', false, 0),
      (v_question_id, '40 m3/hr', true, 1),
      (v_question_id, '90 m3/hr', false, 2),
      (v_question_id, '60 m3/hr', false, 3);
  END IF;

  -- 5. Reactor inner diameter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier consumes fuel at 30 kg/hr. A grate with a specific gasification rate of 120 kg/hr-m2 is selected. Using Di = (1.27 x Ar)^0.5, what is the computed inner diameter of the reactor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier consumes fuel at 30 kg/hr. A grate with a specific gasification rate of 120 kg/hr-m2 is selected. Using Di = (1.27 x Ar)^0.5, what is the computed inner diameter of the reactor?', 'single_choice', 'hard', 'Given: FCR = 30 kg/hr; SGR = 120 kg/hr-m2. Reactor cross-sectional area Ar = FCR / SGR = 30 / 120 = 0.25 m2. Inner diameter Di = (1.27 x 0.25)^0.5 = (0.3175)^0.5 = 0.56 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.79 m', false, 0),
      (v_question_id, '0.32 m', false, 1),
      (v_question_id, '0.50 m', false, 2),
      (v_question_id, '0.56 m', true, 3);
  END IF;

  -- 6. Fire zone rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier burns fuel at 36 kg/hr. The rice husk density is 100 kg/m3 and the cross-sectional area of the reactor is 0.30 m2. Using FZR = FCR / (60 x density x Ar), what is the fire zone rate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier burns fuel at 36 kg/hr. The rice husk density is 100 kg/m3 and the cross-sectional area of the reactor is 0.30 m2. Using FZR = FCR / (60 x density x Ar), what is the fire zone rate?', 'single_choice', 'hard', 'Given: FCR = 36 kg/hr; density = 100 kg/m3; Ar = 0.30 m2. FZR = (36 / 60 kg/min) / (100 x 0.30 kg/m) = 0.6 / 30 = 0.02 m/min = 2.0 cm/min, which lies within the allowable 1 to 3 cm/min fire zone rate.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.2 cm/min', false, 0),
      (v_question_id, '0.02 cm/min', false, 1),
      (v_question_id, '2.0 cm/min', true, 2),
      (v_question_id, '120 cm/min', false, 3);
  END IF;

  -- 7. Time for fire zone to reach middle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gasifier reactor has an inner cylinder height of 1.5 m and a cross-sectional area of 0.40 m2. It burns rice husk at 48 kg/hr, and the rice husk density is 120 kg/m3. Approximately how long will it take for the fire zone to reach the middle of the reactor? Use FZR = FCR / (60 x density x Ar).';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gasifier reactor has an inner cylinder height of 1.5 m and a cross-sectional area of 0.40 m2. It burns rice husk at 48 kg/hr, and the rice husk density is 120 kg/m3. Approximately how long will it take for the fire zone to reach the middle of the reactor? Use FZR = FCR / (60 x density x Ar).', 'single_choice', 'hard', 'Given: H = 1.5 m; Ar = 0.40 m2; FCR = 48 kg/hr; density = 120 kg/m3. FZR = (48 / 60) / (120 x 0.40) = 0.8 / 48 = 0.01667 m/min = 1.67 cm/min. The middle of the reactor is at 1.5 / 2 = 0.75 m = 75 cm, so t = 75 / 1.67 = 45 minutes.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '45 minutes', true, 0),
      (v_question_id, '22.5 minutes', false, 1),
      (v_question_id, '75 minutes', false, 2),
      (v_question_id, '90 minutes', false, 3);
  END IF;

  -- 8. Time to consume a full reactor load
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gasifier reactor has an inner diameter of 0.6 m and a fuel column height of 1.5 m. It is fully loaded with rice husk having a density of 100 kg/m3 and consumes fuel at 30 kg/hr. How long will the fuel load last?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gasifier reactor has an inner diameter of 0.6 m and a fuel column height of 1.5 m. It is fully loaded with rice husk having a density of 100 kg/m3 and consumes fuel at 30 kg/hr. How long will the fuel load last?', 'single_choice', 'medium', 'Given: D = 0.6 m; H = 1.5 m; density = 100 kg/m3; FCR = 30 kg/hr. Volume = (pi/4)(0.6)^2(1.5) = 0.424 m3. Fuel load = 0.424 x 100 = 42.4 kg. Time = 42.4 / 30 = 1.41 hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.41 hr', true, 0),
      (v_question_id, '0.71 hr', false, 1),
      (v_question_id, '2.83 hr', false, 2),
      (v_question_id, '1.80 hr', false, 3);
  END IF;

  -- 9. Specific gasification rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier with an inner reactor diameter of 0.6 m consumes fuel at 45 kg/hr. What is the specific gasification rate of the reactor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier with an inner reactor diameter of 0.6 m consumes fuel at 45 kg/hr. What is the specific gasification rate of the reactor?', 'single_choice', 'medium', 'Given: D = 0.6 m; FCR = 45 kg/hr. Reactor area = (pi/4)(0.6)^2 = 0.2827 m2. SGR = FCR / Ar = 45 / 0.2827 = 159.2 kg/hr-m2, which lies within the allowable 70 to 210 kg/hr-m2 range.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '39.8 kg/hr-m2', false, 0),
      (v_question_id, '636.6 kg/hr-m2', false, 1),
      (v_question_id, '159.2 kg/hr-m2', true, 2),
      (v_question_id, '125.0 kg/hr-m2', false, 3);
  END IF;

  -- 10. Equivalence ratio from air supplied
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier consumes 30 kg of fuel per hour. The stoichiometric air requirement of rice husk is 4.7 kg air per kg fuel, and the actual air supplied to the gasifier is 42.3 kg per hour. What is the equivalence ratio of the gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier consumes 30 kg of fuel per hour. The stoichiometric air requirement of rice husk is 4.7 kg air per kg fuel, and the actual air supplied to the gasifier is 42.3 kg per hour. What is the equivalence ratio of the gasifier?', 'single_choice', 'medium', 'Given: fuel = 30 kg/hr; stoichiometric air = 4.7 kg air/kg fuel; actual air = 42.3 kg/hr. Stoichiometric air for the fuel rate = 30 x 4.7 = 141 kg/hr. Equivalence ratio = actual air / stoichiometric air = 42.3 / 141 = 0.30, within the 0.2 to 0.4 range of gasifiers.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.33', false, 0),
      (v_question_id, '1.41', false, 1),
      (v_question_id, '0.15', false, 2),
      (v_question_id, '0.30', true, 3);
  END IF;

  -- 11. Fuel consumption from reactor diameter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier with a reactor diameter of 120 cm is designed to supply heat to a steam boiler. If its specific gasification rate is 150 kg/hr-m2 and one sack of rice husk weighs 10 kg, how many sacks of fuel does it consume per hour?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier with a reactor diameter of 120 cm is designed to supply heat to a steam boiler. If its specific gasification rate is 150 kg/hr-m2 and one sack of rice husk weighs 10 kg, how many sacks of fuel does it consume per hour?', 'single_choice', 'medium', 'Given: D = 1.2 m; SGR = 150 kg/hr-m2; 10 kg per sack. Reactor area = (pi/4)(1.2)^2 = 1.131 m2. Fuel consumption = 150 x 1.131 = 169.65 kg/hr = 16.96 sacks per hour.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '21.6 sacks/hr', false, 0),
      (v_question_id, '16.96 sacks/hr', true, 1),
      (v_question_id, '8.48 sacks/hr', false, 2),
      (v_question_id, '67.9 sacks/hr', false, 3);
  END IF;

  -- 12. Air volume for gasification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier consumes fuel at 169.65 kg/hr. The stoichiometric air requirement of rice husk is 4.7 kg air per kg fuel, the equivalence ratio is 0.32, and the density of air is 1.25 kg/m3. What volume of air must be supplied to the gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier consumes fuel at 169.65 kg/hr. The stoichiometric air requirement of rice husk is 4.7 kg air per kg fuel, the equivalence ratio is 0.32, and the density of air is 1.25 kg/m3. What volume of air must be supplied to the gasifier?', 'single_choice', 'hard', 'Given: FCR = 169.65 kg/hr; SA = 4.7 kg air/kg fuel; ER = 0.32; air density = 1.25 kg/m3. Air mass = 169.65 x 4.7 x 0.32 = 255.2 kg/hr. Air volume = 255.2 / 1.25 = 204.1 m3/hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '255.2 m3/hr', false, 0),
      (v_question_id, '204.1 m3/hr', true, 1),
      (v_question_id, '318.9 m3/hr', false, 2),
      (v_question_id, '637.9 m3/hr', false, 3);
  END IF;

  -- 13. Thermal power input to gasifier
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk gasifier consumes 100 kg of fuel per hour. If the heating value of rice husk is 3,000 kcal/kg and 0.0012 kW corresponds to 1 kcal/hr, what is the thermal power input to the gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rice husk gasifier consumes 100 kg of fuel per hour. If the heating value of rice husk is 3,000 kcal/kg and 0.0012 kW corresponds to 1 kcal/hr, what is the thermal power input to the gasifier?', 'single_choice', 'easy', 'Given: FCR = 100 kg/hr; heating value = 3,000 kcal/kg; 0.0012 kW per kcal/hr. Energy input = 100 x 3,000 = 300,000 kcal/hr. Power input = 300,000 x 0.0012 = 360 kW.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '83.3 kW', false, 0),
      (v_question_id, '36 kW', false, 1),
      (v_question_id, '3,600 kW', false, 2),
      (v_question_id, '360 kW', true, 3);
  END IF;

  -- 14. Gasification definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Gasification is the process of converting solid biomass into a combustible gas by heating it within which conditions?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Gasification is the process of converting solid biomass into a combustible gas by heating it within which conditions?', 'single_choice', 'easy', 'Gasification converts solid biomass into a combustible gas (producer gas or syngas) by heating it at about 700 to 1,200 degrees Celsius with a limited supply of oxygen or air. Complete burning needs sufficient oxygen, while pyrolysis takes place in the absence of oxygen.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At below 100 degrees Celsius with microorganisms in the absence of oxygen', false, 0),
      (v_question_id, 'At about 700 to 1,200 degrees Celsius in the complete absence of oxygen', false, 1),
      (v_question_id, 'At about 700 to 1,200 degrees Celsius with a limited supply of oxygen or air', true, 2),
      (v_question_id, 'At 100 to 200 degrees Celsius with a large excess of air', false, 3);
  END IF;

  -- 15. Producer gas vs syngas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly distinguishes producer gas from syngas (synthetic gas)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly distinguishes producer gas from syngas (synthetic gas)?', 'single_choice', 'medium', 'Producer gas is made by gasifying carbonaceous material with air, which contains a high amount of nitrogen. Syngas is a combustible mixture consisting primarily of hydrogen and carbon monoxide, typically produced using pure oxygen or steam instead of air.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Producer gas is produced by gasifying with air (high in nitrogen), while syngas is mainly hydrogen and carbon monoxide produced with pure oxygen or steam', true, 0),
      (v_question_id, 'Producer gas consists primarily of methane and carbon dioxide, while syngas consists primarily of nitrogen', false, 1),
      (v_question_id, 'Producer gas and syngas are produced only through anaerobic digestion', false, 2),
      (v_question_id, 'Producer gas is produced using pure oxygen or steam, while syngas is produced using air', false, 3);
  END IF;

  -- 16. Pyrolysis products
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Pyrolysis is the thermal decomposition of biomass in the absence of oxygen. Which set lists its three primary products?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Pyrolysis is the thermal decomposition of biomass in the absence of oxygen. Which set lists its three primary products?', 'single_choice', 'easy', 'Pyrolysis yields three primary products: liquid bio-oil, syngas, and solid biochar.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Biodiesel, glycerol, and methanol', false, 0),
      (v_question_id, 'Biogas, digestate, and carbon dioxide', false, 1),
      (v_question_id, 'Producer gas, ethanol, and glycerol', false, 2),
      (v_question_id, 'Bio-oil, syngas, and biochar', true, 3);
  END IF;

  -- 17. Carbonization
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which term describes a form of slow pyrolysis aimed at producing charcoal?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which term describes a form of slow pyrolysis aimed at producing charcoal?', 'single_choice', 'easy', 'Carbonization is a form of slow pyrolysis aimed at producing charcoal. Gasification, in contrast, aims at a combustible gas, and combustion is the complete burning of biomass with sufficient oxygen to produce heat.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Anaerobic digestion', false, 0),
      (v_question_id, 'Gasification', false, 1),
      (v_question_id, 'Carbonization', true, 2),
      (v_question_id, 'Combustion', false, 3);
  END IF;

  -- 18. Thermochemical vs biochemical conversion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which biomass conversion route is most suitable for wet biomass with high moisture content?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which biomass conversion route is most suitable for wet biomass with high moisture content?', 'single_choice', 'easy', 'Biochemical conversion, which uses microorganisms and enzymes (for example anaerobic digestion or fermentation), is most suitable for wet biomass. Thermochemical conversion, which includes gasification, pyrolysis and combustion, is generally faster and is suited to dry biomass.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pyrolysis and carbonization', false, 0),
      (v_question_id, 'Biochemical conversion such as anaerobic digestion', true, 1),
      (v_question_id, 'Combustion in a stove', false, 2),
      (v_question_id, 'Gasification', false, 3);
  END IF;

  -- 19. Non-combustible components of producer gas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Producer gas is a mixture of carbon monoxide, hydrogen, methane, nitrogen, and carbon dioxide. Which two components do not burn and therefore lower its heating value?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Producer gas is a mixture of carbon monoxide, hydrogen, methane, nitrogen, and carbon dioxide. Which two components do not burn and therefore lower its heating value?', 'single_choice', 'medium', 'Carbon monoxide, hydrogen and methane are combustible. Nitrogen (high because the gas is produced with air) and carbon dioxide do not burn, so they dilute the gas and reduce its heating value.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Nitrogen and carbon dioxide', true, 0),
      (v_question_id, 'Methane and carbon dioxide', false, 1),
      (v_question_id, 'Hydrogen and methane', false, 2),
      (v_question_id, 'Carbon monoxide and hydrogen', false, 3);
  END IF;

  -- 20. Fixed bed operation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In which type of gasifier bed is the fuel bed held stationary, with loading of feedstock and removal of char done in batches?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In which type of gasifier bed is the fuel bed held stationary, with loading of feedstock and removal of char done in batches?', 'single_choice', 'easy', 'In a fixed bed gasifier the fuel bed is stationary and the loading of feedstock and removal of char are done in batches, so operation is not continuous. A moving bed permits continuous operation, while a fluidized bed moves the feedstock in a stream of inert gases.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Moving bed', false, 0),
      (v_question_id, 'Fixed bed', true, 1),
      (v_question_id, 'Fluidized bed', false, 2),
      (v_question_id, 'All bed types operate in batches', false, 3);
  END IF;

  -- 21. Fluidized bed requirements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of gasifier bed requires accurate fuel feeding and close temperature control, with the feedstock moving in a stream inside long reactors together with inert gases?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of gasifier bed requires accurate fuel feeding and close temperature control, with the feedstock moving in a stream inside long reactors together with inert gases?', 'single_choice', 'medium', 'A fluidized bed gasifier moves the feedstock in a stream inside the reactor with inert gases, so it needs accurate fuel feeding and close temperature control. A fixed bed is operated in batches and a moving bed gradually moves the fuel down the reactor as char is discharged.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fluidized bed', true, 0),
      (v_question_id, 'Fixed bed', false, 1),
      (v_question_id, 'Updraft fixed bed', false, 2),
      (v_question_id, 'Moving bed', false, 3);
  END IF;

  -- 22. Gasifier bed classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Gasifier reactors are classified according to how the fuel bed is held or moved in the reactor. Which list gives the three bed types?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Gasifier reactors are classified according to how the fuel bed is held or moved in the reactor. Which list gives the three bed types?', 'single_choice', 'easy', 'By the way the fuel bed is held or moved, gasifier reactors are classified as fixed bed, moving bed, and fluidized bed. Updraft, downdraft and cross draft refer to the direction of air and gas flow, while batch and continuous refer to the mode of operation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Updraft, downdraft, and cross draft', false, 0),
      (v_question_id, 'Batch, semi-continuous, and continuous', false, 1),
      (v_question_id, 'Top lit, bottom lit, and side lit', false, 2),
      (v_question_id, 'Fixed bed, moving bed, and fluidized bed', true, 3);
  END IF;

  -- 23. Cross draft gasifier
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In which mode of gasification is air introduced perpendicular to the fire zone, making gas production unpredictable when not enough char is produced in the bed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In which mode of gasification is air introduced perpendicular to the fire zone, making gas production unpredictable when not enough char is produced in the bed?', 'single_choice', 'medium', 'In a cross draft gasifier, air is introduced perpendicular to the fire zone. Gas production becomes unpredictable when not enough char is produced in the bed. In an updraft gasifier air passes upward through the bed, and in a downdraft gasifier air and gas move downward.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Downdraft', false, 0),
      (v_question_id, 'Semi-continuous', false, 1),
      (v_question_id, 'Cross draft', true, 2),
      (v_question_id, 'Updraft', false, 3);
  END IF;

  -- 24. Updraft gasifier tar
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Compared with a downdraft gasifier, what is the main drawback of an updraft gasifier when its gas is to be used in an internal combustion engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Compared with a downdraft gasifier, what is the main drawback of an updraft gasifier when its gas is to be used in an internal combustion engine?', 'single_choice', 'medium', 'In an updraft gasifier air passes upward through the fuel bed and the gas leaves at the top after passing through the pyrolysis zone, so it carries large amounts of tar and smoke. The gas therefore needs thorough cleaning before it can fuel an internal combustion engine.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The gas contains no hydrogen', false, 0),
      (v_question_id, 'The gas can only be used for diesel engines', false, 1),
      (v_question_id, 'The gas contains large amounts of tar and smoke that require thorough cleaning', true, 2),
      (v_question_id, 'The gas has no combustible components', false, 3);
  END IF;

  -- 25. Top-lit ignition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Why is top-lit fuel ignition effective for a downdraft-type gasifier?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Why is top-lit fuel ignition effective for a downdraft-type gasifier?', 'single_choice', 'medium', 'Igniting the fuel from the top is effective for the downdraft-type gasifier because it produces less tar and smoke during operation. It is not the location prescribed for the continuous-type moving bed.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It produces less tar and smoke during operation', true, 0),
      (v_question_id, 'It lets the reactor operate continuously without char discharge', false, 1),
      (v_question_id, 'It increases the heating value of the gas to above 5,000 kcal/m3', false, 2),
      (v_question_id, 'It removes the need for air supply', false, 3);
  END IF;

  -- 26. Downdraft zone sequence
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a downdraft gasifier, what is the correct sequence of zones from the fuel inlet at the top to the ash at the bottom?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a downdraft gasifier, what is the correct sequence of zones from the fuel inlet at the top to the ash at the bottom?', 'single_choice', 'medium', 'In a downdraft gasifier the fuel passes downward through the drying zone, the pyrolysis zone, the oxidation zone, and the reduction zone before the ash is discharged. Air enters at the oxidation zone and the gas leaves at the bottom.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drying, pyrolysis, oxidation, reduction', true, 0),
      (v_question_id, 'Drying, oxidation, pyrolysis, reduction', false, 1),
      (v_question_id, 'Reduction, oxidation, pyrolysis, drying', false, 2),
      (v_question_id, 'Pyrolysis, drying, oxidation, reduction', false, 3);
  END IF;

  -- 27. Updraft zone sequence
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In an updraft gasifier, air enters at the bottom and gas leaves at the top. Which zone lies directly above the combustion zone near the grate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In an updraft gasifier, air enters at the bottom and gas leaves at the top. Which zone lies directly above the combustion zone near the grate?', 'single_choice', 'medium', 'In an updraft gasifier the zones from top to bottom are drying, pyrolysis, reduction and combustion, above the ash pit. The reduction zone therefore lies directly above the combustion zone, where hot gases from the combustion zone reduce to combustible gases.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drying zone', false, 0),
      (v_question_id, 'Reduction zone', true, 1),
      (v_question_id, 'Pyrolysis zone', false, 2),
      (v_question_id, 'Ash pit', false, 3);
  END IF;

  -- 28. Selecting engine rating from design power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The computed design power for an engine drive is 21 hp. The available engine ratings are 15 hp, 20 hp, 25 hp, and 30 hp. Following the rule of choosing the next higher rated power, which engine drive is selected?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The computed design power for an engine drive is 21 hp. The available engine ratings are 15 hp, 20 hp, 25 hp, and 30 hp. Following the rule of choosing the next higher rated power, which engine drive is selected?', 'single_choice', 'medium', 'Given: Pd = 21 hp. The computed design power is not the engine to be purchased. The designer chooses the next higher rated power, which is 25 hp, and carries that value into the succeeding computations. Ratings of 15 hp and 20 hp are below the requirement.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15 hp', false, 0),
      (v_question_id, '20 hp', false, 1),
      (v_question_id, '30 hp', false, 2),
      (v_question_id, '25 hp', true, 3);
  END IF;

  -- 29. Brake thermal efficiency of CI engine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In sizing a diesel (compression ignition) engine for a gasifier-powered system, the brake thermal efficiency is normally taken within which range?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In sizing a diesel (compression ignition) engine for a gasifier-powered system, the brake thermal efficiency is normally taken within which range?', 'single_choice', 'medium', 'The brake thermal efficiency of a compression ignition engine falls within the 30 to 40 percent range.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 to 40 percent', true, 0),
      (v_question_id, '50 to 60 percent', false, 1),
      (v_question_id, '70 to 80 percent', false, 2),
      (v_question_id, '10 to 20 percent', false, 3);
  END IF;

  -- 30. Belt drive transmission efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What transmission efficiency range is normally used for a belt drive between the engine and the driven machine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What transmission efficiency range is normally used for a belt drive between the engine and the driven machine?', 'single_choice', 'medium', 'A belt drive has a transmission efficiency of 80 to 85 percent, which is used with the brake thermal efficiency in computing the required engine power.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '95 to 100 percent', false, 0),
      (v_question_id, '20 to 30 percent', false, 1),
      (v_question_id, '50 to 60 percent', false, 2),
      (v_question_id, '80 to 85 percent', true, 3);
  END IF;

  -- 31. Allowable specific gasification rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the allowable range of the specific gasification rate used in designing a rice husk gasifier reactor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the allowable range of the specific gasification rate used in designing a rice husk gasifier reactor?', 'single_choice', 'medium', 'The allowable specific gasification rate is 70 to 210 kg/hr-m2. The selected value is used to compute the reactor cross-sectional area from the fuel consumption rate.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 to 30 kg/hr-m2', false, 0),
      (v_question_id, '70 to 210 kg/hr-m2', true, 1),
      (v_question_id, '250 to 400 kg/hr-m2', false, 2),
      (v_question_id, '30 to 50 kg/hr-m2', false, 3);
  END IF;

  -- 32. Allowable fire zone rate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the allowable fire zone rate in a rice husk gasifier reactor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the allowable fire zone rate in a rice husk gasifier reactor?', 'single_choice', 'medium', 'The allowable fire zone rate is 1 to 3 cm/min. A computed value of about 1.7 cm/min, for example, is acceptable.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.1 to 0.3 cm/min', false, 0),
      (v_question_id, '20 to 30 cm/min', false, 1),
      (v_question_id, '1 to 3 cm/min', true, 2),
      (v_question_id, '5 to 10 cm/min', false, 3);
  END IF;

  -- 33. Allowable dust in gas stream
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a gasifier whose producer gas will fuel an engine, what is the allowable amount of dust particulates in the gas stream, according to the usual design limits?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a gasifier whose producer gas will fuel an engine, what is the allowable amount of dust particulates in the gas stream, according to the usual design limits?', 'single_choice', 'medium', 'The allowable dust in the gas stream is 50 mg/m3 and below, preferably 5 mg/m3. These limits drive the sizing of the gas conditioning train, namely the particle separator, wet scrubber or heat exchanger, and the series of filters.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '500 mg/m3 and below, preferably 50 mg/m3', false, 0),
      (v_question_id, '50 mg/m3 and below, preferably 5 mg/m3', true, 1),
      (v_question_id, '5,000 mg/m3 and below', false, 2),
      (v_question_id, '0.5 mg/m3 and below, preferably 0.05 mg/m3', false, 3);
  END IF;

END $$;
