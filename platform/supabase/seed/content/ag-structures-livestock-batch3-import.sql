-- Agricultural Building and Structures, livestock and poultry housing batch 3
-- quiz batch (40 questions, 1 topic). Livestock and poultry housing only:
-- swine, broiler and layer poultry, dairy cattle and milking parlor, goat and
-- sheep, cattle and carabao feedlots, cattle ranch handling facilities,
-- slaughterhouse and lairage, poultry dressing plant, and manure-handling
-- structures (gutters, alleys, lagoons). Every fact, number and formula is
-- drawn directly from the PAES 401 to 412 and PAES 414-1 standards in the
-- reference library, read in full - no invented facts. Plant structures are
-- deliberately excluded. Angles differ from the questions already in this topic.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). Questions about a specific standard
-- carry is_paes=true with the standard number in paes_reference.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Agricultural Building and Structures (STRUCTURES_ENVIRONMENT) — 40 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Building and Structures' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Agricultural Building and Structures';
  END IF;

  -- 1. Swine house orientation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 401:2001, how shall a swine house be oriented on its site?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 401:2001, how shall a swine house be oriented on its site?', 'single_choice', 'easy', 'PAES 401:2001 clause 4.4 requires the building to be constructed in an east-west orientation, with the structure for marketable animals located near the service road. The same location clause appears in the PAES housing standards for broilers, layers, goats and sheep, cattle, dairy cattle and carabao.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'In any orientation, provided the roof overhang is at least 1 m', false, 0),
      (v_question_id, 'In a northeast-southwest orientation, facing the prevailing wind', false, 1),
      (v_question_id, 'In an east-west orientation', true, 2),
      (v_question_id, 'In a north-south orientation, so the long sides face the morning and afternoon sun', false, 3);
  END IF;

  -- 2. Four-unit swine housing system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the four-unit swine housing system described in PAES 401:2001, through which sequence of housing do the pigs pass from farrowing until they are ready for slaughter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the four-unit swine housing system described in PAES 401:2001, through which sequence of housing do the pigs pass from farrowing until they are ready for slaughter?', 'single_choice', 'medium', 'In the four-unit system the sows and piglets stay in the farrowing house until weaning. The weanlings are then moved to a nursery house, next to a growing house, and finally to a finishing house until slaughter weight. The three-unit system combines growing and finishing in one growing-finishing unit, and the two-unit system moves weanlings straight from the farrowing house to a growing-finishing house.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Farrowing house, nursery house, growing house, finishing house', true, 0),
      (v_question_id, 'Gestating house, nursery house, finishing house, growing house', false, 1),
      (v_question_id, 'Farrowing house, nursery house, growing-finishing house', false, 2),
      (v_question_id, 'Farrowing house, growing-finishing house', false, 3);
  END IF;

  -- 3. Gestating sow group pen capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A group pen for gestating sows measures 6.0 m x 4.8 m. Using the PAES 401:2001 minimum space requirement of 1.20 m2 per gestating sow, what is the maximum number of gestating sows the pen can hold?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A group pen for gestating sows measures 6.0 m x 4.8 m. Using the PAES 401:2001 minimum space requirement of 1.20 m2 per gestating sow, what is the maximum number of gestating sows the pen can hold?', 'single_choice', 'medium', 'Given: pen area = 6.0 m x 4.8 m = 28.8 m2; minimum space = 1.20 m2 per gestating sow. Number of sows = 28.8 / 1.20 = 24. Using 1.80 m2 (the dry sow value) would wrongly give 16.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '29 sows', false, 0),
      (v_question_id, '16 sows', false, 1),
      (v_question_id, '20 sows', false, 2),
      (v_question_id, '24 sows', true, 3);
  END IF;

  -- 4. Floor area saved by multi-suckling group housing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farrowing house is to accommodate 8 lactating sows with their litters. PAES 401:2001 gives a minimum space of 7.40 m2 per lactating sow and litter in individual pens and 5.60 m2 per lactating sow and litter in multi-suckling groups. How much floor area is saved by using multi-suckling group housing instead of individual pens?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A farrowing house is to accommodate 8 lactating sows with their litters. PAES 401:2001 gives a minimum space of 7.40 m2 per lactating sow and litter in individual pens and 5.60 m2 per lactating sow and litter in multi-suckling groups. How much floor area is saved by using multi-suckling group housing instead of individual pens?', 'single_choice', 'medium', 'Given: 8 sows with litters; individual pens = 7.40 m2 each; multi-suckling groups = 5.60 m2 each. Individual pens = 8 x 7.40 = 59.2 m2. Multi-suckling = 8 x 5.60 = 44.8 m2. Area saved = 59.2 - 44.8 = 14.4 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '44.8 m2', false, 0),
      (v_question_id, '14.4 m2', true, 1),
      (v_question_id, '59.2 m2', false, 2),
      (v_question_id, '9.6 m2', false, 3);
  END IF;

  -- 5. Swine feeding trough length
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A finishing pen holds 14 pigs weighing 100 kg to 130 kg. PAES 401:2001 requires a minimum feeding trough length of 350 mm per animal for this weight range. What total linear length of trough must the pen have?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A finishing pen holds 14 pigs weighing 100 kg to 130 kg. PAES 401:2001 requires a minimum feeding trough length of 350 mm per animal for this weight range. What total linear length of trough must the pen have?', 'single_choice', 'easy', 'Given: 14 pigs; 350 mm of trough per pig. Total length = 14 x 350 mm = 4,900 mm = 4.9 m. Using 250 mm (the 50-75 kg value) would give 3.5 m, and 300 mm (the 75-100 kg value) would give 4.2 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.5 m', false, 0),
      (v_question_id, '4.2 m', false, 1),
      (v_question_id, '4.9 m', true, 2),
      (v_question_id, '5.6 m', false, 3);
  END IF;

  -- 6. Direction of swine floor slope
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A swine house has a solid concrete floor with a 2% to 4% slope. According to PAES 401:2001, in which direction should the floor slope?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A swine house has a solid concrete floor with a 2% to 4% slope. According to PAES 401:2001, in which direction should the floor slope?', 'single_choice', 'medium', 'PAES 401:2001 clause 7.4.1.2 requires a skid-resistant solid floor sloping 2% to 4% towards a gutter or drainage canal, with the direction of the slope away from the feeding trough, so the feeding area stays dry and clean.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Toward a gutter or drainage canal, away from the feeding trough', true, 0),
      (v_question_id, 'Toward the pen gate, so the pigs can be washed out', false, 1),
      (v_question_id, 'Toward the feeding trough, so spilled feed collects in one place', false, 2),
      (v_question_id, 'Toward the center of the pen, with no gutter', false, 3);
  END IF;

  -- 7. Number of farrowing/rearing pens
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A swine breeding farm keeps 50 sows with a litter index of 2.2 farrowings per sow per year. Each farrowing/rearing pen is occupied for 45 days per cycle. Using the PAES 401:2001 formula, number of pens = (number of sows x litter index x occupancy period / 365) x 1.1, how many farrowing/rearing pens are needed, rounded up to a whole pen?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A swine breeding farm keeps 50 sows with a litter index of 2.2 farrowings per sow per year. Each farrowing/rearing pen is occupied for 45 days per cycle. Using the PAES 401:2001 formula, number of pens = (number of sows x litter index x occupancy period / 365) x 1.1, how many farrowing/rearing pens are needed, rounded up to a whole pen?', 'single_choice', 'hard', 'Given: 50 sows; litter index 2.2; occupancy 45 days; allowance factor 1.1. Pens = (50 x 2.2 x 45 / 365) x 1.1 = (4,950 / 365) x 1.1 = 13.56 x 1.1 = 14.92, which rounds up to 15 pens. Omitting the 1.1 factor gives 13.56, or 14 pens.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '17 pens', false, 0),
      (v_question_id, '14 pens', false, 1),
      (v_question_id, '13 pens', false, 2),
      (v_question_id, '15 pens', true, 3);
  END IF;

  -- 8. Cooling nozzles in swine pens
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 401:2001 lists water spray nozzles as an optional cooling facility for swine pens. How should the nozzles be placed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 401:2001 lists water spray nozzles as an optional cooling facility for swine pens. How should the nozzles be placed?', 'single_choice', 'medium', 'PAES 401:2001 clause 8.5.6.2 states that water spray nozzles should be placed approximately 1.8 m above the floor and point straight down, to obtain the best spray pattern and cover the width of the pen.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 0.5 m above the floor, pointing upward at an angle', false, 0),
      (v_question_id, 'About 1.8 m above the floor, pointing straight down to cover the pen width', true, 1),
      (v_question_id, 'At the ridge of the roof, pointing at the feeding trough', false, 2),
      (v_question_id, 'About 0.9 m above the floor, directly over the waterer only', false, 3);
  END IF;

  -- 9. Natural ventilation layout of a swine house
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How does PAES 401:2001 require the natural ventilation openings of a swine house to be arranged?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How does PAES 401:2001 require the natural ventilation openings of a swine house to be arranged?', 'single_choice', 'medium', 'PAES 401:2001 clause 8.5.5.1 requires outlets to be ridge or chimney openings on the downwind side of the building, preferably at its highest point, and inlets to be vent doors, curtains or other large openings along the long sides of the building. Controllers such as winch systems or motorized arms may adjust the opening size as the weather changes.', NULL, NULL, 'draft', false, NULL, true, 'PAES 401:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Inlets at the short end walls only; outlets along the long sides', false, 0),
      (v_question_id, 'Outlets and inlets on the same side of the building to avoid drafts', false, 1),
      (v_question_id, 'Outlets at floor level on the upwind end wall; inlets at the ridge', false, 2),
      (v_question_id, 'Outlets as ridge or chimney openings on the downwind side at the highest point; inlets as large openings along the long sides', true, 3);
  END IF;

  -- 10. Broiler house floor area after 4 weeks
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A broiler house is stocked with 3,000 birds. PAES 402:2001 requires 6.25 m2 of floor space per 100 birds up to 4 weeks old and 12.50 m2 per 100 birds above 4 weeks old. How much additional floor area must be made available when the flock passes 4 weeks of age?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A broiler house is stocked with 3,000 birds. PAES 402:2001 requires 6.25 m2 of floor space per 100 birds up to 4 weeks old and 12.50 m2 per 100 birds above 4 weeks old. How much additional floor area must be made available when the flock passes 4 weeks of age?', 'single_choice', 'medium', 'Given: 3,000 birds; 6.25 m2 per 100 birds up to 4 weeks; 12.50 m2 per 100 birds above 4 weeks. Area up to 4 weeks = 30 x 6.25 = 187.5 m2. Area above 4 weeks = 30 x 12.50 = 375 m2. Additional area = 375 - 187.5 = 187.5 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 402:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '93.75 m2', false, 0),
      (v_question_id, '375.0 m2', false, 1),
      (v_question_id, '187.5 m2', true, 2),
      (v_question_id, '562.5 m2', false, 3);
  END IF;

  -- 11. Round feeders for broilers older than 4 weeks
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A broiler house will grow out 1,800 birds that are older than 4 weeks, using round feeders with 305 mm diameter pans. PAES 402:2001 requires 5 round feeders per 100 birds at this age. How many round feeders are needed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A broiler house will grow out 1,800 birds that are older than 4 weeks, using round feeders with 305 mm diameter pans. PAES 402:2001 requires 5 round feeders per 100 birds at this age. How many round feeders are needed?', 'single_choice', 'easy', 'Given: 1,800 birds; 5 round feeders per 100 birds. Number of feeders = (1,800 / 100) x 5 = 18 x 5 = 90 feeders. Using the 4 weeks-and-below rate of 4 per 100 birds would give only 72.', NULL, NULL, 'draft', false, NULL, true, 'PAES 402:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '180 feeders', false, 0),
      (v_question_id, '90 feeders', true, 1),
      (v_question_id, '72 feeders', false, 2),
      (v_question_id, '135 feeders', false, 3);
  END IF;

  -- 12. Cage versus litter-floor layer capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 510 m2 layer house can be stocked either with birds in cages, at 5 m2 per 100 birds, or with laying birds (beyond 22 weeks) on a litter floor, at 17 m2 per 100 birds, as specified in PAES 403:2001. How many more laying birds can the house hold with cages than with a litter floor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 510 m2 layer house can be stocked either with birds in cages, at 5 m2 per 100 birds, or with laying birds (beyond 22 weeks) on a litter floor, at 17 m2 per 100 birds, as specified in PAES 403:2001. How many more laying birds can the house hold with cages than with a litter floor?', 'single_choice', 'medium', 'Given: floor area 510 m2; cages = 5 m2 per 100 birds; laying litter floor = 17 m2 per 100 birds. Cage capacity = 510 / 5 x 100 = 10,200 birds. Litter-floor capacity = 510 / 17 x 100 = 3,000 birds. Difference = 10,200 - 3,000 = 7,200 birds.', NULL, NULL, 'draft', false, NULL, true, 'PAES 403:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7,200 birds', true, 0),
      (v_question_id, '13,200 birds', false, 1),
      (v_question_id, '3,000 birds', false, 2),
      (v_question_id, '10,200 birds', false, 3);
  END IF;

  -- 13. Litter depth and retaining wall
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a litter-type floor in a poultry house, what litter depth over the cemented floor and what retaining wall does the PAES for broiler and layer housing specify?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a litter-type floor in a poultry house, what litter depth over the cemented floor and what retaining wall does the PAES for broiler and layer housing specify?', 'single_choice', 'medium', 'PAES 402:2001 and PAES 403:2001 (clause 7.5.2.1) require litter at least 50 mm to 100 mm deep over the cemented floor, with a solid wall 600 mm high around the cemented floor to retain the litter.', NULL, NULL, 'draft', false, NULL, true, 'PAES 402:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 mm to 50 mm deep, retained by a 1.2 m wall', false, 0),
      (v_question_id, '150 mm to 200 mm deep, retained by a 300 mm wall', false, 1),
      (v_question_id, '50 mm to 100 mm deep, retained by wire mesh only', false, 2),
      (v_question_id, '50 mm to 100 mm deep, retained by a solid wall 600 mm high', true, 3);
  END IF;

  -- 14. Undesirable property of poultry litter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 402:2001 and PAES 403:2001 list the properties that litter material for poultry houses should have. Which of the following is NOT one of them?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 402:2001 and PAES 403:2001 list the properties that litter material for poultry houses should have. Which of the following is NOT one of them?', 'single_choice', 'easy', 'Litter should be light in weight, of medium particle size, highly absorbent, quick to dry, soft and compressible, of low thermal conductivity, and inexpensive. High thermal conductivity is the opposite of the required low thermal conductivity, because litter is meant to insulate the birds from the cold floor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 402:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Soft and compressible', false, 0),
      (v_question_id, 'High thermal conductivity', true, 1),
      (v_question_id, 'Highly absorbent', false, 2),
      (v_question_id, 'Dries rapidly', false, 3);
  END IF;

  -- 15. Summer temperature control in a poultry house
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In summertime, PAES 402:2001 does not allow the temperature in a poultry house to become higher than the outside temperature. Which measures does the standard list for lowering the house temperature?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In summertime, PAES 402:2001 does not allow the temperature in a poultry house to become higher than the outside temperature. Which measures does the standard list for lowering the house temperature?', 'single_choice', 'easy', 'PAES 402:2001 clause 8.2.2.6 states that house temperature should be lowered by providing additional water troughs, roof sprinklers, foggers and fans. Closing the vents or adding brooder heat would raise rather than lower the temperature.', NULL, NULL, 'draft', false, NULL, true, 'PAES 402:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Additional water troughs, roof sprinklers, foggers and fans', true, 0),
      (v_question_id, 'Heat lamps and plastic curtains on all sides', false, 1),
      (v_question_id, 'Closing all vents and adding hover covers', false, 2),
      (v_question_id, 'Additional brooder lamps and thicker litter', false, 3);
  END IF;

  -- 16. End-wall passage in a cage layer house
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Where carts are used for feeding and egg gathering in a cage layer house, PAES 403:2001 requires a clear passage of 800 mm between cage rows and the longitudinal walls. What clear passage must be provided at the end walls?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Where carts are used for feeding and egg gathering in a cage layer house, PAES 403:2001 requires a clear passage of 800 mm between cage rows and the longitudinal walls. What clear passage must be provided at the end walls?', 'single_choice', 'medium', 'PAES 403:2001 clause 8.4 requires a clear passage of 800 mm between cage rows and to the longitudinal walls, and 2.4 m at the end walls, so that carts can be turned and moved between rows.', NULL, NULL, 'draft', false, NULL, true, 'PAES 403:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.2 m', false, 0),
      (v_question_id, '1.8 m', false, 1),
      (v_question_id, '2.4 m', true, 2),
      (v_question_id, '0.8 m', false, 3);
  END IF;

  -- 17. Total floor area of a loose-housing dairy barn
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A loose-housing dairy barn is to hold 24 milking cows, 2 cows in maternity stalls and 10 yearlings. Using the PAES 407:2001 minimum floor areas of 6 m2 per milking cow, 10 m2 per cow in a maternity stall and 4 m2 per yearling, what is the minimum total floor area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A loose-housing dairy barn is to hold 24 milking cows, 2 cows in maternity stalls and 10 yearlings. Using the PAES 407:2001 minimum floor areas of 6 m2 per milking cow, 10 m2 per cow in a maternity stall and 4 m2 per yearling, what is the minimum total floor area?', 'single_choice', 'medium', 'Given: 24 milking cows at 6 m2; 2 maternity cows at 10 m2; 10 yearlings at 4 m2. Area = 24 x 6 + 2 x 10 + 10 x 4 = 144 + 20 + 40 = 204 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 407:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '214 m2', false, 0),
      (v_question_id, '204 m2', true, 1),
      (v_question_id, '184 m2', false, 2),
      (v_question_id, '196 m2', false, 3);
  END IF;

  -- 18. Maternity pens for a dairy herd
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dairy farm keeps 100 mature cows. PAES 407:2001 requires one maternity pen for every 20 to 25 mature cows. How many maternity pens must the housing provide?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A dairy farm keeps 100 mature cows. PAES 407:2001 requires one maternity pen for every 20 to 25 mature cows. How many maternity pens must the housing provide?', 'single_choice', 'easy', 'Given: 100 mature cows; one maternity pen per 20 to 25 cows. Pens = 100 / 25 = 4 up to 100 / 20 = 5, so 4 to 5 maternity pens are required. Maternity pens are for cows that are two months away from parturition.', NULL, NULL, 'draft', false, NULL, true, 'PAES 407:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 to 3 pens', false, 0),
      (v_question_id, '10 to 12 pens', false, 1),
      (v_question_id, '8 to 10 pens', false, 2),
      (v_question_id, '4 to 5 pens', true, 3);
  END IF;

  -- 19. Solid partitions between calf pens
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 407:2001 requires solid partitions between the individual pens of calves under 3 months of age. What is the reason given for this requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 407:2001 requires solid partitions between the individual pens of calves under 3 months of age. What is the reason given for this requirement?', 'single_choice', 'medium', 'PAES 407:2001 clause 7.1.2.3 requires solid partitions to prevent calves from licking each other, because hairballs could form in the underdeveloped rumen of the calf.', NULL, NULL, 'draft', false, NULL, true, 'PAES 407:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To reduce the noise made by the calves', false, 0),
      (v_question_id, 'To keep the calves warm during cold nights', false, 1),
      (v_question_id, 'To prevent calves from licking each other, since hairballs may form in the underdeveloped rumen', true, 2),
      (v_question_id, 'To stop feed from being spilled from one pen to the next', false, 3);
  END IF;

  -- 20. Roof slope with indigenous roofing materials
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The roof of a dairy cattle shed must not be flatter than 25% when roofed with G.I. sheets. What is the minimum roof slope under PAES 407:2001 if the roofing is made of indigenous materials?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The roof of a dairy cattle shed must not be flatter than 25% when roofed with G.I. sheets. What is the minimum roof slope under PAES 407:2001 if the roofing is made of indigenous materials?', 'single_choice', 'medium', 'PAES 407:2001 clause 6.2.2 requires a roof slope of not less than 25%, and a minimum of 58% if the roofing is made of indigenous materials. The same slopes are required in the PAES housing standards for goats and sheep, cattle feedlots and carabao feedlots.', NULL, NULL, 'draft', false, NULL, true, 'PAES 407:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '58%', true, 0),
      (v_question_id, '40%', false, 1),
      (v_question_id, '25%', false, 2),
      (v_question_id, '75%', false, 3);
  END IF;

  -- 21. Pen wall post spacing in a carabao feedlot
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a carabao feedlot, the pen walling posts are embedded in concrete pedestals at least 0.4 m deep. What is the maximum center-to-center spacing between posts under PAES 408:2001?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a carabao feedlot, the pen walling posts are embedded in concrete pedestals at least 0.4 m deep. What is the maximum center-to-center spacing between posts under PAES 408:2001?', 'single_choice', 'hard', 'PAES 408:2001 clause 6.3 limits the center-to-center post spacing of a carabao feedlot pen wall to 1.5 m. The 3 m post spacing is the value for the cattle feedlot (PAES 405) and dairy cattle housing (PAES 407) pen walls, which use the same 50 mm rails and 75 mm posts.', NULL, NULL, 'draft', false, NULL, true, 'PAES 408:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.0 m', false, 0),
      (v_question_id, '1.5 m', true, 1),
      (v_question_id, '3.0 m', false, 2),
      (v_question_id, '2.5 m', false, 3);
  END IF;

  -- 22. Floor space for pregnant and lactating does
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A goat house will hold 20 lactating small does (50 kg to 70 kg) and 10 pregnant small does of the same size. PAES 404:2001 requires 2.0 m2 per lactating small doe and 1.3 m2 per pregnant small doe. What is the total minimum floor space?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A goat house will hold 20 lactating small does (50 kg to 70 kg) and 10 pregnant small does of the same size. PAES 404:2001 requires 2.0 m2 per lactating small doe and 1.3 m2 per pregnant small doe. What is the total minimum floor space?', 'single_choice', 'medium', 'Given: 20 lactating does at 2.0 m2; 10 pregnant does at 1.3 m2. Floor space = 20 x 2.0 + 10 x 1.3 = 40 + 13 = 53 m2. Swapping the two rates gives the common wrong answer of 46 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 404:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '46 m2', false, 0),
      (v_question_id, '60 m2', false, 1),
      (v_question_id, '53 m2', true, 2),
      (v_question_id, '39 m2', false, 3);
  END IF;

  -- 23. Height of the trough bed above the apron
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Why does PAES 407:2001 require the bed of a dairy cattle feeding trough to be 0.15 m above the level of the apron?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Why does PAES 407:2001 require the bed of a dairy cattle feeding trough to be 0.15 m above the level of the apron?', 'single_choice', 'medium', 'PAES 407:2001 clause 7.2.1.4 sets the trough bed 0.15 m above the apron to facilitate the natural feeding stance of the animals. Keeping the animals from stepping into the trough is the job of the horizontal restraining rail, not of the trough height.', NULL, NULL, 'draft', false, NULL, true, 'PAES 407:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To keep manure from the apron out of the trough', false, 0),
      (v_question_id, 'To let the trough drain by gravity into the gutter', false, 1),
      (v_question_id, 'To prevent the animals from stepping into the trough', false, 2),
      (v_question_id, 'To facilitate the natural feeding stance of the animals', true, 3);
  END IF;

  -- 24. Cooling facility in a carabao feedlot
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a carabao feedlot with more than five heads, which cooling facility does PAES 408:2001 require?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a carabao feedlot with more than five heads, which cooling facility does PAES 408:2001 require?', 'single_choice', 'easy', 'PAES 408:2001 clause 7.2.3 requires built-in sprinklers for a feedlot with more than five heads, with all plumbing design and installation conforming to the National Plumbing Code of the Philippines.', NULL, NULL, 'draft', false, NULL, true, 'PAES 408:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Built-in sprinklers', true, 0),
      (v_question_id, 'A wallowing pond beside each pen', false, 1),
      (v_question_id, 'Exhaust fans mounted on the end walls', false, 2),
      (v_question_id, 'A mist fan for every pen', false, 3);
  END IF;

  -- 25. Milking parlor distance from manure and wastewater
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For sanitation, how far shall a milking parlor be from manure piles or a wastewater pond, according to PAES 409:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For sanitation, how far shall a milking parlor be from manure piles or a wastewater pond, according to PAES 409:2002?', 'single_choice', 'medium', 'PAES 409:2002 clause 4.2 requires the milking parlor to be at least 100 m away from manure piles or a wastewater pond. The 30 m and 180 m or 275 m figures in clause 4.1 are the minimum and maximum distances from the lactating barn.', NULL, NULL, 'draft', false, NULL, true, 'PAES 409:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 m', false, 0),
      (v_question_id, '180 m', false, 1),
      (v_question_id, '50 m', false, 2),
      (v_question_id, '100 m', true, 3);
  END IF;

  -- 26. Holding area for a milking herd
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A milking parlor serves a herd of 24 cows. PAES 409:2002 requires a minimum holding area (wash pen) of 2.23 m2 per animal. What is the minimum holding area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A milking parlor serves a herd of 24 cows. PAES 409:2002 requires a minimum holding area (wash pen) of 2.23 m2 per animal. What is the minimum holding area?', 'single_choice', 'easy', 'Given: 24 cows; 2.23 m2 per animal. Holding area = 24 x 2.23 = 53.52 m2. The holding area must also be roofed, paved with a rough finish, and sloped 2% to 4% away from the parlor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 409:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.76 m2', false, 0),
      (v_question_id, '53.52 m2', true, 1),
      (v_question_id, '66.90 m2', false, 2),
      (v_question_id, '44.60 m2', false, 3);
  END IF;

  -- 27. Milking stall width for pipeline milking
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 409:2002, what stall width shall be provided in a milking parlor that uses a pipeline milking system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 409:2002, what stall width shall be provided in a milking parlor that uses a pipeline milking system?', 'single_choice', 'medium', 'PAES 409:2002 clause 6.3.3 specifies a milking stall width of 0.7 m to 0.8 m for a pipeline milking system. A wider stall of 1 m to 1.1 m is required when a bucket milking machine is used or when milking is done by hand.', NULL, NULL, 'draft', false, NULL, true, 'PAES 409:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.2 m to 1.5 m', false, 0),
      (v_question_id, '1.0 m to 1.1 m', false, 1),
      (v_question_id, '0.7 m to 0.8 m', true, 2),
      (v_question_id, '0.4 m to 0.6 m', false, 3);
  END IF;

  -- 28. Horizontal run of a cattle loading ramp
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cattle loading ramp must reach the deck of a tractor-trailer that is 1.2 m high. If the ramp is built at the 30% slope recommended in PAES 406:2001 (rise divided by horizontal run), what horizontal run does it need?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A cattle loading ramp must reach the deck of a tractor-trailer that is 1.2 m high. If the ramp is built at the 30% slope recommended in PAES 406:2001 (rise divided by horizontal run), what horizontal run does it need?', 'single_choice', 'hard', 'Given: deck height (rise) = 1.2 m; slope = 30% = 0.30. Run = rise / slope = 1.2 / 0.30 = 4.0 m. The maximum slopes are 36% for a permanent ramp (run 3.33 m) and 47% for a portable ramp (run 2.55 m), which would make the ramp steeper than recommended.', NULL, NULL, 'draft', false, NULL, true, 'PAES 406:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.00 m', true, 0),
      (v_question_id, '5.00 m', false, 1),
      (v_question_id, '2.55 m', false, 2),
      (v_question_id, '3.33 m', false, 3);
  END IF;

  -- 29. Holding and crowding pen area for a cattle ranch
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cattle ranch handles 40 steers averaging 300 kg each. PAES 406:2001 requires 1.6 m2 per animal in the holding pen and 0.9 m2 per animal in the crowding pen for cattle weighing 270 kg to 540 kg. What combined area of holding pen and crowding pen is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A cattle ranch handles 40 steers averaging 300 kg each. PAES 406:2001 requires 1.6 m2 per animal in the holding pen and 0.9 m2 per animal in the crowding pen for cattle weighing 270 kg to 540 kg. What combined area of holding pen and crowding pen is required?', 'single_choice', 'medium', 'Given: 40 animals in the 270-540 kg class; holding pen 1.6 m2 per animal; crowding pen 0.9 m2 per animal. Holding pen = 40 x 1.6 = 64 m2. Crowding pen = 40 x 0.9 = 36 m2. Combined area = 64 + 36 = 100 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 406:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 m2', true, 0),
      (v_question_id, '72 m2', false, 1),
      (v_question_id, '120 m2', false, 2),
      (v_question_id, '64 m2', false, 3);
  END IF;

  -- 30. Lairage pen area for one day of slaughter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A slaughterhouse lairage must hold one day of kill: 20 cattle in loose-type pens, 30 hogs weighing 90 kg each, and 40 goats. Using the PAES 410:2000 space requirements of 2.23 m2 per large animal in loose type, 0.60 m2 per hog weighing less than 100 kg, and 0.56 m2 per small animal, what is the minimum pen area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A slaughterhouse lairage must hold one day of kill: 20 cattle in loose-type pens, 30 hogs weighing 90 kg each, and 40 goats. Using the PAES 410:2000 space requirements of 2.23 m2 per large animal in loose type, 0.60 m2 per hog weighing less than 100 kg, and 0.56 m2 per small animal, what is the minimum pen area?', 'single_choice', 'hard', 'Given: 20 cattle x 2.23 m2 = 44.6 m2; 30 hogs x 0.60 m2 = 18.0 m2; 40 goats x 0.56 m2 = 22.4 m2. Total = 44.6 + 18.0 + 22.4 = 85.0 m2. Using the tie-up value of 3.30 m2 per large animal would give 106.4 m2, and using 0.7 m2 per hog would give 88.0 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 410:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '88.0 m2', false, 0),
      (v_question_id, '106.4 m2', false, 1),
      (v_question_id, '85.0 m2', true, 2),
      (v_question_id, '62.6 m2', false, 3);
  END IF;

  -- 31. Floor drain inlets in a slaughterhouse
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A slaughterhouse dressing hall has a floor measuring 15 m x 16 m. PAES 411:2000 requires one drain inlet for each 40 m2 of floor space. How many drain inlets must be provided at minimum?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A slaughterhouse dressing hall has a floor measuring 15 m x 16 m. PAES 411:2000 requires one drain inlet for each 40 m2 of floor space. How many drain inlets must be provided at minimum?', 'single_choice', 'easy', 'Given: floor area = 15 x 16 = 240 m2; one inlet per 40 m2. Inlets = 240 / 40 = 6. Each inlet must be at least 300 x 300 mm, and more or larger inlets are needed where water discharge is high.', NULL, NULL, 'draft', false, NULL, true, 'PAES 411:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 inlets', false, 0),
      (v_question_id, '7 inlets', false, 1),
      (v_question_id, '8 inlets', false, 2),
      (v_question_id, '6 inlets', true, 3);
  END IF;

  -- 32. Dewatering tank capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a slaughterhouse, drainage pipes discharge into a sump from which the material is transferred to an elevated dewatering tank. PAES 411:2000 sizes the tank at 0.014 m3 per head of the maximum number of animals slaughtered daily. What capacity is required for a plant that slaughters at most 120 animals per day?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a slaughterhouse, drainage pipes discharge into a sump from which the material is transferred to an elevated dewatering tank. PAES 411:2000 sizes the tank at 0.014 m3 per head of the maximum number of animals slaughtered daily. What capacity is required for a plant that slaughters at most 120 animals per day?', 'single_choice', 'medium', 'Given: 120 animals per day; 0.014 m3 per head. Capacity = 120 x 0.014 = 1.68 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 411:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8.57 m3', false, 0),
      (v_question_id, '1.68 m3', true, 1),
      (v_question_id, '0.17 m3', false, 2),
      (v_question_id, '16.80 m3', false, 3);
  END IF;

  -- 33. Fall of a slaughterhouse blood drain
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The bleeding area drain of a slaughterhouse runs 8 m to the blood tank. PAES 411:2000 requires the blood drain to be sloped not less than 170 mm per meter to the discharge point. What is the minimum drop in elevation along this run?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The bleeding area drain of a slaughterhouse runs 8 m to the blood tank. PAES 411:2000 requires the blood drain to be sloped not less than 170 mm per meter to the discharge point. What is the minimum drop in elevation along this run?', 'single_choice', 'medium', 'Given: run = 8 m; minimum slope = 170 mm per meter. Drop = 8 x 170 mm = 1,360 mm = 1.36 m. The blood drain must also have a diameter of at least 150 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 411:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.85 m', false, 0),
      (v_question_id, '1.20 m', false, 1),
      (v_question_id, '1.70 m', false, 2),
      (v_question_id, '1.36 m', true, 3);
  END IF;

  -- 34. Moving-top evisceration table requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 411:2000, a slaughterhouse must be provided with a moving-top evisceration table when its slaughter rate is at least:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 411:2000, a slaughterhouse must be provided with a moving-top evisceration table when its slaughter rate is at least:', 'single_choice', 'hard', 'PAES 411:2000 clause 8.5.8 requires a moving-top evisceration table when the slaughtering rate is 25 or more cattle per hour or 150 or more swine per hour. The table needs cold water sprays and a vented sanitizing compartment kept at a minimum of 82 degrees C.', NULL, NULL, 'draft', false, NULL, true, 'PAES 411:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 cattle or 150 swine per hour', true, 0),
      (v_question_id, '50 cattle or 300 swine per hour', false, 1),
      (v_question_id, '10 cattle or 50 swine per hour', false, 2),
      (v_question_id, '15 cattle or 100 swine per hour', false, 3);
  END IF;

  -- 35. Painting of internal slaughterhouse walls
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which requirement of PAES 411:2000 applies to the internal walls of a slaughterhouse in the rooms where carcasses are processed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which requirement of PAES 411:2000 applies to the internal walls of a slaughterhouse in the rooms where carcasses are processed?', 'single_choice', 'medium', 'PAES 411:2000 clause 7.3.6 states that internal walls where carcasses are processed shall not be painted. They are instead made of concrete, granolithic concrete or tiles, smooth and impervious to liquids up to 1.8 m, and coved to the floor with a minimum radius of 50 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 411:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'They shall be painted with white lead-free enamel', false, 0),
      (v_question_id, 'They shall not be painted', true, 1),
      (v_question_id, 'They shall be left rough to help the workers grip the surface', false, 2),
      (v_question_id, 'They shall be covered with wood paneling for insulation', false, 3);
  END IF;

  -- 36. Cold storage in a poultry dressing plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 412:2002, a poultry dressing plant must provide chilling and cold storage if the carcasses are not removed within a certain time after dressing. What is that time, and what temperature must the cold storage maintain?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 412:2002, a poultry dressing plant must provide chilling and cold storage if the carcasses are not removed within a certain time after dressing. What is that time, and what temperature must the cold storage maintain?', 'single_choice', 'medium', 'PAES 412:2002 clause 6.5 requires adequate chilling and cold storage facilities if all carcasses are not removed within six hours after dressing. The cold storage must have the capacity to maintain a temperature of 4 degrees C or less.', NULL, NULL, 'draft', false, NULL, true, 'PAES 412:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Twelve hours; 10 degrees C or less', false, 0),
      (v_question_id, 'Six hours; -18 degrees C or less', false, 1),
      (v_question_id, 'Six hours; 4 degrees C or less', true, 2),
      (v_question_id, 'Two hours; 4 degrees C or less', false, 3);
  END IF;

  -- 37. Scrape alley width for swine and poultry
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 414-1:2002 on agricultural liquid waste, what width should a scrape alley have in swine and poultry houses?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 414-1:2002 on agricultural liquid waste, what width should a scrape alley have in swine and poultry houses?', 'single_choice', 'medium', 'PAES 414-1:2002 clause 7.1.1.1 gives a scrape alley width of 1 m to 2.5 m for swine and poultry and 2.5 m to 4 m for dairy and beef cattle. The 0.4 m to 0.6 m figure is the width of a scrape gutter in a confined stall barn.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414-1:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 m to 2.5 m', true, 0),
      (v_question_id, '0.4 m to 0.6 m', false, 1),
      (v_question_id, '2.5 m to 4 m', false, 2),
      (v_question_id, '4 m to 6 m', false, 3);
  END IF;

  -- 38. Drop of a swine gravity-drain gutter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gravity-drain gutter in a swine building is 15 m long and is built with the 1% bottom slope specified in PAES 414-1:2002. How much lower is the bottom at the drain end than at the far end?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gravity-drain gutter in a swine building is 15 m long and is built with the 1% bottom slope specified in PAES 414-1:2002. How much lower is the bottom at the drain end than at the far end?', 'single_choice', 'easy', 'Given: length = 15 m; slope = 1% = 0.01. Drop = 15 m x 0.01 = 0.15 m = 150 mm. The gutter should also be deep and narrow, at least 760 mm deep and 150 mm wide.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414-1:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,500 mm', false, 0),
      (v_question_id, '15 mm', false, 1),
      (v_question_id, '760 mm', false, 2),
      (v_question_id, '150 mm', true, 3);
  END IF;

  -- 39. Required volume of an anaerobic lagoon
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An anaerobic lagoon for a piggery must hold, over its treatment period, 120 m3 of manure, 300 m3 of wastewater and 40 m3 of clean dilution water. The total daily volatile solids loading is 160 kg/day, the selected volatile solids loading rate is 32 kg per 1,000 m3 per day, and the sludge volume is 300 m3. Using PAES 414-1:2002 (waste volume WV = manure + wastewater + clean water; minimum treatment volume TVmin = daily volatile solids loading / loading rate; lagoon volume = WV + TVmin + sludge volume), what is the minimum required lagoon volume?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An anaerobic lagoon for a piggery must hold, over its treatment period, 120 m3 of manure, 300 m3 of wastewater and 40 m3 of clean dilution water. The total daily volatile solids loading is 160 kg/day, the selected volatile solids loading rate is 32 kg per 1,000 m3 per day, and the sludge volume is 300 m3. Using PAES 414-1:2002 (waste volume WV = manure + wastewater + clean water; minimum treatment volume TVmin = daily volatile solids loading / loading rate; lagoon volume = WV + TVmin + sludge volume), what is the minimum required lagoon volume?', 'single_choice', 'hard', 'Given: manure 120 m3; wastewater 300 m3; clean water 40 m3; VST = 160 kg/day; VSLR = 32 kg per 1,000 m3 per day; sludge volume 300 m3. WV = 120 + 300 + 40 = 460 m3. TVmin = 160 / 32 x 1,000 m3 = 5,000 m3. Lagoon volume = 460 + 5,000 + 300 = 5,760 m3. Leaving out the waste volume gives 5,300 m3 and leaving out the sludge gives 5,460 m3.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414-1:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,300 m3', false, 0),
      (v_question_id, '5,460 m3', false, 1),
      (v_question_id, '5,760 m3', true, 2),
      (v_question_id, '760 m3', false, 3);
  END IF;

  -- 40. Minimum depth of an anaerobic lagoon
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum acceptable depth of an anaerobic lagoon for livestock waste under PAES 414-1:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the minimum acceptable depth of an anaerobic lagoon for livestock waste under PAES 414-1:2002?', 'single_choice', 'medium', 'PAES 414-1:2002 states that the minimum acceptable depth for anaerobic lagoons is 1.8 m. By contrast, an aerobic lagoon is operated at a depth of 0.6 m to 1.5 m. Lagoons should also be located on soil with at least 15% clay content and have the storage bottom at least 1 m above the water table.', NULL, NULL, 'draft', false, NULL, true, 'PAES 414-1:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.2 m', false, 0),
      (v_question_id, '1.8 m', true, 1),
      (v_question_id, '0.6 m', false, 2),
      (v_question_id, '3.0 m', false, 3);
  END IF;

END $$;
