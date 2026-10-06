-- Environmental Engineering and Science: waste management quiz batch 3 (40 questions, 1 topic).
-- Every fact, formula and numeric answer is drawn from the reference library
-- (PAES 413 Biogas Plant, PAES 414-1 Agricultural Liquid Waste, PAES 414-2
-- Agricultural Solid Waste - Composting, PAES 616 Wastewater Re-use for
-- Irrigation, RA 9003 and RA 9275) read in full on 2026-10-06 -- no invented
-- facts. Every computation was re-derived and each question states all of its
-- given values in the text. Focus: solid waste, agricultural and livestock
-- waste, composting, biogas / anaerobic digestion, lagoons and wastewater
-- treatment, BOD, effluent and waste disposal laws. Questions overlapping the
-- ~90 already published for this topic were avoided.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=true with a paes_reference only
-- where the question is directly about a PAES clause.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Environmental Engineering and Science (STRUCTURES_ENVIRONMENT) — 40 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Environmental Engineering and Science' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Environmental Engineering and Science';
  END IF;

  -- 1. Anaerobic lagoon minimum treatment volume
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A swine farm is designing an anaerobic lagoon. The total daily volatile solids loading from all sources is 36 kg/day and the selected volatile solids loading rate (VSLR) is 9 kg per 1,000 m3 per day. Using TVmin = VST / VSLR, what is the minimum treatment volume of the lagoon?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A swine farm is designing an anaerobic lagoon. The total daily volatile solids loading from all sources is 36 kg/day and the selected volatile solids loading rate (VSLR) is 9 kg per 1,000 m3 per day. Using TVmin = VST / VSLR, what is the minimum treatment volume of the lagoon?', 'single_choice', 'medium', 'Given: VST = 36 kg/day; VSLR = 9 kg/1,000 m3/day. TVmin = VST / VSLR = 36 / (9/1,000) = 4,000 m3. Forgetting that the loading rate is per 1,000 m3 gives the wrong answer of 4 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '400 m3', false, 0),
      (v_question_id, '4,000 m3', true, 1),
      (v_question_id, '324,000 m3', false, 2),
      (v_question_id, '4 m3', false, 3);
  END IF;

  -- 2. Lagoon waste volume
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a lagoon treatment period, the total volume of manure is 150 m3, the total volume of wastewater (including flush water that will not be recycled) is 480 m3, and the clean dilution water added is 70 m3. Using WV = VMT + VWWT + CW, what is the waste volume for the treatment period?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a lagoon treatment period, the total volume of manure is 150 m3, the total volume of wastewater (including flush water that will not be recycled) is 480 m3, and the clean dilution water added is 70 m3. Using WV = VMT + VWWT + CW, what is the waste volume for the treatment period?', 'single_choice', 'easy', 'Given: VMT = 150 m3; VWWT = 480 m3; CW = 70 m3. WV = 150 + 480 + 70 = 700 m3. The other choices each leave out one of the three components.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '700 m3', true, 0),
      (v_question_id, '550 m3', false, 1),
      (v_question_id, '220 m3', false, 2),
      (v_question_id, '630 m3', false, 3);
  END IF;

  -- 3. Lagoon sludge volume
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lagoon serves 10 animal units (AU). Each animal unit produces 8 kg of total solids per day (TS), the sludge accumulation ratio (SAR) is 0.0485 m3 per kg of total solids, and the sludge accumulation time (T) is 2 years. Using SV = 365 x AU x TS x SAR x T, what is the sludge volume?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lagoon serves 10 animal units (AU). Each animal unit produces 8 kg of total solids per day (TS), the sludge accumulation ratio (SAR) is 0.0485 m3 per kg of total solids, and the sludge accumulation time (T) is 2 years. Using SV = 365 x AU x TS x SAR x T, what is the sludge volume?', 'single_choice', 'hard', 'Given: AU = 10; TS = 8 kg/AU/day; SAR = 0.0485 m3/kg TS; T = 2 years. SV = 365 x 10 x 8 x 0.0485 x 2 = 2,832 m3 (rounded). Using T = 1 year gives 1,416 m3; omitting the 365 days gives 7.76 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,665 m3', false, 0),
      (v_question_id, '7.76 m3', false, 1),
      (v_question_id, '2,832 m3', true, 2),
      (v_question_id, '1,416 m3', false, 3);
  END IF;

  -- 4. Aerobic lagoon treatment surface area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The total daily production of BOD5 from the manure and wastewater of a livestock farm is 60 kg/day. If the selected BOD5 loading rate of an aerobic lagoon is 30 kg per hectare per day, what is the minimum treatment surface area (TSAmin = BODT / BODLR)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The total daily production of BOD5 from the manure and wastewater of a livestock farm is 60 kg/day. If the selected BOD5 loading rate of an aerobic lagoon is 30 kg per hectare per day, what is the minimum treatment surface area (TSAmin = BODT / BODLR)?', 'single_choice', 'medium', 'Given: BODT = 60 kg/day; BODLR = 30 kg/ha/day. TSAmin = BODT / BODLR = 60 / 30 = 2.0 ha = 20,000 m2. Inverting the ratio gives 0.5 ha.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 ha (5,000 m2)', false, 0),
      (v_question_id, '1,800 ha', false, 1),
      (v_question_id, '90 ha', false, 2),
      (v_question_id, '2.0 ha (20,000 m2)', true, 3);
  END IF;

  -- 5. Biogas digester volume for swine manure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Thirty pigs weighing 73-91 kg each produce 8.00 kg of manure per day per head. The manure is mixed with water at a ratio of 1 kg of manure to 1 L of water (1:1) and fed to a continuous-fed digester with a retention time of 20 days. Taking the slurry as 1,000 kg/m3, what is the required digester volume (daily slurry volume x retention time)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Thirty pigs weighing 73-91 kg each produce 8.00 kg of manure per day per head. The manure is mixed with water at a ratio of 1 kg of manure to 1 L of water (1:1) and fed to a continuous-fed digester with a retention time of 20 days. Taking the slurry as 1,000 kg/m3, what is the required digester volume (daily slurry volume x retention time)?', 'single_choice', 'medium', 'Given: 30 pigs x 8.00 kg/day = 240 kg manure/day; water at 1:1 = 240 L/day; slurry = 480 kg/day = 0.48 m3/day. Digester volume = 0.48 m3/day x 20 days = 9.6 m3. Using manure only gives 4.8 m3; a 1:2 manure-to-water ratio would give 14.4 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.8 m3', false, 0),
      (v_question_id, '14.4 m3', false, 1),
      (v_question_id, '9.6 m3', true, 2),
      (v_question_id, '19.2 m3', false, 3);
  END IF;

  -- 6. Outlet tank volume of fixed-type biogas plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a fixed-type biogas plant, the slurry occupies 9 m3 of the digester. According to PAES 413:2001, what is the volume of its outlet tank?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a fixed-type biogas plant, the slurry occupies 9 m3 of the digester. According to PAES 413:2001, what is the volume of its outlet tank?', 'single_choice', 'medium', 'For the fixed type, the outlet tank volume shall be one-third of the digester volume occupied by the slurry: 9 m3 / 3 = 3 m3. (For floating and balloon types the outlet tank is at least equal to the daily slurry input instead.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 m3', true, 0),
      (v_question_id, '4.5 m3', false, 1),
      (v_question_id, '9 m3', false, 2),
      (v_question_id, '1.8 m3', false, 3);
  END IF;

  -- 7. Gasholder storage volume with fluctuation allowance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A floating-drum biogas plant produces 4.2 m3 of biogas per day. Daily gas use is two ordinary mantle lamps, each used 3 hours/day at 0.071 m3/hr, and one 5-cm gas burner used 3 hours/day at 0.226 m3/hr. The gas to be stored is the daily surplus (production less consumption) increased by 30% to allow for fluctuation in biogas production. What gas volume must the gasholder store?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A floating-drum biogas plant produces 4.2 m3 of biogas per day. Daily gas use is two ordinary mantle lamps, each used 3 hours/day at 0.071 m3/hr, and one 5-cm gas burner used 3 hours/day at 0.226 m3/hr. The gas to be stored is the daily surplus (production less consumption) increased by 30% to allow for fluctuation in biogas production. What gas volume must the gasholder store?', 'single_choice', 'hard', 'Given: production = 4.2 m3/day. Consumption = 2 x 3 x 0.071 + 1 x 3 x 0.226 = 0.426 + 0.678 = 1.104 m3/day. Surplus = 4.2 - 1.104 = 3.096 m3. With the 30% fluctuation allowance: 3.096 x 1.3 = 4.02 m3. Omitting the 1.3 factor gives 3.10 m3; omitting the consumption gives 5.46 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.46 m3', false, 0),
      (v_question_id, '4.02 m3', true, 1),
      (v_question_id, '3.10 m3', false, 2),
      (v_question_id, '1.44 m3', false, 3);
  END IF;

  -- 8. Square floating-type digester inner side
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A square floating-type biogas digester has an effective volume Vd = 4.0 m3 and a height/side ratio r = 0.5. Using Sd = cube root of (1.15 x Vd / r), where the factor 1.15 accounts for a 15% freeboard, what is the inner side of the digester?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A square floating-type biogas digester has an effective volume Vd = 4.0 m3 and a height/side ratio r = 0.5. Using Sd = cube root of (1.15 x Vd / r), where the factor 1.15 accounts for a 15% freeboard, what is the inner side of the digester?', 'single_choice', 'hard', 'Given: Vd = 4.0 m3; r = 0.5. Sd = (1.15 x 4.0 / 0.5)^(1/3) = (9.2)^(1/3) = 2.10 m. Without the freeboard factor the result would be 2.00 m; 1.05 m is the digester height (r x Sd = 0.5 x 2.10).', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.66 m', false, 0),
      (v_question_id, '2.00 m', false, 1),
      (v_question_id, '2.10 m', true, 2),
      (v_question_id, '1.05 m', false, 3);
  END IF;

  -- 9. Baffle board height in a floating-type digester
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rectangular floating-type digester is 1.20 m high and has a 15% freeboard. The baffle board is provided midway between the inlet and outlet pipes, and its height must be 25% to 50% of the filling line height. What is the allowable range of baffle board height?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rectangular floating-type digester is 1.20 m high and has a 15% freeboard. The baffle board is provided midway between the inlet and outlet pipes, and its height must be 25% to 50% of the filling line height. What is the allowable range of baffle board height?', 'single_choice', 'medium', 'Given: digester height = 1.20 m; freeboard = 15%. Filling line = 1.20 x (1 - 0.15) = 1.02 m. Baffle height = 25% to 50% of 1.02 m = 0.255 m to 0.510 m. Applying the percentages to the full digester height instead gives 0.30 m to 0.60 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.30 m to 0.60 m', false, 0),
      (v_question_id, '0.255 m to 0.510 m', true, 1),
      (v_question_id, '0.128 m to 0.255 m', false, 2),
      (v_question_id, '0.510 m to 1.020 m', false, 3);
  END IF;

  -- 10. C:N ratio of a compost mix
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A compost mix contains a total of 1,800 kg of carbon and 60 kg of nitrogen. The recommended C:N ratio for most compost operations is 25:1 to 40:1. What is the C:N ratio of this mix and is it acceptable?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A compost mix contains a total of 1,800 kg of carbon and 60 kg of nitrogen. The recommended C:N ratio for most compost operations is 25:1 to 40:1. What is the C:N ratio of this mix and is it acceptable?', 'single_choice', 'easy', 'Given: C = 1,800 kg; N = 60 kg. C:N = 1,800 / 60 = 30:1, which lies between the recommended 25:1 and 40:1, so it is acceptable.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60:1, which is above the recommended range', false, 0),
      (v_question_id, '18:1, which is below the recommended range', false, 1),
      (v_question_id, '30:1, which is above the recommended maximum', false, 2),
      (v_question_id, '30:1, which is within the recommended range', true, 3);
  END IF;

  -- 11. Spacing of aerated static piles
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In an aerated static pile composting system, the compost mixture is stacked to a height of 3.6 m, which is within the generally used range of 2.4 m to 4.5 m. About how far apart should individual piles be spaced?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In an aerated static pile composting system, the compost mixture is stacked to a height of 3.6 m, which is within the generally used range of 2.4 m to 4.5 m. About how far apart should individual piles be spaced?', 'single_choice', 'easy', 'Given: pile height = 3.6 m. Individual piles should be spaced about half the distance of the height: 0.5 x 3.6 m = 1.8 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.8 m', true, 0),
      (v_question_id, '3.6 m', false, 1),
      (v_question_id, '7.2 m', false, 2),
      (v_question_id, '0.9 m', false, 3);
  END IF;

  -- 12. Collecting tank limit for a continuous-fed biogas plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A continuous-fed biogas plant will be loaded with the manure of 40 pigs, each producing 5.22 kg of manure per day. Manure and water are mixed at 1:1 (1 kg manure : 1 L water) and the slurry is taken as 1,000 kg/m3. The collecting tank should not exceed the total slurry volume for 10 days. What is the maximum collecting tank volume?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A continuous-fed biogas plant will be loaded with the manure of 40 pigs, each producing 5.22 kg of manure per day. Manure and water are mixed at 1:1 (1 kg manure : 1 L water) and the slurry is taken as 1,000 kg/m3. The collecting tank should not exceed the total slurry volume for 10 days. What is the maximum collecting tank volume?', 'single_choice', 'medium', 'Given: 40 pigs x 5.22 kg/day = 208.8 kg manure/day; water at 1:1 = 208.8 L/day; slurry = 417.6 kg/day = 0.4176 m3/day. Maximum collecting tank = 0.4176 x 10 days = 4.18 m3. Counting manure only gives 2.09 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.09 m3', false, 0),
      (v_question_id, '41.8 m3', false, 1),
      (v_question_id, '8.35 m3', false, 2),
      (v_question_id, '4.18 m3', true, 3);
  END IF;

  -- 13. Length of a horizontal-flow grit chamber
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A horizontal-flow grit chamber is designed with a detention time of 60 s and a horizontal velocity of 0.3 m/s. An added length allowance of 30% is provided for inlet and outlet turbulence. What is the required channel length?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A horizontal-flow grit chamber is designed with a detention time of 60 s and a horizontal velocity of 0.3 m/s. An added length allowance of 30% is provided for inlet and outlet turbulence. What is the required channel length?', 'single_choice', 'medium', 'Given: t = 60 s; v = 0.3 m/s; allowance = 30%. Basic length = v x t = 0.3 x 60 = 18 m. With allowance: 18 x 1.30 = 23.4 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '13.8 m', false, 0),
      (v_question_id, '18.0 m', false, 1),
      (v_question_id, '78.0 m', false, 2),
      (v_question_id, '23.4 m', true, 3);
  END IF;

  -- 14. Oil and grease interceptor volume
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The average daily flow of wastewater from an animal processing plant is 12 m3/day. If the volume of the oil and grease interceptor tank is to be 1 to 3 times the average daily flow, what is the recommended range of tank volume?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The average daily flow of wastewater from an animal processing plant is 12 m3/day. If the volume of the oil and grease interceptor tank is to be 1 to 3 times the average daily flow, what is the recommended range of tank volume?', 'single_choice', 'medium', 'Given: average daily flow = 12 m3/day. Interceptor volume = (1 to 3) x 12 = 12 m3 to 36 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '36 m3 to 108 m3', false, 0),
      (v_question_id, '12 m3 to 36 m3', true, 1),
      (v_question_id, '4 m3 to 12 m3', false, 2),
      (v_question_id, '24 m3 to 72 m3', false, 3);
  END IF;

  -- 15. Depth of a liquid waste storage tank
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A liquid manure storage tank needs a depth of 2.0 m to hold the computed storage volume. The tank depth is the sum of the depth for the computed storage capacity, the freeboard above the lowest inlet opening, and an additional 0.2 m for the liquid always left in the tank. If a freeboard of 0.4 m is provided, what is the required tank depth?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A liquid manure storage tank needs a depth of 2.0 m to hold the computed storage volume. The tank depth is the sum of the depth for the computed storage capacity, the freeboard above the lowest inlet opening, and an additional 0.2 m for the liquid always left in the tank. If a freeboard of 0.4 m is provided, what is the required tank depth?', 'single_choice', 'hard', 'Given: storage depth = 2.0 m; freeboard = 0.4 m; liquid always left = 0.2 m. Tank depth = 2.0 + 0.4 + 0.2 = 2.6 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.8 m', false, 0),
      (v_question_id, '2.4 m', false, 1),
      (v_question_id, '2.6 m', true, 2),
      (v_question_id, '2.2 m', false, 3);
  END IF;

  -- 16. Construction height of a lagoon embankment
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lagoon embankment must have a settled height of 3.0 m. If the embankment elevation is increased by at least 5% during construction to allow for settling, what is the minimum height at which it should be built?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lagoon embankment must have a settled height of 3.0 m. If the embankment elevation is increased by at least 5% during construction to allow for settling, what is the minimum height at which it should be built?', 'single_choice', 'medium', 'Given: settled height = 3.0 m; settling allowance = 5%. Construction height = 3.0 x 1.05 = 3.15 m. A 10% allowance would give 3.30 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.15 m', true, 0),
      (v_question_id, '3.30 m', false, 1),
      (v_question_id, '3.05 m', false, 2),
      (v_question_id, '2.85 m', false, 3);
  END IF;

  -- 17. Volume of water in a free-water-surface wetland
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A free-water-surface constructed wetland is designed for a detention time of 2 to 5 days and receives a flow of 150 m3/day. What is the range of water volume the wetland must hold?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A free-water-surface constructed wetland is designed for a detention time of 2 to 5 days and receives a flow of 150 m3/day. What is the range of water volume the wetland must hold?', 'single_choice', 'hard', 'Given: flow = 150 m3/day; detention time = 2 to 5 days. Volume = flow x detention time = 150 x 2 = 300 m3 up to 150 x 5 = 750 m3. The 3-to-4-day range (450 to 600 m3) belongs to subsurface-flow wetlands.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '300 m3 to 750 m3', true, 0),
      (v_question_id, '450 m3 to 600 m3', false, 1),
      (v_question_id, '300 m3 to 600 m3', false, 2),
      (v_question_id, '150 m3 to 450 m3', false, 3);
  END IF;

  -- 18. Definition of BOD5
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 414-1:2002, the 5-day biochemical oxygen demand (BOD5) is defined as the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 414-1:2002, the 5-day biochemical oxygen demand (BOD5) is defined as the:', 'single_choice', 'easy', 'BOD5 is the quantity of oxygen needed to satisfy the biochemical oxidation of organic matter in a waste sample in 5 days at 20 °C. It is a biological measure, unlike chemical oxygen demand (COD), which uses chemical oxidation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'quantity of oxygen needed to oxidize all organic matter in a waste sample by chemical means', false, 0),
      (v_question_id, 'amount of dissolved oxygen remaining in a waste sample after 5 days of settling', false, 1),
      (v_question_id, 'mass of suspended solids that settle out of a waste sample in 5 days', false, 2),
      (v_question_id, 'quantity of oxygen needed to satisfy the biochemical oxidation of organic matter in a waste sample in 5 days at 20 °C', true, 3);
  END IF;

  -- 19. Volatile solids
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'When the total solids of a liquid waste sample are heated to 600 °C, the part that is driven off as volatile gases is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'When the total solids of a liquid waste sample are heated to 600 °C, the part that is driven off as volatile gases is called the:', 'single_choice', 'easy', 'Volatile solids are the part of the total solids driven off as volatile gases when heated to 600 °C; the part remaining is the fixed solids.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'suspended solids', false, 0),
      (v_question_id, 'volatile solids', true, 1),
      (v_question_id, 'dissolved solids', false, 2),
      (v_question_id, 'fixed solids', false, 3);
  END IF;

  -- 20. Disposal of anaerobic lagoon effluent
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement about the effluent of an anaerobic lagoon is consistent with PAES 414-1:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement about the effluent of an anaerobic lagoon is consistent with PAES 414-1:2002?', 'single_choice', 'medium', 'Effluent from an anaerobic lagoon should not be discharged to streams, lakes or waterways. The lagoon should overflow to a subsequent storage or treatment cell, and the supernatant should be land-applied without surface runoff.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It may be discharged directly to nearby streams once the lagoon is full', false, 0),
      (v_question_id, 'It may be released to a lake provided it is first mixed with clean runoff', false, 1),
      (v_question_id, 'It should not be discharged to streams, lakes or waterways but should overflow to a subsequent storage or treatment cell', true, 2),
      (v_question_id, 'It must be pumped immediately to a drinking water source for dilution', false, 3);
  END IF;

  -- 21. Operating depth of an aerobic lagoon
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 414-1:2002, what are the minimum operating depth and the maximum level of an aerobic lagoon?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 414-1:2002, what are the minimum operating depth and the maximum level of an aerobic lagoon?', 'single_choice', 'medium', 'The minimum operating depth of an aerobic lagoon is 0.6 m and the maximum level shall not exceed 1.5 m. The 1.8 m figure is the minimum acceptable depth of an anaerobic lagoon.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5 m minimum and 2.5 m maximum', false, 0),
      (v_question_id, '0.6 m minimum and 1.5 m maximum', true, 1),
      (v_question_id, '0.3 m minimum and 0.6 m maximum', false, 2),
      (v_question_id, '1.8 m minimum and 3.0 m maximum', false, 3);
  END IF;

  -- 22. Odor control methods
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which set lists the odor control methods for treating foul air from liquid waste facilities under PAES 414-1:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which set lists the odor control methods for treating foul air from liquid waste facilities under PAES 414-1:2002?', 'single_choice', 'medium', 'Foul air is treated with chemical scrubbers, activated carbon or bulk medium biofilters. Bulk media such as soil, peat and compost need sufficient porosity, near-uniform particle size and pH-buffering capacity.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aerated lagoons, drying beds and sludge lagoons', false, 0),
      (v_question_id, 'Sedimentation tanks, settling channels and holding ponds', false, 1),
      (v_question_id, 'Chemical scrubbers, activated carbon and bulk medium biofilters', true, 2),
      (v_question_id, 'Grit chambers, bar screens and comminutors', false, 3);
  END IF;

  -- 23. Temperature requirement for windrow composting
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly describes the temperature requirement of PAES 414-2:2002 for waste composted in windrows?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly describes the temperature requirement of PAES 414-2:2002 for waste composted in windrows?', 'single_choice', 'hard', 'Waste composted in windrows (or a vessel that is not fully enclosed) shall be maintained at a minimum of 55 °C on at least 15 different days, and the windrows shall be turned at least five times after 55 °C is first reached, with 55 °C reached again after the fifth turning. The 3-day requirement applies to fully enclosed vessels. Temperature is measured at 1 m depth.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least 55 °C on at least 15 different days, with at least five turnings after 55 °C is first reached and 55 °C again after the fifth turning', true, 0),
      (v_question_id, 'At least 40 °C on at least 30 different days', false, 1),
      (v_question_id, 'At least 55 °C on at least 3 different days with no turning required', false, 2),
      (v_question_id, 'At least 70 °C on at least 5 different days, measured at the pile surface', false, 3);
  END IF;

  -- 24. Particle size for composting
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 414-2:2002, what particle size should the materials in a compost pile have?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 414-2:2002, what particle size should the materials in a compost pile have?', 'single_choice', 'medium', 'The particle size shall be 5 mm to 50 mm. Very dense materials need a bulking agent or amendment, mixed or ground to the required size before being added to the pile.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 mm to 150 mm', false, 0),
      (v_question_id, '0.5 mm to 2 mm', false, 1),
      (v_question_id, '100 mm to 200 mm', false, 2),
      (v_question_id, '5 mm to 50 mm', true, 3);
  END IF;

  -- 25. Curing of compost
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 414-2:2002, when is a compost pile considered ready for curing, and for how long should it then be left undisturbed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 414-2:2002, when is a compost pile considered ready for curing, and for how long should it then be left undisturbed?', 'single_choice', 'medium', 'The pile shall be cured when turning no longer results in an increase in temperature. It shall not be disturbed for 1 month to 2 months; afterwards the compost is screened if necessary and analysed for nutrient value.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'When the pile first reaches 55 °C; left undisturbed for 1 week', false, 0),
      (v_question_id, 'When moisture drops below 20%; left undisturbed for 6 months', false, 1),
      (v_question_id, 'When the pile is first built; left undisturbed for 4 months', false, 2),
      (v_question_id, 'When turning no longer results in a temperature increase; left undisturbed for 1 to 2 months', true, 3);
  END IF;

  -- 26. Compost that fails quality requirements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 414-2:2002, how should compost that fails to meet quality requirements, and the leachate from storage and composting, be handled?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 414-2:2002, how should compost that fails to meet quality requirements, and the leachate from storage and composting, be handled?', 'single_choice', 'medium', 'Compost that fails to meet quality requirements shall be disposed of at an approved waste disposal site, and leachate from storage and composting shall be treated as liquid waste (PAES 414-1).', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The compost is spread on food crops and the leachate is discharged to a stream', false, 0),
      (v_question_id, 'The compost is burned in the open and the leachate is allowed to seep into the soil', false, 1),
      (v_question_id, 'The compost is disposed of at an approved waste disposal site and the leachate is treated as liquid waste', true, 2),
      (v_question_id, 'The compost is sold as a soil amendment and the leachate is returned to the pile', false, 3);
  END IF;

  -- 27. Location of a biogas plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 413:2001, where should a biogas plant be located relative to the animal pen?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 413:2001, where should a biogas plant be located relative to the animal pen?', 'single_choice', 'easy', 'The biogas plant should be located at a well-drained site, as near as possible to the animal pen and lower than the elevation of the pen canal so the manure flows by gravity; the point of biogas use should also be near.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'As far as possible from the pen and at a higher elevation than the pen canal', false, 0),
      (v_question_id, 'As near as possible to the pen and lower than the elevation of the pen canal', true, 1),
      (v_question_id, 'Directly under the animal pen floor', false, 2),
      (v_question_id, 'Upstream of the pen at the highest point of the farm', false, 3);
  END IF;

  -- 28. Gas tightness test of a digester
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the air-tight test of a biogas digester under PAES 413:2001, the manhole and gas valves are sealed and the pressure is raised to 0.4 m of water column. After 24 hours, which pressure drop indicates that the digester is gas tight?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the air-tight test of a biogas digester under PAES 413:2001, the manhole and gas valves are sealed and the pressure is raised to 0.4 m of water column. After 24 hours, which pressure drop indicates that the digester is gas tight?', 'single_choice', 'hard', 'After the water-tightness test, the gas test is done at 0.4 m water column for 24 hours. A pressure drop of about 10 mm to 20 mm means the digester is gas tight; a drop of about 50 mm means the dome is not gas tight.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 10 mm to 20 mm', true, 0),
      (v_question_id, 'About 200 mm', false, 1),
      (v_question_id, 'About 50 mm', false, 2),
      (v_question_id, 'About 100 mm', false, 3);
  END IF;

  -- 29. Safety when entering a used digester
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which practice is required by PAES 413:2001 when a worker enters a digester that has been used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which practice is required by PAES 413:2001 when a worker enters a digester that has been used?', 'single_choice', 'medium', 'Before entering, the manhole is removed for several days, the gas line nearest the digester is disconnected, the contents are removed and the tank is ventilated; harmful gases or sufficient air are checked, flames are avoided, a breathing pipe or hose is provided, and another person constantly watches from outside the pit.', NULL, NULL, 'draft', false, NULL, true, 'PAES 413')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Another person constantly watches from outside the pit and can respond to an emergency', true, 0),
      (v_question_id, 'The worker enters alone with a lighted lamp to inspect the gas quality', false, 1),
      (v_question_id, 'The digester is entered immediately after emptying without ventilation', false, 2),
      (v_question_id, 'The gas line is kept connected so gas pressure can be monitored', false, 3);
  END IF;

  -- 30. Site selection for wastewater re-use in irrigation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 616:2016, which of the following sites should be avoided for the re-use of treated wastewater for irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 616:2016, which of the following sites should be avoided for the re-use of treated wastewater for irrigation?', 'single_choice', 'medium', 'Highly acidic soils (pH below 4) and highly alkaline soils (pH above 8.5) shall be avoided, with soils near pH 5.5 preferred. Highly permeable sandy or gravelly soils and extremely permeable heavy clay are also avoided, and soil depth shall be greater than 1.0 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 616')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Soil with a depth greater than 1.0 m', false, 0),
      (v_question_id, 'Moderately permeable loam soil', false, 1),
      (v_question_id, 'Highly alkaline soil with a pH greater than 8.5', true, 2),
      (v_question_id, 'Soil with a pH of 5.5', false, 3);
  END IF;

  -- 31. Disinfection of treated liquid waste
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 414-1:2002, disinfection of treated liquid waste is specifically required when the treated wastewater will be used to irrigate:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 414-1:2002, disinfection of treated liquid waste is specifically required when the treated wastewater will be used to irrigate:', 'single_choice', 'medium', 'Disinfection shall be required if the treated wastewater will be irrigated onto food crops; it can be done by chemical agents, physical agents, mechanical means or radiation. Disinfection means killing pathogenic microorganisms.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ornamental plants in enclosed greenhouses only', false, 0),
      (v_question_id, 'Food crops', true, 1),
      (v_question_id, 'Fishponds', false, 2),
      (v_question_id, 'Fallow land', false, 3);
  END IF;

  -- 32. RA 9003 materials recovery facility
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under RA 9003 (Ecological Solid Waste Management Act of 2000), a Materials Recovery Facility (MRF) shall be established in:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under RA 9003 (Ecological Solid Waste Management Act of 2000), a Materials Recovery Facility (MRF) shall be established in:', 'single_choice', 'medium', 'Section 32 of RA 9003 requires an MRF in every barangay or cluster of barangays. The MRF receives mixed waste for final sorting, segregation, composting and recycling, and the residual wastes go to a long-term storage or disposal facility or a sanitary landfill.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'every sanitary landfill only', false, 0),
      (v_question_id, 'every province only', false, 1),
      (v_question_id, 'every region only', false, 2),
      (v_question_id, 'every barangay or cluster of barangays', true, 3);
  END IF;

  -- 33. RA 9003 transfer station storage limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under RA 9003, transfer stations shall be designed and operated so that no waste is stored in the station beyond:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under RA 9003, transfer stations shall be designed and operated so that no waste is stored in the station beyond:', 'single_choice', 'medium', 'Section 25 of RA 9003 provides that no waste shall be stored in a transfer station beyond twenty-four (24) hours. Siting considers the land use plan, proximity to the collection area and the accessibility of haul routes to the disposal facility.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 hours', true, 0),
      (v_question_id, '7 days', false, 1),
      (v_question_id, '6 hours', false, 2),
      (v_question_id, '72 hours', false, 3);
  END IF;

  -- 34. RA 9003 conversion of open dumps
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Section 37 of RA 9003, within how many years after effectivity must every local government unit convert its open dumps into controlled dumps?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Section 37 of RA 9003, within how many years after effectivity must every local government unit convert its open dumps into controlled dumps?', 'single_choice', 'hard', 'Every LGU shall convert its open dumps into controlled dumps within three (3) years after the effectivity of the Act, and no controlled dumps are allowed five (5) years after effectivity. Open dumps are prohibited.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 years', false, 0),
      (v_question_id, '3 years', true, 1),
      (v_question_id, '1 year', false, 2),
      (v_question_id, '10 years', false, 3);
  END IF;

  -- 35. RA 9003 distance from dumps and landfills
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the prohibited acts under RA 9003 is the construction of any establishment within what distance from open dumps, controlled dumps or sanitary landfills?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among the prohibited acts under RA 9003 is the construction of any establishment within what distance from open dumps, controlled dumps or sanitary landfills?', 'single_choice', 'medium', 'Section 48 of RA 9003 prohibits the construction of any establishment within two hundred (200) meters from open dumps, controlled dumps or sanitary landfills. Violators are punished with a fine of P100,000 to P1,000,000 or imprisonment of one to six years, or both.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 meters', false, 0),
      (v_question_id, '100 meters', false, 1),
      (v_question_id, '200 meters', true, 2),
      (v_question_id, '500 meters', false, 3);
  END IF;

  -- 36. RA 9003 sanitary landfill final cover
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the criteria for establishing a sanitary landfill in RA 9003, the installation of the final cover must be completed within how long after the last receipt of wastes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the criteria for establishing a sanitary landfill in RA 9003, the installation of the final cover must be completed within how long after the last receipt of wastes?', 'single_choice', 'hard', 'The closure procedure of RA 9003 (Section 41) requires a low-maintenance final cover that minimizes the infiltration of precipitation into the waste, and its installation must be completed within six (6) months of the last receipt of wastes. A daily cover is placed at the close of each day''s operations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 month', false, 0),
      (v_question_id, '5 years', false, 1),
      (v_question_id, '2 years', false, 2),
      (v_question_id, '6 months', true, 3);
  END IF;

  -- 37. Clean Water Act definition of freshwater
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Clean Water Act of 2004 (RA 9275), freshwater is water containing less than how much dissolved common salt (sodium chloride)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Clean Water Act of 2004 (RA 9275), freshwater is water containing less than how much dissolved common salt (sodium chloride)?', 'single_choice', 'easy', 'RA 9275 defines freshwater as water containing less than 500 ppm of dissolved common salt, sodium chloride, such as that in groundwater, rivers, ponds and lakes.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35,000 ppm', false, 0),
      (v_question_id, '500 ppm', true, 1),
      (v_question_id, '50 ppm', false, 2),
      (v_question_id, '5,000 ppm', false, 3);
  END IF;

  -- 38. Agency for wastewater re-use guidelines for irrigation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the linkage mechanism of RA 9275, which agency coordinates with the DENR in formulating the guidelines for the re-use of wastewater for irrigation and other agricultural uses and for the control of pollution from agricultural and aquaculture activities?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the linkage mechanism of RA 9275, which agency coordinates with the DENR in formulating the guidelines for the re-use of wastewater for irrigation and other agricultural uses and for the control of pollution from agricultural and aquaculture activities?', 'single_choice', 'medium', 'Section 22(c) of RA 9275 assigns the Department of Agriculture to coordinate with the DENR on guidelines for wastewater re-use for irrigation and other agricultural uses and on the prevention, control and abatement of pollution from agricultural and aquaculture activities; BFAR is primarily responsible for pollution control related to fisheries. The DOH handles drinking water standards.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Department of Public Works and Highways', false, 0),
      (v_question_id, 'Department of Science and Technology', false, 1),
      (v_question_id, 'Department of Agriculture', true, 2),
      (v_question_id, 'Department of Health', false, 3);
  END IF;

  -- 39. Basis of the wastewater charge system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the wastewater charge system of RA 9275, the fee for discharging wastewater is based on the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the wastewater charge system of RA 9275, the fee for discharging wastewater is based on the:', 'single_choice', 'hard', 'Section 13 of RA 9275 bases the fee on the net waste load: the difference between the initial waste load of the abstracted water and the waste load of the final effluent discharge. Industries whose effluents are within standards are charged only a minimal reasonable amount.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'net waste load, the difference between the initial waste load of the abstracted water and the waste load of the final effluent discharge', true, 0),
      (v_question_id, 'number of employees of the industry', false, 1),
      (v_question_id, 'total volume of water abstracted by the industry only', false, 2),
      (v_question_id, 'area of the industrial plant', false, 3);
  END IF;

  -- 40. Fines for violations of the Clean Water Act
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Section 28 of RA 9275, what is the fine imposed by the Secretary, upon the recommendation of the Pollution Adjudication Board, on a person who commits a prohibited act, such as discharging regulated pollutants without a permit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Section 28 of RA 9275, what is the fine imposed by the Secretary, upon the recommendation of the Pollution Adjudication Board, on a person who commits a prohibited act, such as discharging regulated pollutants without a permit?', 'single_choice', 'medium', 'Violators shall be fined not less than P10,000 nor more than P200,000 for every day of violation, increased by 10% every two years to maintain its deterrent function. Closure or cessation of operations may also be ordered until proper environmental safeguards are put in place.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P500,000 to P3,000,000 one-time', false, 0),
      (v_question_id, 'P100 to P500 per violation', false, 1),
      (v_question_id, 'P1,000 to P10,000 per month', false, 2),
      (v_question_id, 'P10,000 to P200,000 for every day of violation', true, 3);
  END IF;

END $$;
