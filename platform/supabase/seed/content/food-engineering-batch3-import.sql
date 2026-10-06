-- Food Engineering quiz batch 3 (35 questions, 1 topic). Every fact and figure is
-- taken from reference material in the repository (thermodynamics, heat transfer,
-- psychrometry, refrigeration and food-processing notes) and every computation was
-- re-derived before the answer was marked -- no invented facts. Topics already
-- covered by the existing Food Engineering questions were avoided.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). None of the questions is tied to a specific
-- PAES/PNS clause, so every question has is_paes=false and paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Food Engineering (BIOPROCESS) — 35 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Food Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Food Engineering';
  END IF;

  -- 1. Kelvin-Planck statement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A proposed machine operating in a cycle takes heat from a single furnace and converts all of it into electricity with no waste heat rejected. Which statement of the Second Law of Thermodynamics does it violate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A proposed machine operating in a cycle takes heat from a single furnace and converts all of it into electricity with no waste heat rejected. Which statement of the Second Law of Thermodynamics does it violate?', 'single_choice', 'medium', 'The Kelvin-Planck statement says it is impossible for any device operating on a cycle to receive heat from a single thermal reservoir and produce a net amount of work. A heat engine must reject some heat to a cooler reservoir, so a 100 percent efficient heat engine is impossible. The Clausius statement deals with refrigerators and heat pumps.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The Third Law of Thermodynamics', false, 0),
      (v_question_id, 'The Zeroth Law of Thermodynamics', false, 1),
      (v_question_id, 'The Kelvin-Planck statement', true, 2),
      (v_question_id, 'The Clausius statement', false, 3);
  END IF;

  -- 2. Clausius statement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A designer claims that a refrigerator can keep produce cold in a farm storage room without any electrical or mechanical work input. Which statement of the Second Law of Thermodynamics does this claim violate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A designer claims that a refrigerator can keep produce cold in a farm storage room without any electrical or mechanical work input. Which statement of the Second Law of Thermodynamics does this claim violate?', 'single_choice', 'medium', 'The Clausius statement says it is impossible to construct a device that operates in a cycle and transfers heat from a cooler body to a hotter body without external work. Heat does not flow from cold to hot by itself, so a refrigerator or heat pump needs work input to move heat against the natural flow.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The Kelvin-Planck statement', false, 0),
      (v_question_id, 'The Zeroth Law of Thermodynamics', false, 1),
      (v_question_id, 'Boyle''s law', false, 2),
      (v_question_id, 'The Clausius statement', true, 3);
  END IF;

  -- 3. triple point
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'On the pressure-temperature (P-T) diagram of a pure substance, the point where the vaporization line, the fusion line, and the sublimation line meet is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'On the pressure-temperature (P-T) diagram of a pure substance, the point where the vaporization line, the fusion line, and the sublimation line meet is called the:', 'single_choice', 'easy', 'The triple point is where the vaporization, fusion, and sublimation lines meet, so solid, liquid, and vapor can coexist. The sublimation line lies below the triple point, and across it a substance changes directly between solid and vapor without passing through the liquid phase.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'boiling point', false, 0),
      (v_question_id, 'triple point', true, 1),
      (v_question_id, 'critical point', false, 2),
      (v_question_id, 'saturation point', false, 3);
  END IF;

  -- 4. phase change releasing energy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following phase changes releases energy to the surroundings?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following phase changes releases energy to the surroundings?', 'single_choice', 'easy', 'Condensation, freezing, and deposition release energy. Melting (latent heat of fusion), vaporization (latent heat of vaporization), and sublimation absorb energy.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Melting (solid to liquid)', false, 0),
      (v_question_id, 'Condensation (vapor to liquid)', true, 1),
      (v_question_id, 'Vaporization (liquid to vapor)', false, 2),
      (v_question_id, 'Sublimation (solid to vapor)', false, 3);
  END IF;

  -- 5. conduction ranking
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which arrangement correctly ranks the states of matter from the best to the poorest conductor of heat?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which arrangement correctly ranks the states of matter from the best to the poorest conductor of heat?', 'single_choice', 'easy', 'Conduction passes heat from molecule to molecule through vibration and collisions. Solids are better heat conductors than liquids, and liquids are better conductors than gases.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gases, then liquids, then solids', false, 0),
      (v_question_id, 'Liquids, then solids, then gases', false, 1),
      (v_question_id, 'Solids, then gases, then liquids', false, 2),
      (v_question_id, 'Solids, then liquids, then gases', true, 3);
  END IF;

  -- 6. Grashof number
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Solar drying of grains relies on natural convection. Which dimensionless number represents the ratio of buoyancy to viscous forces and governs natural convection?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Solar drying of grains relies on natural convection. Which dimensionless number represents the ratio of buoyancy to viscous forces and governs natural convection?', 'single_choice', 'medium', 'Natural convection is driven by buoyancy due to temperature differences and is governed by the Grashof number (buoyancy to viscous forces). Forced convection, such as fan-assisted grain drying, is governed by the Reynolds number. The Prandtl number is the ratio of momentum diffusivity to thermal diffusivity, and the Biot number compares internal conduction resistance to surface convection resistance.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grashof number', true, 0),
      (v_question_id, 'Biot number', false, 1),
      (v_question_id, 'Reynolds number', false, 2),
      (v_question_id, 'Prandtl number', false, 3);
  END IF;

  -- 7. Biot number
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Biot number compares the internal resistance to heat conduction within a body to the external convective resistance at its surface. A lumped system, with a uniform temperature inside the solid, is considered valid when the Biot number is typically:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Biot number compares the internal resistance to heat conduction within a body to the external convective resistance at its surface. A lumped system, with a uniform temperature inside the solid, is considered valid when the Biot number is typically:', 'single_choice', 'medium', 'When Bi is much less than 1 (typically below 0.1), the internal temperature gradient is negligible and the lumped system approach is valid. A Biot number above 0.1 means a significant temperature gradient exists within the object.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'equal to 10', false, 0),
      (v_question_id, 'greater than 100', false, 1),
      (v_question_id, 'less than 0.1', true, 2),
      (v_question_id, 'greater than 0.1', false, 3);
  END IF;

  -- 8. counterflow heat exchanger
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among parallel-flow, counterflow, and crossflow arrangements, which heat exchanger arrangement gives the highest efficiency because the temperature difference between the two fluids stays more uniform along the exchanger?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among parallel-flow, counterflow, and crossflow arrangements, which heat exchanger arrangement gives the highest efficiency because the temperature difference between the two fluids stays more uniform along the exchanger?', 'single_choice', 'medium', 'In a counterflow heat exchanger the fluids move in opposite directions, which keeps the temperature difference more uniform and increases the overall heat transfer rate. Parallel flow (same direction) has low efficiency and crossflow (perpendicular) is moderate.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'All three give the same efficiency', false, 0),
      (v_question_id, 'Parallel flow', false, 1),
      (v_question_id, 'Counterflow', true, 2),
      (v_question_id, 'Crossflow', false, 3);
  END IF;

  -- 9. entropy of irreversible process
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In any real (irreversible) process, such as friction, mixing, or spontaneous heat flow, the total entropy of the system plus its surroundings:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In any real (irreversible) process, such as friction, mixing, or spontaneous heat flow, the total entropy of the system plus its surroundings:', 'single_choice', 'medium', 'The total entropy change of the system and surroundings is zero for a reversible process and greater than zero for an irreversible process. In real processes the total entropy always increases.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'decreases', false, 0),
      (v_question_id, 'becomes zero', false, 1),
      (v_question_id, 'remains constant', false, 2),
      (v_question_id, 'increases', true, 3);
  END IF;

  -- 10. quality x numeric
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A saturated water-steam mixture at 101.3 kPa has a specific enthalpy of 2,100 kJ/kg. At this pressure the enthalpy of saturated liquid is 419 kJ/kg and the latent heat of vaporization is 2,257 kJ/kg. What is the quality (vapor mass fraction) of the mixture?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A saturated water-steam mixture at 101.3 kPa has a specific enthalpy of 2,100 kJ/kg. At this pressure the enthalpy of saturated liquid is 419 kJ/kg and the latent heat of vaporization is 2,257 kJ/kg. What is the quality (vapor mass fraction) of the mixture?', 'single_choice', 'medium', 'Given: h = 2,100 kJ/kg; hf = 419 kJ/kg; hfg = 2,257 kJ/kg. Quality x = (h - hf)/hfg = (2,100 - 419)/2,257 = 1,681/2,257 = 0.74.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.74', true, 0),
      (v_question_id, '0.93', false, 1),
      (v_question_id, '0.19', false, 2),
      (v_question_id, '0.80', false, 3);
  END IF;

  -- 11. heat engine work and efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biomass-powered heat engine receives 3,000 kJ of heat from a high-temperature source and rejects 1,200 kJ of heat to the surroundings. What are the work output and the thermal efficiency of the engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A biomass-powered heat engine receives 3,000 kJ of heat from a high-temperature source and rejects 1,200 kJ of heat to the surroundings. What are the work output and the thermal efficiency of the engine?', 'single_choice', 'easy', 'Given: QH = 3,000 kJ; QL = 1,200 kJ. Work output W = QH - QL = 3,000 - 1,200 = 1,800 kJ. Thermal efficiency = W/QH = 1,800/3,000 = 0.60 = 60%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,800 kJ and 40%', false, 0),
      (v_question_id, '1,800 kJ and 60%', true, 1),
      (v_question_id, '4,200 kJ and 40%', false, 2),
      (v_question_id, '4,200 kJ and 60%', false, 3);
  END IF;

  -- 12. Fourier plane wall
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 4-cm-thick wooden panel with thermal conductivity 0.8 W/m·K and an area of 2.0 m² separates two rooms held at 80°C and 30°C. What is the steady heat transfer rate through the panel by conduction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 4-cm-thick wooden panel with thermal conductivity 0.8 W/m·K and an area of 2.0 m² separates two rooms held at 80°C and 30°C. What is the steady heat transfer rate through the panel by conduction?', 'single_choice', 'medium', 'Given: k = 0.8 W/m·K; A = 2.0 m²; L = 0.04 m; ΔT = 80 - 30 = 50 K. By Fourier''s law Q = kAΔT/L = (0.8)(2.0)(50)/0.04 = 2,000 W.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200 W', false, 0),
      (v_question_id, '80 W', false, 1),
      (v_question_id, '2,000 W', true, 2),
      (v_question_id, '1,000 W', false, 3);
  END IF;

  -- 13. composite brick wall heat flux
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A masonry wall consists of 10 cm of facing brick (k = 1.32 W/m·K), 15 cm of common brick (k = 0.69 W/m·K), and 1.25 cm of gypsum plaster (k = 0.48 W/m·K). The outside film coefficient is 30 W/m²·K and the inside film coefficient is 8 W/m²·K. If the outside air is at 35°C and the inside air is conditioned to 22°C, what is the rate of heat gain per unit area of wall?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A masonry wall consists of 10 cm of facing brick (k = 1.32 W/m·K), 15 cm of common brick (k = 0.69 W/m·K), and 1.25 cm of gypsum plaster (k = 0.48 W/m·K). The outside film coefficient is 30 W/m²·K and the inside film coefficient is 8 W/m²·K. If the outside air is at 35°C and the inside air is conditioned to 22°C, what is the rate of heat gain per unit area of wall?', 'single_choice', 'hard', 'Given: x1 = 0.10 m, k1 = 1.32; x2 = 0.15 m, k2 = 0.69; x3 = 0.0125 m, k3 = 0.48; ho = 30; hi = 8; ΔT = 35 - 22 = 13 K. Total resistance = 1/30 + 0.10/1.32 + 0.15/0.69 + 0.0125/0.48 + 1/8 = 0.0333 + 0.0758 + 0.2174 + 0.0260 + 0.1250 = 0.4775 m²·K/W. q = ΔT/R = 13/0.4775 = 27.2 W/m².', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40.7 W/m²', false, 0),
      (v_question_id, '27.2 W/m²', true, 1),
      (v_question_id, '54.4 W/m²', false, 2),
      (v_question_id, '2.09 W/m²', false, 3);
  END IF;

  -- 14. cold storage wall heat gain
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The wall of a cold storage plant is made of an insulating layer (k = 0.2336 kJ/hr·m·°C) 10.16 cm thick held between two concrete layers (k = 3.7382 kJ/hr·m·°C), each 10.16 cm thick. The film coefficients are 81.76 kJ/hr·m²·°C on the outside and 40.88 kJ/hr·m²·°C on the inside. The cold storage is kept at -6.7°C and the ambient temperature is 32.2°C. What is the heat transmitted through a wall area of 55.74 m²?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The wall of a cold storage plant is made of an insulating layer (k = 0.2336 kJ/hr·m·°C) 10.16 cm thick held between two concrete layers (k = 3.7382 kJ/hr·m·°C), each 10.16 cm thick. The film coefficients are 81.76 kJ/hr·m²·°C on the outside and 40.88 kJ/hr·m²·°C on the inside. The cold storage is kept at -6.7°C and the ambient temperature is 32.2°C. What is the heat transmitted through a wall area of 55.74 m²?', 'single_choice', 'hard', 'Given: A = 55.74 m²; ΔT = 32.2 - (-6.7) = 38.9°C. Resistance per m² = 1/81.76 + 0.1016/0.2336 + 2(0.1016/3.7382) + 1/40.88 = 0.01223 + 0.43493 + 0.05436 + 0.02446 = 0.52598 hr·m²·°C/kJ. Q = AΔT/R = (55.74)(38.9)/0.52598 = 4,122 kJ/hr = 4,122/3,600 = 1.145 kW.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.207 kW', false, 0),
      (v_question_id, '1.231 kW', false, 1),
      (v_question_id, '4.12 kW', false, 2),
      (v_question_id, '1.145 kW', true, 3);
  END IF;

  -- 15. black plate radiation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two infinite black plates at 800°C and 300°C exchange heat by radiation. Using a Stefan-Boltzmann constant of 5.669 × 10⁻⁸ W/m²·K⁴, what is the net heat transfer rate per unit area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two infinite black plates at 800°C and 300°C exchange heat by radiation. Using a Stefan-Boltzmann constant of 5.669 × 10⁻⁸ W/m²·K⁴, what is the net heat transfer rate per unit area?', 'single_choice', 'medium', 'Given: T1 = 800 + 273 = 1,073 K; T2 = 300 + 273 = 573 K; σ = 5.669 × 10⁻⁸ W/m²·K⁴; emissivity = 1 for black plates. q/A = σ(T1⁴ - T2⁴) = 5.669 × 10⁻⁸ × (1,073⁴ - 573⁴) = 5.669 × 10⁻⁸ × 1.2178 × 10¹² = 69,035 W/m², or about 69.0 kW/m². Using Celsius temperatures instead of absolute temperatures gives the wrong value.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '69.0 kW/m²', true, 0),
      (v_question_id, '138 kW/m²', false, 1),
      (v_question_id, '22.8 kW/m²', false, 2),
      (v_question_id, '34.5 kW/m²', false, 3);
  END IF;

  -- 16. Dalton law
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the analysis of moist air, the principle that the total pressure of the mixture equals the sum of the partial pressures of dry air and water vapor is known as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the analysis of moist air, the principle that the total pressure of the mixture equals the sum of the partial pressures of dry air and water vapor is known as:', 'single_choice', 'easy', 'Dalton''s law states that the mixture pressure is equal to the sum of the partial pressures of its constituents. For moist air, Pt = Pair + Pvapor.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Newton''s law of cooling', false, 0),
      (v_question_id, 'Charles''s law', false, 1),
      (v_question_id, 'Dalton''s law', true, 2),
      (v_question_id, 'Boyle''s law', false, 3);
  END IF;

  -- 17. psychrometric chart direction
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'On a psychrometric chart, a cooling and humidification process appears as a line that is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'On a psychrometric chart, a cooling and humidification process appears as a line that is:', 'single_choice', 'medium', 'Cooling lowers the dry-bulb temperature, which moves the state point to the left. Humidification raises the humidity ratio, which moves it upward. The combined process is therefore a line running diagonally upwards to the left. (Heating and dehumidification is the opposite, diagonally downwards to the right.)', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'diagonal upwards to the left', true, 0),
      (v_question_id, 'diagonal upwards to the right', false, 1),
      (v_question_id, 'diagonal downwards to the left', false, 2),
      (v_question_id, 'diagonal downwards to the right', false, 3);
  END IF;

  -- 18. humidity ratio computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Air at 34°C has a relative humidity of 65 percent at a barometric pressure of 101.325 kPa. The saturation pressure of water vapor at 34°C is 5.318 kPa. What is the humidity ratio of the air?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Air at 34°C has a relative humidity of 65 percent at a barometric pressure of 101.325 kPa. The saturation pressure of water vapor at 34°C is 5.318 kPa. What is the humidity ratio of the air?', 'single_choice', 'medium', 'Given: T = 34°C; RH = 65%; Patm = 101.325 kPa; Pws = 5.318 kPa. Actual vapor pressure Pw = 0.65 × 5.318 = 3.457 kPa. Humidity ratio W = 0.622 Pw/(Patm - Pw) = 0.622 × 3.457/(101.325 - 3.457) = 2.150/97.868 = 0.0220 kg/kg dry air.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0345 kg water per kg dry air', false, 0),
      (v_question_id, '0.0212 kg water per kg dry air', false, 1),
      (v_question_id, '0.0353 kg water per kg dry air', false, 2),
      (v_question_id, '0.0220 kg water per kg dry air', true, 3);
  END IF;

  -- 19. ton of refrigeration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'One ton of refrigeration (TR) is approximately equal to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'One ton of refrigeration (TR) is approximately equal to:', 'single_choice', 'easy', 'One ton of refrigeration equals 200 BTU/min, or about 211 kJ/min, which is approximately 3.52 kW (3.516 kW).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35.2 kW', false, 0),
      (v_question_id, '3.52 kW', true, 1),
      (v_question_id, '1.00 kW', false, 2),
      (v_question_id, '0.352 kW', false, 3);
  END IF;

  -- 20. COP heat pump vs refrigerator
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A reversible device removes heat QL from a cold space and rejects heat QH to a warm space using work input W. How is its coefficient of performance as a heat pump related to its coefficient of performance as a refrigerator for the same heat transfers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A reversible device removes heat QL from a cold space and rejects heat QH to a warm space using work input W. How is its coefficient of performance as a heat pump related to its coefficient of performance as a refrigerator for the same heat transfers?', 'single_choice', 'medium', 'COP of a refrigerator = QL/(QH - QL) and COP of a heat pump = QH/(QH - QL). Since QH = QL + W, COP of heat pump = 1 + COP of refrigerator, so the COP of a heat pump is always greater than 1.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'COP of heat pump = 1 + COP of refrigerator', true, 0),
      (v_question_id, 'COP of heat pump = COP of refrigerator', false, 1),
      (v_question_id, 'COP of heat pump = 1/(COP of refrigerator)', false, 2),
      (v_question_id, 'COP of heat pump = COP of refrigerator - 1', false, 3);
  END IF;

  -- 21. cold storage heat rejected
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A refrigeration system used for cold storage extracts 750 kJ of heat per cycle from the cold space and has a coefficient of performance of 3.5. How much heat is rejected to the surroundings per cycle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A refrigeration system used for cold storage extracts 750 kJ of heat per cycle from the cold space and has a coefficient of performance of 3.5. How much heat is rejected to the surroundings per cycle?', 'single_choice', 'medium', 'Given: QL = 750 kJ; COP = 3.5. Work input W = QL/COP = 750/3.5 = 214.29 kJ. Heat rejected QH = QL + W = 750 + 214.29 = 964.29 kJ.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2,625 kJ', false, 0),
      (v_question_id, '214.29 kJ', false, 1),
      (v_question_id, '964.29 kJ', true, 2),
      (v_question_id, '750 kJ', false, 3);
  END IF;

  -- 22. Carnot refrigerator minimum power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A refrigerator removes heat from a refrigerated space at -5°C at a rate of 0.35 kJ/s and rejects it to an environment at 20°C. What is the minimum required power input?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A refrigerator removes heat from a refrigerated space at -5°C at a rate of 0.35 kJ/s and rejects it to an environment at 20°C. What is the minimum required power input?', 'single_choice', 'hard', 'Given: TL = -5 + 273 = 268 K; TH = 20 + 273 = 293 K; QL = 0.35 kJ/s. The maximum (Carnot) COP = TL/(TH - TL) = 268/25 = 10.72. Minimum power W = QL/COP = 0.35/10.72 = 0.03265 kW = 32.7 W.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.27 W', false, 0),
      (v_question_id, '32.7 W', true, 1),
      (v_question_id, '350 W', false, 2),
      (v_question_id, '29.9 W', false, 3);
  END IF;

  -- 23. water fountain power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Drinking water is cooled in a refrigerated water fountain from 22°C to 8°C at an average rate of 8 kg/hr. The specific heat of water is 4.187 kJ/kg·K and the COP of the refrigerator is 3.1. What is the required power input?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Drinking water is cooled in a refrigerated water fountain from 22°C to 8°C at an average rate of 8 kg/hr. The specific heat of water is 4.187 kJ/kg·K and the COP of the refrigerator is 3.1. What is the required power input?', 'single_choice', 'medium', 'Given: m = 8 kg/hr; cp = 4.187 kJ/kg·K; ΔT = 22 - 8 = 14 K; COP = 3.1. Heat removal rate QL = (8/3,600)(4.187)(14) = 0.1303 kW = 130.3 W. Power W = QL/COP = 130.3/3.1 = 42 W.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.2 W', false, 0),
      (v_question_id, '404 W', false, 1),
      (v_question_id, '130 W', false, 2),
      (v_question_id, '42 W', true, 3);
  END IF;

  -- 24. vapor compression COP from enthalpies
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a vapor-compression refrigeration system the refrigerant enters the compressor with an enthalpy of 181.79 kJ/kg and leaves it with an enthalpy of 207.3 kJ/kg. After condensation the enthalpy is 58.2 kJ/kg, and the refrigerant is then throttled to the evaporator. What is the coefficient of performance of the system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a vapor-compression refrigeration system the refrigerant enters the compressor with an enthalpy of 181.79 kJ/kg and leaves it with an enthalpy of 207.3 kJ/kg. After condensation the enthalpy is 58.2 kJ/kg, and the refrigerant is then throttled to the evaporator. What is the coefficient of performance of the system?', 'single_choice', 'hard', 'Given: h1 = 181.79 kJ/kg (compressor inlet); h2 = 207.3 kJ/kg (compressor outlet); h3 = h4 = 58.2 kJ/kg (condenser outlet, unchanged by throttling). Refrigerating effect = h1 - h4 = 181.79 - 58.2 = 123.59 kJ/kg. Compressor work = h2 - h1 = 207.3 - 181.79 = 25.51 kJ/kg. COP = 123.59/25.51 = 4.84.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.84', false, 0),
      (v_question_id, '0.21', false, 1),
      (v_question_id, '4.84', true, 2),
      (v_question_id, '0.83', false, 3);
  END IF;

  -- 25. fish freezing product load
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Eight hundred kilograms of fish are cooled from 18°C to -8°C. The specific heat above freezing is 0.7 kcal/kg·°C, the specific heat below freezing is 0.3 kcal/kg·°C, the latent heat of fusion is 61.2 kcal/kg, and the freezing temperature is -3°C. How much heat must be removed from the fish?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Eight hundred kilograms of fish are cooled from 18°C to -8°C. The specific heat above freezing is 0.7 kcal/kg·°C, the specific heat below freezing is 0.3 kcal/kg·°C, the latent heat of fusion is 61.2 kcal/kg, and the freezing temperature is -3°C. How much heat must be removed from the fish?', 'single_choice', 'medium', 'Given: m = 800 kg; cp above = 0.7; cp below = 0.3; hfg = 61.2 kcal/kg; freezing point -3°C. Above freezing: 800 × 0.7 × (18 - (-3)) = 11,760 kcal. Freezing: 800 × 61.2 = 48,960 kcal. Below freezing: 800 × 0.3 × (-3 - (-8)) = 1,200 kcal. Total = 11,760 + 48,960 + 1,200 = 61,920 kcal.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60,960 kcal', false, 0),
      (v_question_id, '12,960 kcal', false, 1),
      (v_question_id, '48,960 kcal', false, 2),
      (v_question_id, '61,920 kcal', true, 3);
  END IF;

  -- 26. air change load
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The storage cooler in a hotel kitchen measures 15 ft × 20 ft × 10 ft. Usage is heavy, equivalent to 9.5 air changes per 24 hours, with 50 percent additional heat allowance. Air density is 0.0751 lb/ft³. The air inside the cooler has an enthalpy of 11.3 BTU/lb and the outside air has an enthalpy of 28.3 BTU/lb. What is the air change load?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The storage cooler in a hotel kitchen measures 15 ft × 20 ft × 10 ft. Usage is heavy, equivalent to 9.5 air changes per 24 hours, with 50 percent additional heat allowance. Air density is 0.0751 lb/ft³. The air inside the cooler has an enthalpy of 11.3 BTU/lb and the outside air has an enthalpy of 28.3 BTU/lb. What is the air change load?', 'single_choice', 'hard', 'Given: V = 15 × 20 × 10 = 3,000 ft³; 9.5 air changes per 24 hr; ρ = 0.0751 lb/ft³; Δh = 28.3 - 11.3 = 17.0 BTU/lb; allowance factor 1.5. Q = (3,000)(9.5/24)(0.0751)(17.0)(1.5) = 1,187.5 ft³/hr × 0.0751 = 89.2 lb/hr; 89.2 × 17.0 = 1,516 BTU/hr; × 1.5 = 2,274 BTU/hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2,274 BTU/hr', true, 0),
      (v_question_id, '1,516 BTU/hr', false, 1),
      (v_question_id, '3,786 BTU/hr', false, 2),
      (v_question_id, '54,578 BTU/hr', false, 3);
  END IF;

  -- 27. sterilization
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which process destroys or eliminates all forms of microbial life, including bacteria, viruses, fungi, and spores, and can be achieved by heat (autoclaving), chemicals, irradiation, or filtration?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which process destroys or eliminates all forms of microbial life, including bacteria, viruses, fungi, and spores, and can be achieved by heat (autoclaving), chemicals, irradiation, or filtration?', 'single_choice', 'easy', 'Sterilization destroys or eliminates all forms of microbial life, including spores. Pasteurization heats food or beverages to a specific temperature for a set time to kill harmful microorganisms and extend shelf life, but it does not eliminate all microbial life.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blanching', false, 0),
      (v_question_id, 'Sterilization', true, 1),
      (v_question_id, 'Curing', false, 2),
      (v_question_id, 'Pasteurization', false, 3);
  END IF;

  -- 28. pasteurized milk
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fresh milk that is heated to a temperature of not lower than 145°F for a period of not less than 30 minutes is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Fresh milk that is heated to a temperature of not lower than 145°F for a period of not less than 30 minutes is classified as:', 'single_choice', 'medium', 'Pasteurized milk is fresh milk heated to 145°F or higher for not less than 30 minutes. Homogenized milk contains fine globules of butterfat made by passing fresh milk through small openings under pressure. Filled milk has butterfat replaced with vegetable fat such as coconut fat, and reconstituted milk is milk powder plus water.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'pasteurized milk', true, 0),
      (v_question_id, 'reconstituted milk', false, 1),
      (v_question_id, 'homogenized milk', false, 2),
      (v_question_id, 'filled milk', false, 3);
  END IF;

  -- 29. size reduction law
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which law of size reduction is best suited to fine grinding of small particles?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which law of size reduction is best suited to fine grinding of small particles?', 'single_choice', 'medium', 'Kick''s law applies to coarse crushing of large particles, Rittinger''s law applies to fine grinding of small particles, and Bond''s law applies to intermediate grinding and crushing.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Newton''s law', false, 0),
      (v_question_id, 'Fourier''s law', false, 1),
      (v_question_id, 'Rittinger''s law', true, 2),
      (v_question_id, 'Kick''s law', false, 3);
  END IF;

  -- 30. saturated salt solution RH
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Saturated salt solutions are used to maintain a fixed relative humidity in a closed chamber. Which salt solution produces a relative humidity of about 95 to 97 percent?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Saturated salt solutions are used to maintain a fixed relative humidity in a closed chamber. Which salt solution produces a relative humidity of about 95 to 97 percent?', 'single_choice', 'hard', 'Potassium sulfate gives about 95-97% RH. Magnesium chloride gives about 30-33% RH, potassium carbonate about 43-45% RH, and sodium chloride about 70-75% RH.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Potassium carbonate', false, 0),
      (v_question_id, 'Sodium chloride', false, 1),
      (v_question_id, 'Magnesium chloride', false, 2),
      (v_question_id, 'Potassium sulfate', true, 3);
  END IF;

  -- 31. controlled atmosphere storage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In controlled atmosphere (CA) storage of fruits and vegetables, which change is made to the storage atmosphere?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In controlled atmosphere (CA) storage of fruits and vegetables, which change is made to the storage atmosphere?', 'single_choice', 'medium', 'Controlled atmosphere storage lowers the oxygen level and raises the carbon dioxide level, which slows respiration and extends the shelf life of the stored commodity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Oxygen is reduced and carbon dioxide is increased', true, 0),
      (v_question_id, 'Oxygen is increased and carbon dioxide is reduced', false, 1),
      (v_question_id, 'Nitrogen is reduced and carbon dioxide is increased', false, 2),
      (v_question_id, 'Both oxygen and carbon dioxide are reduced', false, 3);
  END IF;

  -- 32. blanching before freezing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Why are some fruits and vegetables blanched before freezing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Why are some fruits and vegetables blanched before freezing?', 'single_choice', 'easy', 'Blanching stops enzymatic activity, which helps preserve the texture and color of frozen fruits and vegetables.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To add flavor', false, 0),
      (v_question_id, 'To inactivate enzymes that cause browning', true, 1),
      (v_question_id, 'To raise their sugar content', false, 2),
      (v_question_id, 'To increase their water content', false, 3);
  END IF;

  -- 33. juice evaporator
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An evaporator has a rated evaporation capacity of 500 kg of water per hour. At what rate is juice concentrate containing 45% total solids produced from raw juice containing 12% total solids?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An evaporator has a rated evaporation capacity of 500 kg of water per hour. At what rate is juice concentrate containing 45% total solids produced from raw juice containing 12% total solids?', 'single_choice', 'medium', 'Given: evaporation rate = 500 kg/hr; feed solids = 12%; concentrate solids = 45%. Let P = concentrate rate, so feed F = P + 500. Solids balance: 0.12(P + 500) = 0.45P, so 60 = 0.33P and P = 181.8, or about 182 kg/hr of concentrate (feed = 682 kg/hr).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '682 kg/hr', false, 0),
      (v_question_id, '133 kg/hr', false, 1),
      (v_question_id, '318 kg/hr', false, 2),
      (v_question_id, '182 kg/hr', true, 3);
  END IF;

  -- 34. papaya dehydration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Papaya slices containing 85% moisture are dehydrated in a fruit dryer to a product containing 5% moisture. How many kilograms of raw papaya are needed to produce one ton (1,000 kg) of dried product per day if preparation losses from peeling and trimming are 10% of the raw weight?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Papaya slices containing 85% moisture are dehydrated in a fruit dryer to a product containing 5% moisture. How many kilograms of raw papaya are needed to produce one ton (1,000 kg) of dried product per day if preparation losses from peeling and trimming are 10% of the raw weight?', 'single_choice', 'hard', 'Given: fresh moisture 85% (solids 15%); product moisture 5% (solids 95%); product = 1,000 kg; preparation loss = 10% of raw weight. Solids in product = 0.95 × 1,000 = 950 kg. Trimmed papaya needed = 950/0.15 = 6,333 kg. Raw papaya = 6,333/(1 - 0.10) = 7,037 kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7,037 kg', true, 0),
      (v_question_id, '6,667 kg', false, 1),
      (v_question_id, '6,967 kg', false, 2),
      (v_question_id, '6,333 kg', false, 3);
  END IF;

  -- 35. sugar addition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many kilograms of dry sugar must be added to 100 kg of a sugar solution to raise its concentration from 20% to 45% sugar?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many kilograms of dry sugar must be added to 100 kg of a sugar solution to raise its concentration from 20% to 45% sugar?', 'single_choice', 'medium', 'Given: solution = 100 kg at 20% sugar; target concentration = 45%. Let x = sugar added. Sugar balance: 20 + x = 0.45(100 + x), so 0.55x = 25 and x = 45.45 kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '81.82 kg', false, 0),
      (v_question_id, '31.25 kg', false, 1),
      (v_question_id, '45.45 kg', true, 2),
      (v_question_id, '25.00 kg', false, 3);
  END IF;

END $$;
