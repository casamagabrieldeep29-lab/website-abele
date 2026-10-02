-- Renewable and Alternative Farm Power Sources quiz batch (48 questions, 1
-- topic). Every fact/problem/worked-answer is drawn directly from the
-- "AB Renewable Energy Engineering" review-problem decks (Introduction;
-- Solar Thermal; Solar Photovoltaic; Wind Pump; Biogas Digestion, each with
-- answer keys) plus two Philippine national standards: PAES 413:2001
-- (Agricultural Structures - Biogas Plant) and PNS/BAFS 324:2022 (Solar
-- Powered Irrigation System - Specifications) -- all read in full
-- (2026-10-02). No invented facts. This topic had only 10 published
-- questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- except for 8 questions grounded in the two PAES/PNS standards named above,
-- which carry the standard code in paes_reference.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Renewable and Alternative Farm Power Sources (POWER_ENERGY_MACHINERY) — 48 question(s)
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

  -- 1. RA 10915 - ABE practice act
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which Republic Act regulates the practice of agricultural and biosystems engineering in the Philippines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which Republic Act regulates the practice of agricultural and biosystems engineering in the Philippines?', 'single_choice', 'easy', 'RA 10915 is the law regulating the practice of agricultural and biosystems engineering in the Philippines.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Republic Act No. 8749', false, 0),
      (v_question_id, 'Republic Act No. 9513', false, 1),
      (v_question_id, 'Republic Act No. 10915', true, 2),
      (v_question_id, 'Republic Act No. 9367', false, 3);
  END IF;

  -- 2. RA 9513 - Renewable Energy Act of 2008
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which law is known as the Renewable Energy Act of 2008?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which law is known as the Renewable Energy Act of 2008?', 'single_choice', 'easy', 'RA 9513, the Renewable Energy Act of 2008, promotes the development and utilization of renewable energy resources in the Philippines.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Republic Act No. 8559', false, 0),
      (v_question_id, 'Republic Act No. 9513', true, 1),
      (v_question_id, 'Republic Act No. 8749', false, 2),
      (v_question_id, 'Republic Act No. 9367', false, 3);
  END IF;

  -- 3. FIT solar power (2012)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As of 2012, what was the Feed-In Tariff (FIT) rate for solar power under the Philippine FIT system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As of 2012, what was the Feed-In Tariff (FIT) rate for solar power under the Philippine FIT system?', 'single_choice', 'medium', 'As of 2012, solar power had the highest FIT rate at P9.68 per kWh among the renewable energy sources covered by the FIT system.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P9.68 per kWh', true, 0),
      (v_question_id, 'P8.53 per kWh', false, 1),
      (v_question_id, 'P5.80 per kWh', false, 2),
      (v_question_id, 'P6.63 per kWh', false, 3);
  END IF;

  -- 4. FIT biomass power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As of 2012, what was the Feed-In Tariff (FIT) rate for biomass power under the Philippine FIT system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As of 2012, what was the Feed-In Tariff (FIT) rate for biomass power under the Philippine FIT system?', 'single_choice', 'medium', 'Biomass power had a FIT rate of P6.63 per kWh as of 2012.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P9.68 per kWh', false, 0),
      (v_question_id, 'P8.53 per kWh', false, 1),
      (v_question_id, 'P5.80 per kWh', false, 2),
      (v_question_id, 'P6.63 per kWh', true, 3);
  END IF;

  -- 5. FIT wind power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As of 2012, what was the Feed-In Tariff (FIT) rate for wind power under the Philippine FIT system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As of 2012, what was the Feed-In Tariff (FIT) rate for wind power under the Philippine FIT system?', 'single_choice', 'medium', 'Wind power had a FIT rate of P8.53 per kWh as of 2012, the second highest among the four renewable energy sources with FIT rates.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P9.68 per kWh', false, 0),
      (v_question_id, 'P8.53 per kWh', true, 1),
      (v_question_id, 'P5.80 per kWh', false, 2),
      (v_question_id, 'P6.63 per kWh', false, 3);
  END IF;

  -- 6. FIT hydro power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As of 2012, what was the Feed-In Tariff (FIT) rate for hydro power under the Philippine FIT system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As of 2012, what was the Feed-In Tariff (FIT) rate for hydro power under the Philippine FIT system?', 'single_choice', 'medium', 'Run-of-river hydro power had the lowest FIT rate at P5.80 per kWh as of 2012.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P9.68 per kWh', false, 0),
      (v_question_id, 'P8.53 per kWh', false, 1),
      (v_question_id, 'P5.80 per kWh', true, 2),
      (v_question_id, 'P6.63 per kWh', false, 3);
  END IF;

  -- 7. Coal - biomass but not renewable
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is considered as biomass but not renewable?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is considered as biomass but not renewable?', 'single_choice', 'medium', 'Coal is derived from ancient organic (biomass) material but, unlike rice husk, is non-renewable since it takes geologic time scales to form.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Peat', false, 0),
      (v_question_id, 'Rice husk', false, 1),
      (v_question_id, 'Coal', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 8. OTEC
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which renewable energy technology harnesses the temperature difference between warm surface waters and cold deep ocean waters to generate electricity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which renewable energy technology harnesses the temperature difference between warm surface waters and cold deep ocean waters to generate electricity?', 'single_choice', 'medium', 'Ocean Thermal Energy Conversion (OTEC) exploits the temperature gradient between warm surface seawater and cold deep seawater to generate electricity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ocean Thermal Energy Converter', true, 0),
      (v_question_id, 'Wave Energy Converter', false, 1),
      (v_question_id, 'Tidal Energy Converter', false, 2),
      (v_question_id, 'Wind Turbine', false, 3);
  END IF;

  -- 9. Tidal energy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Tidal energy is derived from the natural rise and fall of ocean ______, which harnesses the kinetic energy of moving water to generate electricity through turbines or barrages.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Tidal energy is derived from the natural rise and fall of ocean ______, which harnesses the kinetic energy of moving water to generate electricity through turbines or barrages.', 'single_choice', 'easy', 'Tidal energy harnesses the kinetic energy of the rise and fall of ocean tides using turbines or barrages.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'waves', false, 0),
      (v_question_id, 'heat', false, 1),
      (v_question_id, 'tides', true, 2),
      (v_question_id, 'currents', false, 3);
  END IF;

  -- 10. Thermoelectric chip
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which device converts heat directly into electricity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which device converts heat directly into electricity?', 'single_choice', 'easy', 'A thermoelectric chip converts heat directly into electricity, unlike a photovoltaic cell which converts light into electricity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Solar collector', false, 0),
      (v_question_id, 'Photovoltaic cell', false, 1),
      (v_question_id, 'Thermoelectric chip', true, 2),
      (v_question_id, 'Solar panel', false, 3);
  END IF;

  -- 11. Average solar power density
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the average power density of solar heat striking the earth''s surface?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the average power density of solar heat striking the earth''s surface?', 'single_choice', 'easy', 'The average power density of solar heat striking the earth''s surface is about 0.89 kW/m² (the solar constant above the atmosphere is about 1.35 kW/m², but surface values are lower due to atmospheric losses).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 kW/m²', false, 0),
      (v_question_id, '0.89 kW/m²', true, 1),
      (v_question_id, '0.58 kW/m²', false, 2),
      (v_question_id, '1.35 kW/m²', false, 3);
  END IF;

  -- 12. Basis of collector inclination
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the basis for determining the degree of inclination of a solar collector?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the basis for determining the degree of inclination of a solar collector?', 'single_choice', 'easy', 'The degree of inclination of a solar collector is based on the latitude of the location to maximize solar energy capture.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Latitude of the place', true, 0),
      (v_question_id, 'Longitude of the place', false, 1),
      (v_question_id, 'Elevation of the place', false, 2),
      (v_question_id, 'Time zone of the place', false, 3);
  END IF;

  -- 13. Equator solar radiation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A place located near the equator will receive ______ solar radiation than places far from it.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A place located near the equator will receive ______ solar radiation than places far from it.', 'single_choice', 'easy', 'Locations near the equator receive more solar radiation than locations farther from it.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'less', false, 0),
      (v_question_id, 'the same amount of', false, 1),
      (v_question_id, 'more', true, 2),
      (v_question_id, 'no', false, 3);
  END IF;

  -- 14. Flat-plate collector sizing problem
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine the size of a flat-plate solar collector perpendicularly inclined at 11 degrees to the direction of sunlight, required to supply thermal heat to a fruit dryer that consumes 1000 kcal per hour of heat energy. Assume a 0.89 kW/m² average power density and a 0.77 transmission factor.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Determine the size of a flat-plate solar collector perpendicularly inclined at 11 degrees to the direction of sunlight, required to supply thermal heat to a fruit dryer that consumes 1000 kcal per hour of heat energy. Assume a 0.89 kW/m² average power density and a 0.77 transmission factor.', 'single_choice', 'hard', 'Using the given 1000 kcal/hr heat demand, 0.89 kW/m² average solar power density, and 0.77 transmission factor for a collector inclined 11 degrees to the sunlight, the required collector area works out to 14.15 m².', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.32 m²', false, 0),
      (v_question_id, '12.65 m²', false, 1),
      (v_question_id, '14.15 m²', true, 2),
      (v_question_id, '16.80 m²', false, 3);
  END IF;

  -- 15. Solar cooker efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the collection efficiency of a solar cooker that delivers 1 kW of thermal energy to a cooking pot if it has a 1.2 m² collector area? The average power density is 0.89 kW/m².';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the collection efficiency of a solar cooker that delivers 1 kW of thermal energy to a cooking pot if it has a 1.2 m² collector area? The average power density is 0.89 kW/m².', 'single_choice', 'hard', 'Collection efficiency = useful heat output ÷ (power density × collector area) = 1 kW ÷ (0.89 kW/m² × 1.2 m²) ≈ 93.6%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '81.7%', false, 0),
      (v_question_id, '89.3%', false, 1),
      (v_question_id, '93.6%', true, 2),
      (v_question_id, '97.2%', false, 3);
  END IF;

  -- 16. Water heating power requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two hundred liters of water is to be heated from 30°C to 80°C in 1 hour using solar heat. What is the power required to heat the given amount of water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two hundred liters of water is to be heated from 30°C to 80°C in 1 hour using solar heat. What is the power required to heat the given amount of water?', 'single_choice', 'medium', 'Heating 200 L (200 kg) of water through a 50°C rise in 1 hour requires about 12 kW of power.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9 kW', false, 0),
      (v_question_id, '11 kW', false, 1),
      (v_question_id, '12 kW', true, 2),
      (v_question_id, '14 kW', false, 3);
  END IF;

  -- 17. Tube-type solar collector area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the area of a tube-type solar collector required to heat 200 liters of water (from 30°C to 80°C in 1 hour) if the collection efficiency is 80% and the collector is oriented directly to the sunlight? The average power density of the sun is 0.89 kW/m².';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the area of a tube-type solar collector required to heat 200 liters of water (from 30°C to 80°C in 1 hour) if the collection efficiency is 80% and the collector is oriented directly to the sunlight? The average power density of the sun is 0.89 kW/m².', 'single_choice', 'hard', 'With an 80% collection efficiency and 0.89 kW/m² average power density, the collector area needed to deliver the required heating power is about 16.8 m².', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '14.3 m²', false, 0),
      (v_question_id, '16.8 m²', true, 1),
      (v_question_id, '19.6 m²', false, 2),
      (v_question_id, '22.4 m²', false, 3);
  END IF;

  -- 18. Optimize heat absorbing capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How can a solar collector''s heat-absorbing capacity be optimized?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How can a solar collector''s heat-absorbing capacity be optimized?', 'single_choice', 'easy', 'Painting the solar collector surface with dull black color increases its ability to absorb solar heat.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Increasing its insulation thickness', false, 0),
      (v_question_id, 'Providing the collector surface with a glass mirror', false, 1),
      (v_question_id, 'Painting the collector with dull black color', true, 2),
      (v_question_id, 'Using a transparent cover only', false, 3);
  END IF;

  -- 19. Concentrating reflector effect
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A concentrating reflector ______ the radiation intensity on the absorbing surface.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A concentrating reflector ______ the radiation intensity on the absorbing surface.', 'single_choice', 'medium', 'A concentrating reflector focuses sunlight to increase the radiation intensity striking the absorbing surface.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'increases', true, 0),
      (v_question_id, 'decreases', false, 1),
      (v_question_id, 'maintains', false, 2),
      (v_question_id, 'has no effect on', false, 3);
  END IF;

  -- 20. Photovoltaic device
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which device generates electricity from sunlight?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which device generates electricity from sunlight?', 'single_choice', 'easy', 'A photovoltaic cell converts sunlight directly into electricity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Wind pump', false, 0),
      (v_question_id, 'Photovoltaic cell', true, 1),
      (v_question_id, 'Generator', false, 2),
      (v_question_id, 'Thermoelectric chip', false, 3);
  END IF;

  -- 21. Ampere-hour capacity calc
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 12-volt solar panel system requires a capacity of 73.6 watt-hours. What is the ampere-hour capacity of the battery needed for the system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 12-volt solar panel system requires a capacity of 73.6 watt-hours. What is the ampere-hour capacity of the battery needed for the system?', 'single_choice', 'medium', 'Ampere-hour capacity = watt-hour ÷ voltage = 73.6 Wh ÷ 12 V ≈ 6.13 Ah.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.13 ampere-hour', true, 0),
      (v_question_id, '4.05 ampere-hour', false, 1),
      (v_question_id, '7.23 ampere-hour', false, 2),
      (v_question_id, '8.50 ampere-hour', false, 3);
  END IF;

  -- 22. Series vs parallel modules
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If a 12-volt solar module output is required using two 12-volt modules, how should the two modules be connected?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If a 12-volt solar module output is required using two 12-volt modules, how should the two modules be connected?', 'single_choice', 'medium', 'Connecting two 12-volt modules in parallel keeps the system voltage at 12 volts while increasing current capacity; connecting them in series would double the voltage instead.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Series', false, 0),
      (v_question_id, 'Parallel', true, 1),
      (v_question_id, 'Perpendicular', false, 2),
      (v_question_id, 'Either series or parallel, it does not matter', false, 3);
  END IF;

  -- 23. Size of 1 peak-watt solar cell
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the approximate size of a solar cell that has the capacity to produce 1 peak watt?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the approximate size of a solar cell that has the capacity to produce 1 peak watt?', 'single_choice', 'easy', 'A solar cell of about 10 cm x 10 cm can typically produce around 1 peak watt.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 cm x 10 cm', true, 0),
      (v_question_id, '5 cm x 10 cm', false, 1),
      (v_question_id, '10 cm x 20 cm', false, 2),
      (v_question_id, '15 cm x 15 cm', false, 3);
  END IF;

  -- 24. Lead-acid battery volts per cell
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lead-acid battery basically has how many volts per cell?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lead-acid battery basically has how many volts per cell?', 'single_choice', 'easy', 'A lead-acid battery cell has a nominal voltage of about 2 volts per cell.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 volts', false, 0),
      (v_question_id, '3 volts', false, 1),
      (v_question_id, '2 volts', true, 2),
      (v_question_id, '1 volt', false, 3);
  END IF;

  -- 25. Mono-crystalline silicon module efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the efficiency of a commonly used mono-crystalline silicon solar module?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the efficiency of a commonly used mono-crystalline silicon solar module?', 'single_choice', 'medium', 'Commonly used mono-crystalline silicon solar modules have an efficiency of around 14%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '14%', true, 0),
      (v_question_id, '20%', false, 1),
      (v_question_id, '32%', false, 2),
      (v_question_id, '45%', false, 3);
  END IF;

  -- 26. Solar cell power vs temperature
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How does the power output of a solar cell change with an increase in temperature?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How does the power output of a solar cell change with an increase in temperature?', 'single_choice', 'medium', 'The power output of a solar cell decreases as its operating temperature increases.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It increases', false, 0),
      (v_question_id, 'It decreases', true, 1),
      (v_question_id, 'It remains the same', false, 2),
      (v_question_id, 'It becomes zero', false, 3);
  END IF;

  -- 27. Wind power calculation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Wind is moving at 4 meters per second over a rotor with an area of 2 m². What is the wind power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Wind is moving at 4 meters per second over a rotor with an area of 2 m². What is the wind power?', 'single_choice', 'hard', 'Using the wind power formula P = 1/2 x density x area x velocity^3 with an air density of 1.25 kg/m³, rotor area of 2 m², and wind speed of 4 m/s: P = 0.5 x 1.25 x 2 x 4^3 = 80 watts.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80 watts', true, 0),
      (v_question_id, '95 watts', false, 1),
      (v_question_id, '125 watts', false, 2),
      (v_question_id, '160 watts', false, 3);
  END IF;

  -- 28. Vertical-axis windpump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which wind machine used for water pumping has its axis of rotation perpendicular to the wind direction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which wind machine used for water pumping has its axis of rotation perpendicular to the wind direction?', 'single_choice', 'medium', 'A vertical-axis rotor windpump rotates about an axis perpendicular to the direction of the wind.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Horizontal-axis rotor windpump', false, 0),
      (v_question_id, 'Vertical-axis rotor windpump', true, 1),
      (v_question_id, 'Cross-flow rotor windpump', false, 2),
      (v_question_id, 'Savonius-type windpump', false, 3);
  END IF;

  -- 29. Doubling wind speed effect
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 2-meter diameter wind rotor is initially exposed to wind at 2 m/s. If the wind speed suddenly doubles to 4 m/s, by what factor does the power output of the windmill increase?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 2-meter diameter wind rotor is initially exposed to wind at 2 m/s. If the wind speed suddenly doubles to 4 m/s, by what factor does the power output of the windmill increase?', 'single_choice', 'medium', 'Wind power is proportional to the cube of wind speed, so doubling the wind speed increases power output by 2 cubed = 8 times.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 times', false, 0),
      (v_question_id, '6 times', false, 1),
      (v_question_id, '8 times', true, 2),
      (v_question_id, '2 times', false, 3);
  END IF;

  -- 30. Windpump in silty groundwater
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A windpump is to be installed in an area where groundwater has a lot of silt. As an Agricultural Engineer, which course of action would you recommend for the suction pipe of the wind pump?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A windpump is to be installed in an area where groundwater has a lot of silt. As an Agricultural Engineer, which course of action would you recommend for the suction pipe of the wind pump?', 'single_choice', 'medium', 'A concrete dug-well casing helps filter out silt from the groundwater before it is drawn into the windpump''s suction pipe.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Use a 4-inch pump casing for the suction pipe', false, 0),
      (v_question_id, 'Use a 4-inch pump casing with fine screen mesh for the suction pipe', false, 1),
      (v_question_id, 'Use a concrete dug-well casing for the suction pipe', true, 2),
      (v_question_id, 'Use an uncased open suction pipe', false, 3);
  END IF;

  -- 31. Doubling rotor diameter effect
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Doubling the diameter of the horizontal-axis rotor of a wind machine will increase its power by ______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Doubling the diameter of the horizontal-axis rotor of a wind machine will increase its power by ______.', 'single_choice', 'medium', 'Wind power is proportional to the swept area of the rotor, which is proportional to the square of its diameter, so doubling the diameter increases power by 2 squared = 4 times.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'two times', false, 0),
      (v_question_id, 'four times', true, 1),
      (v_question_id, 'eight times', false, 2),
      (v_question_id, 'sixteen times', false, 3);
  END IF;

  -- 32. Windpump rotor speed limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The speed of a horizontal-axis rotor windpump is typically limited up to how many rpm?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The speed of a horizontal-axis rotor windpump is typically limited up to how many rpm?', 'single_choice', 'medium', 'Horizontal-axis rotor windpumps are typically limited to a rotational speed of up to 30 rpm, since windpumps are designed for high torque rather than high speed.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 rpm', false, 0),
      (v_question_id, '30 rpm', true, 1),
      (v_question_id, '40 rpm', false, 2),
      (v_question_id, '50 rpm', false, 3);
  END IF;

  -- 33. Deep-water windpump drive
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A windpump used for deep-water pumping is usually provided with which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A windpump used for deep-water pumping is usually provided with which of the following?', 'single_choice', 'medium', 'Deep-water windpumps are typically equipped with a gear-reduction drive to convert the rotor''s low-speed, high-torque rotation into the pumping action needed to lift water from greater depths.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Direct-drive transmission', false, 0),
      (v_question_id, 'Gear-reduction drive', true, 1),
      (v_question_id, 'Chain-reduction drive', false, 2),
      (v_question_id, 'Belt-drive transmission', false, 3);
  END IF;

  -- 34. Solidity definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term describes the ratio of the area of the rotor surface facing the wind to the total swept area of the rotor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term describes the ratio of the area of the rotor surface facing the wind to the total swept area of the rotor?', 'single_choice', 'medium', 'Solidity is the ratio of the rotor blade area facing the wind to the total swept area of the rotor.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Solidity', true, 0),
      (v_question_id, 'Angle of swept', false, 1),
      (v_question_id, 'Rotor coefficient', false, 2),
      (v_question_id, 'Power coefficient', false, 3);
  END IF;

  -- 35. Feed-material-to-water ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the feed-material-to-water ratio for optimum biogas generation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the feed-material-to-water ratio for optimum biogas generation?', 'single_choice', 'medium', 'The recommended feed-material-to-water ratio for optimum biogas generation is 1:0.5 to 1:1.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1:0.5 to 1:1', true, 0),
      (v_question_id, '1:1 to 1:2', false, 1),
      (v_question_id, '1:2 to 1:3', false, 2),
      (v_question_id, '1:3 to 1:4', false, 3);
  END IF;

  -- 36. Digester capacity calculation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biogas digester is to be designed to accommodate 30 liters of dung per day. If the feed-material-to-water ratio is 1:1 and the designed retention time is 80 days, what is the capacity of the digester?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A biogas digester is to be designed to accommodate 30 liters of dung per day. If the feed-material-to-water ratio is 1:1 and the designed retention time is 80 days, what is the capacity of the digester?', 'single_choice', 'hard', 'At a 1:1 feed-to-water ratio, 30 L of dung is mixed with 30 L of water, giving 60 L of slurry per day. Over an 80-day retention time, digester capacity = 60 L/day x 80 days = 4,800 liters.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4,800 liters', true, 0),
      (v_question_id, '5,200 liters', false, 1),
      (v_question_id, '6,100 liters', false, 2),
      (v_question_id, '7,400 liters', false, 3);
  END IF;

  -- 37. Poultry manure calculation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tunnel-ventilated poultry farm is composed of 5 buildings with 30,000 birds per building. How many kilos of manure is available in each building if the birds stay there for 30 days? Consider a manure yield of 0.025 kg/day/bird.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tunnel-ventilated poultry farm is composed of 5 buildings with 30,000 birds per building. How many kilos of manure is available in each building if the birds stay there for 30 days? Consider a manure yield of 0.025 kg/day/bird.', 'single_choice', 'hard', 'Manure per building = 30,000 birds x 0.025 kg/day/bird x 30 days = 22,500 kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18,500 kg', false, 0),
      (v_question_id, '20,875 kg', false, 1),
      (v_question_id, '22,500 kg', true, 2),
      (v_question_id, '24,000 kg', false, 3);
  END IF;

  -- 38. Heating value of biogas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the approximate heating value of biogas?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the approximate heating value of biogas?', 'single_choice', 'medium', 'Biogas has a heating value of approximately 5,500 kcal/m³.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,500 kcal/m³', true, 0),
      (v_question_id, '7,200 kcal/m³', false, 1),
      (v_question_id, '9,468 kcal/m³', false, 2),
      (v_question_id, '11,000 kcal/m³', false, 3);
  END IF;

  -- 39. Biogas replacing diesel
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using biogas as fuel for an engine can replace what percentage of diesel fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Using biogas as fuel for an engine can replace what percentage of diesel fuel?', 'single_choice', 'medium', 'Biogas used as engine fuel can replace up to 80% of the diesel fuel requirement, with the engine still needing a small amount of diesel as pilot fuel for ignition.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60%', false, 0),
      (v_question_id, '80%', true, 1),
      (v_question_id, '100%', false, 2),
      (v_question_id, '40%', false, 3);
  END IF;

  -- 40. Biogas vs natural gas methane content
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following statements about biogas and natural gas is true?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following statements about biogas and natural gas is true?', 'single_choice', 'medium', 'Biogas typically contains 50-70% methane, which is lower than the methane content of natural gas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The methane content of biogas is higher than that of natural gas', false, 0),
      (v_question_id, 'The methane content of biogas is lower than that of natural gas', true, 1),
      (v_question_id, 'The methane content of biogas is the same as that of natural gas', false, 2),
      (v_question_id, 'Biogas contains no methane', false, 3);
  END IF;

  -- 41. PAES 413:2001 - biogas plant components
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Philippine Agricultural Engineering Standards for biogas plants, which set of components make up a biogas plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Philippine Agricultural Engineering Standards for biogas plants, which set of components make up a biogas plant?', 'single_choice', 'easy', 'Per PAES 413:2001, a biogas plant is a plant used to process animal wastes or manure to produce biogas and sludge, consisting of an inlet/mixing tank, digester, gas chamber, and outlet/sludge tank.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Inlet/mixing tank, digester, gas chamber, and outlet/sludge tank', true, 0),
      (v_question_id, 'Digester and gas chamber only', false, 1),
      (v_question_id, 'Mixing tank and gasholder only', false, 2),
      (v_question_id, 'Digester, stirrer, and flame arrester only', false, 3);
  END IF;

  -- 42. PAES 413:2001 - mesophilic temperature range
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the Philippine Agricultural Engineering Standard for biogas plants, what is the mesophilic temperature range within which mesophilic bacteria operate during anaerobic fermentation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the Philippine Agricultural Engineering Standard for biogas plants, what is the mesophilic temperature range within which mesophilic bacteria operate during anaerobic fermentation?', 'single_choice', 'medium', 'PAES 413:2001 defines the mesophilic temperature range as 20°C to 40°C, within which mesophilic bacteria carry out anaerobic digestion, with temperature fluctuations limited to plus or minus 1°C per hour.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10°C - 20°C', false, 0),
      (v_question_id, '20°C - 40°C', true, 1),
      (v_question_id, '40°C - 60°C', false, 2),
      (v_question_id, '60°C - 80°C', false, 3);
  END IF;

  -- 43. PAES 413:2001 - C/N ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 413:2001, what carbon-to-nitrogen (C/N) ratio range is recommended for the anaerobic digestion of organic materials in a biogas plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 413:2001, what carbon-to-nitrogen (C/N) ratio range is recommended for the anaerobic digestion of organic materials in a biogas plant?', 'single_choice', 'medium', 'PAES 413:2001 recommends a C/N ratio within the range of 1:20 to 1:30 for anaerobic digestion, and states the ratio should not exceed 1:35.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1:5 to 1:10', false, 0),
      (v_question_id, '1:20 to 1:30', true, 1),
      (v_question_id, '1:40 to 1:50', false, 2),
      (v_question_id, '1:60 to 1:70', false, 3);
  END IF;

  -- 44. PAES 413:2001 - retention time for pig manure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on the retention-time table in PAES 413:2001 for biogas plants operating at mesophilic temperature, what is the recommended retention time for liquid pig manure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Based on the retention-time table in PAES 413:2001 for biogas plants operating at mesophilic temperature, what is the recommended retention time for liquid pig manure?', 'single_choice', 'medium', 'PAES 413:2001 specifies a retention time of 15 to 25 days for liquid pig manure at mesophilic temperature, which is shorter than that recommended for liquid cow/carabao manure (20-30 days) or animal manure mixed with plant material (50-80 days).', NULL, NULL, 'draft', false, NULL, true, 'PAES 413:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 - 10 days', false, 0),
      (v_question_id, '15 - 25 days', true, 1),
      (v_question_id, '30 - 40 days', false, 2),
      (v_question_id, '50 - 80 days', false, 3);
  END IF;

  -- 45. PNS/BAFS 324:2022 - SPIS definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PNS/BAFS 324:2022, how is a Solar Powered Irrigation System (SPIS) defined?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PNS/BAFS 324:2022, how is a Solar Powered Irrigation System (SPIS) defined?', 'single_choice', 'easy', 'PNS/BAFS 324:2022 defines an SPIS as an irrigation system powered by solar energy, using PV technology, which converts solar energy into electrical energy to run a DC or AC motor-based water pump.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS 324:2022')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An irrigation system powered by solar energy using PV technology, converting solar energy into electrical energy to run a DC or AC motor-based water pump', true, 0),
      (v_question_id, 'Any irrigation system that uses electricity from the grid', false, 1),
      (v_question_id, 'A rain-fed irrigation system with no mechanical pump', false, 2),
      (v_question_id, 'An irrigation canal system oriented to maximize sunlight exposure', false, 3);
  END IF;

  -- 46. PNS/BAFS 324:2022 - PV module gustiness and uplift
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS 324:2022, what is the minimum gustiness and uplift that PV modules in a Solar Powered Irrigation System shall be able to withstand?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS 324:2022, what is the minimum gustiness and uplift that PV modules in a Solar Powered Irrigation System shall be able to withstand?', 'single_choice', 'medium', 'PNS/BAFS 324:2022 requires PV modules to withstand a minimum gustiness and uplift of 180 kph, with a standard degradation of at least 0.5% annually per IEC 61215-1:2021.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS 324:2022')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 kph', false, 0),
      (v_question_id, '140 kph', false, 1),
      (v_question_id, '180 kph', true, 2),
      (v_question_id, '220 kph', false, 3);
  END IF;

  -- 47. PNS/BAFS 324:2022 - inverter capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PNS/BAFS 324:2022, how should the capacity of the inverter in a Solar Powered Irrigation System compare to the pumpset''s input power requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PNS/BAFS 324:2022, how should the capacity of the inverter in a Solar Powered Irrigation System compare to the pumpset''s input power requirement?', 'single_choice', 'medium', 'PNS/BAFS 324:2022 specifies that the capacity of the inverter shall be at least 25% higher than the pumpset''s input power requirement.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS 324:2022')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least 25% higher than the pumpset input power requirement', true, 0),
      (v_question_id, 'Exactly equal to the pumpset input power requirement', false, 1),
      (v_question_id, 'At least 50% lower than the pumpset input power requirement', false, 2),
      (v_question_id, 'Twice the pumpset input power requirement', false, 3);
  END IF;

  -- 48. PNS/BAFS 324:2022 - PV module warranty
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the warranty requirements of PNS/BAFS 324:2022 for Solar Powered Irrigation Systems, what warranty coverage should PV modules have?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the warranty requirements of PNS/BAFS 324:2022 for Solar Powered Irrigation Systems, what warranty coverage should PV modules have?', 'single_choice', 'medium', 'PNS/BAFS 324:2022 requires PV modules to have at least 10 years of material warranty and 25 years of performance warranty, while pumps, workmanship, and inverters each require at least a one-year warranty.', NULL, NULL, 'draft', false, NULL, true, 'PNS/BAFS 324:2022')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least 10 years for material warranty and 25 years for performance warranty', true, 0),
      (v_question_id, 'At least 1 year for both material and performance warranty', false, 1),
      (v_question_id, 'At least 5 years for material warranty only', false, 2),
      (v_question_id, 'No warranty is required for PV modules', false, 3);
  END IF;

END $$;
