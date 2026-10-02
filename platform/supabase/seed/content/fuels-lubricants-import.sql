-- Fuels and Lubricants quiz batch (25 questions, 1 topic). Every fact is
-- drawn directly from a 2025 AB Power Engineering review
-- slide decks "Fuel and Lubricants," "Engine Fuel and Fuel System," and
-- "Engine Cooling and Lubricant System," plus the AB Renewable Energy
-- Engineering "Biodiesel" deck, each read in full (2026-10-02) -- no invented
-- facts. This topic had only 23 published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). None of these facts trace to a
-- specific PAES standard, so is_paes=false/paes_reference=NULL throughout.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Fuels and Lubricants (POWER_ENERGY_MACHINERY) -- 25 question(s)
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
    RAISE EXCEPTION 'Topic not found: Fuels and Lubricants';
  END IF;

  -- 1. Fuel viscosity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which property of a diesel or gasoline fuel affects how easily the fuel flows, particularly at low temperatures, and impacts fuel pump and injector performance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which property of a diesel or gasoline fuel affects how easily the fuel flows, particularly at low temperatures, and impacts fuel pump and injector performance?', 'single_choice', 'easy', 'Viscosity describes a fuel''s resistance to flow, which becomes especially significant at low temperatures and directly affects how well the fuel pump and injectors perform.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Specific Gravity', false, 0),
      (v_question_id, 'Viscosity', true, 1),
      (v_question_id, 'Calorific Value', false, 2),
      (v_question_id, 'Cetane Number', false, 3);
  END IF;

  -- 2. Flash point
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term refers to the lowest temperature at which a fuel can ignite, which is used to indicate its flammability and storage safety?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term refers to the lowest temperature at which a fuel can ignite, which is used to indicate its flammability and storage safety?', 'single_choice', 'easy', 'Flash point is the lowest temperature at which a fuel''s vapors can ignite, making it a key indicator of flammability and a safety consideration in fuel storage.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flash Point', true, 0),
      (v_question_id, 'Calorific Value', false, 1),
      (v_question_id, 'Boiling Point', false, 2),
      (v_question_id, 'Pour Point', false, 3);
  END IF;

  -- 3. Cetane number definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which measure indicates a diesel fuel''s ignition quality, that is, how easily it burns once injected into the engine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which measure indicates a diesel fuel''s ignition quality, that is, how easily it burns once injected into the engine?', 'single_choice', 'easy', 'Cetane number is a measure of diesel fuel''s ignition quality - the higher the cetane number, the more readily the fuel ignites under compression.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cetane Number', true, 0),
      (v_question_id, 'Octane Number', false, 1),
      (v_question_id, 'Calorific Value', false, 2),
      (v_question_id, 'Viscosity Index', false, 3);
  END IF;

  -- 4. Octane number of gasoline range
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the typical octane number range of gasoline fuel used in spark-ignition engines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the typical octane number range of gasoline fuel used in spark-ignition engines?', 'single_choice', 'medium', 'Gasoline fuel intended for spark-ignition engines typically has an octane number in the range of 92 to 98, reflecting its resistance to premature ignition (knocking).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '92 to 98', true, 0),
      (v_question_id, '-25', false, 1),
      (v_question_id, '107', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 5. Cetane number of diesel range
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the typical cetane number range for diesel fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the typical cetane number range for diesel fuel?', 'single_choice', 'medium', 'Diesel fuel typically has a cetane number in the range of 45 to 55, indicating good ignition quality under compression.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5', false, 0),
      (v_question_id, '45 to 55', true, 1),
      (v_question_id, '-2', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 6. Calorific value
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term describes the amount of heat released when a fuel is completely burned, indicating its energy content?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term describes the amount of heat released when a fuel is completely burned, indicating its energy content?', 'single_choice', 'easy', 'Calorific value quantifies the heat energy released upon complete combustion of a fuel, representing its energy content.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Calorific Value', true, 0),
      (v_question_id, 'Flash Point', false, 1),
      (v_question_id, 'Pour Point', false, 2),
      (v_question_id, 'Viscosity', false, 3);
  END IF;

  -- 7. Specific gravity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which fuel property is a measure of a fuel''s density relative to water, affecting engine performance and emissions?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which fuel property is a measure of a fuel''s density relative to water, affecting engine performance and emissions?', 'single_choice', 'medium', 'Specific gravity compares a fuel''s density to that of water, and this ratio has downstream effects on engine performance and emissions.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Specific Weight', false, 0),
      (v_question_id, 'Specific Gravity', true, 1),
      (v_question_id, 'Specific Fuel Consumption', false, 2),
      (v_question_id, 'Viscosity Index', false, 3);
  END IF;

  -- 8. Pour point
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term refers to the lowest temperature at which a fuel will still flow under its own weight?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term refers to the lowest temperature at which a fuel will still flow under its own weight?', 'single_choice', 'easy', 'Pour point is the lowest temperature at which a fuel remains fluid enough to flow on its own, which matters for cold-weather handling and fuel transfer.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pour Point', true, 0),
      (v_question_id, 'Cloud Point', false, 1),
      (v_question_id, 'Flash Point', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 9. Cloud point
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the term for the lowest temperature at which wax crystals begin to form in a fuel, causing it to appear cloudy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the term for the lowest temperature at which wax crystals begin to form in a fuel, causing it to appear cloudy?', 'single_choice', 'medium', 'Cloud point marks the temperature at which dissolved paraffin wax begins to crystallize out of the fuel, giving it a cloudy or hazy appearance - an early sign before the fuel reaches its pour point.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pour Point', false, 0),
      (v_question_id, 'Cloud Point', true, 1),
      (v_question_id, 'Flash Point', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 10. Heating value of gasoline
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the approximate heating value of gasoline fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the approximate heating value of gasoline fuel?', 'single_choice', 'hard', 'Gasoline fuel has an approximate heating value of 45.6 MJ/kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '45.6 MJ/kg', true, 0),
      (v_question_id, '50.1 MJ/kg', false, 1),
      (v_question_id, '59.5 MJ/kg', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 11. Heating value of diesel
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the approximate heating value of diesel fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the approximate heating value of diesel fuel?', 'single_choice', 'hard', 'Diesel fuel has an approximate heating value of 43.1 MJ/kg, slightly lower than gasoline.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '43.1 MJ/kg', true, 0),
      (v_question_id, '46.7 MJ/kg', false, 1),
      (v_question_id, '50.1 MJ/kg', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 12. CO2 emission factor of diesel
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the approximate CO2 emission factor of diesel fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the approximate CO2 emission factor of diesel fuel?', 'single_choice', 'hard', 'Diesel fuel has an approximate CO2 emission factor of 2.5 to 2.7 kg CO2 per liter burned.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.1 to 2.4 kg CO2 per liter', false, 0),
      (v_question_id, '2.5 to 2.7 kg CO2 per liter', true, 1),
      (v_question_id, '2.8 to 3.1 kg CO2 per liter', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 13. Excess air
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term describes the supply of more air than the theoretical amount needed for complete combustion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term describes the supply of more air than the theoretical amount needed for complete combustion?', 'single_choice', 'medium', 'Excess air refers to combustion air supplied beyond the stoichiometric (theoretical) requirement, often used to help ensure complete combustion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Primary air', false, 0),
      (v_question_id, 'Secondary air', false, 1),
      (v_question_id, 'Excess air', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 14. Allowable storage time for gasoline
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the allowable storage time for gasoline fuel before its quality significantly degrades?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the allowable storage time for gasoline fuel before its quality significantly degrades?', 'single_choice', 'medium', 'Gasoline fuel is generally considered usable for only about 3 to 6 months of storage before its quality begins to degrade significantly.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 to 2 months', false, 0),
      (v_question_id, '3 to 6 months', true, 1),
      (v_question_id, '7 to 9 months', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 15. Allowable storage time for diesel
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the allowable storage time for diesel fuel before its quality significantly degrades?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the allowable storage time for diesel fuel before its quality significantly degrades?', 'single_choice', 'medium', 'Diesel fuel can typically be stored for about 6 to 12 months before it begins to degrade significantly, longer than the recommended storage period for gasoline.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 to 5 months', false, 0),
      (v_question_id, '6 to 12 months', true, 1),
      (v_question_id, '13 to 18 months', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 16. Lubricant viscosity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which lubricant property determines its ability to form a protective film between moving parts and resist flow at different temperatures?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which lubricant property determines its ability to form a protective film between moving parts and resist flow at different temperatures?', 'single_choice', 'easy', 'A lubricant''s viscosity governs how well it forms a protective film between moving engine parts and how it resists flow across a range of temperatures.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Viscosity', true, 0),
      (v_question_id, 'Viscosity Index', false, 1),
      (v_question_id, 'Pour Point', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 17. Viscosity index definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term describes how much a lubricant''s viscosity changes with temperature?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term describes how much a lubricant''s viscosity changes with temperature?', 'single_choice', 'medium', 'Viscosity index is an arbitrary, unit-less number indicating how much a lubricant''s viscosity changes across a range of temperatures.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cloud Point', false, 0),
      (v_question_id, 'Pour Point', false, 1),
      (v_question_id, 'Viscosity Index', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 18. Effect of high viscosity index lubricants
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is an effect of lubricants with a high viscosity index?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is an effect of lubricants with a high viscosity index?', 'single_choice', 'medium', 'High viscosity index lubricants maintain more consistent performance across temperature extremes, giving better lubrication, improved fuel efficiency, and good performance in extreme temperatures all at once, which is why all of the above is correct.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Provides better lubrication only', false, 0),
      (v_question_id, 'Improved fuel efficiency only', false, 1),
      (v_question_id, 'Better performance in extreme temperature only', false, 2),
      (v_question_id, 'All of the above', true, 3);
  END IF;

  -- 19. Base number
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which lubricant property measures its ability to neutralize acidic by-products of combustion, indicating its long-term effectiveness?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which lubricant property measures its ability to neutralize acidic by-products of combustion, indicating its long-term effectiveness?', 'single_choice', 'medium', 'Base number measures a lubricant''s capacity to neutralize acidic combustion by-products, which is an indicator of how long the lubricant remains effective in service.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Base Number', true, 0),
      (v_question_id, 'Thermal Stability', false, 1),
      (v_question_id, 'Oxidation Resistance', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 20. Thermal stability
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which lubricant property refers to its resistance to degradation at high temperatures, ensuring long-term effectiveness?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which lubricant property refers to its resistance to degradation at high temperatures, ensuring long-term effectiveness?', 'single_choice', 'medium', 'Thermal stability describes how well a lubricant resists breaking down under high-temperature operating conditions.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flash Point', false, 0),
      (v_question_id, 'Pour Point', false, 1),
      (v_question_id, 'Thermal Stability', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 21. Types of lubricants
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following are recognized types of lubricants used in agricultural machinery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following are recognized types of lubricants used in agricultural machinery?', 'single_choice', 'easy', 'The recognized types of lubricants include oil, grease, penetrating lubricants, and dry lubricants, each suited to different applications.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Oil only', false, 0),
      (v_question_id, 'Grease and penetrating lubricants only', false, 1),
      (v_question_id, 'Dry lubricants only', false, 2),
      (v_question_id, 'Oil, grease, penetrating lubricants, and dry lubricants', true, 3);
  END IF;

  -- 22. Penetrating lubricants
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of lubricant, exemplified by WD-40, is useful for treating stuck bolts, hinges, and similar parts?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of lubricant, exemplified by WD-40, is useful for treating stuck bolts, hinges, and similar parts?', 'single_choice', 'easy', 'Penetrating lubricants, such as WD-40, are formulated to work into tight spaces and are useful for loosening stuck bolts, hinges, and similar parts.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Oil', false, 0),
      (v_question_id, 'Grease', false, 1),
      (v_question_id, 'Penetrating lubricants', true, 2),
      (v_question_id, 'Dry lubricants', false, 3);
  END IF;

  -- 23. Grease color code - blue
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What color code is typically used for grease intended for high-temperature or marine applications?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What color code is typically used for grease intended for high-temperature or marine applications?', 'single_choice', 'medium', 'Blue is the color code typically associated with grease formulated for high-temperature or marine applications.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Green', false, 0),
      (v_question_id, 'Blue', true, 1),
      (v_question_id, 'Red', false, 2),
      (v_question_id, 'Black/Brown', false, 3);
  END IF;

  -- 24. Lubrication system purpose
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What are the purposes of an engine''s lubrication system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What are the purposes of an engine''s lubrication system?', 'single_choice', 'easy', 'An engine''s lubrication system serves multiple purposes at once: it reduces friction, helps cool the engine, provides a sealing effect between the piston and cylinder liner, and helps clean the engine by carrying away contaminants.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To reduce friction only', false, 0),
      (v_question_id, 'To help cool the engine only', false, 1),
      (v_question_id, 'To provide a sealing effect between the piston and cylinder liner only', false, 2),
      (v_question_id, 'All of the above, including cleaning the engine', true, 3);
  END IF;

  -- 25. Biodiesel definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What term describes fatty acid methyl esters (mono-alkyl esters) derived from vegetable oils, animal fats, or other biomass-derived oils?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What term describes fatty acid methyl esters (mono-alkyl esters) derived from vegetable oils, animal fats, or other biomass-derived oils?', 'single_choice', 'easy', 'Biodiesel is defined as fatty acid methyl esters, or mono-alkyl esters, derived from vegetable oils, animal fats, and other biomass-derived oils.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bioethanol', false, 0),
      (v_question_id, 'Biodiesel', true, 1),
      (v_question_id, 'Bio-oil', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

END $$;
