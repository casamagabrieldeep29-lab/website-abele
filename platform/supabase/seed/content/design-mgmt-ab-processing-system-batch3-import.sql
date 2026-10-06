-- Design and Management of AB Processing System quiz batch (35 questions, 1 topic). Every fact is
-- drawn directly from PAES 418:2002, PAES 419:2000, PAES 201/202:2000 and
-- PAES 206:2000 as read in full, and from grain drying, milling and storage
-- lecture notes read in full. All numeric answers were re-derived. No invented
-- facts. Questions that repeat existing ones in this topic were avoided.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). Questions tied directly to a PAES
-- clause carry is_paes=true with the standard in paes_reference; the rest are
-- is_paes=false with paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Design and Management of AB Processing System (BIOPROCESS) — 35 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Design and Management of AB Processing System' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Design and Management of AB Processing System';
  END IF;

  -- 1. Plant location
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly describes a location requirement for a primary processing plant for fresh fruit and vegetable under PAES 418:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly describes a location requirement for a primary processing plant for fresh fruit and vegetable under PAES 418:2002?', 'single_choice', 'medium', 'PAES 418:2002 clause 4 requires the location to conform to the land use plan, to be as near as possible to the raw material supplies, to be accessible to service roads, water supply and electric lines, to have a parking area, to be well drained, and to be away from any source of smells and insects.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The site shall be as near as possible to the raw material supplies, accessible to service roads, water supply and electric lines, and well drained', true, 0),
      (v_question_id, 'The site shall be located near the final consumer market, regardless of its distance from the raw material supplies', false, 1),
      (v_question_id, 'The site shall be on low-lying land so that surface water collects away from the working area', false, 2),
      (v_question_id, 'The site shall be beside livestock or waste facilities so that by-products can be disposed of quickly', false, 3);
  END IF;

  -- 2. Finished product storeroom
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 418:2002, the storeroom for finished products of a fruit and vegetable primary processing plant shall be kept at what temperature and relative humidity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 418:2002, the storeroom for finished products of a fruit and vegetable primary processing plant shall be kept at what temperature and relative humidity?', 'single_choice', 'easy', 'PAES 418:2002 clause 7.4.1 states that the storeroom for finished products shall be clean, protected from foreign matter, and kept at less than 25 degrees C and 60% relative humidity.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 10 °C and 85% relative humidity', false, 0),
      (v_question_id, 'Less than 25 °C and 85% relative humidity', false, 1),
      (v_question_id, 'Less than 25 °C and 60% relative humidity', true, 2),
      (v_question_id, 'Less than 35 °C and 40% relative humidity', false, 3);
  END IF;

  -- 3. Floor slope
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PAES 418:2002, the smooth-finished concrete floor of the processing rooms and storerooms of a fruit and vegetable primary processing plant shall slope how much toward the drainage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PAES 418:2002, the smooth-finished concrete floor of the processing rooms and storerooms of a fruit and vegetable primary processing plant shall slope how much toward the drainage?', 'single_choice', 'easy', 'PAES 418:2002 clause 6.6.3 requires the floor to slope 2% to 4% toward the drainage. The floor is also coved at its intersection with the wall with a 50 mm to 60 mm radius.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.1% to 0.5%', false, 0),
      (v_question_id, '2% to 4%', true, 1),
      (v_question_id, '6% to 8%', false, 2),
      (v_question_id, '10% to 12%', false, 3);
  END IF;

  -- 4. Dirty/clean separation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which arrangement of the processing area is required by PAES 418:2002 for a fruit and vegetable primary processing plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which arrangement of the processing area is required by PAES 418:2002 for a fruit and vegetable primary processing plant?', 'single_choice', 'medium', 'PAES 418:2002 clause 7.2.2 requires the processing area to be physically divided into areas where different functions are performed. The dirty area shall not extend to the section of the plant where the cleanest operations are carried out, and the separation is achieved with light partitions or painted wood panels.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The area is physically divided by function, and the dirty area shall not extend to the section where the cleanest operations are carried out', true, 0),
      (v_question_id, 'The raw material storage area also serves as storage for pesticides and cleaning utensils to save floor space', false, 1),
      (v_question_id, 'One open, undivided room so that workers can move freely between washing and packing', false, 2),
      (v_question_id, 'The washing area placed directly beside the packing area, without partitions, to shorten product handling', false, 3);
  END IF;

  -- 5. Warehouse orientation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 419:2000, how should the long axes of a warehouse for bagged storage of grains be oriented?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 419:2000, how should the long axes of a warehouse for bagged storage of grains be oriented?', 'single_choice', 'easy', 'PAES 419:2000 clause 3.4 states that the long axes of the warehouses should be oriented East-West or sited across the prevailing wind, so that the building is not exposed to afternoon sunlight.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'North-South, to expose both long walls to equal sunlight', false, 0),
      (v_question_id, 'Along the direction of the prevailing wind, to channel air through the building', false, 1),
      (v_question_id, 'Any direction, as long as the roof is painted white', false, 2),
      (v_question_id, 'East-West, or across the prevailing wind', true, 3);
  END IF;

  -- 6. Chinese vs Japanese piling
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Bagged paddy with a moisture content of 16% is to be stored in a warehouse designed under PAES 419:2000. Which piling method applies, and why?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Bagged paddy with a moisture content of 16% is to be stored in a warehouse designed under PAES 419:2000. Which piling method applies, and why?', 'single_choice', 'medium', 'PAES 419:2000 clause 4.2.2.2.1: bagged grain at 14% moisture content or lower may be piled in the Chinese method, while grain with more than 14% moisture content is piled in the Japanese method. The Japanese method provides ventilation space between bags and allows circulation of convective air currents that dissipate heat.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Japanese piling, because it is limited to grain with a moisture content of 14% or lower', false, 0),
      (v_question_id, 'Chinese piling, because bags are laid side by side and one on top of the other to save space', false, 1),
      (v_question_id, 'Japanese piling, because it leaves air spaces between bags that allow convective air currents to dissipate heat', true, 2),
      (v_question_id, 'Chinese piling, because the wooden pallets are sprayed with malathion', false, 3);
  END IF;

  -- 7. Sack stack height
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 419:2000, woven polypropylene sacks have a tendency to slide on each other and therefore shall not be stacked higher than:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 419:2000, woven polypropylene sacks have a tendency to slide on each other and therefore shall not be stacked higher than:', 'single_choice', 'easy', 'PAES 419:2000 clause 4.2.3.2 limits woven polypropylene sacks to 3 meters in height, while jute sacks bind together better and may be stacked up to 6 meters above the floor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 m', false, 0),
      (v_question_id, '4.5 m', false, 1),
      (v_question_id, '6 m', false, 2),
      (v_question_id, '3 m', true, 3);
  END IF;

  -- 8. Warehouse floor height
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 419:2000 requires the floor of a grain warehouse to be elevated above the existing ground. If loading and unloading of trucks will be permitted inside the warehouse, the floor shall be how high above the ground?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 419:2000 requires the floor of a grain warehouse to be elevated above the existing ground. If loading and unloading of trucks will be permitted inside the warehouse, the floor shall be how high above the ground?', 'single_choice', 'easy', 'PAES 419:2000 clause 5.2.2: the floor should be 1 m above the ground to permit easy loading or unloading into trucks at the sides of the warehouse, but if loading and unloading of trucks is permitted inside the warehouse the floor shall be 0.3 m above the ground.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.6 m', false, 0),
      (v_question_id, '0.3 m', true, 1),
      (v_question_id, '1.0 m', false, 2),
      (v_question_id, '0.1 m', false, 3);
  END IF;

  -- 9. Aeration airflow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 419:2000 defines aeration as moving air through stored grains at low airflow rates for purposes other than drying, to maintain or improve grain quality. The generally used airflow range is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 419:2000 defines aeration as moving air through stored grains at low airflow rates for purposes other than drying, to maintain or improve grain quality. The generally used airflow range is:', 'single_choice', 'medium', 'PAES 419:2000 clause 2.7 gives the generally used aeration airflow as 0.07 to 0.28 cubic meter per minute per ton of grain.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.07 to 0.28 cubic meter per minute per ton', true, 0),
      (v_question_id, '0.007 to 0.028 cubic meter per minute per ton', false, 1),
      (v_question_id, '0.7 to 2.8 cubic meters per minute per ton', false, 2),
      (v_question_id, '7 to 28 cubic meters per minute per ton', false, 3);
  END IF;

  -- 10. Rice mill milling recovery index
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to the performance criteria of PAES 206:2000 (Rice Mill - Specifications), what is the minimum milling recovery index of a single-pass rubber roll type rice mill?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to the performance criteria of PAES 206:2000 (Rice Mill - Specifications), what is the minimum milling recovery index of a single-pass rubber roll type rice mill?', 'single_choice', 'medium', 'Table 1 of PAES 206:2000 sets the minimum milling recovery index at 0.98 for rubber roll type mills and 0.97 for cono type mills, while the minimum percent head rice index is 0.90 for all types and the minimum hulling efficiency is 80%.', NULL, NULL, 'draft', false, NULL, true, 'PAES 206:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.95', false, 0),
      (v_question_id, '0.90', false, 1),
      (v_question_id, '0.97', false, 2),
      (v_question_id, '0.98', true, 3);
  END IF;

  -- 11. Dryer heating system efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 201:2000 requires a minimum heating system efficiency of what value for a direct-fired heated-air mechanical grain dryer that uses petroleum-based fuel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 201:2000 requires a minimum heating system efficiency of what value for a direct-fired heated-air mechanical grain dryer that uses petroleum-based fuel?', 'single_choice', 'medium', 'In the performance criteria of PAES 201:2000, the minimum heating system efficiency is 90% for direct-fired and 75% for indirect-fired dryers using petroleum-based fuel, and 65% for direct-fired and 50% for indirect-fired dryers using biomass fuel.', NULL, NULL, 'draft', false, NULL, true, 'PAES 201:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '65%', false, 0),
      (v_question_id, '75%', false, 1),
      (v_question_id, '90%', true, 2),
      (v_question_id, '50%', false, 3);
  END IF;

  -- 12. Tempering
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In grain drying, temporarily holding the grain between drying passes so that the moisture content at the center of the kernel and at its surface can equalize is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In grain drying, temporarily holding the grain between drying passes so that the moisture content at the center of the kernel and at its surface can equalize is called:', 'single_choice', 'easy', 'Tempering is the temporary holding of the grain between drying passes to allow the moisture content in the center of the grain and on its surface to equalize.', NULL, NULL, 'draft', false, NULL, true, 'PAES 202:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aeration', false, 0),
      (v_question_id, 'Tempering', true, 1),
      (v_question_id, 'Dehydration', false, 2),
      (v_question_id, 'Curing', false, 3);
  END IF;

  -- 13. Direct vs indirect-fired
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Why is the thermal efficiency of an indirect-fired grain dryer lower than that of a direct-fired dryer?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Why is the thermal efficiency of an indirect-fired grain dryer lower than that of a direct-fired dryer?', 'single_choice', 'medium', 'In an indirect-fired dryer the burner heats a heat-transfer surface and the drying air passes around it before reaching the grain. The combustion gases do not touch the product, but the low thermal efficiency means most of the fuel energy is lost through the smokestack. A direct-fired dryer forces the products of combustion through the grain with the drying air, so it is less expensive and uses the fuel energy more efficiently.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The combustion gases are mixed with the drying air, which wastes the heat', false, 0),
      (v_question_id, 'The drying air is recirculated, so its temperature keeps falling', false, 1),
      (v_question_id, 'It can only burn biomass fuel, which has a low heating value', false, 2),
      (v_question_id, 'The heat must pass through a heat-transfer surface, and most of the fuel energy is lost through the smokestack', true, 3);
  END IF;

  -- 14. Pre-ventilation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a grain dryer with a burner, what does pre-ventilation accomplish?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a grain dryer with a burner, what does pre-ventilation accomplish?', 'single_choice', 'medium', 'Pre-ventilation is the clearing or purging of the plenum chamber or duct of volatile gases before the burner is ignited. It is usually done by a device that ensures the fan must operate for a certain period before ignition is permitted. Returning exhaust air to the dryer intake is recirculation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It cools the dried grain before it is discharged to storage', false, 0),
      (v_question_id, 'It pre-dries the grain with unheated air before the grain enters the drying chamber', false, 1),
      (v_question_id, 'It clears the plenum chamber and ducts of volatile gases before the burner is ignited', true, 2),
      (v_question_id, 'It returns part of the exhaust air to the dryer intake to save fuel', false, 3);
  END IF;

  -- 15. Bulk storage disadvantage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is a disadvantage of bulk storage of grains compared with bag storage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is a disadvantage of bulk storage of grains compared with bag storage?', 'single_choice', 'medium', 'Bulk storage has a higher capital cost, needs mechanical handling equipment, is inflexible, and requires a higher level of skill in construction and operation. Being labor intensive, involving much spillage, and being difficult to monitor for insects, rodents and birds are disadvantages of bag storage instead.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It is labor intensive and slow', false, 0),
      (v_question_id, 'It requires mechanical handling equipment and has a higher capital cost', true, 1),
      (v_question_id, 'It is difficult to monitor for insects, rodents and birds', false, 2),
      (v_question_id, 'It involves much spillage', false, 3);
  END IF;

  -- 16. Paddy separator
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A paddy separator that makes use of the difference in specific gravity and length between paddy and brown rice is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A paddy separator that makes use of the difference in specific gravity and length between paddy and brown rice is the:', 'single_choice', 'medium', 'The tray-type separator uses the difference in specific gravity and length. The compartment-type separator uses the difference in specific gravity and buoyancy. A paddy separator is needed because paddy has a lower specific gravity than brown rice and its grains are longer, wider and thicker.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tray-type separator', true, 0),
      (v_question_id, 'Destoner', false, 1),
      (v_question_id, 'Aspirator', false, 2),
      (v_question_id, 'Compartment-type separator', false, 3);
  END IF;

  -- 17. Husk share
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rice husk represents approximately what percentage of the weight of paddy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Rice husk represents approximately what percentage of the weight of paddy?', 'single_choice', 'easy', 'Husks represent 20 to 24% of the weight of paddy. For example, 1,000 kg of paddy yields roughly 200 to 240 kg of husk.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35 to 40%', false, 0),
      (v_question_id, '10 to 12%', false, 1),
      (v_question_id, '5 to 8%', false, 2),
      (v_question_id, '20 to 24%', true, 3);
  END IF;

  -- 18. Falling-rate period
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During the falling-rate period of grain drying, the rate of drying is controlled largely by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'During the falling-rate period of grain drying, the rate of drying is controlled largely by:', 'single_choice', 'medium', 'In the falling-rate period, which follows the constant-rate period, drying is controlled largely by the movement of moisture from the interior of the grain to its surface by liquid diffusion. The surface area, humidity difference, mass transfer coefficient and air velocity govern the constant-rate period, when drying takes place from the grain surface like evaporation from a free water surface.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'the velocity of the drying air passing over the grain surface', false, 0),
      (v_question_id, 'the humidity difference between the air stream and the wet grain surface', false, 1),
      (v_question_id, 'the movement of moisture from inside the grain to its surface by liquid diffusion', true, 2),
      (v_question_id, 'the coefficient of mass transfer at the grain surface', false, 3);
  END IF;

  -- 19. Desorption
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If the vapor pressure of the water held by the grain is greater than the vapor pressure of the surrounding air, which process takes place?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If the vapor pressure of the water held by the grain is greater than the vapor pressure of the surrounding air, which process takes place?', 'single_choice', 'easy', 'When the vapor pressure of the grain moisture exceeds that of the surrounding air, moisture leaves the grain, which is desorption (drying). If the vapor pressures are equal, the grain is in equilibrium with the air. If the air has the higher vapor pressure, the grain takes up moisture (adsorption).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hysteresis', false, 0),
      (v_question_id, 'Desorption', true, 1),
      (v_question_id, 'Absorption', false, 2),
      (v_question_id, 'Adsorption', false, 3);
  END IF;

  -- 20. Plant area computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A primary processing plant for fresh fruit and vegetable is to handle 35 tons of commodity. Using the PAES 418:2002 requirement of 20 square meters of area per ton of commodity, what area shall be provided for the plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A primary processing plant for fresh fruit and vegetable is to handle 35 tons of commodity. Using the PAES 418:2002 requirement of 20 square meters of area per ton of commodity, what area shall be provided for the plant?', 'single_choice', 'easy', 'Given: 35 tons of commodity and 20 m2 per ton (PAES 418:2002 clause 5.1). Area = 35 tons x 20 m2/ton = 700 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 418:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '700 m²', true, 0),
      (v_question_id, '1.75 m²', false, 1),
      (v_question_id, '70 m²', false, 2),
      (v_question_id, '7,000 m²', false, 3);
  END IF;

  -- 21. Warehouse floor area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The PAES 419:2000 recommended warehouse for 100,000 cavans measures 25 m x 78 m, and larger capacities are met by building identical units. If a 300,000-cavan grain warehouse is built as three identical 100,000-cavan buildings, what is the total floor area of the three buildings?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The PAES 419:2000 recommended warehouse for 100,000 cavans measures 25 m x 78 m, and larger capacities are met by building identical units. If a 300,000-cavan grain warehouse is built as three identical 100,000-cavan buildings, what is the total floor area of the three buildings?', 'single_choice', 'medium', 'Given: one building = 25 m x 78 m = 1,950 m2. Three buildings = 3 x 1,950 = 5,850 m2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 419:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,950 m²', false, 0),
      (v_question_id, '5,850 m²', true, 1),
      (v_question_id, '3,900 m²', false, 2),
      (v_question_id, '7,800 m²', false, 3);
  END IF;

  -- 22. Bag count
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pile of milled rice in a warehouse is 10 m long, 5 m wide and 3 m high. If the recommended stacking density for rice is 15 bags per cubic meter, how many bags can be piled?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pile of milled rice in a warehouse is 10 m long, 5 m wide and 3 m high. If the recommended stacking density for rice is 15 bags per cubic meter, how many bags can be piled?', 'single_choice', 'medium', 'Given: volume = 10 m x 5 m x 3 m = 150 m3 and stacking density of rice = 15 bags/m3. Number of bags = 150 x 15 = 2,250 bags. The recommended densities are 10 bags/m3 for palay, 15 bags/m3 for rice and 12 bags/m3 for corn.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '150 bags', false, 0),
      (v_question_id, '1,800 bags', false, 1),
      (v_question_id, '2,250 bags', true, 2),
      (v_question_id, '1,500 bags', false, 3);
  END IF;

  -- 23. MC wb to db
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Palay has a moisture content of 28% wet basis. What is its moisture content on a dry basis?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Palay has a moisture content of 28% wet basis. What is its moisture content on a dry basis?', 'single_choice', 'easy', 'MCdb = MCwb / (100 - MCwb) x 100 = 28 / (100 - 28) x 100 = 28 / 72 x 100 = 38.9%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '28.0%', false, 0),
      (v_question_id, '72.0%', false, 1),
      (v_question_id, '21.9%', false, 2),
      (v_question_id, '38.9%', true, 3);
  END IF;

  -- 24. Dry matter at MC db
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A lot of newly dried paddy weighs 2,280 kg and has a moisture content of 14% dry basis. What is the weight of the dry matter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A lot of newly dried paddy weighs 2,280 kg and has a moisture content of 14% dry basis. What is the weight of the dry matter?', 'single_choice', 'medium', 'Given: total weight = 2,280 kg and MCdb = 14%. On a dry basis, total weight = dry matter x (1 + 0.14), so dry matter = 2,280 / 1.14 = 2,000 kg (the remaining 280 kg is water).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2,000.0 kg', true, 0),
      (v_question_id, '2,266.0 kg', false, 1),
      (v_question_id, '1,960.8 kg', false, 2),
      (v_question_id, '2,651.2 kg', false, 3);
  END IF;

  -- 25. Water removed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 2,500-kg lot of paddy at 22% moisture content wet basis is dried to 14% wet basis. How much water is removed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 2,500-kg lot of paddy at 22% moisture content wet basis is dried to 14% wet basis. How much water is removed?', 'single_choice', 'medium', 'Given: initial weight = 2,500 kg, initial MC = 22% wb, final MC = 14% wb. Dry matter = 2,500 x 0.78 = 1,950 kg. Final weight = 1,950 / 0.86 = 2,267.4 kg. Water removed = 2,500 - 2,267.4 = 232.6 kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200.0 kg', false, 0),
      (v_question_id, '350.0 kg', false, 1),
      (v_question_id, '232.6 kg', true, 2),
      (v_question_id, '256.4 kg', false, 3);
  END IF;

  -- 26. Fresh paddy to procure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A research project needs 6,000 kg of paddy with a moisture content of 12% dry basis. The available freshly harvested paddy has a moisture content of 24% wet basis and will be dried to 12% dry basis. How many kilograms of freshly harvested paddy must be procured?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A research project needs 6,000 kg of paddy with a moisture content of 12% dry basis. The available freshly harvested paddy has a moisture content of 24% wet basis and will be dried to 12% dry basis. How many kilograms of freshly harvested paddy must be procured?', 'single_choice', 'hard', 'Given: final weight = 6,000 kg at 12% db; initial MC = 24% wb. Dry matter = 6,000 / 1.12 = 5,357.1 kg. Fresh paddy weight = dry matter / (1 - 0.24) = 5,357.1 / 0.76 = 7,048.9 kg, or about 7,049 kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6,720 kg', false, 0),
      (v_question_id, '7,895 kg', false, 1),
      (v_question_id, '6,947 kg', false, 2),
      (v_question_id, '7,049 kg', true, 3);
  END IF;

  -- 27. Rice hull fuel for drying
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many kilograms of rice hull are needed to dry 1.5 tons of palay from 22% to 14% moisture content wet basis? Given: latent heat of vaporization of water = 2,500 kJ/kg, heating value of rice hull = 14 MJ/kg, and overall heat utilization efficiency of the furnace and dryer = 40%.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many kilograms of rice hull are needed to dry 1.5 tons of palay from 22% to 14% moisture content wet basis? Given: latent heat of vaporization of water = 2,500 kJ/kg, heating value of rice hull = 14 MJ/kg, and overall heat utilization efficiency of the furnace and dryer = 40%.', 'single_choice', 'hard', 'Given: 1,500 kg palay, 22% wb to 14% wb, latent heat = 2,500 kJ/kg, heating value = 14,000 kJ/kg, efficiency = 40%. Dry matter = 1,500 x 0.78 = 1,170 kg. Final weight = 1,170 / 0.86 = 1,360.5 kg. Water removed = 1,500 - 1,360.5 = 139.5 kg. Heat required = 139.5 x 2,500 = 348,837 kJ. Fuel energy = 348,837 / 0.40 = 872,093 kJ. Rice hull = 872,093 / 14,000 = 62.3 kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '62.3 kg', true, 0),
      (v_question_id, '53.6 kg', false, 1),
      (v_question_id, '10.0 kg', false, 2),
      (v_question_id, '24.9 kg', false, 3);
  END IF;

  -- 28. Kerosene for drying
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many liters of kerosene are needed to dry 2 tons of paddy from 28% to 14% moisture content wet basis? Given: latent heat of vaporization of water = 2,500 kJ/kg, heating value of kerosene = 43 MJ/kg, specific gravity of kerosene = 0.8, and burner efficiency = 80%.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many liters of kerosene are needed to dry 2 tons of paddy from 28% to 14% moisture content wet basis? Given: latent heat of vaporization of water = 2,500 kJ/kg, heating value of kerosene = 43 MJ/kg, specific gravity of kerosene = 0.8, and burner efficiency = 80%.', 'single_choice', 'hard', 'Given: 2,000 kg paddy, 28% wb to 14% wb, latent heat = 2,500 kJ/kg, heating value = 43,000 kJ/kg, SG = 0.8, efficiency = 80%. Dry matter = 2,000 x 0.72 = 1,440 kg. Final weight = 1,440 / 0.86 = 1,674.4 kg. Water removed = 325.6 kg. Heat required = 325.6 x 2,500 = 813,953 kJ. Fuel energy = 813,953 / 0.80 = 1,017,442 kJ. Kerosene = 1,017,442 / 43,000 = 23.66 kg. Volume = 23.66 / 0.8 = 29.6 L.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25.4 L', false, 0),
      (v_question_id, '29.6 L', true, 1),
      (v_question_id, '18.9 L', false, 2),
      (v_question_id, '23.7 L', false, 3);
  END IF;

  -- 29. Blower capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Each cubic meter of drying air removes 0.002 kg of moisture from the grain. What blower capacity, in cubic meters per minute, is needed to remove 150 kg of moisture in 10 hours of drying?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Each cubic meter of drying air removes 0.002 kg of moisture from the grain. What blower capacity, in cubic meters per minute, is needed to remove 150 kg of moisture in 10 hours of drying?', 'single_choice', 'medium', 'Given: 0.002 kg water per m3 of air, 150 kg water to remove, 10 h of drying. Air required = 150 / 0.002 = 75,000 m3. Drying time = 10 x 60 = 600 min. Blower capacity = 75,000 / 600 = 125 m3/min.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12.5 m³/min', false, 0),
      (v_question_id, '250 m³/min', false, 1),
      (v_question_id, '7,500 m³/min', false, 2),
      (v_question_id, '125 m³/min', true, 3);
  END IF;

  -- 30. Silo dimensions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cylindrical silo is to store 8 tons of paddy with a bulk density of 576 kg/m3. If the silo height is twice its diameter (H = 2D), what are the diameter and height of the silo? Neglect the additional volume of the cone formed by the angle of repose.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A cylindrical silo is to store 8 tons of paddy with a bulk density of 576 kg/m3. If the silo height is twice its diameter (H = 2D), what are the diameter and height of the silo? Neglect the additional volume of the cone formed by the angle of repose.', 'single_choice', 'hard', 'Given: mass = 8,000 kg, bulk density = 576 kg/m3, H = 2D. Volume = 8,000 / 576 = 13.89 m3. V = (pi/4) D2 (2D) = (pi/2) D3, so D3 = 13.89 / 1.5708 = 8.842 and D = 2.07 m. H = 2D = 4.14 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'D = 2.28 m; H = 3.42 m', false, 0),
      (v_question_id, 'D = 2.07 m; H = 4.14 m', true, 1),
      (v_question_id, 'D = 2.61 m; H = 2.61 m', false, 2),
      (v_question_id, 'D = 1.91 m; H = 3.82 m', false, 3);
  END IF;

  -- 31. Silo classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A silo has a diameter of 6 m and a height of 9 m. Using the aspect-ratio classification of silos (retaining: h/d of 0.4 or less; squat: h/d from 0.4 to 1.0; intermediate: h/d from 1.0 to 2.0; slender: h/d of 2.0 or more), how is this silo classified?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A silo has a diameter of 6 m and a height of 9 m. Using the aspect-ratio classification of silos (retaining: h/d of 0.4 or less; squat: h/d from 0.4 to 1.0; intermediate: h/d from 1.0 to 2.0; slender: h/d of 2.0 or more), how is this silo classified?', 'single_choice', 'medium', 'Given: d = 6 m and h = 9 m. Aspect ratio h/d = 9 / 6 = 1.5, which lies between 1.0 and 2.0, so the silo is intermediate.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Intermediate', true, 0),
      (v_question_id, 'Slender', false, 1),
      (v_question_id, 'Retaining', false, 2),
      (v_question_id, 'Squat', false, 3);
  END IF;

  -- 32. Moisture reduction per hour
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A heated-air mechanical grain dryer is tested with 2,000 kg of paddy at 22% moisture content wet basis, dried to 14% wet basis in an actual drying time of 5 hours. Using the PAES 202:2000 formulas (final weight W2 = W1(100 - MC1)/(100 - MC2); moisture reduction per hour by weight = (initial weight - final weight)/actual drying time), what is the moisture reduction per hour by weight?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A heated-air mechanical grain dryer is tested with 2,000 kg of paddy at 22% moisture content wet basis, dried to 14% wet basis in an actual drying time of 5 hours. Using the PAES 202:2000 formulas (final weight W2 = W1(100 - MC1)/(100 - MC2); moisture reduction per hour by weight = (initial weight - final weight)/actual drying time), what is the moisture reduction per hour by weight?', 'single_choice', 'hard', 'Given: W1 = 2,000 kg, MC1 = 22%, MC2 = 14%, time = 5 h. W2 = 2,000 x (100 - 22) / (100 - 14) = 2,000 x 78 / 86 = 1,813.95 kg. Moisture removed = 2,000 - 1,813.95 = 186.05 kg. Moisture reduction per hour = 186.05 / 5 = 37.2 kg/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 202:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '32.0 kg/h', false, 0),
      (v_question_id, '400.0 kg/h', false, 1),
      (v_question_id, '37.2 kg/h', true, 2),
      (v_question_id, '186.1 kg/h', false, 3);
  END IF;

  -- 33. Heat utilization factor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The heat utilization factor of a dryer is the ratio of the temperature drop of the air during drying (evaporative cooling) to the temperature rise caused by heating the air. Ambient air at 30 °C (T1) is heated to 60 °C (T2) and leaves the dryer at 40 °C (T3). What is the heat utilization factor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The heat utilization factor of a dryer is the ratio of the temperature drop of the air during drying (evaporative cooling) to the temperature rise caused by heating the air. Ambient air at 30 °C (T1) is heated to 60 °C (T2) and leaves the dryer at 40 °C (T3). What is the heat utilization factor?', 'single_choice', 'medium', 'Given: T1 = 30 °C, T2 = 60 °C, T3 = 40 °C. Temperature drop during drying = T2 - T3 = 20 °C. Temperature rise from heating = T2 - T1 = 30 °C. HUF = 20 / 30 = 0.67.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.33', false, 0),
      (v_question_id, '0.50', false, 1),
      (v_question_id, '1.50', false, 2),
      (v_question_id, '0.67', true, 3);
  END IF;

  -- 34. Hulling efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In testing a rice mill under PAES 206:2000, 200 kg of clean paddy was fed and 30 kg of unhulled paddy was recovered. A hulled sample weighing 100 g contained 90 g of whole brown rice. If the coefficient of hulling = 1 - (weight of unhulled paddy / weight of clean paddy), the coefficient of wholeness = weight of whole brown rice / weight of the total hulled sample, and hulling efficiency is the product of the two expressed in percent, what is the hulling efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In testing a rice mill under PAES 206:2000, 200 kg of clean paddy was fed and 30 kg of unhulled paddy was recovered. A hulled sample weighing 100 g contained 90 g of whole brown rice. If the coefficient of hulling = 1 - (weight of unhulled paddy / weight of clean paddy), the coefficient of wholeness = weight of whole brown rice / weight of the total hulled sample, and hulling efficiency is the product of the two expressed in percent, what is the hulling efficiency?', 'single_choice', 'hard', 'Given: clean paddy = 200 kg, unhulled paddy = 30 kg, whole brown rice = 90 g out of 100 g. Coefficient of hulling = 1 - 30/200 = 0.85. Coefficient of wholeness = 90/100 = 0.90. Hulling efficiency = 0.85 x 0.90 x 100 = 76.5%. This is below the 80% minimum hulling efficiency in the PAES 206:2000 performance criteria.', NULL, NULL, 'draft', false, NULL, true, 'PAES 206:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '87.5%', false, 0),
      (v_question_id, '90.0%', false, 1),
      (v_question_id, '76.5%', true, 2),
      (v_question_id, '85.0%', false, 3);
  END IF;

  -- 35. Milling recovery
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Milling recovery is the ratio of the weight of milled rice to the total weight of palay, expressed in percent. A rice mill processed 2,400 kg of palay and produced 480 kg of husk and 1,632 kg of milled rice. What is the milling recovery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Milling recovery is the ratio of the weight of milled rice to the total weight of palay, expressed in percent. A rice mill processed 2,400 kg of palay and produced 480 kg of husk and 1,632 kg of milled rice. What is the milling recovery?', 'single_choice', 'medium', 'Given: palay = 2,400 kg, husk = 480 kg, milled rice = 1,632 kg. Milling recovery = 1,632 / 2,400 x 100 = 68.0%. The husk is part of the palay weight, so it is not subtracted from the denominator.', NULL, NULL, 'draft', false, NULL, true, 'PAES 206:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '68.0%', true, 0),
      (v_question_id, '32.0%', false, 1),
      (v_question_id, '85.0%', false, 2),
      (v_question_id, '80.0%', false, 3);
  END IF;

END $$;
