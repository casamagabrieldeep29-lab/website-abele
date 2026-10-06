-- Agricultural Building and Structures, plant-related batch 3
-- quiz batch (40 questions, 1 topic). Plant-related structures only:
-- greenhouses and plant growth structures, plant tissue culture laboratory,
-- fruit and vegetable storage, grain warehouse, steel silo, primary processing
-- plant, structural-load and beam computations, and farm-building materials
-- (concrete, lumber, plywood, reinforcing bars). Every fact, number and formula
-- is drawn from the PAES 415, 416, 417, 418 and 419 standards, the silo
-- standard , the wood-based panel standard (PAES 320) and
-- the solved structures problem sets in the reference library, all read in
-- full - no invented facts. Livestock and poultry housing is deliberately
-- excluded. Angles differ from the questions already in this topic.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). Questions about a specific standard
-- carry is_paes=true with the standard number in paes_reference; general
-- structural-mechanics and materials questions have is_paes=false.
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

  -- 1. Greenhouse ridge orientation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 415:2001, how should the ridge of a greenhouse be oriented, and for what reason?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 415:2001, how should the ridge of a greenhouse be oriented, and for what reason?', 'single_choice', 'easy', 'PAES 415:2001 clause 4.2 states that the greenhouse should be placed with the ridge in a north to south orientation to reduce interior shading from the structure itself on the plants. Greenhouses that are connected together should also be built north to south to give even light coverage throughout the day.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'North to south, to reduce shading of the plants by the structure itself', true, 0),
      (v_question_id, 'East to west, so the long roof surface faces the midday sun', false, 1),
      (v_question_id, 'Facing the prevailing wind, to maximize natural ventilation', false, 2),
      (v_question_id, 'Northeast to southwest, to avoid afternoon heat gain', false, 3);
  END IF;

  -- 2. Rolling bench usable area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A greenhouse has a floor measuring 12 m x 25 m. Under PAES 415:2001, the usable bench space is 66% to 75% of the floor area for fixed benches and 90% of the floor area for rolling benches. How much usable bench area is available if rolling benches are installed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A greenhouse has a floor measuring 12 m x 25 m. Under PAES 415:2001, the usable bench space is 66% to 75% of the floor area for fixed benches and 90% of the floor area for rolling benches. How much usable bench area is available if rolling benches are installed?', 'single_choice', 'medium', 'Given: floor 12 m x 25 m; rolling benches use 90% of the floor area. Floor area = 12 x 25 = 300 m². Usable bench area = 0.90 x 300 = 270 m². (Fixed benches would give only 198 m² to 225 m², i.e. 66% to 75%.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '300 m²', false, 0),
      (v_question_id, '270 m²', true, 1),
      (v_question_id, '198 m²', false, 2),
      (v_question_id, '225 m²', false, 3);
  END IF;

  -- 3. Greenhouse ridge height
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A gable greenhouse is 12 m wide and has an eave height of 2.4 m. Under PAES 415:2001, the height of the structure at the center equals the eave height plus one-fourth of the width. What is the height at the center of the structure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A gable greenhouse is 12 m wide and has an eave height of 2.4 m. Under PAES 415:2001, the height of the structure at the center equals the eave height plus one-fourth of the width. What is the height at the center of the structure?', 'single_choice', 'medium', 'Given: width = 12 m; eave height = 2.4 m. Height at center = eave height + (1/4) x width = 2.4 + (1/4)(12) = 2.4 + 3.0 = 5.4 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.4 m', true, 0),
      (v_question_id, '6.4 m', false, 1),
      (v_question_id, '8.4 m', false, 2),
      (v_question_id, '3.9 m', false, 3);
  END IF;

  -- 4. Glass greenhouse roof pitch
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 415:2001, what roof pitch is recommended for a glass-covered greenhouse so that condensation inside does not drip onto the plants?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 415:2001, what roof pitch is recommended for a glass-covered greenhouse so that condensation inside does not drip onto the plants?', 'single_choice', 'medium', 'PAES 415:2001 clause 7.3.5 gives a roof pitch of 51% for a glass greenhouse to prevent inside condensation from dripping on plants. Plastic-covered greenhouses require a steeper pitch of 58% to 70% for the same reason.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '58% to 70%', false, 0),
      (v_question_id, '51%', true, 1),
      (v_question_id, 'About 30%', false, 2),
      (v_question_id, 'About 20%', false, 3);
  END IF;

  -- 5. Polyethylene roofing thickness
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 415:2001, polyethylene sheet used as greenhouse roofing shall have a minimum thickness of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 415:2001, polyethylene sheet used as greenhouse roofing shall have a minimum thickness of:', 'single_choice', 'easy', 'PAES 415:2001 clause 7.3.4.2.1 states that polyethylene sheet roofing provides good protection from rain, has low investment cost and needs fewer structural components, and shall have a minimum thickness of 130 micrometers.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '250 micrometers', false, 0),
      (v_question_id, '50 micrometers', false, 1),
      (v_question_id, '80 micrometers', false, 2),
      (v_question_id, '130 micrometers', true, 3);
  END IF;

  -- 6. Greenhouse gutter drop
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 415:2001 requires a 2% slope on the gutters of a gutter-connected (ridge and furrow) greenhouse for drainage. If a gutter is 36 m long, what is the total drop from its high end to its low end?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 415:2001 requires a 2% slope on the gutters of a gutter-connected (ridge and furrow) greenhouse for drainage. If a gutter is 36 m long, what is the total drop from its high end to its low end?', 'single_choice', 'medium', 'Given: gutter length = 36 m; slope = 2% = 0.02. Drop = 0.02 x 36 m = 0.72 m between the high and low ends.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.36 m', false, 0),
      (v_question_id, '1.80 m', false, 1),
      (v_question_id, '0.72 m', true, 2),
      (v_question_id, '0.072 m', false, 3);
  END IF;

  -- 7. Leaching irrigation volume
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rule of thumb in PAES 415:2001 for irrigating container-grown greenhouse crops is to apply 10% to 15% more water than the container will hold, to leach soluble salts at each irrigation. A pot holds 2.0 L of water. What volume range should be applied per irrigation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rule of thumb in PAES 415:2001 for irrigating container-grown greenhouse crops is to apply 10% to 15% more water than the container will hold, to leach soluble salts at each irrigation. A pot holds 2.0 L of water. What volume range should be applied per irrigation?', 'single_choice', 'medium', 'Given: container holds 2.0 L; apply 10% to 15% more. Lower value = 2.0 x 1.10 = 2.2 L; upper value = 2.0 x 1.15 = 2.3 L. The volume to apply is 2.2 L to 2.3 L, which leaches salts and reduces their accumulation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.7 L to 1.8 L', false, 0),
      (v_question_id, '2.2 L to 2.3 L', true, 1),
      (v_question_id, '2.0 L to 2.1 L', false, 2),
      (v_question_id, '2.6 L to 3.0 L', false, 3);
  END IF;

  -- 8. Tomato bench population
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Table 3 of PAES 415:2001 gives a population density of 4 to 6 tomato plants per square meter of bench when tomato is planted 40 cm between hills in 2-row beds. How many plants can a 15 m² bench area accommodate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Table 3 of PAES 415:2001 gives a population density of 4 to 6 tomato plants per square meter of bench when tomato is planted 40 cm between hills in 2-row beds. How many plants can a 15 m² bench area accommodate?', 'single_choice', 'medium', 'Given: density = 4 to 6 plants/m²; bench area = 15 m². Minimum = 4 x 15 = 60 plants; maximum = 6 x 15 = 90 plants. The bench holds 60 to 90 plants.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60 to 90 plants', true, 0),
      (v_question_id, '45 to 75 plants', false, 1),
      (v_question_id, '90 to 120 plants', false, 2),
      (v_question_id, '360 to 420 plants', false, 3);
  END IF;

  -- 9. Intake louver area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A mechanically ventilated greenhouse has four exhaust fans, each with an opening area of 1.2 m². Under PAES 415:2001, the air intake louver area should be at least 1.25 times the area of the fans. What is the minimum intake louver area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A mechanically ventilated greenhouse has four exhaust fans, each with an opening area of 1.2 m². Under PAES 415:2001, the air intake louver area should be at least 1.25 times the area of the fans. What is the minimum intake louver area?', 'single_choice', 'hard', 'Given: 4 fans x 1.2 m² = 4.8 m² total fan area; louver area >= 1.25 x fan area. Minimum louver area = 1.25 x 4.8 = 6.0 m².', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.8 m²', false, 0),
      (v_question_id, '1.5 m²', false, 1),
      (v_question_id, '6.0 m²', true, 2),
      (v_question_id, '7.5 m²', false, 3);
  END IF;

  -- 10. Trellis load on greenhouse frame
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 415:2001, greenhouse framing shall be able to carry trellising loads up to 25 kg/m². What total trellising load must the framing of an 8 m x 24 m greenhouse be able to carry?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 415:2001, greenhouse framing shall be able to carry trellising loads up to 25 kg/m². What total trellising load must the framing of an 8 m x 24 m greenhouse be able to carry?', 'single_choice', 'hard', 'Given: floor 8 m x 24 m; design load = 25 kg/m². Area = 8 x 24 = 192 m². Total load = 192 x 25 = 4,800 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,920 kg', false, 0),
      (v_question_id, '9,600 kg', false, 1),
      (v_question_id, '600 kg', false, 2),
      (v_question_id, '4,800 kg', true, 3);
  END IF;

  -- 11. Wooden greenhouse truss width
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a greenhouse framed with wood, PAES 415:2001 requires a reinforced truss construction once the structure is wider than:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a greenhouse framed with wood, PAES 415:2001 requires a reinforced truss construction once the structure is wider than:', 'single_choice', 'medium', 'PAES 415:2001 clause 7.3.2.2.2 states that rafters of wooden frames are placed 0.6 m to 1.2 m center to center depending on strength requirements, and that greenhouses over 15.25 m wide shall require a reinforced truss construction.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20.00 m', false, 0),
      (v_question_id, '9.00 m', false, 1),
      (v_question_id, '15.25 m', true, 2),
      (v_question_id, '12.00 m', false, 3);
  END IF;

  -- 12. Pad and fan cooling distance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a pad-and-fan evaporative cooling system, PAES 415:2001 recommends a pad-to-fan distance of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a pad-and-fan evaporative cooling system, PAES 415:2001 recommends a pad-to-fan distance of:', 'single_choice', 'medium', 'PAES 415:2001 clause 8.3.1.1 recommends a pad-to-fan distance of 30 m to 50 m. For very long houses, fans installed in the roof at the midpoint with pads at both ends help reduce air velocities across the plants. The vertical pad height should not exceed 2.5 m nor be less than 0.5 m for uniform water flow.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 m to 50 m', true, 0),
      (v_question_id, '15 m to 20 m', false, 1),
      (v_question_id, '70 m to 100 m', false, 2),
      (v_question_id, '5 m to 10 m', false, 3);
  END IF;

  -- 13. Concrete aisles in growing areas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Why does PAES 415:2001 advise against using regular concrete for the aisles between growing areas of a greenhouse?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Why does PAES 415:2001 advise against using regular concrete for the aisles between growing areas of a greenhouse?', 'single_choice', 'medium', 'PAES 415:2001 clause 7.5.4 states that regular concrete should be avoided for aisles in growing areas because it will not drain properly. A concrete, gravel or stone walkway 0.60 m to 0.9 m wide is built for access, and the rest of the floor is covered with several inches of gravel to drain excess water.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It cannot carry the weight of the benches', false, 0),
      (v_question_id, 'It cannot be laid level for flood irrigation', false, 1),
      (v_question_id, 'It reflects too much light onto the plants', false, 2),
      (v_question_id, 'It does not drain properly, so gravel is preferred for the growing aisles', true, 3);
  END IF;

  -- 14. Chinese and Japanese bag piling
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In large-scale bagged storage under PAES 419:2000, grain with a moisture content of more than 14% is piled using which method, and what does it provide?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In large-scale bagged storage under PAES 419:2000, grain with a moisture content of more than 14% is piled using which method, and what does it provide?', 'single_choice', 'medium', 'PAES 419:2000 clause 4.2.2.2.1.2: the Japanese method is used for bagged grain with moisture content of more than 14%. It leaves air space between bags, allowing convective air currents to circulate and dissipate heat. The Chinese method, with sacks piled side by side and one on top of the other over malathion-sprayed pallets, is for grain at 14% moisture content or lower.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Block stacking, which places bags directly against the walls', false, 0),
      (v_question_id, 'The Japanese method, which leaves air spaces between bags for convective air circulation and heat dissipation', true, 1),
      (v_question_id, 'The Chinese method, which packs bags side by side to save space', false, 2),
      (v_question_id, 'Criss-cross stacking, which seals the pile for fumigation', false, 3);
  END IF;

  -- 15. Number of warehouse doors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 419:2000 requires a bagged-grain warehouse to have at least two doors. What is the purpose of this requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 419:2000 requires a bagged-grain warehouse to have at least two doors. What is the purpose of this requirement?', 'single_choice', 'easy', 'PAES 419:2000 clause 5.5.1 requires at least two doors so that stocks can be rotated on a first in, first out basis. Roll-up doors are generally used because they close tightly, and swing doors, if fitted, shall open outwards so that storage capacity is not reduced.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To allow two forklift lanes to operate at once', false, 0),
      (v_question_id, 'To satisfy the fire exit requirement', false, 1),
      (v_question_id, 'To provide cross ventilation of the stacks', false, 2),
      (v_question_id, 'To rotate stocks on a first in, first out basis', true, 3);
  END IF;

  -- 16. Warehouse for 300,000 cavans
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 419:2000 recommends a 25 m x 78 m building for a capacity of 100,000 cavans, and larger capacities are met by building several units of the recommended size. A warehouse complex for 300,000 cavans will use only 100,000-cavan buildings. What is the total floor footprint of the buildings, ignoring the spaces between them?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 419:2000 recommends a 25 m x 78 m building for a capacity of 100,000 cavans, and larger capacities are met by building several units of the recommended size. A warehouse complex for 300,000 cavans will use only 100,000-cavan buildings. What is the total floor footprint of the buildings, ignoring the spaces between them?', 'single_choice', 'hard', 'Given: one 100,000-cavan building = 25 m x 78 m = 1,950 m². Number of buildings = 300,000 / 100,000 = 3. Total footprint = 3 x 1,950 = 5,850 m².', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,850 m²', true, 0),
      (v_question_id, '7,800 m²', false, 1),
      (v_question_id, '1,950 m²', false, 2),
      (v_question_id, '3,900 m²', false, 3);
  END IF;

  -- 17. Wet-basis moisture content of paddy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 419:2000 defines moisture content on a wet basis as (M0 - M1)/M0 x 100, where M0 is the initial mass of the test portion and M1 is the mass of the dry test portion. A 250 g paddy sample weighs 215 g after oven drying. What is its moisture content, wet basis?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 419:2000 defines moisture content on a wet basis as (M0 - M1)/M0 x 100, where M0 is the initial mass of the test portion and M1 is the mass of the dry test portion. A 250 g paddy sample weighs 215 g after oven drying. What is its moisture content, wet basis?', 'single_choice', 'medium', 'Given: M0 = 250 g; M1 = 215 g. MC (w.b.) = (250 - 215)/250 x 100 = 35/250 x 100 = 14.0%. (The dry-basis value would be 35/215 = 16.3%, which is not what the standard defines.) At 14% or lower, the bags may be piled by the Chinese method.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35.0%', false, 0),
      (v_question_id, '12.0%', false, 1),
      (v_question_id, '14.0%', true, 2),
      (v_question_id, '16.3%', false, 3);
  END IF;

  -- 18. Roof truss span without pillars
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'To avoid internal pillars that interfere with pest control and stock management, PAES 419:2000 says a standard roof truss of what span (or larger) should be used for a bagged-grain warehouse?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'To avoid internal pillars that interfere with pest control and stock management, PAES 419:2000 says a standard roof truss of what span (or larger) should be used for a bagged-grain warehouse?', 'single_choice', 'medium', 'PAES 419:2000 clause 5.4.1 states that internal pillars supporting roof frames shall be avoided because they can interfere with pest control and other stock management procedures, and that a standard roof truss of 14.5 m span (or larger) should be used. Clause 4.5.6 likewise calls for a clear inside span with no pillars obstructing the stacking arrangement.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.0 m', false, 0),
      (v_question_id, '14.5 m', true, 1),
      (v_question_id, '30.0 m', false, 2),
      (v_question_id, '8.0 m', false, 3);
  END IF;

  -- 19. Warehouse louver screening
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 419:2000, how should ventilation louvers of a bagged-grain warehouse be screened against birds and insects?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 419:2000, how should ventilation louvers of a bagged-grain warehouse be screened against birds and insects?', 'single_choice', 'medium', 'PAES 419:2000 clause 5.6.2: ventilation openings such as louvers shall be fitted on the outside with anti-bird grills (20 mm mesh) and on the inside, 10 cm behind the grills, with insect screens that are removable for cleaning, which deter most insects.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 mm mesh anti-bird grills outside and removable insect screens about 10 cm behind them inside', true, 0),
      (v_question_id, '5 mm wire mesh outside and fixed glass panels inside', false, 1),
      (v_question_id, '50 mm chicken wire outside and no inner screen', false, 2),
      (v_question_id, 'Insect screens outside and 20 mm grills inside', false, 3);
  END IF;

  -- 20. F&V storage ceiling height
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 417:2002, what is the minimum height of the ceiling of a fruit and vegetable storage above the finished floor line for manual handling and for mechanical handling, respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 417:2002, what is the minimum height of the ceiling of a fruit and vegetable storage above the finished floor line for manual handling and for mechanical handling, respectively?', 'single_choice', 'easy', 'PAES 417:2002 clause 7.2.1 states that ceilings shall be at least 2.4 m from the finished floor line for manual handling and 6 m for mechanical handling.', NULL, NULL, 'draft', false, NULL, true, 'PAES 417:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.0 m and 4.0 m', false, 0),
      (v_question_id, '2.4 m for both', false, 1),
      (v_question_id, '3.0 m and 4.5 m', false, 2),
      (v_question_id, '2.4 m and 6.0 m', true, 3);
  END IF;

  -- 21. Refrigerated room insulation R-values
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which set gives the recommended minimum R-values (m²·K/W) for the ceiling, wall and floor of a refrigerated fruit and vegetable storage room under PAES 417:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which set gives the recommended minimum R-values (m²·K/W) for the ceiling, wall and floor of a refrigerated fruit and vegetable storage room under PAES 417:2002?', 'single_choice', 'hard', 'PAES 417:2002 Table 3 gives the recommended minimum R-values for a refrigerated room: ceiling 5 (R-30), wall 3.5 (R-20) and floor 1.76 (R-10). The ceiling gains the most heat from the roof and therefore needs the highest resistance. The ceiling, wall and floor shall also be provided with vapor barriers.', NULL, NULL, 'draft', false, NULL, true, 'PAES 417:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ceiling 1.76, wall 3.5, floor 5.0', false, 0),
      (v_question_id, 'Ceiling 3.5, wall 5.0, floor 1.76', false, 1),
      (v_question_id, 'Ceiling 5.0, wall 1.76, floor 3.5', false, 2),
      (v_question_id, 'Ceiling 5.0, wall 3.5, floor 1.76', true, 3);
  END IF;

  -- 22. Forced ventilation of stored cabbage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 417:2002 recommends a forced-ventilation rate of 20 to 30 (L/s) per ton for stored cabbage. What ventilation range should be provided for a store holding 8 tons of cabbage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 417:2002 recommends a forced-ventilation rate of 20 to 30 (L/s) per ton for stored cabbage. What ventilation range should be provided for a store holding 8 tons of cabbage?', 'single_choice', 'medium', 'Given: 20 to 30 L/s per ton; 8 tons of cabbage. Minimum = 20 x 8 = 160 L/s; maximum = 30 x 8 = 240 L/s. The store needs 160 to 240 L/s.', NULL, NULL, 'draft', false, NULL, true, 'PAES 417:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.5 to 3.75 L/s', false, 0),
      (v_question_id, '48 to 80 L/s', false, 1),
      (v_question_id, '160 to 240 L/s', true, 2),
      (v_question_id, '80 to 96 L/s', false, 3);
  END IF;

  -- 23. Ceiling R-value of cold room
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The ceiling of a refrigerated fruit and vegetable storage room is built from these layers with thermal resistances in m²·K/W: outside air film 0.049, 140 mm fiberglass 3.21, 50 mm rigid insulation 1.85, 13 mm plywood 0.11, and inside air film 0.03. What is the total R-value of the ceiling?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The ceiling of a refrigerated fruit and vegetable storage room is built from these layers with thermal resistances in m²·K/W: outside air film 0.049, 140 mm fiberglass 3.21, 50 mm rigid insulation 1.85, 13 mm plywood 0.11, and inside air film 0.03. What is the total R-value of the ceiling?', 'single_choice', 'hard', 'Given the layer resistances, the total R is their sum: 0.049 + 3.21 + 1.85 + 0.11 + 0.03 = 5.249, about 5.25 m²·K/W. This meets the PAES 417:2002 minimum of 5 (R-30) for ceilings.', NULL, NULL, 'draft', false, NULL, true, 'PAES 417:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.10 m²·K/W', false, 0),
      (v_question_id, '5.25 m²·K/W', true, 1),
      (v_question_id, '3.40 m²·K/W', false, 2),
      (v_question_id, '5.17 m²·K/W', false, 3);
  END IF;

  -- 24. Tissue culture growth room finishes
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 416:2002, which requirements apply to the growth room of a plant tissue culture laboratory?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 416:2002, which requirements apply to the growth room of a plant tissue culture laboratory?', 'single_choice', 'medium', 'PAES 416:2002 requires the growth room to be isolated from the external environment with an anteroom, its ceiling insulated with a minimum R-value of 2.64 (R-15), and its walls painted with antifungal epoxy paint (clause 5.3.2). Uniform airflow, a thermostat and humidity control are also provided.', NULL, NULL, 'draft', false, NULL, true, 'PAES 416:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ceiling insulated to a minimum R-value of 2.64 (R-15) and walls painted with antifungal epoxy paint', true, 0),
      (v_question_id, 'Ceiling insulated to a minimum R-value of 5.0 (R-30) and walls left as bare concrete', false, 1),
      (v_question_id, 'No ceiling insulation, with walls tiled to full height', false, 2),
      (v_question_id, 'Ceiling insulated to a minimum R-value of 1.76 (R-10) and walls painted with ordinary oil paint', false, 3);
  END IF;

  -- 25. Growth room shelf dimensions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the growth room of a plant tissue culture laboratory, PAES 416:2002 sets the shelf width, when accessible from one side only, and the distance between shelf layers at:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the growth room of a plant tissue culture laboratory, PAES 416:2002 sets the shelf width, when accessible from one side only, and the distance between shelf layers at:', 'single_choice', 'medium', 'PAES 416:2002 clause 6.3.5: shelf width should be 405 mm if accessible from only one side and 1 m if accessible from both sides, and the distance between each layer of the shelves shall be 455 mm. Aisles and passages shall be at least 1 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 416:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '405 mm wide with 1 m between layers', false, 0),
      (v_question_id, '405 mm wide with 455 mm between layers', true, 1),
      (v_question_id, '600 mm wide with 300 mm between layers', false, 2),
      (v_question_id, '1 m wide with 455 mm between layers', false, 3);
  END IF;

  -- 26. Carton utilization of pallet surface
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fruit and vegetable container with outside dimensions of 433 mm x 333 mm is packed 8 per layer on a pallet measuring 1.2 m x 1.0 m, as in the container table of PAES 418:2002. What percent of the pallet surface area is utilized?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fruit and vegetable container with outside dimensions of 433 mm x 333 mm is packed 8 per layer on a pallet measuring 1.2 m x 1.0 m, as in the container table of PAES 418:2002. What percent of the pallet surface area is utilized?', 'single_choice', 'medium', 'Given: container 0.433 m x 0.333 m; 8 per layer; pallet 1.2 m x 1.0 m = 1.2 m². Area covered = 8 x 0.433 x 0.333 = 1.1535 m². Utilization = 1.1535 / 1.2 x 100 = 96.1%, about 96%.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '99%', false, 0),
      (v_question_id, '100%', false, 1),
      (v_question_id, '92%', false, 2),
      (v_question_id, '96%', true, 3);
  END IF;

  -- 27. Sorting table design
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which description of a sorting and grading table follows PAES 418:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which description of a sorting and grading table follows PAES 418:2002?', 'single_choice', 'medium', 'PAES 418:2002 clause 7.2.3.3: the sorting and grading surface should be about 100 mm to 150 mm below the bottom of the elbow in the normal working position, and its edges should be lined with a thin layer of foam to protect the commodity from bruising. The table should slope from the center toward the sorter by 10 degrees, with reject chutes at table level.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Surface at shoulder height, hard metal edges, sloping away from the sorter', false, 0),
      (v_question_id, 'Surface 500 mm below the elbow, bare edges, perfectly level', false, 1),
      (v_question_id, 'Surface 100 mm to 150 mm below the bottom of the elbow, foam-lined edges, sloping 10 degrees from the center toward the sorter', true, 2),
      (v_question_id, 'Surface 100 mm to 150 mm above the elbow, foam-lined edges, 30 degree slope', false, 3);
  END IF;

  -- 28. Silo slenderness classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Philippine National Standard for steel silos, slenderness (aspect ratio) is the ratio of the equivalent height of the grain to the silo diameter. A silo has an inside diameter of 8 m and an equivalent grain height of 18 m. How is it classified?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under the Philippine National Standard for steel silos, slenderness (aspect ratio) is the ratio of the equivalent height of the grain to the silo diameter. A silo has an inside diameter of 8 m and an equivalent grain height of 18 m. How is it classified?', 'single_choice', 'medium', 'Given: h = 18 m; d = 8 m. Aspect ratio h/d = 18/8 = 2.25. The standard classifies a silo with h/d >= 2.0 as slender (intermediate is 1.0 < h/d < 2.0, squat is 0.4 < h/d <= 1.0, and retaining is h/d <= 0.4 with a flat bottom).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Intermediate', false, 0),
      (v_question_id, 'Retaining', false, 1),
      (v_question_id, 'Slender', true, 2),
      (v_question_id, 'Squat', false, 3);
  END IF;

  -- 29. Squat silo with hopper
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A steel silo with a hopper bottom has an aspect ratio (h/d) of 0.35. How does the Philippine National Standard for silos classify it?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A steel silo with a hopper bottom has an aspect ratio (h/d) of 0.35. How does the Philippine National Standard for silos classify it?', 'single_choice', 'hard', 'The standard classifies a flat-bottom silo with h/d <= 0.4 as retaining. However, a silo with h/d <= 0.4 that has a hopper is classified as squat, the same class as silos with 0.4 < h/d <= 1.0.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Slender', false, 0),
      (v_question_id, 'Retaining', false, 1),
      (v_question_id, 'Intermediate', false, 2),
      (v_question_id, 'Squat', true, 3);
  END IF;

  -- 30. Silo hopper wall angle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The coefficient of friction of a stored grain on the hopper wall of a steel silo is 0.50. The angle of friction is arctan of the coefficient of friction, and the standard requires the sloping sides of a hopper bottom to be at least 10 degrees greater than the grain angle of friction. What is the minimum hopper wall angle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The coefficient of friction of a stored grain on the hopper wall of a steel silo is 0.50. The angle of friction is arctan of the coefficient of friction, and the standard requires the sloping sides of a hopper bottom to be at least 10 degrees greater than the grain angle of friction. What is the minimum hopper wall angle?', 'single_choice', 'hard', 'Given: coefficient of friction = 0.50. Angle of friction = arctan(0.50) = 26.6 degrees. Minimum hopper wall angle = 26.6 + 10 = 36.6 degrees, so that the grain flows by gravity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '46.6 degrees', false, 0),
      (v_question_id, '36.6 degrees', true, 1),
      (v_question_id, '26.6 degrees', false, 2),
      (v_question_id, '16.6 degrees', false, 3);
  END IF;

  -- 31. Grain bin peak capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cylindrical grain bin has a diameter of 5 m and a wall (eave) height of 6 m. When filled to its peak, the grain forms a cone above the eave with an angle of fill of 28 degrees. Taking the cone volume as one-third of the base area times the cone height, with cone height = radius x tan(angle of fill), what is the peak volumetric capacity of the bin?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A cylindrical grain bin has a diameter of 5 m and a wall (eave) height of 6 m. When filled to its peak, the grain forms a cone above the eave with an angle of fill of 28 degrees. Taking the cone volume as one-third of the base area times the cone height, with cone height = radius x tan(angle of fill), what is the peak volumetric capacity of the bin?', 'single_choice', 'hard', 'Given: D = 5 m; H = 6 m; angle of fill = 28 degrees; radius = 2.5 m. Cylinder volume = (pi/4)(5)² (6) = 117.8 m³. Cone height = 2.5 x tan 28 = 1.329 m; cone volume = (1/3)(pi/4)(5)² (1.329) = 8.7 m³. Peak capacity = 117.8 + 8.7 = 126.5 m³.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '126.5 m³', true, 0),
      (v_question_id, '8.7 m³', false, 1),
      (v_question_id, '143.9 m³', false, 2),
      (v_question_id, '117.8 m³', false, 3);
  END IF;

  -- 32. Silo floor perforation area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For the flooring of a flat-bottom steel silo, the Philippine National Standard for silos requires the net area of perforations (round or slatted) to be at least what percent of the gross floor area, so that the minimum aeration requirement is achieved?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For the flooring of a flat-bottom steel silo, the Philippine National Standard for silos requires the net area of perforations (round or slatted) to be at least what percent of the gross floor area, so that the minimum aeration requirement is achieved?', 'single_choice', 'easy', 'The standard requires, for flat-bottom silo flooring, a net area of perforations of at least 15 percent of the gross floor area. The perforations may be round or slatted.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 percent', false, 0),
      (v_question_id, '25 percent', false, 1),
      (v_question_id, '15 percent', true, 2),
      (v_question_id, '10 percent', false, 3);
  END IF;

  -- 33. Silo wall construction
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement about the walls of a steel grain silo is correct under the Philippine National Standard for silos?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement about the walls of a steel grain silo is correct under the Philippine National Standard for silos?', 'single_choice', 'medium', 'The standard requires wall materials to be corrosion resistant and not painted; rivets or bolts and nuts shall be used to join wall materials and they shall not be welded. Overlaps of wall sheets shall not coincide with those of the adjacent levels, and walls should be installed with stiffeners.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Wall sheets are welded to make the silo airtight, and the inside surface is painted to protect the grain', false, 0),
      (v_question_id, 'Stiffeners are optional because the corrugated wall carries all loads', false, 1),
      (v_question_id, 'Wall sheets are joined by rivets or bolts and nuts, never welded, and wall surfaces are not painted', true, 2),
      (v_question_id, 'Overlaps of wall sheets should coincide with those of adjacent levels to give a continuous seam', false, 3);
  END IF;

  -- 34. Maximum moment of beam with two loads
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A simply supported beam with a 4 m span carries a 5 kN concentrated load at 1 m and a 10 kN concentrated load at 3 m, both measured from the left support. Neglecting the weight of the beam, what is the maximum bending moment?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A simply supported beam with a 4 m span carries a 5 kN concentrated load at 1 m and a 10 kN concentrated load at 3 m, both measured from the left support. Neglecting the weight of the beam, what is the maximum bending moment?', 'single_choice', 'hard', 'Given: span 4 m; 5 kN at 1 m; 10 kN at 3 m from the left. Taking moments about the right support: R_left = (5 x 3 + 10 x 1)/4 = 6.25 kN; R_right = 15 - 6.25 = 8.75 kN. Moment under the 5 kN load = 6.25 x 1 = 6.25 kN-m. Moment under the 10 kN load = 6.25 x 3 - 5 x 2 = 8.75 kN-m. Maximum moment = 8.75 kN-m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12.5 kN-m', false, 0),
      (v_question_id, '15.0 kN-m', false, 1),
      (v_question_id, '6.25 kN-m', false, 2),
      (v_question_id, '8.75 kN-m', true, 3);
  END IF;

  -- 35. Reinforcing bar substitution
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A beam needs 4 pieces of 20 mm diameter reinforcing steel bars. If 20 mm bars are not available, how many 16 mm diameter bars must be used to provide at least the same total cross-sectional area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A beam needs 4 pieces of 20 mm diameter reinforcing steel bars. If 20 mm bars are not available, how many 16 mm diameter bars must be used to provide at least the same total cross-sectional area?', 'single_choice', 'medium', 'Given: 4 bars of 20 mm; replacement bars of 16 mm. Required area = 4 x (pi/4)(20)² = 1,256.6 mm². Area of one 16 mm bar = (pi/4)(16)² = 201.06 mm². Number = 1,256.6 / 201.06 = 6.25, which is rounded up to 7 bars.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7 bars', true, 0),
      (v_question_id, '6 bars', false, 1),
      (v_question_id, '5 bars', false, 2),
      (v_question_id, '8 bars', false, 3);
  END IF;

  -- 36. Safe uniform load on a beam
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A simply supported beam spans 4 m and has a section modulus of 1.04 x 10^6 mm³. The allowable bending stress is 12 MPa. What is the safe uniformly distributed load the beam can carry, using M = wL²/8 for the maximum moment?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A simply supported beam spans 4 m and has a section modulus of 1.04 x 10^6 mm³. The allowable bending stress is 12 MPa. What is the safe uniformly distributed load the beam can carry, using M = wL²/8 for the maximum moment?', 'single_choice', 'hard', 'Given: L = 4 m; S = 1.04 x 10^6 mm³; allowable stress = 12 MPa. Resisting moment M = stress x S = 12 x 1.04 x 10^6 = 12.48 x 10^6 N-mm = 12.48 kN-m. From M = wL²/8, w = 8M/L² = 8(12.48)/(4)² = 6.24 kN/m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9.36 kN/m', false, 0),
      (v_question_id, '6.24 kN/m', true, 1),
      (v_question_id, '12.48 kN/m', false, 2),
      (v_question_id, '3.12 kN/m', false, 3);
  END IF;

  -- 37. Greenhouse footing concrete
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A permanent greenhouse needs 20 post footings, each 0.30 m x 0.30 m in plan and 0.45 m deep (the minimum foundation depth for permanent greenhouses). A Class A mix needs 9 bags of 40-kg cement per cubic meter of concrete. How many bags of cement are needed for all the footings, rounded up to whole bags?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A permanent greenhouse needs 20 post footings, each 0.30 m x 0.30 m in plan and 0.45 m deep (the minimum foundation depth for permanent greenhouses). A Class A mix needs 9 bags of 40-kg cement per cubic meter of concrete. How many bags of cement are needed for all the footings, rounded up to whole bags?', 'single_choice', 'hard', 'Given: 20 footings of 0.30 x 0.30 x 0.45 m; 9 bags of cement per m³. Volume of one footing = 0.30 x 0.30 x 0.45 = 0.0405 m³; total = 20 x 0.0405 = 0.81 m³. Bags = 9 x 0.81 = 7.29, rounded up to 8 bags.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9 bags', false, 0),
      (v_question_id, '6 bags', false, 1),
      (v_question_id, '7 bags', false, 2),
      (v_question_id, '8 bags', true, 3);
  END IF;

  -- 38. Plywood plies by thickness
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 320:2002, general-purpose plywood 12 mm thick is made up of how many plies?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 320:2002, general-purpose plywood 12 mm thick is made up of how many plies?', 'single_choice', 'easy', 'PAES 320:2002 Table 2 lists thickness against number of plies: 3 mm and 4 mm have 3 plies; 5.5 mm and 10 mm have 5 plies; and 12 mm, 15 mm, 19 mm and 25 mm have 7 plies. Plyboard of 15 mm and thicker has a kiln-dried lumber core.', NULL, NULL, 'draft', false, NULL, true, 'PAES 320:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7 plies', true, 0),
      (v_question_id, '5 plies', false, 1),
      (v_question_id, '9 plies', false, 2),
      (v_question_id, '3 plies', false, 3);
  END IF;

  -- 39. Galvanizing of steel greenhouse frames
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 415:2001, when steel greenhouse framing is galvanized, when should galvanizing be done and how are exposed areas treated?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 415:2001, when steel greenhouse framing is galvanized, when should galvanizing be done and how are exposed areas treated?', 'single_choice', 'medium', 'PAES 415:2001 clause 7.3.2.1.2: if galvanizing is done, it shall preferably be done after all cutting and welding has been performed. Areas where bare metal is exposed by cutting or welding shall be painted. Steel must be painted or galvanized to resist high-moisture conditions.', NULL, NULL, 'draft', false, NULL, true, 'PAES 415:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Only on roof members, leaving columns bare', false, 0),
      (v_question_id, 'After all cutting and welding, with exposed bare metal painted', true, 1),
      (v_question_id, 'It is not recommended; aluminum paint alone is used', false, 2),
      (v_question_id, 'Before cutting and welding, with cut ends left untreated', false, 3);
  END IF;

  -- 40. Board feet and cost of wooden frame members
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A wooden greenhouse frame requires 40 pieces of lumber, each 2 in thick x 3 in wide x 12 ft long, priced at P65 per board foot. Using bd.ft = T(in) x W(in) x L(ft) / 12, what is the total cost?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A wooden greenhouse frame requires 40 pieces of lumber, each 2 in thick x 3 in wide x 12 ft long, priced at P65 per board foot. Using bd.ft = T(in) x W(in) x L(ft) / 12, what is the total cost?', 'single_choice', 'medium', 'Given: 40 pieces of 2 in x 3 in x 12 ft; P65 per board foot. One piece = 2 x 3 x 12 / 12 = 6 bd.ft. Total = 40 x 6 = 240 bd.ft. Cost = 240 x 65 = P15,600.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P31,200', false, 0),
      (v_question_id, 'P390', false, 1),
      (v_question_id, 'P15,600', true, 2),
      (v_question_id, 'P1,300', false, 3);
  END IF;

END $$;
