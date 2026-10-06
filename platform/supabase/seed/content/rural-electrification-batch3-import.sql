-- Rural Electrification quiz batch 3 (40 questions, 1 topic). Every fact and
-- formula is drawn directly from the Philippine Agricultural Engineering
-- Standards on electric motors (specifications and methods of test) and from
-- standard electrical review material in the repo -- no invented facts. Every
-- numeric problem was re-derived independently before use, and every given
-- value is stated in the question text itself.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=true with a paes_reference only
-- where the question is directly about a PAES clause; otherwise false/NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Rural Electrification (STRUCTURES_ENVIRONMENT) -- 40 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Rural Electrification' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Rural Electrification';
  END IF;

  -- 1. Three-phase voltage displacement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a three-phase motor supply, the three individual voltages are displaced from one another by how many electrical degrees so that the voltage peaks occur at even time intervals and balance the power received by the motor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a three-phase motor supply, the three individual voltages are displaced from one another by how many electrical degrees so that the voltage peaks occur at even time intervals and balance the power received by the motor?', 'single_choice', 'easy', 'The three voltages of a three-phase supply are 120 degrees apart (360 / 3), so the peaks occur at even time intervals and the power received and delivered by the motor is balanced throughout its 360-degree rotation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90 degrees', false, 0),
      (v_question_id, '120 degrees', true, 1),
      (v_question_id, '60 degrees', false, 2),
      (v_question_id, '180 degrees', false, 3);
  END IF;

  -- 2. Starting torque definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What do you call the motor torque at zero speed, which is also the maximum torque required to start the load?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What do you call the motor torque at zero speed, which is also the maximum torque required to start the load?', 'single_choice', 'medium', 'Starting torque (also called locked-rotor torque) is the torque the motor develops at zero speed; it must be large enough to start the connected load.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Running torque', false, 0),
      (v_question_id, 'Breakdown torque', false, 1),
      (v_question_id, 'Full-load torque', false, 2),
      (v_question_id, 'Starting (locked-rotor) torque', true, 3);
  END IF;

  -- 3. Breakdown torque definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What do you call the maximum torque an electric motor can develop during overload without stalling?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What do you call the maximum torque an electric motor can develop during overload without stalling?', 'single_choice', 'medium', 'Breakdown torque (also called pull-out torque) is the maximum torque a motor can develop during overload without stalling. Starting torque, by contrast, is the torque at zero speed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rated torque', false, 0),
      (v_question_id, 'Starting torque', false, 1),
      (v_question_id, 'Breakdown (pull-out) torque', true, 2),
      (v_question_id, 'Locked-rotor torque', false, 3);
  END IF;

  -- 4. Thermal protector
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which motor accessory protects the motor against overheating due to overload or failure to start?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which motor accessory protects the motor against overheating due to overload or failure to start?', 'single_choice', 'easy', 'A thermal protector is a device that protects the motor against overheating caused by overload or by failure to start.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Thermal protector', true, 0),
      (v_question_id, 'Disconnecting switch', false, 1),
      (v_question_id, 'Voltage regulator', false, 2),
      (v_question_id, 'Centrifugal switch', false, 3);
  END IF;

  -- 5. Synchronous motor and power factor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of AC motor is capable of raising the power factor of a system that has large induction-motor loads?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of AC motor is capable of raising the power factor of a system that has large induction-motor loads?', 'single_choice', 'medium', 'A synchronous motor can be operated to raise (improve) the power factor of systems having large induction-motor loads. Squirrel-cage and wound-rotor motors are induction types and do not improve the system power factor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Synchronous motor', true, 0),
      (v_question_id, 'Squirrel-cage motor', false, 1),
      (v_question_id, 'Shaded-pole motor', false, 2),
      (v_question_id, 'Wound-rotor motor', false, 3);
  END IF;

  -- 6. Series motor high starting torque
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of DC motor, with its field winding connected in series with the armature, is used in applications requiring a high starting torque?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of DC motor, with its field winding connected in series with the armature, is used in applications requiring a high starting torque?', 'single_choice', 'easy', 'In a series-wound DC motor the field winding is in series with the armature, giving a high starting torque. A shunt-wound motor (field in parallel with the armature) is instead used where constant speed is needed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Squirrel-cage motor', false, 0),
      (v_question_id, 'Shunt-wound motor', false, 1),
      (v_question_id, 'Synchronous motor', false, 2),
      (v_question_id, 'Series-wound motor', true, 3);
  END IF;

  -- 7. Universal motor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of small series motor, rated up to 3.73 kW, is commonly designed to operate on either direct current or alternating current?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of small series motor, rated up to 3.73 kW, is commonly designed to operate on either direct current or alternating current?', 'single_choice', 'medium', 'A universal motor is a small series motor (up to 3.73 kW) designed to run on either DC or AC supply, which is why it is common in portable tools and small appliances.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Compound-wound motor', false, 0),
      (v_question_id, 'Repulsion motor', false, 1),
      (v_question_id, 'Universal motor', true, 2),
      (v_question_id, 'Shaded-pole motor', false, 3);
  END IF;

  -- 8. Fractional horsepower motor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A motor built in a smaller frame with a continuous rating of less than 1 hp, open type, running at 1,700 to 1,800 rpm is classified by size as what?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A motor built in a smaller frame with a continuous rating of less than 1 hp, open type, running at 1,700 to 1,800 rpm is classified by size as what?', 'single_choice', 'medium', 'A motor with a continuous rating of less than 1 hp (open type, 1,700 to 1,800 rpm) is a fractional-horsepower motor. Integral-horsepower motors are built in larger frames and are rated 1 hp or more.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Intermittent-duty motor', false, 0),
      (v_question_id, 'Fractional-horsepower motor', true, 1),
      (v_question_id, 'Integral-horsepower motor', false, 2),
      (v_question_id, 'Subfractional universal motor', false, 3);
  END IF;

  -- 9. Intermittent duty rating
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A motor that is to be used for less than one hour each time and then followed by a period of rest is given an intermittent duty rating. Which set lists the standard intermittent ratings, in minutes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A motor that is to be used for less than one hour each time and then followed by a period of rest is given an intermittent duty rating. Which set lists the standard intermittent ratings, in minutes?', 'single_choice', 'medium', 'Intermittent-rated motors are used for less than one hour each time followed by a rest period; the standard ratings are 5, 15, 30 and 60 minutes. A continuous rating is for use of more than one hour.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15, 30, 45 and 90 minutes', false, 0),
      (v_question_id, '10, 20, 40 and 80 minutes', false, 1),
      (v_question_id, '5, 15, 30 and 60 minutes', true, 2),
      (v_question_id, '30, 60, 90 and 120 minutes', false, 3);
  END IF;

  -- 10. Insulation class temperature
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which motor insulation class has a maximum continuous hot-spot temperature of 155 degrees Celsius?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which motor insulation class has a maximum continuous hot-spot temperature of 155 degrees Celsius?', 'single_choice', 'medium', 'Maximum continuous hot-spot temperatures by insulation class are: A = 105 C, B = 130 C, F = 155 C and H = 180 C. Hence Class F.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Class B', false, 0),
      (v_question_id, 'Class F', true, 1),
      (v_question_id, 'Class H', false, 2),
      (v_question_id, 'Class A', false, 3);
  END IF;

  -- 11. TEFC enclosure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A totally enclosed fan-cooled (TEFC) motor is cooled by which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A totally enclosed fan-cooled (TEFC) motor is cooled by which of the following?', 'single_choice', 'medium', 'A TEFC motor is totally enclosed and is cooled by an external integral fan mounted on the motor shaft. Circulating water cooling belongs to the water-cooled totally enclosed type, and a separate motor-driven blower belongs to the externally ventilated open type.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An external integral fan', true, 0),
      (v_question_id, 'A separate motor-driven blower', false, 1),
      (v_question_id, 'Water circulated through the enclosure', false, 2),
      (v_question_id, 'Resin-filled windings only', false, 3);
  END IF;

  -- 12. Repulsion motor reversal
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among single-phase motors, which type is not electrically reversible and is reversed only by readjusting the brush ring?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among single-phase motors, which type is not electrically reversible and is reversed only by readjusting the brush ring?', 'single_choice', 'hard', 'The wound-rotor (repulsion) motor has a winding and commutator on the rotor with short-circuited brushes, and its direction is reversed by readjusting the brush ring. Capacitor-start and two-value capacitor motors are electrically reversible, and shaded-pole motors cannot be reversed electrically.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two-value capacitor motor', false, 0),
      (v_question_id, 'Permanent split-capacitor motor', false, 1),
      (v_question_id, 'Capacitor-start induction-run motor', false, 2),
      (v_question_id, 'Wound-rotor (repulsion) motor', true, 3);
  END IF;

  -- 13. NEMA design D
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the NEMA design letters for integral-horsepower motors, which one has a very high starting torque, low starting current and high slip at rated load, and is used for loads such as punch presses?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among the NEMA design letters for integral-horsepower motors, which one has a very high starting torque, low starting current and high slip at rated load, and is used for loads such as punch presses?', 'single_choice', 'hard', 'Design D motors have very high starting torque, low starting current and high slip at rated load (typical slip of 5 to 8 percent or 8 to 13 percent), which suits intermittent, peaky loads such as punch presses, cranes and hoists.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Design A', false, 0),
      (v_question_id, 'Design B', false, 1),
      (v_question_id, 'Design D', true, 2),
      (v_question_id, 'Design C', false, 3);
  END IF;

  -- 14. Motor grounding
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which parts of an electric motor are required to be grounded in accordance with the Philippine Electrical Code?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which parts of an electric motor are required to be grounded in accordance with the Philippine Electrical Code?', 'single_choice', 'easy', 'Exposed noncurrent-carrying metal parts of the motor (frame, enclosure) must be grounded so that a fault current has a safe path to earth and the operator is protected from shock. Current-carrying parts such as the windings are not grounded.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The line (hot) conductors', false, 0),
      (v_question_id, 'Exposed noncurrent-carrying metal parts', true, 1),
      (v_question_id, 'The rotor bars', false, 2),
      (v_question_id, 'The stator windings', false, 3);
  END IF;

  -- 15. Power delay device
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An optional power delay device may be provided with an electric motor. Against which of the following does it protect the motor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An optional power delay device may be provided with an electric motor. Against which of the following does it protect the motor?', 'single_choice', 'medium', 'A power delay device protects the electric motor from surges of electricity as well as from low and high voltages,.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Surges and low or high voltages', true, 0),
      (v_question_id, 'Bearing wear and shaft misalignment', false, 1),
      (v_question_id, 'Reverse rotation of the shaft', false, 2),
      (v_question_id, 'Overheating from high ambient temperature only', false, 3);
  END IF;

  -- 16. Rotary phase converter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which phase converter, used to supply a three-phase motor from a single-phase line, uses a single-phase idler motor to create the third phase?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which phase converter, used to supply a three-phase motor from a single-phase line, uses a single-phase idler motor to create the third phase?', 'single_choice', 'medium', 'A rotary phase converter uses an idler motor to generate the third phase. A static converter uses capacitors to produce a synthetic three-phase output, and a digital converter uses digital signal processors and power electronics.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Static phase converter', false, 0),
      (v_question_id, 'Step-down phase converter', false, 1),
      (v_question_id, 'Digital phase converter', false, 2),
      (v_question_id, 'Rotary phase converter', true, 3);
  END IF;

  -- 17. Neutral conductor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which conductor is intentionally connected to the neutral point of the power source to provide a return path for unbalanced loads, allowing both three-phase and single-phase equipment to be used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which conductor is intentionally connected to the neutral point of the power source to provide a return path for unbalanced loads, allowing both three-phase and single-phase equipment to be used?', 'single_choice', 'medium', 'The neutral conductor connects to the neutral point of the source and carries the unbalanced return current, so single-phase loads can be served together with three-phase equipment. The ground wire, by contrast, is the connection that provides safety and fault protection.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Ground wire', false, 0),
      (v_question_id, 'Feeder conductor', false, 1),
      (v_question_id, 'Neutral conductor', true, 2),
      (v_question_id, 'Service entrance conductor', false, 3);
  END IF;

  -- 18. Methods of test - number of load settings
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the varying load performance test of an electric motor, data are obtained for at least how many load settings, and over what load range?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the varying load performance test of an electric motor, data are obtained for at least how many load settings, and over what load range?', 'single_choice', 'hard', 'The varying load test requires data for at least ten settings, from no load up to a maximum of 110 percent of the rated full load, with constant line voltage; input power, line voltage, load current, shaft torque, shaft speed and casing temperature are recorded at each increment.', NULL, NULL, 'draft', false, NULL, true, 'PAES 130:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least ten settings, from 50 to 150 percent of rated load', false, 0),
      (v_question_id, 'At least ten settings, from no load to 110 percent of rated load', true, 1),
      (v_question_id, 'At least three settings, at no load, half load and full load', false, 2),
      (v_question_id, 'At least five settings, from 25 to 100 percent of rated load', false, 3);
  END IF;

  -- 19. Methods of test - speed fluctuation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During the varying load test of an electric motor, the motor speed shall not fluctuate from the set speed by more than which limit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'During the varying load test of an electric motor, the motor speed shall not fluctuate from the set speed by more than which limit?', 'single_choice', 'hard', 'During the test, the speed of the motor must not fluctuate by more than 1 percent or 10 rpm, whichever is greater, from the set or selected speed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 130:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 percent or 10 rpm, whichever is greater', true, 0),
      (v_question_id, '2 percent or 20 rpm, whichever is smaller', false, 1),
      (v_question_id, '0.5 percent or 5 rpm, whichever is smaller', false, 2),
      (v_question_id, '5 percent or 50 rpm, whichever is greater', false, 3);
  END IF;

  -- 20. Methods of test - instrument location
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In testing an electric motor on a dynamometer, why are the power measuring instruments connected as close as possible to the motor terminals?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In testing an electric motor on a dynamometer, why are the power measuring instruments connected as close as possible to the motor terminals?', 'single_choice', 'medium', 'Placing the instruments close to the motor terminals minimizes the voltage drop in the lead wires between the meter and the motor, so the measured line voltage and input power represent what the motor actually receives.', NULL, NULL, 'draft', false, NULL, true, 'PAES 130:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To reduce the ambient temperature around the motor', false, 0),
      (v_question_id, 'To increase the starting torque of the motor', false, 1),
      (v_question_id, 'To raise the power factor of the motor', false, 2),
      (v_question_id, 'To reduce the voltage drop between the instruments and the motor', true, 3);
  END IF;

  -- 21. Service factor for small motors
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the standard service factor for motors rated from 0.37 to 0.75 kW (1/2 to 1 hp)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the standard service factor for motors rated from 0.37 to 0.75 kW (1/2 to 1 hp)?', 'single_choice', 'medium', 'The standard service factors are 1.40 for 0.04 to 0.09 kW, 1.35 for 0.12 to 0.25 kW, 1.25 for 0.37 to 0.75 kW, 1.15 for more than 0.75 kW up to 149.20 kW, and 1.00 for larger motors.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.40', false, 0),
      (v_question_id, '1.15', false, 1),
      (v_question_id, '1.00', false, 2),
      (v_question_id, '1.25', true, 3);
  END IF;

  -- 22. Shaded pole motor size
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Shaded-pole motors, which obtain starting torque from a current induced in a shading coil, are used only in very small sizes. What is the normal output limit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Shaded-pole motors, which obtain starting torque from a current induced in a shading coil, are used only in very small sizes. What is the normal output limit?', 'single_choice', 'medium', 'In a shaded-pole motor the current is induced in an auxiliary shading coil; shaded-pole motors are used only in very small sizes, normally below 50 W output.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Below 50 W output', true, 0),
      (v_question_id, 'Below 500 W output', false, 1),
      (v_question_id, 'Below 3.73 kW output', false, 2),
      (v_question_id, 'Below 1.5 kW output', false, 3);
  END IF;

  -- 23. Starting kVA from code letter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The nameplate of a 5-hp squirrel-cage induction motor shows motor code letter H, which corresponds to 6.30 to 7.09 kVA per horsepower of starting input. What is the range of the motor starting kVA?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The nameplate of a 5-hp squirrel-cage induction motor shows motor code letter H, which corresponds to 6.30 to 7.09 kVA per horsepower of starting input. What is the range of the motor starting kVA?', 'single_choice', 'medium', 'Given: 5 hp, code letter H = 6.30 to 7.09 kVA/hp. Starting kVA = 5 x 6.30 = 31.5 kVA (lower limit) to 5 x 7.09 = 35.45 kVA (upper limit). Answer: 31.5 to 35.45 kVA.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.15 to 3.55 kVA', false, 0),
      (v_question_id, '63.0 to 70.9 kVA', false, 1),
      (v_question_id, '31.5 to 35.45 kVA', true, 2),
      (v_question_id, '6.30 to 7.09 kVA', false, 3);
  END IF;

  -- 24. Apparent power of a three-phase motor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 7.5-hp, three-phase, 230-V induction motor draws a full-load line current of 22 A. What is the apparent power drawn by the motor? (Use S = square root of 3 x V x I.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 7.5-hp, three-phase, 230-V induction motor draws a full-load line current of 22 A. What is the apparent power drawn by the motor? (Use S = square root of 3 x V x I.)', 'single_choice', 'medium', 'Given: V = 230 V; I = 22 A. S = 1.732 x 230 x 22 = 8,764 VA, or about 8.76 kVA.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.92 kVA', false, 0),
      (v_question_id, '8.76 kVA', true, 1),
      (v_question_id, '5.06 kVA', false, 2),
      (v_question_id, '12.4 kVA', false, 3);
  END IF;

  -- 25. Ambient temperature correction of ampacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 30-mm2 TW copper conductor has a tabulated allowable ampacity of 90 A at an ambient temperature of 30 degrees Celsius. The installation ambient temperature is 38 degrees Celsius, where the temperature correction factor for TW conductors is 0.82. What is the corrected allowable ampacity of the conductor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 30-mm2 TW copper conductor has a tabulated allowable ampacity of 90 A at an ambient temperature of 30 degrees Celsius. The installation ambient temperature is 38 degrees Celsius, where the temperature correction factor for TW conductors is 0.82. What is the corrected allowable ampacity of the conductor?', 'single_choice', 'hard', 'Given: tabulated ampacity = 90 A at 30 C; correction factor at 36 to 40 C = 0.82. Corrected ampacity = 90 A x 0.82 = 73.8 A. A hotter ambient lowers the allowable current, so the factor is less than 1.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '73.8 A', true, 0),
      (v_question_id, '81.9 A', false, 1),
      (v_question_id, '90.0 A', false, 2),
      (v_question_id, '97.2 A', false, 3);
  END IF;

  -- 26. Input power at minimum efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 10-hp (7.46 kW) motor is required to meet a minimum efficiency of 90.2 percent at its rated output. What is the maximum input power the motor may draw at rated output?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 10-hp (7.46 kW) motor is required to meet a minimum efficiency of 90.2 percent at its rated output. What is the maximum input power the motor may draw at rated output?', 'single_choice', 'medium', 'Given: output = 7.46 kW; efficiency = 90.2 percent. Efficiency = output / input, so input = 7.46 / 0.902 = 8.27 kW.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '6.73 kW', false, 0),
      (v_question_id, '7.46 kW', false, 1),
      (v_question_id, '8.27 kW', true, 2),
      (v_question_id, '8.88 kW', false, 3);
  END IF;

  -- 27. Shaft torque from power and speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A motor under test must deliver 3.73 kW at a shaft speed of 1,740 rpm. Using the shaft output power formula Po = (T x N) / 974, where Po is in kW, T in kg-m and N in rpm, what shaft torque is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A motor under test must deliver 3.73 kW at a shaft speed of 1,740 rpm. Using the shaft output power formula Po = (T x N) / 974, where Po is in kW, T in kg-m and N in rpm, what shaft torque is required?', 'single_choice', 'hard', 'Given: Po = 3.73 kW; N = 1,740 rpm; Po = T x N / 974. T = 974 x Po / N = 974 x 3.73 / 1,740 = 2.09 kg-m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 130:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.48 kg-m', false, 0),
      (v_question_id, '2.09 kg-m', true, 1),
      (v_question_id, '20.5 kg-m', false, 2),
      (v_question_id, '6.66 kg-m', false, 3);
  END IF;

  -- 28. Three-phase real power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A three-phase, 230-V induction motor draws a line current of 15.2 A at a power factor of 0.82. What is the input power of the motor? (Use P = square root of 3 x V x I x power factor.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A three-phase, 230-V induction motor draws a line current of 15.2 A at a power factor of 0.82. What is the input power of the motor? (Use P = square root of 3 x V x I x power factor.)', 'single_choice', 'medium', 'Given: V = 230 V; I = 15.2 A; pf = 0.82. P = 1.732 x 230 x 15.2 x 0.82 = 4,965 W, or about 4.97 kW.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.87 kW', false, 0),
      (v_question_id, '6.06 kW', false, 1),
      (v_question_id, '3.50 kW', false, 2),
      (v_question_id, '4.97 kW', true, 3);
  END IF;

  -- 29. Three-phase line current
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A balanced three-phase load of 15 kW is supplied at 230 V line-to-line and operates at a power factor of 0.85. What is the line current?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A balanced three-phase load of 15 kW is supplied at 230 V line-to-line and operates at a power factor of 0.85. What is the line current?', 'single_choice', 'hard', 'Given: P = 15,000 W; V = 230 V; pf = 0.85. I = P / (1.732 x V x pf) = 15,000 / (1.732 x 230 x 0.85) = 44.3 A.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '37.7 A', false, 0),
      (v_question_id, '76.7 A', false, 1),
      (v_question_id, '65.2 A', false, 2),
      (v_question_id, '44.3 A', true, 3);
  END IF;

  -- 30. Generator kVA from kW load
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The electric motors of a rice milling plant have a total power input of 35 kW at an overall power factor of 0.80. What is the minimum generator rating in kVA?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The electric motors of a rice milling plant have a total power input of 35 kW at an overall power factor of 0.80. What is the minimum generator rating in kVA?', 'single_choice', 'medium', 'Given: real power = 35 kW; pf = 0.80. Apparent power = kW / pf = 35 / 0.80 = 43.75 kVA.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '54.7 kVA', false, 0),
      (v_question_id, '28.0 kVA', false, 1),
      (v_question_id, '43.75 kVA', true, 2),
      (v_question_id, '35.0 kVA', false, 3);
  END IF;

  -- 31. Motor current and conductor ampacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A single-phase, 220-V motor draws 5 kW of input power at a power factor of 0.80 in continuous duty. Branch-circuit conductors for a single continuous-duty motor must have an ampacity of at least 125 percent of the motor full-load current. What is the minimum conductor ampacity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A single-phase, 220-V motor draws 5 kW of input power at a power factor of 0.80 in continuous duty. Branch-circuit conductors for a single continuous-duty motor must have an ampacity of at least 125 percent of the motor full-load current. What is the minimum conductor ampacity?', 'single_choice', 'hard', 'Given: P = 5,000 W; V = 220 V; pf = 0.80. Full-load current I = P / (V x pf) = 5,000 / (220 x 0.80) = 28.4 A. Minimum ampacity = 1.25 x 28.4 = 35.5 A.', NULL, NULL, 'draft', false, NULL, true, 'PAES 129:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '28.4 A', false, 0),
      (v_question_id, '35.5 A', true, 1),
      (v_question_id, '22.7 A', false, 2),
      (v_question_id, '18.2 A', false, 3);
  END IF;

  -- 32. Monthly energy cost of a motor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 3.73-kW (5-hp) motor with an efficiency of 87.5 percent delivers its full rated output for 6 hours a day for 30 days. If electricity costs PHP 11.50 per kWh, what is the energy cost for the 30 days?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 3.73-kW (5-hp) motor with an efficiency of 87.5 percent delivers its full rated output for 6 hours a day for 30 days. If electricity costs PHP 11.50 per kWh, what is the energy cost for the 30 days?', 'single_choice', 'hard', 'Given: output = 3.73 kW; efficiency = 0.875; 6 h/day x 30 days = 180 h; rate = PHP 11.50/kWh. Input power = 3.73 / 0.875 = 4.263 kW. Energy = 4.263 x 180 = 767.3 kWh. Cost = 767.3 x 11.50 = PHP 8,824.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PHP 8,824', true, 0),
      (v_question_id, 'PHP 9,118', false, 1),
      (v_question_id, 'PHP 7,721', false, 2),
      (v_question_id, 'PHP 6,756', false, 3);
  END IF;

  -- 33. Energy cost per kilogram
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 7.5-kW motor-driven mill runs at full load for 4 hours to process 2,000 kg of grain. If electricity costs PHP 12.00 per kWh, what is the energy cost per kilogram of grain processed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 7.5-kW motor-driven mill runs at full load for 4 hours to process 2,000 kg of grain. If electricity costs PHP 12.00 per kWh, what is the energy cost per kilogram of grain processed?', 'single_choice', 'medium', 'Given: 7.5 kW; 4 h; 2,000 kg; PHP 12.00/kWh. Energy = 7.5 x 4 = 30 kWh. Energy per kg = 30 / 2,000 = 0.015 kWh/kg. Cost per kg = 0.015 x 12.00 = PHP 0.18/kg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PHP 1.80 per kg', false, 0),
      (v_question_id, 'PHP 0.018 per kg', false, 1),
      (v_question_id, 'PHP 0.18 per kg', true, 2),
      (v_question_id, 'PHP 0.36 per kg', false, 3);
  END IF;

  -- 34. Percent voltage drop in a branch circuit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 230-V single-phase branch circuit supplies a 20-A load located 40 m from the panel. Each conductor has a resistance of 5 ohms per kilometer. Considering both the outgoing and return conductors, what is the percent voltage drop based on 230 V?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 230-V single-phase branch circuit supplies a 20-A load located 40 m from the panel. Each conductor has a resistance of 5 ohms per kilometer. Considering both the outgoing and return conductors, what is the percent voltage drop based on 230 V?', 'single_choice', 'hard', 'Given: I = 20 A; one-way length = 40 m; 5 ohm/km per conductor; V = 230 V. Loop length = 2 x 40 = 80 m, so R = 5 x 0.080 = 0.40 ohm. Voltage drop = I x R = 20 x 0.40 = 8 V. Percent drop = 8 / 230 x 100 = 3.48 percent.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.74 percent', false, 0),
      (v_question_id, '3.48 percent', true, 1),
      (v_question_id, '6.96 percent', false, 2),
      (v_question_id, '8.00 percent', false, 3);
  END IF;

  -- 35. Conductor resistance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the resistance of a single copper conductor 150 m long with a cross-sectional area of 5.5 mm2? Use a resistivity of copper of 0.0172 ohm-mm2 per meter.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the resistance of a single copper conductor 150 m long with a cross-sectional area of 5.5 mm2? Use a resistivity of copper of 0.0172 ohm-mm2 per meter.', 'single_choice', 'medium', 'Given: rho = 0.0172 ohm-mm2/m; L = 150 m; A = 5.5 mm2. R = rho x L / A = 0.0172 x 150 / 5.5 = 0.469 ohm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.13 ohms', false, 0),
      (v_question_id, '14.2 ohms', false, 1),
      (v_question_id, '0.94 ohm', false, 2),
      (v_question_id, '0.47 ohm', true, 3);
  END IF;

  -- 36. Transformer rated primary current
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 25-kVA single-phase step-down transformer has a rated primary voltage of 2,300 V and a rated secondary voltage of 230 V. What is its rated primary current?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 25-kVA single-phase step-down transformer has a rated primary voltage of 2,300 V and a rated secondary voltage of 230 V. What is its rated primary current?', 'single_choice', 'medium', 'Given: S = 25,000 VA; Vp = 2,300 V. Ip = S / Vp = 25,000 / 2,300 = 10.87 A. (The rated secondary current is 25,000 / 230 = 108.7 A.)', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.87 A', true, 0),
      (v_question_id, '54.3 A', false, 1),
      (v_question_id, '1.09 A', false, 2),
      (v_question_id, '108.7 A', false, 3);
  END IF;

  -- 37. Open-delta transformer capacity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two identical 25-kVA single-phase transformers are connected in open-delta to supply a balanced three-phase load. What is the maximum three-phase load, in kVA, that the bank can carry? (Open-delta capacity = square root of 3 x the rating of one transformer.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two identical 25-kVA single-phase transformers are connected in open-delta to supply a balanced three-phase load. What is the maximum three-phase load, in kVA, that the bank can carry? (Open-delta capacity = square root of 3 x the rating of one transformer.)', 'single_choice', 'hard', 'Given: two 25-kVA units in open-delta; capacity = 1.732 x 25 = 43.3 kVA, which is about 86.6 percent of the 50 kVA total nameplate rating.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '43.3 kVA', true, 0),
      (v_question_id, '37.5 kVA', false, 1),
      (v_question_id, '50.0 kVA', false, 2),
      (v_question_id, '25.0 kVA', false, 3);
  END IF;

  -- 38. Power factor correction capacitor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A motor load takes 5 kW at a lagging power factor of 0.75. What capacitor rating, in kvar, is needed to raise the power factor to 0.95? (Required kvar = P x (tan of the original angle minus tan of the new angle).)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A motor load takes 5 kW at a lagging power factor of 0.75. What capacitor rating, in kvar, is needed to raise the power factor to 0.95? (Required kvar = P x (tan of the original angle minus tan of the new angle).)', 'single_choice', 'hard', 'Given: P = 5 kW; pf1 = 0.75, pf2 = 0.95. tan(arccos 0.75) = 0.8819, giving Q1 = 4.41 kvar. tan(arccos 0.95) = 0.3287, giving Q2 = 1.64 kvar. Capacitor kvar = 4.41 - 1.64 = 2.77 kvar.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.00 kvar', false, 0),
      (v_question_id, '4.41 kvar', false, 1),
      (v_question_id, '2.77 kvar', true, 2),
      (v_question_id, '1.64 kvar', false, 3);
  END IF;

  -- 39. Number of luminaires by lumen method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A room 8 m by 12 m requires an average maintained illumination of 300 lux. Each luminaire holds two lamps of 3,200 lumens each, the coefficient of utilization is 0.60 and the maintenance factor is 0.80. How many luminaires are needed? (Number of luminaires = illumination x area / (lumens per luminaire x CU x MF).)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A room 8 m by 12 m requires an average maintained illumination of 300 lux. Each luminaire holds two lamps of 3,200 lumens each, the coefficient of utilization is 0.60 and the maintenance factor is 0.80. How many luminaires are needed? (Number of luminaires = illumination x area / (lumens per luminaire x CU x MF).)', 'single_choice', 'hard', 'Given: E = 300 lux; A = 8 x 12 = 96 m2; 2 x 3,200 = 6,400 lm per luminaire; CU = 0.60; MF = 0.80. N = 300 x 96 / (6,400 x 0.60 x 0.80) = 28,800 / 3,072 = 9.375, rounded up to 10 luminaires.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 luminaires', false, 0),
      (v_question_id, '19 luminaires', false, 1),
      (v_question_id, '5 luminaires', false, 2),
      (v_question_id, '10 luminaires', true, 3);
  END IF;

  -- 40. Motor slip
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 4-pole induction motor is connected to a 60-Hz supply and runs at a full-load speed of 1,710 rpm. What is its percent slip? (Synchronous speed = 120 x f / P.)';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 4-pole induction motor is connected to a 60-Hz supply and runs at a full-load speed of 1,710 rpm. What is its percent slip? (Synchronous speed = 120 x f / P.)', 'single_choice', 'medium', 'Given: f = 60 Hz; P = 4 poles; N = 1,710 rpm. Synchronous speed = 120 x 60 / 4 = 1,800 rpm. Slip = (1,800 - 1,710) / 1,800 x 100 = 5.0 percent.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.26 percent', false, 0),
      (v_question_id, '5.0 percent', true, 1),
      (v_question_id, '10.0 percent', false, 2),
      (v_question_id, '2.5 percent', false, 3);
  END IF;

END $$;
