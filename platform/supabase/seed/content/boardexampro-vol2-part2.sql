-- Auto-generated from supabase/seed/content/boardexampro-vol2-part2.json
-- Source reference: ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)
-- Idempotent: safe to re-run; skips topics/subtopics/questions that already exist.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Irrigation and Drainage Systems (LAND_WATER) — 17 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_water_control uuid;
  v_sub_pressurized uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAND_WATER';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Irrigation and Drainage Systems' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Irrigation and Drainage Systems', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_water_control FROM public.subtopics WHERE name = 'Water Control Structures' AND topic_id = v_topic_id;
  IF v_sub_water_control IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Water Control Structures') RETURNING id INTO v_sub_water_control;
  END IF;

  SELECT id INTO v_sub_pressurized FROM public.subtopics WHERE name = 'Pressurized Irrigation Systems' AND topic_id = v_topic_id;
  IF v_sub_pressurized IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Pressurized Irrigation Systems') RETURNING id INTO v_sub_pressurized;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A total of 1,500 cubic meters of water was delivered to a 1-hectare farm for the month of July, during which the consumptive use was estimated at 7 mm/day. The effective rainfall for the period was 120 mm. What is the irrigation efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A total of 1,500 cubic meters of water was delivered to a 1-hectare farm for the month of July, during which the consumptive use was estimated at 7 mm/day. The effective rainfall for the period was 120 mm. What is the irrigation efficiency?', 'single_choice', 'hard', 'CU = 0.007 m/day x 31 days x 1 ha x 10,000 m²/ha = 2,170 m³. ER = 0.120 m x 1 ha x 10,000 m²/ha = 1,200 m³. Ea = (CU - ER)/water delivered = (2,170 - 1,200)/1,500 = 0.647 = 64.7%.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '58.4%', false, 0),
      (v_question_id, '64.7%', true, 1),
      (v_question_id, '72.3%', false, 2),
      (v_question_id, '80.7%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This surface drainage layout is adapted to fields containing depressions that are too deep or too large to be eliminated by land leveling.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'This surface drainage layout is adapted to fields containing depressions that are too deep or too large to be eliminated by land leveling.', 'single_choice', 'medium', 'Random ditch system - ditches are run through the scattered depressions in whatever alignment the topography dictates, connecting them to an outlet.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Random ditch system', true, 0),
      (v_question_id, 'Interception system', false, 1),
      (v_question_id, 'Bedding system', false, 2),
      (v_question_id, 'Diversion ditch system', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In this subsurface drainage pattern the laterals enter the submain from one side only, in order to minimize the double drainage that occurs near the submain.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In this subsurface drainage pattern the laterals enter the submain from one side only, in order to minimize the double drainage that occurs near the submain.', 'single_choice', 'medium', 'Gridiron - laterals join the submain from one side only, so the strip adjacent to the submain is not drained twice.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gridiron', true, 0),
      (v_question_id, 'Herringbone', false, 1),
      (v_question_id, 'Double-main', false, 2),
      (v_question_id, 'Natural system', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The submain is laid along a depression and the laterals join it alternately from both sides. This drainage pattern is known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The submain is laid along a depression and the laterals join it alternately from both sides. This drainage pattern is known as', 'single_choice', 'medium', 'The herringbone pattern causes double drainage along the submain, acceptable where the depression is narrow; where the depression bottom is wide, a double-main system is preferred instead.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'gridiron', false, 0),
      (v_question_id, 'herringbone', true, 1),
      (v_question_id, 'double-main', false, 2),
      (v_question_id, 'random', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The method of applying water to the surface of the soil in the form of a spray, much like natural rainfall, is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The method of applying water to the surface of the soil in the form of a spray, much like natural rainfall, is', 'single_choice', 'easy', 'Sprinkler irrigation delivers pressurized water through nozzles that break the jet into droplets.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'sprinkler irrigation', true, 0),
      (v_question_id, 'furrow irrigation', false, 1),
      (v_question_id, 'basin irrigation', false, 2),
      (v_question_id, 'corrugation irrigation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This surface method is common in areas with small field layouts or lowland farms. The field is level in all directions, enclosed by a dike to prevent runoff, and receives an undirected flow of water.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'This surface method is common in areas with small field layouts or lowland farms. The field is level in all directions, enclosed by a dike to prevent runoff, and receives an undirected flow of water.', 'single_choice', 'easy', 'Basin irrigation floods a level, diked plot; it is the standard method for lowland rice in the Philippines.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sprinkler irrigation', false, 0),
      (v_question_id, 'Furrow irrigation', false, 1),
      (v_question_id, 'Basin irrigation', true, 2),
      (v_question_id, 'Corrugation irrigation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Water is delivered directly to the base of each plant and released into the soil through small orifices at low pressure. This method is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Water is delivered directly to the base of each plant and released into the soil through small orifices at low pressure. This method is', 'single_choice', 'easy', 'Trickle (drip) irrigation applies water slowly through emitters placed at the plant base, wetting only part of the root zone, giving the highest application efficiency among common methods.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'sprinkler irrigation', false, 0),
      (v_question_id, 'flooding', false, 1),
      (v_question_id, 'basin irrigation', false, 2),
      (v_question_id, 'trickle irrigation', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A variation of the furrow method that uses small rills for irrigating closely spaced crops such as small grains and pastures is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A variation of the furrow method that uses small rills for irrigating closely spaced crops such as small grains and pastures is', 'single_choice', 'medium', 'Corrugations are shallow rills formed across the field so water moves in small streams and spreads laterally into the closely spaced rows.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'flooding', false, 0),
      (v_question_id, 'trickle irrigation', false, 1),
      (v_question_id, 'basin irrigation', false, 2),
      (v_question_id, 'corrugation irrigation', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An open canal must cross a river or a road at a location where the canal cannot be carried above ground. The appropriate structure is a/an';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_water_control, 'An open canal must cross a river or a road at a location where the canal cannot be carried above ground. The appropriate structure is a/an', 'single_choice', 'medium', 'An inverted siphon carries canal water beneath the obstruction under pressure and returns it to open-channel flow on the other side.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'inverted siphon', true, 0),
      (v_question_id, 'sluice gate', false, 1),
      (v_question_id, 'check gate', false, 2),
      (v_question_id, 'canal fall', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Where the ground slope along a canal route changes abruptly, this structure is built to connect two canal reaches lying at different elevations.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_water_control, 'Where the ground slope along a canal route changes abruptly, this structure is built to connect two canal reaches lying at different elevations.', 'single_choice', 'medium', 'A canal fall (drop structure) lowers the canal bed in a controlled way and dissipates the excess energy of the falling water.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Inverted siphon', false, 0),
      (v_question_id, 'Spur', false, 1),
      (v_question_id, 'Canal fall', true, 2),
      (v_question_id, 'Sluice gate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Compute the unidirectional flow per unit width between two parallel drains spaced 1,000 m apart if the hydraulic conductivity of the soil is 12 m/day and the water levels at the drains are 8 m and 10 m above the impervious base.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Compute the unidirectional flow per unit width between two parallel drains spaced 1,000 m apart if the hydraulic conductivity of the soil is 12 m/day and the water levels at the drains are 8 m and 10 m above the impervious base.', 'single_choice', 'hard', 'For an unconfined aquifer with no recharge: Q = k(h1²-h2²)/(2L). k = 12 m/day = 0.50 m/hr. Q = 0.50[(10)²-(8)²]/(2x1000) = 0.50(36)/2000 = 0.0090 cu.m/hr.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.0045 cu.m/hr', false, 0),
      (v_question_id, '0.0090 cu.m/hr', true, 1),
      (v_question_id, '0.0180 cu.m/hr', false, 2),
      (v_question_id, '0.2160 cu.m/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An unconfined sand aquifer with a hydraulic conductivity of 10 m/day rests on a horizontal impervious base. Two fully penetrating ditches bound a strip of land 1,000 m wide; water stands 6 m in the left ditch and 10 m in the right ditch above the impervious base. Rainfall recharge is 8 mm/day and evaporation losses are 3 mm/day. Compute the flow into the right drain.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'An unconfined sand aquifer with a hydraulic conductivity of 10 m/day rests on a horizontal impervious base. Two fully penetrating ditches bound a strip of land 1,000 m wide; water stands 6 m in the left ditch and 10 m in the right ditch above the impervious base. Rainfall recharge is 8 mm/day and evaporation losses are 3 mm/day. Compute the flow into the right drain.', 'single_choice', 'hard', 'Net recharge R = 8-3 = 5 mm/day = 0.005 m/day. QR = RL/2 - k(h2²-h1²)/(2L) = (0.005)(1000)/2 - 10[(10)²-(6)²]/(2x1000) = 2.50 - 0.32 = 2.18 sq.m/day.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.18 sq.m/day', true, 0),
      (v_question_id, '2.50 sq.m/day', false, 1),
      (v_question_id, '2.82 sq.m/day', false, 2),
      (v_question_id, '3.20 sq.m/day', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using the same aquifer conditions (k = 10 m/day, L = 1,000 m, h_left = 6 m, h_right = 10 m, rainfall 8 mm/day, evaporation 3 mm/day), compute the flow into the left drain.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Using the same aquifer conditions (k = 10 m/day, L = 1,000 m, h_left = 6 m, h_right = 10 m, rainfall 8 mm/day, evaporation 3 mm/day), compute the flow into the left drain.', 'single_choice', 'hard', 'Total flow removed by both drains equals net recharge over the strip: Qt = RL = (0.005)(1000) = 5.00 sq.m/day. QL = Qt - QR = 5.00 - 2.18 = 2.82 sq.m/day.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.18 sq.m/day', false, 0),
      (v_question_id, '2.50 sq.m/day', false, 1),
      (v_question_id, '2.82 sq.m/day', true, 2),
      (v_question_id, '5.00 sq.m/day', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In this type of emitter the fully turbulent jet leaving the outlet is broken up and converted into drop-by-drop flow. (PNS/BAFS/PAES 224:2017)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pressurized, 'In this type of emitter the fully turbulent jet leaving the outlet is broken up and converted into drop-by-drop flow. (PNS/BAFS/PAES 224:2017)', 'single_choice', 'medium', 'Orifice emitter - a small opening produces a fully turbulent jet that is broken into individual drops.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tortuous', false, 0),
      (v_question_id, 'Orifice', true, 1),
      (v_question_id, 'Vortex', false, 2),
      (v_question_id, 'Point-source', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An emitter that discharges water from emission points which are individually and relatively widely spaced, usually more than 1 m apart, is classified as (PNS/BAFS/PAES 224:2017)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pressurized, 'An emitter that discharges water from emission points which are individually and relatively widely spaced, usually more than 1 m apart, is classified as (PNS/BAFS/PAES 224:2017)', 'single_choice', 'medium', 'Point-source emitters wet discrete zones and are used for widely spaced crops such as tree fruits; line-source emitters form a wetted strip suitable for row crops.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'on-off flushing', false, 0),
      (v_question_id, 'in-line', false, 1),
      (v_question_id, 'line-source', false, 2),
      (v_question_id, 'point-source', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Compute the net depth of water application for a field whose soil available moisture is 150 mm/m, with an allowable soil moisture depletion of 45% and an effective root-zone depth of 1.0 m. (PNS/BAFS/PAES 223:2017)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pressurized, 'Compute the net depth of water application for a field whose soil available moisture is 150 mm/m, with an allowable soil moisture depletion of 45% and an effective root-zone depth of 1.0 m. (PNS/BAFS/PAES 223:2017)', 'single_choice', 'hard', 'd_net = (FC - PWP) x dr x MAD = 150 x 1.0 x 0.45 = 67.5 mm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '45.0 mm', false, 0),
      (v_question_id, '60.0 mm', false, 1),
      (v_question_id, '67.5 mm', true, 2),
      (v_question_id, '96.4 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using the same field data (available moisture 150 mm/m, allowable depletion 45%, root zone 1.0 m), determine the irrigation frequency if the peak daily water use is 6.0 mm/day. (PNS/BAFS/PAES 223:2017)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pressurized, 'Using the same field data (available moisture 150 mm/m, allowable depletion 45%, root zone 1.0 m), determine the irrigation frequency if the peak daily water use is 6.0 mm/day. (PNS/BAFS/PAES 223:2017)', 'single_choice', 'hard', 'If = d_net / peak ETa = 67.5 / 6.0 = 11.25 ≈ 11.3 days.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.5 days', false, 0),
      (v_question_id, '9.6 days', false, 1),
      (v_question_id, '11.3 days', true, 2),
      (v_question_id, '16.1 days', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Mathematics and Basic Engineering (MATH_BASIC_ENGG) — 30 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_age uuid;
  v_sub_time_work uuid;
  v_sub_machine_design uuid;
  v_sub_stats uuid;
  v_sub_surveying uuid;
  v_sub_quadratic uuid;
  v_sub_permcomb uuid;
  v_sub_prob_stats uuid;
  v_sub_trig uuid;
  v_sub_maxima_minima uuid;
  v_sub_derivatives uuid;
  v_sub_law_cosines uuid;
  v_sub_triangles uuid;
  v_sub_som uuid;
  v_sub_chem uuid;
  v_sub_engg_economy uuid;
  v_sub_thermo uuid;
  v_sub_curvature_refraction uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'MATH_BASIC_ENGG';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: MATH_BASIC_ENGG';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Mathematics and Basic Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Mathematics and Basic Engineering', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_age FROM public.subtopics WHERE name = 'Age Problem' AND topic_id = v_topic_id;
  IF v_sub_age IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Age Problem') RETURNING id INTO v_sub_age;
  END IF;

  SELECT id INTO v_sub_time_work FROM public.subtopics WHERE name = 'Time and Work Problem' AND topic_id = v_topic_id;
  IF v_sub_time_work IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Time and Work Problem') RETURNING id INTO v_sub_time_work;
  END IF;

  SELECT id INTO v_sub_machine_design FROM public.subtopics WHERE name = 'Machine Design' AND topic_id = v_topic_id;
  IF v_sub_machine_design IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Machine Design') RETURNING id INTO v_sub_machine_design;
  END IF;

  SELECT id INTO v_sub_stats FROM public.subtopics WHERE name = 'Variance and Standard Deviation' AND topic_id = v_topic_id;
  IF v_sub_stats IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Variance and Standard Deviation') RETURNING id INTO v_sub_stats;
  END IF;

  SELECT id INTO v_sub_surveying FROM public.subtopics WHERE name = 'Surveying' AND topic_id = v_topic_id;
  IF v_sub_surveying IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Surveying') RETURNING id INTO v_sub_surveying;
  END IF;

  SELECT id INTO v_sub_quadratic FROM public.subtopics WHERE name = 'Quadratic Equations' AND topic_id = v_topic_id;
  IF v_sub_quadratic IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Quadratic Equations') RETURNING id INTO v_sub_quadratic;
  END IF;

  SELECT id INTO v_sub_permcomb FROM public.subtopics WHERE name = 'Permutations and Combinations' AND topic_id = v_topic_id;
  IF v_sub_permcomb IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Permutations and Combinations') RETURNING id INTO v_sub_permcomb;
  END IF;

  SELECT id INTO v_sub_prob_stats FROM public.subtopics WHERE name = 'Probability and Statistics' AND topic_id = v_topic_id;
  IF v_sub_prob_stats IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Probability and Statistics') RETURNING id INTO v_sub_prob_stats;
  END IF;

  SELECT id INTO v_sub_trig FROM public.subtopics WHERE name = 'Trigonometry' AND topic_id = v_topic_id;
  IF v_sub_trig IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Trigonometry') RETURNING id INTO v_sub_trig;
  END IF;

  SELECT id INTO v_sub_maxima_minima FROM public.subtopics WHERE name = 'Maxima and Minima' AND topic_id = v_topic_id;
  IF v_sub_maxima_minima IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Maxima and Minima') RETURNING id INTO v_sub_maxima_minima;
  END IF;

  SELECT id INTO v_sub_derivatives FROM public.subtopics WHERE name = 'Limits and Derivatives' AND topic_id = v_topic_id;
  IF v_sub_derivatives IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Limits and Derivatives') RETURNING id INTO v_sub_derivatives;
  END IF;

  SELECT id INTO v_sub_law_cosines FROM public.subtopics WHERE name = 'Law of Cosines' AND topic_id = v_topic_id;
  IF v_sub_law_cosines IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Law of Cosines') RETURNING id INTO v_sub_law_cosines;
  END IF;

  SELECT id INTO v_sub_triangles FROM public.subtopics WHERE name = 'Triangles' AND topic_id = v_topic_id;
  IF v_sub_triangles IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Triangles') RETURNING id INTO v_sub_triangles;
  END IF;

  SELECT id INTO v_sub_som FROM public.subtopics WHERE name = 'Strength of Materials' AND topic_id = v_topic_id;
  IF v_sub_som IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Strength of Materials') RETURNING id INTO v_sub_som;
  END IF;

  SELECT id INTO v_sub_chem FROM public.subtopics WHERE name = 'Chemistry' AND topic_id = v_topic_id;
  IF v_sub_chem IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Chemistry') RETURNING id INTO v_sub_chem;
  END IF;

  SELECT id INTO v_sub_engg_economy FROM public.subtopics WHERE name = 'Engineering Economy' AND topic_id = v_topic_id;
  IF v_sub_engg_economy IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Engineering Economy') RETURNING id INTO v_sub_engg_economy;
  END IF;

  SELECT id INTO v_sub_thermo FROM public.subtopics WHERE name = 'Thermodynamics' AND topic_id = v_topic_id;
  IF v_sub_thermo IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Thermodynamics') RETURNING id INTO v_sub_thermo;
  END IF;

  SELECT id INTO v_sub_curvature_refraction FROM public.subtopics WHERE name = 'Curvature and Refraction' AND topic_id = v_topic_id;
  IF v_sub_curvature_refraction IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Curvature and Refraction') RETURNING id INTO v_sub_curvature_refraction;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Six years ago, Alex was four times as old as Ben. Six years from now, Alex will be twice as old as Ben. What is the present age of Ben?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_age, 'Six years ago, Alex was four times as old as Ben. Six years from now, Alex will be twice as old as Ben. What is the present age of Ben?', 'single_choice', 'medium', 'A-6=4(B-6) -> A=4B-18. A+6=2(B+6) -> A=2B+6. Equating: 4B-18=2B+6 -> B=12 years old.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 years old', false, 0),
      (v_question_id, '12 years old', true, 1),
      (v_question_id, '15 years old', false, 2),
      (v_question_id, '18 years old', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Pump A can fill a tank in 4 hours while Pump B can fill the same tank in 6 hours. How long will it take both pumps working together to fill the tank?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_time_work, 'Pump A can fill a tank in 4 hours while Pump B can fill the same tank in 6 hours. How long will it take both pumps working together to fill the tank?', 'single_choice', 'medium', 'Combined rate = 1/4 + 1/6 = 5/12 tank per hour. t = 12/5 = 2.4 hours = 2 hours and 24 minutes.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 hours and 24 minutes', true, 0),
      (v_question_id, '2 hours and 30 minutes', false, 1),
      (v_question_id, '3 hours and 12 minutes', false, 2),
      (v_question_id, '5 hours', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A thrust washer has an inside diameter of 15 mm and an outside diameter of 80 mm. For an allowable bearing pressure of 100 psi, determine the axial load the washer can sustain.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_machine_design, 'A thrust washer has an inside diameter of 15 mm and an outside diameter of 80 mm. For an allowable bearing pressure of 100 psi, determine the axial load the washer can sustain.', 'single_choice', 'hard', 'Convert to inches: Do=3.1496 in, Di=0.5906 in. F=pA=100(pi/4)[(3.1496)²-(0.5906)²]=100(7.5172)=751.7 lb.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '618.5 lb', false, 0),
      (v_question_id, '702.4 lb', false, 1),
      (v_question_id, '751.7 lb', true, 2),
      (v_question_id, '823.9 lb', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A roller chain and sprocket drives a vertical centrifugal-discharge bucket elevator. The driving sprocket has 15 teeth and turns at 150 rpm, while the driven sprocket turns at 45 rpm. Determine the number of teeth of the driven sprocket.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_machine_design, 'A roller chain and sprocket drives a vertical centrifugal-discharge bucket elevator. The driving sprocket has 15 teeth and turns at 150 rpm, while the driven sprocket turns at 45 rpm. Determine the number of teeth of the driven sprocket.', 'single_choice', 'medium', 'For a chain drive, T1n1=T2n2. T2=T1(n1/n2)=15(150/45)=50 teeth.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 teeth', false, 0),
      (v_question_id, '45 teeth', false, 1),
      (v_question_id, '50 teeth', true, 2),
      (v_question_id, '60 teeth', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the standard deviation of the daily temperatures recorded over a five-day period: 20, 24, 18, 26, and 12 degrees.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_stats, 'Find the standard deviation of the daily temperatures recorded over a five-day period: 20, 24, 18, 26, and 12 degrees.', 'single_choice', 'medium', 'Mean=20. Squared deviations: 0,16,4,36,64, sum=120. Sample variance=120/(5-1)=30. s=sqrt(30)=5.48.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.90', false, 0),
      (v_question_id, '5.48', true, 1),
      (v_question_id, '6.00', false, 2),
      (v_question_id, '30.00', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A distance of 250 m was measured with a steel tape standardized at 20 °C, having a coefficient of thermal expansion of 0.0000116/°C. If the corrected distance is 250.087 m, find the temperature during measurement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_surveying, 'A distance of 250 m was measured with a steel tape standardized at 20 °C, having a coefficient of thermal expansion of 0.0000116/°C. If the corrected distance is 250.087 m, find the temperature during measurement.', 'single_choice', 'hard', 'Ct=alpha(To-Ts)L. 0.087=0.0000116(To-20)(250) -> 0.087=0.0029(To-20) -> To-20=30 -> To=50.0 °C.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '35.0 °C', false, 0),
      (v_question_id, '42.5 °C', false, 1),
      (v_question_id, '50.0 °C', true, 2),
      (v_question_id, '58.0 °C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A distance of 250 m was measured with a tape of cross-sectional area 0.04 cm² standardized at a tension of 5 kg. If E = 2.10 x 10^6 kg/cm² and the corrected distance is 250.010 m, determine the pull applied during measurement.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_surveying, 'A distance of 250 m was measured with a tape of cross-sectional area 0.04 cm² standardized at a tension of 5 kg. If E = 2.10 x 10^6 kg/cm² and the corrected distance is 250.010 m, determine the pull applied during measurement.', 'single_choice', 'hard', 'Cp=(Po-Ps)L/(AE). 0.010=(Po-5)(250)/[(0.04)(2.10x10^6)] = (Po-5)(250)/84000. Po-5=3.36 -> Po=8.36 kg.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.68 kg', false, 0),
      (v_question_id, '8.36 kg', true, 1),
      (v_question_id, '9.46 kg', false, 2),
      (v_question_id, '11.72 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Mark rows downstream for 45 km, then turns around and returns to his starting point. The whole trip takes 12 hours. If the current flows at 2 km/h, how fast can Mark row in still water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_quadratic, 'Mark rows downstream for 45 km, then turns around and returns to his starting point. The whole trip takes 12 hours. If the current flows at 2 km/h, how fast can Mark row in still water?', 'single_choice', 'hard', '45/(r+2)+45/(r-2)=12 -> 45(r-2)+45(r+2)=12(r²-4) -> 90r=12r²-48 -> 2r²-15r-8=0 -> (2r+1)(r-8)=0 -> r=8 km/hr (r=-0.5 rejected).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6 km/hr', false, 0),
      (v_question_id, '7.5 km/hr', false, 1),
      (v_question_id, '8 km/hr', true, 2),
      (v_question_id, '10 km/hr', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In how many ways can 4 boys and 3 girls be seated on a bench if boys and girls must alternate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_permcomb, 'In how many ways can 4 boys and 3 girls be seated on a bench if boys and girls must alternate?', 'single_choice', 'medium', 'With 4 boys and 3 girls, the only alternating pattern is B G B G B G B. Boys: 4!=24 ways, girls: 3!=6 ways. Total=24x6=144.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '72', false, 0),
      (v_question_id, '144', true, 1),
      (v_question_id, '210', false, 2),
      (v_question_id, '5,040', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many distinguishable arrangements can be made of the letters of the word MISSISSIPPI?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_permcomb, 'How many distinguishable arrangements can be made of the letters of the word MISSISSIPPI?', 'single_choice', 'hard', 'MISSISSIPPI has 11 letters with I=4, S=4, P=2, M=1. Arrangements=11!/(4!4!2!1!)=39,916,800/1,152=34,650.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '34,650', true, 0),
      (v_question_id, '39,916,800', false, 1),
      (v_question_id, '831,600', false, 2),
      (v_question_id, '27,720', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'At a dinner party, 5 men and 5 women are to be seated around a round table. In how many ways can they be seated if there are no restrictions?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_permcomb, 'At a dinner party, 5 men and 5 women are to be seated around a round table. In how many ways can they be seated if there are no restrictions?', 'single_choice', 'medium', 'For circular permutations, one seat is fixed as reference: arrangements=(n-1)!=(10-1)!=9!=362,880.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10!', false, 0),
      (v_question_id, '9!', true, 1),
      (v_question_id, '5! x 5!', false, 2),
      (v_question_id, '5! x 4!', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many chords can be drawn through 15 points lying on a circle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_permcomb, 'How many chords can be drawn through 15 points lying on a circle?', 'single_choice', 'medium', 'A chord is determined by any 2 of the points: 15C2=(15x14)/2=105.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30', false, 0),
      (v_question_id, '105', true, 1),
      (v_question_id, '210', false, 2),
      (v_question_id, '225', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a class of 40 students, 22 are boys and 18 are girls. On a unit test, 6 boys and 7 girls earned a grade of A. If a student is chosen at random, what is the probability of choosing a girl or an A student?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_prob_stats, 'In a class of 40 students, 22 are boys and 18 are girls. On a unit test, 6 boys and 7 girls earned a grade of A. If a student is chosen at random, what is the probability of choosing a girl or an A student?', 'single_choice', 'medium', 'P(girl)=18/40, P(A)=13/40, P(girl and A)=7/40. P(girl or A)=18/40+13/40-7/40=24/40=3/5.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '13/40', false, 0),
      (v_question_id, '3/5', true, 1),
      (v_question_id, '31/40', false, 2),
      (v_question_id, '7/20', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 25-foot ladder leans against a wall with its base 10 feet from the wall. What angle does the ladder make with the ground?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_trig, 'A 25-foot ladder leans against a wall with its base 10 feet from the wall. What angle does the ladder make with the ground?', 'single_choice', 'medium', 'cos(theta)=adjacent/hypotenuse=10/25=0.40. theta=cos^-1(0.40)=66.42°.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '23.58°', false, 0),
      (v_question_id, '45.00°', false, 1),
      (v_question_id, '66.42°', true, 2),
      (v_question_id, '68.20°', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the dimension of a rectangle with a perimeter of 800 m such that the enclosed area is a maximum.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_maxima_minima, 'Find the dimension of a rectangle with a perimeter of 800 m such that the enclosed area is a maximum.', 'single_choice', 'medium', '800=2x+2y -> y=400-x. A=x(400-x)=400x-x². dA/dx=400-2x=0 -> x=200 m, y=200 m (a square).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 m', false, 0),
      (v_question_id, '150 m', false, 1),
      (v_question_id, '200 m', true, 2),
      (v_question_id, '400 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A ball is thrown into the air, and its height at any time t is given by h = 5 + 20t - 5t². What is its maximum height in meters?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_maxima_minima, 'A ball is thrown into the air, and its height at any time t is given by h = 5 + 20t - 5t². What is its maximum height in meters?', 'single_choice', 'medium', 'h''=20-10t. Set h''=0: t=2 s. h=5+20(2)-5(2)²=5+40-20=25 m.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 m', false, 0),
      (v_question_id, '25 m', true, 1),
      (v_question_id, '30 m', false, 2),
      (v_question_id, '45 m', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the derivative of x³ sin x.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_derivatives, 'Find the derivative of x³ sin x.', 'single_choice', 'medium', 'Product rule: dy/dx = x³(d/dx)(sin x) + sin x(d/dx)(x³) = x³ cos x + sin x(3x²) = 3x² sin x + x³ cos x.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3x² sin x + x³ cos x', true, 0),
      (v_question_id, '3x² cos x - x³ sin x', false, 1),
      (v_question_id, 'x³ cos x - 3x² sin x', false, 2),
      (v_question_id, '3x² sin x - x³ cos x', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a triangle, sides b = 15 and c = 8 enclose an angle A = 40°. What is the length of side a?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_law_cosines, 'In a triangle, sides b = 15 and c = 8 enclose an angle A = 40°. What is the length of side a?', 'single_choice', 'medium', 'a²=b²+c²-2bc cos A = 225+64-240(0.76604)=289-183.85=105.15. a=10.25.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9.42', false, 0),
      (v_question_id, '10.25', true, 1),
      (v_question_id, '11.86', false, 2),
      (v_question_id, '13.04', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A triangle has side lengths of 9 cm, 12 cm, and 15 cm. Find its area using Heron''s formula.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_triangles, 'A triangle has side lengths of 9 cm, 12 cm, and 15 cm. Find its area using Heron''s formula.', 'single_choice', 'medium', 's=(9+12+15)/2=18. A=sqrt[18(18-9)(18-12)(18-15)]=sqrt[18x9x6x3]=sqrt(2916)=54 sq cm (a 3-4-5 right triangle scaled by 3).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '36 sq cm', false, 0),
      (v_question_id, '48 sq cm', false, 1),
      (v_question_id, '54 sq cm', true, 2),
      (v_question_id, '60 sq cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hollow steel tube with an inside diameter of 80 mm must carry a tensile load of 300 kN. Determine the outside diameter of the tube if the stress is limited to 100 MN/m².';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_som, 'A hollow steel tube with an inside diameter of 80 mm must carry a tensile load of 300 kN. Determine the outside diameter of the tube if the stress is limited to 100 MN/m².', 'single_choice', 'hard', 'P=sigma*A, A=(pi/4)(D²-80²). 300,000=100(pi/4)(D²-6,400). D²-6,400=3,819.7... D²=10,219.7, D=101.09 mm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '96.44 mm', false, 0),
      (v_question_id, '101.09 mm', true, 1),
      (v_question_id, '108.32 mm', false, 2),
      (v_question_id, '115.39 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What force is required to punch a 25-mm diameter hole in a plate that is 20 mm thick if the shear strength of the plate is 300 MN/m²?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_som, 'What force is required to punch a 25-mm diameter hole in a plate that is 20 mm thick if the shear strength of the plate is 300 MN/m²?', 'single_choice', 'hard', 'The resisting area is the cylindrical surface along the hole perimeter: A=pi*d*t=pi(25)(20)=1,570.80 mm². P=tau*A=300(1,570.80)=471,239 N=471.24 kN.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '471.24 kN', true, 0),
      (v_question_id, '471.24 N', false, 1),
      (v_question_id, '589.05 kN', false, 2),
      (v_question_id, '150.00 kN', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A steel shaft 3 ft long with a diameter of 3 in is subjected to a torque of 10 kip-ft. Determine the maximum shearing stress.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_som, 'A steel shaft 3 ft long with a diameter of 3 in is subjected to a torque of 10 kip-ft. Determine the maximum shearing stress.', 'single_choice', 'hard', 'T=10 kip-ft=120,000 lb-in. tau_max=16T/(pi D³)=16(120,000)/[pi(3)³]=1,920,000/84.823=22,635 psi.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18,946 psi', false, 0),
      (v_question_id, '20,372 psi', false, 1),
      (v_question_id, '22,635 psi', true, 2),
      (v_question_id, '25,465 psi', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many molecules of water are there in 90 g of H2O?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_chem, 'How many molecules of water are there in 90 g of H2O?', 'single_choice', 'medium', 'Molar mass H2O=18 g/mol. Moles=90/18=5 moles. Molecules=5x6.022x10^23=30.110x10^23.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.022 x 10^23 molecules', false, 0),
      (v_question_id, '12.044 x 10^23 molecules', false, 1),
      (v_question_id, '18.066 x 10^23 molecules', false, 2),
      (v_question_id, '30.110 x 10^23 molecules', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Calculate the mass of 3.011 x 10^23 molecules of NaCl.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_chem, 'Calculate the mass of 3.011 x 10^23 molecules of NaCl.', 'single_choice', 'medium', 'Molar mass NaCl=58.5 g/mol. Moles=(3.011x10^23)/(6.022x10^23)=0.5 mole. Mass=0.5x58.5=29.25 g.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '29.25 g', true, 0),
      (v_question_id, '35.50 g', false, 1),
      (v_question_id, '58.50 g', false, 2),
      (v_question_id, '117.00 g', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An engineer is entitled to receive P30,000 at the beginning of each year for 15 years. What is the present value of this annuity at the time he is supposed to receive the first payment if the rate of interest is 5% compounded annually?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_engg_economy, 'An engineer is entitled to receive P30,000 at the beginning of each year for 15 years. What is the present value of this annuity at the time he is supposed to receive the first payment if the rate of interest is 5% compounded annually?', 'single_choice', 'hard', 'Annuity due: the first payment is received today, so only the remaining 14 payments are discounted. P=30,000+30,000[1-(1.05)^-14]/0.05=30,000+30,000(9.8986)=30,000+296,959=P326,959.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P311,401', false, 0),
      (v_question_id, 'P326,959', true, 1),
      (v_question_id, 'P341,207', false, 2),
      (v_question_id, 'P450,000', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If money is worth 10%, determine the present value of a perpetuity of P2,000 payable annually, with the first payment due at the end of 6 years.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_engg_economy, 'If money is worth 10%, determine the present value of a perpetuity of P2,000 payable annually, with the first payment due at the end of 6 years.', 'single_choice', 'hard', 'Value one period before the first payment (end of year 5): P''=A/i=2,000/0.10=P20,000. Discount 5 years to present: P=20,000/(1.10)^5=20,000/1.61051=P12,418.43.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P11,289.25', false, 0),
      (v_question_id, 'P12,418.43', true, 1),
      (v_question_id, 'P13,660.27', false, 2),
      (v_question_id, 'P20,000.00', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 5-cubic-meter compressed air tank has its pressure drop from 800 kPa to 200 kPa while the temperature remains unchanged at 30 °C. By what percentage has the mass of air in the tank been reduced?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_thermo, 'A 5-cubic-meter compressed air tank has its pressure drop from 800 kPa to 200 kPa while the temperature remains unchanged at 30 °C. By what percentage has the mass of air in the tank been reduced?', 'single_choice', 'hard', 'pV=mRT. m1=(800)(5)/[(0.287)(303)]=46.00 kg. m2=(200)(5)/[(0.287)(303)]=11.50 kg. Percent reduction=(46.00-11.50)/46.00=0.75=75%.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50%', false, 0),
      (v_question_id, '65%', false, 1),
      (v_question_id, '75%', true, 2),
      (v_question_id, '80%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A sailor whose eye is 4 m above sea level just sees the top of a lighthouse standing 45 m above sea level. Find the distance of the sailor from the lighthouse.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_curvature_refraction, 'A sailor whose eye is 4 m above sea level just sees the top of a lighthouse standing 45 m above sea level. Find the distance of the sailor from the lighthouse.', 'single_choice', 'hard', 'Using h=0.067d² (h in m, d in km): for the lighthouse, D1=sqrt(45/0.067)=25.92 km; for the sailor''s eye, D2=sqrt(4/0.067)=7.73 km. D=D1+D2=33.64 km.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25.92 km', false, 0),
      (v_question_id, '29.80 km', false, 1),
      (v_question_id, '33.64 km', true, 2),
      (v_question_id, '38.15 km', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A steel rod 20 mm in diameter carries an axial tensile load of 30 kN. Determine the axial stress developed in the rod.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_som, 'A steel rod 20 mm in diameter carries an axial tensile load of 30 kN. Determine the axial stress developed in the rod.', 'single_choice', 'medium', 'A=(pi/4)(20)²=314.16 mm². sigma=P/A=30,000/314.16=95.49 MPa.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '47.75 MPa', false, 0),
      (v_question_id, '75.00 MPa', false, 1),
      (v_question_id, '95.49 MPa', true, 2),
      (v_question_id, '150.00 MPa', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In how many ways can 6 persons be seated in a row if two particular persons must always sit beside each other?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_permcomb, 'In how many ways can 6 persons be seated in a row if two particular persons must always sit beside each other?', 'single_choice', 'medium', 'Treat the two persons as a single block, leaving 5 units to arrange: 5!=120. The two persons may exchange places within the block: 2!=2. Total=120x2=240.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120', false, 0),
      (v_question_id, '240', true, 1),
      (v_question_id, '360', false, 2),
      (v_question_id, '720', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences (FUNDAMENTALS_SCIENCES) — 15 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_ecology uuid;
  v_sub_crop_science uuid;
  v_sub_soil_science uuid;
  v_sub_animal_science uuid;
  v_sub_fisheries uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'FUNDAMENTALS_SCIENCES';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: FUNDAMENTALS_SCIENCES';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_ecology FROM public.subtopics WHERE name = 'Ecological and Environmental Sciences' AND topic_id = v_topic_id;
  IF v_sub_ecology IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Ecological and Environmental Sciences') RETURNING id INTO v_sub_ecology;
  END IF;

  SELECT id INTO v_sub_crop_science FROM public.subtopics WHERE name = 'Crop Science' AND topic_id = v_topic_id;
  IF v_sub_crop_science IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Crop Science') RETURNING id INTO v_sub_crop_science;
  END IF;

  SELECT id INTO v_sub_soil_science FROM public.subtopics WHERE name = 'Soil Science' AND topic_id = v_topic_id;
  IF v_sub_soil_science IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Soil Science') RETURNING id INTO v_sub_soil_science;
  END IF;

  SELECT id INTO v_sub_animal_science FROM public.subtopics WHERE name = 'Animal Science' AND topic_id = v_topic_id;
  IF v_sub_animal_science IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Animal Science') RETURNING id INTO v_sub_animal_science;
  END IF;

  SELECT id INTO v_sub_fisheries FROM public.subtopics WHERE name = 'Fisheries and Aquatic Resources' AND topic_id = v_topic_id;
  IF v_sub_fisheries IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Fisheries and Aquatic Resources') RETURNING id INTO v_sub_fisheries;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This species interaction harms one organism while the other is neither helped nor harmed. The harming species may release chemicals or toxins that inhibit the growth or survival of the other.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_ecology, 'This species interaction harms one organism while the other is neither helped nor harmed. The harming species may release chemicals or toxins that inhibit the growth or survival of the other.', 'single_choice', 'medium', 'Amensalism: one species is negatively affected, the other unaffected (-/0). Commensalism: one benefits, the other is unaffected (+/0). Mutualism: both species benefit (+/+). Predation: one benefits at the direct expense of the other (+/-).', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Amensalism', true, 0),
      (v_question_id, 'Commensalism', false, 1),
      (v_question_id, 'Predation', false, 2),
      (v_question_id, 'Mutualism', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Diazotrophic microorganisms possessing the enzyme nitrogenase convert atmospheric nitrogen gas (N2) into ammonia (NH3). This step of the nitrogen cycle is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_ecology, 'Diazotrophic microorganisms possessing the enzyme nitrogenase convert atmospheric nitrogen gas (N2) into ammonia (NH3). This step of the nitrogen cycle is called', 'single_choice', 'easy', 'Nitrogen fixation converts inert N2 into a chemically available form. Nitrification oxidizes ammonium to nitrite and then to nitrate. Denitrification returns nitrate to gaseous nitrogen. Assimilation is the uptake of nitrates or ammonium by plants for building organic compounds.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'nitrification', false, 0),
      (v_question_id, 'denitrification', false, 1),
      (v_question_id, 'nitrogen fixation', true, 2),
      (v_question_id, 'assimilation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The fertilizer is first dissolved in water at the prescribed rate and then sprayed onto the upper portion of the plant, particularly the leaves. This method of application is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_crop_science, 'The fertilizer is first dissolved in water at the prescribed rate and then sprayed onto the upper portion of the plant, particularly the leaves. This method of application is', 'single_choice', 'easy', 'Foliar spray allows rapid absorption of nutrients through the leaf surface and is often used to correct micronutrient deficiencies. The hole method uses a pointed stake to open pegholes around the plant. Broadcasting spreads fertilizer uniformly over the whole area. Row application places fertilizer in bands along the crop rows.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'foliar spray', true, 0),
      (v_question_id, 'hole method', false, 1),
      (v_question_id, 'broadcast', false, 2),
      (v_question_id, 'row application', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The fertilizer is spread uniformly over the entire area either before planting or while the crop is already growing. This method is known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_crop_science, 'The fertilizer is spread uniformly over the entire area either before planting or while the crop is already growing. This method is known as', 'single_choice', 'easy', 'Broadcasting is fast and suited to closely spaced crops, but it is less efficient because fertilizer also falls between plants. It may be done before planting (basal) or as a topdressing on a standing crop.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'foliar spray', false, 0),
      (v_question_id, 'hole method', false, 1),
      (v_question_id, 'broadcast', true, 2),
      (v_question_id, 'row application', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A crop shows a sickly yellowish-green coloration of the leaves together with stunted growth. This symptom indicates a deficiency in';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_crop_science, 'A crop shows a sickly yellowish-green coloration of the leaves together with stunted growth. This symptom indicates a deficiency in', 'single_choice', 'medium', 'Nitrogen deficiency produces general chlorosis, first on older leaves, because nitrogen is mobile and is translocated to the young growth. Phosphorus deficiency shows purplish discoloration; potassium deficiency shows marginal scorching of older leaves.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'nitrogen', true, 0),
      (v_question_id, 'phosphorus', false, 1),
      (v_question_id, 'potassium', false, 2),
      (v_question_id, 'calcium', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The leaves, stems, and branches of a crop turn purplish, and growth is slow with delayed maturity. This indicates a deficiency in';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_crop_science, 'The leaves, stems, and branches of a crop turn purplish, and growth is slow with delayed maturity. This indicates a deficiency in', 'single_choice', 'medium', 'Phosphorus deficiency causes anthocyanin accumulation, giving the characteristic purple tint, and delays flowering and maturity. Phosphorus is essential to energy transfer (ATP) and to root development.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'nitrogen', false, 0),
      (v_question_id, 'phosphorus', true, 1),
      (v_question_id, 'potassium', false, 2),
      (v_question_id, 'sulfur', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Saccharum officinarum is the scientific name of';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_crop_science, 'Saccharum officinarum is the scientific name of', 'single_choice', 'easy', 'Sugarcane – Saccharum officinarum. Rice – Oryza sativa; sweet potato – Ipomoea batatas; jute – Corchorus capsularis.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'sweet potato', false, 0),
      (v_question_id, 'rice', false, 1),
      (v_question_id, 'sugarcane', true, 2),
      (v_question_id, 'jute', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the ISS (International Soil Science Society) classification, soil separates with diameters ranging from 0.02 mm to 0.002 mm are classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_soil_science, 'Under the ISS (International Soil Science Society) classification, soil separates with diameters ranging from 0.02 mm to 0.002 mm are classified as', 'single_choice', 'medium', 'ISS limits: coarse sand 2.0-0.2 mm; fine sand 0.2-0.02 mm; silt 0.02-0.002 mm; clay below 0.002 mm. Note that the USDA system sets the silt-sand boundary at 0.05 mm instead of 0.02 mm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'coarse sand', false, 0),
      (v_question_id, 'fine sand', false, 1),
      (v_question_id, 'silt', true, 2),
      (v_question_id, 'clay', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The ease with which a soil crumbles when handled is referred to as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_soil_science, 'The ease with which a soil crumbles when handled is referred to as', 'single_choice', 'easy', 'Friability – the ease of crumbling of soils; a friable soil is easy to till. Plasticity – the capacity of a moist soil to be molded and to retain the shape. Puddlability – susceptibility of a soil to a reduction in its apparent specific volume through mechanical work. Soil colloid – the finest fraction, able to absorb large amounts of water and responsible for stickiness when wet.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'plasticity', false, 0),
      (v_question_id, 'puddlability', false, 1),
      (v_question_id, 'soil colloid', false, 2),
      (v_question_id, 'friability', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Water that has been absorbed from an atmosphere of water vapor as a result of attractive forces at the surface of the soil particles is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_soil_science, 'Water that has been absorbed from an atmosphere of water vapor as a result of attractive forces at the surface of the soil particles is called', 'single_choice', 'medium', 'Hygroscopic water is held so tightly on particle surfaces that it is unavailable to plants. Capillary water is held in the soil pores against gravity and constitutes most of the plant-available water. Gravitational water drains freely from the macropores after saturation.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'hygroscopic water', true, 0),
      (v_question_id, 'capillary water', false, 1),
      (v_question_id, 'gravitational water', false, 2),
      (v_question_id, 'available water', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Chevron refers to the meat of a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_animal_science, 'Chevron refers to the meat of a', 'single_choice', 'easy', 'Chevron – goat meat; mutton – meat of sheep; veal – meat of a calf; beef – meat of a mature ox or cattle.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'goat', true, 0),
      (v_question_id, 'sheep', false, 1),
      (v_question_id, 'calf', false, 2),
      (v_question_id, 'mature ox', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A young male pig that was castrated at an early age is called a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_animal_science, 'A young male pig that was castrated at an early age is called a', 'single_choice', 'medium', 'Barrow – young male pig castrated before sexual maturity. Stag – male castrated at an advanced age; cara-stag – a castrated male carabao. Steer – male cattle castrated while young.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'stag', false, 0),
      (v_question_id, 'cara-stag', false, 1),
      (v_question_id, 'barrow', true, 2),
      (v_question_id, 'steer', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fresh milk of high purity that must be delivered to the customer within 36 hours and whose bacterial count is 10,000 or less per milliliter is classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_animal_science, 'Fresh milk of high purity that must be delivered to the customer within 36 hours and whose bacterial count is 10,000 or less per milliliter is classified as', 'single_choice', 'medium', 'Certified milk meets strict sanitary and bacteriological standards and a short delivery window. Homogenized milk contains finer butterfat globules than fresh milk. Filled milk has its butterfat replaced with vegetable fat such as coconut fat. Condensed milk has had a large part of its water removed and sugar added.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'homogenized milk', false, 0),
      (v_question_id, 'condensed milk', false, 1),
      (v_question_id, 'filled milk', false, 2),
      (v_question_id, 'certified milk', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'This stationary or floating enclosure is made of nets or screens sewn or fastened together, installed in the water with its surface opening covered, and held in place by wooden or bamboo posts or by floats and anchors.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fisheries, 'This stationary or floating enclosure is made of nets or screens sewn or fastened together, installed in the water with its surface opening covered, and held in place by wooden or bamboo posts or by floats and anchors.', 'single_choice', 'easy', 'A fish cage confines the stock in an enclosure suspended within a natural body of water, allowing free exchange of water through the netting. A fishpond is an artificial impoundment; fish traps and shelters are capture rather than culture structures.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fishpond', false, 0),
      (v_question_id, 'Fish cage', true, 1),
      (v_question_id, 'Fish trap', false, 2),
      (v_question_id, 'Fish shelter', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The type of aquaculture that makes use of major lakes, rivers, reservoirs, dams, small water impoundments, catch basins, rice paddies, and land-based ponds is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fisheries, 'The type of aquaculture that makes use of major lakes, rivers, reservoirs, dams, small water impoundments, catch basins, rice paddies, and land-based ponds is', 'single_choice', 'easy', 'Freshwater aquaculture operates in inland waters of negligible salinity. Mariculture is the farming of fish, plants, and other animals in salt water. Brackishwater aquaculture is carried out where fresh and marine waters mix, such as in coastal fishponds.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'mariculture', false, 0),
      (v_question_id, 'freshwater aquaculture', true, 1),
      (v_question_id, 'brackishwater aquaculture', false, 2),
      (v_question_id, 'deep-sea mariculture', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Aquaculture Engineering (LAND_WATER) — 10 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  v_sub_fishpond_construction uuid;
  v_sub_stocking uuid;
  v_sub_pond_construction uuid;
  v_sub_pond_water_supply uuid;
  v_sub_cage_culture uuid;
  v_sub_pond_fertilization uuid;
  v_sub_pond_outlet uuid;
  v_sub_site_preparation uuid;
  v_sub_water_transport uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAND_WATER';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Aquaculture Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Aquaculture Engineering', 'area_2') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_sub_fishpond_construction FROM public.subtopics WHERE name = 'Construction of Aquaculture Fishponds' AND topic_id = v_topic_id;
  IF v_sub_fishpond_construction IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Construction of Aquaculture Fishponds') RETURNING id INTO v_sub_fishpond_construction;
  END IF;

  SELECT id INTO v_sub_stocking FROM public.subtopics WHERE name = 'Stocking of Aquaculture Fishponds' AND topic_id = v_topic_id;
  IF v_sub_stocking IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Stocking of Aquaculture Fishponds') RETURNING id INTO v_sub_stocking;
  END IF;

  SELECT id INTO v_sub_pond_construction FROM public.subtopics WHERE name = 'Pond Construction' AND topic_id = v_topic_id;
  IF v_sub_pond_construction IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Pond Construction') RETURNING id INTO v_sub_pond_construction;
  END IF;

  SELECT id INTO v_sub_pond_water_supply FROM public.subtopics WHERE name = 'Pond Water Supply' AND topic_id = v_topic_id;
  IF v_sub_pond_water_supply IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Pond Water Supply') RETURNING id INTO v_sub_pond_water_supply;
  END IF;

  SELECT id INTO v_sub_cage_culture FROM public.subtopics WHERE name = 'Cage Culture' AND topic_id = v_topic_id;
  IF v_sub_cage_culture IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Cage Culture') RETURNING id INTO v_sub_cage_culture;
  END IF;

  SELECT id INTO v_sub_pond_fertilization FROM public.subtopics WHERE name = 'Pond Fertilization' AND topic_id = v_topic_id;
  IF v_sub_pond_fertilization IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Pond Fertilization') RETURNING id INTO v_sub_pond_fertilization;
  END IF;

  SELECT id INTO v_sub_pond_outlet FROM public.subtopics WHERE name = 'Pond Outlet Structures' AND topic_id = v_topic_id;
  IF v_sub_pond_outlet IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Pond Outlet Structures') RETURNING id INTO v_sub_pond_outlet;
  END IF;

  SELECT id INTO v_sub_site_preparation FROM public.subtopics WHERE name = 'Preparation of the Construction Site' AND topic_id = v_topic_id;
  IF v_sub_site_preparation IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Preparation of the Construction Site') RETURNING id INTO v_sub_site_preparation;
  END IF;

  SELECT id INTO v_sub_water_transport FROM public.subtopics WHERE name = 'Water Transport Structures' AND topic_id = v_topic_id;
  IF v_sub_water_transport IS NULL THEN
    INSERT INTO public.subtopics (topic_id, name) VALUES (v_topic_id, 'Water Transport Structures') RETURNING id INTO v_sub_water_transport;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a fish pond to produce fish both for food and for cash, its water surface area should be greater than';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fishpond_construction, 'For a fish pond to produce fish both for food and for cash, its water surface area should be greater than', 'single_choice', 'easy', 'A pond larger than 300 m² provides enough production for household consumption with a surplus that can be sold. The pond should also be square or rectangular in shape to simplify construction, management, and harvesting.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '100 m²', false, 0),
      (v_question_id, '200 m²', false, 1),
      (v_question_id, '300 m²', true, 2),
      (v_question_id, '500 m²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A properly designed small fish pond is shallow, with the water depth increasing from the upper end toward the lower end. The recommended depths are';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_fishpond_construction, 'A properly designed small fish pond is shallow, with the water depth increasing from the upper end toward the lower end. The recommended depths are', 'single_choice', 'easy', 'The gentle increase in depth toward the outlet allows the pond to be drained completely and the fish to be concentrated for harvesting. The banks, in turn, should stand about 50 cm higher than the water surface, have well-formed side slopes, and be built with tightly packed soil.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 cm at the upper end to 60 cm at the lower end', false, 0),
      (v_question_id, '60 cm at the upper end to 90 cm at the lower end', true, 1),
      (v_question_id, '90 cm at the upper end to 120 cm at the lower end', false, 2),
      (v_question_id, 'uniform 100 cm throughout', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In stocking a fish pond with tilapia, the recommended rate is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_stocking, 'In stocking a fish pond with tilapia, the recommended rate is', 'single_choice', 'easy', 'Two tilapia fingerlings per square meter of pond area is the standard rate for small-scale pond culture. Only strong baby fish at least 5 cm long should be stocked, obtained from a government station or another farmer. For cage culture, the corresponding rate is 150 to 200 fish per cubic meter of cage volume.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'one fish per square meter of pond area', false, 0),
      (v_question_id, 'two fish per square meter of pond area', true, 1),
      (v_question_id, 'five fish per square meter of pond area', false, 2),
      (v_question_id, 'ten fish per square meter of pond area', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Classified according to construction method, a pond that is obtained entirely through soil excavation is a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pond_construction, 'Classified according to construction method, a pond that is obtained entirely through soil excavation is a', 'single_choice', 'easy', 'According to construction method, ponds are classified as dug-out, embankment, or cut-and-fill ponds. Dug-out ponds are the simplest to build and are fed either by rain and surface runoff, or by springs and seepage where the water table lies near the surface. A barrage pond is a classification based on the way the pond is supplied and dammed, not on the excavation method.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'dug-out pond', true, 0),
      (v_question_id, 'embankment pond', false, 1),
      (v_question_id, 'cut-and-fill pond', false, 2),
      (v_question_id, 'barrage pond', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pump is to deliver 0.025 m³/s of water to a fish farm against a total pumping head of 10 m. If the overall efficiency of the pumping unit is 70%, determine the required power.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pond_water_supply, 'A pump is to deliver 0.025 m³/s of water to a fish farm against a total pumping head of 10 m. If the overall efficiency of the pumping unit is 70%, determine the required power.', 'single_choice', 'hard', 'Given: Q = 0.025 m³/s; H = 10 m; E = 0.70. Required: Pump power, P. Solution: P (kW) = (9.81 x Q x H) ÷ E = (9.81 x 0.025 x 10) ÷ 0.70 = 2.4525 ÷ 0.70 = 3.50 kW. The total pumping head H is the sum of the suction head, the delivery head, and the pipe loss head. For ordinary field pumps the suction head should be kept as small as possible, since most will not draw water higher than 3 to 5 m in field use.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.72 kW', false, 0),
      (v_question_id, '2.45 kW', false, 1),
      (v_question_id, '3.50 kW', true, 2),
      (v_question_id, '4.91 kW', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In producing tilapia in cages, each cage should be stocked at the rate of';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_cage_culture, 'In producing tilapia in cages, each cage should be stocked at the rate of', 'single_choice', 'medium', 'Cage culture supports a far higher density than pond culture because the flowing water continuously renews oxygen and removes wastes. The stock used should be 8 to 10 cm long and weigh 15 to 20 g each — these are the fish dimensions, not the stocking rate. For a start, small cages of about 1 m x 1 m x 1.2 m are preferred, sited in water deep enough to leave at least 50 cm of water below the cage.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 to 10 fish per cubic meter', false, 0),
      (v_question_id, '15 to 20 fish per cubic meter', false, 1),
      (v_question_id, '50 to 100 fish per cubic meter', false, 2),
      (v_question_id, '150 to 200 fish per cubic meter', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'To keep the pond water green, it should be fertilized once a week. If compost is used, the recommended rate of application is about';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pond_fertilization, 'To keep the pond water green, it should be fertilized once a week. If compost is used, the recommended rate of application is about', 'single_choice', 'medium', 'Compost is applied at about 10 kg per 100 m² of water surface, packed tightly in the fertilizing crib. If animal manure is used instead, the rate per 100 m² is 2 to 3 kg of chicken droppings, 8 to 10 kg of pig manure, or 10 to 15 kg of cow manure. Where animals are raised beside the pond, the daily manure swept in should not exceed that of 4 to 5 ducks, 5 to 8 chickens, or 1 to 2 pigs per 100 m² of water.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 to 3 kg per 100 m²', false, 0),
      (v_question_id, '10 kg per 100 m²', true, 1),
      (v_question_id, '8 to 10 kg per 100 m²', false, 2),
      (v_question_id, '10 to 15 kg per 100 m²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The outlet of a fish pond is located through the bottom of the lower-end bank. Its bottom should be set at approximately';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_pond_outlet, 'The outlet of a fish pond is located through the bottom of the lower-end bank. Its bottom should be set at approximately', 'single_choice', 'medium', 'Placing the outlet bottom about 10 cm below the deepest point in the pond allows the pond to be drained completely for harvesting and for drying the pond bottom. By contrast, the inlet is located through the top of the upper-end bank with its bottom about 10 cm above the highest level of pond water. Outlets may be a straight pipe, an L-pipe, or a monk; alternatively a siphon of at least 3 cm diameter may be used. Outlet structures serve two purposes: keeping the water surface at its optimum (design) level, and allowing complete draining and harvesting whenever necessary.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 cm above the highest level of pond water', false, 0),
      (v_question_id, 'at the same level as the pond bottom', false, 1),
      (v_question_id, '10 cm below the deepest point in the pond', true, 2),
      (v_question_id, '40 cm below the deepest point in the pond', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Before the dikes of a fish pond are built, the surface soil within the construction area must be stripped and set aside. The main reason is that surface soil';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_site_preparation, 'Before the dikes of a fish pond are built, the surface soil within the construction area must be stripped and set aside. The main reason is that surface soil', 'single_choice', 'medium', 'Surface soil, usually 5 to 30 cm deep, holds the greatest concentration of roots and decaying organic materials; as these decompose the fill settles and voids form, so it cannot be used for the foundation of any dike or structure. The stripped topsoil is kept aside and later spread on top of the banks and on their outside slopes, where its organic matter supports a protective grass cover. A well-built pond dike must resist the water pressure from the pond depth, be impervious enough to keep seepage to a minimum, and stand high enough that water never runs over its top.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'is too expensive to transport to the dike', false, 0),
      (v_question_id, 'contains the highest concentration of roots and decaying organic matter, making it unstable as a construction material', true, 1),
      (v_question_id, 'is too impervious and would prevent the pond from draining', false, 2),
      (v_question_id, 'has a specific mass greater than that of reinforced concrete', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A feeder canal serving a fish farm has a roughness coefficient of 0.025, a hydraulic radius of 0.40 m, and an effective slope of 0.0009. Compute the velocity of water in the canal.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, v_sub_water_transport, 'A feeder canal serving a fish farm has a roughness coefficient of 0.025, a hydraulic radius of 0.40 m, and an effective slope of 0.0009. Compute the velocity of water in the canal.', 'single_choice', 'hard', 'Given: n = 0.025; R = 0.40 m; S = 0.0009. Required: Velocity of water in the canal, v. Solution: v = (1 ÷ n)(R^(2/3))(S^(1/2)) = (1 ÷ 0.025)(0.40)^(2/3)(0.0009)^(1/2) = (40)(0.5429)(0.03) = 0.65 m/s. This is the Manning equation, which relates the carrying capacity of a canal to its shape, its effective gradient or head loss, and the roughness of its sides. The computed velocity must then be checked against the maximum permissible average velocity for the canal lining. For an unlined canal in average sandy soil and good loam this limit is 0.7 m/s, so the design is acceptable; a canal in soft clay (limit 0.2 m/s) would scour.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.22 m/s', false, 0),
      (v_question_id, '0.43 m/s', false, 1),
      (v_question_id, '0.65 m/s', true, 2),
      (v_question_id, '0.98 m/s', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Agricultural Building and Structures (STRUCTURES_ENVIRONMENT) — 30 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which structural member is characterized by loads acting perpendicular to its long axis, and may occur in horizontal, inclined, or vertical positions such as floor joists, rafters, and studs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which structural member is characterized by loads acting perpendicular to its long axis, and may occur in horizontal, inclined, or vertical positions such as floor joists, rafters, and studs?', 'single_choice', 'easy', 'A beam resists loads applied perpendicular (transverse) to its longitudinal axis, which develops bending. Although normally horizontal, inclined rafters and vertical studs are still beams because the governing action is bending. Tension members carry pure axial pull, compression members carry pure axial push, and combined members carry axial force and bending simultaneously.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tension member', false, 0),
      (v_question_id, 'Beam', true, 1),
      (v_question_id, 'Compression member', false, 2),
      (v_question_id, 'Combined member', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the fundamental concepts of structural design, the internal resistance developed by a material against an externally applied force is termed as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the fundamental concepts of structural design, the internal resistance developed by a material against an externally applied force is termed as', 'single_choice', 'easy', 'Stress is the internal resistance offered by a body to an external force, expressed as force per unit area. Its basic form assumes that the distribution is uniform over the area and that the load acts axially or perpendicular to that area. Strain is the resulting deformation, load is the external action itself, and moment is the turning effect of a force.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'strain', false, 0),
      (v_question_id, 'stress', true, 1),
      (v_question_id, 'load', false, 2),
      (v_question_id, 'moment', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The tendency of two equal and parallel forces acting in opposite directions to cause adjoining surfaces of a member to slide over one another produces';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The tendency of two equal and parallel forces acting in opposite directions to cause adjoining surfaces of a member to slide over one another produces', 'single_choice', 'medium', 'Shear arises from equal, opposite, and parallel forces that make one plane of the member slip past an adjacent plane. In timber construction, horizontal shear failure is a common mode because the shearing resistance of wood parallel to the grain is considerably lower than across the grain. Compression crushes, tension elongates, and neither describes this sliding action.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'compressive stress', false, 0),
      (v_question_id, 'tensile stress', false, 1),
      (v_question_id, 'shear stress', true, 2),
      (v_question_id, 'bearing stress', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'One board foot of lumber corresponds to which nominal dimension?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'One board foot of lumber corresponds to which nominal dimension?', 'single_choice', 'medium', 'The board foot (fbm) is the customary unit for pricing lumber and represents a nominal piece measuring one foot long, one foot wide, and one inch thick. In the working formula, length is taken in feet while width and thickness are taken in inches, and the product is divided by twelve. Note also that commercial sizes of 2" x 2" and smaller are priced by linear foot rather than by board foot.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One foot length by one foot width by one inch thickness', true, 0),
      (v_question_id, 'One foot length by one inch width by one inch thickness', false, 1),
      (v_question_id, 'One meter length by one foot width by one inch thickness', false, 2),
      (v_question_id, 'One foot length by one foot width by one foot thickness', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the commercial types of plywood, which one is specified for external use?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Among the commercial types of plywood, which one is specified for external use?', 'single_choice', 'easy', 'Marine plywood is the type intended for exterior exposure. Softwood plywood is the most common choice for structural applications, while hardwood plywood is used for paneling and finishing where usually only one face carries the hardwood finish. Plywood itself consists of three, five, seven, or more veneer slices laid with the grain of each sheet at right angles to those above and below it.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Softwood plywood', false, 0),
      (v_question_id, 'Hardwood plywood', false, 1),
      (v_question_id, 'Marine plywood', true, 2),
      (v_question_id, 'Veneered particle board', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A specially formulated mortar used in masonry work is more specifically known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A specially formulated mortar used in masonry work is more specifically known as', 'single_choice', 'easy', 'Grout is defined as a specially formulated mortar. The related terms are distinguished by composition: paste is a mixture of cement and water only, while mortar is a mixture of cement, water, and sand. Mortar functions to bond units together, seal spaces between units, tie steel reinforcement and anchor bolts into the wall, and provide design lines of color and shadow.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'paste', false, 0),
      (v_question_id, 'grout', true, 1),
      (v_question_id, 'plaster', false, 2),
      (v_question_id, 'slurry', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which class of concrete carries a cement-sand-gravel proportion of 1:2:4 and is used for members subjected to bending stress?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which class of concrete carries a cement-sand-gravel proportion of 1:2:4 and is used for members subjected to bending stress?', 'single_choice', 'medium', 'Class A concrete is proportioned 1:2:4 and covers sidewalks and floor slabs four inches thick as well as reinforced concrete, being applied to beams, slabs, columns, and all members subjected to bending stress. Class B at 1:2.5:5 serves walls, footings, posts, and foundations not reinforced for bending, while Class C at 1:3:6 is for machinery foundations and footings not under water.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Class A', true, 0),
      (v_question_id, 'Class B', false, 1),
      (v_question_id, 'Class C', false, 2),
      (v_question_id, 'Class D', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Concrete hollow blocks with thicknesses ranging from 7.5 cm to 10 cm, intended for walls and fences, are classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Concrete hollow blocks with thicknesses ranging from 7.5 cm to 10 cm, intended for walls and fences, are classified as', 'single_choice', 'medium', 'Non-bearing blocks range from 7.5 cm to 10 cm in thickness and are intended for walls and fences that carry essentially their own weight. Bearing blocks, by contrast, range from 15 cm to 20 cm thick and are used to carry loads other than their own weight. For estimating purposes, CHB work is taken at 12.5 pieces per square meter.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'bearing blocks', false, 0),
      (v_question_id, 'non-bearing blocks', true, 1),
      (v_question_id, 'structural blocks', false, 2),
      (v_question_id, 'partition-grade blocks', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The thickness of galvanized iron roofing sheets is expressed in gauge numbers ranging from No. 14 to No. 30. Which statement correctly describes this system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The thickness of galvanized iron roofing sheets is expressed in gauge numbers ranging from No. 14 to No. 30. Which statement correctly describes this system?', 'single_choice', 'medium', 'Gauge number varies inversely with thickness, so a No. 30 sheet is thinner than a No. 14 sheet. G.I. sheet is the most common roofing material because of its reasonable cost, availability, durability, and ease of installation and repair. Plain sheets measure 90 cm wide by 2.4 m long, while corrugated sheets are 80 cm wide with corrugation lengths of 1.5 m to 3.6 m at 30 cm intervals.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The higher the gauge number, the thicker the sheet', false, 0),
      (v_question_id, 'The higher the gauge number, the thinner the sheet', true, 1),
      (v_question_id, 'Gauge number is independent of thickness', false, 2),
      (v_question_id, 'Gauge number refers to the corrugation depth', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Based on the area over which it is applied, a load acting at a point or along a line is classified as a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Based on the area over which it is applied, a load acting at a point or along a line is classified as a', 'single_choice', 'easy', 'A concentrated load is applied at a point or along a line. A distributed load is spread over a large area, and a uniformly distributed load is one that is equal over the entire portion of the contact area. Lateral load is not a classification by area of application; it refers instead to direction and includes wind and seismic loads.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'distributed load', false, 0),
      (v_question_id, 'uniformly distributed load', false, 1),
      (v_question_id, 'concentrated load', true, 2),
      (v_question_id, 'lateral load', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Merriman''s formula, expressed as W = ½SL(1 + 0.1L), is used to estimate the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Merriman''s formula, expressed as W = ½SL(1 + 0.1L), is used to estimate the', 'single_choice', 'medium', 'Merriman''s formula estimates the dead load contributed by wooden roof trusses, where W is the weight of one truss in pounds, S is the bay or spacing between adjacent trusses in feet, and L is the span of the truss in feet. It belongs to the dead load group because trusses are permanently attached to the structure, alongside roofing, columns, beams, girders, walls, and windows.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'weight of one wooden roof truss', true, 0),
      (v_question_id, 'total wind pressure on a wall', false, 1),
      (v_question_id, 'dead load of a concrete slab', false, 2),
      (v_question_id, 'safe span of a wooden beam', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In designing agricultural buildings for wind stresses, the velocity pressure shall be taken as never less than';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In designing agricultural buildings for wind stresses, the velocity pressure shall be taken as never less than', 'single_choice', 'medium', 'A floor value of 20 psf is imposed on velocity pressure regardless of the computed value. Related design rules require that wind may come from any direction, so every surface member is designed for the maximum force coefficients both positive and negative; that open windows or doors increase negative pressure on the leeward side; and that structures in typhoon belts be checked against maximum velocities such as 185 kph or 140 kph.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 psf', false, 0),
      (v_question_id, '15 psf', false, 1),
      (v_question_id, '20 psf', true, 2),
      (v_question_id, '25 psf', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 401, the device in which a sow is confined during farrowing and lactation and which prevents her from turning around is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under PAES 401, the device in which a sow is confined during farrowing and lactation and which prevents her from turning around is the', 'single_choice', 'medium', 'The farrowing stall, also called a farrowing crate, restrains the sow so that she cannot turn around, thereby reducing piglet crushing. The farrowing pen also confines the sow during farrowing and lactation, but it allows her to turn around, which is the distinguishing feature. The creep area is the separate space provided for piglets inside the farrowing pen.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'farrowing pen', false, 0),
      (v_question_id, 'farrowing stall or crate', true, 1),
      (v_question_id, 'creep area', false, 2),
      (v_question_id, 'gestating pen', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The average number of farrowings of one sow per year is termed as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The average number of farrowings of one sow per year is termed as', 'single_choice', 'medium', 'Litter index, also called farrowing index, is the average number of farrowings of one sow per year and appears directly in the formulas for computing the number of farrowing, nursery, and fattening pens. Occupancy refers to the number of days an animal stays in a pen, while culling rate is the rate of removing undesirable or unproductive animals from the herd.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'culling rate', false, 0),
      (v_question_id, 'occupancy', false, 1),
      (v_question_id, 'litter index', true, 2),
      (v_question_id, 'selection rate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In which swine housing system are the weanlings moved from the farrowing house to a nursery house before being transferred to a growing-finishing unit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In which swine housing system are the weanlings moved from the farrowing house to a nursery house before being transferred to a growing-finishing unit?', 'single_choice', 'medium', 'The three-unit system routes the animals through farrowing, then nursery, then growing-finishing housing. In the two-unit system the weanlings pass directly from the farrowing house to the growing-finishing house, with no nursery stage. In the one-unit system the sows are removed at weaning and the pigs remain in the same building from farrowing until slaughter weight.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'One-unit system', false, 0),
      (v_question_id, 'Two-unit system', false, 1),
      (v_question_id, 'Three-unit system', true, 2),
      (v_question_id, 'Multi-suckling system', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Materials placed around brooder stoves to prevent chicks from straying too far from the heat supply until they learn its source are called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Materials placed around brooder stoves to prevent chicks from straying too far from the heat supply until they learn its source are called', 'single_choice', 'easy', 'Brooder guards confine newly hatched chicks near the heat source until they can locate it on their own. Brooding is the broader process of supplying heat to chicks after hatching until their natural heat-regulatory mechanisms become fully functional. Litter is the material used as bedding, and the hover is the adjustable canopy of the brooder maintained at a minimum clearance above the birds'' backs.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'brooder guards', true, 0),
      (v_question_id, 'hovers', false, 1),
      (v_question_id, 'litter', false, 2),
      (v_question_id, 'draught boards', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A long and narrow poultry house in which at least one-half of the front and the back are open is described as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A long and narrow poultry house in which at least one-half of the front and the back are open is described as', 'single_choice', 'easy', 'Open-sided housing relies on natural air movement through the large openings on the front and back walls. Enclosed housing instead maintains interior conditions as near as possible to the birds'' optimum requirements through mechanical ventilation and artificial lighting. Slotted and litter types describe flooring systems rather than the housing envelope.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'enclosed housing', false, 0),
      (v_question_id, 'open-sided housing', true, 1),
      (v_question_id, 'slotted housing', false, 2),
      (v_question_id, 'litter-type housing', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 403, the flooring system in which slats cover 60% of the total floor area while the remaining 40% is covered with litter is designated as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under PAES 403, the flooring system in which slats cover 60% of the total floor area while the remaining 40% is covered with litter is designated as', 'single_choice', 'medium', 'The slot-litter type is the combination system with a 60% slatted and 40% littered split of the floor area. The litter type uses commonly available materials such as rice hull, rice straw, and wood shavings over a cemented floor, while the slotted type uses openings throughout to facilitate the cleaning of droppings. Community type refers to nesting boxes, not flooring.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'litter type', false, 0),
      (v_question_id, 'slotted type', false, 1),
      (v_question_id, 'slot-litter type', true, 2),
      (v_question_id, 'community type', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the terminology of PAES 404, a young goat under six months old of either sex is called a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the terminology of PAES 404, a young goat under six months old of either sex is called a', 'single_choice', 'easy', 'A kid is a young goat under six months old of either sex; the corresponding term for sheep is lamb. A buck is a mature male goat and a doe is a mature female goat that has kidded, with a dry doe being one without milk. The sheep counterparts are ram for the mature male and ewe for the mature female that has already lambed.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'kid', true, 0),
      (v_question_id, 'lamb', false, 1),
      (v_question_id, 'buck', false, 2),
      (v_question_id, 'doe', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In cattle terminology, a female between two and three years of age which has not given birth is a';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In cattle terminology, a female between two and three years of age which has not given birth is a', 'single_choice', 'medium', 'A heifer is a female between two and three years of age that has not yet given birth. A cow is a mature female that has already calved, and a calf is a young male or female under one year of age. In dairy cattle terminology, a yearling is a one- to two-year-old animal of either sex.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'cow', false, 0),
      (v_question_id, 'heifer', true, 1),
      (v_question_id, 'calf', false, 2),
      (v_question_id, 'yearling', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a cattle ranch corral system, the pen used to funnel cattle into the working chute is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a cattle ranch corral system, the pen used to funnel cattle into the working chute is the', 'single_choice', 'medium', 'The crowding pen funnels animals toward the working chute and is built either circular, as a quarter or half circle, or funnel-shaped with one straight side and the other entering the working chute at 30 degrees. The holding pen confines animals coming from the pasture, while the loading chute moves cattle from the working chute or crowding pen onto a vehicle.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'holding pen', false, 0),
      (v_question_id, 'crowding pen', true, 1),
      (v_question_id, 'detention pen', false, 2),
      (v_question_id, 'loading chute', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 410, the separate compartment in a lairage used to confine sick or suspected animals is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under PAES 410, the separate compartment in a lairage used to confine sick or suspected animals is the', 'single_choice', 'medium', 'A detention pen is the separate compartment within the lairage for sick or suspected animals, and for all such suspect pens a lighting intensity of not less than 540 lux is required. The lairage itself is any premise or yard used to confine animals awaiting slaughter, including the unloading ramp, pens, and detention pens. The stunning pen belongs to the slaughterhouse proper.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'holding pen', false, 0),
      (v_question_id, 'detention pen', true, 1),
      (v_question_id, 'stunning pen', false, 2),
      (v_question_id, 'crowding pen', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In slaughterhouse terminology, the digestive tract of ruminants such as the stomach or intestines which still contains fecal matter is referred to as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In slaughterhouse terminology, the digestive tract of ruminants such as the stomach or intestines which still contains fecal matter is referred to as', 'single_choice', 'medium', 'Green offal is the ruminant digestive tract still containing fecal matter, while black offal is the corresponding term for swine. Offal in general is any part of the internal organs of a slaughtered animal. Detained meat requires further examination as declared by a veterinary inspector, whereas condemned meat has been declared unfit for human consumption.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'black offal', false, 0),
      (v_question_id, 'green offal', true, 1),
      (v_question_id, 'condemned meat', false, 2),
      (v_question_id, 'detained meat', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a poultry dressing plant, the process of restraining birds prior to slitting is known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a poultry dressing plant, the process of restraining birds prior to slitting is known as', 'single_choice', 'easy', 'Shackling is the restraining of birds immediately before slitting. Scalding is the lowering of the carcass into steam or hot water to prepare the skin for dehairing or defeathering, while gambrelling is the suspension of the carcass for a particular operation. Dressing itself covers bleeding, defeathering, and eviscerating, with the head, shanks, crop, oil gland, and other inedible parts removed.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'shackling', true, 0),
      (v_question_id, 'stunning', false, 1),
      (v_question_id, 'scalding', false, 2),
      (v_question_id, 'gambrelling', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of biogas plant consists of a heat-sealed plastic or rubber bag that combines the digester and the gasholder in one unit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which type of biogas plant consists of a heat-sealed plastic or rubber bag that combines the digester and the gasholder in one unit?', 'single_choice', 'medium', 'The balloon type is a heat-sealed plastic or rubber bag in which the digester and gasholder are combined, with the upper portion serving as gas storage. The floating type has a moving gasholder that floats either directly in the fermenting slurry or in a separate water jacket, while the fixed type is a closed digester with an immovable rigid gas chamber and a displacement pit.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Floating type', false, 0),
      (v_question_id, 'Fixed type', false, 1),
      (v_question_id, 'Balloon type', true, 2),
      (v_question_id, 'Multi-digester plant', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The mesophilic temperature range within which mesophilic bacteria operate in a biogas digester is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The mesophilic temperature range within which mesophilic bacteria operate in a biogas digester is', 'single_choice', 'easy', 'Mesophilic bacteria operate between 20 °C and 40 °C, and the tabulated retention times for animal manure are referenced to this range. The gas produced is a mixture composed of 50 to 70 percent methane and 30 to 40 percent carbon dioxide generated by methanogenic bacteria. Where the substrate temperature falls below the proper process temperature, a heating system becomes advisable.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 °C to 20 °C', false, 0),
      (v_question_id, '20 °C to 40 °C', true, 1),
      (v_question_id, '40 °C to 60 °C', false, 2),
      (v_question_id, '55 °C to 70 °C', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The composting method that arranges the compost mix in long, narrow piles which are periodically turned to maintain aerobic conditions is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The composting method that arranges the compost mix in long, narrow piles which are periodically turned to maintain aerobic conditions is', 'single_choice', 'medium', 'Windrow composting arranges the mix in long narrow piles that are turned periodically to keep conditions aerobic, and it carries the longest typical composting time among the listed methods at about four months. The aerated static pile takes roughly four weeks, while the in-vessel system runs about 7 to 30 days within an enclosed reactor that controls temperature, moisture, and odor.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'in-vessel composting', false, 0),
      (v_question_id, 'aerated static pile', false, 1),
      (v_question_id, 'windrow composting', true, 2),
      (v_question_id, 'vermicomposting', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a plant tissue culture laboratory, the flow of air currents in which the currents do not intermingle is described as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a plant tissue culture laboratory, the flow of air currents in which the currents do not intermingle is described as', 'single_choice', 'easy', 'Laminar flow describes air currents that do not intermingle, and laminar flow hoods or still-air boxes are required in the transfer room for all aseptic work. Asepsis is the resulting condition of freedom from contaminating microorganisms in the plant material, culture medium, and culture vessel. Incubation refers to subjecting cultures to conditions favorable to tissue growth.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'turbulent flow', false, 0),
      (v_question_id, 'laminar flow', true, 1),
      (v_question_id, 'asepsis', false, 2),
      (v_question_id, 'incubation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Storage in an artificial atmosphere in which the proportion of carbon dioxide and/or oxygen is precisely controlled is termed';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Storage in an artificial atmosphere in which the proportion of carbon dioxide and/or oxygen is precisely controlled is termed', 'single_choice', 'easy', 'Controlled atmosphere storage precisely regulates the carbon dioxide and oxygen proportions of the storage air. Bulk storage piles produce in room-sized bins whose lateral forces must be resisted by the building walls, while pallet bin storage places produce in boxes or bins that are stacked in the storage room. A drip cooler is a storage structure with continuously wetted walls.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'bulk storage', false, 0),
      (v_question_id, 'controlled atmosphere storage', true, 1),
      (v_question_id, 'pallet bin storage', false, 2),
      (v_question_id, 'drip cooling', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Wooden frames placed on concrete warehouse floors to prevent direct contact between the stacked bags of grain and the floor are known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Wooden frames placed on concrete warehouse floors to prevent direct contact between the stacked bags of grain and the floor are known as', 'single_choice', 'easy', 'Dunnage, also called pallet or tarima, keeps sacks off the concrete floor and prevents moisture migration into the grain. The standard pallet size for bagged storage is 152 cm by 61 cm. A related but distinct term is aeration, which is the movement of air through stored grains at low airflow rates, generally 0.07 to 0.28 cubic meter per minute per ton, for purposes other than drying.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'dunnage or tarima', true, 0),
      (v_question_id, 'battens', false, 1),
      (v_question_id, 'bulking agents', false, 2),
      (v_question_id, 'cribbing', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Design and Specifications of Coffee Processing Facility (STRUCTURES_ENVIRONMENT) — 13 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Design and Specifications of Coffee Processing Facility' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    INSERT INTO public.topics (exam_area_id, name, mock_area) VALUES (v_exam_area_id, 'Design and Specifications of Coffee Processing Facility', 'area_3') RETURNING id INTO v_topic_id;
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A proposed site for a coffee processing facility is being validated. Based on the site selection criteria of BAFE Technical Bulletin No. 1, s. 2025, what is the MAXIMUM slope gradient of the terrain that may still be accepted?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A proposed site for a coffee processing facility is being validated. Based on the site selection criteria of BAFE Technical Bulletin No. 1, s. 2025, what is the MAXIMUM slope gradient of the terrain that may still be accepted?', 'single_choice', 'medium', 'Section V states two topographic classes only: Flat = 0% to 3%, Undulating = 3% to 8%. Undulating is the steeper of the two admissible classes, so the governing ceiling is 8%.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3%', false, 0),
      (v_question_id, '8%', true, 1),
      (v_question_id, '15%', false, 2),
      (v_question_id, '30%', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dry-process facility will dry 182 kg of fresh coffee cherries per batch in a solar dryer. Design loading is 25 kg/m² at a bed depth of 40 mm. Excluding the walkway of personnel, what is the minimum drying bed area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A dry-process facility will dry 182 kg of fresh coffee cherries per batch in a solar dryer. Design loading is 25 kg/m² at a bed depth of 40 mm. Excluding the walkway of personnel, what is the minimum drying bed area?', 'single_choice', 'hard', 'Given: W_fcc = 182 kg/batch; W_fca = 25 kg/m²; t_bed = 40 mm. Required: A_DB, the minimum drying bed area. Solution: the design loading already embeds the bed depth and the bulk density of fresh cherries, so the depth is descriptive and does not enter the computation. A_DB = W_fcc / W_fca = 182 kg ÷ 25 kg/m² = 7.28 m² ≈ 7.3 m².', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.8 m²', false, 0),
      (v_question_id, '5.7 m²', false, 1),
      (v_question_id, '7.3 m²', true, 2),
      (v_question_id, '14.6 m²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fresh coffee cherries at 60% moisture content are dried down to 12% moisture content. Following the sample computation in the Technical Bulletin, what is the weight of dried coffee cherries obtained from a 182 kg batch?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Fresh coffee cherries at 60% moisture content are dried down to 12% moisture content. Following the sample computation in the Technical Bulletin, what is the weight of dried coffee cherries obtained from a 182 kg batch?', 'single_choice', 'hard', 'Given: W_f = 182 kg; MC_i = 60%; MC_f = 12%. Required: W_d, the weight of dried coffee cherries per batch. Solution: W_d = W_f [1 − (MC_i − MC_f)/100] = 182[1 − (60 − 12)/100] = 182(1 − 0.48) = 182(0.52) = 94.64 kg/batch.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '82.7 kg', false, 0),
      (v_question_id, '87.4 kg', false, 1),
      (v_question_id, '94.6 kg', true, 2),
      (v_question_id, '160.2 kg', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Green coffee beans of the Robusta variety are to be classified by size using an oscillating sieve. Per PNS/BAFS 341:2022 as adopted in the Technical Bulletin, what diameter of perforation corresponds to the LARGE size class?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Green coffee beans of the Robusta variety are to be classified by size using an oscillating sieve. Per PNS/BAFS 341:2022 as adopted in the Technical Bulletin, what diameter of perforation corresponds to the LARGE size class?', 'single_choice', 'easy', 'Table 1 of the Technical Bulletin tabulates sieve perforation diameter by variety and size class. For Coffea canephora (Robusta): large 7.50 mm, medium 6.50 mm, small 5.50 mm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.50 mm', false, 0),
      (v_question_id, '7.50 mm', true, 1),
      (v_question_id, '7.93 mm', false, 2),
      (v_question_id, '9.52 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A cooperative loads 10 kg of green coffee beans per batch into a non-specialty roaster to attain a dark roast. Per PNS/BAFS 214:2023, what is the maximum allowable roasting time for that load?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A cooperative loads 10 kg of green coffee beans per batch into a non-specialty roaster to attain a dark roast. Per PNS/BAFS 214:2023, what is the maximum allowable roasting time for that load?', 'single_choice', 'medium', 'Table 2 of the Technical Bulletin brackets the maximum roasting time by input per load: 2 to 5 kg → 18 min; 5 < m ≤ 10 kg → 25 min; 10 < m ≤ 50 kg → 45 min. Since m = 10 kg satisfies 5 < 10 ≤ 10, the second bracket governs.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '18 min', false, 0),
      (v_question_id, '25 min', true, 1),
      (v_question_id, '45 min', false, 2),
      (v_question_id, '60 min', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fermentation box of food-grade plastic is to hold 20 kg of parchment coffee with a bulk density of 665 kg/m³. An additional volume equal to 50% of the box volume is provided for water. If the footprint is 50 cm × 30 cm, what is the minimum height of the box?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A fermentation box of food-grade plastic is to hold 20 kg of parchment coffee with a bulk density of 665 kg/m³. An additional volume equal to 50% of the box volume is provided for water. If the footprint is 50 cm × 30 cm, what is the minimum height of the box?', 'single_choice', 'hard', 'Given: C_FB = 20 kg; rho_PC = 665 kg/m³; L x W = 0.50 m x 0.30 m. Required: H_FB, the minimum height of the fermentation box. Solution: Step 1, volume occupied by the parchment coffee: V_FB = C_FB / rho_PC = 20 kg ÷ 665 kg/m³ = 0.0301 m³. Step 2, add the 50% water allowance: V_FB,total = 1.50 V_FB = 1.50(0.0301) = 0.0451 m³. Step 3, solve for depth: H_FB = V_FB,total / (L x W) = 0.0451 m³ ÷ [(0.50 m)(0.30 m)] = 0.30 m = 30 cm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 cm', false, 0),
      (v_question_id, '30 cm', true, 1),
      (v_question_id, '40 cm', false, 2),
      (v_question_id, '45 cm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The receiving, weighing, and floatation area will house one floatation tank (1.0 m²) and one weighing scale (0.5 m²), with one worker assigned. Ceiling height is 2.6 m, air space requirement is 12 m³/person, and a safety factor of 1.10 is applied. What is the minimum floor area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The receiving, weighing, and floatation area will house one floatation tank (1.0 m²) and one weighing scale (0.5 m²), with one worker assigned. Ceiling height is 2.6 m, air space requirement is 12 m³/person, and a safety factor of 1.10 is applied. What is the minimum floor area?', 'single_choice', 'hard', 'Given: A_ft = 1.0 m²; A_ws = 0.5 m²; N_p = 1 person; H_c = 2.6 m; AS_person = 12 m³/person; S.F. = 1.10. Required: A_RWF, the minimum floor area. Solution: Step 1, convert the volumetric air-space requirement of Section 806, PD 1096 into an equivalent floor area: A_air = (AS_person x N_p) ÷ H_c = (12 x 1) ÷ 2.6 = 4.615 m². Step 2, sum the equipment footprints: A_equip = A_ft + A_ws = 1.0 + 0.5 = 1.5 m². Step 3, apply the safety factor for miscellaneous spaces (Section VIII-A.3): A_RWF = (A_equip + A_air) x S.F. = (1.5 + 4.615)(1.10) = 6.73 m² ≈ 7 m².', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.08 m²', false, 0),
      (v_question_id, '6.12 m²', false, 1),
      (v_question_id, '6.73 m²', true, 2),
      (v_question_id, '7.40 m²', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A combined roasting, grinding, and packaging area measures 17 m² with a ceiling height of 2.6 m. Since it contains machinery, what is the minimum ventilation rate that mechanical ventilation must deliver?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A combined roasting, grinding, and packaging area measures 17 m² with a ceiling height of 2.6 m. Since it contains machinery, what is the minimum ventilation rate that mechanical ventilation must deliver?', 'single_choice', 'hard', 'Given: A_RGP = 17 m²; H_c = 2.6 m; ACH = 3 per hour. Required: V_min, the minimum ventilation rate. Solution: Section VIII-F, citing Section 811 of PD 1096, requires not less than three air changes per hour for rooms with machinery. V_min = A_RGP x H_c x ACH = (17 m²)(2.6 m)(3 h⁻¹) = 132.6 m³/h ≈ 133 m³/h.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '44.2 m³/h', false, 0),
      (v_question_id, '51.0 m³/h', false, 1),
      (v_question_id, '132.6 m³/h', true, 2),
      (v_question_id, '176.8 m³/h', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 7 m² sorting area will be illuminated with 11 W to 15 W LED lamps. Using the minimum lighting intensity prescribed for sorting and the bulb density table in Annex D (0.313 bulbs/m² at 500 lux), how many lamps are required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A 7 m² sorting area will be illuminated with 11 W to 15 W LED lamps. Using the minimum lighting intensity prescribed for sorting and the bulb density table in Annex D (0.313 bulbs/m² at 500 lux), how many lamps are required?', 'single_choice', 'hard', 'Given: A_SORT = 7 m²; E_min = 500 lux; n = 0.313 bulbs/m². Required: N_bulbs, the number of LED lamps required. Solution: Section VIII-E.2 sets 500 lux as the minimum for sorting and operating or working areas. Entering Annex D at 500 lux under the 11 W to 15 W column gives n = 0.313 bulbs/m². N_bulbs = n x A_SORT = (0.313 bulbs/m²)(7 m²) = 2.19, rounded up to 3 lamps, since 2 lamps would leave the area below the 500 lux minimum.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2', false, 0),
      (v_question_id, '3', true, 1),
      (v_question_id, '7', false, 2),
      (v_question_id, '14', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A portable, non-wheeled fire extinguisher with a gross weight of 20 kg is to be mounted inside the processing facility. Per RA 9514, what are the maximum height of its top above the finished floor and the minimum clearance below it?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A portable, non-wheeled fire extinguisher with a gross weight of 20 kg is to be mounted inside the processing facility. Per RA 9514, what are the maximum height of its top above the finished floor and the minimum clearance below it?', 'single_choice', 'medium', 'Mounting height is keyed to gross weight W_g: W_g ≤ 18 kg → h_top ≤ 1.5 m; W_g > 18 kg → h_top ≤ 1.0 m. Since W_g = 20 kg > 18 kg, the 1.0 m limit governs. Independent of weight, the bottom clearance c must satisfy c ≥ 100 mm.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5 m and 100 mm', false, 0),
      (v_question_id, '1.0 m and 100 mm', true, 1),
      (v_question_id, '1.5 m and 150 mm', false, 2),
      (v_question_id, '1.0 m and 50 mm', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the hygienic zoning prescribed by the Technical Bulletin, which of the following is classified as a DIRTY area rather than a clean area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under the hygienic zoning prescribed by the Technical Bulletin, which of the following is classified as a DIRTY area rather than a clean area?', 'single_choice', 'medium', 'Section VIII-B enumerates exactly three clean areas: roasting, grinding, and packaging. Every other space, including receiving, floatation, pulping, fermentation, washing, drying, hulling, sorting, storage, AND display, is a dirty area. The display area admits customers from outside the facility, so it cannot be held to clean-area control.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Roasting area', false, 0),
      (v_question_id, 'Grinding area', false, 1),
      (v_question_id, 'Packaging area', false, 2),
      (v_question_id, 'Display area', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fermentation of pulped parchment coffee primarily removes the —';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Fermentation of pulped parchment coffee primarily removes the —', 'single_choice', 'easy', 'Section VI defines fermentation as a metabolic process acting on sugars, facilitated by enzymes naturally occurring in the coffee fruit together with microflora acquired from the environment. Its function is to break down the mucilage still adhering to the parchment after pulping, which would otherwise promote contamination. Upon completion, the parchment coffee must be washed thoroughly before drying.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Exocarp', false, 0),
      (v_question_id, 'Mucilage', true, 1),
      (v_question_id, 'Silver skin', false, 2),
      (v_question_id, 'Moisture', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Recommended relative humidity for green coffee bean storage is —';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Recommended relative humidity for green coffee bean storage is —', 'single_choice', 'easy', 'Section VIII-B.1.7 sets the storage conditions for GCB at 9% to 12% moisture content and 60% to 80% relative humidity, to prevent the beans from rewetting and degrading. A thermometer and hygrometer must be provided for monitoring of the storage conditions.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40%-60%', false, 0),
      (v_question_id, '50%-70%', false, 1),
      (v_question_id, '60%-80%', true, 2),
      (v_question_id, '70%-90%', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Environmental Engineering and Science (STRUCTURES_ENVIRONMENT) — 30 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Disease-causing organisms that grow and multiply within a host, producing an infection, are collectively termed';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Disease-causing organisms that grow and multiply within a host, producing an infection, are collectively termed', 'single_choice', 'easy', 'Pathogens include bacteria (cholera, typhoid), viruses (infectious hepatitis, polio), protozoa (giardiasis, cryptosporidiosis), and helminths (schistosomiasis). Contamination by human feces is the single most important source in water. Nutrients are growth-essential chemicals such as nitrogen and phosphorus; metalloids are elements showing both metallic and non-metallic behavior; surfactants are the detergent ingredients that lower surface tension.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'surfactants', false, 0),
      (v_question_id, 'nutrients', false, 1),
      (v_question_id, 'pathogens', true, 2),
      (v_question_id, 'metalloids', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which parameter expresses the amount of oxygen required to oxidize the organic matter in a wastewater sample by purely chemical means?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which parameter expresses the amount of oxygen required to oxidize the organic matter in a wastewater sample by purely chemical means?', 'single_choice', 'medium', 'COD measures the oxygen consumed in chemically oxidizing the waste, whereas BOD measures the oxygen that microorganisms require to biologically degrade it. DO is the oxygen actually present in the water, and TDS is a measure of salinity, not oxygen demand.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Chemical oxygen demand (COD)', true, 0),
      (v_question_id, 'Total dissolved solids (TDS)', false, 1),
      (v_question_id, 'Dissolved oxygen (DO)', false, 2),
      (v_question_id, 'Biochemical oxygen demand (BOD)', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Runoff originating from agricultural lands, urban streets, logging sites, and abandoned mines is classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Runoff originating from agricultural lands, urban streets, logging sites, and abandoned mines is classified as', 'single_choice', 'medium', 'Nonpoint sources are intermittent and enter the receiving water at many scattered locations, which makes them difficult to monitor and regulate. Point sources such as treatment plant outfalls and industrial discharge pipes collect the polluted water at a central point before release, and are therefore easier to control.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'an outfall discharge', false, 0),
      (v_question_id, 'an effluent load', false, 1),
      (v_question_id, 'a point source', false, 2),
      (v_question_id, 'a nonpoint source', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Liebig''s law of the minimum, the rate of algal growth in a water body is governed by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under Liebig''s law of the minimum, the rate of algal growth in a water body is governed by', 'single_choice', 'medium', 'That nutrient is the limiting nutrient. Reducing a non-limiting nutrient produces little benefit unless its concentration is driven low enough to become limiting. Freshwater systems are most often phosphorus limited, while most marine waters are nitrogen limited.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'the total mass of all nutrients present', false, 0),
      (v_question_id, 'the nutrient least available relative to the plant''s requirement', true, 1),
      (v_question_id, 'the nutrient present in the greatest concentration', false, 2),
      (v_question_id, 'the dissolved oxygen concentration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The accelerated aging of a lake caused by nutrient loading from municipal wastewater, industrial wastes, and fertilized agricultural runoff is termed';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The accelerated aging of a lake caused by nutrient loading from municipal wastewater, industrial wastes, and fertilized agricultural runoff is termed', 'single_choice', 'easy', 'Eutrophication occurring without human interference may take thousands of years; human activity can compress that process into decades, which is why it is described as cultural. Thermal stratification is the density-driven layering of a lake, and biomagnification is the increase in contaminant concentration at successively higher trophic levels.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'cultural eutrophication', true, 0),
      (v_question_id, 'thermal stratification', false, 1),
      (v_question_id, 'biomagnification', false, 2),
      (v_question_id, 'natural eutrophication', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a thermally stratified lake, the transition layer in which temperature falls rapidly with depth is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a thermally stratified lake, the transition layer in which temperature falls rapidly with depth is the', 'single_choice', 'medium', 'The epilimnion is the warm, wind-mixed surface layer; the hypolimnion is the cold bottom layer that is cut off from reaeration during summer stratification. The euphotic zone is defined by light rather than temperature — it is the upper region where photosynthetic oxygen production exceeds respiration.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'epilimnion', false, 0),
      (v_question_id, 'hypolimnion', false, 1),
      (v_question_id, 'thermocline (metalimnion)', true, 2),
      (v_question_id, 'euphotic zone', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A well drilled into a confined aquifer in which the water rises above the top of that aquifer without pumping is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A well drilled into a confined aquifer in which the water rises above the top of that aquifer without pumping is called', 'single_choice', 'medium', 'The level to which the water rises defines the piezometric (potentiometric) surface. If the pressure is sufficient to lift the water above ground level so that it discharges unaided, the well is described as a flowing artesian well. A water table well taps an unconfined aquifer, where water stands at atmospheric pressure at the water table.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a water table well', false, 0),
      (v_question_id, 'an artesian well', true, 1),
      (v_question_id, 'a perched well', false, 2),
      (v_question_id, 'a recharge well', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the Safe Drinking Water Act, the non-enforceable level of a contaminant at which no known or anticipated adverse health effect occurs, including a margin of safety and set without regard to cost or feasibility, is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under the Safe Drinking Water Act, the non-enforceable level of a contaminant at which no known or anticipated adverse health effect occurs, including a margin of safety and set without regard to cost or feasibility, is the', 'single_choice', 'medium', 'The MCLG is a health-based goal; the enforceable MCL is set as close to it as technological and economic feasibility allow. For carcinogens the MCLG is generally zero. A treatment technique is imposed instead of an MCL where the contaminant is impractical to measure routinely, and secondary standards address welfare concerns such as taste, odor, and color.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'secondary standard', false, 0),
      (v_question_id, 'treatment technique (TT)', false, 1),
      (v_question_id, 'Maximum Contaminant Level (MCL)', false, 2),
      (v_question_id, 'Maximum Contaminant Level Goal (MCLG)', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The addition of alum to raw water in order to neutralize the negative surface charge of colloids so that they will adhere to one another is';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The addition of alum to raw water in order to neutralize the negative surface charge of colloids so that they will adhere to one another is', 'single_choice', 'medium', 'Coagulation is a chemical process that destabilizes particles; it occurs in a rapid-mix tank with detention times of well under a minute. Flocculation is the physical process of gentle agitation that follows, allowing destabilized particles to collide and grow into settleable floc, which sedimentation and filtration then remove.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'coagulation', true, 0),
      (v_question_id, 'sedimentation', false, 1),
      (v_question_id, 'filtration', false, 2),
      (v_question_id, 'flocculation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Coliform bacteria are used in routine drinking water analysis mainly because they';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Coliform bacteria are used in routine drinking water analysis mainly because they', 'single_choice', 'medium', 'Testing individually for each pathogen is impractical, so the analysis looks instead for evidence of fecal contamination. Coliforms are excreted by the entire population in enormous numbers and generally outlive pathogens outside the host, so their absence implies pathogens are unlikely. The method is not absolute: viruses and protozoan cysts such as Giardia and Cryptosporidium may persist longer than coliforms and resist disinfection better.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'provide a direct measurement of organic strength', false, 0),
      (v_question_id, 'are the most virulent of the waterborne pathogens', false, 1),
      (v_question_id, 'serve as indicator organisms whose presence suggests fecal contamination', true, 2),
      (v_question_id, 'are the only bacteria able to survive chlorination', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The minimum settling velocity a particle must possess in order to be removed in a sedimentation basin, numerically equal to the flow rate divided by the basin surface area, is the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The minimum settling velocity a particle must possess in order to be removed in a sedimentation basin, numerically equal to the flow rate divided by the basin surface area, is the', 'single_choice', 'medium', 'It is also referred to as the surface loading rate, and every particle whose settling velocity equals or exceeds it is theoretically removed. Detention time is the basin volume divided by the flow rate; the filtration rate is the flow divided by filter area; mixing intensity (G) characterizes agitation in a flocculation basin.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'filtration rate', false, 0),
      (v_question_id, 'mixing intensity', false, 1),
      (v_question_id, 'hydraulic detention time', false, 2),
      (v_question_id, 'critical settling velocity', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly describes secondary treatment in a municipal wastewater treatment plant?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which statement correctly describes secondary treatment in a municipal wastewater treatment plant?', 'single_choice', 'medium', 'Primary treatment is purely physical and removes roughly 35 percent of the BOD and 60 percent of the suspended solids. A well-operated secondary plant achieves about 90 percent removal of both, which meets the Clean Water Act requirement of at least 85 percent BOD removal for publicly owned treatment works. Neither stage removes nutrients efficiently — typically no more than half the nitrogen and a third of the phosphorus — so advanced treatment is required where the receiving water is nutrient sensitive.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It relies only on screening, skimming, and gravity settling.', false, 0),
      (v_question_id, 'It augments physical processes with the microbial oxidation of organic matter.', true, 1),
      (v_question_id, 'It is designed principally to remove dissolved metals and salts.', false, 2),
      (v_question_id, 'It removes essentially all nitrogen and phosphorus from the effluent.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ground-level ozone produced when nitrogen oxides and volatile organic compounds react in the presence of sunlight is best classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Ground-level ozone produced when nitrogen oxides and volatile organic compounds react in the presence of sunlight is best classified as', 'single_choice', 'medium', 'Primary pollutants are emitted directly into the atmosphere; secondary pollutants are formed there by physical processes and chemical reactions. The NOx and VOCs that drive the reaction are themselves primary pollutants, but the ozone they produce is not emitted by any source.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a secondary pollutant', true, 0),
      (v_question_id, 'a fugitive emission', false, 1),
      (v_question_id, 'an inert tracer', false, 2),
      (v_question_id, 'a primary pollutant', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT among the criteria pollutants for which National Ambient Air Quality Standards have been established?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT among the criteria pollutants for which National Ambient Air Quality Standards have been established?', 'single_choice', 'easy', 'The criteria pollutants are carbon monoxide, lead, nitrogen dioxide, ground-level ozone, sulfur dioxide, and particulate matter (PM10 and PM2.5). The name derives from the multi-volume Air Quality Criteria documents on which the original standards were based. Carbon dioxide is a normal product of complete combustion and is of concern for its greenhouse effect rather than as a criteria pollutant.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sulfur dioxide', false, 0),
      (v_question_id, 'Carbon monoxide', false, 1),
      (v_question_id, 'Lead', false, 2),
      (v_question_id, 'Carbon dioxide', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Primary National Ambient Air Quality Standards are established in order to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Primary National Ambient Air Quality Standards are established in order to', 'single_choice', 'medium', 'Public welfare is the basis of the secondary standards, which in practice have usually been set at the same levels as the primary standards. Allowable release rates from particular sources are emission standards such as the New Source Performance Standards, not ambient standards. Balancing benefits against cost characterizes drinking water MCLs under the Safe Drinking Water Act, and is precisely what the NAAQS are not permitted to do.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'limit the rate at which pollutants may be released from a specific industrial source.', false, 0),
      (v_question_id, 'balance public health benefits against the cost of compliance.', false, 1),
      (v_question_id, 'protect public health with an adequate margin of safety, including the most sensitive individuals, regardless of cost or technological feasibility.', true, 2),
      (v_question_id, 'protect crops, structures, materials, and other elements of public welfare.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Nitrogen oxides produced when nitrogen and oxygen in the combustion air are heated to a sufficiently high flame temperature are known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Nitrogen oxides produced when nitrogen and oxygen in the combustion air are heated to a sufficiently high flame temperature are known as', 'single_choice', 'medium', 'Thermal NOx forms from the nitrogen in air at temperatures of roughly 1,000 K and above. Fuel NOx comes from nitrogen chemically bound in the fuel molecules themselves; natural gas contains almost none, while some coals contain as much as three percent nitrogen by weight.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'fuel NOx', false, 0),
      (v_question_id, 'thermal NOx', true, 1),
      (v_question_id, 'secondary NOx', false, 2),
      (v_question_id, 'fugitive NOx', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Carbon monoxide is hazardous to human health chiefly because it';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Carbon monoxide is hazardous to human health chiefly because it', 'single_choice', 'medium', 'Hemoglobin has a far greater affinity for carbon monoxide than for oxygen, so even modest concentrations act as an asphyxiant. The elderly, the fetus, and persons with cardiovascular disease are the most sensitive. Effects are usually reversible: healthy subjects clear about half the carbon monoxide from the blood within three to four hours of breathing clean air.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'deposits on lung tissue as a fine insoluble particulate.', false, 0),
      (v_question_id, 'irritates the eyes and mucous membranes.', false, 1),
      (v_question_id, 'binds with hemoglobin to form carboxyhemoglobin, reducing oxygen delivery to tissues.', true, 2),
      (v_question_id, 'reacts with water vapor to form a strong acid in the lungs.', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Solid particulate matter formed when vapors condense is specifically referred to as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Solid particulate matter formed when vapors condense is specifically referred to as', 'single_choice', 'easy', 'Dusts are solid particles generated by grinding or crushing operations; mist (or, loosely, fog) refers to liquid particles; and aerosol is the general term for any tiny solid or liquid particle dispersed in the atmosphere. Smoke and soot describe carbon particles from incomplete combustion.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'fume', true, 0),
      (v_question_id, 'mist', false, 1),
      (v_question_id, 'aerosol', false, 2),
      (v_question_id, 'dust', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The eye irritation most commonly complained of during a photochemical smog episode is caused principally by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The eye irritation most commonly complained of during a photochemical smog episode is caused principally by', 'single_choice', 'medium', 'Ozone is the most abundant photochemical oxidant and is responsible for chest constriction, irritation of the mucous membranes, damage to vegetation, and the cracking of rubber, but it is not the agent behind eye irritation. Peroxybenzoyl nitrate is another contributor. Carbon monoxide and sulfur dioxide are not products of the photochemical reaction sequence.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'sulfur dioxide', false, 0),
      (v_question_id, 'ozone', false, 1),
      (v_question_id, 'carbon monoxide', false, 2),
      (v_question_id, 'peroxyacetyl nitrate, formaldehyde, and acrolein', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The morning break-up of a nocturnal radiation inversion, which brings trapped pollutants rapidly back down to ground level, is known as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The morning break-up of a nocturnal radiation inversion, which brings trapped pollutants rapidly back down to ground level, is known as', 'single_choice', 'medium', 'Radiation inversions form on clear nights as the ground radiates heat to space, and they typically last only a matter of hours; because photochemical reactions cannot proceed without sunlight, the pollutant that usually accumulates is carbon monoxide. Subsidence refers to the descending, compressively heated air of a high-pressure system, which produces inversions that are higher, longer lasting, and more common in summer.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'scavenging', false, 0),
      (v_question_id, 'fumigation', true, 1),
      (v_question_id, 'subsidence', false, 2),
      (v_question_id, 'photolysis', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In an electrostatic precipitator, particulate matter is removed from a flue gas stream by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In an electrostatic precipitator, particulate matter is removed from a flue gas stream by', 'single_choice', 'medium', 'Wires held at a very high negative voltage ionize the gas, and the charged particles migrate to the grounded collector plates. Option A describes a cyclone collector, which is used for relatively large particles; option B describes a baghouse; option C describes wet flue-gas desulfurization, which targets sulfur dioxide rather than particulates.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'contacting the gas with a finely pulverized limestone slurry', false, 0),
      (v_question_id, 'spinning the gas in a vortex so that particles are thrown against the wall', false, 1),
      (v_question_id, 'passing the gas through fabric filter bags suspended in a large chamber', false, 2),
      (v_question_id, 'charging the particles in a corona discharge and collecting them on grounded plates', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is normally EXCLUDED from the category of municipal solid waste?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is normally EXCLUDED from the category of municipal solid waste?', 'single_choice', 'medium', 'Municipal solid waste covers residential, commercial, institutional, and industrial sources, but excludes construction waste, automobile bodies, municipal sludges, combustion ash, and industrial process wastes — even when those materials are disposed of in the same landfill or incinerator.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Food scraps from restaurants and markets', false, 0),
      (v_question_id, 'Yard trimmings from residences', false, 1),
      (v_question_id, 'Construction and demolition debris', true, 2),
      (v_question_id, 'Containers and packaging', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Within solid waste terminology, the combustible portion of rubbish is designated as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Within solid waste terminology, the combustible portion of rubbish is designated as', 'single_choice', 'medium', 'Rubbish covers both combustible and non-combustible materials such as cans, newspaper, tires, bottles, and plastics, but excludes food waste. Garbage is the putrescible animal and vegetable residue from the preparation and serving of food; refuse is essentially synonymous with solid waste; discards are what remain after materials have been recovered.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'trash', true, 0),
      (v_question_id, 'discards', false, 1),
      (v_question_id, 'refuse', false, 2),
      (v_question_id, 'garbage', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In solid waste accounting, waste generation is equal to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In solid waste accounting, waste generation is equal to', 'single_choice', 'medium', 'Generation is the total amount of material entering the waste stream. Materials recovery removes a portion for recycling or composting, and what is left over — the discards — is burned or buried. Activities that keep material out of the municipal system altogether are not counted as generation at all.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'discards only', false, 0),
      (v_question_id, 'materials recovered plus discards', true, 1),
      (v_question_id, 'discards minus materials recovered', false, 2),
      (v_question_id, 'the quantity landfilled plus the quantity combusted', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the hierarchy of integrated solid waste management, the highest priority is generally assigned to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the hierarchy of integrated solid waste management, the highest priority is generally assigned to', 'single_choice', 'easy', 'Source reduction and recycling occupy the top of the hierarchy because they cut the quantity that must be burned or buried, reduce the pollution associated with extracting and processing resources, and slow the consumption of scarce materials. Disposal ranks last. The hierarchy is a guide rather than a rigid rule, since the best option in a particular case depends on the material and the facilities available.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'landfilling in an engineered facility', false, 0),
      (v_question_id, 'combustion with energy recovery', false, 1),
      (v_question_id, 'source reduction', true, 2),
      (v_question_id, 'composting of yard trimmings', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Backyard composting of yard trimmings by a household is properly classified as';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Backyard composting of yard trimmings by a household is properly classified as', 'single_choice', 'medium', 'The material never enters the municipal collection system, so nothing is generated to be managed. By contrast, yard trimmings delivered to a municipal composting facility and sold as a soil amendment are considered recycling, because the material is collected and then purchased by an end user.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'resource recovery', false, 0),
      (v_question_id, 'disposal', false, 1),
      (v_question_id, 'recycling', false, 2),
      (v_question_id, 'source reduction', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A postconsumer recyclable material is best defined as one that';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A postconsumer recyclable material is best defined as one that', 'single_choice', 'medium', 'Old newspapers and used plastic bottles are typical examples. Option D describes preconsumer material, which is excluded from EPA generation and recovery statistics and generally does not count toward procurement laws that require recycled content in government purchases.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'has already been used by a consumer for its intended purpose and has entered the waste stream', true, 0),
      (v_question_id, 'is capable of being composted rather than landfilled', false, 1),
      (v_question_id, 'carries a eco-label certifying its environmental performance', false, 2),
      (v_question_id, 'is manufacturing scrap returned directly to the original production process', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The liquid that percolates through buried refuse and must be collected to protect the underlying groundwater is called';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The liquid that percolates through buried refuse and must be collected to protect the underlying groundwater is called', 'single_choice', 'easy', 'Municipal solid waste landfills are required to be built with a composite liner, a flexible membrane liner over compacted clay, together with a leachate collection system of perforated pipes and groundwater monitoring wells.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'digestate', false, 0),
      (v_question_id, 'leachate', true, 1),
      (v_question_id, 'effluent', false, 2),
      (v_question_id, 'condensate', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a sanitary landfill, a thin layer of soil is placed over each day''s compacted refuse primarily in order to';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In a sanitary landfill, a thin layer of soil is placed over each day''s compacted refuse primarily in order to', 'single_choice', 'medium', 'Each day''s waste is compacted into a cell and covered. When an active area has been filled with cells, additional layers called lifts may be placed on top. Compaction is achieved by heavy machinery making multiple passes, not by the cover itself, and a typical compacted density is on the order of 1,000 pounds per cubic yard.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'neutralize the acidity of the leachate', false, 0),
      (v_question_id, 'provide the compaction needed to reduce waste volume', false, 1),
      (v_question_id, 'increase the rate of methane generation', false, 2),
      (v_question_id, 'control windblown litter and odor, limit water entry, and deny access to rodents, birds, and flies', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Phase IV of the decomposition sequence in a landfill is characterized by';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Phase IV of the decomposition sequence in a landfill is characterized by', 'single_choice', 'hard', 'The sequence runs from an initial aerobic phase, to acidogenesis, to unsteady methanogenesis, and finally to steady methanogenesis roughly a year or so after a cell is closed. Gas production continues for many years, declining significantly only after perhaps several decades, which is why completed landfills require gas collection and venting systems.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'aerobic degradation with rapid oxygen consumption', false, 0),
      (v_question_id, 'acid formation, depressed pH, and the solubilization of heavy metals', false, 1),
      (v_question_id, 'steady methanogenesis, with methane and carbon dioxide generated in nearly equal proportions', true, 2),
      (v_question_id, 'the complete cessation of gas production', false, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Elements of Food Processing and Process Design (BIOPROCESS) — 21 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of thermal processing is described as a mild-intensity heat process in which fruits or vegetables are exposed to boiling water or steam for only 2 seconds to 2-3 minutes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which type of thermal processing is described as a mild-intensity heat process in which fruits or vegetables are exposed to boiling water or steam for only 2 seconds to 2-3 minutes?', 'single_choice', 'easy', 'Blanching is the least severe of the three thermal processes (blanching < pasteurizing < commercial sterilization) and is defined by very short exposure times of 2 seconds to 2-3 minutes in boiling water or steam.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pasteurization', false, 0),
      (v_question_id, 'Blanching', true, 1),
      (v_question_id, 'Commercial sterilization', false, 2),
      (v_question_id, 'Freeze concentration', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The principal purpose of blanching prior to freezing or canning is to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The principal purpose of blanching prior to freezing or canning is to:', 'single_choice', 'medium', 'Blanching inactivates endogenous enzymes — those responsible for browning, wilting, and similar defects. It is expressly noted as not being a sole method of preservation.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'lower water activity below 0.60', false, 0),
      (v_question_id, 'sterilize the container before filling', false, 1),
      (v_question_id, 'destroy all vegetative pathogens present', false, 2),
      (v_question_id, 'inactivate endogenous enzymes', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In milk processing, the continuous high-temperature short-time (HTST) or "flash pasteurization" condition is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In milk processing, the continuous high-temperature short-time (HTST) or "flash pasteurization" condition is:', 'single_choice', 'easy', 'HTST for milk is 72 °C for 15 seconds. The batch holding (LTLT) alternative is 63 °C for 30 minutes; both stay below the boiling point of water, within the 60-95 °C pasteurization range.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '63 °C for 30 minutes', false, 0),
      (v_question_id, '72 °C for 15 seconds', true, 1),
      (v_question_id, '95 °C for 2 minutes', false, 2),
      (v_question_id, '121 °C for 15 minutes', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Commercial sterilization, also known as "canning," is best characterized as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Commercial sterilization, also known as "canning," is best characterized as a:', 'single_choice', 'medium', 'Commercial sterilization is the highest-intensity heat process among the three. Because temperatures above 100 °C are required, steam under pressure is used; products are packed in cans, bottles, or bags.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'mild process applied only to acid fruit juices', false, 0),
      (v_question_id, 'moderate-intensity heat process conducted below 100 °C', false, 1),
      (v_question_id, 'high-intensity heat process requiring steam under pressure to reach temperatures above 100 °C', true, 2),
      (v_question_id, 'non-thermal process using ionizing radiation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly describes the effect of freezing on microorganisms in food?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which statement correctly describes the effect of freezing on microorganisms in food?', 'single_choice', 'medium', 'Freezing is not a sterilizing step — it only reduces microbial numbers. It is, however, recognized as a control measure for nematode parasites and tapeworms.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Freezing only reduces the number of microorganisms', true, 0),
      (v_question_id, 'Freezing permanently raises the minimum growth temperature of pathogens', false, 1),
      (v_question_id, 'Freezing has no recognized effect on parasites', false, 2),
      (v_question_id, 'Freezing sterilizes the food product', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The formation of histamine in fishes held under abusive temperatures proceeds through the action of which enzyme on L-histidine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The formation of histamine in fishes held under abusive temperatures proceeds through the action of which enzyme on L-histidine?', 'single_choice', 'medium', 'Histidine decarboxylase converts L-histidine to histamine with the release of carbon dioxide. Histamine accumulation is the basis of food intoxication in fishes.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Polyphenol oxidase', false, 0),
      (v_question_id, 'Histidine decarboxylase', true, 1),
      (v_question_id, 'Lipoxygenase', false, 2),
      (v_question_id, 'Pectin methylesterase', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under the FDA limits cited for food irradiation, the maximum dose allowed for fruits and vegetables is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Under the FDA limits cited for food irradiation, the maximum dose allowed for fruits and vegetables is:', 'single_choice', 'easy', 'Fruits and vegetables are limited to 1 kGy. The much higher 44 kGy figure belongs to the NASA Space Flight Program as the sterilization dose (10-log reduction) for frozen packaged meats.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 kGy', false, 0),
      (v_question_id, '44 kGy', false, 1),
      (v_question_id, '0.1 kGy', false, 2),
      (v_question_id, '1 kGy', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ionizing radiation is best defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Ionizing radiation is best defined as:', 'single_choice', 'medium', 'Ionizing radiation carries sufficient energy to displace an electron from an atom; examples include alpha particles, beta particles, high-energy electrons, gamma rays, and x-rays. Irradiation does not and cannot make foods radioactive, and causes only minimal temperature increase.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'radiation confined to the visible region of the spectrum', false, 0),
      (v_question_id, 'electromagnetic radiation that raises product temperature above 100 °C', false, 1),
      (v_question_id, 'electromagnetic radiation with enough energy to knock down an electron in an atom', true, 2),
      (v_question_id, 'radiation that renders the treated food slightly radioactive', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Preservation by concentration generally involves the removal of how much of the water, and yields products of what water activity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Preservation by concentration generally involves the removal of how much of the water, and yields products of what water activity?', 'single_choice', 'medium', 'Concentration removes 1/3 to 2/3 of the water from a liquid feed to yield a liquid concentrate with Aw of 0.7-0.85. The preservative effect is partial, so most of the benefit comes from reduced weight and volume.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/3 to 2/3 of the water; Aw of 0.7-0.85', true, 0),
      (v_question_id, 'all of the water; Aw below 0.30', false, 1),
      (v_question_id, 'about 1/10 of the water; Aw of 0.95-0.99', false, 2),
      (v_question_id, '2/3 to 3/4 of the water; Aw of 0.30-0.50', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Dehydration is regarded as the oldest method of preservation because it controls spoilage primarily by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Dehydration is regarded as the oldest method of preservation because it controls spoilage primarily by:', 'single_choice', 'medium', 'Dehydration stops microbial growth by lowering Aw. Enzymatic reactions and Maillard browning remain the principal quality concerns during the process.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'excluding oxygen from the package headspace', false, 0),
      (v_question_id, 'lowering water activity, thereby stopping the growth of microorganisms', true, 1),
      (v_question_id, 'denaturing all proteins in the food matrix', false, 2),
      (v_question_id, 'lowering the pH of the product', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The term "fermentation" is derived from the Latin verb fervere, which means:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The term "fermentation" is derived from the Latin verb fervere, which means:', 'single_choice', 'easy', 'Technically, fermentation is the process by which a living cell obtains energy through the breakdown of glucose and other simple sugars without requiring oxygen.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'to breathe', false, 0),
      (v_question_id, 'to sour', false, 1),
      (v_question_id, 'to boil', true, 2),
      (v_question_id, 'to leaven', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Vinegar is the characteristic product of which type of food fermentation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Vinegar is the characteristic product of which type of food fermentation?', 'single_choice', 'easy', 'Acetic acid fermentation yields vinegar. Alcoholic fermentation gives wine and beer, while lactic acid fermentation gives yoghurt, cheese, soy sauce, sausage, and fermented fish.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Acetic acid fermentation', true, 0),
      (v_question_id, 'Propionic acid fermentation', false, 1),
      (v_question_id, 'Alcoholic fermentation', false, 2),
      (v_question_id, 'Lactic acid fermentation', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The operating conditions cited for High Pressure Processing (HPP) of foods are:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The operating conditions cited for High Pressure Processing (HPP) of foods are:', 'single_choice', 'medium', 'HPP operates at 600-900 MPa (6,000-9,000 bar) for 5-10 minutes at 5-130 °C, inactivating microorganisms and viruses. It is commonly applied to juices and non-porous foods.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.1-1 MPa for 30 minutes at 100 °C', false, 0),
      (v_question_id, '6-9 MPa for 1 hour at ambient temperature', false, 1),
      (v_question_id, '60-90 MPa for 5 seconds at 72 °C', false, 2),
      (v_question_id, '600-900 MPa for 5-10 minutes at 5-130 °C', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In high power ultrasound, the formation of bubbles through the expansion and contraction of ultrasonic waves is termed:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In high power ultrasound, the formation of bubbles through the expansion and contraction of ultrasonic waves is termed:', 'single_choice', 'medium', 'Cavitation is the bubble formation and collapse phenomenon that drives the effect. It generates localized temperatures near 5000 K and pressures near 2000 atm, and operates at frequencies greater than 20 kHz.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Homogenization', false, 0),
      (v_question_id, 'Cavitation', true, 1),
      (v_question_id, 'Agglomeration', false, 2),
      (v_question_id, 'Sonic drying', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The life cycle of a microbial population, which can be modeled using a sigmoid curve, follows which sequence of phases?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The life cycle of a microbial population, which can be modeled using a sigmoid curve, follows which sequence of phases?', 'single_choice', 'medium', 'The population passes through lag, log (exponential), stationary, and death (decline) phases. The curve is described by a sigmoid model, while its temperature dependence is handled through the Arrhenius equation.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Log, stationary, lag, death', false, 0),
      (v_question_id, 'Log, lag, stationary, death', false, 1),
      (v_question_id, 'Lag, log, stationary, death', true, 2),
      (v_question_id, 'Lag, stationary, log, death', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Transport phenomena, as applied in food process design, involve the net macroscopic transfer of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Transport phenomena, as applied in food process design, involve the net macroscopic transfer of:', 'single_choice', 'medium', 'Transport phenomena cover all irreversible processes of statistical nature arising from the random continuous motion of molecules, and involve the net macroscopic transfer of mass, energy, and momentum, governed by the three Newtonian conservation laws.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'mass, energy, and momentum', true, 0),
      (v_question_id, 'heat, light, and sound', false, 1),
      (v_question_id, 'mass, charge, and entropy', false, 2),
      (v_question_id, 'momentum, charge, and energy', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the process design stages, which activity immediately follows the computation of material and energy balances?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the process design stages, which activity immediately follows the computation of material and energy balances?', 'single_choice', 'medium', 'The sequence runs: process flow → material and energy balances → sizing and rating → equipment and utilities costing → financial and profitability analysis → optimization and review.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Financial and profitability analysis', false, 0),
      (v_question_id, 'Optimization and review', false, 1),
      (v_question_id, 'Equipment and utilities costing', false, 2),
      (v_question_id, 'Sizing and rating', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which food process flowsheet is described as a simple representation of processes used for the preliminary calculation of material and energy balances?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which food process flowsheet is described as a simple representation of processes used for the preliminary calculation of material and energy balances?', 'single_choice', 'medium', 'The process block diagram is the simplest representation and carries material flow rates (kg/h), energy flows (kW), temperatures (°C), and pressures (bar). Process flow diagrams are more detailed and use specific symbols for equipment, piping, and utilities.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Piping and instrumentation diagram', false, 0),
      (v_question_id, 'Equipment layout', false, 1),
      (v_question_id, 'Process block diagram', true, 2),
      (v_question_id, 'Process flow diagram', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A flowsheet that specifies both the type and connection of instrumentation and the type and connection of pipes is a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A flowsheet that specifies both the type and connection of instrumentation and the type and connection of pipes is a:', 'single_choice', 'medium', 'The P&ID documents instrumentation and piping types and their connections. The process control diagram is distinct — it shows the position of control units and their connection with the sensors.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Process block diagram', false, 0),
      (v_question_id, 'Piping and instrumentation diagram', true, 1),
      (v_question_id, '3D process flow diagram', false, 2),
      (v_question_id, 'Equipment layout', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which mechanical transport equipment is used for fruits and vegetables suspended in water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which mechanical transport equipment is used for fruits and vegetables suspended in water?', 'single_choice', 'easy', 'Hydraulic conveyors move fruits and vegetables suspended in water, while pneumatic conveyors handle particles and grains suspended in air.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hydraulic conveyor', true, 0),
      (v_question_id, 'Bucket elevator', false, 1),
      (v_question_id, 'Roll conveyor', false, 2),
      (v_question_id, 'Pneumatic conveyor', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the classification of unit operations in food processing, drying is grouped under:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the classification of unit operations in food processing, drying is grouped under:', 'single_choice', 'medium', 'Drying is a mass transfer operation, together with extraction, distillation, absorption, adsorption, crystallization from solution, and ion exchange. Heating, blanching, pasteurization, sterilization, evaporation, cooling, and freezing fall under heat transfer operations.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Membrane separations', false, 0),
      (v_question_id, 'Non-thermal preservation', false, 1),
      (v_question_id, 'Heat transfer operations', false, 2),
      (v_question_id, 'Mass transfer operations', true, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Food Process Evaluation and Modelling (BIOPROCESS) — 10 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the estimation of fixed capital cost, the relation C_F = 1.6 C_Eq applies a multiplier known as the Lang factor. What range may this factor take?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the estimation of fixed capital cost, the relation C_F = 1.6 C_Eq applies a multiplier known as the Lang factor. What range may this factor take?', 'single_choice', 'medium', 'The Lang factor can vary between 1.5 and 2.5, with 1.6 used as the working value. Fixed capital cost accounts for 30-40% of total cost and covers the plant site and buildings as well as process equipment and installation.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.5 to 2.5', true, 0),
      (v_question_id, '0.5 to 0.7', false, 1),
      (v_question_id, '1.0 to 1.2', false, 2),
      (v_question_id, '3.0 to 4.0', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Working capital cost is commonly estimated as C_W = 0.5 C_F. Under what condition does this factor tend to rise toward 70%?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Working capital cost is commonly estimated as C_W = 0.5 C_F. Under what condition does this factor tend to rise toward 70%?', 'single_choice', 'medium', 'The factor may vary from 50-70%, especially for seasonal raw materials that require high raw material cost and manufacturing cost. Working capital covers cash at hand or in bank, manufacturing cost, and tax.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'When the plant is fully automated', false, 0),
      (v_question_id, 'When the project life exceeds 20 years', false, 1),
      (v_question_id, 'When seasonal raw materials drive high raw material and manufacturing costs', true, 2),
      (v_question_id, 'When the equipment is purchased second-hand', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Following the money flow diagram, net profit (P_N) is obtained by deducting which item from profit (P)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Following the money flow diagram, net profit (P_N) is obtained by deducting which item from profit (P)?', 'single_choice', 'medium', 'gross profit = sales - manufacturing cost. profit = gross profit - taxes. net profit = profit - capital recovery. Capital recovery is computed as C_R = eC_F, where e is the depreciation factor.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Taxes', false, 0),
      (v_question_id, 'Capital recovery', true, 1),
      (v_question_id, 'Manufacturing cost', false, 2),
      (v_question_id, 'Working capital', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a project with an expected life of 10 years under linear depreciation, the depreciation factor (e) used in computing capital recovery is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'For a project with an expected life of 10 years under linear depreciation, the depreciation factor (e) used in computing capital recovery is:', 'single_choice', 'medium', 'The depreciation factor is e = 1/N_T, where N_T is the expected project life. For a 10-year project, e = 1/10 = 0.1. This recovers the capital within the duration of the expected life.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10', false, 0),
      (v_question_id, '1.6', false, 1),
      (v_question_id, '0.5', false, 2),
      (v_question_id, '0.1', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In estimating equipment cost from capacity using C = C0(M/M0)^n, the scale index n takes a value of 0.5 for:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In estimating equipment cost from capacity using C = C0(M/M0)^n, the scale index n takes a value of 0.5 for:', 'single_choice', 'medium', 'A scale index of n = 0.5 applies to large processing units, while n = 1 applies to complex mechanical and electrical units. Food process equipment is generally more expensive than that of chemical industries because of materials and design requirements such as SUS 316 and hygienic construction.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'large processing units', true, 0),
      (v_question_id, 'complex mechanical and electrical units', false, 1),
      (v_question_id, 'second-hand off-the-shelf equipment', false, 2),
      (v_question_id, 'plant site and buildings', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT counted among the elements of a mathematical model?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT counted among the elements of a mathematical model?', 'single_choice', 'medium', 'A mathematical model consists of governing equations (conservation of mass, momentum, and energy), a priori information, and initial and boundary conditions including assumptions and constraints. Visualization of results belongs to the post-processing stage of an engineering simulation, not to the model itself.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Governing equations based on the three conservation laws', false, 0),
      (v_question_id, 'A priori information', false, 1),
      (v_question_id, 'Initial and boundary conditions', false, 2),
      (v_question_id, 'Post-processing visualization of results', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The conversion Kelvin = Celsius + 273.15 is cited as an example of which type of model?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The conversion Kelvin = Celsius + 273.15 is cited as an example of which type of model?', 'single_choice', 'easy', 'Deterministic, from the root word determinism, is the opposite of a random event — the future outcome can be calculated exactly without any involvement of randomness. A probabilistic model instead incorporates random variables and probability distributions and yields a probability distribution as its solution.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Probabilistic model', false, 0),
      (v_question_id, 'Deterministic model', true, 1),
      (v_question_id, 'Monte Carlo model', false, 2),
      (v_question_id, 'Discrete events model', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A modeling method that samples a process n times to determine statistical properties, using randomness to solve problems that might in principle be deterministic, is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A modeling method that samples a process n times to determine statistical properties, using randomness to solve problems that might in principle be deterministic, is:', 'single_choice', 'medium', 'The Monte Carlo method relies on repeated sampling and is particularly useful for modeling phenomena with significant uncertainty in the inputs, such as risk calculation in business and sensitivity analysis.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cellular automata', false, 0),
      (v_question_id, 'Lattice Boltzmann method', false, 1),
      (v_question_id, 'Monte Carlo method', true, 2),
      (v_question_id, 'Molecular dynamics', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In modeling space, the approach in which each location has a property, the domain is discretized into cells or points forming a mesh, and the observer is fixed is termed:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In modeling space, the approach in which each location has a property, the domain is discretized into cells or points forming a mesh, and the observer is fixed is termed:', 'single_choice', 'medium', 'The Eulerian approach keeps the observer fixed and assigns properties to discretized locations in a mesh. The Lagrangian approach instead predicts the movement of an object by its trajectory, with the observer moving together with the object.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Lagrangian approach', false, 0),
      (v_question_id, 'Eulerian approach', true, 1),
      (v_question_id, 'Discrete event approach', false, 2),
      (v_question_id, 'Stochastic approach', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the engineering simulation process flow, problem thinking, mesh generation, and choosing the computational model belong to which stage?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the engineering simulation process flow, problem thinking, mesh generation, and choosing the computational model belong to which stage?', 'single_choice', 'medium', 'These activities constitute pre-processing. Processing covers discretization of the mathematical equations, application of boundary conditions, and continuing iteration until convergence is reached, while post-processing covers numerical analysis and visualization of the results.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Processing', false, 0),
      (v_question_id, 'Post-processing', false, 1),
      (v_question_id, 'Model validation', false, 2),
      (v_question_id, 'Pre-processing', true, 3);
  END IF;
END $$;

-- =====================================================================
-- Topic: Design and Management of AB Processing System (BIOPROCESS) — 12 question(s)
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

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Good Manufacturing Practice is best defined as that part of quality assurance which ensures that products are:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Good Manufacturing Practice is best defined as that part of quality assurance which ensures that products are:', 'single_choice', 'medium', 'GMPs are the basic operational and environmental conditions required to produce safe foods. They address the hazards associated with personnel and environment during food production and provide the foundation for any food safety system.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'tested for compliance only after production has been completed', false, 0),
      (v_question_id, 'produced at the lowest possible cost while still meeting consumer demand', false, 1),
      (v_question_id, 'consistently produced and controlled to the quality standards appropriate to their intended use and as required by the marketing authorization', true, 2),
      (v_question_id, 'free of all biological, chemical, and physical hazards without need for any further control system', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which area addressed by GMPs covers preventive maintenance and calibration of thermometers, thermocouples, metal detectors, scales, and pH meters?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which area addressed by GMPs covers preventive maintenance and calibration of thermometers, thermocouples, metal detectors, scales, and pH meters?', 'single_choice', 'easy', 'Equipment maintenance covers preventive maintenance and calibration of all equipment and instruments that can affect food safety. Sanitation instead covers cleaning and sanitizing procedures and pre-operational assessment.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Equipment maintenance', true, 0),
      (v_question_id, 'Sanitation', false, 1),
      (v_question_id, 'Environmental control (premises)', false, 2),
      (v_question_id, 'Water safety', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Procedures ensuring that final products are coded and labelled properly, that incoming, in-process, and outgoing materials are traceable, and that a recall system is tested through mock recalls fall under which GMP area?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Procedures ensuring that final products are coded and labelled properly, that incoming, in-process, and outgoing materials are traceable, and that a recall system is tested through mock recalls fall under which GMP area?', 'single_choice', 'medium', 'Recall and traceability requires proper coding and labelling, traceability of materials across the process, and a recall system that is in place and tested for effectiveness, with mock recall procedures cited as the example.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shipping, receiving, handling, storage', false, 0),
      (v_question_id, 'Personnel practices', false, 1),
      (v_question_id, 'Pest control', false, 2),
      (v_question_id, 'Recall and traceability', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Good Agricultural Practice (GAP), formed within the European Union upon the initiative of FAO, is best characterized as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Good Agricultural Practice (GAP), formed within the European Union upon the initiative of FAO, is best characterized as:', 'single_choice', 'medium', 'GAP does not entail new standards; it provides a tool to help harmonize present standards by integrating environmental and social indicators into the production process. It rests on the principle "from farm to table," reflected in the integrated production system.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'an approach aiming at environmental, economic, and social compliance on the farm and through the stages of post-treatment and processing', true, 0),
      (v_question_id, 'an entirely new set of standards intended to replace existing food industry regulations', false, 1),
      (v_question_id, 'a quality system governing non-clinical health and environmental safety studies', false, 2),
      (v_question_id, 'a certification scheme restricted to animal husbandry operations', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the specific aims and objectives of the CODEX of Good Hygiene Practices is to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Among the specific aims and objectives of the CODEX of Good Hygiene Practices is to:', 'single_choice', 'medium', 'The CODEX of GHP aims to identify the essential principles of food hygiene applicable throughout the food chain, recommend a HACCP-based approach, indicate how to implement its principles, and provide guidance for specific codes needed by particular sectors.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'replace HACCP with a simpler inspection-based scheme', false, 0),
      (v_question_id, 'confine hygiene requirements to the manufacturing stage only', false, 1),
      (v_question_id, 'recommend a HACCP-based approach as a means to enhance food safety', true, 2),
      (v_question_id, 'set microbiological criteria to be applied by individual consumers', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The development of HACCP was based on which existing engineering system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'The development of HACCP was based on which existing engineering system?', 'single_choice', 'medium', 'FMEA examines what could potentially go wrong at each stage in an operation, together with possible causes and the likely effects. HACCP is described as more than a failure-mode-effect analysis for food.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Total Quality Management', false, 0),
      (v_question_id, 'Statistical process control', false, 1),
      (v_question_id, 'Six Sigma methodology', false, 2),
      (v_question_id, 'Failure, Mode and Effect Analysis (FMEA)', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is described as a prerequisite program essential to the development and implementation of a successful HACCP program?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is described as a prerequisite program essential to the development and implementation of a successful HACCP program?', 'single_choice', 'medium', 'cGMPs are prerequisite to effective HACCP programs. Prerequisites should be established, documented, regularly audited, and managed separately from the HACCP program, although certain aspects may be incorporated into the plan as verification activities.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Microbiological testing of every finished lot', false, 0),
      (v_question_id, 'Total Quality Management certification', false, 1),
      (v_question_id, 'Current Good Manufacturing Practices (cGMPs)', true, 2),
      (v_question_id, 'ISO 14001 environmental certification', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the application of HACCP, microbiological testing is seldom an effective means of monitoring CCPs because:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'In the application of HACCP, microbiological testing is seldom an effective means of monitoring CCPs because:', 'single_choice', 'medium', 'Monitoring of CCPs is best accomplished through physical and chemical tests and through visual observations. Microbiological criteria do, however, play a role in verifying that the overall HACCP system is working.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'it is prohibited by regulatory agencies', false, 0),
      (v_question_id, 'of the time required to obtain results', true, 1),
      (v_question_id, 'it cannot detect biological hazards', false, 2),
      (v_question_id, 'it applies only to thermally processed canned foods', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A critical limit is best defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'A critical limit is best defined as:', 'single_choice', 'medium', 'Critical limits document the appropriate parameters that must be met at each CCP and are set in order to prevent, eliminate, or reduce a hazard to an acceptable level.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'the acceptable number of corrective actions per production run', false, 0),
      (v_question_id, 'the point in the process at which a hazard is first identified', false, 1),
      (v_question_id, 'the frequency at which verification activities are conducted', false, 2),
      (v_question_id, 'a maximum or minimum value to which a biological, chemical, or physical limit must be controlled at a CCP', true, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Establishing procedures to be followed when a hazard is identified, with the aim of eliminating the cause and bringing the CCP back under control, corresponds to which HACCP principle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Establishing procedures to be followed when a hazard is identified, with the aim of eliminating the cause and bringing the CCP back under control, corresponds to which HACCP principle?', 'single_choice', 'medium', 'Beyond restoring control, the cause of the problem must be identified in order to prevent future recurrence.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Establish corrective action procedures', true, 0),
      (v_question_id, 'Establish critical limits', false, 1),
      (v_question_id, 'Establish verification procedures', false, 2),
      (v_question_id, 'Establish record-keeping and documentation procedures', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Verification procedures are best described as activities that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Verification procedures are best described as activities that:', 'single_choice', 'medium', 'Verification is distinct from CCP monitoring. It is usually completed yearly, or when a system fails or there is a major change in the product or process.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'take a planned series of observations to determine whether a CCP is within critical limits', false, 0),
      (v_question_id, 'identify the steps at which a hazard may be prevented, eliminated, or reduced', false, 1),
      (v_question_id, 'are other than monitoring CCPs, and show that the HACCP plan and system are operating accordingly', true, 2),
      (v_question_id, 'document the maximum or minimum values that must be met at each CCP', false, 3);
  END IF;

  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT one of the four types of HACCP records?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT one of the four types of HACCP records?', 'single_choice', 'easy', 'The four record types are the HACCP plan with its support documentation, records of CCP monitoring, records of corrective actions, and records of verification activities. Documentation and record keeping demonstrate the effective application of HACCP.', 'Board Exam Pro', 'ABELE 1st Ed Vol II Answer Key.pdf (pages 71-136)', 'draft')
    RETURNING id INTO v_question_id;

    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'HACCP plan and support documentation used in developing the plan', false, 0),
      (v_question_id, 'Records of employee attendance and payroll', true, 1),
      (v_question_id, 'Records of CCP monitoring', false, 2),
      (v_question_id, 'Records of corrective actions', false, 3);
  END IF;
END $$;

