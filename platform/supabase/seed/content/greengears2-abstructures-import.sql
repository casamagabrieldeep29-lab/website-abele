-- Auto-generated from supabase/seed/content/greengears2-abstructures.json — AB Structures Engineering deck (147 questions, 6 topics)
-- Idempotent: safe to re-run; skips questions that already exist (matched by topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left NULL (no source attribution stored).
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Agricultural Building and Structures (STRUCTURES_ENVIRONMENT) — 115 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the specific gravity of cement, particularly, the more common Portland cement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the specific gravity of cement, particularly, the more common Portland cement.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.65', false, 0),
      (v_question_id, '3.15', true, 1),
      (v_question_id, '3.16', false, 2),
      (v_question_id, '2.66', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the minimum distance of slaughterhouse away from any building used for human habitation, and from any factory, public road or public place.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the minimum distance of slaughterhouse away from any building used for human habitation, and from any factory, public road or public place.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 m', false, 0),
      (v_question_id, '150 m', false, 1),
      (v_question_id, '200 m', true, 2),
      (v_question_id, '250 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to DPWH''s DO No. 112 Series of 2019 and as revised in DO No. 15 Series 2020, this is the design speed for all terrain types of farm-to-market roads.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'According to DPWH''s DO No. 112 Series of 2019 and as revised in DO No. 15 Series 2020, this is the design speed for all terrain types of farm-to-market roads.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 kph', false, 0),
      (v_question_id, '30 kph', true, 1),
      (v_question_id, '40 kph', false, 2),
      (v_question_id, '50 kph', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farmer needs to order lumber for work bench that requires a total of 428 board feet. If each piece of lumber measures 2 inches thick, 6 inches wide, and 12 feet long, how many pieces of lumber should the carpenter order?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A farmer needs to order lumber for work bench that requires a total of 428 board feet. If each piece of lumber measures 2 inches thick, 6 inches wide, and 12 feet long, how many pieces of lumber should the carpenter order?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '32 pcs', false, 0),
      (v_question_id, '34 pcs', false, 1),
      (v_question_id, '36 pcs', true, 2),
      (v_question_id, '38 pcs', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the brooding temperature that should be provided for 15-day old chicks in a broiler house?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the brooding temperature that should be provided for 15-day old chicks in a broiler house?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25-27 °C', false, 0),
      (v_question_id, '27-29 °C', true, 1),
      (v_question_id, '29-32 °C', false, 2),
      (v_question_id, '32-35 °C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of farmstead which consists primarily of residence and small service buildings. In this, essential farm operations area carried on with hired services.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of farmstead which consists primarily of residence and small service buildings. In this, essential farm operations area carried on with hired services.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Suburban', true, 0),
      (v_question_id, 'Community', false, 1),
      (v_question_id, 'Open farmstead', false, 2),
      (v_question_id, 'Central', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This measurement is the maximum length of greenhouses and maximum total width of gutter-connected greenhouses.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This measurement is the maximum length of greenhouses and maximum total width of gutter-connected greenhouses.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 m', false, 0),
      (v_question_id, '50 m', true, 1),
      (v_question_id, '30 m', false, 2),
      (v_question_id, '60 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Seven adult pigs are to be contained in a pen of a swine house. What should be the area of the pen for this group?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Seven adult pigs are to be contained in a pen of a swine house. What should be the area of the pen for this group?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.5 sq. m.', false, 0),
      (v_question_id, '14 sq. m', false, 1),
      (v_question_id, '15.75 sq. m', false, 2),
      (v_question_id, '17.5 sq. m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 289:2019 – This percentage is the minimum crossfall of road carriageway. Meanwhile, twice of this should be the cross fall of the road shoulder.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'PAES 289:2019 – This percentage is the minimum crossfall of road carriageway. Meanwhile, twice of this should be the cross fall of the road shoulder.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5%', true, 0),
      (v_question_id, '2%', false, 1),
      (v_question_id, '2.5%', false, 2),
      (v_question_id, '3%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How long is the defects liability period to ensure the contractor rectifies any structural defects or failures that appear after the project''s completion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How long is the defects liability period to ensure the contractor rectifies any structural defects or failures that appear after the project''s completion?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Three months after project completion', false, 0),
      (v_question_id, 'Six months after project completion', false, 1),
      (v_question_id, 'Nine months after project completion', false, 2),
      (v_question_id, 'Twelve months after project completion', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In zone planning, the farmstead is divided into different zones of 10 to 30 meters wide concentric circles. What can be found within the innermost circle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In zone planning, the farmstead is divided into different zones of 10 to 30 meters wide concentric circles. What can be found within the innermost circle?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Family dwelling area', true, 0),
      (v_question_id, 'Implement and machine storage', false, 1),
      (v_question_id, 'Farm workshop', false, 2),
      (v_question_id, 'Livestock building', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Due to constant typhoons, an old mango tree was cut to prevent it from falling along the farmer''s house. If the width of its trunk is 40 cm and the length of the trunk is 5 meters, how many board foot can be obtained from it?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Due to constant typhoons, an old mango tree was cut to prevent it from falling along the farmer''s house. If the width of its trunk is 40 cm and the length of the trunk is 5 meters, how many board foot can be obtained from it?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '405 bd. ft.', false, 0),
      (v_question_id, '141 bd. ft.', true, 1),
      (v_question_id, '254 bd. ft.', false, 2),
      (v_question_id, '129 bd. ft.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm shed is to be made of masonry and wood. What type of construction would it be?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A farm shed is to be made of masonry and wood. What type of construction would it be?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type I', false, 0),
      (v_question_id, 'Type II', false, 1),
      (v_question_id, 'Type III', true, 2),
      (v_question_id, 'Type V', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Maximum wind gusts which the frames of a greenhouse shall be able to withstand.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Maximum wind gusts which the frames of a greenhouse shall be able to withstand.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 kph', false, 0),
      (v_question_id, '150 kph', false, 1),
      (v_question_id, '200 kph', false, 2),
      (v_question_id, '250 kph', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the maximum distance of a milking parlor away from the lactating barn if milking is done two times a day?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the maximum distance of a milking parlor away from the lactating barn if milking is done two times a day?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 m', false, 0),
      (v_question_id, '180 m', false, 1),
      (v_question_id, '275 m', true, 2),
      (v_question_id, '100 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is described as the rate of increase or decrease in the level of the land, the slope expressed in percentage.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is described as the rate of increase or decrease in the level of the land, the slope expressed in percentage.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'grade', false, 0),
      (v_question_id, 'gradient', true, 1),
      (v_question_id, 'gradation', false, 2),
      (v_question_id, 'grading', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The number of CHB needed to build a wall is 394 pieces, given that the height of the wall is 3.5 m, what is its length?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The number of CHB needed to build a wall is 394 pieces, given that the height of the wall is 3.5 m, what is its length?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.5 m', false, 0),
      (v_question_id, '8 m', false, 1),
      (v_question_id, '8.5 m', false, 2),
      (v_question_id, '9 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which among the pipe below can withstand the most pressure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which among the pipe below can withstand the most pressure?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'GI pipe schedule 20', false, 0),
      (v_question_id, 'GI pipe schedule 80', true, 1),
      (v_question_id, 'GI pipe schedule 40', false, 2),
      (v_question_id, 'GI pipe schedule 10', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the measurement of a rectangle pallet as given by the American Society of Agricultural Engineers (ASAE)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the measurement of a rectangle pallet as given by the American Society of Agricultural Engineers (ASAE)?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120 cm x 100 cm x 72 cm', true, 0),
      (v_question_id, '100 cm x 72 cm x 61 cm', false, 1),
      (v_question_id, '100 cm x 120 cm x 61 cm', false, 2),
      (v_question_id, '120 cm x 72 cm x 61 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Unless otherwise specified in the contract, what is the free-haul distance for the construction of farm to market roads?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Unless otherwise specified in the contract, what is the free-haul distance for the construction of farm to market roads?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1200 m', false, 0),
      (v_question_id, '1000 m', false, 1),
      (v_question_id, '700 m', false, 2),
      (v_question_id, '600 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a laying cage, the floor shall be made of a 12 gauge wire and is sloped to allow laid eggs to roll out. What should be the slope of its floor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a laying cage, the floor shall be made of a 12 gauge wire and is sloped to allow laid eggs to roll out. What should be the slope of its floor?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18-25%', false, 0),
      (v_question_id, '4-7%', false, 1),
      (v_question_id, '21-25%', true, 2),
      (v_question_id, '2-4%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A square storage room has a floor area of 16 sqm, a ceiling height of 2.4 m, a window which measures 0.3 m by 0.4 m, and a standard door 210 cm by 900 mm. How many CHB was used to build its walls?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A square storage room has a floor area of 16 sqm, a ceiling height of 2.4 m, a window which measures 0.3 m by 0.4 m, and a standard door 210 cm by 900 mm. How many CHB was used to build its walls?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '480 pcs', false, 0),
      (v_question_id, '455 pcs', true, 1),
      (v_question_id, '215 pcs', false, 2),
      (v_question_id, '390 pcs', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the recommended lighting intensity for the refrigerated storage room of a fruit and vegetable storage.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the recommended lighting intensity for the refrigerated storage room of a fruit and vegetable storage.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 lux', false, 0),
      (v_question_id, '200 lux', false, 1),
      (v_question_id, '500 lux', false, 2),
      (v_question_id, '50 lux', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum dimension of the gate of a farm workshop and machinery shed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the minimum dimension of the gate of a farm workshop and machinery shed?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 m high by 3.7 m wide', true, 0),
      (v_question_id, '3.7 m high by 3 m wide', false, 1),
      (v_question_id, '600 mm wide by 0.9-1 m high', false, 2),
      (v_question_id, '900 mm wide by 2 m high', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A greenhouse has a roof pitch of 60%. What type of covering material is used for the greenhouse?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A greenhouse has a roof pitch of 60%. What type of covering material is used for the greenhouse?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Glass', false, 0),
      (v_question_id, 'Plastic', true, 1),
      (v_question_id, 'Wood', false, 2),
      (v_question_id, 'Metal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How much class A concrete can be made of 100 40-kg bags of cement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How much class A concrete can be made of 100 40-kg bags of cement?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '11.11 m³', true, 0),
      (v_question_id, '12.12 m³', false, 1),
      (v_question_id, '13.33 m³', false, 2),
      (v_question_id, '14.44 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which drawing command creates multiple evenly spaced copies of objects in a circular or rectangular pattern?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which drawing command creates multiple evenly spaced copies of objects in a circular or rectangular pattern?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Copy', false, 0),
      (v_question_id, 'Mirror', false, 1),
      (v_question_id, 'Array', true, 2),
      (v_question_id, 'Offset', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a wood defect which is characterized by a small separation of the wood fiber in the longitudinal direction, it does not extend entirely to the opposite side of the wood.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a wood defect which is characterized by a small separation of the wood fiber in the longitudinal direction, it does not extend entirely to the opposite side of the wood.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Checks', true, 0),
      (v_question_id, 'Shakes', false, 1),
      (v_question_id, 'Wane', false, 2),
      (v_question_id, 'Diamond', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the recommended lighting intensity within the pen area of a housing for dairy cattle.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the recommended lighting intensity within the pen area of a housing for dairy cattle.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200 lux', false, 0),
      (v_question_id, '70 lux', true, 1),
      (v_question_id, '30 lux', false, 2),
      (v_question_id, '100 lux', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum road shoulder width of one lane concrete FMR?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the minimum road shoulder width of one lane concrete FMR?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 m', false, 0),
      (v_question_id, '0.75 m', true, 1),
      (v_question_id, '1.0 m', false, 2),
      (v_question_id, '1.5 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 4-inch thick floor slab is to be filled with concrete, how much 40-kg cement bags, sand, and gravel is needed if the designed floor area is 25 sq. m?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A 4-inch thick floor slab is to be filled with concrete, how much 40-kg cement bags, sand, and gravel is needed if the designed floor area is 25 sq. m?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '23 bags, 1.27 m³, 2.54 m³', true, 0),
      (v_question_id, '16 bags, 1.27 m³, 2.54 m³', false, 1),
      (v_question_id, '31 bags, 1.72 m³, 3.44 m³', false, 2),
      (v_question_id, '21 bags, 1.72 m³, 3.44 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the suitable material used for embankments. It is excavated from a source or pit.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the suitable material used for embankments. It is excavated from a source or pit.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'borrow', true, 0),
      (v_question_id, 'fill', false, 1),
      (v_question_id, 'backfill', false, 2),
      (v_question_id, 'excavation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a load which tends to shorten or crush a structural member.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a load which tends to shorten or crush a structural member.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'compression', true, 0),
      (v_question_id, 'tension', false, 1),
      (v_question_id, 'shear', false, 2),
      (v_question_id, 'bending', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a pre-built structural member capable of supporting a load over a given span. It consists of one or more triangles in its construction.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a pre-built structural member capable of supporting a load over a given span. It consists of one or more triangles in its construction.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'column', false, 0),
      (v_question_id, 'beam', false, 1),
      (v_question_id, 'truss', true, 2),
      (v_question_id, 'foundation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a warehouse for bag type storage of grains, what is the recommended space between the edge of bag piles and the wall?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a warehouse for bag type storage of grains, what is the recommended space between the edge of bag piles and the wall?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.25 m', false, 0),
      (v_question_id, '0.5 m', false, 1),
      (v_question_id, '0.75 m', false, 2),
      (v_question_id, '1.0 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Twenty 50-kg pigs are to be housed in a pen, what should be the designed a floor area of their pen?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Twenty 50-kg pigs are to be housed in a pen, what should be the designed a floor area of their pen?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7 sqm', false, 0),
      (v_question_id, '10 sqm', true, 1),
      (v_question_id, '14 sqm', false, 2),
      (v_question_id, '17 sqm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Four hundred fifty-five pieces of 4-inch CHB is needed to build a storage room. If the total length of its walls is 16 m and the height 2.4 m, how much 12 mm-thick class B mortar was used to build its walls?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Four hundred fifty-five pieces of 4-inch CHB is needed to build a storage room. If the total length of its walls is 16 m and the height 2.4 m, how much 12 mm-thick class B mortar was used to build its walls?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.65 m³', false, 0),
      (v_question_id, '1.365 m³', false, 1),
      (v_question_id, '1.6 m³', true, 2),
      (v_question_id, '1.35 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Four carabaos in a feedlot should have a minimum space of ________?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Four carabaos in a feedlot should have a minimum space of ________?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 m²', false, 0),
      (v_question_id, '14 m²', false, 1),
      (v_question_id, '16 m²', true, 2),
      (v_question_id, '18 m²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A corrugated G.I. sheet has an effective width of 60 cm, what is its side lapping?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A corrugated G.I. sheet has an effective width of 60 cm, what is its side lapping?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 corrugation', false, 0),
      (v_question_id, '1 ½ corrugations', false, 1),
      (v_question_id, '2 corrugations', false, 2),
      (v_question_id, '2 ½ corrugations', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A beam requires 0.5 m³ of concrete upon its construction, how many 40-kg bags of cement should be used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A beam requires 0.5 m³ of concrete upon its construction, how many 40-kg bags of cement should be used?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 bags', false, 0),
      (v_question_id, '5 bags', true, 1),
      (v_question_id, '3 bags', false, 2),
      (v_question_id, '9 bags', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of load that comes from the intended used and on the occupancy of the building.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of load that comes from the intended used and on the occupancy of the building.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'floor live loads', true, 0),
      (v_question_id, 'utility loads', false, 1),
      (v_question_id, 'occupancy load', false, 2),
      (v_question_id, 'roof live loads', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the distance between two main trusses.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the distance between two main trusses.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'bay', true, 0),
      (v_question_id, 'span', false, 1),
      (v_question_id, 'rise', false, 2),
      (v_question_id, 'pitch', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the maximum slope of a one-lane earth road?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the maximum slope of a one-lane earth road?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3%', true, 0),
      (v_question_id, '2.5%', false, 1),
      (v_question_id, '1.5%', false, 2),
      (v_question_id, '4%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It defines a part or the entirety of a property, site or location, with defined physical boundaries, used or required by a government infrastructure project.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It defines a part or the entirety of a property, site or location, with defined physical boundaries, used or required by a government infrastructure project.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Government land', false, 0),
      (v_question_id, 'Right-of-Way', true, 1),
      (v_question_id, 'Expansion land', false, 2),
      (v_question_id, 'Property acquistion', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A warehouse needs to store 60,000 bags of rice. What should be its designed dimension?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A warehouse needs to store 60,000 bags of rice. What should be its designed dimension?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6-10 m x 30 m buildings', false, 0),
      (v_question_id, '1-25 x 78 m building', false, 1),
      (v_question_id, '1-20 m x 60 m and 1-10 m x 30 m buildings', false, 2),
      (v_question_id, '2-16 m x 48 m buildings', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ten coconut trees were cut to be sold as lumbers, if their average diameter is 0.35 m and their average length 20 m. Approximately, how many board feet can be obtained from these?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Ten coconut trees were cut to be sold as lumbers, if their average diameter is 0.35 m and their average length 20 m. Approximately, how many board feet can be obtained from these?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3920 bd. ft.', false, 0),
      (v_question_id, '3900 bd. ft.', false, 1),
      (v_question_id, '3921 bd. ft.', true, 2),
      (v_question_id, '3923 bd. ft.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What should be the minimum step width for the stairs of goat and sheep housing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What should be the minimum step width for the stairs of goat and sheep housing?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '800 mm', true, 0),
      (v_question_id, '200 mm', false, 1),
      (v_question_id, '300 mm', false, 2),
      (v_question_id, '700 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Three poultry housing of slot-litter type floor has a pen space of 98 m² each. How many laying chickens can they accommodate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Three poultry housing of slot-litter type floor has a pen space of 98 m² each. How many laying chickens can they accommodate?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2000 heads', false, 0),
      (v_question_id, '2100 heads', true, 1),
      (v_question_id, '2200 heads', false, 2),
      (v_question_id, '2300 heads', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a cement that attains high early strength and should not be used in large masses as it has high heat evolution.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a cement that attains high early strength and should not be used in large masses as it has high heat evolution.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type V', false, 0),
      (v_question_id, 'Type IV', false, 1),
      (v_question_id, 'Type III', true, 2),
      (v_question_id, 'Type II', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What should be the thickness of the concrete base slab for the floor of a slaughterhouse?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What should be the thickness of the concrete base slab for the floor of a slaughterhouse?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '150 mm', true, 0),
      (v_question_id, '200 mm', false, 1),
      (v_question_id, '250 mm', false, 2),
      (v_question_id, '300 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the recommended maximum ventilation rate for most greenhouses?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the recommended maximum ventilation rate for most greenhouses?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.75-1 air change per minute', true, 0),
      (v_question_id, '1-2 air change per minute', false, 1),
      (v_question_id, '0.5-1.5 air change per minute', false, 2),
      (v_question_id, '1.5-2 air change per minute', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Approximately how many times is the total dry volume of concrete components greater than the volume of wet concrete?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Approximately how many times is the total dry volume of concrete components greater than the volume of wet concrete?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.24 times', false, 0),
      (v_question_id, '1.34 times', false, 1),
      (v_question_id, '1.44 times', false, 2),
      (v_question_id, '1.54 times', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the application of water to concrete through brushing or pressure spraying to prevent the loss of initial moisture and maintain the chemical reaction within the concrete mixture, commonly for seven days.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the application of water to concrete through brushing or pressure spraying to prevent the loss of initial moisture and maintain the chemical reaction within the concrete mixture, commonly for seven days.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'watering', false, 0),
      (v_question_id, 'setting', false, 1),
      (v_question_id, 'misting', false, 2),
      (v_question_id, 'curing', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to DPWH D.O. No. 32 series of 2025, this is the class of structural concrete including pre-stressed concrete structures and members.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'According to DPWH D.O. No. 32 series of 2025, this is the class of structural concrete including pre-stressed concrete structures and members.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Class A', false, 0),
      (v_question_id, 'Class B', false, 1),
      (v_question_id, 'Class C', false, 2),
      (v_question_id, 'Class P', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These types of foundation consist of continuous lengths of concrete of prescribed width, depth, and thickness, placed centrally under each wall to be supported.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These types of foundation consist of continuous lengths of concrete of prescribed width, depth, and thickness, placed centrally under each wall to be supported.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Slab foundations', false, 0),
      (v_question_id, 'Strip foundations', true, 1),
      (v_question_id, 'Pile and beam foundations', false, 2),
      (v_question_id, 'Combined footing', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the total period of occupancy in a nursery/weaners'' pen of a swine house?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the total period of occupancy in a nursery/weaners'' pen of a swine house?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '38-45 days', false, 0),
      (v_question_id, '33-38 days', true, 1),
      (v_question_id, '93-153 days', false, 2),
      (v_question_id, '63- 65 days', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many kilograms of cement is needed to create 2 m³ of class A mortar?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How many kilograms of cement is needed to create 2 m³ of class A mortar?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1440 kg', true, 0),
      (v_question_id, '960 kg', false, 1),
      (v_question_id, '1160 kg', false, 2),
      (v_question_id, '1120 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What are the dimensions for maximum piling in a warehouse for bag type storage of grains?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What are the dimensions for maximum piling in a warehouse for bag type storage of grains?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.3 m x 21.9 m x 4.5 m', true, 0),
      (v_question_id, '7.9 m x 21.3 m x 5.4 m', false, 1),
      (v_question_id, '7.4 m x 21.5 m x 4.5 m', false, 2),
      (v_question_id, '7.1 m x 25.3 m x 5.4 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is an abnormal wood that forms on the underside of leaning and crooked trees. It is hard and brittle, and its presence denotes an unbalanced structure in the wood.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is an abnormal wood that forms on the underside of leaning and crooked trees. It is hard and brittle, and its presence denotes an unbalanced structure in the wood.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'shake', false, 0),
      (v_question_id, 'check', false, 1),
      (v_question_id, 'knots', false, 2),
      (v_question_id, 'reaction wood', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A log measures 18 inches in diameter and 24 feet long. Estimate the lumber yield in board feet.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A log measures 18 inches in diameter and 24 feet long. Estimate the lumber yield in board feet.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '290 bd. ft.', false, 0),
      (v_question_id, '292 bd. ft.', false, 1),
      (v_question_id, '294 bd. ft.', true, 2),
      (v_question_id, '296 bd. ft.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are lumber composed of factory plane graded for doors, sash and others cutting for general mill works.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are lumber composed of factory plane graded for doors, sash and others cutting for general mill works.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Yard lumber', false, 0),
      (v_question_id, 'Factory and Shop Lumber', true, 1),
      (v_question_id, 'Structural Lumber', false, 2),
      (v_question_id, 'Plain lumber', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This a wood preservative which is a black to brownish oil produced by the distillation of coal-tar, and has many of the properties required of a preservative, but it increases flammability and is subject to evaporation.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This a wood preservative which is a black to brownish oil produced by the distillation of coal-tar, and has many of the properties required of a preservative, but it increases flammability and is subject to evaporation.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'unleachable metallic salts', false, 0),
      (v_question_id, 'used engine oil', false, 1),
      (v_question_id, 'coal tar', false, 2),
      (v_question_id, 'creosote', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a non-plotting layer in AutoCAD, meaning anything on it will not show up when you print.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a non-plotting layer in AutoCAD, meaning anything on it will not show up when you print.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'defpoints layer', true, 0),
      (v_question_id, 'layer 0', false, 1),
      (v_question_id, 'current layer', false, 2),
      (v_question_id, 'invisible layer', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A supplier offers two types of lumber: Type A: 2" x 6" x 14'' at P65/bd.ft and Type B: 1" × 12" × 14'' at P58/bd.ft. If you need 120 board feet of either type, how much cheaper is Type B?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A supplier offers two types of lumber: Type A: 2" x 6" x 14'' at P65/bd.ft and Type B: 1" × 12" × 14'' at P58/bd.ft. If you need 120 board feet of either type, how much cheaper is Type B?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '720 pesos', false, 0),
      (v_question_id, '840 pesos', true, 1),
      (v_question_id, '960 pesos', false, 2),
      (v_question_id, '1040 pesos', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to DPWH''s DO No. 15 series of 2020, what should be the minimum pavement width of two-lane FMR?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'According to DPWH''s DO No. 15 series of 2020, what should be the minimum pavement width of two-lane FMR?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 m', false, 0),
      (v_question_id, '5.1 m', false, 1),
      (v_question_id, '6 m', false, 2),
      (v_question_id, '6.1 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'From PAES 419:2000 to PAES 419:2015, what is the increase in the spacing between piles in a warehouse for bagged type storage of grain?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'From PAES 419:2000 to PAES 419:2015, what is the increase in the spacing between piles in a warehouse for bagged type storage of grain?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.4m', true, 0),
      (v_question_id, '0.5 m', false, 1),
      (v_question_id, '0.6 m', false, 2),
      (v_question_id, '1.0 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What should be the maximum water cement ratio of concrete if it is intended to be watertight when it is exposed to sea water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What should be the maximum water cement ratio of concrete if it is intended to be watertight when it is exposed to sea water?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.42', false, 0),
      (v_question_id, '0.44', true, 1),
      (v_question_id, '0.46', false, 2),
      (v_question_id, '0.48', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum depth of foundation for greenhouses?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the minimum depth of foundation for greenhouses?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.4 m', false, 0),
      (v_question_id, '0.45 m', true, 1),
      (v_question_id, '0.5 m', false, 2),
      (v_question_id, '0.6 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the total board foot of 16 pieces of a 1-in. x 12-in. x 16-feet wood?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the total board foot of 16 pieces of a 1-in. x 12-in. x 16-feet wood?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '256 bd. ft.', true, 0),
      (v_question_id, '265 bd. ft.', false, 1),
      (v_question_id, '225 bd. ft.', false, 2),
      (v_question_id, '252 bd. ft.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What are the components of a mortar/plaster?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What are the components of a mortar/plaster?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cement, sand, and gravel', false, 0),
      (v_question_id, 'Cement, gravel, and water', false, 1),
      (v_question_id, 'Cement and water', false, 2),
      (v_question_id, 'Cement, sand, and water', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the lighting intensity for the stunning area in a slaughterhouse?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the lighting intensity for the stunning area in a slaughterhouse?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '220 lux', true, 0),
      (v_question_id, '200 lux', false, 1),
      (v_question_id, '500 lux', false, 2),
      (v_question_id, '100 lux', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the slope of wall tops and ledges for agricultural structures involving food processing?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the slope of wall tops and ledges for agricultural structures involving food processing?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 degrees', false, 0),
      (v_question_id, '45 degrees', true, 1),
      (v_question_id, '60 degrees', false, 2),
      (v_question_id, '90 degrees', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Twelve reinforced concrete posts, each measuring 30 cm x 30 cm x 3 meters, will be constructed. Each post requires four vertical reinforcing bars, along with stirrups placed at 30-cm intervals. Determine how many 6-meter standard reinforcing bars are needed to supply all the vertical bars for the project.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Twelve reinforced concrete posts, each measuring 30 cm x 30 cm x 3 meters, will be constructed. Each post requires four vertical reinforcing bars, along with stirrups placed at 30-cm intervals. Determine how many 6-meter standard reinforcing bars are needed to supply all the vertical bars for the project.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16 bars', false, 0),
      (v_question_id, '20 bars', false, 1),
      (v_question_id, '24 bars', true, 2),
      (v_question_id, '28 bars', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These have a thread which gives them a greater holding power and resistance to withdrawal than nails and can easily be removed without damage to the wood.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These have a thread which gives them a greater holding power and resistance to withdrawal than nails and can easily be removed without damage to the wood.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bolts and nuts', false, 0),
      (v_question_id, 'Locks and latches', false, 1),
      (v_question_id, 'screws', true, 2),
      (v_question_id, 'rivets', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These plans show the layout of the buildings in relation to each other and to other objects. This type of drawing must be according to scale, it is essential for the proper planning and layout of the farmstead and must indicate the positions of the existing and proposed: roads, buildings, fences, watering points, pipelines, septic tanks, electric cables, telephone poles and trees.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These plans show the layout of the buildings in relation to each other and to other objects. This type of drawing must be according to scale, it is essential for the proper planning and layout of the farmstead and must indicate the positions of the existing and proposed: roads, buildings, fences, watering points, pipelines, septic tanks, electric cables, telephone poles and trees.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Site plans', true, 0),
      (v_question_id, 'Floor plan', false, 1),
      (v_question_id, 'Foundation plan', false, 2),
      (v_question_id, 'Roofing plan', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A storage room is estimated to consume 320 pieces of 4-in. thick CHB. How many cubic meters of sand is needed to formulate the class B mortar that will be used in filling these CHBs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A storage room is estimated to consume 320 pieces of 4-in. thick CHB. How many cubic meters of sand is needed to formulate the class B mortar that will be used in filling these CHBs?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.96 m³', true, 0),
      (v_question_id, '1 m³', false, 1),
      (v_question_id, '0.48 m³', false, 2),
      (v_question_id, '0.5 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine weight of the foundation required to carry the load of an internal combustion engine use to drive a 10 sacks per hour multi-pass rice mill. The engine is a 40 hp diesel at a maximum engine speed of 870 rpm. The total weight of the engine is 982 kg. Assume a concrete density of 2,406 kg/m3 .';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Determine weight of the foundation required to carry the load of an internal combustion engine use to drive a 10 sacks per hour multi-pass rice mill. The engine is a 40 hp diesel at a maximum engine speed of 870 rpm. The total weight of the engine is 982 kg. Assume a concrete density of 2,406 kg/m3 .', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3186.13 kg', true, 0),
      (v_question_id, '3318.36 kg', false, 1),
      (v_question_id, '3631.86 kg', false, 2),
      (v_question_id, '3168.31 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the bulk density of light concrete.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the bulk density of light concrete.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1450–1650 kg', false, 0),
      (v_question_id, '850–1500 kg', false, 1),
      (v_question_id, '1800–2500 kg', false, 2),
      (v_question_id, '500–1800 kg', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a wood joint made by beveling each two parts to be joined, usually at a 45 degree angle, to form a corner usually a 90 degree.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a wood joint made by beveling each two parts to be joined, usually at a 45 degree angle, to form a corner usually a 90 degree.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Straight joint', false, 0),
      (v_question_id, 'Corner joint', false, 1),
      (v_question_id, 'Miter joint', true, 2),
      (v_question_id, 'Lap joint', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This code  provide for all buildings and structures, a framework of minimum standards and requirements to regulate and control their location, site, design, quality of materials, construction, use, occupancy, and maintenance.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This code  provide for all buildings and structures, a framework of minimum standards and requirements to regulate and control their location, site, design, quality of materials, construction, use, occupancy, and maintenance.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'National Building Code of the Philippines', true, 0),
      (v_question_id, 'National Structural Code of the Philippines', false, 1),
      (v_question_id, 'Constructors'' Performance Evaluation System (CPES)', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is a comprehensive set of regulations and standards that govern the design, construction, and maintenance of structures within the Philippines. It aims to ensure safety, durability, and resilience of buildings and infrastructure against natural and man-made hazards such as earthquakes, typhoons, and other environmental factors prevalent in the country.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is a comprehensive set of regulations and standards that govern the design, construction, and maintenance of structures within the Philippines. It aims to ensure safety, durability, and resilience of buildings and infrastructure against natural and man-made hazards such as earthquakes, typhoons, and other environmental factors prevalent in the country.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'National Building Code of the Philippines', false, 0),
      (v_question_id, 'National Structural Code of the Philippines', true, 1),
      (v_question_id, 'Constructors'' Performance Evaluation System (CPES)', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the size of reinforcement bar for concrete slabs in slaughterhouses?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the size of reinforcement bar for concrete slabs in slaughterhouses?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 mm dia. RSB', true, 0),
      (v_question_id, '12 mm dia. RSB', false, 1),
      (v_question_id, '16 mm dia. RSB', false, 2),
      (v_question_id, '20 mm dia. RSB', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of concrete mixture that should be used for foundations unless otherwise stated.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of concrete mixture that should be used for foundations unless otherwise stated.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Coarse concrete', true, 0),
      (v_question_id, 'Normal concrete', false, 1),
      (v_question_id, 'Fine concrete', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Inn FMRs, how long shall forms for concrete remain in place undisturbed after concrete pouring?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Inn FMRs, how long shall forms for concrete remain in place undisturbed after concrete pouring?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Not less than 72 hours.', false, 0),
      (v_question_id, 'Not less than 48 hours', false, 1),
      (v_question_id, 'Not less than 36 hours', false, 2),
      (v_question_id, 'Not less than 24 hours', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the maximum stacking height for cell packs in a fruit and vegetable storage.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the maximum stacking height for cell packs in a fruit and vegetable storage.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '16 units', false, 0),
      (v_question_id, '12 units', true, 1),
      (v_question_id, '8 units', false, 2),
      (v_question_id, '4 units', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using Fuller''s rule, how many cubic meters of gravel is needed for a 5 m³ class C concrete mixture?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Using Fuller''s rule, how many cubic meters of gravel is needed for a 5 m³ class C concrete mixture?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 m³', false, 0),
      (v_question_id, '4.53 m³', false, 1),
      (v_question_id, '4.62 m³', true, 2),
      (v_question_id, '4.89 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the density of concrete used in the estimate of foundation for agricultural machinery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the density of concrete used in the estimate of foundation for agricultural machinery?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1440 kg/m³', false, 0),
      (v_question_id, '2406 kg/m³', true, 1),
      (v_question_id, '2399 kg/m³', false, 2),
      (v_question_id, '1780 kg/m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A graphic representation of the view as seen by the eyes, it shows the appearance of the finished building. This drawing represents the actual, in three-dimensional form of the proposed building.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A graphic representation of the view as seen by the eyes, it shows the appearance of the finished building. This drawing represents the actual, in three-dimensional form of the proposed building.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sketch', false, 0),
      (v_question_id, 'Location plan', false, 1),
      (v_question_id, 'Site plan', false, 2),
      (v_question_id, 'Perspective', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This unit consisting of upright containers used for storage and handling of grains in bulk and provided with necessary equipment and accessories.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This unit consisting of upright containers used for storage and handling of grains in bulk and provided with necessary equipment and accessories.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Warehouse', false, 0),
      (v_question_id, 'Silo', true, 1),
      (v_question_id, 'Storage house', false, 2),
      (v_question_id, 'Grain tank', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A silo that has an aspect ratio greater than 1.0 and less than 2.0.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A silo that has an aspect ratio greater than 1.0 and less than 2.0.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Retaining', false, 0),
      (v_question_id, 'Squat', false, 1),
      (v_question_id, 'Intermediate', true, 2),
      (v_question_id, 'Slender', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'From the NSCP, what is the basic wind speed of Zone 1 in the Philippines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'From the NSCP, what is the basic wind speed of Zone 1 in the Philippines?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '250 kph', true, 0),
      (v_question_id, '200 kph', false, 1),
      (v_question_id, '150 kph', false, 2),
      (v_question_id, '100 kph', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'From the NSCP, under what seismic zone classification are most provinces of the Philippines?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'From the NSCP, under what seismic zone classification are most provinces of the Philippines?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Zone 1', false, 0),
      (v_question_id, 'Zone 2', false, 1),
      (v_question_id, 'Zone 3', false, 2),
      (v_question_id, 'Zone 4', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An open building is a building having each wall opened at a minimum of  ?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'An open building is a building having each wall opened at a minimum of  ?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '80%', true, 1),
      (v_question_id, '70%', false, 2),
      (v_question_id, '60%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the strongest direction of a wood and is parallel to the fiber grain.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the strongest direction of a wood and is parallel to the fiber grain.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'axial', true, 0),
      (v_question_id, 'radial', false, 1),
      (v_question_id, 'tangential', false, 2),
      (v_question_id, 'horizontal', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A wall fence which measures 10 m x 3 m is to be plastered on both sides, how many 40-kg cement bags and how much cubic meter/s of sand is needed considering a class C 25 mm thick plaster?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A wall fence which measures 10 m x 3 m is to be plastered on both sides, how many 40-kg cement bags and how much cubic meter/s of sand is needed considering a class C 25 mm thick plaster?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '14 bags, 1.5 m³ sand', true, 0),
      (v_question_id, '13 bags, 1.5 m³ sand', false, 1),
      (v_question_id, '7 bags, 0.75 m³ sand', false, 2),
      (v_question_id, '6 bags, 0.75 m³ sand', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'They are used to fix corrugated sheet materials and must be long enough to go at least 20 mm into the wood.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'They are used to fix corrugated sheet materials and must be long enough to go at least 20 mm into the wood.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Lost head nails', false, 0),
      (v_question_id, 'Concrete nails', false, 1),
      (v_question_id, 'Roofing nails', true, 2),
      (v_question_id, 'Clout or slate nails', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the capacity of cement bags is used in Fuller''s rule of concrete estimate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the capacity of cement bags is used in Fuller''s rule of concrete estimate?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Approximately 40 kg', true, 0),
      (v_question_id, 'Approximately 50 kg', false, 1),
      (v_question_id, 'Approximately 94 kg', false, 2),
      (v_question_id, 'Approximately 110 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using Fuller''s rule, how many bags of cement is needed for a one cubic meter class AA concrete?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Using Fuller''s rule, how many bags of cement is needed for a one cubic meter class AA concrete?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.5 bags', false, 0),
      (v_question_id, '9.5 bags', false, 1),
      (v_question_id, '9 bags', false, 2),
      (v_question_id, '10 bags', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Five dry sows are to be housed in a pen with a length of 3 m, what should be the width of the pen?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Five dry sows are to be housed in a pen with a length of 3 m, what should be the width of the pen?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 m', false, 0),
      (v_question_id, '3 m', true, 1),
      (v_question_id, '4 m', false, 2),
      (v_question_id, '5 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What should be the orientation of slats for partially slotted floor in a swine house?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What should be the orientation of slats for partially slotted floor in a swine house?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Perpendicular to the length of the pen', true, 0),
      (v_question_id, 'Parallel to the length of the pen', false, 1),
      (v_question_id, 'Angled at 45 degrees', false, 2),
      (v_question_id, 'Angled at 60 degrees', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many community nest box is needed to be provided for 45 layers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How many community nest box is needed to be provided for 45 layers?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'one', false, 0),
      (v_question_id, 'two', true, 1),
      (v_question_id, 'three', false, 2),
      (v_question_id, 'four', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a container filled with a liquid solution used to immerse livestock or disinfect footwear. It should be provided in a cattle ranch if the herd is 200 units or more.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a container filled with a liquid solution used to immerse livestock or disinfect footwear. It should be provided in a cattle ranch if the herd is 200 units or more.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Disinfection pool', false, 0),
      (v_question_id, 'Animal pond', false, 1),
      (v_question_id, 'Dipping vat', true, 2),
      (v_question_id, 'Sanitation bath', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is any physical change made on buildings/structures to increase the value, quality, and/or to improve the aesthetic.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is any physical change made on buildings/structures to increase the value, quality, and/or to improve the aesthetic.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'alteration', false, 0),
      (v_question_id, 'addition', false, 1),
      (v_question_id, 'renovation', true, 2),
      (v_question_id, 'repair', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Starting from 2026, which government agency will be taking over the development of farm-to-market roads?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Starting from 2026, which government agency will be taking over the development of farm-to-market roads?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Department of Public Works and Highways (DPWH)', false, 0),
      (v_question_id, 'Department of Agriculture (DA)', true, 1),
      (v_question_id, 'Department of Agrarian Reform (DAR)', false, 2),
      (v_question_id, 'Department of Interior and Local Government (DILG)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'From the National Farm-to-Market Roads Network Plan 2023-2028, what is the total target of FMRs to be concreted within the country?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'From the National Farm-to-Market Roads Network Plan 2023-2028, what is the total target of FMRs to be concreted within the country?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '64,155.20 km', true, 0),
      (v_question_id, '67,255.46 km', false, 1),
      (v_question_id, '66,253.89 km', false, 2),
      (v_question_id, '65,766.23 km', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a type of stall that allows the animals to proceed directly forward after milking is completed.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a type of stall that allows the animals to proceed directly forward after milking is completed.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'back-out stall', false, 0),
      (v_question_id, 'walk-through stall', true, 1),
      (v_question_id, 'turn-around stall', false, 2),
      (v_question_id, 'rotating stall', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using Fuller''s rule, how many cubic meters of sand is needed to create a 10 m³ class B concrete mixture?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Using Fuller''s rule, how many cubic meters of sand is needed to create a 10 m³ class B concrete mixture?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 m³', false, 0),
      (v_question_id, '4.53 m³', false, 1),
      (v_question_id, '4.62 m³', true, 2),
      (v_question_id, '4.89 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Locations of vents for warehouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Locations of vents for warehouse.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Near the floor level', false, 0),
      (v_question_id, 'Top of the wall near grid line', false, 1),
      (v_question_id, 'Top of the roof and the ridge', false, 2),
      (v_question_id, 'All of the above', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At what minimum distance shall the farm workshop and machinery shed be situated from other buildings to reduce fire hazard, to allow for future expansion, and maneuvering and parking of machinery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'At what minimum distance shall the farm workshop and machinery shed be situated from other buildings to reduce fire hazard, to allow for future expansion, and maneuvering and parking of machinery?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 m', false, 0),
      (v_question_id, '35 m', false, 1),
      (v_question_id, '50 m', false, 2),
      (v_question_id, '45 m', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the graded portion of a highway between top and side slopes, prepared as a foundation for the pavement structure and shoulder.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the graded portion of a highway between top and side slopes, prepared as a foundation for the pavement structure and shoulder.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Road bed', true, 0),
      (v_question_id, 'Roadway embankment', false, 1),
      (v_question_id, 'Roadway', false, 2),
      (v_question_id, 'Road carriageway', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'These are types of hydrated lime which develop high, early plasticity and higher water retentivity and by a limitation on their unhydrated oxide content.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'These are types of hydrated lime which develop high, early plasticity and higher water retentivity and by a limitation on their unhydrated oxide content.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Type N', false, 0),
      (v_question_id, 'Type S', false, 1),
      (v_question_id, 'Type NA and SA', false, 2),
      (v_question_id, 'Type S and SA', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the minimum thickness of roadside masonry V-ditch?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the minimum thickness of roadside masonry V-ditch?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.15 m', false, 0),
      (v_question_id, '0.20 m', false, 1),
      (v_question_id, '0.25 m', true, 2),
      (v_question_id, '0.30 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is described as the difference in crossfall between the pavement and its adjacent shoulder.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is described as the difference in crossfall between the pavement and its adjacent shoulder.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shoulder gradient', false, 0),
      (v_question_id, 'Pavement difference', false, 1),
      (v_question_id, 'Shoulder rollover', true, 2),
      (v_question_id, 'Pavement rollover', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the property of a metal by virtue of which it can be drawn into wires or elongated before rupture takes place.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the property of a metal by virtue of which it can be drawn into wires or elongated before rupture takes place.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ductility', true, 0),
      (v_question_id, 'plasticity', false, 1),
      (v_question_id, 'elasticity', false, 2),
      (v_question_id, 'malleability', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The CHB estimate per square meter of wall assuming there is no breakage during construction.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The CHB estimate per square meter of wall assuming there is no breakage during construction.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 pcs/m²', false, 0),
      (v_question_id, '12.5 pcs/m²', true, 1),
      (v_question_id, '13 pcs/m²', false, 2),
      (v_question_id, '13.5 pcs/m²', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Environmental Engineering and Science (STRUCTURES_ENVIRONMENT) — 17 question(s)
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
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Environmental Engineering and Science', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'pH value that should be maintained in biogas digesters to maintain proper digestion process and prevent toxic effect to methanogenic bacteria.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'pH value that should be maintained in biogas digesters to maintain proper digestion process and prevent toxic effect to methanogenic bacteria.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 to 5.5', false, 0),
      (v_question_id, '5 to 6.5', false, 1),
      (v_question_id, '6.5 to 7', false, 2),
      (v_question_id, '7 to 8.5', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A biogas digester is to be fed with manure from 20 feedlot cows. By utilizing the minimum recommended retention period for cow manure, what is the expected volume of biogas to be produced if the gas production potential is at 0.026 m³/kg manure?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A biogas digester is to be fed with manure from 20 feedlot cows. By utilizing the minimum recommended retention period for cow manure, what is the expected volume of biogas to be produced if the gas production potential is at 0.026 m³/kg manure?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '291.2 m³', false, 0),
      (v_question_id, '78 m³', false, 1),
      (v_question_id, '145.6 m³', true, 2),
      (v_question_id, '135.2 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a part of total solids which pass through the filter during the filtration procedure of liquid wastes.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a part of total solids which pass through the filter during the filtration procedure of liquid wastes.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dissolved solids', true, 0),
      (v_question_id, 'Filtered solids', false, 1),
      (v_question_id, 'Volatile solids', false, 2),
      (v_question_id, 'Suspended solids', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm intends to integrate a biogas digester in its operations. They intent to utilize the manure that will be produced by their chicken layers. If they''ve found out that they would need 10 m³ biogas per day, how many layers do they need to sustain this? Use 30 days retention period.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A farm intends to integrate a biogas digester in its operations. They intent to utilize the manure that will be produced by their chicken layers. If they''ve found out that they would need 10 m³ biogas per day, how many layers do they need to sustain this? Use 30 days retention period.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2052 heads', true, 0),
      (v_question_id, '2000 heads', false, 1),
      (v_question_id, '2051 heads', false, 2),
      (v_question_id, '2223 heads', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the clay content of soils in which agricultural waste management structures shall be constructed on?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the clay content of soils in which agricultural waste management structures shall be constructed on?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30%', false, 0),
      (v_question_id, '25%', false, 1),
      (v_question_id, '20%', false, 2),
      (v_question_id, '15%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The manure of thirty 75-kg finishers is going to be fed into a biogas digester. Utilizing a 25-day retention period and a 1:2 slurry ratio, how much biogas can be produced daily?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The manure of thirty 75-kg finishers is going to be fed into a biogas digester. Utilizing a 25-day retention period and a 1:2 slurry ratio, how much biogas can be produced daily?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '13.92 m³/day', true, 0),
      (v_question_id, '29. 01 m³/day', false, 1),
      (v_question_id, '39 m³/day', false, 2),
      (v_question_id, '32.63 m³/day', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The composting of agricultural solid wastes requires aerobic condition. What minimum percentage of oxygen shall be maintained in these condition?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The composting of agricultural solid wastes requires aerobic condition. What minimum percentage of oxygen shall be maintained in these condition?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25%', false, 0),
      (v_question_id, '15%', false, 1),
      (v_question_id, '10%', false, 2),
      (v_question_id, '5%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a biogas digester requiring fast movement of substrates, gravity cannot be used due to topographical reasons. Instead, what type of pump can be used if the substrate utilized has higher solid contents?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a biogas digester requiring fast movement of substrates, gravity cannot be used due to topographical reasons. Instead, what type of pump can be used if the substrate utilized has higher solid contents?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Centrifugal pumps', false, 0),
      (v_question_id, 'Rotary pumps', false, 1),
      (v_question_id, 'Positive displacement pumps', true, 2),
      (v_question_id, 'Submersible pump', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a fixed type biogas digester, how much of the digester volume is occupied by slurry?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In a fixed type biogas digester, how much of the digester volume is occupied by slurry?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '66%', false, 1),
      (v_question_id, '60%', false, 2),
      (v_question_id, '80%', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the recommended maximum retention period in a biogas digester of animal manure mixed with plant material?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the recommended maximum retention period in a biogas digester of animal manure mixed with plant material?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '80 days', true, 0),
      (v_question_id, '50 days', false, 1),
      (v_question_id, '40 days', false, 2),
      (v_question_id, '55 days', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the amount of organic matters in a substrate that can be degraded by anaerobic microorganisms. It also indicates the biogas output per unit quantity of substrate.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the amount of organic matters in a substrate that can be degraded by anaerobic microorganisms. It also indicates the biogas output per unit quantity of substrate.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'methanogenic potential (MP)', false, 0),
      (v_question_id, 'biogas potential (BP)', false, 1),
      (v_question_id, 'biochemical methane potential (BMP)', true, 2),
      (v_question_id, 'biochemical methane quality (BMQ)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the average period time the slurry is in the inlet tank prior to digestion, expressed in days.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the average period time the slurry is in the inlet tank prior to digestion, expressed in days.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'retention period', false, 0),
      (v_question_id, 'storage period', true, 1),
      (v_question_id, 'digestion period', false, 2),
      (v_question_id, 'fermentation period', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In wet anaerobic digestion, the organic material used has a consistency of how much dry matter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In wet anaerobic digestion, the organic material used has a consistency of how much dry matter?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10-20% or less', true, 0),
      (v_question_id, '10-15% or less', false, 1),
      (v_question_id, '5-10% or less', false, 2),
      (v_question_id, '15-20% or less', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farm produces 2000 kg of animal manure monthly, if this is fed into a biogas digester and retained for 30 days, what is the total volume of the digester at 1:1 slurry ratio?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A farm produces 2000 kg of animal manure monthly, if this is fed into a biogas digester and retained for 30 days, what is the total volume of the digester at 1:1 slurry ratio?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 m³', false, 0),
      (v_question_id, '6 m³', false, 1),
      (v_question_id, '4 m³', true, 2),
      (v_question_id, '8 m³', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is a biogas digester with a volume of 140 to 7000 cubic meter.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is a biogas digester with a volume of 140 to 7000 cubic meter.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'household', false, 0),
      (v_question_id, 'small-scale', true, 1),
      (v_question_id, 'medium-scale', false, 2),
      (v_question_id, 'large-scale', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Type of gutter for agricultural liquid waste management structures collecting cattle manure.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Type of gutter for agricultural liquid waste management structures collecting cattle manure.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gravity drain gutter', false, 0),
      (v_question_id, 'Step dam gutters', true, 1),
      (v_question_id, 'Scrape gutters', false, 2),
      (v_question_id, 'Flush gutter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the composting time for aerated static pile.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the composting time for aerated static pile.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 months', false, 0),
      (v_question_id, '4 weeks', true, 1),
      (v_question_id, '7 days', false, 2),
      (v_question_id, '30 days', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Design and Management of AB Processing System (BIOPROCESS) — 2 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A primary processing plant for fresh onions has an area of 1700 m², what is the capacity of the plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A primary processing plant for fresh onions has an area of 1700 m², what is the capacity of the plant?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '170 tons', false, 0),
      (v_question_id, '68 tons', false, 1),
      (v_question_id, '85 tons', true, 2),
      (v_question_id, '90 tons', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The temporary storage of raw materials in a primary processing plant for fresh fruit and vegetable shall be able to store materials for how long?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The temporary storage of raw materials in a primary processing plant for fresh fruit and vegetable shall be able to store materials for how long?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2-5 processing days', true, 0),
      (v_question_id, '3-5 processing days', false, 1),
      (v_question_id, '3-4 processing days', false, 2),
      (v_question_id, '2-4 processing days', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Elements of Food Processing and Process Design (BIOPROCESS) — 3 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is an insect control technique which creates airtight conditions to reduce oxygen and increase carbon dioxide levels arresting insects and stopping mold development.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is an insect control technique which creates airtight conditions to reduce oxygen and increase carbon dioxide levels arresting insects and stopping mold development.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'sanitation', false, 0),
      (v_question_id, 'chemical control', false, 1),
      (v_question_id, 'hermetic storage', true, 2),
      (v_question_id, 'Controlled storage', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This is the subjecting of cultures to conditions favorable to the growth of the plant tissue.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'This is the subjecting of cultures to conditions favorable to the growth of the plant tissue.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'fermentation', false, 0),
      (v_question_id, 'incubation', true, 1),
      (v_question_id, 'storage', false, 2),
      (v_question_id, 'ageing', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It is the condition that describes the freedom of plant materials, culture medium, confines of the culture vessel from contaminating microorganisms.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It is the condition that describes the freedom of plant materials, culture medium, confines of the culture vessel from contaminating microorganisms.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'sanitized', false, 0),
      (v_question_id, 'sterilized', false, 1),
      (v_question_id, 'asepsis', true, 2),
      (v_question_id, 'sepsis', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Engineering Economy and Project Feasibility Analysis (PROJECT_MGMT_RDE) — 7 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'PROJECT_MGMT_RDE';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: PROJECT_MGMT_RDE';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Engineering Economy and Project Feasibility Analysis' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Engineering Economy and Project Feasibility Analysis', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The CPES rating is expressed as a numerical score with corresponding qualitative description. A rating of 83%–89% typically corresponds to which qualitative rating?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'The CPES rating is expressed as a numerical score with corresponding qualitative description. A rating of 83%–89% typically corresponds to which qualitative rating?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Outstanding', false, 0),
      (v_question_id, 'Very Satisfactory', false, 1),
      (v_question_id, 'Satisfactory', true, 2),
      (v_question_id, 'Unsatisfactory', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Maximum rating for time upon completion of projects for contracts which do not involve the supply of construction materials or where the materials are supplied by the owner/agency.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Maximum rating for time upon completion of projects for contracts which do not involve the supply of construction materials or where the materials are supplied by the owner/agency.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5', true, 0),
      (v_question_id, '0.4', false, 1),
      (v_question_id, '0.3', false, 2),
      (v_question_id, '0.2', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A project is to be evaluated twice during construction, at what percentage of physical completion shall the first evaluation be conducted?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A project is to be evaluated twice during construction, at what percentage of physical completion shall the first evaluation be conducted?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30% physically complete', true, 0),
      (v_question_id, '35% physically complete', false, 1),
      (v_question_id, '40% physically complete', false, 2),
      (v_question_id, '50% physically complete', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In CPES, what is the weight of the evaluation upon completion of a horizontal project?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'In CPES, what is the weight of the evaluation upon completion of a horizontal project?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40%', true, 0),
      (v_question_id, '30%', false, 1),
      (v_question_id, '60%', false, 2),
      (v_question_id, '70%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What type of license must a constructors'' performance evaluator possess?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What type of license must a constructors'' performance evaluator possess?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Professional Architect', false, 0),
      (v_question_id, 'Professional Engineer', false, 1),
      (v_question_id, 'Driver''s License', false, 2),
      (v_question_id, 'Both A and B', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many visits shall, at least, be done by the CPE during the construction of projects with a duration of 85 calendar days?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'How many visits shall, at least, be done by the CPE during the construction of projects with a duration of 85 calendar days?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'one', true, 0),
      (v_question_id, 'two', false, 1),
      (v_question_id, 'three', false, 2),
      (v_question_id, 'four', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the maximum rating of Environmental, Safety and Health (ESH) during construction of projects which involve the supply of construction materials?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'What is the maximum rating of Environmental, Safety and Health (ESH) during construction of projects which involve the supply of construction materials?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.07', true, 0),
      (v_question_id, '0.05', false, 1),
      (v_question_id, '0.10', false, 2),
      (v_question_id, '0.15', false, 3);
  END IF;

END $$;

-- =====================================================================
-- Topic: Laws, Professional Standards, and Ethics (LAWS_ETHICS) — 3 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAWS_ETHICS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAWS_ETHICS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Laws, Professional Standards, and Ethics' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Laws, Professional Standards, and Ethics', 'area_1') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'It refers to one of the implementing Boards of the CIAP which is tasked to formulate, recommend and implement policies, guidelines, plans and programs for the efficient implementation of public and private construction in the country.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'It refers to one of the implementing Boards of the CIAP which is tasked to formulate, recommend and implement policies, guidelines, plans and programs for the efficient implementation of public and private construction in the country.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Philippine Contractors Accreditation Board (PCAB)', false, 0),
      (v_question_id, 'Philippine Domestic Construction Board (PDCB)', true, 1),
      (v_question_id, 'National Philippine Board of Construction (NPBC)', false, 2),
      (v_question_id, 'INFRACOM', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A document issued by the Building Official (BO) to an owner/applicant to proceed with the construction, installation, addition, alteration, renovation, conversion, repair, moving, demolition or other work activity of a specific project/building/structure or portions.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'A document issued by the Building Official (BO) to an owner/applicant to proceed with the construction, installation, addition, alteration, renovation, conversion, repair, moving, demolition or other work activity of a specific project/building/structure or portions.', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Application form', false, 0),
      (v_question_id, 'Building permit', true, 1),
      (v_question_id, 'Referral code', false, 2),
      (v_question_id, 'Building regulation form', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which government agency is primarily responsible for enforcing PD 1096?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch)
    VALUES (v_topic_id, NULL, 'Which government agency is primarily responsible for enforcing PD 1096?', 'single_choice', 'medium', NULL, NULL, NULL, 'draft', false, NULL)
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Department of Public Works and Highways (DPWH)', true, 0),
      (v_question_id, 'Department of Agriculture (DA)', false, 1),
      (v_question_id, 'Department of Agrarian Reform (DAR)', false, 2),
      (v_question_id, 'Department of Interior and Local Government (DILG)', false, 3);
  END IF;

END $$;
