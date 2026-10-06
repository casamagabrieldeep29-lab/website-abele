-- Renewable and Alternative Farm Power Sources quiz batch 3 (40 questions, 1
-- topic). Every fact, formula and worked answer is drawn directly from the
-- reference library: the Renewable Energy Act of 2008 (RA 9513), PAES
-- 413:2001 (Agricultural Structures - Biogas Plant), PNS/BAFS 324:2022 and
-- PNS/BAFS 325:2022 (Solar Powered Irrigation System - Specifications and
-- Methods of Test) and answer-keyed review material on solar, wind, hydro,
-- biogas, biofuel and biomass power -- no invented facts. Computation items state every given value
-- in the question text. Existing published and draft questions of this topic
-- (see renewable-farm-power-import.sql) are not repeated.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- except for 7 questions grounded in PAES 413:2001, PNS/BAFS 324:2022 or
-- PNS/BAFS 325:2022, which carry the standard code in paes_reference.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Renewable and Alternative Farm Power Sources (POWER_ENERGY_MACHINERY) — 40 question(s)
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
    RAISE EXCEPTION 'Topic not found: Renewable and Alternative Farm Power Sources';
  END IF;

  -- 1. Lead agency of the Renewable Energy Act
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Renewable Energy Act of 2008 (RA 9513), which government agency is mandated as the lead agency in implementing the Act?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Renewable Energy Act of 2008 (RA 9513), which government agency is mandated as the lead agency in implementing the Act?', 'single_choice', 'easy', 'RA 9513 designates the Department of Energy (DOE) as the lead agency mandated to implement the Act. The DOE also certifies RE developers, registers them, and issues the certifications needed to avail of the incentives.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Department of Science and Technology (DOST)', false, 0),
      (v_question_id, 'Department of Environment and Natural Resources (DENR)', false, 1),
      (v_question_id, 'Energy Regulatory Commission (ERC)', false, 2),
      (v_question_id, 'Department of Energy (DOE)', true, 3);
  END IF;

  -- 2. Biofuels Act
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which Republic Act is known as the Biofuel Act of 2006 of the Philippines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which Republic Act is known as the Biofuel Act of 2006 of the Philippines?', 'single_choice', 'easy', 'The Biofuel Act of 2006 is Republic Act No. 9367. RA 9513 is the Renewable Energy Act of 2008, RA 8749 is the Clean Air Act, and RA 9136 is the Electric Power Industry Reform Act.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'RA 9136', false, 0),
      (v_question_id, 'RA 9367', true, 1),
      (v_question_id, 'RA 8749', false, 2),
      (v_question_id, 'RA 9513', false, 3);
  END IF;

  -- 3. Resources covered by the feed-in tariff system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Renewable Energy Act of 2008 mandates a feed-in tariff (FIT) system for electricity produced from emerging renewable energy resources. Which of the following resources is NOT among those named for the FIT system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Renewable Energy Act of 2008 mandates a feed-in tariff (FIT) system for electricity produced from emerging renewable energy resources. Which of the following resources is NOT among those named for the FIT system?', 'single_choice', 'medium', 'Section 7 of RA 9513 mandates the FIT system for electricity produced from wind, solar, ocean, run-of-river hydropower and biomass. Geothermal is not one of the resources named for the FIT.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geothermal', true, 0),
      (v_question_id, 'Biomass', false, 1),
      (v_question_id, 'Run-of-river hydropower', false, 2),
      (v_question_id, 'Solar', false, 3);
  END IF;

  -- 4. Minimum period of fixed FIT rates
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the feed-in tariff system of the Renewable Energy Act of 2008, the mandated number of years for the application of the fixed tariff rates shall be not less than how many years?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the feed-in tariff system of the Renewable Energy Act of 2008, the mandated number of years for the application of the fixed tariff rates shall be not less than how many years?', 'single_choice', 'medium', 'Section 7(c) of RA 9513 requires the ERC to determine the fixed tariff for each type of emerging renewable energy and the mandated number of years for applying these rates, which shall not be less than twelve (12) years.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 years', false, 0),
      (v_question_id, '20 years', false, 1),
      (v_question_id, '12 years', true, 2),
      (v_question_id, '5 years', false, 3);
  END IF;

  -- 5. Income tax holiday of RE developers
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Renewable Energy Act of 2008, a duly registered RE developer is exempt from income taxes levied by the National Government for the first how many years of its commercial operations (Income Tax Holiday)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Renewable Energy Act of 2008, a duly registered RE developer is exempt from income taxes levied by the National Government for the first how many years of its commercial operations (Income Tax Holiday)?', 'single_choice', 'easy', 'Section 15(a) of RA 9513 grants a duly registered RE developer an Income Tax Holiday (ITH), exempting it from national income taxes for the first seven (7) years of its commercial operations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 years', false, 0),
      (v_question_id, '7 years', true, 1),
      (v_question_id, '10 years', false, 2),
      (v_question_id, '5 years', false, 3);
  END IF;

  -- 6. Corporate tax rate after the ITH
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'After the seven-year Income Tax Holiday, what corporate tax rate on net taxable income shall registered RE developers pay under the Renewable Energy Act of 2008, provided the savings are passed on to end-users as lower power rates?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'After the seven-year Income Tax Holiday, what corporate tax rate on net taxable income shall registered RE developers pay under the Renewable Energy Act of 2008, provided the savings are passed on to end-users as lower power rates?', 'single_choice', 'medium', 'Section 15(e) of RA 9513 provides that after seven years of ITH, all RE developers shall pay a corporate tax of ten percent (10%) on net taxable income, provided the RE developer passes on the savings to the end-users in the form of lower power rates.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', true, 0),
      (v_question_id, '5%', false, 1),
      (v_question_id, '30%', false, 2),
      (v_question_id, '20%', false, 3);
  END IF;

  -- 7. Government share on RE projects and geothermal
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Renewable Energy Act of 2008, the government share on RE development projects is 1% of the gross income of RE developers from the sale of the renewable energy produced. What is the government share for indigenous geothermal energy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Renewable Energy Act of 2008, the government share on RE development projects is 1% of the gross income of RE developers from the sale of the renewable energy produced. What is the government share for indigenous geothermal energy?', 'single_choice', 'medium', 'Section 13 of RA 9513 fixes the government share at one percent (1%) of the gross income of RE resource developers, except for indigenous geothermal energy, which is set at one and a half percent (1.5%) of gross income.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2% of gross income', false, 0),
      (v_question_id, '3% of gross income', false, 1),
      (v_question_id, '0.5% of gross income', false, 2),
      (v_question_id, '1.5% of gross income', true, 3);
  END IF;

  -- 8. Net-metering
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Renewable Energy Act of 2008, net-metering is best described as a system, appropriate for distributed generation, in which a distribution grid user:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the Renewable Energy Act of 2008, net-metering is best described as a system, appropriate for distributed generation, in which a distribution grid user:', 'single_choice', 'medium', 'RA 9513 defines net-metering as a system appropriate for distributed generation in which a distribution grid user has a two-way connection to the grid and is charged only for the net electricity consumption, and is credited for any overall contribution to the electricity grid.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Is disconnected from the grid and supplies only its own load', false, 0),
      (v_question_id, 'Is billed a flat monthly rate regardless of the electricity actually consumed', false, 1),
      (v_question_id, 'Has a two-way connection to the grid, is charged only for net electricity consumption, and is credited for any overall contribution to the grid', true, 2),
      (v_question_id, 'Sells all generated electricity to the grid at the spot-market price and buys all consumption at the retail rate', false, 3);
  END IF;

  -- 9. Geothermal considered renewable
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Renewable Energy Act of 2008, geothermal energy is considered renewable, and the Act applies to it, if the geothermal resource is produced through:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Renewable Energy Act of 2008, geothermal energy is considered renewable, and the Act applies to it, if the geothermal resource is produced through:', 'single_choice', 'medium', 'Section 4 of RA 9513 considers geothermal energy renewable if it is produced through (1) natural recharge, where the water is replenished by rainfall and heat is continuously produced inside the earth, and/or (2) enhanced recharge, where hot water used in the process is re-injected into the ground to produce more steam and provide additional recharge.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One-time extraction of steam without any replenishment of the reservoir', false, 0),
      (v_question_id, 'Artificial heating of injected water using fossil fuels', false, 1),
      (v_question_id, 'Natural recharge only, with any re-injection of water prohibited', false, 2),
      (v_question_id, 'Natural recharge (rainfall replenishes the water, heat is produced inside the earth) and/or enhanced recharge (re-injection of used hot water)', true, 3);
  END IF;

  -- 10. Must-dispatch status of intermittent RE
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Renewable Energy Act of 2008, qualified and registered generating units that use intermittent RE resources (such as wind, solar, run-of-river hydro or ocean energy) are considered ______ based on the available energy and enjoy priority dispatch.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Renewable Energy Act of 2008, qualified and registered generating units that use intermittent RE resources (such as wind, solar, run-of-river hydro or ocean energy) are considered ______ based on the available energy and enjoy priority dispatch.', 'single_choice', 'hard', 'Section 20 of RA 9513 states that qualified and registered RE generating units with intermittent RE resources shall be considered "must dispatch" based on available energy and shall enjoy the benefit of priority dispatch. Intermittent resources are those whose availability is location-specific, hard to predict and inherently uncontrollable, such as wind, solar, run-of-river hydro and ocean.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dispatchable only on demand', false, 0),
      (v_question_id, 'Last-to-dispatch units', false, 1),
      (v_question_id, '"Must dispatch" units', true, 2),
      (v_question_id, 'Peaking-only units', false, 3);
  END IF;

  -- 11. Waste-to-energy technologies
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Renewable Energy Act of 2008 encourages the adoption of waste-to-energy facilities such as biogas systems. Waste-to-energy technologies refer to systems that convert biodegradable materials, such as animal manure or agricultural waste, into useful energy through processes such as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Renewable Energy Act of 2008 encourages the adoption of waste-to-energy facilities such as biogas systems. Waste-to-energy technologies refer to systems that convert biodegradable materials, such as animal manure or agricultural waste, into useful energy through processes such as:', 'single_choice', 'medium', 'Section 30 of RA 9513 defines waste-to-energy technologies as systems that convert biodegradable materials such as animal manure or agricultural waste into useful energy through processes such as anaerobic digestion, fermentation and gasification, among others.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Anaerobic digestion, fermentation and gasification', true, 0),
      (v_question_id, 'Pasteurization, canning and freezing', false, 1),
      (v_question_id, 'Sedimentation, coagulation and sand filtration', false, 2),
      (v_question_id, 'Evaporation, crystallization and drying', false, 3);
  END IF;

  -- 12. Solar constant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the value of the solar constant, the fixed amount of solar energy that reaches the top of the earth''s atmosphere per second on 1 square meter facing the sun?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the value of the solar constant, the fixed amount of solar energy that reaches the top of the earth''s atmosphere per second on 1 square meter facing the sun?', 'single_choice', 'easy', 'The solar constant is the fixed amount of solar energy reaching the top of the earth''s atmosphere, measured per second on 1 m² facing the sun, equal to 1,353 W/m². It is higher than the average power density of solar heat that actually strikes the earth''s surface because the atmosphere absorbs and scatters part of the radiation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,000 W/m²', false, 0),
      (v_question_id, '1,353 W/m²', true, 1),
      (v_question_id, '890 W/m²', false, 2),
      (v_question_id, '580 W/m²', false, 3);
  END IF;

  -- 13. Pyrheliometer
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which instrument is used to measure the direct (beam) solar radiation, as distinguished from the global solar radiation measured by a pyranometer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which instrument is used to measure the direct (beam) solar radiation, as distinguished from the global solar radiation measured by a pyranometer?', 'single_choice', 'medium', 'A pyrheliometer measures direct (beam) solar radiation, while a pyranometer measures global solar radiation (direct plus diffuse). A sunshine recorder measures the duration of sunshine, and a spectroradiometer measures the spectral distribution of solar radiation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pyrheliometer', true, 0),
      (v_question_id, 'Spectroradiometer', false, 1),
      (v_question_id, 'Pyranometer', false, 2),
      (v_question_id, 'Sunshine recorder', false, 3);
  END IF;

  -- 14. Non-tracking solar collector
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of solar collector does NOT have to follow the movement of the sun (non-tracking type)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of solar collector does NOT have to follow the movement of the sun (non-tracking type)?', 'single_choice', 'easy', 'The flat-plate-type collector is the non-tracking type. Concentrating-type collectors, such as parabolic trough and parabolic dish collectors, must follow the movement of the sun to keep the radiation focused on the absorber.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Parabolic trough collector', false, 0),
      (v_question_id, 'Parabolic dish collector', false, 1),
      (v_question_id, 'Concentrating-type collector', false, 2),
      (v_question_id, 'Flat-plate-type collector', true, 3);
  END IF;

  -- 15. Solar cooker collection efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A solar cooker has a collector area of 1.5 m² and delivers 0.9 kW of thermal energy to the cooking pot. If the average power density of the sun is 0.89 kW/m², what is the collection efficiency of the solar cooker?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A solar cooker has a collector area of 1.5 m² and delivers 0.9 kW of thermal energy to the cooking pot. If the average power density of the sun is 0.89 kW/m², what is the collection efficiency of the solar cooker?', 'single_choice', 'medium', 'Given: collector area = 1.5 m², delivered heat = 0.9 kW, power density = 0.89 kW/m². Solar input = 0.89 × 1.5 = 1.335 kW. Collection efficiency = 0.9 / 1.335 = 0.674 = 67.4%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '89.0%', false, 0),
      (v_question_id, '67.4%', true, 1),
      (v_question_id, '60.0%', false, 2),
      (v_question_id, '148.3%', false, 3);
  END IF;

  -- 16. Collector area for a solar water heater
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A solar water heater is to heat 150 liters of water (1 kg per liter) from 28 °C to 68 °C in 2 hours. The specific heat of water is 4.186 kJ/kg-°C, the collection efficiency is 70%, and the collector faces the sun directly with an average power density of 0.89 kW/m². What collector area is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A solar water heater is to heat 150 liters of water (1 kg per liter) from 28 °C to 68 °C in 2 hours. The specific heat of water is 4.186 kJ/kg-°C, the collection efficiency is 70%, and the collector faces the sun directly with an average power density of 0.89 kW/m². What collector area is required?', 'single_choice', 'hard', 'Given: m = 150 kg, temperature rise = 68 - 28 = 40 °C, time = 2 h = 7,200 s, cp = 4.186 kJ/kg-°C, efficiency = 0.70, power density = 0.89 kW/m². Heat required = 150 × 4.186 × 40 = 25,116 kJ. Power required = 25,116 / 7,200 = 3.488 kW. Collector area = 3.488 / (0.70 × 0.89) = 5.60 m².', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.92 m²', false, 0),
      (v_question_id, '2.74 m²', false, 1),
      (v_question_id, '5.60 m²', true, 2),
      (v_question_id, '11.20 m²', false, 3);
  END IF;

  -- 17. PV modules in series and parallel
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A solar pumping system uses four PV modules, each rated 75 watt-peak with a nominal voltage of 12 volts. The modules are arranged as two series strings of two modules each, and the two strings are connected in parallel. What are the nominal system voltage and the total rated power of the array?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A solar pumping system uses four PV modules, each rated 75 watt-peak with a nominal voltage of 12 volts. The modules are arranged as two series strings of two modules each, and the two strings are connected in parallel. What are the nominal system voltage and the total rated power of the array?', 'single_choice', 'medium', 'Modules in series add their voltages, so each string is 2 × 12 = 24 V. Strings in parallel keep the same voltage (and add current), so the system voltage remains 24 V. The rated powers add: 4 × 75 = 300 watt-peak.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 V and 300 watt-peak', true, 0),
      (v_question_id, '48 V and 300 watt-peak', false, 1),
      (v_question_id, '24 V and 150 watt-peak', false, 2),
      (v_question_id, '12 V and 300 watt-peak', false, 3);
  END IF;

  -- 18. Peak power of a charging channel
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A solar battery charging station has 18 PV modules, each rated 100 watt-peak, divided equally into 6 charging channels. In each channel the modules are connected in parallel. If the overall efficiency is 75%, what is the peak solar power generation per charging channel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A solar battery charging station has 18 PV modules, each rated 100 watt-peak, divided equally into 6 charging channels. In each channel the modules are connected in parallel. If the overall efficiency is 75%, what is the peak solar power generation per charging channel?', 'single_choice', 'medium', 'Given: 18 modules, 100 Wp each, 6 channels, overall efficiency 75%. Modules per channel = 18 / 6 = 3. Rated power per channel = 3 × 100 = 300 W. Peak power generation per channel = 300 × 0.75 = 225 W.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 W', false, 0),
      (v_question_id, '300 W', false, 1),
      (v_question_id, '1,350 W', false, 2),
      (v_question_id, '225 W', true, 3);
  END IF;

  -- 19. Daily PV energy yield from insolation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A PV array has a total area of 12 m² and receives a solar insolation of 5.0 kWh/m² per day. The modules have an efficiency of 16%, and the other system losses (wiring, controller and battery) leave 80% of the module output as usable energy. How much usable electrical energy does the system deliver per day?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A PV array has a total area of 12 m² and receives a solar insolation of 5.0 kWh/m² per day. The modules have an efficiency of 16%, and the other system losses (wiring, controller and battery) leave 80% of the module output as usable energy. How much usable electrical energy does the system deliver per day?', 'single_choice', 'medium', 'Given: area = 12 m², insolation = 5.0 kWh/m²-day, module efficiency = 0.16, system factor = 0.80. Incident solar energy = 5.0 × 12 = 60 kWh/day. Module output = 60 × 0.16 = 9.6 kWh/day. Usable energy = 9.6 × 0.80 = 7.68 kWh/day.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60.0 kWh/day', false, 0),
      (v_question_id, '9.60 kWh/day', false, 1),
      (v_question_id, '7.68 kWh/day', true, 2),
      (v_question_id, '48.0 kWh/day', false, 3);
  END IF;

  -- 20. Charge controller types in an SPIS
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the classification of controllers for a Solar Powered Irrigation System, the two types of charge controller are:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the classification of controllers for a Solar Powered Irrigation System, the two types of charge controller are:', 'single_choice', 'medium', 'PNS/BAFS 324:2022 classifies controllers as inverter or charge controller. The two types of charge controller are Maximum Power Point Tracking (MPPT) and Pulse Width Modulation (PWM). Surface/submersible pumpsets and open/closed channels are other classifications in the same standard.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS 324:2022')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Surface pumpset and submersible pumpset', false, 0),
      (v_question_id, 'Maximum Power Point Tracking (MPPT) and Pulse Width Modulation (PWM)', true, 1),
      (v_question_id, 'Open channel and closed channel', false, 2),
      (v_question_id, 'Floating drum and fixed dome', false, 3);
  END IF;

  -- 21. System efficiency of a solar powered irrigation system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a performance test of a Solar Powered Irrigation System, the pump discharge is 0.004 m³/s at a total head of 15 m. The solar irradiance is 900 W/m² and the total surface area of the solar array is 10 m². Using a specific weight of water of 9,810 N/m³, what is the system efficiency, defined as the hydraulic output of the pumpset divided by the total solar input power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a performance test of a Solar Powered Irrigation System, the pump discharge is 0.004 m³/s at a total head of 15 m. The solar irradiance is 900 W/m² and the total surface area of the solar array is 10 m². Using a specific weight of water of 9,810 N/m³, what is the system efficiency, defined as the hydraulic output of the pumpset divided by the total solar input power?', 'single_choice', 'hard', 'Given: Q = 0.004 m³/s, H = 15 m, specific weight = 9,810 N/m³, I = 900 W/m², A = 10 m². The system efficiency is gamma × Q × H / (I × A). Hydraulic output = 9,810 × 0.004 × 15 = 588.6 W. Solar input = 900 × 10 = 9,000 W. Efficiency = 588.6 / 9,000 = 0.0654 = 6.54%.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS 325:2022')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '65.4%', false, 0),
      (v_question_id, '6.54%', true, 1),
      (v_question_id, '0.65%', false, 2),
      (v_question_id, '3.27%', false, 3);
  END IF;

  -- 22. Theoretical wind power of a rotor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A wind rotor has a diameter of 4 m and the wind speed is 6 m/s. Taking the air density as 1.25 kg/m³, what is the theoretical power of the wind passing through the rotor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A wind rotor has a diameter of 4 m and the wind speed is 6 m/s. Taking the air density as 1.25 kg/m³, what is the theoretical power of the wind passing through the rotor?', 'single_choice', 'medium', 'Given: D = 4 m, V = 6 m/s, air density = 1.25 kg/m³. Swept area A = π × D² / 4 = π × 16 / 4 = 12.566 m². Theoretical power P = 1/2 × density × A × V³ = 0.5 × 1.25 × 12.566 × 216 = 1,696 W.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '283 W', false, 0),
      (v_question_id, '6,786 W', false, 1),
      (v_question_id, '3,393 W', false, 2),
      (v_question_id, '1,696 W', true, 3);
  END IF;

  -- 23. Electrical output of a wind turbine using a power coefficient
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A wind turbine has a rotor diameter of 3 m and the wind speed is 7 m/s. Taking the air density as 1.25 kg/m³ and an overall power coefficient of 0.20 for conversion to electrical power, what is the available electrical power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A wind turbine has a rotor diameter of 3 m and the wind speed is 7 m/s. Taking the air density as 1.25 kg/m³ and an overall power coefficient of 0.20 for conversion to electrical power, what is the available electrical power?', 'single_choice', 'hard', 'Given: D = 3 m, V = 7 m/s, air density = 1.25 kg/m³, power coefficient = 0.20. Swept area A = π × 3² / 4 = 7.069 m². Theoretical power = 0.5 × 1.25 × 7.069 × 343 = 1,515 W. Available electrical power = theoretical power × power coefficient = 1,515 × 0.20 = 303 W.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '894 W', false, 0),
      (v_question_id, '1,515 W', false, 1),
      (v_question_id, '303 W', true, 2),
      (v_question_id, '1,212 W', false, 3);
  END IF;

  -- 24. Tip speed ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A wind turbine with a rotor diameter of 2 m turns at 120 rpm in a wind speed of 5 m/s. What is its tip speed ratio, defined as the blade tip speed divided by the wind speed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A wind turbine with a rotor diameter of 2 m turns at 120 rpm in a wind speed of 5 m/s. What is its tip speed ratio, defined as the blade tip speed divided by the wind speed?', 'single_choice', 'medium', 'Given: D = 2 m, N = 120 rpm, wind speed V = 5 m/s. Blade tip speed = π × D × N / 60 = π × 2 × 120 / 60 = 12.57 m/s. Tip speed ratio = 12.57 / 5 = 2.51.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.51', true, 0),
      (v_question_id, '1.26', false, 1),
      (v_question_id, '150.8', false, 2),
      (v_question_id, '5.03', false, 3);
  END IF;

  -- 25. Pump location of a windpump for a deep well
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A windpump is to lift water from a well in which the water level is 40 ft below the ground surface. Where is it recommended to install the pump?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A windpump is to lift water from a well in which the water level is 40 ft below the ground surface. Where is it recommended to install the pump?', 'single_choice', 'medium', 'A lift of 40 ft (about 12 m) is beyond the practical suction lift of a pump set at the ground surface. For such a deep well the pump should be installed in the well near the level of the water, so that the windpump pushes the water up through the drop pipe.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At the ground surface', false, 0),
      (v_question_id, 'In the well, near the level of the water', true, 1),
      (v_question_id, 'At a level 1 meter from the ground surface', false, 2),
      (v_question_id, 'At the top of the tower beside the rotor', false, 3);
  END IF;

  -- 26. Power output of a micro-scale hydro system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A micro-hydro site has a flow of 250 liters per second falling through a head of 20 m. Assuming an overall efficiency of 60%, a water density of 1,000 kg/m³ and g = 9.81 m/s², what is the power output of the hydro system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A micro-hydro site has a flow of 250 liters per second falling through a head of 20 m. Assuming an overall efficiency of 60%, a water density of 1,000 kg/m³ and g = 9.81 m/s², what is the power output of the hydro system?', 'single_choice', 'medium', 'Given: Q = 250 L/s = 0.25 m³/s, H = 20 m, efficiency = 0.60, density = 1,000 kg/m³, g = 9.81 m/s². Power output = density × g × Q × H × efficiency = 1,000 × 9.81 × 0.25 × 20 × 0.60 = 29,430 W = 29.4 kW.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '81.8 kW', false, 0),
      (v_question_id, '2.94 kW', false, 1),
      (v_question_id, '29.4 kW', true, 2),
      (v_question_id, '49.1 kW', false, 3);
  END IF;

  -- 27. Classification of hydropower plants by capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Hydropower plants are classified by generated power as pico (below 5 kW), micro (5 kW to 100 kW), mini (100 kW to 10 MW), small (10 MW to 25 MW), medium (25 MW to 100 MW) and large (above 100 MW). How is a hydropower plant with an installed capacity of 18 MW classified?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Hydropower plants are classified by generated power as pico (below 5 kW), micro (5 kW to 100 kW), mini (100 kW to 10 MW), small (10 MW to 25 MW), medium (25 MW to 100 MW) and large (above 100 MW). How is a hydropower plant with an installed capacity of 18 MW classified?', 'single_choice', 'medium', 'Given the classification ranges, 18 MW falls between 10 MW and 25 MW, so the plant is classified as small hydro. It is above the mini-hydro range (up to 10 MW) and below the medium range (25 MW and above).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mini hydro', false, 0),
      (v_question_id, 'Large hydro', false, 1),
      (v_question_id, 'Medium hydro', false, 2),
      (v_question_id, 'Small hydro', true, 3);
  END IF;

  -- 28. Scum in a biogas digester
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a biogas digester, what is the layer of floating, mainly fibrous material that forms on top of the slurry called?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a biogas digester, what is the layer of floating, mainly fibrous material that forms on top of the slurry called?', 'single_choice', 'easy', 'Scum is the layer of floating material (mainly fibrous) on the slurry. Sludge is the settled portion or precipitate of the slurry, effluent is the residue that comes out at the outlet after digestion, and the substrate is the organic material used to produce biogas.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Scum', true, 0),
      (v_question_id, 'Effluent', false, 1),
      (v_question_id, 'Sludge', false, 2),
      (v_question_id, 'Substrate', false, 3);
  END IF;

  -- 29. Collecting tank size for a continuous-fed biogas plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a continuous-fed biogas plant, the size of the collecting tank that holds and separates manure from heavy and non-biodegradable materials should not exceed the total slurry volume for how many days?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a continuous-fed biogas plant, the size of the collecting tank that holds and separates manure from heavy and non-biodegradable materials should not exceed the total slurry volume for how many days?', 'single_choice', 'medium', 'For a continuous-fed biogas plant, the collecting tank should not exceed the total slurry volume for 10 days. The slurry volume is the volume occupied by manure and water at a ratio of 1:1 (1 kg of manure : 1 L of water).', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 days', true, 0),
      (v_question_id, '5 days', false, 1),
      (v_question_id, '20 days', false, 2),
      (v_question_id, '3 days', false, 3);
  END IF;

  -- 30. Digester capacity for a piggery
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A piggery has 40 pigs weighing 73 to 91 kg, each producing 8.0 kg of manure per day. The manure is mixed with water at a ratio of 1 kg of manure to 1 L of water, and the retention time is 20 days. What is the required slurry capacity of the digester? (The digester capacity is the daily slurry volume multiplied by the retention time.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A piggery has 40 pigs weighing 73 to 91 kg, each producing 8.0 kg of manure per day. The manure is mixed with water at a ratio of 1 kg of manure to 1 L of water, and the retention time is 20 days. What is the required slurry capacity of the digester? (The digester capacity is the daily slurry volume multiplied by the retention time.)', 'single_choice', 'hard', 'Given: 40 pigs, 8.0 kg manure/day/pig, manure to water = 1:1, retention time = 20 days. Daily manure = 40 × 8.0 = 320 kg. Water = 320 L. Daily slurry = 320 + 320 = 640 L = 0.64 m³. Digester capacity = 0.64 × 20 = 12.8 m³.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '19.2 m³', false, 0),
      (v_question_id, '12.8 m³', true, 1),
      (v_question_id, '25.6 m³', false, 2),
      (v_question_id, '6.4 m³', false, 3);
  END IF;

  -- 31. Gas-tightness test of a digester
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the air-tightness test of a biogas digester, the manhole and gas valves are sealed and the digester is pressurized to 0.4 m of water column, then left for 24 hours. A pressure drop of about how much indicates that the digester is gas tight?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the air-tightness test of a biogas digester, the manhole and gas valves are sealed and the digester is pressurized to 0.4 m of water column, then left for 24 hours. A pressure drop of about how much indicates that the digester is gas tight?', 'single_choice', 'hard', 'After pressurizing to 0.4 m of water column and leaving it for 24 hours, a pressure drop of about 10 mm to 20 mm means the digester is gas tight. A drop of about 50 mm means the dome is not gas tight.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 50 mm', false, 0),
      (v_question_id, '30 mm to 40 mm', false, 1),
      (v_question_id, 'About 100 mm', false, 2),
      (v_question_id, '10 mm to 20 mm', true, 3);
  END IF;

  -- 32. Effective gas chamber volume of a floating-type plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In sizing the effective gas chamber of a floating-type biogas plant, the product of the biogas accumulation rate and the longest duration when all non-continuous gas devices are idle is multiplied by what factor to account for the fluctuation in biogas production?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In sizing the effective gas chamber of a floating-type biogas plant, the product of the biogas accumulation rate and the longest duration when all non-continuous gas devices are idle is multiplied by what factor to account for the fluctuation in biogas production?', 'single_choice', 'hard', 'The product is multiplied by 1.3 to account for the 30% fluctuation in biogas production. The accumulation rate is the biogas production potential less the biogas consumption of each device.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.15', false, 0),
      (v_question_id, '2.0', false, 1),
      (v_question_id, '1.3', true, 2),
      (v_question_id, '1.5', false, 3);
  END IF;

  -- 33. Microorganism that ferments sugar to bioethanol
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which microorganism is responsible for fermenting the sugar in the fermented sap of sugar-rich plants into bioethanol?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which microorganism is responsible for fermenting the sugar in the fermented sap of sugar-rich plants into bioethanol?', 'single_choice', 'easy', 'Yeast ferments sugar into alcohol (bioethanol). Bacteria tend to produce acid instead of alcohol, mold decomposes biomass without producing alcohol or acid, and methanogenic bacteria produce methane in biogas digestion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Acid-forming bacteria', false, 0),
      (v_question_id, 'Yeast', true, 1),
      (v_question_id, 'Methanogenic bacteria', false, 2),
      (v_question_id, 'Mold', false, 3);
  END IF;

  -- 34. Distillation efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 1,000 mL sample of fermented feedstock contains 25% alcohol. After distillation, 280 mL of distillate is recovered with 70% alcohol content. What is the distillation efficiency, defined as the volume of alcohol in the distillate divided by the volume of alcohol in the feedstock?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 1,000 mL sample of fermented feedstock contains 25% alcohol. After distillation, 280 mL of distillate is recovered with 70% alcohol content. What is the distillation efficiency, defined as the volume of alcohol in the distillate divided by the volume of alcohol in the feedstock?', 'single_choice', 'medium', 'Given: feedstock = 1,000 mL at 25% alcohol, distillate = 280 mL at 70% alcohol. Alcohol in the feedstock = 1,000 × 0.25 = 250 mL. Alcohol in the distillate = 280 × 0.70 = 196 mL. Distillation efficiency = 196 / 250 × 100 = 78.4%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '70.0%', false, 0),
      (v_question_id, '28.0%', false, 1),
      (v_question_id, '78.4%', true, 2),
      (v_question_id, '89.3%', false, 3);
  END IF;

  -- 35. Daily ethanol output of a bioethanol plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A bioethanol plant processes 8,000 liters per day of fermented sap containing 12% alcohol. If the distillation efficiency is 85%, what volume of bioethanol can be produced in one day?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A bioethanol plant processes 8,000 liters per day of fermented sap containing 12% alcohol. If the distillation efficiency is 85%, what volume of bioethanol can be produced in one day?', 'single_choice', 'medium', 'Given: 8,000 L/day of sap, 12% alcohol, distillation efficiency = 85%. Alcohol in the sap = 8,000 × 0.12 = 960 L/day. Bioethanol produced = 960 × 0.85 = 816 L/day.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '960 liters per day', false, 0),
      (v_question_id, '6,800 liters per day', false, 1),
      (v_question_id, '1,129 liters per day', false, 2),
      (v_question_id, '816 liters per day', true, 3);
  END IF;

  -- 36. Biodiesel and glycerol in the settling tank
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'After the transesterification of vegetable oil with a potassium hydroxide-methanol mixture, the products separate in the settling tank. Which statement is correct?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'After the transesterification of vegetable oil with a potassium hydroxide-methanol mixture, the products separate in the settling tank. Which statement is correct?', 'single_choice', 'medium', 'In the settling tank the biodiesel (methyl ester) separates and is found at the top of the container, while the heavier glycerol settles at the bottom, where it can be drawn off.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Biodiesel is found at the top and glycerol at the bottom', true, 0),
      (v_question_id, 'Biodiesel evaporates and only glycerol remains in the tank', false, 1),
      (v_question_id, 'Biodiesel and glycerol remain evenly mixed throughout the tank', false, 2),
      (v_question_id, 'Glycerol is found at the top and biodiesel at the bottom', false, 3);
  END IF;

  -- 37. Methoxide tank of a biodiesel plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a biodiesel plant, in which component are potassium hydroxide and methanol mixed together before this solution is used to treat the raw oil in the transesterification process?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a biodiesel plant, in which component are potassium hydroxide and methanol mixed together before this solution is used to treat the raw oil in the transesterification process?', 'single_choice', 'easy', 'Potassium hydroxide and methanol are mixed in the methoxide tank to form potassium methoxide. This solution is then mixed with the clean raw oil in the reaction tank, and the products separate later in the settling tank.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Settling tank', false, 0),
      (v_question_id, 'Methoxide tank', true, 1),
      (v_question_id, 'Reaction tank', false, 2),
      (v_question_id, 'Raw oil tank', false, 3);
  END IF;

  -- 38. Thermal efficiency of a biomass stove
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A wood-fired stove heats 3 kg of water from 25 °C to 100 °C and then evaporates 0.4 kg of the water. The stove consumes 1.0 kg of wood with a heating value of 4,000 kcal/kg. Taking the specific heat of water as 1 kcal/kg-°C and the heat of vaporization as 540 kcal/kg, what is the thermal efficiency of the stove?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A wood-fired stove heats 3 kg of water from 25 °C to 100 °C and then evaporates 0.4 kg of the water. The stove consumes 1.0 kg of wood with a heating value of 4,000 kcal/kg. Taking the specific heat of water as 1 kcal/kg-°C and the heat of vaporization as 540 kcal/kg, what is the thermal efficiency of the stove?', 'single_choice', 'medium', 'Given: 3 kg water heated from 25 to 100 °C, 0.4 kg evaporated, 1.0 kg wood at 4,000 kcal/kg, cp = 1 kcal/kg-°C, hfg = 540 kcal/kg. Sensible heat = 3 × 1 × (100 - 25) = 225 kcal. Latent heat = 0.4 × 540 = 216 kcal. Heat used = 225 + 216 = 441 kcal. Heat from fuel = 1.0 × 4,000 = 4,000 kcal. Thermal efficiency = 441 / 4,000 = 11.0%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.6%', false, 0),
      (v_question_id, '14.7%', false, 1),
      (v_question_id, '11.0%', true, 2),
      (v_question_id, '5.4%', false, 3);
  END IF;

  -- 39. Rice husk fuel replacing LPG
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A poultry farm uses three 50-kg LPG cylinders per 24-hour day for brooding heat and will replace the LPG with rice husk. LPG has a heating value of 11,000 kcal/kg, and rice husk has a heating value of 3,000 kcal/kg. The rice husk system delivers 60% of the heating value of the husk as useful heat, while the LPG heat is taken at its full heating value. How many kilograms of rice husk are consumed per hour?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A poultry farm uses three 50-kg LPG cylinders per 24-hour day for brooding heat and will replace the LPG with rice husk. LPG has a heating value of 11,000 kcal/kg, and rice husk has a heating value of 3,000 kcal/kg. The rice husk system delivers 60% of the heating value of the husk as useful heat, while the LPG heat is taken at its full heating value. How many kilograms of rice husk are consumed per hour?', 'single_choice', 'hard', 'Given: 3 × 50 = 150 kg LPG/day, 11,000 kcal/kg, 24 h/day, husk 3,000 kcal/kg, husk system delivers 60%. Heat from LPG = 150 × 11,000 = 1,650,000 kcal/day = 68,750 kcal/h. Useful heat per kg of husk = 3,000 × 0.60 = 1,800 kcal. Rice husk = 68,750 / 1,800 = 38.2 kg/h.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '22.9 kg per hour', false, 0),
      (v_question_id, '13.8 kg per hour', false, 1),
      (v_question_id, '63.7 kg per hour', false, 2),
      (v_question_id, '38.2 kg per hour', true, 3);
  END IF;

  -- 40. Heat output of a furnace in kW
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biomass furnace delivers 3,000 kcal of useful heat per hour. Using 1 kcal = 4.186 kJ, what is the equivalent heat output in kW?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A biomass furnace delivers 3,000 kcal of useful heat per hour. Using 1 kcal = 4.186 kJ, what is the equivalent heat output in kW?', 'single_choice', 'easy', 'Given: 3,000 kcal/h, 1 kcal = 4.186 kJ. Heat = 3,000 × 4.186 = 12,558 kJ/h. Dividing by 3,600 s/h gives 3.49 kJ/s = 3.49 kW.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.49 kW', true, 0),
      (v_question_id, '0.84 kW', false, 1),
      (v_question_id, '12.56 kW', false, 2),
      (v_question_id, '209 kW', false, 3);
  END IF;

END $$;
