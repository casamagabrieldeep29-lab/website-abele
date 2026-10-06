-- Aquaculture Engineering batch 3 (33 questions, 1 topic). Facts are drawn from
-- the Philippine Fisheries Code (RA 8550) text and aquaculture review material,
-- plus recalled-exam items on shrimp culture and mariculture parks.
-- Computation items state every given in the question text.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). No PAES standard specific to
-- aquaculture/fishpond facilities was found, so is_paes=false, paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Aquaculture Engineering (LAND_WATER) — 33 question(s)
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

  -- 1. Fish pond definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code (RA 8550), a land-based facility enclosed with earthen or stone material to impound water for growing fish is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code (RA 8550), a land-based facility enclosed with earthen or stone material to impound water for growing fish is called a:', 'single_choice', 'easy', 'RA 8550 defines a fish pond as a land-based facility enclosed with earthen or stone material to impound water for growing fish. A fish pen is built inside a body of water, a fish cage is a net enclosure, and a fish corral (baklad) is a trap used to capture fish.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fish pen', false, 0),
      (v_question_id, 'Fish cage', false, 1),
      (v_question_id, 'Fish pond', true, 2),
      (v_question_id, 'Fish corral', false, 3);
  END IF;

  -- 2. Fish pen definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code (RA 8550), an artificial enclosure constructed within a body of water for culturing fish, made up of poles closely arranged with wooden materials, screen or nylon netting to prevent escape of fish, is a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code (RA 8550), an artificial enclosure constructed within a body of water for culturing fish, made up of poles closely arranged with wooden materials, screen or nylon netting to prevent escape of fish, is a:', 'single_choice', 'medium', 'RA 8550 defines a fish pen as an artificial enclosure constructed within a body of water for culturing fish and fishery/aquatic resources, made up of closely arranged poles with wooden materials, screen or nylon netting to prevent escape of the fish. A fish pond, in contrast, is land-based, and a fish corral is a stationary trap for capturing fish.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fish corral', false, 0),
      (v_question_id, 'Fish pen', true, 1),
      (v_question_id, 'Payao', false, 2),
      (v_question_id, 'Fish pond', false, 3);
  END IF;

  -- 3. Fish corral (baklad)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A stationary weir or trap made of rows of bamboo stakes, plastic nets and other materials, usually with an easy entrance but a difficult exit, used to intercept and capture fish is known in the Philippine Fisheries Code as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A stationary weir or trap made of rows of bamboo stakes, plastic nets and other materials, usually with an easy entrance but a difficult exit, used to intercept and capture fish is known in the Philippine Fisheries Code as a:', 'single_choice', 'medium', 'RA 8550 defines the fish corral or baklad as a stationary weir or trap devised to intercept and capture fish, built of rows of bamboo stakes, plastic nets and similar materials, with one or more enclosures that are easy to enter but hard to leave. It is a capture device and is not a culture structure like a pen or cage.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Purse seine', false, 0),
      (v_question_id, 'Artificial reef', false, 1),
      (v_question_id, 'Fish cage', false, 2),
      (v_question_id, 'Fish corral (baklad)', true, 3);
  END IF;

  -- 4. Fish fry
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Philippine Fisheries Code, a fish that has just been hatched, usually measuring 1 to 2.5 cm, is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the Philippine Fisheries Code, a fish that has just been hatched, usually measuring 1 to 2.5 cm, is called a:', 'single_choice', 'easy', 'RA 8550 defines fish fry as the stage at which a fish has just been hatched, usually 1-2.5 cm in size. Fingerlings are the later stage measuring about 6-13 cm depending on the species.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fry', true, 0),
      (v_question_id, 'Fingerling', false, 1),
      (v_question_id, 'Sabalo', false, 2),
      (v_question_id, 'Broodstock', false, 3);
  END IF;

  -- 5. Fingerling classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hatchery sells tilapia that measure 10 cm in length. Under the size range given in the Philippine Fisheries Code, which stage are these fish in?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A hatchery sells tilapia that measure 10 cm in length. Under the size range given in the Philippine Fisheries Code, which stage are these fish in?', 'single_choice', 'easy', 'Given: length = 10 cm. RA 8550 defines fish fingerlings as the life-cycle stage measuring about 6-13 cm depending on the species, so a 10-cm fish falls within this range. Fry are only 1-2.5 cm, so they are smaller.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Broodstock', false, 0),
      (v_question_id, 'Fingerling', true, 1),
      (v_question_id, 'Fry', false, 2),
      (v_question_id, 'Sabalo', false, 3);
  END IF;

  -- 6. Fully developed fishpond dike height
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'By definition in the Philippine Fisheries Code, the dikes enclosing a fully-developed fishpond area must be strong enough to resist the pressure of the highest flood tide and must be built at least how high above the highest floodwater level in the locality?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'By definition in the Philippine Fisheries Code, the dikes enclosing a fully-developed fishpond area must be strong enough to resist the pressure of the highest flood tide and must be built at least how high above the highest floodwater level in the locality?', 'single_choice', 'medium', 'A fully-developed fishpond area is a clean, leveled area enclosed by dikes at least one foot higher than the highest floodwater level in the locality and strong enough to resist the pressure at the highest flood tide. One foot is the minimum freeboard stated in the definition.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Three feet', false, 0),
      (v_question_id, 'Five feet', false, 1),
      (v_question_id, 'One foot', true, 2),
      (v_question_id, 'Two feet', false, 3);
  END IF;

  -- 7. Fully developed fishpond components
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to the Philippine Fisheries Code, a fully-developed fishpond area is made up of at least which classes of ponds, together with a functional water control system, and produces on a commercial scale?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to the Philippine Fisheries Code, a fully-developed fishpond area is made up of at least which classes of ponds, together with a functional water control system, and produces on a commercial scale?', 'single_choice', 'medium', 'A fully-developed fishpond area consists of at least a nursery pond, a transition pond, a rearing pond, or a combination of any or all of these classes, with a functional water control system, and it produces on a commercial scale.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reservoir, settling and drainage ponds', false, 0),
      (v_question_id, 'Broodstock, hatchery and spawning ponds', false, 1),
      (v_question_id, 'Evaporation, crystallizer and storage ponds', false, 2),
      (v_question_id, 'Nursery, transition and rearing ponds', true, 3);
  END IF;

  -- 8. Catadromous species
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, a freshwater fish that migrates to marine areas to spawn is classified as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, a freshwater fish that migrates to marine areas to spawn is classified as a:', 'single_choice', 'easy', 'RA 8550 defines catadromous species as freshwater fishes that migrate to marine areas to spawn, while anadromous species are marine fishes that migrate to freshwater areas to spawn.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Catadromous species', true, 0),
      (v_question_id, 'Anadromous species', false, 1),
      (v_question_id, 'Demersal species', false, 2),
      (v_question_id, 'Stenohaline species', false, 3);
  END IF;

  -- 9. Municipal fishing vessel size
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, municipal fishing refers to fishing within municipal waters using fishing vessels of at most how many gross tons, or fishing that does not require a vessel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, municipal fishing refers to fishing within municipal waters using fishing vessels of at most how many gross tons, or fishing that does not require a vessel?', 'single_choice', 'easy', 'RA 8550 defines municipal fishing as fishing within municipal waters using fishing vessels of three (3) gross tons or less, or fishing not requiring the use of fishing vessels. Small-scale commercial fishing starts at 3.1 GT.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 GT', false, 0),
      (v_question_id, '3 GT', true, 1),
      (v_question_id, '20 GT', false, 2),
      (v_question_id, '1 GT', false, 3);
  END IF;

  -- 10. Gross tonnage and fishing scale
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fishing vessel has total closed-in spaces of 4,500 cubic feet. Using the Philippine Fisheries Code, where one gross ton equals 100 cubic feet of closed-in space, and the classes small-scale commercial (3.1 up to 20 GT), medium-scale commercial (20.1 up to 150 GT) and large commercial (more than 150 GT), the vessel is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fishing vessel has total closed-in spaces of 4,500 cubic feet. Using the Philippine Fisheries Code, where one gross ton equals 100 cubic feet of closed-in space, and the classes small-scale commercial (3.1 up to 20 GT), medium-scale commercial (20.1 up to 150 GT) and large commercial (more than 150 GT), the vessel is classified as:', 'single_choice', 'hard', 'Given: closed-in volume = 4,500 ft3; 1 GT = 100 ft3. Gross tonnage = 4,500 / 100 = 45 GT. A vessel of 20.1 to 150 GT is in the medium-scale commercial class, so 45 GT falls under medium-scale commercial fishing.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Small-scale commercial fishing', false, 0),
      (v_question_id, 'Large commercial fishing', false, 1),
      (v_question_id, 'Medium-scale commercial fishing', true, 2),
      (v_question_id, 'Municipal fishing', false, 3);
  END IF;

  -- 11. 10 percent water surface limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Philippine Fisheries Code limits the area of lakes and rivers that may be allotted to fish pens, fish cages and fish traps to not over 10 percent of the suitable water surface area. If a lake has 800 hectares of suitable water surface area, what is the maximum total area that may be allotted to these structures?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Philippine Fisheries Code limits the area of lakes and rivers that may be allotted to fish pens, fish cages and fish traps to not over 10 percent of the suitable water surface area. If a lake has 800 hectares of suitable water surface area, what is the maximum total area that may be allotted to these structures?', 'single_choice', 'medium', 'Given: suitable water surface area = 800 ha; limit = 10 percent. Maximum area = 0.10 x 800 = 80 ha. The remainder of the lake must be kept free of fish pens, cages and traps, and stocking density and feeding are also controlled by carrying capacity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80 ha', true, 0),
      (v_question_id, '400 ha', false, 1),
      (v_question_id, '160 ha', false, 2),
      (v_question_id, '8 ha', false, 3);
  END IF;

  -- 12. Fishpond lease area limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, areas leased for fishpond purposes shall be no more than how many hectares for an individual lessee?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, areas leased for fishpond purposes shall be no more than how many hectares for an individual lessee?', 'single_choice', 'medium', 'Section 46 of RA 8550 limits fishpond lease areas to not more than 50 hectares for individuals and 250 hectares for corporations or fisherfolk organizations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '150 hectares', false, 0),
      (v_question_id, '100 hectares', false, 1),
      (v_question_id, '250 hectares', false, 2),
      (v_question_id, '50 hectares', true, 3);
  END IF;

  -- 13. Fishpond lease term
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, a Fishpond Lease Agreement runs for 25 years and is renewable for another 25 years. What is the longest total period a lessee can hold the lease if it is renewed once?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, a Fishpond Lease Agreement runs for 25 years and is renewable for another 25 years. What is the longest total period a lessee can hold the lease if it is renewed once?', 'single_choice', 'easy', 'Given: lease period = 25 years; one renewal = another 25 years. Total = 25 + 25 = 50 years.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 years', false, 0),
      (v_question_id, '40 years', false, 1),
      (v_question_id, '30 years', false, 2),
      (v_question_id, '50 years', true, 3);
  END IF;

  -- 14. Reversion of undeveloped leased area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, a leased fishpond area must be developed and producing on a commercial scale within three years from approval of the lease contract. Areas that are not fully producing within how many years from approval automatically revert to the public domain for reforestation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, a leased fishpond area must be developed and producing on a commercial scale within three years from approval of the lease contract. Areas that are not fully producing within how many years from approval automatically revert to the public domain for reforestation?', 'single_choice', 'medium', 'RA 8550 Section 46 requires the leased area to be developed and producing on a commercial scale within three years, and provides that areas not fully producing within five years from approval of the lease contract automatically revert to the public domain for reforestation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 years', true, 0),
      (v_question_id, '3 years', false, 1),
      (v_question_id, '4 years', false, 2),
      (v_question_id, '10 years', false, 3);
  END IF;

  -- 15. Grounds for cancelling a fishpond lease
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is stated in the Philippine Fisheries Code as a ground for cancellation of a Fishpond Lease Agreement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is stated in the Philippine Fisheries Code as a ground for cancellation of a Fishpond Lease Agreement?', 'single_choice', 'medium', 'The Code provides that a fishpond shall not be subleased in whole or in part (failure to comply means cancellation of the FLA), and that the lessee must provide facilities that minimize environmental pollution, such as settling ponds and reservoirs (failure to comply also means cancellation).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Harvesting more than once a year', false, 0),
      (v_question_id, 'Stocking only native fish species', false, 1),
      (v_question_id, 'Subleasing the fishpond in whole or in part', true, 2),
      (v_question_id, 'Using a gravity-fed drainage gate', false, 3);
  END IF;

  -- 16. Minimum pond water supply computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fish farm of 4 hectares of ponds is supplied from a river. Using the minimum water supply requirement of 5 liters per second per hectare of pond, what is the minimum water supply needed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fish farm of 4 hectares of ponds is supplied from a river. Using the minimum water supply requirement of 5 liters per second per hectare of pond, what is the minimum water supply needed?', 'single_choice', 'medium', 'Given: area = 4 ha; requirement = 5 L/s per ha. Flow = 5 x 4 = 20 L/s. Per day: 20 L/s x 86,400 s/day = 1,728,000 L = 1,728 m3/day.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40 L/s, or 3,456 m3/day', false, 0),
      (v_question_id, '20 L/s, or 1,728 m3/day', true, 1),
      (v_question_id, '5 L/s, or 432 m3/day', false, 2),
      (v_question_id, '20 L/s, or 72 m3/day', false, 3);
  END IF;

  -- 17. Privileges for pens and cages in municipal areas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, no new concessions, licenses, permits or leases for fish pens, fish cages, fish corrals/traps and similar structures in municipal areas shall be granted except to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, no new concessions, licenses, permits or leases for fish pens, fish cages, fish corrals/traps and similar structures in municipal areas shall be granted except to:', 'single_choice', 'medium', 'Section 53 of RA 8550 restricts new privileges for fish pens, cages, corrals/traps and similar structures in municipal areas to municipal fisherfolk and their organizations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Foreign investors with approved projects', false, 0),
      (v_question_id, 'Municipal fisherfolk and their organizations', true, 1),
      (v_question_id, 'Commercial fishing corporations', false, 2),
      (v_question_id, 'Any Filipino citizen who applies first', false, 3);
  END IF;

  -- 18. Insurance of fishponds
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, inland fishponds, fish cages and fish pens are covered by the insurance program of which agency against force majeure and fortuitous events?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, inland fishponds, fish cages and fish pens are covered by the insurance program of which agency against force majeure and fortuitous events?', 'single_choice', 'easy', 'Section 54 of RA 8550 places inland fishponds, fish cages and fish pens under the insurance program of the Philippine Crop Insurance Corporation for losses caused by force majeure and fortuitous events.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Philippine Coconut Authority', false, 0),
      (v_question_id, 'Land Bank of the Philippines', false, 1),
      (v_question_id, 'Social Security System', false, 2),
      (v_question_id, 'Philippine Crop Insurance Corporation', true, 3);
  END IF;

  -- 19. Registration of hatcheries and fishponds
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, all fish hatcheries, fish breeding facilities and private fishponds must be registered with the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, all fish hatcheries, fish breeding facilities and private fishponds must be registered with the:', 'single_choice', 'easy', 'Section 57 of RA 8550 requires all fish hatcheries, fish breeding facilities and private fishponds to be registered with the LGUs, which prescribe minimum standards for these facilities in consultation with the Department of Agriculture.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Local government units', true, 0),
      (v_question_id, 'National Water Resources Board', false, 1),
      (v_question_id, 'Department of Environment and Natural Resources', false, 2),
      (v_question_id, 'Philippine Coast Guard', false, 3);
  END IF;

  -- 20. Mangrove conversion offender duty
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, it is unlawful to convert mangroves into fishponds. If the converted area requires rehabilitation or restoration as determined by the court, the offender must also be required to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, it is unlawful to convert mangroves into fishponds. If the converted area requires rehabilitation or restoration as determined by the court, the offender must also be required to:', 'single_choice', 'medium', 'Section 94 of RA 8550 makes the conversion of mangroves into fishponds or for any other purpose unlawful, punishable by imprisonment of six years and one day to twelve years and/or a fine of P80,000. If the area requires rehabilitation or restoration as determined by the court, the offender must restore or compensate for the restoration of the damage.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Surrender the fishing equipment only', false, 0),
      (v_question_id, 'Transfer the area to the offender''s heirs', false, 1),
      (v_question_id, 'Restore or compensate for the restoration of the damage', true, 2),
      (v_question_id, 'Apply for a new fishpond lease over the same area', false, 3);
  END IF;

  -- 21. Aquatic pollution fine computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, aquatic pollution is punishable by a fine of P80,000 plus an additional fine of P8,000 per day until the violation ceases and the fines are paid. If a fishpond operator''s violation continues for 15 days until it ceases, what is the total fine (excluding imprisonment)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, aquatic pollution is punishable by a fine of P80,000 plus an additional fine of P8,000 per day until the violation ceases and the fines are paid. If a fishpond operator''s violation continues for 15 days until it ceases, what is the total fine (excluding imprisonment)?', 'single_choice', 'hard', 'Given: base fine = P80,000; additional fine = P8,000 per day; duration = 15 days. Additional = 8,000 x 15 = P120,000. Total = 80,000 + 120,000 = P200,000.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P1,200,000', false, 0),
      (v_question_id, 'P88,000', false, 1),
      (v_question_id, 'P200,000', true, 2),
      (v_question_id, 'P120,000', false, 3);
  END IF;

  -- 22. Intensive feeding as pollution
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following aquaculture practices is expressly listed in the Philippine Fisheries Code definition of aquatic pollution?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following aquaculture practices is expressly listed in the Philippine Fisheries Code definition of aquatic pollution?', 'single_choice', 'medium', 'RA 8550 defines aquatic pollution to include deforestation, unsound agricultural practices such as the use of banned chemicals and excessive use of chemicals, intensive use of artificial fish feed, and wetland conversion, because these cause similar harmful effects on the aquatic environment.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Stocking hatchery-reared fingerlings', false, 0),
      (v_question_id, 'Intensive use of artificial fish feed', true, 1),
      (v_question_id, 'Planting mangroves along the pond dike', false, 2),
      (v_question_id, 'Building settling ponds before discharge', false, 3);
  END IF;

  -- 23. Sabalo
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the Philippine Fisheries Code, catching, gathering or possessing "sabalo" is unlawful except for local breeding or scientific purposes. What is a "sabalo"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the Philippine Fisheries Code, catching, gathering or possessing "sabalo" is unlawful except for local breeding or scientific purposes. What is a "sabalo"?', 'single_choice', 'easy', 'Section 98 of RA 8550 makes it unlawful to catch, gather, capture or possess mature milkfish, or "sabalo", and such other breeders or spawners as the Department may determine. Catching for local breeding or for scientific or research purposes may be allowed under guidelines.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A mature milkfish', true, 0),
      (v_question_id, 'A newly hatched milkfish fry', false, 1),
      (v_question_id, 'A mature tilapia', false, 2),
      (v_question_id, 'A tilapia fingerling', false, 3);
  END IF;

  -- 24. Environmental Compliance Certificate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine Fisheries Code, no person may undertake a development project that affects the quality of the environment without first securing an Environmental Compliance Certificate (ECC) from the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine Fisheries Code, no person may undertake a development project that affects the quality of the environment without first securing an Environmental Compliance Certificate (ECC) from the:', 'single_choice', 'easy', 'Sections 12 and 13 of RA 8550 require an Environmental Impact Statement to be prepared before such projects, submitted to the DENR for review, and require an ECC from the Secretary of the Department of Environment and Natural Resources before any development project is undertaken.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Secretary of Agriculture', false, 0),
      (v_question_id, 'Mayor of the municipality', false, 1),
      (v_question_id, 'Director of BFAR', false, 2),
      (v_question_id, 'Secretary of the DENR', true, 3);
  END IF;

  -- 25. Sea ranching
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The release of the young of fishery species reared in hatcheries and nurseries into natural bodies of water for subsequent harvest at maturity is termed:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The release of the young of fishery species reared in hatcheries and nurseries into natural bodies of water for subsequent harvest at maturity is termed:', 'single_choice', 'medium', 'RA 8550 defines sea ranching as the release of young of fishery species reared in hatcheries and nurseries into natural bodies of water for subsequent harvest at maturity, or the manipulation of fishery habitat to encourage the growth of wild stocks. Sea farming, by contrast, is the stocking of marine plants or animals under controlled conditions for rearing and harvesting.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sea ranching', true, 0),
      (v_question_id, 'Fish refuge', false, 1),
      (v_question_id, 'Artificial reef', false, 2),
      (v_question_id, 'Sea farming', false, 3);
  END IF;

  -- 26. Municipal waters between opposite shores
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Municipal waters extend 15 km seaward from the coastline. However, under the Philippine Fisheries Code, where two municipalities are on opposite shores with less than 30 km of marine waters between them, the outer boundary line is equally distant from the opposite shores. If 24 km of marine water lies between two such municipalities, how far from each shore is the outer boundary of each municipality''s waters?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Municipal waters extend 15 km seaward from the coastline. However, under the Philippine Fisheries Code, where two municipalities are on opposite shores with less than 30 km of marine waters between them, the outer boundary line is equally distant from the opposite shores. If 24 km of marine water lies between two such municipalities, how far from each shore is the outer boundary of each municipality''s waters?', 'single_choice', 'medium', 'Given: distance between shores = 24 km (less than 30 km); the line is equidistant from the two shores. Distance from each shore = 24 / 2 = 12 km, which is less than the usual 15 km.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 km', false, 0),
      (v_question_id, '6 km', false, 1),
      (v_question_id, '15 km', false, 2),
      (v_question_id, '12 km', true, 3);
  END IF;

  -- 27. Mariculture parks
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Breeding and growout production of commercially important marine species in zonified marine cages is referred to by the Bureau of Fisheries and Aquatic Resources as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Breeding and growout production of commercially important marine species in zonified marine cages is referred to by the Bureau of Fisheries and Aquatic Resources as:', 'single_choice', 'medium', 'The Bureau of Fisheries and Aquatic Resources (BFAR) refers to zonified marine cage areas used for the breeding and growout of commercially important marine species as mariculture parks.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Seawater cage farms', false, 0),
      (v_question_id, 'Mariculture parks', true, 1),
      (v_question_id, 'Ocean cage parks', false, 2),
      (v_question_id, 'Industrial cage parks', false, 3);
  END IF;

  -- 28. Eye ablation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Eye ablation is a technique used to induce females to spawn in which cultured species?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Eye ablation is a technique used to induce females to spawn in which cultured species?', 'single_choice', 'easy', 'Eye ablation, the removal or crushing of an eyestalk, is used to induce spawning in female shrimp (penaeid broodstock). It is not used for milkfish, oysters or mussels.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Milkfish', false, 0),
      (v_question_id, 'Oysters', false, 1),
      (v_question_id, 'Shrimp', true, 2),
      (v_question_id, 'Mussels', false, 3);
  END IF;

  -- 29. Penaeid larval stages
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Penaeid shrimps pass through which larval stages, in sequence, before they become post larvae?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Penaeid shrimps pass through which larval stages, in sequence, before they become post larvae?', 'single_choice', 'medium', 'Penaeid shrimps develop through nauplius, then zoea, then mysis before reaching the post larval stage. The other sequences listed use stages that belong to other crustaceans or place the stages in the wrong order.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Zoea, megalopa, instar', false, 0),
      (v_question_id, 'Nauplius, megalopa, instar', false, 1),
      (v_question_id, 'Nauplius, mysis, zoea', false, 2),
      (v_question_id, 'Nauplius, zoea, mysis', true, 3);
  END IF;

  -- 30. Dominant brackishwater species
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which pair of species is the most dominant in brackishwater culture in the Philippines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which pair of species is the most dominant in brackishwater culture in the Philippines?', 'single_choice', 'easy', 'Milkfish and shrimp are the most dominant species cultured in brackishwater ponds in the Philippines. Oysters and mussels are grown in marine shallow areas, and tilapia is mainly a freshwater species.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mudcrab and grouper', false, 0),
      (v_question_id, 'Milkfish and shrimp', true, 1),
      (v_question_id, 'Tilapia and carp', false, 2),
      (v_question_id, 'Oysters and mussels', false, 3);
  END IF;

  -- 31. Top aquaculture species by volume
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In 2024, which was the number one aquaculture species in the Philippines in terms of volume of production?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In 2024, which was the number one aquaculture species in the Philippines in terms of volume of production?', 'single_choice', 'easy', 'In 2024 the Philippines produced a total of 1,020,823 metric tons of fisheries products, with seaweed as the number one aquaculture species in terms of volume of production.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tilapia', false, 0),
      (v_question_id, 'Tiger prawn', false, 1),
      (v_question_id, 'Seaweed', true, 2),
      (v_question_id, 'Milkfish', false, 3);
  END IF;

  -- 32. Pond filling time computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 1-hectare pond is to be filled to a depth of 0.8 m using a continuous supply of 5 liters per second. How long will it take to fill the pond? (1 ha = 10,000 m2; 1 m3 = 1,000 L)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 1-hectare pond is to be filled to a depth of 0.8 m using a continuous supply of 5 liters per second. How long will it take to fill the pond? (1 ha = 10,000 m2; 1 m3 = 1,000 L)', 'single_choice', 'hard', 'Given: area = 10,000 m2; depth = 0.8 m; flow = 5 L/s. Volume = 10,000 x 0.8 = 8,000 m3 = 8,000,000 L. Time = 8,000,000 / 5 = 1,600,000 s. Days = 1,600,000 / 86,400 = 18.5 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18.5 days', true, 0),
      (v_question_id, '23.1 days', false, 1),
      (v_question_id, '1.85 days', false, 2),
      (v_question_id, '9.3 days', false, 3);
  END IF;

  -- 33. Semi-intensive stocking computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 1,500 m2 pond is managed under the semi-intensive method, which uses a stocking density of 4 to 6 fish per square meter. What range of total fish stocked is appropriate for this pond?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 1,500 m2 pond is managed under the semi-intensive method, which uses a stocking density of 4 to 6 fish per square meter. What range of total fish stocked is appropriate for this pond?', 'single_choice', 'medium', 'Given: area = 1,500 m2; density = 4 to 6 fish/m2. Lower limit = 4 x 1,500 = 6,000 fish. Upper limit = 6 x 1,500 = 9,000 fish. Range = 6,000 to 9,000 fish.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4,000 to 6,000 fish', false, 0),
      (v_question_id, '1,500 to 4,500 fish', false, 1),
      (v_question_id, '6,000 to 9,000 fish', true, 2),
      (v_question_id, '9,000 fish or more', false, 3);
  END IF;

END $$;
