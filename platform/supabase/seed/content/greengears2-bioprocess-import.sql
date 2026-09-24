-- Auto-generated from supabase/seed/content/greengears2-bioprocess.json — Bioprocess/Food Engineering deck (154 questions, 6 topics)
-- Idempotent: safe to re-run; skips questions that already exist (matched by topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left NULL (no source attribution stored).
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Design and Management of AB Processing System (BIOPROCESS) — 13 question(s)
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
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Design and Management of AB Processing System', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The expression used to indicate the amount of bran removed in the milling process.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The expression used to indicate the amount of bran removed in the milling process.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Milling percentage', false, 0),
      (v_question_id, 'Head rice recovery', false, 1),
      (v_question_id, 'Bran recovery', false, 2),
      (v_question_id, 'Milling degree', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dried paddy sample was milled using a rubber roll laboratory rice mill. After milling, the weight of the whole milled grains, broken milled, and rice husk were 34 g, 298 g, and 189 g respectively. The milled rice was classified as Class A. Determine the percent head rice.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A dried paddy sample was milled using a rubber roll laboratory rice mill. After milling, the weight of the whole milled grains, broken milled, and rice husk were 34 g, 298 g, and 189 g respectively. The milled rice was classified as Class A. Determine the percent head rice.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.13%', false, 0),
      (v_question_id, '6.29%', false, 1),
      (v_question_id, '6.53%', true, 2),
      (v_question_id, '5.57%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is the most important factor in selecting a location for agricultural processing facility expansion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which of the following is the most important factor in selecting a location for agricultural processing facility expansion?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Presence of accessible roads for transport', false, 0),
      (v_question_id, 'Proximity to consumers and markets', false, 1),
      (v_question_id, 'Availability of raw materials and utilities', true, 2),
      (v_question_id, 'Availability of laborers and workers', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Regular milled rice has how many percent of bran removed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Regular milled rice has how many percent of bran removed?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25%', false, 0),
      (v_question_id, '50%', true, 1),
      (v_question_id, '75%', false, 2),
      (v_question_id, '100%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Five tons of paddy milled in 6 hrs produce 3950 kgs of brown rice and 3250 kgs of milled rice. If the head rice recovery is 85 %, what is the amount of broken grains?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Five tons of paddy milled in 6 hrs produce 3950 kgs of brown rice and 3250 kgs of milled rice. If the head rice recovery is 85 %, what is the amount of broken grains?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '487.50 kg', true, 0),
      (v_question_id, '521.4 kg', false, 1),
      (v_question_id, '473.89 kg', false, 2),
      (v_question_id, '535.18 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A local process or series of processes used to improve, alter, or preserve agricultural, fishery, and forestry products. This includes activities like cleaning, sorting, grading, processing, packaging, and transporting these products.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A local process or series of processes used to improve, alter, or preserve agricultural, fishery, and forestry products. This includes activities like cleaning, sorting, grading, processing, packaging, and transporting these products.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agricultural and bio-processing', false, 0),
      (v_question_id, 'Postharvest processing', false, 1),
      (v_question_id, 'Agro-industrial processing', true, 2),
      (v_question_id, 'Primary processing', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farmer-trader pays P9.00 per kilogram for a palay with moisture content of 24% wet basis and purity 80%. After passing it through the cleaner, the purity became 95%. Moreover, the former used open sun drying to dry the palay to 14% wet basis. Determine how much should the farmer-trader sell her clean dried palay if she wants to have a profit of P0.40 per kilogram clean dried palay. Assume a processing fee of P0.30 per kilogram clean dried palay';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A farmer-trader pays P9.00 per kilogram for a palay with moisture content of 24% wet basis and purity 80%. After passing it through the cleaner, the purity became 95%. Moreover, the former used open sun drying to dry the palay to 14% wet basis. Determine how much should the farmer-trader sell her clean dried palay if she wants to have a profit of P0.40 per kilogram clean dried palay. Assume a processing fee of P0.30 per kilogram clean dried palay', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Php 12.80/kg', true, 0),
      (v_question_id, 'Php 14.50/kg', false, 1),
      (v_question_id, 'Php 11.20/kg', false, 2),
      (v_question_id, 'Php 13.80/kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This rice grade meets the lowest grade requirement for milled rice.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This rice grade meets the lowest grade requirement for milled rice.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Grade 4', false, 0),
      (v_question_id, 'Grade 5', true, 1),
      (v_question_id, 'Grade 6', false, 2),
      (v_question_id, 'Grade 7', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A procedure developed for designing, checking, and maintaining machines, equipment, and the product quality to carry out acceptable procedures and products is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A procedure developed for designing, checking, and maintaining machines, equipment, and the product quality to carry out acceptable procedures and products is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Manufacturing', false, 0),
      (v_question_id, 'Fabrication', false, 1),
      (v_question_id, 'Work simulation', false, 2),
      (v_question_id, 'Standardization', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This allows the movement of nutrients from the bran layer to the inner part of the grain thus making the vitamins available to the milled rice.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This allows the movement of nutrients from the bran layer to the inner part of the grain thus making the vitamins available to the milled rice.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Polishing', false, 0),
      (v_question_id, 'Nutrient soaking', false, 1),
      (v_question_id, 'Tempering', false, 2),
      (v_question_id, 'Parboiling', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A milled rice particle with length ranging from 3/8 to 6/8 of the whole length of the grain.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A milled rice particle with length ranging from 3/8 to 6/8 of the whole length of the grain.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Head rice', false, 0),
      (v_question_id, 'Large broken', true, 1),
      (v_question_id, 'Small broken', false, 2),
      (v_question_id, 'Brewer''s rice', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rice kernels from which only the hull has been removed and with the bran layer still intact.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Rice kernels from which only the hull has been removed and with the bran layer still intact.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Brown rice', false, 0),
      (v_question_id, 'Dehulled rice', false, 1),
      (v_question_id, 'Cargo rice', false, 2),
      (v_question_id, 'All of the above', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is suitable for many biomass fuel, can gasify wet fuel, and does not require any specific fuel size.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is suitable for many biomass fuel, can gasify wet fuel, and does not require any specific fuel size.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Updraft', true, 0),
      (v_question_id, 'Downdraft', false, 1),
      (v_question_id, 'Cross-draft', false, 2),
      (v_question_id, 'Fluidized bed', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Elements of Food Processing and Process Design (BIOPROCESS) — 41 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Elements of Food Processing and Process Design' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Elements of Food Processing and Process Design', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which among the following is the most appropriate reason for storing green mangoes at low temperature?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which among the following is the most appropriate reason for storing green mangoes at low temperature?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The photosynthetic rate is reduced', false, 0),
      (v_question_id, 'Respiration and photosynthesis are completely inhibited, prolonging shelf-life of green mangoes', false, 1),
      (v_question_id, 'The respiration rate is reduced', true, 2),
      (v_question_id, 'The rate of respiration and photosynthesis are reduced', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The process of separation of product into various quality fractions that may be defined on the basis of size, shape, density, texture, and color is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The process of separation of product into various quality fractions that may be defined on the basis of size, shape, density, texture, and color is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blending', false, 0),
      (v_question_id, 'Grading', false, 1),
      (v_question_id, 'Fractionating', false, 2),
      (v_question_id, 'Sorting', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a controlled atmosphere storage, the X is reduced, and the Y level is increased.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a controlled atmosphere storage, the X is reduced, and the Y level is increased.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'X = carbon dioxide, Y = oxygen', false, 0),
      (v_question_id, 'X = nitrogen, Y = carbon dioxide', false, 1),
      (v_question_id, 'X = oxygen, Y = nitrogen', false, 2),
      (v_question_id, 'X = oxygen, Y = carbon dioxide', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is one of the most renowned and well-established quality management system in the food sector and focuses on food safety management for all food produces, and it involves the ability of companies to control hazards in terms of food safety to conform to the regulatory requirements and to communicate food safety issues to all involved stakeholders.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is one of the most renowned and well-established quality management system in the food sector and focuses on food safety management for all food produces, and it involves the ability of companies to control hazards in terms of food safety to conform to the regulatory requirements and to communicate food safety issues to all involved stakeholders.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ISO 22000', true, 0),
      (v_question_id, 'ISO 9001:2015', false, 1),
      (v_question_id, 'British Retail Consortium', false, 2),
      (v_question_id, 'Hazard Analysis and Critical Control Points', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Suppose you are working in a food processing plant. A contamination had spread in the facility. As an engineer, what must be the first thing that you should do?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Suppose you are working in a food processing plant. A contamination had spread in the facility. As an engineer, what must be the first thing that you should do?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Monitor the critical control points', false, 0),
      (v_question_id, 'Conduct clearing in the food processing plant', false, 1),
      (v_question_id, 'Find the source of contamination', true, 2),
      (v_question_id, 'Determine the hazards in the area', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the fifth principle in the seven principles of HACCP?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the fifth principle in the seven principles of HACCP?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Establish corrective measures', true, 0),
      (v_question_id, 'Establish critical limits', false, 1),
      (v_question_id, 'Establish verification procedures', false, 2),
      (v_question_id, 'Determine the critical control points', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the maximum/minimum value to which a biological, chemical, or physical parameter must be controlled to prevent, eliminate, or reduce to an acceptable level the occurrence of a food safety hazard.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the maximum/minimum value to which a biological, chemical, or physical parameter must be controlled to prevent, eliminate, or reduce to an acceptable level the occurrence of a food safety hazard.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Critical control point', false, 0),
      (v_question_id, 'Critical limits', true, 1),
      (v_question_id, 'Deviation', false, 2),
      (v_question_id, 'Control measure', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are set of guidelines and regulations that ensure hygienic and controlled manufacturing processes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are set of guidelines and regulations that ensure hygienic and controlled manufacturing processes.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hazard Analysis Critical Control Points', false, 0),
      (v_question_id, 'ISO 9001:2015', false, 1),
      (v_question_id, 'Good Manufacturing Practices', true, 2),
      (v_question_id, 'Sanitation Standard Operating Procedures', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which food safety system focuses on analyzing potential hazards at each step of production and implementing controls to prevent contamination?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which food safety system focuses on analyzing potential hazards at each step of production and implementing controls to prevent contamination?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hazard Analysis Critical Control Points', true, 0),
      (v_question_id, 'ISO 9001:2015', false, 1),
      (v_question_id, 'Good Manufacturing Practices', false, 2),
      (v_question_id, 'Sanitation Standard Operating Procedures', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which program is designed to regularly check the processing environment for microbial hazards and ensure sanitary conditions are maintained?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which program is designed to regularly check the processing environment for microbial hazards and ensure sanitary conditions are maintained?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Environmental monitoring program', true, 0),
      (v_question_id, 'Good manufacturing practices', false, 1),
      (v_question_id, 'Sanitation Standard Operating Procedures', false, 2),
      (v_question_id, 'Hazard Analysis Critical Control Points', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a United States Food and Drug Administration designation that a chemical or substance added to food is considered safe by experts under the conditions of its intended uses.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a United States Food and Drug Administration designation that a chemical or substance added to food is considered safe by experts under the conditions of its intended uses.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'HRPS', false, 0),
      (v_question_id, 'GRAS', true, 1),
      (v_question_id, 'PRTS', false, 2),
      (v_question_id, 'GMTS', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What specific Sustainable Development Goal (SDG) is ensuring access to food, ending malnutrition, and sustainable food production fall into?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What specific Sustainable Development Goal (SDG) is ensuring access to food, ending malnutrition, and sustainable food production fall into?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'SDG 1', false, 0),
      (v_question_id, 'SDG 2', true, 1),
      (v_question_id, 'SDG 9', false, 2),
      (v_question_id, 'SDG 13', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is not a part of the processes involved in the mechanical separations in food processing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which of the following is not a part of the processes involved in the mechanical separations in food processing?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Screening', false, 0),
      (v_question_id, 'Centrifugation', false, 1),
      (v_question_id, 'Agglomeration', true, 2),
      (v_question_id, 'Mechanical expression', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is one method of improving the storage quality of fruits and vegetables to extending their shelf-life?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is one method of improving the storage quality of fruits and vegetables to extending their shelf-life?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reduce air circulation within the storage facility', false, 0),
      (v_question_id, 'Control relative humidity and temperature according to its needs', true, 1),
      (v_question_id, 'Use non-ventilated storage rooms to prevent moisture loss', false, 2),
      (v_question_id, 'Decrease the storage temperature in the facility', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of microorganism is most commonly responsible for the spoilage of fruits and vegetables?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which type of microorganism is most commonly responsible for the spoilage of fruits and vegetables?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bacteria', false, 0),
      (v_question_id, 'Viruses', false, 1),
      (v_question_id, 'Yeast', false, 2),
      (v_question_id, 'Fungi', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are food that is lost at the retail or consumer levels. This can occur at grocery stores, restaurants, and in consumers'' homes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are food that is lost at the retail or consumer levels. This can occur at grocery stores, restaurants, and in consumers'' homes.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Food loss', false, 0),
      (v_question_id, 'Food waste', true, 1),
      (v_question_id, 'Food consumption', false, 2),
      (v_question_id, 'Food dump', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What water activity value does proliferation of yeasts start in food products?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What water activity value does proliferation of yeasts start in food products?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.6', false, 0),
      (v_question_id, '0.7', true, 1),
      (v_question_id, '0.8', false, 2),
      (v_question_id, '0.9', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This law of size reduction states that the energy required to reduce the size of particles is proportional to the ratio of the initial size of a typical dimension to the final size of that dimension.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This law of size reduction states that the energy required to reduce the size of particles is proportional to the ratio of the initial size of a typical dimension to the final size of that dimension.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Kick''s Law', true, 0),
      (v_question_id, 'Rittinger''s Law', false, 1),
      (v_question_id, 'Bond''s Law', false, 2),
      (v_question_id, 'Fourier''s Law', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A company exports mangoes to China. However, upon inspection, it was identified that some mangoes are already infected with Anthracnose disease. As an ABE, what is the best procedure you should use to address the problem?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A company exports mangoes to China. However, upon inspection, it was identified that some mangoes are already infected with Anthracnose disease. As an ABE, what is the best procedure you should use to address the problem?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Use of ethylene gas', false, 0),
      (v_question_id, 'Controlled atmosphere packaging', false, 1),
      (v_question_id, 'Hot water treatment', true, 2),
      (v_question_id, 'Fumigation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Industrial bottling of virgin coconut oil prints a batch number. What is the main purpose of this batch number?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Industrial bottling of virgin coconut oil prints a batch number. What is the main purpose of this batch number?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bottle identification', false, 0),
      (v_question_id, 'Expiry indicator', false, 1),
      (v_question_id, 'Serial number', false, 2),
      (v_question_id, 'Product recall', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are the component elements of food security, except for one:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The following are the component elements of food security, except for one:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Development', true, 0),
      (v_question_id, 'Availability', false, 1),
      (v_question_id, 'Utilization', false, 2),
      (v_question_id, 'Access', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of packaging that interacts with the product and its environment to extend shelf-life and maintain quality of products.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of packaging that interacts with the product and its environment to extend shelf-life and maintain quality of products.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Smart packaging', false, 0),
      (v_question_id, 'Active packaging', true, 1),
      (v_question_id, 'Modified atmosphere packaging', false, 2),
      (v_question_id, 'Bio-composite packaging', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'To aid in recycling, a number is placed inside the recycle logo to identify what plastic the material is. What type of plastic does the number 4 indicate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'To aid in recycling, a number is placed inside the recycle logo to identify what plastic the material is. What type of plastic does the number 4 indicate?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PET', false, 0),
      (v_question_id, 'HDPE', false, 1),
      (v_question_id, 'LDPE', true, 2),
      (v_question_id, 'PP', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are natural polysaccharides used as biological sources of biodegradable film directly extracted from red and purple seaweeds.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are natural polysaccharides used as biological sources of biodegradable film directly extracted from red and purple seaweeds.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Chitosan', false, 0),
      (v_question_id, 'Alginates', false, 1),
      (v_question_id, 'Carrageenan', true, 2),
      (v_question_id, 'Cellulose', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The process of destroying most disease-producing microorganisms and limiting fermentation in milk or other liquids by heating a foodstuff for a definite time and temperature.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The process of destroying most disease-producing microorganisms and limiting fermentation in milk or other liquids by heating a foodstuff for a definite time and temperature.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hot water treatment', false, 0),
      (v_question_id, 'Pasteurization', true, 1),
      (v_question_id, 'Evaporation', false, 2),
      (v_question_id, 'Irradiation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fresh milk of high purity to be delivered to the consumer within 36 hours. The number of bacteria is 10,000 counts or less per mL.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Fresh milk of high purity to be delivered to the consumer within 36 hours. The number of bacteria is 10,000 counts or less per mL.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Certified milk', true, 0),
      (v_question_id, 'Evaporated milk', false, 1),
      (v_question_id, 'Condensed milk', false, 2),
      (v_question_id, 'Powder milk', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a milk where the butterfat is replaced with vegetable fat such as coconut fat.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a milk where the butterfat is replaced with vegetable fat such as coconut fat.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Certified milk', false, 0),
      (v_question_id, 'Evaporated milk', false, 1),
      (v_question_id, 'Condensed milk', false, 2),
      (v_question_id, 'Filled milk', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fresh milk heated to a temperature of not lower than 145 degrees Fahrenheit for a period of not less than 30 minutes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A fresh milk heated to a temperature of not lower than 145 degrees Fahrenheit for a period of not less than 30 minutes.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reconstituted milk', false, 0),
      (v_question_id, 'Homogenized milk', false, 1),
      (v_question_id, 'Pasteurized milk', true, 2),
      (v_question_id, 'Recombined milk', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 418:2002, washing of tomato is done by using _____% chlorox solution applied by dipping, spraying, or wiping with a damp cloth then drying the fruit before packing.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Under PAES 418:2002, washing of tomato is done by using _____% chlorox solution applied by dipping, spraying, or wiping with a damp cloth then drying the fruit before packing.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5%', false, 0),
      (v_question_id, '1%', true, 1),
      (v_question_id, '1.5%', false, 2),
      (v_question_id, '2%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The toxin produced by some strain of the fungi Aspergillus flavus and Aspergillus parasitum, the most potent carcinogen yet discovered is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The toxin produced by some strain of the fungi Aspergillus flavus and Aspergillus parasitum, the most potent carcinogen yet discovered is called', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aflatoxin', true, 0),
      (v_question_id, 'Hydrophilic toxin', false, 1),
      (v_question_id, 'Fusarium toxin', false, 2),
      (v_question_id, 'Mycotoxin', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The core components of Good Manufacturing Practices are composed of 5P''s, which highlights the critical areas of focus for maintaining quality in manufacturing. What are these 5P''s?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The core components of Good Manufacturing Practices are composed of 5P''s, which highlights the critical areas of focus for maintaining quality in manufacturing. What are these 5P''s?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'People, Products, Processes, Procedures, Premises', true, 0),
      (v_question_id, 'People, Processes, Procedures, Personality, Products', false, 1),
      (v_question_id, 'People, Premises, Personality, Production, Procedures', false, 2),
      (v_question_id, 'People, Products, Premises, Production, Procedures', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This GMP principle is crucial for maintaining the integrity of the manufacturing processes and ensuring product quality and safety.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This GMP principle is crucial for maintaining the integrity of the manufacturing processes and ensuring product quality and safety.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Creating SOPs', false, 0),
      (v_question_id, 'Document procedures and processes', false, 1),
      (v_question_id, 'Implement and enforce SOPs', false, 2),
      (v_question_id, 'Validate the effectiveness of the SOPs', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This GMP principle is crucial for the continual improvement and maintaining regulatory compliances.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This GMP principle is crucial for the continual improvement and maintaining regulatory compliances.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Develop job competence of workers', false, 0),
      (v_question_id, 'Conduct GMP audits regularly', true, 1),
      (v_question_id, 'Implement and enforce SOPs', false, 2),
      (v_question_id, 'Prioritize quality and integrate it in the workflow', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are written procedures that an establishment develops and implements to prevent direct contamination and adulteration of products.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are written procedures that an establishment develops and implements to prevent direct contamination and adulteration of products.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'SSOP', true, 0),
      (v_question_id, 'GMP', false, 1),
      (v_question_id, 'HACCP', false, 2),
      (v_question_id, 'ISO 2200', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The ISO is an independent, non-governmental, internal standard development organization for quality management. What does ISO stand for?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The ISO is an independent, non-governmental, internal standard development organization for quality management. What does ISO stand for?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'International Standard Organization', false, 0),
      (v_question_id, 'Internal Organization for Standardization', true, 1),
      (v_question_id, 'International Standardization Organization', false, 2),
      (v_question_id, 'International Organization for Standards', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Related ISO quality management standards are based from these seven Quality Management Principles (QMPs). Which of the following is NOT part of these principles?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Related ISO quality management standards are based from these seven Quality Management Principles (QMPs). Which of the following is NOT part of these principles?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Customer focus', false, 0),
      (v_question_id, 'Improvement', false, 1),
      (v_question_id, 'Satisfaction', true, 2),
      (v_question_id, 'Engagement of people', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a product-oriented approach which focuses on testing and inspecting raw materials, processes, and finished products to ensure they meet safety and quality standards.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a product-oriented approach which focuses on testing and inspecting raw materials, processes, and finished products to ensure they meet safety and quality standards.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Quality Control', true, 0),
      (v_question_id, 'Quality Assurance', false, 1),
      (v_question_id, 'Quality Standards', false, 2),
      (v_question_id, 'Quality Management', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a process-oriented approach which ensures that systems, policies, and preventive measures are in place to consistently produce safe and high-quality food.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a process-oriented approach which ensures that systems, policies, and preventive measures are in place to consistently produce safe and high-quality food.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Quality Control', false, 0),
      (v_question_id, 'Quality Assurance', true, 1),
      (v_question_id, 'Quality Standards', false, 2),
      (v_question_id, 'Quality Management', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the main objective of HACCP?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the main objective of HACCP?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Production process monitoring', false, 0),
      (v_question_id, 'Preventive approach to food safety', true, 1),
      (v_question_id, 'Efficient resource allocation', false, 2),
      (v_question_id, 'Finished product inspection', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a critical step to remove impurities from raw sugarcane juice by using heat, chemical additives like lime, and sedimentation to create a clear liquid.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a critical step to remove impurities from raw sugarcane juice by using heat, chemical additives like lime, and sedimentation to create a clear liquid.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sedimentation', false, 0),
      (v_question_id, 'Clarification', true, 1),
      (v_question_id, 'Filtration', false, 2),
      (v_question_id, 'Liming', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The process of heating vegetables in steam or in boiling water to inactivate enzymes and to reduce microbial population thereby prolonging storage at sub-freezing temperature.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The process of heating vegetables in steam or in boiling water to inactivate enzymes and to reduce microbial population thereby prolonging storage at sub-freezing temperature.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blanching', true, 0),
      (v_question_id, 'Boiling', false, 1),
      (v_question_id, 'Conching', false, 2),
      (v_question_id, 'Tempering', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Food Engineering (BIOPROCESS) — 24 question(s)
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
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Food Engineering', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The mass of water vapor present in one kilogram of dry air is called?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The mass of water vapor present in one kilogram of dry air is called?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Absolute humidity', false, 0),
      (v_question_id, 'Relative humidity', false, 1),
      (v_question_id, 'Humidity ratio', true, 2),
      (v_question_id, 'Specific humidity', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the ratio of convective to conductive heat transfer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the ratio of convective to conductive heat transfer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Nusselt Number (Nu)', true, 0),
      (v_question_id, 'Lewis Number', false, 1),
      (v_question_id, 'Reynolds Number (Re)', false, 2),
      (v_question_id, 'Froude Number (Fr)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of system that occurs when there is no exchange of heat that takes place with the surroundings, either in closed or open systems';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of system that occurs when there is no exchange of heat that takes place with the surroundings, either in closed or open systems', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Semi-open systems', false, 0),
      (v_question_id, 'Isolated systems', false, 1),
      (v_question_id, 'Adiabatic systems', true, 2),
      (v_question_id, 'Isothermal systems', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The governing law for heat conduction.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The governing law for heat conduction.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fourier''s Law', true, 0),
      (v_question_id, 'Newton''s Law of Cooling', false, 1),
      (v_question_id, 'Newton''s Law of Heating', false, 2),
      (v_question_id, 'Stefan-Boltzmann Law', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A glass of water with a mass of 0.3 kg at 30 degrees Celsius is to be cooled down to 4 degrees Celsius by dropping ice cubes into it. The latent heat of fusion of ice is 334 kJ/kg. The amount of ice that needs to be added to cool the water down is?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A glass of water with a mass of 0.3 kg at 30 degrees Celsius is to be cooled down to 4 degrees Celsius by dropping ice cubes into it. The latent heat of fusion of ice is 334 kJ/kg. The amount of ice that needs to be added to cool the water down is?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35.5 g', false, 0),
      (v_question_id, '76.4 g', false, 1),
      (v_question_id, '93.0 g', true, 2),
      (v_question_id, '97.6 g', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following statements is incorrect?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which of the following statements is incorrect?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The constant dry bulb temperature line represents the adiabatic saturation process', true, 0),
      (v_question_id, 'Willis Carrier invented the psychrometric chart', false, 1),
      (v_question_id, 'The content wet bulb temperature line coincides with the constant enthalpy line', false, 2),
      (v_question_id, 'The chart is plotted for pressure equal to 760 mmHg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the heat associated with the change in the physical state or phase of materials.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the heat associated with the change in the physical state or phase of materials.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sensible Heat', false, 0),
      (v_question_id, 'Latent Heat', true, 1),
      (v_question_id, 'Specific heat', false, 2),
      (v_question_id, 'Heat of vaporization', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The process where heat transfer is attributed only to a change in dry bulb temperature is called?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The process where heat transfer is attributed only to a change in dry bulb temperature is called?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Humidification', false, 0),
      (v_question_id, 'Sensible heating and cooling', true, 1),
      (v_question_id, 'Sensible heating', false, 2),
      (v_question_id, 'Sensible cooling', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Sensible cooling occurs when air temperature decreases due to the loss of heat with ___________.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Sensible cooling occurs when air temperature decreases due to the loss of heat with ___________.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Constant pressure', false, 0),
      (v_question_id, 'Constant enthalpy', false, 1),
      (v_question_id, 'Constant moisture content', true, 2),
      (v_question_id, 'Constant specific volume', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A thermodynamic process that occurs without heat transfer between the system and its surroundings.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A thermodynamic process that occurs without heat transfer between the system and its surroundings.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Isothermal', false, 0),
      (v_question_id, 'Isobaric', false, 1),
      (v_question_id, 'Isochoric', false, 2),
      (v_question_id, 'Adiabatic', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This states that if two systems are in thermal equilibrium with a third system, then they are also in thermal equilibrium with each other.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This states that if two systems are in thermal equilibrium with a third system, then they are also in thermal equilibrium with each other.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Zeroth Law of Thermodynamics', true, 0),
      (v_question_id, 'First Law of Thermodynamics', false, 1),
      (v_question_id, 'Second Law of Thermodynamics', false, 2),
      (v_question_id, 'Third Law of Thermodynamics', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Following the supply of high-temperature, high-pressure vapor from the compressor, the condenser facilitates the cooling process. As a result, the refrigerant undergoes a transformation into a ________, and is subsequently directed towards the expansion valve in the loop.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Following the supply of high-temperature, high-pressure vapor from the compressor, the condenser facilitates the cooling process. As a result, the refrigerant undergoes a transformation into a ________, and is subsequently directed towards the expansion valve in the loop.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Low pressure, low temperature', false, 0),
      (v_question_id, 'High pressure, low temperature', true, 1),
      (v_question_id, 'Low pressure, high temperature', false, 2),
      (v_question_id, 'High pressure, high temperature', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The actual dry bulb temperature from an evaporative cooler is 22°C. If the outside air has dry bulb temperature of 33°C and wet bulb temperature of 20°C, determine the evaporative cooler efficiency.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The actual dry bulb temperature from an evaporative cooler is 22°C. If the outside air has dry bulb temperature of 33°C and wet bulb temperature of 20°C, determine the evaporative cooler efficiency.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '82.56%', false, 0),
      (v_question_id, '83.81%', false, 1),
      (v_question_id, '84.05%', false, 2),
      (v_question_id, '84.62%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A Carnot refrigeration cycle absorbs heat at –3°C and rejects t at 27°C. If the cycle is used as a heat pump and works with the same given conditions, what is the COP?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A Carnot refrigeration cycle absorbs heat at –3°C and rejects t at 27°C. If the cycle is used as a heat pump and works with the same given conditions, what is the COP?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7', false, 0),
      (v_question_id, '8', false, 1),
      (v_question_id, '9', false, 2),
      (v_question_id, '10', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During sensible cooling, what happens to the moisture content of the product?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'During sensible cooling, what happens to the moisture content of the product?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It increases', false, 0),
      (v_question_id, 'It decreases', false, 1),
      (v_question_id, 'It may either increase of decrease', false, 2),
      (v_question_id, 'No change occurs', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a refrigeration cycle, the heat is rejected by the refrigerant in what part?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a refrigeration cycle, the heat is rejected by the refrigerant in what part?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Evaporator', false, 0),
      (v_question_id, 'Condenser', true, 1),
      (v_question_id, 'Compressor', false, 2),
      (v_question_id, 'Expansion Valve', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rice husk stove boils 2 liters of water and subsequently evaporated 0.5 liter. The initial temperature of water is 27 C. The amount of fuel consumed in boiling and evaporating water is 1.5 kg. What is the thermal efficiency of the stove? Assume a heat of vaporization of water equal to 540 kCal/kg and heating value of fuel equal to 3,000 kCal per kg.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A rice husk stove boils 2 liters of water and subsequently evaporated 0.5 liter. The initial temperature of water is 27 C. The amount of fuel consumed in boiling and evaporating water is 1.5 kg. What is the thermal efficiency of the stove? Assume a heat of vaporization of water equal to 540 kCal/kg and heating value of fuel equal to 3,000 kCal per kg.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.2%', false, 0),
      (v_question_id, '9.2%', true, 1),
      (v_question_id, '10.5%', false, 2),
      (v_question_id, '11.4%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the amount of heat needed to raise the temperature of a 1.5-tons medium-size paddy from 27°C to 45°C? The moisture content of paddy is 14% wet basis.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the amount of heat needed to raise the temperature of a 1.5-tons medium-size paddy from 27°C to 45°C? The moisture content of paddy is 14% wet basis.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18,569 BTU', false, 0),
      (v_question_id, '20,675 BTU', false, 1),
      (v_question_id, '22,763 BTU', true, 2),
      (v_question_id, '25,351 BTU', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Estimate the heat required to increase the temperature of 20 kilograms of orange pulp from 30 to 70 degrees Celsius. The mean heat capacity of the orange pulp is 4 kJ/kg-C.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Estimate the heat required to increase the temperature of 20 kilograms of orange pulp from 30 to 70 degrees Celsius. The mean heat capacity of the orange pulp is 4 kJ/kg-C.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1778 kJ', false, 0),
      (v_question_id, '3100 kJ', false, 1),
      (v_question_id, '1834 kJ', false, 2),
      (v_question_id, '3200 kJ', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Moist air at standard atmospheric pressure is 45°C dry bulb and 25% relative humidity. Find the saturation vapor pressure.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Moist air at standard atmospheric pressure is 45°C dry bulb and 25% relative humidity. Find the saturation vapor pressure.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9.58 kPa', true, 0),
      (v_question_id, '9.85 kPa', false, 1),
      (v_question_id, '5.98 kPa', false, 2),
      (v_question_id, '5.89 kPa', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the actual vapor pressure in # 113?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the actual vapor pressure in # 113?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.45 kPa', false, 0),
      (v_question_id, '2.43 kPa', false, 1),
      (v_question_id, '2.40 kPa', true, 2),
      (v_question_id, '2.37 kPa', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the main component of dry ice?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the main component of dry ice?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Carbon dioxide', true, 0),
      (v_question_id, 'Carbon monoxide', false, 1),
      (v_question_id, 'Oxygen', false, 2),
      (v_question_id, 'Water', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the temperature at which water vapor starts to condense out of the air, and is read by following a horizontal line from the state-point to the saturation line.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the temperature at which water vapor starts to condense out of the air, and is read by following a horizontal line from the state-point to the saturation line.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dry bulb temperature', false, 0),
      (v_question_id, 'Wet bulb temperature', false, 1),
      (v_question_id, 'Dew point temperature', true, 2),
      (v_question_id, 'Relative humidity', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At 100% relative humidity, the wet bulb temperature is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'At 100% relative humidity, the wet bulb temperature is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Lower than the dew point temperature', false, 0),
      (v_question_id, 'Higher than the dew point temperature', false, 1),
      (v_question_id, 'Equal to the dew point temperature', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Food Process Evaluation and Modelling (BIOPROCESS) — 50 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Food Process Evaluation and Modelling' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Food Process Evaluation and Modelling', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the stoichiometric air of rice husk?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the stoichiometric air of rice husk?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.5 kg air/kg rice husk', false, 0),
      (v_question_id, '4.7 kg air/kg rice husk', true, 1),
      (v_question_id, '5.6 kg air/kg rice husk', false, 2),
      (v_question_id, '6.5 kg air/kg rice husk', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are losses that occur between the completion of harvest and the moment of consumption.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are losses that occur between the completion of harvest and the moment of consumption.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Production losses', false, 0),
      (v_question_id, 'Quality losses', false, 1),
      (v_question_id, 'Postharvest losses', true, 2),
      (v_question_id, 'Both A and C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the complete or near removal of water from a material.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the complete or near removal of water from a material.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drying', false, 0),
      (v_question_id, 'Dehydration', true, 1),
      (v_question_id, 'Evaporation', false, 2),
      (v_question_id, 'Both A and B', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How much liter of kerosene is needed to dry one ton of paddy from 30% to 14%? Assume latent heat of vaporization is 2500 kJ/kg, heating value of kerosene is 43 MJ/kg, kerosene specific gravity is 0.8, and burner efficiency is 80%';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How much liter of kerosene is needed to dry one ton of paddy from 30% to 14%? Assume latent heat of vaporization is 2500 kJ/kg, heating value of kerosene is 43 MJ/kg, kerosene specific gravity is 0.8, and burner efficiency is 80%', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '11 liters', false, 0),
      (v_question_id, '14 liters', false, 1),
      (v_question_id, '17 liters', true, 2),
      (v_question_id, '21 liters', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many kilograms of water is lost from a ton of palay at 20.9% if the moisture content changes to 15.2%?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How many kilograms of water is lost from a ton of palay at 20.9% if the moisture content changes to 15.2%?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '53.15 kg', false, 0),
      (v_question_id, '67.22 kg', true, 1),
      (v_question_id, '72.15 kg', false, 2),
      (v_question_id, '64.69 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the geometric mean diameter of rice with the following dimensions: L = 11.18 mm, W = 4.56 mm, Thickness = 2.14 mm.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the geometric mean diameter of rice with the following dimensions: L = 11.18 mm, W = 4.56 mm, Thickness = 2.14 mm.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.98 mm', false, 0),
      (v_question_id, '4.56 mm', false, 1),
      (v_question_id, '4.78 mm', true, 2),
      (v_question_id, '4.12 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the percentage increase in the porosity of the harvested medium-sized paddy with 21% moisture content wet basis if it is to be dried to 14% wet basis?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the percentage increase in the porosity of the harvested medium-sized paddy with 21% moisture content wet basis if it is to be dried to 14% wet basis?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.1%', true, 0),
      (v_question_id, '0.2%', false, 1),
      (v_question_id, '68%', false, 2),
      (v_question_id, '45%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many kilograms of rice hull are needed to dry one ton of palay from 24% to 14% w.b.? Assume latent heat of vaporization is 2,500 kJ/kg, heating value of rice hull is 14 MJ/kg, and it is 100% efficient.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How many kilograms of rice hull are needed to dry one ton of palay from 24% to 14% w.b.? Assume latent heat of vaporization is 2,500 kJ/kg, heating value of rice hull is 14 MJ/kg, and it is 100% efficient.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '157.8 kg', false, 0),
      (v_question_id, '29.1 kg', false, 1),
      (v_question_id, '116.3 kg', false, 2),
      (v_question_id, '20.80 kg', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The following are mechanical dryers under heated-air mechanical drying except for one. Which is it?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The following are mechanical dryers under heated-air mechanical drying except for one. Which is it?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Batch dryer', false, 0),
      (v_question_id, 'Recirculating batch dryer', false, 1),
      (v_question_id, 'In-store dryer', true, 2),
      (v_question_id, 'Continuous flow dryer', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Convert a moisture content of 25% wet basis to moisture content dry basis.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Convert a moisture content of 25% wet basis to moisture content dry basis.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '33%', true, 0),
      (v_question_id, '28%', false, 1),
      (v_question_id, '39%', false, 2),
      (v_question_id, '24%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the maximum moisture content for safe storage in paddy seeds for less than one year?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the maximum moisture content for safe storage in paddy seeds for less than one year?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9%', true, 0),
      (v_question_id, '12%', false, 1),
      (v_question_id, '14%', false, 2),
      (v_question_id, '18%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The material is said to be in the state of equilibrium if __________.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The material is said to be in the state of equilibrium if __________.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The vapor pressure of the air is equal to the vapor pressure of the product', true, 0),
      (v_question_id, 'The vapor pressure of the air is greater than the vapor pressure of the product', false, 1),
      (v_question_id, 'The vapor pressure of the air is lesser than the vapor pressure of the product', false, 2),
      (v_question_id, 'The vapor pressure of the air is greater than or equal to the vapor pressure of the product', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following are the factors that affects the equilibrium moisture content?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which of the following are the factors that affects the equilibrium moisture content?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dry bulb temperature and wet bulb temperature', false, 0),
      (v_question_id, 'Relative humidity and humidity ratio', false, 1),
      (v_question_id, 'Relative humidity and dry bulb temperature', true, 2),
      (v_question_id, 'Relative humidity and specific enthalpy', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The best index for determining the optimum time of harvesting grains is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The best index for determining the optimum time of harvesting grains is:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Planting date', false, 0),
      (v_question_id, 'Moisture content', false, 1),
      (v_question_id, 'Grain color', true, 2),
      (v_question_id, 'Flag leaf dryness', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the best level of equilibrium relative humidity for storage of grains in silos, bins, and other storage facilities?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the best level of equilibrium relative humidity for storage of grains in silos, bins, and other storage facilities?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Less than 75%', false, 0),
      (v_question_id, 'Less than 65%', true, 1),
      (v_question_id, 'Greater than 85%', false, 2),
      (v_question_id, 'Greater than 65%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the maximum moisture content for safe storage in palay seeds?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the maximum moisture content for safe storage in palay seeds?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', false, 0),
      (v_question_id, '12%', true, 1),
      (v_question_id, '14%', false, 2),
      (v_question_id, '16%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a method of preserving agricultural commodities such as grains using airtight and moisture-proof containers that create a sealed environment.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a method of preserving agricultural commodities such as grains using airtight and moisture-proof containers that create a sealed environment.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hypobaric storage', false, 0),
      (v_question_id, 'Controlled atmosphere storage', false, 1),
      (v_question_id, 'Hermetic storage', true, 2),
      (v_question_id, 'Modern-sealed storage', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of postharvest loss where it is attributed on moisture loss, physical and structural damages to the commodity.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of postharvest loss where it is attributed on moisture loss, physical and structural damages to the commodity.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Qualitative loss', false, 0),
      (v_question_id, 'Quantitative loss', true, 1),
      (v_question_id, 'Production loss', false, 2),
      (v_question_id, 'Postharvest loss', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a material balance, if the system is in a steady-state condition, what can be assumed about the accumulation term?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a material balance, if the system is in a steady-state condition, what can be assumed about the accumulation term?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It is equal to the total output alone', false, 0),
      (v_question_id, 'It is equal to zero', true, 1),
      (v_question_id, 'It is equal to the sum of all components', false, 2),
      (v_question_id, 'It is equal to the total input alone', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following salt solution produces a relative humidity of 70 – 75%?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which of the following salt solution produces a relative humidity of 70 – 75%?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Magnesium chloride', false, 0),
      (v_question_id, 'Potassium sulfate', false, 1),
      (v_question_id, 'Sodium chloride', true, 2),
      (v_question_id, 'Potassium carbonate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Eight thousand kg of paddy with a moisture content of 12% (d.b) is required for a research project on grain storage. It was decided that the available freshly harvested paddy with a moisture content of 20% (w.b.) should be procured and then it will be dried to a moisture content of 12% (d.b.) How many kg of freshly harvested paddy are to be procured?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Eight thousand kg of paddy with a moisture content of 12% (d.b) is required for a research project on grain storage. It was decided that the available freshly harvested paddy with a moisture content of 20% (w.b.) should be procured and then it will be dried to a moisture content of 12% (d.b.) How many kg of freshly harvested paddy are to be procured?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9010 kg', false, 0),
      (v_question_id, '8760 kg', false, 1),
      (v_question_id, '8540 kg', false, 2),
      (v_question_id, '8930 kg', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine the amount of rice husk fuel required to dry 4 tons of paddy from 21% to 14% moisture content. The air temperature for drying is 45 degrees Celsius. The ambient temperature is 30 degrees Celsius while the relative humidity is 85%. The recommended airflow rate is 25 cu. m of air per min-ton of grain. Assume a heating value for rice husk of 3000 kcal/kg and heat utilization efficiency for the dryer is 0.4. Based on the psychrometric chart, the following are obtained: h1 = 88 kJ/kg-da; h2 = 104 kJ/kg-da; and vs=0.93 cu.m./kg-da';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Determine the amount of rice husk fuel required to dry 4 tons of paddy from 21% to 14% moisture content. The air temperature for drying is 45 degrees Celsius. The ambient temperature is 30 degrees Celsius while the relative humidity is 85%. The recommended airflow rate is 25 cu. m of air per min-ton of grain. Assume a heating value for rice husk of 3000 kcal/kg and heat utilization efficiency for the dryer is 0.4. Based on the psychrometric chart, the following are obtained: h1 = 88 kJ/kg-da; h2 = 104 kJ/kg-da; and vs=0.93 cu.m./kg-da', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18.54 kg/hr', false, 0),
      (v_question_id, '20.64 kg/hr', true, 1),
      (v_question_id, '23.17 kg/hr', false, 2),
      (v_question_id, '25.76 kg/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The moisture content at the turning point from the constant rate drying to the first stage falling rate drying is said to be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The moisture content at the turning point from the constant rate drying to the first stage falling rate drying is said to be:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Absolute moisture content', false, 0),
      (v_question_id, 'Ambient moisture content', false, 1),
      (v_question_id, 'Critical moisture content', true, 2),
      (v_question_id, 'Equilibrium moisture content', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A corn cob has an stoichiometric air requirement of 5.7 kg air/kg fuel. If 3 kg of corn cob is required to be burned per hour, how much air in m³/hr is required for the system.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A corn cob has an stoichiometric air requirement of 5.7 kg air/kg fuel. If 3 kg of corn cob is required to be burned per hour, how much air in m³/hr is required for the system.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.69 m³/hr', false, 0),
      (v_question_id, '31.69 m³/hr', false, 1),
      (v_question_id, '13.96 m³/hr', true, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In this drying period, water vapor diffused through the dry solids to the drying air and the drying rate is controlled by the rate of moisture movement through the solid.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In this drying period, water vapor diffused through the dry solids to the drying air and the drying rate is controlled by the rate of moisture movement through the solid.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Constant rate period', false, 0),
      (v_question_id, 'First falling rate period', true, 1),
      (v_question_id, 'Second falling period', false, 2),
      (v_question_id, 'Initial induction period', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If the vapor pressure of the water held by the grain is greater than the vapor pressure of the surrounding air, what condition exists?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'If the vapor pressure of the water held by the grain is greater than the vapor pressure of the surrounding air, what condition exists?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Absorption', false, 0),
      (v_question_id, 'Adsorption', false, 1),
      (v_question_id, 'Desorption', true, 2),
      (v_question_id, 'Hysteresis', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Calculate the molarity for this sugar solution, which is prepared by dissolving 10 kg of sucrose in 90 kilograms of water. The density of the solution is 1040 kg/m3.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Calculate the molarity for this sugar solution, which is prepared by dissolving 10 kg of sucrose in 90 kilograms of water. The density of the solution is 1040 kg/m3.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.28 mol/liter', false, 0),
      (v_question_id, '0.30 mol/liter', true, 1),
      (v_question_id, '0.32 mol/liter', false, 2),
      (v_question_id, '0.34 mol/liter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An evaporator has a rated evaporation capacity of 500 kg of water per one hour operation. Calculate the rate of production of juice concentrate containing 45% total solids from raw juice containing 12% solids.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'An evaporator has a rated evaporation capacity of 500 kg of water per one hour operation. Calculate the rate of production of juice concentrate containing 45% total solids from raw juice containing 12% solids.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '179 kg', false, 0),
      (v_question_id, '182 kg', true, 1),
      (v_question_id, '186 kg', false, 2),
      (v_question_id, '180 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Papaya slices containing 85% moisture is dehydrated in a fruit dryer. The dry product has 5% moisture content, how much product is needed to produce one ton of papaya slice product per day? Preparation losses like peeling and trimming is 10%.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Papaya slices containing 85% moisture is dehydrated in a fruit dryer. The dry product has 5% moisture content, how much product is needed to produce one ton of papaya slice product per day? Preparation losses like peeling and trimming is 10%.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7020 kg', false, 0),
      (v_question_id, '7037 kg', true, 1),
      (v_question_id, '7043 kg', false, 2),
      (v_question_id, '7018 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the amount of sugar that is to be added in a 100 kg sugar solution to raise its concentration from 20% to 45%?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the amount of sugar that is to be added in a 100 kg sugar solution to raise its concentration from 20% to 45%?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '36.76 kg', false, 0),
      (v_question_id, '45.45 kg', true, 1),
      (v_question_id, '51.25 kg', false, 2),
      (v_question_id, '56.19 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A sugar solution with 15% sugar concentration is fed into a mixer at 35,000 kg/hr. Dry sugar is added to produce 50,000 kg/hr of a solution with 30% sugar concentration. Calculate the mass flow rate of the dry sugar needed for the solution.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A sugar solution with 15% sugar concentration is fed into a mixer at 35,000 kg/hr. Dry sugar is added to produce 50,000 kg/hr of a solution with 30% sugar concentration. Calculate the mass flow rate of the dry sugar needed for the solution.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,750 kg/hr', false, 0),
      (v_question_id, '7,750 kg/hr', false, 1),
      (v_question_id, '9,750 kg/hr', true, 2),
      (v_question_id, '8,740 kg/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At a moisture content of 20%, the angle of repose for paddy will be ________ than a dry paddy with 14% moisture content.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'At a moisture content of 20%, the angle of repose for paddy will be ________ than a dry paddy with 14% moisture content.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Greater', true, 0),
      (v_question_id, 'Lower', false, 1),
      (v_question_id, 'Equal', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As the relative humidity ________ and air temperature ________, the EMC of grains increases.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'As the relative humidity ________ and air temperature ________, the EMC of grains increases.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Increases, increases', false, 0),
      (v_question_id, 'Increases, decreases', true, 1),
      (v_question_id, 'Decreases, increases', false, 2),
      (v_question_id, 'Decreases, decreases', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the EMC of milled rice (in d.b.) in Philippine environmental condition.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the EMC of milled rice (in d.b.) in Philippine environmental condition.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '13%', false, 0),
      (v_question_id, '14%', false, 1),
      (v_question_id, '16%', false, 2),
      (v_question_id, '18%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a moisture content determination method where it makes use of the electrical properties of the material which is directly related to the MC.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a moisture content determination method where it makes use of the electrical properties of the material which is directly related to the MC.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Primary method', false, 0),
      (v_question_id, 'Secondary method', true, 1),
      (v_question_id, 'Tertiary method', false, 2);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For seed storage purposes, drying air temperatures should never exceed _______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For seed storage purposes, drying air temperatures should never exceed _______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35°C', false, 0),
      (v_question_id, '43°C', true, 1),
      (v_question_id, '51 °C', false, 2),
      (v_question_id, '55 °C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For sun drying of paddy grains, the optimum layer thickness is ________.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'For sun drying of paddy grains, the optimum layer thickness is ________.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 to 5 cm', false, 0),
      (v_question_id, '2 to 3 cm', false, 1),
      (v_question_id, '3 to 4 cm', false, 2),
      (v_question_id, '2 to 4 cm', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The most commonly used continuous flow dryer, which can also be classified as mixing and non-mixing.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The most commonly used continuous flow dryer, which can also be classified as mixing and non-mixing.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Concurrent flow', false, 0),
      (v_question_id, 'Counter-flow', false, 1),
      (v_question_id, 'Cross flow', true, 2);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The efficiency of the dryer operation is an important factor in assessing and selecting optimum dryer. Which of the following is not a factor affecting drying efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The efficiency of the dryer operation is an important factor in assessing and selecting optimum dryer. Which of the following is not a factor affecting drying efficiency?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Environment-related', false, 0),
      (v_question_id, 'Crop-specific', false, 1),
      (v_question_id, 'Design and operation', false, 2),
      (v_question_id, 'All of the above', false, 3),
      (v_question_id, 'None of the above', true, 4);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is recommended that paddy should be harvested when 80% of the panicle are fully ripe for the reason that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is recommended that paddy should be harvested when 80% of the panicle are fully ripe for the reason that:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Harvesting paddy before 80% will produce more broken grains', false, 0),
      (v_question_id, 'Harvesting paddy above 80% will produce more empty grains', false, 1),
      (v_question_id, 'Harvesting paddy above 80% will produce more shattered and broken grains', true, 2),
      (v_question_id, 'All of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a drying system where ambient air is forced through a column of grains.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a drying system where ambient air is forced through a column of grains.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Mechanical drying', false, 0),
      (v_question_id, 'Heated-air drying', false, 1),
      (v_question_id, 'Unheated-air drying', true, 2),
      (v_question_id, 'Flash drying', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'One ton of rough rice at 24% moisture content wet basis is to be dried to 14% moisture content dry basis. What is the weight of the dry matter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'One ton of rough rice at 24% moisture content wet basis is to be dried to 14% moisture content dry basis. What is the weight of the dry matter?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '700 kg', false, 0),
      (v_question_id, '760 kg', true, 1),
      (v_question_id, '240 kg', false, 2),
      (v_question_id, '830 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The amount of grain moisture removed by a cubic meter of air in a drying system is 0.0015 kg. What blower capacity in cubic meters per min, is needed to remove all 120 kg moisture if the drying time is 12 hours?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The amount of grain moisture removed by a cubic meter of air in a drying system is 0.0015 kg. What blower capacity in cubic meters per min, is needed to remove all 120 kg moisture if the drying time is 12 hours?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '111', true, 0),
      (v_question_id, '121', false, 1),
      (v_question_id, '234', false, 2),
      (v_question_id, '100', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Sixty thousand cubic meters of air is needed to be removed from grains to attain 14% MC db which is safe for long term storage. What fan capacity, in cubic meters per min, is needed to accomplish drying in 8 hours';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Sixty thousand cubic meters of air is needed to be removed from grains to attain 14% MC db which is safe for long term storage. What fan capacity, in cubic meters per min, is needed to accomplish drying in 8 hours', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '140', false, 0),
      (v_question_id, '130', false, 1),
      (v_question_id, '125', true, 2),
      (v_question_id, '155', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The angle of friction is the angle measured from the horizontal at which the product starts to move downward over a smooth surface. Which among these is true?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The angle of friction is the angle measured from the horizontal at which the product starts to move downward over a smooth surface. Which among these is true?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Wet grain has greater angle of friction than dry grain', false, 0),
      (v_question_id, 'Wet grain has lower angle of friction than dry grain', true, 1),
      (v_question_id, 'Wet grain has equal angle of friction than dry grain', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a measure of dissolved solids in sugar liquor or syrup using refractometer.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a measure of dissolved solids in sugar liquor or syrup using refractometer.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Glycemic index', false, 0),
      (v_question_id, 'Brix index', false, 1),
      (v_question_id, 'Brix', true, 2),
      (v_question_id, 'Sugar index', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the amount of foreign materials in a sample of grains.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the amount of foreign materials in a sample of grains.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Impurities', false, 0),
      (v_question_id, 'Chalky grains', false, 1),
      (v_question_id, 'Dockage', true, 2),
      (v_question_id, 'Defects', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following demonstrates the drying process of grains?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which of the following demonstrates the drying process of grains?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Heating – Tempering – Evaporation – Cooling', false, 0),
      (v_question_id, 'Cooling – Evaporation – Heating – Tempering', false, 1),
      (v_question_id, 'Heating – Evaporation – Cooling– Tempering', false, 2),
      (v_question_id, 'Heating– Evaporation – Tempering - Cooling', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the biomass fuel heating value of peanut hull';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the biomass fuel heating value of peanut hull', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4695 kcal/kg', false, 0),
      (v_question_id, '4102 kcal/kg', true, 1),
      (v_question_id, '3000 kcal/kg', false, 2),
      (v_question_id, '4797 kcal kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The expression of moisture content commonly used in commercial scale.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The expression of moisture content commonly used in commercial scale.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'MC db', false, 0),
      (v_question_id, 'MC wb', true, 1),
      (v_question_id, 'MC', false, 2),
      (v_question_id, 'All of the above', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Agricultural Building and Structures (STRUCTURES_ENVIRONMENT) — 11 question(s)
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
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Building and Structures', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the optimum recommended stack heigh (in feet) for paddy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the optimum recommended stack heigh (in feet) for paddy?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15.46', false, 0),
      (v_question_id, '19.68', true, 1),
      (v_question_id, '6', false, 2),
      (v_question_id, '5.5', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A silo that has an aspect ratio greater than or equal to 2.0 (h/d is greater than or equal to 2.0)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A silo that has an aspect ratio greater than or equal to 2.0 (h/d is greater than or equal to 2.0)', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Retaining', false, 0),
      (v_question_id, 'Intermediate', false, 1),
      (v_question_id, 'Squat', false, 2),
      (v_question_id, 'Slender', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 23-ton of potatoes are to be stored at an agricultural processing plant. How many areas are needed to be provided for the commodity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A 23-ton of potatoes are to be stored at an agricultural processing plant. How many areas are needed to be provided for the commodity?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '360 m2', false, 0),
      (v_question_id, '430 m2', false, 1),
      (v_question_id, '460 m2', true, 2),
      (v_question_id, '520 m2', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If a pile of rough rice is 8 meters long, 6 meters wide, and 3.6 meters high, how many bags of rough rice are safe to be piled?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'If a pile of rough rice is 8 meters long, 6 meters wide, and 3.6 meters high, how many bags of rough rice are safe to be piled?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,443 bags', false, 0),
      (v_question_id, '8,592 bags', false, 1),
      (v_question_id, '2,732 bags', false, 2),
      (v_question_id, '1,728 bags', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on PAES 418, the store room for finished products in the primary processing plant of fruits and vegetables shall have humidity level of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Based on PAES 418, the store room for finished products in the primary processing plant of fruits and vegetables shall have humidity level of:', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40%', false, 0),
      (v_question_id, '60%', true, 1),
      (v_question_id, '70%', false, 2),
      (v_question_id, '85%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The storage area of a processing plant shall have a capacity for temporary storage of raw materials for how many processing days?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The storage area of a processing plant shall have a capacity for temporary storage of raw materials for how many processing days?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 to 3 days', false, 0),
      (v_question_id, '2 to 3 days', false, 1),
      (v_question_id, '1 to 5 days', false, 2),
      (v_question_id, '2 to 5 days', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on the Philippine Agricultural Engineering Standards, what is the angle of repose for rice hull?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Based on the Philippine Agricultural Engineering Standards, what is the angle of repose for rice hull?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 to 36 degrees', false, 0),
      (v_question_id, '35 to 45 degrees', false, 1),
      (v_question_id, '30 to 55 degrees', false, 2),
      (v_question_id, '35 to 50 degrees', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The size of wire mesh used in storage to protect stored products from insects and rodents (PAES 419:2015)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The size of wire mesh used in storage to protect stored products from insects and rodents (PAES 419:2015)', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/8 inches wire mesh', false, 0),
      (v_question_id, '¼ inches wire mesh', true, 1),
      (v_question_id, '½ inches wire mesh', false, 2),
      (v_question_id, '¾ inches wire mesh', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ten tons of shelled corn will be stored in a cylindrical silo. Loading will be done only from the bottom to the top of the cylindrical container without considering the additional volume of the cone due to the effects of the angle of repose of the sample. If the silo required a 1.5D = H ratio, what would be the dimension of the silo? Assume BD shelled corn = 45 lb/cu. Ft';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Ten tons of shelled corn will be stored in a cylindrical silo. Loading will be done only from the bottom to the top of the cylindrical container without considering the additional volume of the cone due to the effects of the angle of repose of the sample. If the silo required a 1.5D = H ratio, what would be the dimension of the silo? Assume BD shelled corn = 45 lb/cu. Ft', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'D = 2.07 m; H = 3.11 m', false, 0),
      (v_question_id, 'D = 2.70 m; H = 4.05 m', false, 1),
      (v_question_id, 'D = 2.82 m; H = 4.23 m', false, 2),
      (v_question_id, 'D = 2.28 m; H = 3.42 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Jute bags should not be stacked higher than ____ and plastics bags higher than _____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Jute bags should not be stacked higher than ____ and plastics bags higher than _____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 m, 2 m', false, 0),
      (v_question_id, '2 m, 3 m', false, 1),
      (v_question_id, '5 m, 4 m', false, 2),
      (v_question_id, '4 m, 3 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In this type of bag storage, bags are laid in complete length-wise or breath-wise tiers in alternate layers systematically.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In this type of bag storage, bags are laid in complete length-wise or breath-wise tiers in alternate layers systematically.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Block stacking', false, 0),
      (v_question_id, 'Japanese method', false, 1),
      (v_question_id, 'Criss-cross method', true, 2),
      (v_question_id, 'Chinese method', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Agricultural Machinery Design, Fabrication/Manufacturing and Testing (POWER_ENERGY_MACHINERY) — 15 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Machinery Design, Fabrication/Manufacturing and Testing' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Agricultural Machinery Design, Fabrication/Manufacturing and Testing', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Out of the 220 kg of paddy rice that goes through the rubber roller of a rice mill, 46.2 kg of unhulled paddy is collected. What is the hulling coefficient? (Assume 570 kg/cu. m density of paddy)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Out of the 220 kg of paddy rice that goes through the rubber roller of a rice mill, 46.2 kg of unhulled paddy is collected. What is the hulling coefficient? (Assume 570 kg/cu. m density of paddy)', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.67', false, 0),
      (v_question_id, '0.71', false, 1),
      (v_question_id, '0.79', true, 2),
      (v_question_id, '0.21', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of horizontal conveyor which can be inclined, has high handling capacity, and can convey up to 30 meters of distance.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of horizontal conveyor which can be inclined, has high handling capacity, and can convey up to 30 meters of distance.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Belt conveyor', false, 0),
      (v_question_id, 'Screw conveyor', false, 1),
      (v_question_id, 'Chain conveyor', true, 2),
      (v_question_id, 'Pneumatic elevator', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of mechanical transport operations which has higher energy requirement and is preferred for large-scale transport of food such as spices and other powdery products.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of mechanical transport operations which has higher energy requirement and is preferred for large-scale transport of food such as spices and other powdery products.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hydraulic conveyor', false, 0),
      (v_question_id, 'Mechanical conveyor', false, 1),
      (v_question_id, 'Screw conveyor', false, 2),
      (v_question_id, 'Pneumatic conveyor', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rice hull has high proportion of ______ which causes considerable damage to processing equipment through excessive wear of machine parts and interconnecting transfer facilities.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Rice hull has high proportion of ______ which causes considerable damage to processing equipment through excessive wear of machine parts and interconnecting transfer facilities.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hemicellulose', false, 0),
      (v_question_id, 'Lignin', false, 1),
      (v_question_id, 'Silica', true, 2),
      (v_question_id, 'Cellulose', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Maximum speed requirement for vertical abrasive whitening cone machine.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Maximum speed requirement for vertical abrasive whitening cone machine.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '13 m/s', true, 0),
      (v_question_id, '14 m/s', false, 1),
      (v_question_id, '15 m/s', false, 2),
      (v_question_id, '20 m/s', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is an auxiliary part of modern rice mills which is used to remove light materials like chaffs and unfilled grains.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is an auxiliary part of modern rice mills which is used to remove light materials like chaffs and unfilled grains.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Aspirator', true, 0),
      (v_question_id, 'Destoner', false, 1),
      (v_question_id, 'Whitener', false, 2),
      (v_question_id, 'Paddy separator', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If the end point in milling is brown rice, the grain has just passed through a _____.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'If the end point in milling is brown rice, the grain has just passed through a _____.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Paddy cleaner', false, 0),
      (v_question_id, 'Rubber roll huller', true, 1),
      (v_question_id, 'Whitener', false, 2),
      (v_question_id, 'Sifter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A blower elevates forage into a 12.2 m high silo t a rate of 455 kg/minute. Determine the input power of the blower if its efficiency is 40%.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A blower elevates forage into a 12.2 m high silo t a rate of 455 kg/minute. Determine the input power of the blower if its efficiency is 40%.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.91 kW', false, 0),
      (v_question_id, '2.30 kW', true, 1),
      (v_question_id, '5.55 kW', false, 2),
      (v_question_id, '1.50 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The grain to be used in heated-air mechanical grain dryer testing shall be homogenous with a moisture content of at least _____ for rice and corn.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The grain to be used in heated-air mechanical grain dryer testing shall be homogenous with a moisture content of at least _____ for rice and corn.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '14%', false, 0),
      (v_question_id, '18%', false, 1),
      (v_question_id, '22%', true, 2),
      (v_question_id, '25%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A chamber wherein air pressure forms uniform distribution of heated-air through the grain mass.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A chamber wherein air pressure forms uniform distribution of heated-air through the grain mass.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Duct', false, 0),
      (v_question_id, 'Bin', false, 1),
      (v_question_id, 'Blower', false, 2),
      (v_question_id, 'Plenum', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The main principle at which rubber huller work is?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The main principle at which rubber huller work is?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two rollers at opposite direction with same speed', false, 0),
      (v_question_id, 'Two rollers at opposite direction with different speed', true, 1),
      (v_question_id, 'Two rollers at same direction with same speed', false, 2),
      (v_question_id, 'Two rollers at same direction with different speed', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rubber roller is used as a huller for a rice mill. The faster roller is directly driven by an electric motor at 1500 rpm. What would be the required speed for the slower roller?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A rubber roller is used as a huller for a rice mill. The faster roller is directly driven by an electric motor at 1500 rpm. What would be the required speed for the slower roller?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1290 rpm', false, 0),
      (v_question_id, '1920 rpm', false, 1),
      (v_question_id, '1125 rpm', true, 2),
      (v_question_id, '2190 rpm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the theoretical rpm of a bucket elevator whose head pulley diameter is 0.2 m and the bucket projection is 0.1 m?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the theoretical rpm of a bucket elevator whose head pulley diameter is 0.2 m and the bucket projection is 0.1 m?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '75 rpm', false, 0),
      (v_question_id, '77 rpm', true, 1),
      (v_question_id, '79 rpm', false, 2),
      (v_question_id, '81 rpm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The husking ratio or rubber roll huller is about _______.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The husking ratio or rubber roll huller is about _______.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50-60%', false, 0),
      (v_question_id, '60-70%', false, 1),
      (v_question_id, '70-80%', false, 2),
      (v_question_id, '80-90%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The commonly used threshing units for throw-in type thresher';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The commonly used threshing units for throw-in type thresher', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Peg-tooth', true, 0),
      (v_question_id, 'Wire loop', false, 1),
      (v_question_id, 'Rasp bar', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

END $$;
