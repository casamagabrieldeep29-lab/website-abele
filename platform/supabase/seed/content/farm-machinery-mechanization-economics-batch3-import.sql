-- Farm Machinery and Mechanization, Economics, Management, and Marketing quiz batch 3 (35 questions, 1 topic).
-- Every fact, formula, and worked figure is drawn directly from agricultural
-- mechanization review material (mechanization models and institutions,
-- tillage, planting, crop protection, pumping, harvesting and threshing,
-- tractor operation and power transmission, machinery costs, and agribusiness
-- management and marketing) read in full (2026-10-05) -- no invented facts.
-- Numeric answers were independently recomputed. Every given value is stated
-- in the question text.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). No PAES clause is tested here, so every
-- question has is_paes=false and paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Farm Machinery and Mechanization, Economics, Management, and Marketing (POWER_ENERGY_MACHINERY) -- 35 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Farm Machinery and Mechanization, Economics, Management, and Marketing' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Farm Machinery and Mechanization, Economics, Management, and Marketing';
  END IF;

  -- 1. Japanese model of mechanization
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Agricultural mechanization models are grouped by the land area to farmer ratio. Which country follows the Japanese model, in which mechanization is increased mainly to raise yields and cropping intensities to meet the growing demand for food and raw materials?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Agricultural mechanization models are grouped by the land area to farmer ratio. Which country follows the Japanese model, in which mechanization is increased mainly to raise yields and cropping intensities to meet the growing demand for food and raw materials?', 'single_choice', 'easy', 'Countries with a high land area to farmer ratio (USA model: Thailand, Malaysia, Indonesia) mechanize to cultivate large lands with limited manpower. Countries with a low land area to farmer ratio (Japanese model: South Korea, China, Taiwan, Sri Lanka, and the Philippines) mechanize to increase yields and cropping intensities.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Indonesia', false, 0),
      (v_question_id, 'Thailand', false, 1),
      (v_question_id, 'Philippines', true, 2),
      (v_question_id, 'Malaysia', false, 3);
  END IF;

  -- 2. Agriculture 3.0
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which stage in the evolution of agriculture is characterized by the use of GPS, remote sensing, and Geographic Information Systems to gather data on soil, crops, and weather so that fertilizers, pesticides, and irrigation are applied only where and when needed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which stage in the evolution of agriculture is characterized by the use of GPS, remote sensing, and Geographic Information Systems to gather data on soil, crops, and weather so that fertilizers, pesticides, and irrigation are applied only where and when needed?', 'single_choice', 'medium', 'Agriculture 3.0 is the precision agriculture era (1990s). Agriculture 1.0 relied on manual and animal labor, Agriculture 2.0 introduced tractors and harvesters (mechanization and the Green Revolution), and Agriculture 4.0 is driven by IoT, artificial intelligence, robotics, and big data analytics.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agriculture 1.0', false, 0),
      (v_question_id, 'Agriculture 3.0', true, 1),
      (v_question_id, 'Agriculture 4.0', false, 2),
      (v_question_id, 'Agriculture 2.0', false, 3);
  END IF;

  -- 3. Intermediate level of mechanization
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm uses a carabao-drawn plow for land preparation and an engine-driven thresher operated by hired workers for threshing. In the qualitative levels of mechanization, this farm is operating at which level?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A farm uses a carabao-drawn plow for land preparation and an engine-driven thresher operated by hired workers for threshing. In the qualitative levels of mechanization, this farm is operating at which level?', 'single_choice', 'medium', 'Intermediate mechanization uses non-mechanical power (man and animal) in combination with a mechanical power source operated by man. Low mechanization uses only man and animal power, high mechanization uses solely mechanical power operated by man, and full mechanization uses solely mechanical power with limited intervention by man.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Intermediate mechanization', true, 0),
      (v_question_id, 'High mechanization', false, 1),
      (v_question_id, 'Low mechanization', false, 2),
      (v_question_id, 'Full mechanization', false, 3);
  END IF;

  -- 4. Primary tillage classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Chisel plows and subsoilers are used for the initial cutting, breaking, and inversion of the soil. Under the classification of tillage, to which type do they belong and what working depth range is associated with that type?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Chisel plows and subsoilers are used for the initial cutting, breaking, and inversion of the soil. Under the classification of tillage, to which type do they belong and what working depth range is associated with that type?', 'single_choice', 'medium', 'Primary tillage (commonly called plowing) involves the initial cutting, breaking, and inversion of the soil using moldboard, disc, and chisel plows and subsoilers, at a depth of 6 to 36 inches. Secondary tillage (harrowing) works at 3 to 6 inches, and general-purpose tillage (rotavating) at up to 6 inches.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'General-purpose tillage, up to 6 inches', false, 0),
      (v_question_id, 'Secondary tillage, 6 to 36 inches', false, 1),
      (v_question_id, 'Secondary tillage, 3 to 6 inches', false, 2),
      (v_question_id, 'Primary tillage, 6 to 36 inches', true, 3);
  END IF;

  -- 5. Landside of the moldboard plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a moldboard plow bottom, which part counteracts the side pressure exerted by the furrow slice on the plow bottom?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a moldboard plow bottom, which part counteracts the side pressure exerted by the furrow slice on the plow bottom?', 'single_choice', 'medium', 'The landside counteracts the side pressure exerted by the furrow slice on the plow bottom. The share provides the cutting edge, the moldboard receives the furrow slice and lifts, inverts, and throws it to one side, and the frog is the base to which the other parts are attached.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Share', false, 0),
      (v_question_id, 'Frog', false, 1),
      (v_question_id, 'Landside', true, 2),
      (v_question_id, 'Moldboard', false, 3);
  END IF;

  -- 6. Land planing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which tillage operation cuts and moves small layers of soil to provide a smooth, refined surface condition?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which tillage operation cuts and moves small layers of soil to provide a smooth, refined surface condition?', 'single_choice', 'medium', 'Land planing cuts and moves small layers of soil to give a smooth, refined surface. Land grading moves soil to establish a desired elevation and slope (leveling, contouring, cutting, filling), land forming moves soil to create desired soil configurations, and earthmoving is the tillage action and transport used to loosen, load, carry, and unload soil.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Land forming', false, 0),
      (v_question_id, 'Land grading', false, 1),
      (v_question_id, 'Earthmoving', false, 2),
      (v_question_id, 'Land planing', true, 3);
  END IF;

  -- 7. Conservation tillage residue cover
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A conservation tillage system is defined as one that maintains at least what percentage of residue cover on the soil surface after planting?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A conservation tillage system is defined as one that maintains at least what percentage of residue cover on the soil surface after planting?', 'single_choice', 'easy', 'Conservation tillage maintains a minimum of 30 percent residue cover on the soil surface after planting, or at least 1,100 kg/ha of flat small grain residue equivalent during the critical erosion period.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 percent', false, 0),
      (v_question_id, '30 percent', true, 1),
      (v_question_id, '20 percent', false, 2),
      (v_question_id, '10 percent', false, 3);
  END IF;

  -- 8. Solid drill planter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farmer wants to plant a cereal crop continuously in rows only 25 cm apart, a pattern that does not allow later entry of machinery between the rows. Which type of planter fits this requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A farmer wants to plant a cereal crop continuously in rows only 25 cm apart, a pattern that does not allow later entry of machinery between the rows. Which type of planter fits this requirement?', 'single_choice', 'medium', 'A solid drill planter plants seeds continuously in rows with row spacing less than 36 cm, so machinery cannot enter afterwards. A row-crop drill planter uses row spacing greater than 36 cm, a hill-drop planter plants one or more seeds in hills along rows, and a broadcaster scatters seeds over the surface without definite rows or hills.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Solid drill planter', true, 0),
      (v_question_id, 'Hill-drop planter', false, 1),
      (v_question_id, 'Broadcaster', false, 2),
      (v_question_id, 'Row-crop drill planter', false, 3);
  END IF;

  -- 9. Fan type nozzle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A knapsack sprayer is to be used to apply herbicide on flat ground. Which nozzle is the most suitable, and what are its pressure and orifice characteristics?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A knapsack sprayer is to be used to apply herbicide on flat ground. Which nozzle is the most suitable, and what are its pressure and orifice characteristics?', 'single_choice', 'medium', 'A fan type nozzle produces a flat spray pattern and is best suited to flat surfaces such as herbicide application; it operates at low pressure with a large orifice. A cone type nozzle (hollow or solid cone) is best for crops because droplets approach the leaves from several angles, and it works at high pressure with a small orifice.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fan type nozzle, low pressure and large orifice', true, 0),
      (v_question_id, 'Fan type nozzle, high pressure and small orifice', false, 1),
      (v_question_id, 'Cone type nozzle, low pressure and large orifice', false, 2),
      (v_question_id, 'Cone type nozzle, high pressure and small orifice', false, 3);
  END IF;

  -- 10. Theoretical suction lift
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At sea level, what is the theoretical maximum height to which a pump can lift water by suction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'At sea level, what is the theoretical maximum height to which a pump can lift water by suction?', 'single_choice', 'easy', 'At sea level atmospheric pressure is about 10,200 kg/m2, so the water column rises h = P/rho = 10,200/1,000 = 10.2 m (about 33 ft). Because of impurities and friction losses, the practical suction lift is only about 7.62 m (25 ft).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 5.0 m (16.4 ft)', false, 0),
      (v_question_id, 'About 7.62 m (25 ft)', false, 1),
      (v_question_id, 'About 15.0 m (49 ft)', false, 2),
      (v_question_id, 'About 10.2 m (33 ft)', true, 3);
  END IF;

  -- 11. Correct rice harvesting time
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following statements about determining the correct harvesting time of rice is correct?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following statements about determining the correct harvesting time of rice is correct?', 'single_choice', 'medium', 'Rice should be harvested when 80 to 85 percent of the grains per panicle have turned yellow (straw-colored), at a moisture content of 20 to 25 percent wet basis. The other statements are wrong: late-maturing varieties are harvested at 130 to 136 days after sowing (early-maturing at about 110 days), and the harvest is 28 to 35 days after heading in the dry season and 32 to 38 days in the wet season.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Early-maturing varieties should be harvested at 130 to 136 days after sowing', false, 0),
      (v_question_id, 'For the wet season, harvest 28 to 35 days after heading', false, 1),
      (v_question_id, 'Harvest when 80 to 85 percent of the grains per panicle are straw-colored', true, 2),
      (v_question_id, 'The ideal moisture content for harvesting is 30 to 35 percent wet basis', false, 3);
  END IF;

  -- 12. Axial-flow thresher
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In an axial-flow thresher, the crop enters one end of the cylinder, circles it several times, and leaves at the other end. About what proportion of the grains is separated from the straw at the cylinder, and which cylinder type is most commonly used with this thresher for rice?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In an axial-flow thresher, the crop enters one end of the cylinder, circles it several times, and leaves at the other end. About what proportion of the grains is separated from the straw at the cylinder, and which cylinder type is most commonly used with this thresher for rice?', 'single_choice', 'medium', 'In an axial-flow thresher about 90 percent of the grains are separated at the cylinder, and the peg-toothed cylinder (spikes or pegs) is the type most commonly used for rice. In a tangential-flow thresher only about 60 percent of the grains pass through the concave, and rasp-bar cylinders are used for a wide variety of crops such as peanut and other cereals because of their mild action.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 90 percent, rasp-bar cylinder', false, 0),
      (v_question_id, 'About 90 percent, peg-toothed cylinder', true, 1),
      (v_question_id, 'About 60 percent, peg-toothed cylinder', false, 2),
      (v_question_id, 'About 60 percent, wire-loop cylinder', false, 3);
  END IF;

  -- 13. Timeliness as a factor in harvesting system choice
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Delayed harvesting can cause shattering and lodging, reduce the time available for land preparation of the next crop, and cause grains to over-dry, discolor, or sprout. Which factor affecting the choice of a harvesting and threshing system does this describe?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Delayed harvesting can cause shattering and lodging, reduce the time available for land preparation of the next crop, and cause grains to over-dry, discolor, or sprout. Which factor affecting the choice of a harvesting and threshing system does this describe?', 'single_choice', 'medium', 'Timeliness of operation is a major factor in choosing a harvesting and threshing system because it affects field losses, the time available for the next crop, and grain quality. The other listed factors are the kind of crop, topography, farm size, type of culture, availability and cost of labor, and availability of capital.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Kind of crop', false, 0),
      (v_question_id, 'Topography', false, 1),
      (v_question_id, 'Farm size', false, 2),
      (v_question_id, 'Timeliness of operation', true, 3);
  END IF;

  -- 14. Gear for descending a slope
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the safest gear setting for a tractor descending a 10 percent slope?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the safest gear setting for a tractor descending a 10 percent slope?', 'single_choice', 'easy', 'On descending slopes a low gear (first gear) is used so that the engine provides braking; neutral should never be used because the tractor would roll freely.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Neutral', false, 0),
      (v_question_id, 'First gear', true, 1),
      (v_question_id, 'Second gear', false, 2),
      (v_question_id, 'Third gear', false, 3);
  END IF;

  -- 15. 5S Standardize
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor operator prepares a maintenance checklist and schedule so that oil changes, tire pressure checks, and air filter replacements are done at regular intervals by all staff. Which step of the 5S of housekeeping does this represent?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor operator prepares a maintenance checklist and schedule so that oil changes, tire pressure checks, and air filter replacements are done at regular intervals by all staff. Which step of the 5S of housekeeping does this represent?', 'single_choice', 'medium', 'Standardize (Seiketsu) creates a maintenance schedule and standard procedures for inspections and servicing so that tasks are performed consistently and breakdowns are avoided. Set in Order (Seiton) arranges tools and parts, Shine (Seiso) is cleaning, and Sustain (Shitsuke) is developing the habits and discipline to keep the system going.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sustain (Shitsuke)', false, 0),
      (v_question_id, 'Set in Order (Seiton)', false, 1),
      (v_question_id, 'Standardize (Seiketsu)', true, 2),
      (v_question_id, 'Shine (Seiso)', false, 3);
  END IF;

  -- 16. Benevolent authoritative leadership
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm manager makes the decisions alone but lets subordinates freely comment on them and gives awards for good performance. Which leadership style does the manager practice?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A farm manager makes the decisions alone but lets subordinates freely comment on them and gives awards for good performance. Which leadership style does the manager practice?', 'single_choice', 'medium', 'In the benevolent authoritative style the manager decides, subordinates are free to comment, and awards are given. Exploitative authoritative managers decide and use threats for failure, consultative managers seek input before deciding with no rewards, and in the participative style everyone gets to decide.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Benevolent authoritative', true, 0),
      (v_question_id, 'Participative', false, 1),
      (v_question_id, 'Consultative', false, 2),
      (v_question_id, 'Exploitative authoritative', false, 3);
  END IF;

  -- 17. Place utility
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A trader hauls harvested corn from a producing area to markets where it is needed. Which type of utility is created by this activity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A trader hauls harvested corn from a producing area to markets where it is needed. Which type of utility is created by this activity?', 'single_choice', 'easy', 'Place utility is created by moving products to the areas of need. Form utility changes raw materials into more useful products, time utility ensures availability when needed, and possession utility transfers ownership to those who value the product more.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Possession utility', false, 0),
      (v_question_id, 'Form utility', false, 1),
      (v_question_id, 'Place utility', true, 2),
      (v_question_id, 'Time utility', false, 3);
  END IF;

  -- 18. Variable cost of a machine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the economics of farm machinery, the cost associated with the operation of a machine, particularly the fuel and electricity consumed and the labor employed, is classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the economics of farm machinery, the cost associated with the operation of a machine, particularly the fuel and electricity consumed and the labor employed, is classified as', 'single_choice', 'easy', 'Variable cost depends on how much the machine is used and covers fuel, electricity, and labor. Fixed cost is the cost of owning the machine regardless of use, and investment cost is the sum of money required to acquire the machine.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'overhead cost', false, 0),
      (v_question_id, 'investment cost', false, 1),
      (v_question_id, 'fixed cost', false, 2),
      (v_question_id, 'variable cost', true, 3);
  END IF;

  -- 19. Operators of an AMSC
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Who may operate an Agricultural Machinery Service Center (AMSC), a facility that provides repair, maintenance, and sometimes rental or custom farming services?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Who may operate an Agricultural Machinery Service Center (AMSC), a facility that provides repair, maintenance, and sometimes rental or custom farming services?', 'single_choice', 'easy', 'An AMSC can be operated by either the private or the public sector. Private operators include cooperatives, business companies registered with the SEC and DTI, and equipment suppliers; public operators include LGUs, SCUs, and government agencies.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Private entities only', false, 0),
      (v_question_id, 'Either private entities or government', true, 1),
      (v_question_id, 'Government agencies only', false, 2),
      (v_question_id, 'Only the manufacturers of the machinery', false, 3);
  END IF;

  -- 20. Penetration pricing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dealer introduces a new brand of power tiller at a deliberately low starting price in order to gain market share quickly. Which pricing strategy is being used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A dealer introduces a new brand of power tiller at a deliberately low starting price in order to gain market share quickly. Which pricing strategy is being used?', 'single_choice', 'easy', 'Penetration pricing starts the price low to gain market share. Prestige pricing sets a high price for an image of exclusivity, bundle pricing sells in bulk, and odd-even pricing uses prices such as 99.99.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Penetration pricing', true, 0),
      (v_question_id, 'Odd-even pricing', false, 1),
      (v_question_id, 'Bundle pricing', false, 2),
      (v_question_id, 'Prestige pricing', false, 3);
  END IF;

  -- 21. Draft power of a single moldboard plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the draft horsepower required to pull a single moldboard plow in a clay loam soil with a width of cut of 30 cm and a depth of cut of 15 cm, if the soil draft is 8 psi (pounds per square inch) and the average speed is 5 kph? Use 1 kg = 2.2 lb, 1 in = 2.54 cm, and 1 hp = 76.2 kg-m/s.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the draft horsepower required to pull a single moldboard plow in a clay loam soil with a width of cut of 30 cm and a depth of cut of 15 cm, if the soil draft is 8 psi (pounds per square inch) and the average speed is 5 kph? Use 1 kg = 2.2 lb, 1 in = 2.54 cm, and 1 hp = 76.2 kg-m/s.', 'single_choice', 'hard', 'Given: width 30 cm, depth 15 cm, soil draft 8 psi, speed 5 kph. Cut area = 30 x 15 = 450 cm2 = 69.75 in2. Draft F = 8 lb/in2 x 69.75 in2 = 558 lb = 253.6 kg. Speed = 5,000 m / 3,600 s = 1.389 m/s. DHP = F x S / 76.2 = (253.6)(1.389)/76.2 = 4.6 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.4 hp', false, 0),
      (v_question_id, '4.6 hp', true, 1),
      (v_question_id, '2.3 hp', false, 2),
      (v_question_id, '9.2 hp', false, 3);
  END IF;

  -- 22. Disc angle from swath of a power tiller
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A power tiller with disc plows 0.30 m in diameter is tested on a plot 12 m wide. The machine completes the plowing in 25 rounds. Using swath = plot width / (2 x number of rounds) and disc angle = sin-1 (swath / disc diameter), what is the disc angle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A power tiller with disc plows 0.30 m in diameter is tested on a plot 12 m wide. The machine completes the plowing in 25 rounds. Using swath = plot width / (2 x number of rounds) and disc angle = sin-1 (swath / disc diameter), what is the disc angle?', 'single_choice', 'hard', 'Given: plot width 12 m, 25 rounds, disc diameter 0.30 m. Swath = 12 / (2 x 25) = 0.24 m. Disc angle = sin-1 (0.24 / 0.30) = sin-1 (0.80) = 53.1 degrees.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '36.9 degrees', false, 0),
      (v_question_id, '38.7 degrees', false, 1),
      (v_question_id, '53.1 degrees', true, 2),
      (v_question_id, '45.0 degrees', false, 3);
  END IF;

  -- 23. Cutting width of a tandem disc harrow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The cutting width of a tandem disc harrow is given by W = 0.95NS + 1.2D, where N is the number of disks, S is the disk spacing, and D is the disk diameter. What is the cutting width of a tandem disc harrow with 16 disks spaced 25 cm apart and a disk diameter of 50 cm?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The cutting width of a tandem disc harrow is given by W = 0.95NS + 1.2D, where N is the number of disks, S is the disk spacing, and D is the disk diameter. What is the cutting width of a tandem disc harrow with 16 disks spaced 25 cm apart and a disk diameter of 50 cm?', 'single_choice', 'medium', 'Given: N = 16, S = 25 cm, D = 50 cm. W = 0.95(16)(25) + 1.2(50) = 380 + 60 = 440 cm = 4.40 m. The other widths come from the single-action (0.3D), offset (0.6D), and double offset (0.85D) formulas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.40 m', true, 0),
      (v_question_id, '4.23 m', false, 1),
      (v_question_id, '4.10 m', false, 2),
      (v_question_id, '3.95 m', false, 3);
  END IF;

  -- 24. Seeds per hill for a target plant population
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A corn field is to be planted to a population of 68,000 plants per hectare. The rows are 0.75 m apart, the hills are 0.50 m apart, and an average emergence of 85 percent is expected. Using expected plant population = (10,000 m2/ha)(seeds per hill)(emergence) / (row spacing x hill spacing), how many seeds per hill should be planted?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A corn field is to be planted to a population of 68,000 plants per hectare. The rows are 0.75 m apart, the hills are 0.50 m apart, and an average emergence of 85 percent is expected. Using expected plant population = (10,000 m2/ha)(seeds per hill)(emergence) / (row spacing x hill spacing), how many seeds per hill should be planted?', 'single_choice', 'medium', 'Given: EPP = 68,000 plants/ha, row spacing 0.75 m, hill spacing 0.50 m, emergence 0.85. 68,000 = (10,000)(seeds per hill)(0.85) / (0.75 x 0.50) = 22,666.7 x (seeds per hill). Seeds per hill = 3.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 seeds per hill', false, 0),
      (v_question_id, '5 seeds per hill', false, 1),
      (v_question_id, '2 seeds per hill', false, 2),
      (v_question_id, '3 seeds per hill', true, 3);
  END IF;

  -- 25. Seeding rate of a grain drill from calibration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A grain drill has 9 rows spaced 6 inches apart and a ground wheel 1.22 m in diameter. In a calibration test, the ground wheel was turned 10 revolutions and the drill discharged 1,100 g of seed at the full adjustment setting. Using 1 in = 0.0254 m, what seeding rate in kg/ha does the full setting give?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A grain drill has 9 rows spaced 6 inches apart and a ground wheel 1.22 m in diameter. In a calibration test, the ground wheel was turned 10 revolutions and the drill discharged 1,100 g of seed at the full adjustment setting. Using 1 in = 0.0254 m, what seeding rate in kg/ha does the full setting give?', 'single_choice', 'hard', 'Given: 9 rows x 6 in spacing, ground wheel D = 1.22 m, 10 revolutions, discharge 1,100 g = 1.1 kg. Width = 9 x 6 x 0.0254 = 1.3716 m. Distance = pi(1.22)(10) = 38.33 m. Area = 1.3716 x 38.33 = 52.57 m2. Seeding rate = 1.1 kg x 10,000 / 52.57 = 209.2 kg/ha.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '657.4 kg/ha', false, 0),
      (v_question_id, '418.5 kg/ha', false, 1),
      (v_question_id, '209.2 kg/ha', true, 2),
      (v_question_id, '104.6 kg/ha', false, 3);
  END IF;

  -- 26. Required pump capacity of a tractor-mounted sprayer
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor-mounted sprayer with 12 nozzles spaced 20 inches apart is to apply 200 gallons per hectare at a forward speed of 6 kph. Use field capacity (ha/hr) = speed (kph) x width (m) x efficiency (decimal) / 10, take efficiency as 1.0, and 1 in = 0.0254 m. What pump capacity in gallons per minute is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor-mounted sprayer with 12 nozzles spaced 20 inches apart is to apply 200 gallons per hectare at a forward speed of 6 kph. Use field capacity (ha/hr) = speed (kph) x width (m) x efficiency (decimal) / 10, take efficiency as 1.0, and 1 in = 0.0254 m. What pump capacity in gallons per minute is required?', 'single_choice', 'medium', 'Given: 12 nozzles x 20 in, rate 200 gal/ha, speed 6 kph. Swath = 12 x 20 x 0.0254 = 6.096 m. FC = (6)(6.096)(1.0)/10 = 3.658 ha/hr. Q = application rate x FC = 200 x 3.658 = 731.5 gal/hr = 12.2 gpm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12.2 gpm', true, 0),
      (v_question_id, '6.1 gpm', false, 1),
      (v_question_id, '1.02 gpm', false, 2),
      (v_question_id, '24.4 gpm', false, 3);
  END IF;

  -- 27. Chemical to mix per knapsack load
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 20-liter knapsack sprayer is calibrated with a nozzle discharge of 1.0 L/min, a swath of 2 m, and a walking speed of 25 m/min. The recommended chemical application rate is 3 kg/ha. How much chemical should be mixed with water for each full tank (load)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 20-liter knapsack sprayer is calibrated with a nozzle discharge of 1.0 L/min, a swath of 2 m, and a walking speed of 25 m/min. The recommended chemical application rate is 3 kg/ha. How much chemical should be mixed with water for each full tank (load)?', 'single_choice', 'hard', 'Given: tank 20 L, discharge 1.0 L/min, swath 2 m, speed 25 m/min, chemical rate 3 kg/ha. Water applied = 10,000 m2 x 1.0 / (2 x 25) = 200 L/ha. One tank covers 20 / 200 = 0.1 ha. Chemical per load = 0.1 ha x 3 kg/ha = 0.3 kg = 300 g.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '150 g per load', false, 0),
      (v_question_id, '300 g per load', true, 1),
      (v_question_id, '3,000 g per load', false, 2),
      (v_question_id, '600 g per load', false, 3);
  END IF;

  -- 28. Power to drive a pump from a river
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Water is pumped at 800 gpm from a river to a farm 120 ft above the river. Friction and other losses equal 25 percent of the static head and the pump efficiency is 65 percent. Using P (hp) = Q(gpm) x H(ft) / (3960 x efficiency), what horsepower is required to drive the pump?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Water is pumped at 800 gpm from a river to a farm 120 ft above the river. Friction and other losses equal 25 percent of the static head and the pump efficiency is 65 percent. Using P (hp) = Q(gpm) x H(ft) / (3960 x efficiency), what horsepower is required to drive the pump?', 'single_choice', 'medium', 'Given: Q = 800 gpm, static head 120 ft, losses 25 percent of static head, efficiency 0.65. Total head H = 120 + 0.25(120) = 150 ft. P = (800)(150) / (3960 x 0.65) = 120,000 / 2,574 = 46.6 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '55.9 hp', false, 0),
      (v_question_id, '37.3 hp', false, 1),
      (v_question_id, '30.3 hp', false, 2),
      (v_question_id, '46.6 hp', true, 3);
  END IF;

  -- 29. Length of a cross belt drive
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The length of a cross belt is L = 2C + 1.57(D1 + D2) + (D1 + D2)^2 / (4C), where C is the center-to-center distance of the shafts, D1 is the larger pulley diameter, and D2 is the smaller pulley diameter. What is the length of a cross belt for pulleys of 30 inches and 10 inches in diameter whose shafts are 50 inches apart?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The length of a cross belt is L = 2C + 1.57(D1 + D2) + (D1 + D2)^2 / (4C), where C is the center-to-center distance of the shafts, D1 is the larger pulley diameter, and D2 is the smaller pulley diameter. What is the length of a cross belt for pulleys of 30 inches and 10 inches in diameter whose shafts are 50 inches apart?', 'single_choice', 'medium', 'Given: D1 = 30 in, D2 = 10 in, C = 50 in. L = 2(50) + 1.57(30 + 10) + (30 + 10)^2 / (4 x 50) = 100 + 62.8 + 1,600/200 = 100 + 62.8 + 8 = 170.8 in.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '170.8 in', true, 0),
      (v_question_id, '162.8 in', false, 1),
      (v_question_id, '178.8 in', false, 2),
      (v_question_id, '164.8 in', false, 3);
  END IF;

  -- 30. Crankshaft to rear axle speed ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor engine runs at 2,200 rpm and the tractor must travel at 6 kph. The rear wheels are 1.5 m in diameter. What overall speed ratio between the engine crankshaft and the rear axle is required? (Speed ratio = engine rpm / ground wheel rpm; wheel travel per revolution = pi x D.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor engine runs at 2,200 rpm and the tractor must travel at 6 kph. The rear wheels are 1.5 m in diameter. What overall speed ratio between the engine crankshaft and the rear axle is required? (Speed ratio = engine rpm / ground wheel rpm; wheel travel per revolution = pi x D.)', 'single_choice', 'hard', 'Given: engine 2,200 rpm, travel speed 6 kph, rear wheel D = 1.5 m. Travel speed = 6,000 m/hr / 60 = 100 m/min. Wheel circumference = pi(1.5) = 4.712 m, so wheel rpm = 100 / 4.712 = 21.22 rpm. Speed ratio = 2,200 / 21.22 = 103.7 : 1.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '51.8 : 1', false, 0),
      (v_question_id, '207.3 : 1', false, 1),
      (v_question_id, '33.0 : 1', false, 2),
      (v_question_id, '103.7 : 1', true, 3);
  END IF;

  -- 31. Field efficiency of a self-propelled combine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 6-m self-propelled combine harvests a 24-ha field at an operating speed of 4 kph. The rice yield of the field is 30 tons, the grain tank holds 2 tons, and the combine stops for 5 minutes each time the tank is unloaded. The field is 500 m long and the combine takes 15 seconds to turn at the headland at the end of each pass. Use theoretical field capacity = speed x width / 10. What is the field efficiency of the combine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 6-m self-propelled combine harvests a 24-ha field at an operating speed of 4 kph. The rice yield of the field is 30 tons, the grain tank holds 2 tons, and the combine stops for 5 minutes each time the tank is unloaded. The field is 500 m long and the combine takes 15 seconds to turn at the headland at the end of each pass. Use theoretical field capacity = speed x width / 10. What is the field efficiency of the combine?', 'single_choice', 'hard', 'Given: W = 6 m, 24 ha, S = 4 kph, yield 30 tons, tank 2 tons, unloading stop 5 min, field length 500 m, turn 15 s. TFC = (4)(6)/10 = 2.4 ha/hr. Number of passes = (24 ha x 10,000 / 500 m) / 6 m = 80. Working time t1 = 80 x 0.5 km / 4 kph = 10 hr. Turning t2 = 80 x 15 s = 1,200 s = 0.333 hr. Unloading t3 = (30/2) x 5 min = 75 min = 1.25 hr. Total T = 11.58 hr. AFC = 24 / 11.58 = 2.07 ha/hr. Efficiency = 2.07 / 2.4 = 86.3 percent.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '96.8 percent', false, 0),
      (v_question_id, '77.9 percent', false, 1),
      (v_question_id, '86.3 percent', true, 2),
      (v_question_id, '88.9 percent', false, 3);
  END IF;

  -- 32. Water requirement of lowland rice per hectare
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rule of thumb states that a lowland rice crop needs approximately 10 mm of water per day. How much water in cubic meters per hectare will a rice variety that matures in 120 days require? (1 ha = 10,000 m2)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rule of thumb states that a lowland rice crop needs approximately 10 mm of water per day. How much water in cubic meters per hectare will a rice variety that matures in 120 days require? (1 ha = 10,000 m2)', 'single_choice', 'easy', 'Given: 10 mm/day for 120 days. Total depth = 10 x 120 = 1,200 mm = 1.2 m. Volume per hectare = 1.2 m x 10,000 m2 = 12,000 m3.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120,000 m3/ha', false, 0),
      (v_question_id, '12,000 m3/ha', true, 1),
      (v_question_id, '1,200 m3/ha', false, 2),
      (v_question_id, '6,000 m3/ha', false, 3);
  END IF;

  -- 33. Quick ratio of a farm business
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm business has current assets of 480,000 pesos, of which 180,000 pesos is inventory, and current liabilities of 200,000 pesos. Using quick (acid test) ratio = (current assets - inventory) / current liabilities, what is its quick ratio?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A farm business has current assets of 480,000 pesos, of which 180,000 pesos is inventory, and current liabilities of 200,000 pesos. Using quick (acid test) ratio = (current assets - inventory) / current liabilities, what is its quick ratio?', 'single_choice', 'medium', 'Given: current assets 480,000; inventory 180,000; current liabilities 200,000. Quick ratio = (480,000 - 180,000) / 200,000 = 300,000 / 200,000 = 1.5. This is the ability to pay short-term liabilities without selling inventory (compare the current ratio of 2.4).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.4', false, 0),
      (v_question_id, '1.4', false, 1),
      (v_question_id, '1.5', true, 2),
      (v_question_id, '0.63', false, 3);
  END IF;

  -- 34. Return on investment of a machine
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cooperative buys a rice mill for 360,000 pesos that earns an annual net return of 54,000 pesos. Return on investment is the return divided by the cost of the investment times 100. What is the return on investment?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A cooperative buys a rice mill for 360,000 pesos that earns an annual net return of 54,000 pesos. Return on investment is the return divided by the cost of the investment times 100. What is the return on investment?', 'single_choice', 'medium', 'Given: investment 360,000 pesos; annual return 54,000 pesos. ROI = (54,000 / 360,000) x 100 = 15 percent.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15 percent', true, 0),
      (v_question_id, '6.7 percent', false, 1),
      (v_question_id, '150 percent', false, 2),
      (v_question_id, '85 percent', false, 3);
  END IF;

  -- 35. Mechanization level in hp per hectare
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The level of mechanization of an area can be expressed as installed power per hectare (hp/ha). A 400-ha farm owns 5 four-wheel tractors rated 80 hp each and 12 power tillers rated 10 hp each. What is its level of mechanization?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The level of mechanization of an area can be expressed as installed power per hectare (hp/ha). A 400-ha farm owns 5 four-wheel tractors rated 80 hp each and 12 power tillers rated 10 hp each. What is its level of mechanization?', 'single_choice', 'medium', 'Given: 5 tractors x 80 hp = 400 hp; 12 power tillers x 10 hp = 120 hp; area 400 ha. Total power = 520 hp. Mechanization level = 520 / 400 = 1.30 hp/ha.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.00 hp/ha', false, 0),
      (v_question_id, '1.30 hp/ha', true, 1),
      (v_question_id, '0.30 hp/ha', false, 2),
      (v_question_id, '0.77 hp/ha', false, 3);
  END IF;
END $$;
