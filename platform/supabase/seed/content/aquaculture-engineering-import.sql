-- Aquaculture Engineering quiz batch (27 questions, 1 topic). Every fact is
-- drawn directly from a lecture draft on Principles of Aquaculture
-- Engineering read in full (2026-10-02) — no invented facts. This topic had
-- only 22 published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). No PAES standard specific to
-- aquaculture/fishpond facilities was found in the reference library, so
-- every question here has is_paes=false and paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Aquaculture Engineering (LAND_WATER) — 27 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Aquaculture Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Aquaculture Engineering';
  END IF;

  -- 1. Aquaculture vs fishing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly distinguishes aquaculture from fishing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly distinguishes aquaculture from fishing?', 'single_choice', 'easy', 'Aquaculture involves deliberately cultivating and raising aquatic organisms in controlled environments for human consumption, whereas fishing is comparable to hunting -- collecting aquatic animals from their natural habitat.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aquaculture refers to the collection of aquatic animals from their natural habitat, while fishing refers to raising them in captivity', false, 0),
      (v_question_id, 'Aquaculture is the deliberate cultivation of aquatic organisms in controlled environments for human consumption, while fishing is comparable to hunting aquatic animals from their natural habitat', true, 1),
      (v_question_id, 'Both aquaculture and fishing exclusively use controlled, man-made environments', false, 2),
      (v_question_id, 'Aquaculture only applies to seawater species, while fishing only applies to freshwater species', false, 3);
  END IF;

  -- 2. Freshwater aquaculture salinity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the classification of aquaculture based on growing medium/source of water, what salinity level characterizes freshwater aquaculture?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the classification of aquaculture based on growing medium/source of water, what salinity level characterizes freshwater aquaculture?', 'single_choice', 'easy', 'Freshwater aquaculture uses water sourced from springs, rivers, lakes, and developed underground water resources, with a salinity of less than 0.5 ppt. Typical species include tilapia, carp, milkfish, catfish, and freshwater shrimp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 0.5 ppt', true, 0),
      (v_question_id, '0.5 to 35 ppt', false, 1),
      (v_question_id, 'Greater than 35 ppt', false, 2),
      (v_question_id, '3.5 to 5 ppt', false, 3);
  END IF;

  -- 3. Brackish water aquaculture
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Brackish water aquaculture, typically practiced in estuaries and mangrove areas where river water mixes with tidal water, operates within what salinity range?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Brackish water aquaculture, typically practiced in estuaries and mangrove areas where river water mixes with tidal water, operates within what salinity range?', 'single_choice', 'medium', 'Brackish water is a combination of fresh and sea water, found in estuaries and mangrove areas, with salinity that varies from 0.5 to 35 ppt depending on the tidal phase and freshwater discharge. Typical species cultured include milkfish, tilapia, crabs, and prawns.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 0.5 ppt', false, 0),
      (v_question_id, '0.5 to 35 ppt', true, 1),
      (v_question_id, 'Greater than 35 ppt', false, 2),
      (v_question_id, '35 to 50 ppt', false, 3);
  END IF;

  -- 4. Mariculture
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Mariculture (sea water aquaculture) is defined by a salinity greater than 35 ppt. Which pair of species is specifically noted as being cultured in pens and cages under this system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Mariculture (sea water aquaculture) is defined by a salinity greater than 35 ppt. Which pair of species is specifically noted as being cultured in pens and cages under this system?', 'single_choice', 'medium', 'Mariculture uses sea water (greater than 35 ppt) as the growth medium. Fish species such as lapu-lapu and kitang are cultured in pens and cages, while other species such as seaweeds, oysters, and mussels are cultured in shallow sandy areas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tilapia and carp', false, 0),
      (v_question_id, 'Lapu-lapu and kitang', true, 1),
      (v_question_id, 'Milkfish and prawns', false, 2),
      (v_question_id, 'Oysters and mussels', false, 3);
  END IF;

  -- 5. Extensive method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which aquaculture production method is characterized by a minimal stocking density of 1-3 fish per square meter, reliance on natural feed, and minimal water exchange?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which aquaculture production method is characterized by a minimal stocking density of 1-3 fish per square meter, reliance on natural feed, and minimal water exchange?', 'single_choice', 'easy', 'The extensive method is characterized by minimal stocking density (1-3 fish per sq. m), the use of natural feed, and minimal water exchange.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Extensive method', true, 0),
      (v_question_id, 'Semi-intensive method', false, 1),
      (v_question_id, 'Intensive method', false, 2),
      (v_question_id, 'Polyculture method', false, 3);
  END IF;

  -- 6. Semi-intensive method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pond stocked at 4-6 fish per square meter, fed with natural feed supplemented by fertilizer, and given partial water exchange is being operated under which production method?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pond stocked at 4-6 fish per square meter, fed with natural feed supplemented by fertilizer, and given partial water exchange is being operated under which production method?', 'single_choice', 'medium', 'The semi-intensive method is characterized by moderate stocking density (4-6 fish per sq. m), use of natural and supplemental feed (with fertilizer), and partial water exchange.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Extensive method', false, 0),
      (v_question_id, 'Semi-intensive method', true, 1),
      (v_question_id, 'Intensive method', false, 2),
      (v_question_id, 'Monoculture method', false, 3);
  END IF;

  -- 7. Intensive method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which production method requires a high water exchange rate specifically for maximum aeration, alongside a high stocking density of 6 or more fish per sq. m and the use of artificial feeds?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which production method requires a high water exchange rate specifically for maximum aeration, alongside a high stocking density of 6 or more fish per sq. m and the use of artificial feeds?', 'single_choice', 'medium', 'The intensive method is characterized by high stocking density (6 and more fish per sq. m), the use of artificial feeds, and a high water exchange rate for maximum aeration.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Extensive method', false, 0),
      (v_question_id, 'Semi-intensive method', false, 1),
      (v_question_id, 'Intensive method', true, 2),
      (v_question_id, 'Polyculture method', false, 3);
  END IF;

  -- 8. Water-use classification: flow through
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'When aquaculture systems are classified based on water use, which system is defined as one where the water passes through the aquaculture system and is then discharged?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'When aquaculture systems are classified based on water use, which system is defined as one where the water passes through the aquaculture system and is then discharged?', 'single_choice', 'easy', 'Based on water use, aquaculture systems are classified as open systems (raised in natural or man-made bodies of water such as cages, pens, enclosures), flow through systems (water passes through and is then discharged), and closed systems (water is reconditioned and recirculated).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Open system', false, 0),
      (v_question_id, 'Flow through system', true, 1),
      (v_question_id, 'Closed system', false, 2),
      (v_question_id, 'Polyculture system', false, 3);
  END IF;

  -- 9. Broodstock
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In aquaculture facility classification based on purpose or function, what is a "broodstock" enclosure specifically used for?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In aquaculture facility classification based on purpose or function, what is a "broodstock" enclosure specifically used for?', 'single_choice', 'easy', 'Broodstock enclosures are defined as facilities for the conditioning of mature fish for breeding, one of the categories under the classification of aquaculture facilities based on purpose or function.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conditioning of mature fish for breeding', true, 0),
      (v_question_id, 'Rearing juvenile fish to market size', false, 1),
      (v_question_id, 'Hatching fertilized eggs', false, 2),
      (v_question_id, 'Housing fingerlings before stocking', false, 3);
  END IF;

  -- 10. Products classification: Recreation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Aquatic organisms raised primarily for leisure, such as bait fish for sport fishing, fall under which classification of aquaculture based on products?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Aquatic organisms raised primarily for leisure, such as bait fish for sport fishing, fall under which classification of aquaculture based on products?', 'single_choice', 'easy', 'Based on aquaculture products, recreation refers to aquatic organisms raised primarily for leisure (e.g., bait fish for sport fishing), distinct from nutraceutical products (raised for food and medicine) and ornamental organisms (raised for aesthetic appeal).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Nutraceutical', false, 0),
      (v_question_id, 'Recreation', true, 1),
      (v_question_id, 'Ornamental', false, 2),
      (v_question_id, 'Broodstock', false, 3);
  END IF;

  -- 11. Stenohaline vs euryhaline
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Prawns and crabs, which can withstand wide variations in salinity such as those found in brackish water, are classified as which type of organism?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Prawns and crabs, which can withstand wide variations in salinity such as those found in brackish water, are classified as which type of organism?', 'single_choice', 'easy', 'Euryhaline organisms can withstand a wide variation in salinity of the growing medium, such as prawns and crabs in brackish water. Stenohaline organisms, such as carp and mackerel, can withstand only small variations in salinity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stenohaline', false, 0),
      (v_question_id, 'Euryhaline', true, 1),
      (v_question_id, 'Anadromous', false, 2),
      (v_question_id, 'Katadromous', false, 3);
  END IF;

  -- 12. Minimum water supply requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For aquaculture systems supplied with water from reservoirs such as rivers, wells, and groundwater, what is the minimum water supply requirement per hectare of pond?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For aquaculture systems supplied with water from reservoirs such as rivers, wells, and groundwater, what is the minimum water supply requirement per hectare of pond?', 'single_choice', 'medium', 'An adequate and pollution-free water supply is the most crucial factor in aquaculture site selection. Systems supplied from reservoirs such as rivers, wells, or groundwater require a minimum of 5 L/sec per hectare of pond.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 L/sec/ha', false, 0),
      (v_question_id, '5 L/sec/ha', true, 1),
      (v_question_id, '10 L/sec/ha', false, 2),
      (v_question_id, '15 L/sec/ha', false, 3);
  END IF;

  -- 13. Catchment area ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a pond system that relies on rainwater as its water supply, what is the minimum recommended ratio of catchment area to pond area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a pond system that relies on rainwater as its water supply, what is the minimum recommended ratio of catchment area to pond area?', 'single_choice', 'hard', 'Systems supplied by rainwater require a minimum of 10-15 hectares of catchment area for every 1 hectare of pond.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1-5 ha of catchment area to 1 ha of pond', false, 0),
      (v_question_id, '5-10 ha of catchment area to 1 ha of pond', false, 1),
      (v_question_id, '10-15 ha of catchment area to 1 ha of pond', true, 2),
      (v_question_id, '20-25 ha of catchment area to 1 ha of pond', false, 3);
  END IF;

  -- 14. pH range
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the acceptable pH range of water quality parameters for aquaculture applications?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the acceptable pH range of water quality parameters for aquaculture applications?', 'single_choice', 'easy', 'The acceptable range of pH for aquaculture water quality parameters is 7.0 to 8.5.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.0 - 7.0', false, 0),
      (v_question_id, '7.0 - 8.5', true, 1),
      (v_question_id, '5.5 - 7.5', false, 2),
      (v_question_id, '8.5 - 10.0', false, 3);
  END IF;

  -- 15. Alkalinity range
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the acceptable alkalinity range (as CaCO3) for water quality in aquaculture ponds?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the acceptable alkalinity range (as CaCO3) for water quality in aquaculture ponds?', 'single_choice', 'hard', 'Acceptable alkalinity, measured as CaCO3, ranges from 100 to 400 ppm (mg/L) in the acceptable water quality parameters for aquaculture applications.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0 - 50 ppm', false, 0),
      (v_question_id, '100 - 400 ppm', true, 1),
      (v_question_id, '400 - 600 ppm', false, 2),
      (v_question_id, '50 - 100 ppm', false, 3);
  END IF;

  -- 16. Dissolved oxygen minimum
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum acceptable level of dissolved oxygen in the acceptable water quality parameters for aquaculture applications?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the minimum acceptable level of dissolved oxygen in the acceptable water quality parameters for aquaculture applications?', 'single_choice', 'easy', 'The acceptable dissolved oxygen level for aquaculture applications is greater than 3 mg/L.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Greater than 0.5 mg/L', false, 0),
      (v_question_id, 'Greater than 1 mg/L', false, 1),
      (v_question_id, 'Greater than 3 mg/L', true, 2),
      (v_question_id, 'Greater than 5 mg/L', false, 3);
  END IF;

  -- 17. Unionized ammonia
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the acceptable water quality parameters for aquaculture, what is the acceptable maximum concentration of unionized ammonia (NH3)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among the acceptable water quality parameters for aquaculture, what is the acceptable maximum concentration of unionized ammonia (NH3)?', 'single_choice', 'hard', 'Unionized ammonia (NH3), which is toxic to aquatic organisms, must be kept to less than 0.02 ppm according to the acceptable range of water quality parameters for aquaculture applications.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 0.02 ppm', true, 0),
      (v_question_id, 'Less than 0.1 ppm', false, 1),
      (v_question_id, 'Less than 0.2 ppm', false, 2),
      (v_question_id, 'Less than 3.0 ppm', false, 3);
  END IF;

  -- 18. Soil type
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What type of soil is generally considered best both for the construction of a fish pond and for supporting vegetation at the pond bottom?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What type of soil is generally considered best both for the construction of a fish pond and for supporting vegetation at the pond bottom?', 'single_choice', 'easy', 'Sandy clay to clayey loam is generally considered the best type of soil for both pond construction and vegetation. Clayey soils have good compaction and low permeability, but as clay content decreases, suitability for ponds also decreases.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pure sand', false, 0),
      (v_question_id, 'Sandy clay to clayey loam', true, 1),
      (v_question_id, 'Pure clay', false, 2),
      (v_question_id, 'Loamy sand', false, 3);
  END IF;

  -- 19. Slope percentage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For site selection in aquaculture, what slope is generally considered good for a flat area being developed into a fish pond?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For site selection in aquaculture, what slope is generally considered good for a flat area being developed into a fish pond?', 'single_choice', 'easy', 'Generally, flat areas with a slope of about 3 percent are considered a good area for aquaculture site development.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 1 percent', false, 0),
      (v_question_id, 'About 3 percent', true, 1),
      (v_question_id, 'About 10 percent', false, 2),
      (v_question_id, 'About 15 percent', false, 3);
  END IF;

  -- 20. Flood design recurrence interval
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'When accounting for flooding in fish pond design, ponds should be designed based on the height of a flood with what recurrence interval?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'When accounting for flooding in fish pond design, ponds should be designed based on the height of a flood with what recurrence interval?', 'single_choice', 'medium', 'Rainfall and watershed size are evaluated due to their influence on flooding and runoff. Ponds should be designed based on the height of a flood with a recurrence interval of 10-15 years.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1-5 years', false, 0),
      (v_question_id, '10-15 years', true, 1),
      (v_question_id, '25-50 years', false, 2),
      (v_question_id, '50-100 years', false, 3);
  END IF;

  -- 21. Pen vs cage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In pen and cage culture systems, what distinguishes a "pen" from a "cage"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In pen and cage culture systems, what distinguishes a "pen" from a "cage"?', 'single_choice', 'easy', 'A pen is enclosed on the sides only, with the bottom formed by the lake or sea bottom, whereas a cage is enclosed on all sides except the top. Both are open enclosure systems usually constructed on publicly owned natural bodies of water.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A pen is enclosed on the sides with the bottom formed by the lake or sea bottom, while a cage is enclosed on all sides except the top', true, 0),
      (v_question_id, 'A cage is enclosed on the sides with the bottom formed by the lake or sea bottom, while a pen is enclosed on all sides except the top', false, 1),
      (v_question_id, 'Both a pen and a cage are fully enclosed, including the bottom and the top', false, 2),
      (v_question_id, 'Both a pen and a cage are left open on all sides, including the bottom', false, 3);
  END IF;

  -- 22. Excavated/dugout pond
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of pond is a reservoir dug out of the soil, generally constructed in relatively flat areas, and must be pumped to drain rather than drained by gravity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of pond is a reservoir dug out of the soil, generally constructed in relatively flat areas, and must be pumped to drain rather than drained by gravity?', 'single_choice', 'medium', 'Excavated/dugout ponds are reservoirs dug out in the soil and filled with water for aquaculture production. They are generally constructed in relatively flat areas and have to be pumped to drain.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Watershed pond', false, 0),
      (v_question_id, 'Excavated/Dugout pond', true, 1),
      (v_question_id, 'Embankment pond', false, 2),
      (v_question_id, 'Raceway', false, 3);
  END IF;

  -- 23. Embankment pond
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which pond type, constructed using levees, dikes, and bunds to contain water, is described as the primary method of pond culture and can be constructed over a wide range of topography?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which pond type, constructed using levees, dikes, and bunds to contain water, is described as the primary method of pond culture and can be constructed over a wide range of topography?', 'single_choice', 'medium', 'Embankment ponds use levees, dikes, and bunds to contain water for raising aquaculture organisms. They are the primary method of pond culture and can be constructed over a wide range of topography, involving both digging (for depth) and construction (for embankments).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Watershed pond', false, 0),
      (v_question_id, 'Excavated/Dugout pond', false, 1),
      (v_question_id, 'Embankment pond', true, 2),
      (v_question_id, 'Raceway', false, 3);
  END IF;

  -- 24. Wave height formula / fetch
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the pond design wave height formula h = 100 x 1/3 (square root of fetch), what does "fetch" represent?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the pond design wave height formula h = 100 x 1/3 (square root of fetch), what does "fetch" represent?', 'single_choice', 'hard', 'The wave height formula (h = 100 x 1/3(sqrt of fetch)) is used in levee design, where fetch is defined as the distance over which the wind blows.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The depth of the pond', false, 0),
      (v_question_id, 'The distance over which the wind blows', true, 1),
      (v_question_id, 'The length of the levee', false, 2),
      (v_question_id, 'The total surface area of the pond', false, 3);
  END IF;

  -- 25. Levee orientation and construction allowances
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In levee design for fish ponds, which orientation relative to the wind reduces the levee''s susceptibility to erosion, and what additional allowances should be added for the core trench and for settlement, respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In levee design for fish ponds, which orientation relative to the wind reduces the levee''s susceptibility to erosion, and what additional allowances should be added for the core trench and for settlement, respectively?', 'single_choice', 'hard', 'A levee built perpendicular to the wind reduces its susceptibility to erosion, while one built parallel to the wind increases wind action and helps with aeration. An additional 20% should be added for the core trench and 15% for settlement.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Perpendicular to the wind; add 20% for core trench and 15% for settlement', true, 0),
      (v_question_id, 'Parallel to the wind; add 20% for core trench and 15% for settlement', false, 1),
      (v_question_id, 'Perpendicular to the wind; add 15% for core trench and 20% for settlement', false, 2),
      (v_question_id, 'Parallel to the wind; add 15% for core trench and 20% for settlement', false, 3);
  END IF;

  -- 26. Raceways
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What distinguishes a raceway from other aquaculture culture units?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What distinguishes a raceway from other aquaculture culture units?', 'single_choice', 'medium', 'Raceways are culture units in which water flows continuously, making a single pass through the unit before being discharged -- classifying them as flow-through systems.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Water flows continuously through the unit in a single pass before being discharged', true, 0),
      (v_question_id, 'Water is fully recirculated using biological and mechanical filters', false, 1),
      (v_question_id, 'Water remains stagnant throughout the production cycle', false, 2),
      (v_question_id, 'Water is supplied only by rainwater', false, 3);
  END IF;

  -- 27. RAS
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A Recirculating Aquaculture System (RAS) is best described as a production system that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A Recirculating Aquaculture System (RAS) is best described as a production system that:', 'single_choice', 'medium', 'A Recirculating Aquaculture System (RAS) recycles and renovates water for the culture of an aquatic organism. It is a self-contained aquaculture system that requires minimal water exchange due to the internal recycling of water and the use of biological and mechanical filters.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Recycles and renovates water for the culture of aquatic organisms, requiring minimal water exchange through the use of biological and mechanical filters', true, 0),
      (v_question_id, 'Discharges all water after a single continuous pass through the unit', false, 1),
      (v_question_id, 'Relies solely on natural rainfall for its water supply', false, 2),
      (v_question_id, 'Requires a high water exchange rate to achieve maximum aeration', false, 3);
  END IF;

END $$;
