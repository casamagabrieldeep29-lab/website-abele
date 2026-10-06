-- Tractor selection and sizing quiz batch (30 questions, 1 topic). Every definition,
-- formula, and worked figure is drawn directly from agricultural machinery and power
-- engineering review materials with solved problems and answer keys, read in full
-- (2026-10-02) -- no invented facts. Numeric answers were independently recomputed.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since this is general machinery-sizing review material, not a PAES standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Selection of Tractor Size, Implements, and Other Specifications (POWER_ENERGY_MACHINERY) -- 30 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Selection of Tractor Size, Implements, and Other Specifications' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Selection of Tractor Size, Implements, and Other Specifications';
  END IF;

  -- 1. Tractor size basis
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which tillage operations demand the highest draft requirements, such that the determination of tractor size is generally based on them?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which tillage operations demand the highest draft requirements, such that the determination of tractor size is generally based on them?', 'single_choice', 'easy', 'Primary tillage operations (such as plowing) demand the highest draft requirements, so the process of determining tractor size is based on them.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Crop spraying operations', false, 0),
      (v_question_id, 'Secondary tillage operations such as harrowing', false, 1),
      (v_question_id, 'Primary tillage operations such as plowing', true, 2),
      (v_question_id, 'Planting and seeding operations', false, 3);
  END IF;

  -- 2. Methods of estimating tractor size
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following are the two methods of estimating the size of tractor needed for a tillage operation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following are the two methods of estimating the size of tractor needed for a tillage operation?', 'single_choice', 'medium', 'Tractor size can be estimated (a) from the specific draft (unit draft) of the soil for the given implement, and (b) from the specific resistance of implements, using data found in handbooks and literature on agricultural engineering. Using the same procedure, the power requirement of the operation and the approximate size of the power unit can then be calculated.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Use of engine displacement and number of cylinders', false, 0),
      (v_question_id, 'Use of wheel diameter and tire pressure', false, 1),
      (v_question_id, 'Use of the specific draft of the soil and use of the specific resistance of implements', true, 2),
      (v_question_id, 'Use of fuel tank capacity and PTO speed', false, 3);
  END IF;

  -- 3. Unit draft definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In estimating tractor size, the unit draft (specific draft) of a soil refers to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In estimating tractor size, the unit draft (specific draft) of a soil refers to:', 'single_choice', 'easy', 'Unit draft is the specific resistance of a given type of soil, at a given moisture content, to the passage of a tillage implement. It is multiplied by the cross-sectional area of the soil cut to estimate the draft of an implement.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The maximum pull that the tractor can deliver at its drawbar', false, 0),
      (v_question_id, 'The specific resistance of a given type of soil, at a given moisture content, to the passage of a tillage implement', true, 1),
      (v_question_id, 'The power delivered by the tractor engine to the PTO shaft', false, 2),
      (v_question_id, 'The weight transferred from the front wheels to the rear wheels of the tractor', false, 3);
  END IF;

  -- 4. Drawbar versus PTO power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A farmer plows a large field of heavy clay soil with a disc plow and later uses a rotary tiller to prepare the seedbed. The tractor struggles during plowing but performs well with the rotary tiller. Which type of power is most critical for each operation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A farmer plows a large field of heavy clay soil with a disc plow and later uses a rotary tiller to prepare the seedbed. The tractor struggles during plowing but performs well with the rotary tiller. Which type of power is most critical for each operation?', 'single_choice', 'medium', 'Drawbar power is the ability of the tractor to pull heavy loads such as plows, harrows, and trailers, so it is essential for traction operations like plowing. PTO power is the power delivered by the engine to external implements through the PTO shaft, so it is critical for equipment with rotating parts such as rotary tillers and mowers.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PTO power for plowing; drawbar power for seedbed preparation', false, 0),
      (v_question_id, 'Drawbar power for plowing; PTO power for seedbed preparation', true, 1),
      (v_question_id, 'Drawbar power for both plowing and seedbed preparation', false, 2),
      (v_question_id, 'PTO power for both plowing and seedbed preparation', false, 3);
  END IF;

  -- 5. PTO-driven implements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which method of tractor power delivery is used to operate implements with rotating parts, such as rotary tillers and rotary mowers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which method of tractor power delivery is used to operate implements with rotating parts, such as rotary tillers and rotary mowers?', 'single_choice', 'easy', 'The power take-off (PTO) is a rotating shaft at the rear (and sometimes front) of the tractor that transfers rotary power from the engine directly to implements such as rotary tillers and rotary mowers. Common PTO speeds are 540 and 1,000 rpm. Drawbar power, in contrast, is used to pull or tow implements such as moldboard plows, disc harrows, and trailers.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Electrical power', false, 0),
      (v_question_id, 'Drawbar power', false, 1),
      (v_question_id, 'Hydraulic power', false, 2),
      (v_question_id, 'Power take-off (PTO) power', true, 3);
  END IF;

  -- 6. General-purpose tillage implements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Rotavators and floating tillers, which combine primary and secondary tillage in a single operation, are classified as implements for what type of tillage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Rotavators and floating tillers, which combine primary and secondary tillage in a single operation, are classified as implements for what type of tillage?', 'single_choice', 'easy', 'General-purpose tillage combines primary and secondary tillage in a single operation, works to a depth of up to 6 inches, and is commonly referred to as rotavating or rototilling. Its implements are rotavators and floating tillers.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Primary tillage', false, 0),
      (v_question_id, 'Secondary tillage', false, 1),
      (v_question_id, 'Subsoiling', false, 2),
      (v_question_id, 'General-purpose tillage', true, 3);
  END IF;

  -- 7. Hitch for large trailing implements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which hitch system for a tractor is suitable for large, heavy implements that are trailed behind the tractor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which hitch system for a tractor is suitable for large, heavy implements that are trailed behind the tractor?', 'single_choice', 'medium', 'The drawbar hitch system is the hitch suited for large, heavy trailing implements, with the draft force of the tractor acting at the hitch.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drawbar hitch system', true, 0),
      (v_question_id, 'Semi-mounted hitch system', false, 1),
      (v_question_id, 'Belt-pulley hitch system', false, 2),
      (v_question_id, 'Three-point hitch system', false, 3);
  END IF;

  -- 8. Drawbar pull on a slope
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The effective drawbar pull of a tractor is reduced by about how much for every percent of grade (slope)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The effective drawbar pull of a tractor is reduced by about how much for every percent of grade (slope)?', 'single_choice', 'medium', 'The effective drawbar pull of a tractor is reduced by about 1% for every percent of grade, which should be considered when sizing a tractor for sloping fields.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10%', false, 0),
      (v_question_id, '1%', true, 1),
      (v_question_id, '0.1%', false, 2),
      (v_question_id, '5%', false, 3);
  END IF;

  -- 9. Rolling resistance coefficient in deep mud
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the coefficient of rolling resistance used for a wheel-type tractor operating on deep mud?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the coefficient of rolling resistance used for a wheel-type tractor operating on deep mud?', 'single_choice', 'medium', 'The coefficient of rolling resistance of a wheel-type tractor is 0.25 on deep mud, compared with 0.07 on dry hard ground. Rolling resistance is the weight of the tractor multiplied by this coefficient.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.45', false, 0),
      (v_question_id, '0.07', false, 1),
      (v_question_id, '0.25', true, 2),
      (v_question_id, '0.35', false, 3);
  END IF;

  -- 10. Recommended wheel slip for 4WD tractors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the recommended level of wheel slip on tilled soil for a four-wheel-drive tractor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the recommended level of wheel slip on tilled soil for a four-wheel-drive tractor?', 'single_choice', 'medium', 'The recommended level of wheel slip on tilled soil is 10% for a four-wheel-drive tractor and 12% for a two-wheel-drive tractor.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5%', false, 0),
      (v_question_id, '12%', false, 1),
      (v_question_id, '20%', false, 2),
      (v_question_id, '10%', true, 3);
  END IF;

  -- 11. Drawbar power from dynamometer pull
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A drawbar dynamometer shows that the average pull required by a machine is 20 kN. If the tractor travels at 5 kph, what is the power developed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A drawbar dynamometer shows that the average pull required by a machine is 20 kN. If the tractor travels at 5 kph, what is the power developed?', 'single_choice', 'easy', 'Drawbar power = force x speed. With force in kN and speed in kph, P (kW) = F x S / 3.6 = (20)(5) / 3.6 = 27.78 kW. The result is in kW, so it should not be read as hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '27.78 kW', true, 0),
      (v_question_id, '6.67 hp', false, 1),
      (v_question_id, '56.7 kW', false, 2),
      (v_question_id, '27.78 hp', false, 3);
  END IF;

  -- 12. Drawbar horsepower from pull in pounds
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor operating at 3.5 mph develops a drawbar pull of 3,000 lb while pulling a trailer. Estimate its required drawbar horsepower.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor operating at 3.5 mph develops a drawbar pull of 3,000 lb while pulling a trailer. Estimate its required drawbar horsepower.', 'single_choice', 'easy', 'Drawbar horsepower = pull (lb) x speed (mph) / 375 = (3,000)(3.5) / 375 = 28 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '32 hp', false, 0),
      (v_question_id, '35 hp', false, 1),
      (v_question_id, '22 hp', false, 2),
      (v_question_id, '28 hp', true, 3);
  END IF;

  -- 13. Drawbar power from rolling resistance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor pulls a 2,500-kg load at a speed of 5 kph on flat ground. If the coefficient of rolling resistance is 0.25, what is the drawbar power that the tractor generates?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor pulls a 2,500-kg load at a speed of 5 kph on flat ground. If the coefficient of rolling resistance is 0.25, what is the drawbar power that the tractor generates?', 'single_choice', 'medium', 'Rolling resistance force = (2,500 kg)(9.81 m/s2)(0.25) = 6,131.25 N. Speed = 5 kph = 1.389 m/s. Drawbar power = F x S = 6,131.25 x 1.389 = 8,515.6 W = 11.42 hp (at 746 W per hp). The 8.51 value is in kW, not hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7 hp', false, 0),
      (v_question_id, '15 hp', false, 1),
      (v_question_id, '8.51 hp', false, 2),
      (v_question_id, '11.42 hp', true, 3);
  END IF;

  -- 14. Theoretical field capacity of an offset disk harrow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor pulls a 2.0-m-wide heavy-duty offset disk harrow at an operating speed of 10 kph. What is the theoretical field capacity of the machine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor pulls a 2.0-m-wide heavy-duty offset disk harrow at an operating speed of 10 kph. What is the theoretical field capacity of the machine?', 'single_choice', 'easy', 'Theoretical field capacity = (speed x width) / 10 = (10 kph)(2.0 m) / 10 = 2.0 ha/hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.2 ha/hr', false, 0),
      (v_question_id, '2.4 ha/hr', false, 1),
      (v_question_id, '3.1 ha/hr', false, 2),
      (v_question_id, '2.0 ha/hr', true, 3);
  END IF;

  -- 15. Draft of a moldboard plow from specific draft
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-wheel tractor pulls a 3-bottom, 14-inch moldboard plow in clay loam soil with a specific draft of 0.56 kg/cm2 at a depth of 25.4 cm. What is the draft of the plow before any adjustment for speed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A four-wheel tractor pulls a 3-bottom, 14-inch moldboard plow in clay loam soil with a specific draft of 0.56 kg/cm2 at a depth of 25.4 cm. What is the draft of the plow before any adjustment for speed?', 'single_choice', 'medium', 'Draft = specific draft x width of cut x depth of cut = (0.56 kg/cm2)(3 x 14 in x 2.54 cm/in)(25.4 cm) = (0.56)(106.68 cm)(25.4 cm) = 1,517.4 kg. Using the width in inches without converting to centimeters would give a wrong value.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,517 kg', true, 0),
      (v_question_id, '2,155 kg', false, 1),
      (v_question_id, '3,035 kg', false, 2),
      (v_question_id, '597 kg', false, 3);
  END IF;

  -- 16. Highest usable gear for a plowing operation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A four-wheel tractor with a 3 x 14-inch moldboard plow operates in clay loam soil (specific draft = 0.56 kg/cm2) at a depth of 25.4 cm. The maximum draft the tractor can pull and the percent increase in draft due to speed are: 1L, 3.2 kph, 4,000 kg, 14%; 2L, 4.8 kph, 3,100 kg, 28%; 3L, 6.4 kph, 2,200 kg, 42%; 4L, 8.0 kph, 1,300 kg, 56%. Which is the highest gear setting that can sustain the draft requirement of the operation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A four-wheel tractor with a 3 x 14-inch moldboard plow operates in clay loam soil (specific draft = 0.56 kg/cm2) at a depth of 25.4 cm. The maximum draft the tractor can pull and the percent increase in draft due to speed are: 1L, 3.2 kph, 4,000 kg, 14%; 2L, 4.8 kph, 3,100 kg, 28%; 3L, 6.4 kph, 2,200 kg, 42%; 4L, 8.0 kph, 1,300 kg, 56%. Which is the highest gear setting that can sustain the draft requirement of the operation?', 'single_choice', 'hard', 'Specific-draft-based draft = (0.56)(3 x 14 x 2.54)(25.4) = 1,517.4 kg. Adjusted draft at 4L = 1,517.4 x 1.56 = 2,367 kg, which exceeds the 1,300 kg available. At 3L = 1,517.4 x 1.42 = 2,154.7 kg, which is within the 2,200 kg maximum draft. Therefore 3L is the highest gear that can sustain the operation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3L', true, 0),
      (v_question_id, '4L', false, 1),
      (v_question_id, '1L', false, 2),
      (v_question_id, '2L', false, 3);
  END IF;

  -- 17. Tractor horsepower for a plowing operation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A plow has an adjusted draft of 2,154.7 kg when pulled at 6.4 kph. Using drawbar horsepower = draft (kg) x speed (kph) / 274, and assuming that the drawbar power available is 80% of the tractor power, what tractor horsepower is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A plow has an adjusted draft of 2,154.7 kg when pulled at 6.4 kph. Using drawbar horsepower = draft (kg) x speed (kph) / 274, and assuming that the drawbar power available is 80% of the tractor power, what tractor horsepower is required?', 'single_choice', 'hard', 'Drawbar horsepower = (2,154.7)(6.4) / 274 = 50.3 hp. If only 80% of the tractor power is available at the drawbar, tractor power = 50.3 / 0.80 = 62.9 hp. Dividing by 0.80 (not multiplying) is needed because the tractor must supply more power than what reaches the drawbar.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100.7 hp', false, 0),
      (v_question_id, '40.3 hp', false, 1),
      (v_question_id, '50.3 hp', false, 2),
      (v_question_id, '62.9 hp', true, 3);
  END IF;

  -- 18. Drawbar horsepower of a three-disk plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Soil in a 500-hectare corn farm gives a draft of 10 psi when plowing at a speed of 4 km/hr. What drawbar horsepower is required to pull a three-disk plow with an effective cut of 12 inches per disk at a plowing depth of 6 inches?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Soil in a 500-hectare corn farm gives a draft of 10 psi when plowing at a speed of 4 km/hr. What drawbar horsepower is required to pull a three-disk plow with an effective cut of 12 inches per disk at a plowing depth of 6 inches?', 'single_choice', 'medium', 'Draft = 10 psi x (12 in x 6 in x 3 disks) = 2,160 lb = 981.8 kg (at 2.2 lb/kg). Drawbar horsepower = draft (kg) x speed (kph) / 274 = (981.8)(4) / 274 = 14.33 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.2 hp', false, 0),
      (v_question_id, '14.3 hp', true, 1),
      (v_question_id, '23.4 hp', false, 2),
      (v_question_id, '34.5 hp', false, 3);
  END IF;

  -- 19. Daily area plowed by a three-disk plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor pulls a three-disk plow with an effective cut of 12 inches per disk at 4 km/hr. How many hectares can it plow in one day of 16 hours of operation if the total time loss is 30%?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor pulls a three-disk plow with an effective cut of 12 inches per disk at 4 km/hr. How many hectares can it plow in one day of 16 hours of operation if the total time loss is 30%?', 'single_choice', 'medium', 'Effective field capacity = (S x W x Eff) / 10 = (4 kph)(3 x 12 x 0.0254 m)(0.70) / 10 = 0.256 ha/hr. For 16 hours per day: 0.256 x 16 = 4.1 ha/day. Ignoring the 30% time loss would give 5.85 ha/day.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.10 ha/day', true, 0),
      (v_question_id, '5.85 ha/day', false, 1),
      (v_question_id, '8.19 ha/day', false, 2),
      (v_question_id, '1.76 ha/day', false, 3);
  END IF;

  -- 20. Days to plow a farm with several tractors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 500-hectare farm is to be plowed using ten identical tractors, each pulling a three-disk plow with an effective cut of 12 inches per disk at 4 km/hr. Each tractor works 16 hours per day with a total time loss of 30%. How many days are required to plow the entire farm?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 500-hectare farm is to be plowed using ten identical tractors, each pulling a three-disk plow with an effective cut of 12 inches per disk at 4 km/hr. Each tractor works 16 hours per day with a total time loss of 30%. How many days are required to plow the entire farm?', 'single_choice', 'hard', 'Effective field capacity per tractor = (4)(3 x 12 x 0.0254)(0.70) / 10 = 0.256 ha/hr, or 4.096 ha/day for 16 hours. Ten tractors cover 40.96 ha/day, so the time required is 500 / 40.96 = 12.2 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24.4 days', false, 0),
      (v_question_id, '122.1 days', false, 1),
      (v_question_id, '8.5 days', false, 2),
      (v_question_id, '12.2 days', true, 3);
  END IF;

  -- 21. Width of offset disk harrow for a corn project
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a 200-hectare corn project, the field has to be tilled within 30 days. What width of heavy-duty offset disk harrow should be selected if the tractor operates at 5 kph? Assume a 75% field efficiency and an 8-hour working day.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a 200-hectare corn project, the field has to be tilled within 30 days. What width of heavy-duty offset disk harrow should be selected if the tractor operates at 5 kph? Assume a 75% field efficiency and an 8-hour working day.', 'single_choice', 'medium', 'Required effective field capacity = 200 ha / (30 days x 8 hr/day) = 0.8333 ha/hr. From EFC = (S x W x Eff) / 10, W = (0.8333 x 10) / (5 x 0.75) = 2.22 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.44 m', false, 0),
      (v_question_id, '1.67 m', false, 1),
      (v_question_id, '3.33 m', false, 2),
      (v_question_id, '2.22 m', true, 3);
  END IF;

  -- 22. Hectares plowed by a four-bottom plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor operating at 5.7 kph for 6 hours is pulling four 42-cm moldboard bottoms at a depth of 15 cm. If the field efficiency is 82%, how many hectares are plowed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor operating at 5.7 kph for 6 hours is pulling four 42-cm moldboard bottoms at a depth of 15 cm. If the field efficiency is 82%, how many hectares are plowed?', 'single_choice', 'medium', 'Effective field capacity = (S x W x Eff) / 10 = (5.7 kph)(4 x 0.42 m)(0.82) / 10 = 0.7852 ha/hr. Area plowed in 6 hours = 0.7852 x 6 = 4.71 ha. The depth of cut is not needed to compute field capacity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.34 ha', false, 0),
      (v_question_id, '3.89 ha', false, 1),
      (v_question_id, '4.71 ha', true, 2),
      (v_question_id, '5.00 ha', false, 3);
  END IF;

  -- 23. Effective field capacity of a twelve-bottom plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Determine the effective field capacity of a twelve-bottom plow with a rated width of 74 cm per bottom operating at 7.25 kph if the field efficiency is 87%.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Determine the effective field capacity of a twelve-bottom plow with a rated width of 74 cm per bottom operating at 7.25 kph if the field efficiency is 87%.', 'single_choice', 'medium', 'Effective field capacity = (S x W x Eff) / 10 = (7.25 kph)(12 x 0.74 m)(0.87) / 10 = 5.60 ha/hr. Forgetting the field efficiency would give 6.44 ha/hr, and forgetting the number of bottoms would give 0.47 ha/hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.60 ha/hr', true, 0),
      (v_question_id, '6.44 ha/hr', false, 1),
      (v_question_id, '7.40 ha/hr', false, 2),
      (v_question_id, '0.47 ha/hr', false, 3);
  END IF;

  -- 24. Time to plow a large area with several tractors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Five hundred hectares of farm is to be plowed using a 5-bottom moldboard plow with a cutting width of 20 cm per bottom. Three tractors are each pulling a plow at an average speed of 15 kph. Assuming a plowing efficiency of 85% and 6 hours of plowing operation per day, how many days are needed to finish the whole area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Five hundred hectares of farm is to be plowed using a 5-bottom moldboard plow with a cutting width of 20 cm per bottom. Three tractors are each pulling a plow at an average speed of 15 kph. Assuming a plowing efficiency of 85% and 6 hours of plowing operation per day, how many days are needed to finish the whole area?', 'single_choice', 'hard', 'Effective field capacity per tractor = (15 kph)(5 x 0.20 m)(0.85) / 10 = 1.275 ha/hr. For three tractors: 3.825 ha/hr x 6 hr/day = 22.95 ha/day. Days required = 500 / 22.95 = 21.8 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '32.7 days', false, 0),
      (v_question_id, '65.4 days', false, 1),
      (v_question_id, '18.5 days', false, 2),
      (v_question_id, '21.8 days', true, 3);
  END IF;

  -- 25. Drawbar horsepower of a five-bottom plow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tractor pulls a 5-bottom plow at 15 kph. Each bottom cuts 20 cm wide and 15 cm deep, and the specific draft of the soil is 12 psi. What is the approximate drawbar horsepower of the plow?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tractor pulls a 5-bottom plow at 15 kph. Each bottom cuts 20 cm wide and 15 cm deep, and the specific draft of the soil is 12 psi. What is the approximate drawbar horsepower of the plow?', 'single_choice', 'hard', 'Cross-section of cut = 20 cm x 15 cm x 5 bottoms = 1,500 cm2 = 232.5 in2. Draft = 12 psi x 232.5 in2 = 2,790 lb. Speed = 15 kph = 820 ft/min. Drawbar horsepower = (2,790 lb)(820 ft/min) / 33,000 = about 69 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '138.7 hp', false, 0),
      (v_question_id, '34.7 hp', false, 1),
      (v_question_id, '69.3 hp', true, 2),
      (v_question_id, '104.0 hp', false, 3);
  END IF;

  -- 26. Number of animal-drawn plows needed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many 13-cm animal-drawn plows are needed to plow a 3-hectare field in one day of 8 hours? The field efficiency is 78% and the speed of travel is 3 kph.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many 13-cm animal-drawn plows are needed to plow a 3-hectare field in one day of 8 hours? The field efficiency is 78% and the speed of travel is 3 kph.', 'single_choice', 'medium', 'Effective field capacity per plow = (3 kph)(0.13 m)(0.78) / 10 = 0.03042 ha/hr. Number of plows = 3 ha / (8 hr x 0.03042 ha/hr) = 12.3, which is rounded up to 13 plows so that the field is completed in one day.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 plows', false, 0),
      (v_question_id, '12 plows', false, 1),
      (v_question_id, '13 plows', true, 2),
      (v_question_id, '25 plows', false, 3);
  END IF;

  -- 27. Field efficiency of a floating tiller
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 1.2-m-wide floating tiller is used for rotary tilling and puddling a wetland paddy field measuring 24 m x 42 m. The average speed is 3 kph and turning at the headlands takes 10 seconds. What is the field efficiency if the field is worked along its length?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 1.2-m-wide floating tiller is used for rotary tilling and puddling a wetland paddy field measuring 24 m x 42 m. The average speed is 3 kph and turning at the headlands takes 10 seconds. What is the field efficiency if the field is worked along its length?', 'single_choice', 'hard', 'Number of rows = 24 m / 1.2 m = 20 rows. Turning time = 20 x 10 s = 200 s = 0.056 hr. Travel time = (42 m x 20 rows) / 3,000 m/hr = 0.28 hr. Total time = 0.336 hr. Actual field capacity = 0.1008 ha / 0.336 hr = 0.30 ha/hr. Theoretical field capacity = (3)(1.2) / 10 = 0.36 ha/hr. Field efficiency = 0.30 / 0.36 = about 83%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '71.6%', false, 0),
      (v_question_id, '83.3%', true, 1),
      (v_question_id, '88.7%', false, 2),
      (v_question_id, '66.7%', false, 3);
  END IF;

  -- 28. Effective field capacity of a tandem-disk harrow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tandem-disk harrow set at an 18-degree working angle has 24 disks, each 30 cm in diameter, spaced 20 cm apart. It is pulled at 10 kph and the field efficiency is 90%. Using an effective width W = 0.95NS + 1.2D for tandem-disk harrows, what is the effective field capacity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tandem-disk harrow set at an 18-degree working angle has 24 disks, each 30 cm in diameter, spaced 20 cm apart. It is pulled at 10 kph and the field efficiency is 90%. Using an effective width W = 0.95NS + 1.2D for tandem-disk harrows, what is the effective field capacity?', 'single_choice', 'hard', 'Effective width = 0.95(24)(20 cm) + 1.2(30 cm) = 456 + 36 = 492 cm = 4.92 m. Theoretical field capacity = (10)(4.92) / 10 = 4.92 ha/hr. Effective field capacity = 4.92 x 0.90 = 4.43 ha/hr.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.92 ha/hr', false, 0),
      (v_question_id, '5.47 ha/hr', false, 1),
      (v_question_id, '4.19 ha/hr', false, 2),
      (v_question_id, '4.43 ha/hr', true, 3);
  END IF;

  -- 29. Fuel consumption of a 300-hp tractor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If the specific fuel consumption of a tractor engine is 350 g of diesel per kW-hr during plowing, approximately how much diesel will a 300-hp tractor consume in 8 hours of operation? Assume a specific gravity of diesel of 0.76.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If the specific fuel consumption of a tractor engine is 350 g of diesel per kW-hr during plowing, approximately how much diesel will a 300-hp tractor consume in 8 hours of operation? Assume a specific gravity of diesel of 0.76.', 'single_choice', 'hard', 'Power = 300 hp x 0.746 kW/hp = 223.8 kW. Fuel mass per hour = 223.8 kW x 0.350 kg/kW-hr = 78.33 kg/hr. For 8 hours: 626.6 kg. Volume = 626.6 kg / 0.76 kg/L = about 824.5 liters.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,105.3 liters', false, 0),
      (v_question_id, '721.6 liters', false, 1),
      (v_question_id, '769.2 liters', false, 2),
      (v_question_id, '824.5 liters', true, 3);
  END IF;

  -- 30. Tractors needed for a sugarcane planting operation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 2.4-m sugarcane planter is to be used to plant a 150-hectare farm at 6 kph. The operation must be finished in 10 days working 8 hours per day, and the planting efficiency is 80%. How many tractor-planter units are needed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 2.4-m sugarcane planter is to be used to plant a 150-hectare farm at 6 kph. The operation must be finished in 10 days working 8 hours per day, and the planting efficiency is 80%. How many tractor-planter units are needed?', 'single_choice', 'hard', 'Effective field capacity per unit = (6 kph)(2.4 m)(0.80) / 10 = 1.152 ha/hr. Time required by one unit = 150 / 1.152 = 130.2 hr. Available time per unit = 10 days x 8 hr/day = 80 hr. Number of units = 130.2 / 80 = 1.63, rounded up to 2 tractor-planter units.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 unit', false, 0),
      (v_question_id, '2 units', true, 1),
      (v_question_id, '3 units', false, 2),
      (v_question_id, '4 units', false, 3);
  END IF;

END $$;
