-- Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences quiz batch 3 (35 questions, 1 topic).
-- Covers crop science (plant hormones, photoperiod, germination, cropping systems, tillage,
-- seedling methods, irrigation selection, fertilizer computations), soil physical properties
-- and soil moisture computations, animal science (digestive systems, reproduction, brooding,
-- swine terms), fishery science (fish life stages, spawning habitat, aquaculture output,
-- fishing-vessel classes, municipal waters), and ecological/environmental science
-- (eutrophication, BOD, dissolved oxygen, biodiversity, CDM credits, carbon accounting).
-- Every fact is drawn from review material in the repo; computations were re-derived.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). Only the broiler brooding temperature
-- question is tied to a standard clause (is_paes=true); all others have
-- is_paes=false and paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences (FUNDAMENTALS_SCIENCES) — 35 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'FUNDAMENTALS_SCIENCES';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: FUNDAMENTALS_SCIENCES';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences';
  END IF;

  -- 1. Trap crop
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A crop that is planted to protect the main crop by attracting the pest to itself is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A crop that is planted to protect the main crop by attracting the pest to itself is called a:', 'single_choice', 'easy', 'A trap crop is planted to attract pests away from the main crop. A catch crop is a short-term crop planted between main crops to use excess soil nutrients, a cover crop provides soil cover, and a green manure crop is grown only to be plowed under to improve soil fertility.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cover crop', false, 0),
      (v_question_id, 'Catch crop', false, 1),
      (v_question_id, 'Trap crop', true, 2),
      (v_question_id, 'Green manure crop', false, 3);
  END IF;

  -- 2. Ethylene
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which plant hormone is the only gaseous phytohormone and promotes fruit ripening?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which plant hormone is the only gaseous phytohormone and promotes fruit ripening?', 'single_choice', 'easy', 'Ethylene is the only gaseous phytohormone and promotes fruit ripening. Auxins promote stem elongation and root initiation, gibberellic acid promotes seed germination and fruit enlargement, and cytokinin promotes shoot growth and nutrient mobilization.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gibberellic acid', false, 0),
      (v_question_id, 'Auxin', false, 1),
      (v_question_id, 'Cytokinin', false, 2),
      (v_question_id, 'Ethylene', true, 3);
  END IF;

  -- 3. Short-day plant
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A plant that requires an extended dark period to induce flowering is classified, according to its photoperiodic response, as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A plant that requires an extended dark period to induce flowering is classified, according to its photoperiodic response, as a:', 'single_choice', 'medium', 'A short-day plant requires an extended dark period to induce flowering. A day-neutral plant flowers over a wide range of day lengths. A sciophyte is a shade-loving plant, which is a classification by light need and not by photoperiodic response.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Short-day plant', true, 0),
      (v_question_id, 'Long-day plant', false, 1),
      (v_question_id, 'Day-neutral plant', false, 2),
      (v_question_id, 'Sciophyte', false, 3);
  END IF;

  -- 4. Hypogeal germination
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In hypogeal seed germination, what happens to the cotyledons?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In hypogeal seed germination, what happens to the cotyledons?', 'single_choice', 'medium', 'In hypogeal germination the epicotyl emerges from the ground and the cotyledons stay below the ground surface. In epigeal germination the hypocotyl elongates and pushes the cotyledons above the ground.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'They are lifted above the ground by the elongating hypocotyl', false, 0),
      (v_question_id, 'They remain below the ground surface while the epicotyl emerges', true, 1),
      (v_question_id, 'They are shed before the radicle emerges', false, 2),
      (v_question_id, 'They become the first true leaves above the ground', false, 3);
  END IF;

  -- 5. Relay cropping
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Several crops are grown together, but the secondary crop is planted only after the flowering stage of the primary crop. This cropping system is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Several crops are grown together, but the secondary crop is planted only after the flowering stage of the primary crop. This cropping system is called:', 'single_choice', 'medium', 'In relay cropping the secondary crop is planted only after the primary crop has flowered. In intercropping the period of overlap is long enough to include the vegetative stage. Ratoon cropping is harvesting the same planting multiple times, and crop rotation grows crops in sequence on the same parcel.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Relay cropping', true, 0),
      (v_question_id, 'Intercropping', false, 1),
      (v_question_id, 'Ratoon cropping', false, 2),
      (v_question_id, 'Crop rotation', false, 3);
  END IF;

  -- 6. Conservation tillage residue
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tillage system is classified as conservation tillage when it maintains at least what percentage of residue cover on the soil surface after planting?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tillage system is classified as conservation tillage when it maintains at least what percentage of residue cover on the soil surface after planting?', 'single_choice', 'medium', 'Conservation tillage is a system that maintains at least 30% residue cover on the soil surface after planting. The residue helps retain moisture and control erosion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20%', false, 0),
      (v_question_id, '30%', true, 1),
      (v_question_id, '50%', false, 2),
      (v_question_id, '10%', false, 3);
  END IF;

  -- 7. Dapog method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the dapog method of raising rice seedlings, the pre-germinated seeds are sown on a flat cemented or puddled seedbed and are ready for transplanting after about:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the dapog method of raising rice seedlings, the pre-germinated seeds are sown on a flat cemented or puddled seedbed and are ready for transplanting after about:', 'single_choice', 'medium', 'Dapog seedlings, grown from pre-germinated seeds on a flat cemented or puddled soil with reliable irrigation, are ready for transplanting after 10 to 14 days, and uprooting is easier than with bed methods. The wet-bed method takes 15 to 21 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15 to 21 days', false, 0),
      (v_question_id, '30 to 35 days', false, 1),
      (v_question_id, '3 to 5 days', false, 2),
      (v_question_id, '10 to 14 days', true, 3);
  END IF;

  -- 8. Basin irrigation soil
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Basin irrigation, in which areas of land surrounded by dikes are flooded as in lowland rice production, is applicable to which soil condition?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Basin irrigation, in which areas of land surrounded by dikes are flooded as in lowland rice production, is applicable to which soil condition?', 'single_choice', 'medium', 'Basin irrigation is applicable to finely textured soils with low permeability. Border strip irrigation suits soils with medium infiltration rates, and drip irrigation is adaptable to uneven terrain.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Coarse sandy soils with very high permeability', false, 0),
      (v_question_id, 'Soils with medium infiltration rates only', false, 1),
      (v_question_id, 'Finely textured soils with low permeability', true, 2),
      (v_question_id, 'Steep, uneven terrain', false, 3);
  END IF;

  -- 9. Field capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The amount of water a soil can hold against the force of gravity, usually one to two days after irrigation, and which is the ceiling of the water available to plants, is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The amount of water a soil can hold against the force of gravity, usually one to two days after irrigation, and which is the ceiling of the water available to plants, is the:', 'single_choice', 'easy', 'Field capacity is the amount of water the soil can hold against gravity, usually one to two days after irrigation, and is the upper limit of water available to plants. The permanent wilting point is the water content below which plants permanently wilt, and at saturation all void spaces are filled with water.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Permanent wilting point', false, 0),
      (v_question_id, 'Saturation point', false, 1),
      (v_question_id, 'Hygroscopic coefficient', false, 2),
      (v_question_id, 'Field capacity', true, 3);
  END IF;

  -- 10. Texture, infiltration and water holding
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Compared with finer-textured soils, coarser-textured soils generally have:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Compared with finer-textured soils, coarser-textured soils generally have:', 'single_choice', 'medium', 'Coarser soils have higher infiltration rates than finer soils, but they have a lower water holding capacity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Higher infiltration rates and lower water holding capacity', true, 0),
      (v_question_id, 'Higher infiltration rates and higher water holding capacity', false, 1),
      (v_question_id, 'Lower infiltration rates and lower water holding capacity', false, 2),
      (v_question_id, 'Lower infiltration rates and higher water holding capacity', false, 3);
  END IF;

  -- 11. Proventriculus
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the digestive tract of poultry, which organ is considered the true stomach, where digestive juices break down the feed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the digestive tract of poultry, which organ is considered the true stomach, where digestive juices break down the feed?', 'single_choice', 'easy', 'The proventriculus is the true stomach of poultry, where digestive juices break down the feed. The crop temporarily stores and moistens feed, and the gizzard provides the mechanical breakdown of food.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cloaca', false, 0),
      (v_question_id, 'Gizzard', false, 1),
      (v_question_id, 'Proventriculus', true, 2),
      (v_question_id, 'Crop', false, 3);
  END IF;

  -- 12. Best time to inseminate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During the estrous cycle of a female farm animal, when is the best time to inseminate or to mate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'During the estrous cycle of a female farm animal, when is the best time to inseminate or to mate?', 'single_choice', 'medium', 'Estrus is the period of sexual receptivity due to high estrogen levels, and the best time to inseminate or to mate is at the end of estrus.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At the start of proestrus', false, 0),
      (v_question_id, 'At the end of estrus', true, 1),
      (v_question_id, 'During diestrus', false, 2),
      (v_question_id, 'At the beginning of estrus', false, 3);
  END IF;

  -- 13. Broiler brooding temperature
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to the standard for broiler housing, what is the recommended brooding temperature for chicks that are 8 to 14 days old?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to the standard for broiler housing, what is the recommended brooding temperature for chicks that are 8 to 14 days old?', 'single_choice', 'medium', 'The recommended brooding temperature schedule is 32 to 35 C for chicks aged 1 to 7 days, 29 to 32 C for 8 to 14 days, and 27 to 29 C for 14 to 21 days. Beyond 21 days, heat is provided only when necessary.', NULL, NULL, 'draft', false, NULL, true, 'PAES 402:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '27 to 29 C', false, 0),
      (v_question_id, '32 to 35 C', false, 1),
      (v_question_id, '29 to 32 C', true, 2),
      (v_question_id, '24 to 27 C', false, 3);
  END IF;

  -- 14. Boar taint
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the undesirable odor and taste of the meat derived from uncastrated swine called?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the undesirable odor and taste of the meat derived from uncastrated swine called?', 'single_choice', 'easy', 'Boar taint is the undesirable odor and taste found in meat from uncastrated male swine. A barrow is a male swine castrated before the development of secondary sexual characteristics.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Farrowing odor', false, 0),
      (v_question_id, 'Weaner taint', false, 1),
      (v_question_id, 'Barrow flavor', false, 2),
      (v_question_id, 'Boar taint', true, 3);
  END IF;

  -- 15. Fish fingerling size
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fish fingerling is a stage in the life cycle of a fish that measures about:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fish fingerling is a stage in the life cycle of a fish that measures about:', 'single_choice', 'medium', 'A fingerling measures about 6 to 13 cm, depending on the species. A fish fry is a stage at which a fish has just hatched, usually 1 to 2.5 cm in size.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 to 2.5 cm', false, 0),
      (v_question_id, '6 to 13 cm', true, 1),
      (v_question_id, '30 to 40 cm', false, 2),
      (v_question_id, '20 to 25 cm', false, 3);
  END IF;

  -- 16. Katadromous fish
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fish that spawns in salt water and then spends its life in freshwater habitats is described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fish that spawns in salt water and then spends its life in freshwater habitats is described as:', 'single_choice', 'medium', 'A katadromous fish spawns in salt water and then lives in freshwater. An anadromous fish does the opposite, spawning in freshwater and spending its life in salt water. Stenohaline and euryhaline describe tolerance to salinity variation, not spawning habitat.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Katadromous', true, 0),
      (v_question_id, 'Euryhaline', false, 1),
      (v_question_id, 'Anadromous', false, 2),
      (v_question_id, 'Stenohaline', false, 3);
  END IF;

  -- 17. Top aquaculture species 2024
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In 2024, which was the number one aquaculture species in the Philippines in terms of volume of production?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In 2024, which was the number one aquaculture species in the Philippines in terms of volume of production?', 'single_choice', 'easy', 'Seaweed was the number one aquaculture species in the Philippines in terms of volume of production in 2024.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tiger prawn', false, 0),
      (v_question_id, 'Milkfish', false, 1),
      (v_question_id, 'Seaweed', true, 2),
      (v_question_id, 'Tilapia', false, 3);
  END IF;

  -- 18. Commercial fishing scale
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Philippine fisheries law, fishing for trade and profit using a fishing vessel of 18 gross tons (GT) is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Philippine fisheries law, fishing for trade and profit using a fishing vessel of 18 gross tons (GT) is classified as:', 'single_choice', 'medium', 'Given: vessel of 18 GT. Municipal fishing uses vessels of 3 GT or less, small-scale commercial fishing uses 3.1 GT up to 20 GT, medium-scale commercial fishing uses 20.1 GT up to 150 GT, and large commercial fishing uses more than 150 GT. An 18-GT vessel is therefore small-scale commercial.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Small-scale commercial fishing', true, 0),
      (v_question_id, 'Large commercial fishing', false, 1),
      (v_question_id, 'Municipal fishing', false, 2),
      (v_question_id, 'Medium-scale commercial fishing', false, 3);
  END IF;

  -- 19. Eutrophication
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The accumulation of excessive nutrients, such as NPK fertilizers from agricultural fields, in bodies of water that leads to algal blooms and fish kills is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The accumulation of excessive nutrients, such as NPK fertilizers from agricultural fields, in bodies of water that leads to algal blooms and fish kills is called:', 'single_choice', 'medium', 'Eutrophication occurs when excess nutrients, such as nitrogen and phosphorus from fertilizers, accumulate in water and hasten the growth of aquatic vegetation and algae, leading to algal blooms and fish kills. Nitrification is the biological oxidation of ammonia to nitrate.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Nitrification', false, 0),
      (v_question_id, 'Desertification', false, 1),
      (v_question_id, 'Siltation', false, 2),
      (v_question_id, 'Eutrophication', true, 3);
  END IF;

  -- 20. Biochemical oxygen demand
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which water quality measure expresses the amount of oxygen that bacteria will consume while decomposing organic matter under aerobic conditions?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which water quality measure expresses the amount of oxygen that bacteria will consume while decomposing organic matter under aerobic conditions?', 'single_choice', 'medium', 'Biochemical oxygen demand (BOD) is the amount of oxygen consumed by bacteria while decomposing organic matter under aerobic conditions. DO is the oxygen present in the water, and COD measures oxygen demand through chemical oxidation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dissolved oxygen (DO)', false, 0),
      (v_question_id, 'Biochemical oxygen demand (BOD)', true, 1),
      (v_question_id, 'Chemical oxygen demand (COD)', false, 2),
      (v_question_id, 'Electrical conductivity (EC)', false, 3);
  END IF;

  -- 21. Dissolved oxygen daily cycle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Dissolved oxygen concentration in a waterbody is typically lowest at what time of day?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Dissolved oxygen concentration in a waterbody is typically lowest at what time of day?', 'single_choice', 'medium', 'Dissolved oxygen is lowest at sunrise because aquatic plants and algae consume oxygen through respiration during the night while no photosynthesis occurs in the dark to replenish it. DO is higher in the afternoon because of peak photosynthesis.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Noon', false, 0),
      (v_question_id, 'Sunrise', true, 1),
      (v_question_id, 'Mid-afternoon', false, 2),
      (v_question_id, 'Sunset', false, 3);
  END IF;

  -- 22. Biodiversity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which term describes the enormous variety of life on Earth?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which term describes the enormous variety of life on Earth?', 'single_choice', 'easy', 'Biodiversity refers to the enormous variety of life on Earth, including the variety of species, genes and ecosystems.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ecological balance', false, 0),
      (v_question_id, 'Stability', false, 1),
      (v_question_id, 'Biodiversity', true, 2),
      (v_question_id, 'Endemism', false, 3);
  END IF;

  -- 23. Seedlings with allowance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many seedlings should be purchased for a 3-hectare orchard planted at a spacing of 5 m x 4 m, if a 10% allowance is added to the number of seedlings needed? (1 ha = 10,000 m2)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many seedlings should be purchased for a 3-hectare orchard planted at a spacing of 5 m x 4 m, if a 10% allowance is added to the number of seedlings needed? (1 ha = 10,000 m2)', 'single_choice', 'medium', 'Given: area = 3 ha, spacing = 5 m x 4 m = 20 m2 per seedling, allowance = 10%. Seedlings = 1.10 x (3 x 10,000 / 20) = 1.10 x 1,500 = 1,650 seedlings.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,800', false, 0),
      (v_question_id, '1,500', false, 1),
      (v_question_id, '1,350', false, 2),
      (v_question_id, '1,650', true, 3);
  END IF;

  -- 24. Urea requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The recommended nitrogen rate for a crop is 120 kg N/ha. How many kilograms of urea (46-0-0) per hectare are needed if urea is the only fertilizer applied?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The recommended nitrogen rate for a crop is 120 kg N/ha. How many kilograms of urea (46-0-0) per hectare are needed if urea is the only fertilizer applied?', 'single_choice', 'medium', 'Given: required N = 120 kg/ha, urea grade 46-0-0 (46% N). Fertilizer rate = (rate of desired nutrient x 100) / % nutrient in the fertilizer = (120 x 100) / 46 = 260.9, or about 261 kg/ha.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '261 kg/ha', true, 0),
      (v_question_id, '120 kg/ha', false, 1),
      (v_question_id, '175 kg/ha', false, 2),
      (v_question_id, '55 kg/ha', false, 3);
  END IF;

  -- 25. Bags of 0-22-0
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 3-hectare farm needs 60 kg P2O5/ha, and the only fertilizer used is 0-22-0, sold in 50-kg bags. How many bags must be bought, rounding up to a whole bag?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 3-hectare farm needs 60 kg P2O5/ha, and the only fertilizer used is 0-22-0, sold in 50-kg bags. How many bags must be bought, rounding up to a whole bag?', 'single_choice', 'hard', 'Given: 60 kg P2O5/ha, 22% P2O5, 3 ha, 50 kg per bag. Fertilizer rate = (60 x 100) / 22 = 272.7 kg/ha. For 3 ha: 272.7 x 3 = 818.2 kg. Bags = 818.2 / 50 = 16.36, rounded up to 17 bags.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 bags', false, 0),
      (v_question_id, '18 bags', false, 1),
      (v_question_id, '16 bags', false, 2),
      (v_question_id, '17 bags', true, 3);
  END IF;

  -- 26. Nutrients in 16-20-0
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If 250 kg/ha of fertilizer grade 16-20-0 is applied, how many kilograms per hectare of N and P2O5 does it supply?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If 250 kg/ha of fertilizer grade 16-20-0 is applied, how many kilograms per hectare of N and P2O5 does it supply?', 'single_choice', 'medium', 'Given: 250 kg/ha of 16-20-0 (16% N, 20% P2O5). N = 250 x 0.16 = 40 kg/ha. P2O5 = 250 x 0.20 = 50 kg/ha.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 kg N and 40 kg P2O5', false, 0),
      (v_question_id, '400 kg N and 500 kg P2O5', false, 1),
      (v_question_id, '40 kg N and 50 kg P2O5', true, 2),
      (v_question_id, '16 kg N and 20 kg P2O5', false, 3);
  END IF;

  -- 27. Soil porosity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A soil has a bulk density of 1.25 g/cc and a particle density of 2.65 g/cc. What is its porosity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A soil has a bulk density of 1.25 g/cc and a particle density of 2.65 g/cc. What is its porosity?', 'single_choice', 'medium', 'Given: bulk density = 1.25 g/cc, particle density = 2.65 g/cc. Porosity n = 1 - (bulk density / particle density) = 1 - (1.25 / 2.65) = 1 - 0.472 = 0.528, or 52.8%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '52.8%', true, 0),
      (v_question_id, '47.2%', false, 1),
      (v_question_id, '42.5%', false, 2),
      (v_question_id, '57.5%', false, 3);
  END IF;

  -- 28. Moisture content dry basis
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A moist soil sample weighs 250 g. After oven drying it weighs 200 g. What is the soil moisture content on a dry mass basis?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A moist soil sample weighs 250 g. After oven drying it weighs 200 g. What is the soil moisture content on a dry mass basis?', 'single_choice', 'easy', 'Given: initial mass = 250 g, final (dry) mass = 200 g. Dry-basis moisture content = (initial mass - final mass) / final mass = (250 - 200) / 200 = 0.25, or 25%. On a wet basis it would be 50/250 = 20%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20%', false, 0),
      (v_question_id, '25%', true, 1),
      (v_question_id, '50%', false, 2),
      (v_question_id, '80%', false, 3);
  END IF;

  -- 29. Air volume in soil
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An undisturbed soil core has a total volume of 500 cm3. It contains 270 cm3 of solids and 120 cm3 of water. What is the volume of air in the core?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An undisturbed soil core has a total volume of 500 cm3. It contains 270 cm3 of solids and 120 cm3 of water. What is the volume of air in the core?', 'single_choice', 'easy', 'Given: V total = 500 cm3, V solid = 270 cm3, V water = 120 cm3. Since V total = V solid + V water + V air, V air = 500 - 270 - 120 = 110 cm3.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '380 cm3', false, 0),
      (v_question_id, '230 cm3', false, 1),
      (v_question_id, '150 cm3', false, 2),
      (v_question_id, '110 cm3', true, 3);
  END IF;

  -- 30. Depth of soil moisture
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A soil has a moisture content of 25% on a dry mass basis and a bulk density of 1.25 g/cc. Taking the density of water as 1.00 g/cc, what is the depth of water held in a 600-mm root zone?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A soil has a moisture content of 25% on a dry mass basis and a bulk density of 1.25 g/cc. Taking the density of water as 1.00 g/cc, what is the depth of water held in a 600-mm root zone?', 'single_choice', 'hard', 'Given: SMC dry basis = 0.25, bulk density = 1.25 g/cc, water density = 1.00 g/cc, soil depth = 600 mm. Apparent specific gravity = 1.25 / 1.00 = 1.25. Depth of moisture = SMC(db) x ASG x soil depth = 0.25 x 1.25 x 600 = 187.5 mm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120.0 mm', false, 0),
      (v_question_id, '750.0 mm', false, 1),
      (v_question_id, '187.5 mm', true, 2),
      (v_question_id, '150.0 mm', false, 3);
  END IF;

  -- 31. Available water depth
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A soil has a field capacity of 28% and a permanent wilting point of 14%, both on a dry mass basis, and a bulk density of 1.30 g/cc. Taking the density of water as 1.00 g/cc, what depth of available water is held in a 0.50-m root zone?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A soil has a field capacity of 28% and a permanent wilting point of 14%, both on a dry mass basis, and a bulk density of 1.30 g/cc. Taking the density of water as 1.00 g/cc, what depth of available water is held in a 0.50-m root zone?', 'single_choice', 'hard', 'Given: FC = 28%, PWP = 14% (dry basis), bulk density = 1.30 g/cc, root zone = 0.50 m = 500 mm. Water holding capacity = FC - PWP = 14%. Depth = 0.14 x 1.30 x 500 = 91 mm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '70 mm', false, 0),
      (v_question_id, '91 mm', true, 1),
      (v_question_id, '182 mm', false, 2),
      (v_question_id, '140 mm', false, 3);
  END IF;

  -- 32. Plant density
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Corn is planted at 0.25 m between plants within the row and 0.75 m between rows. How many plants are there in one hectare? (1 ha = 10,000 m2)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Corn is planted at 0.25 m between plants within the row and 0.75 m between rows. How many plants are there in one hectare? (1 ha = 10,000 m2)', 'single_choice', 'medium', 'Given: plant spacing = 0.25 m, row spacing = 0.75 m, area = 10,000 m2. Plant density = area / (plant spacing x row spacing) = 10,000 / (0.25 x 0.75) = 10,000 / 0.1875 = 53,333 plants/ha.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '53,333 plants', true, 0),
      (v_question_id, '13,333 plants', false, 1),
      (v_question_id, '40,000 plants', false, 2),
      (v_question_id, '26,667 plants', false, 3);
  END IF;

  -- 33. Municipal waters between two municipalities
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two municipalities are on opposite shores of a bay with only 24 km of marine waters between them. Municipal waters normally extend 15 km from the coastline, but where less than 30 km of marine waters separates municipalities on opposite shores, the outer limit is placed equally distant from the two shores. How far from its own shore do the municipal waters of each municipality extend?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two municipalities are on opposite shores of a bay with only 24 km of marine waters between them. Municipal waters normally extend 15 km from the coastline, but where less than 30 km of marine waters separates municipalities on opposite shores, the outer limit is placed equally distant from the two shores. How far from its own shore do the municipal waters of each municipality extend?', 'single_choice', 'hard', 'Given: 24 km of marine waters between the municipalities, which is less than 30 km, so the limit is equidistant from both shores. Distance = 24 / 2 = 12 km from each shore.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 km', true, 0),
      (v_question_id, '24 km', false, 1),
      (v_question_id, '9 km', false, 2),
      (v_question_id, '15 km', false, 3);
  END IF;

  -- 34. Certified emission reductions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A clean development mechanism (CDM) project avoids 3,500 metric tons of CO2 emissions every year. If one certified emission reduction (CER) is equivalent to one metric ton of CO2, how many CERs does the project earn over 10 years?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A clean development mechanism (CDM) project avoids 3,500 metric tons of CO2 emissions every year. If one certified emission reduction (CER) is equivalent to one metric ton of CO2, how many CERs does the project earn over 10 years?', 'single_choice', 'easy', 'Given: 3,500 t CO2 avoided per year, 1 CER = 1 t CO2, 10 years. CERs = 3,500 x 10 = 35,000 CERs.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3,500 CERs', false, 0),
      (v_question_id, '10,500 CERs', false, 1),
      (v_question_id, '35,000 CERs', true, 2),
      (v_question_id, '350,000 CERs', false, 3);
  END IF;

  -- 35. Carbon negative
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In one year, an enterprise emits 180 metric tons of CO2 and removes 210 metric tons of CO2 from the atmosphere through carbon capture and storage. Which term best describes its carbon status?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In one year, an enterprise emits 180 metric tons of CO2 and removes 210 metric tons of CO2 from the atmosphere through carbon capture and storage. Which term best describes its carbon status?', 'single_choice', 'medium', 'Given: emissions = 180 t CO2, removals = 210 t CO2. Net = 180 - 210 = -30 t CO2, meaning more CO2 is removed than emitted. This is carbon negative, also called climate positive. Carbon neutral or net-zero would require a net result of zero.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Climate neutral', false, 0),
      (v_question_id, 'Carbon negative (climate positive)', true, 1),
      (v_question_id, 'Net-zero carbon', false, 2),
      (v_question_id, 'Carbon neutral', false, 3);
  END IF;

END $$;
