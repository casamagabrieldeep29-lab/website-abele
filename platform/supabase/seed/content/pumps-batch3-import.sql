-- Pumps quiz batch 3 (35 questions, 1 topic). Every fact, formula and
-- numeric answer is drawn from the reference library (PAES 115, 153, 154, 608
-- and 615 clauses and annexes, plus pump review notes and formula sheets
-- read in full on 2026-10-05) -- no invented facts. Every computation was
-- re-derived and each question states all of its given values in the text.
-- Topics covered here are NOT repeated from the existing PAES 114 batch
-- (paes-114-centrifugal-pump-import.sql): pump types, heads, NPSH, cavitation,
-- affinity laws, power and efficiency, pump selection, hand pumps, test procedure.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=true with a paes_reference only
-- where the question is directly about a PAES clause or annex; otherwise false/NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Pumps (LAND_WATER) -- 35 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Pumps' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Pumps';
  END IF;

  -- 1. Pumps vs turbines
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly differentiates a pump from a turbine?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly differentiates a pump from a turbine?', 'single_choice', 'easy', 'Pumps and turbines are both energy-conversion devices. A pump converts electrical or mechanical energy into fluid energy, while a turbine converts fluid energy into electrical or mechanical energy.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pumps convert fluid energy into mechanical work, while turbines need external energy to increase fluid flow', false, 0),
      (v_question_id, 'Pumps use energy to create fluid movement, while turbines create energy out of fluid movement', true, 1),
      (v_question_id, 'Turbines increase the velocity and pressure of the fluid, while pumps reduce them', false, 2),
      (v_question_id, 'Pumps are used only for gases, while turbines are used only for liquids', false, 3);
  END IF;

  -- 2. Positive vs non-positive displacement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement describes a positive displacement pump, as distinguished from a non-positive displacement pump?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement describes a positive displacement pump, as distinguished from a non-positive displacement pump?', 'single_choice', 'medium', 'Positive displacement pumps (rotary and reciprocating pumps) fill and empty chambers every cycle and move a fixed amount of fluid per rotation. Non-positive displacement pumps, such as the centrifugal pump, increase the potential energy of the liquid by increasing its kinetic energy.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Its chambers fill and empty during every cycle of operation, so it moves a fixed amount of fluid with each rotation', true, 0),
      (v_question_id, 'It depends on gravity flow through the casing to move the liquid, without any moving parts', false, 1),
      (v_question_id, 'It raises the potential energy of the liquid by first increasing the kinetic energy of the liquid', false, 2),
      (v_question_id, 'It delivers whatever flow results from the discharge head, regardless of the pump speed', false, 3);
  END IF;

  -- 3. Rotary pump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A rotary pump moves fluid from the inlet to the outlet by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A rotary pump moves fluid from the inlet to the outlet by:', 'single_choice', 'easy', 'A rotary pump traps the fluid with gears, vanes, lobes, or screws and conveys it from the inlet to the outlet. A back-and-forth piston or diaphragm describes a reciprocating pump, and rotating impellers describe a centrifugal pump.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Using the back-and-forth motion of a piston or diaphragm to pressurize the fluid', false, 0),
      (v_question_id, 'Using gears, vanes, lobes, or screws to trap and convey the fluid', true, 1),
      (v_question_id, 'Using centrifugal force imparted by one or more rotating impellers', false, 2),
      (v_question_id, 'Using the gravity head between the water source and the discharge point', false, 3);
  END IF;

  -- 4. Reciprocating pump for multi-bladed windmills
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of pump is appropriate for multi-bladed windmills, where a connecting rod converts the rotary motion of the rotor into a back-and-forth pumping action?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of pump is appropriate for multi-bladed windmills, where a connecting rod converts the rotary motion of the rotor into a back-and-forth pumping action?', 'single_choice', 'medium', 'A reciprocating pump uses the back-and-forth motion of mechanical parts, such as a piston or diaphragm, to pressurize the fluid. This suits the low-speed, high-torque operation of a multi-bladed windpump rotor.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reciprocating pump', true, 0),
      (v_question_id, 'Mixed flow pump', false, 1),
      (v_question_id, 'Centrifugal pump', false, 2),
      (v_question_id, 'Axial flow pump', false, 3);
  END IF;

  -- 5. Axial flow pump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.1, an axial flow pump develops most of its suction and discharge head by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.1, an axial flow pump develops most of its suction and discharge head by:', 'single_choice', 'medium', 'Clause 3.1: an axial flow pump develops most of its suction and discharge head by the propelling or lifting action of the impeller vanes on the water. A pump that develops head partly by centrifugal force and partly by vane lift is a mixed flow pump (clause 3.8).', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The back-and-forth motion of a piston inside a cylinder', false, 0),
      (v_question_id, 'Centrifugal force acting on the water inside a spiral or volute casing', false, 1),
      (v_question_id, 'The propelling or lifting action of the impeller vanes on the water', true, 2),
      (v_question_id, 'Partly centrifugal force and partly the lift of the vanes on the water', false, 3);
  END IF;

  -- 6. Mixed flow pump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.8, which type of pump combines some of the features of both the centrifugal pump and the axial flow pump, developing head partly by centrifugal force and partly by the lift of the vanes on the water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.8, which type of pump combines some of the features of both the centrifugal pump and the axial flow pump, developing head partly by centrifugal force and partly by the lift of the vanes on the water?', 'single_choice', 'medium', 'Clause 3.8: a mixed flow pump combines some of the features of the centrifugal and axial flow pumps, and its head is developed partly by centrifugal force and partly by the lift of the vanes on the water.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diffuser pump', false, 0),
      (v_question_id, 'Volute pump', false, 1),
      (v_question_id, 'Reciprocating pump', false, 2),
      (v_question_id, 'Mixed flow pump', true, 3);
  END IF;

  -- 7. Submersible pump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In pump selection for solar-powered irrigation systems, which pump type is designed for high head and medium flow rates but is very sensitive to dry running, so a float switch may be used to regulate the reservoir water level?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In pump selection for solar-powered irrigation systems, which pump type is designed for high head and medium flow rates but is very sensitive to dry running, so a float switch may be used to regulate the reservoir water level?', 'single_choice', 'medium', 'A submersible pump is very sensitive to dry running, so the sustainability of the water source must be ensured and a float switch may regulate the reservoir water level. A surface pump is mounted above the water level and suits shallow wells with high flow and low head.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Surface pump', false, 0),
      (v_question_id, 'Hand pump', false, 1),
      (v_question_id, 'Submersible pump', true, 2),
      (v_question_id, 'Booster pump', false, 3);
  END IF;

  -- 8. Double acting hand pump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 153:2010 clause 4.1.2.2, a double acting force type hand pump is one that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 153:2010 clause 4.1.2.2, a double acting force type hand pump is one that:', 'single_choice', 'medium', 'Clause 4.1.2.2: a double acting force type hand pump discharges water on both the forward and back strokes. A single acting pump (clause 4.1.2.1) discharges only on the forward stroke and draws water into the cylinder during the back stroke.', NULL, NULL, 'draft', false, NULL, true, 'PAES 153:2010')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Discharges water only on the forward stroke and draws water into the cylinder on the back stroke', false, 0),
      (v_question_id, 'Lifts water only by the action of the plunger and has no air chamber', false, 1),
      (v_question_id, 'Is driven by an engine instead of the movement of human arms', false, 2),
      (v_question_id, 'Discharges water on both the forward and the back strokes', true, 3);
  END IF;

  -- 9. Hand pump lifting performance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 153:2010 clause 7, what lifting performance is required of a lift type hand pump and of a force type hand pump, respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 153:2010 clause 7, what lifting performance is required of a lift type hand pump and of a force type hand pump, respectively?', 'single_choice', 'medium', 'Clause 7.2: a lift type hand pump shall lift water from a cistern or well to at least 6 m. Clause 7.3: a force type hand pump shall lift water up to a height of 15 m from ground level.', NULL, NULL, 'draft', false, NULL, true, 'PAES 153:2010')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Lift type: lift water to at least 15 m; force type: lift water up to a height of 6 m from ground level', false, 0),
      (v_question_id, 'Lift type: lift water to at least 3 m; force type: lift water up to a height of 20 m from ground level', false, 1),
      (v_question_id, 'Lift type: lift water from a cistern or well to at least 6 m; force type: lift water up to a height of 15 m from ground level', true, 2),
      (v_question_id, 'Both types: lift water to at least 10 m from ground level', false, 3);
  END IF;

  -- 10. Cavitation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.3, cavitation in a pump is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.3, cavitation in a pump is the:', 'single_choice', 'medium', 'Clause 3.3: cavitation is the formation of cavities filled with water vapor due to a local pressure drop, and their collapse as soon as the vapor bubbles reach regions of high pressure. The NPSHR of a pump states the minimum suction conditions needed to prevent it.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Loss of the liquid seal when the casing is not primed before starting the pump', false, 0),
      (v_question_id, 'Formation of cavities filled with water vapor due to a local pressure drop, which collapse once the vapor bubbles reach regions of high pressure', true, 1),
      (v_question_id, 'Rise in water temperature caused by recirculation inside the casing at zero discharge', false, 2),
      (v_question_id, 'Entry of atmospheric air through a leaking suction joint, forming an air lock inside the casing', false, 3);
  END IF;

  -- 11. Theoretical maximum suction lift
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under standard atmospheric pressure at sea level (14.7 psi), what is the theoretical maximum suction lift of a pump drawing water?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under standard atmospheric pressure at sea level (14.7 psi), what is the theoretical maximum suction lift of a pump drawing water?', 'single_choice', 'easy', 'Standard atmospheric pressure acting on the water surface can theoretically support a suction lift of about 33 ft. The practical suction lift is lower because of impurities in the water and frictional losses in the suction pipe.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 33 ft', true, 0),
      (v_question_id, 'About 50 ft', false, 1),
      (v_question_id, 'About 14.7 ft', false, 2),
      (v_question_id, 'About 10 ft', false, 3);
  END IF;

  -- 12. Static suction lift
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.19, the vertical distance from the free suction water level to the centerline of the pump is called the static suction lift when:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.19, the vertical distance from the free suction water level to the centerline of the pump is called the static suction lift when:', 'single_choice', 'medium', 'Clause 3.19: static suction lift exists when the source of water supply is below the centerline of the pump. When the source is above the centerline, the same vertical distance is the static suction head (clause 3.18).', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The source of water supply is above the centerline of the pump', false, 0),
      (v_question_id, 'The discharge water level is higher than the water source', false, 1),
      (v_question_id, 'The pump is operating at its maximum efficiency', false, 2),
      (v_question_id, 'The source of water supply is below the centerline of the pump', true, 3);
  END IF;

  -- 13. Static discharge head
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.17, the vertical distance from the centerline of the pump to the discharge water level is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.17, the vertical distance from the centerline of the pump to the discharge water level is called the:', 'single_choice', 'medium', 'Clause 3.17: static discharge head (hd) is the vertical distance from the centerline of the pump to the discharge water level. The total discharge head (clause 3.20) additionally includes friction and exit losses in the discharge piping plus the velocity head and pressure head at the point of discharge.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Total discharge head', false, 0),
      (v_question_id, 'Velocity head', false, 1),
      (v_question_id, 'Static suction head', false, 2),
      (v_question_id, 'Static discharge head', true, 3);
  END IF;

  -- 14. Specific speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In pump terminology, the specific speed of a pump expresses the relationship among:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In pump terminology, the specific speed of a pump expresses the relationship among:', 'single_choice', 'medium', 'Specific speed relates the pump speed in rpm, the discharge in gpm, and the head in feet.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Speed in rpm, discharge in gpm, and head in feet', true, 0),
      (v_question_id, 'Efficiency, brake horsepower, and water horsepower', false, 1),
      (v_question_id, 'Suction lift, discharge head, and friction head', false, 2),
      (v_question_id, 'Impeller diameter, casing diameter, and number of vanes', false, 3);
  END IF;

  -- 15. Total head with suction lift
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.21, where a suction lift exists, the total head of a pump is the sum of the total discharge head and the total suction lift. A pump draws water from a source below its centerline. The total discharge head is 28.5 m and the total suction lift is 3.2 m. What is the total head?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.21, where a suction lift exists, the total head of a pump is the sum of the total discharge head and the total suction lift. A pump draws water from a source below its centerline. The total discharge head is 28.5 m and the total suction lift is 3.2 m. What is the total head?', 'single_choice', 'medium', 'Given: total discharge head = 28.5 m; total suction lift = 3.2 m (suction lift exists). TH = total discharge head + total suction lift = 28.5 + 3.2 = 31.7 m. Where a positive suction head exists instead, the total suction head is subtracted from the total discharge head.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25.3 m', false, 0),
      (v_question_id, '28.5 m', false, 1),
      (v_question_id, '31.7 m', true, 2),
      (v_question_id, '34.9 m', false, 3);
  END IF;

  -- 16. Total discharge head from gauge reading
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the PAES 115:2000 head measurement, the total discharge head is Hd = Pd/gamma + vd^2/(2g) + zd + hf. A discharge pressure gauge reads 24 m of water, the flow velocity at the gauge connection is 3 m/s, the gauge elevation is 0.6 m, and the friction loss between the pressure tapping and the pump flange is 0.4 m. Using g = 9.81 m/s2, what is Hd?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the PAES 115:2000 head measurement, the total discharge head is Hd = Pd/gamma + vd^2/(2g) + zd + hf. A discharge pressure gauge reads 24 m of water, the flow velocity at the gauge connection is 3 m/s, the gauge elevation is 0.6 m, and the friction loss between the pressure tapping and the pump flange is 0.4 m. Using g = 9.81 m/s2, what is Hd?', 'single_choice', 'hard', 'Given: Pd/gamma = 24 m; v = 3 m/s; zd = 0.6 m; hf = 0.4 m; g = 9.81 m/s2. Velocity head = 3^2/(2 x 9.81) = 0.459 m. Hd = 24 + 0.459 + 0.6 + 0.4 = 25.46 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25.00 m', false, 0),
      (v_question_id, '25.46 m', true, 1),
      (v_question_id, '23.46 m', false, 2),
      (v_question_id, '25.92 m', false, 3);
  END IF;

  -- 17. NPSH available
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 3.10, NPSHA = (Pa - Pvp)/gamma - Hs. A pump has an atmospheric pressure Pa of 10,300 kg/m2, a vapor pressure Pvp of 240 kg/m2, a specific weight of water gamma of 1,000 kg/m3, and a total suction lift Hs of 5 m. What is the NPSHA?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 3.10, NPSHA = (Pa - Pvp)/gamma - Hs. A pump has an atmospheric pressure Pa of 10,300 kg/m2, a vapor pressure Pvp of 240 kg/m2, a specific weight of water gamma of 1,000 kg/m3, and a total suction lift Hs of 5 m. What is the NPSHA?', 'single_choice', 'hard', 'Given: Pa = 10,300 kg/m2; Pvp = 240 kg/m2; gamma = 1,000 kg/m3; Hs = 5 m. NPSHA = (10,300 - 240)/1,000 - 5 = 10.06 - 5 = 5.06 m. Ignoring the vapor pressure gives 5.30 m, and adding Pvp instead of subtracting gives 5.54 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.54 m', false, 0),
      (v_question_id, '15.06 m', false, 1),
      (v_question_id, '5.30 m', false, 2),
      (v_question_id, '5.06 m', true, 3);
  END IF;

  -- 18. Water power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a PAES 115:2000 performance test, water power is computed as WP = TH x Q / 102, where WP is in kW, TH is the total head in m, and Q is the discharge in L/s. A pump delivers 20 L/s at a total head of 25 m. What is the water power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a PAES 115:2000 performance test, water power is computed as WP = TH x Q / 102, where WP is in kW, TH is the total head in m, and Q is the discharge in L/s. A pump delivers 20 L/s at a total head of 25 m. What is the water power?', 'single_choice', 'medium', 'Given: TH = 25 m; Q = 20 L/s. WP = TH x Q / 102 = (25 x 20) / 102 = 500 / 102 = 4.90 kW.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.10 kW', false, 0),
      (v_question_id, '51.0 kW', false, 1),
      (v_question_id, '4.90 kW', true, 2),
      (v_question_id, '2.45 kW', false, 3);
  END IF;

  -- 19. Pump efficiency from torque and speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a PAES 115:2000 performance test, the pump input power is IPp = Ts x N / 974, where IPp is in kW, Ts is the input shaft torque in kg-m, and N is the shaft speed in rpm. The pump efficiency is the water power divided by IPp, times 100. A pump has a water power of 4.9 kW and runs at 1,450 rpm with an input shaft torque of 5 kg-m. What is the pump efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a PAES 115:2000 performance test, the pump input power is IPp = Ts x N / 974, where IPp is in kW, Ts is the input shaft torque in kg-m, and N is the shaft speed in rpm. The pump efficiency is the water power divided by IPp, times 100. A pump has a water power of 4.9 kW and runs at 1,450 rpm with an input shaft torque of 5 kg-m. What is the pump efficiency?', 'single_choice', 'hard', 'Given: WP = 4.9 kW; Ts = 5 kg-m; N = 1,450 rpm. IPp = (5 x 1,450) / 974 = 7.44 kW. Pump efficiency = (4.9 / 7.44) x 100 = 65.8%. Using 1,000 instead of 974 gives 67.6%, and inverting the ratio gives 151.9%.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '65.8%', true, 0),
      (v_question_id, '151.9%', false, 1),
      (v_question_id, '67.6%', false, 2),
      (v_question_id, '34.2%', false, 3);
  END IF;

  -- 20. Overall (wire-to-water) efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 Annex G, the overall (wire-to-water) efficiency is the water power divided by the input power to the motor, times 100. A pumping unit has a water power of 5.1 kW and an electric motor input power of 8.5 kW. What is its overall efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 Annex G, the overall (wire-to-water) efficiency is the water power divided by the input power to the motor, times 100. A pumping unit has a water power of 5.1 kW and an electric motor input power of 8.5 kW. What is its overall efficiency?', 'single_choice', 'easy', 'Given: WP = 5.1 kW; input power to the motor IPm = 8.5 kW. Overall efficiency = (5.1 / 8.5) x 100 = 60.0%.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '166.7%', false, 0),
      (v_question_id, '60.0%', true, 1),
      (v_question_id, '40.0%', false, 2),
      (v_question_id, '85.0%', false, 3);
  END IF;

  -- 21. Brake horsepower, US units
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pump delivers 500 gpm against a total dynamic head of 40 ft. The pump efficiency is 65%. Using BHP = Q x TDH / (3960 x pump efficiency), with Q in gpm and TDH in ft, what is the brake horsepower?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pump delivers 500 gpm against a total dynamic head of 40 ft. The pump efficiency is 65%. Using BHP = Q x TDH / (3960 x pump efficiency), with Q in gpm and TDH in ft, what is the brake horsepower?', 'single_choice', 'medium', 'Given: Q = 500 gpm; TDH = 40 ft; efficiency = 0.65. BHP = (500 x 40) / (3960 x 0.65) = 20,000 / 2,574 = 7.77 hp. Omitting the efficiency gives the water horsepower of 5.05 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.05 hp', false, 0),
      (v_question_id, '7.77 hp', true, 1),
      (v_question_id, '11.95 hp', false, 2),
      (v_question_id, '3.28 hp', false, 3);
  END IF;

  -- 22. Groundwater pumping input power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Groundwater is pumped from a shallow aquifer for irrigation at a required discharge of 300 gpm. The suction head is 8 ft, the maximum drawdown is 10 ft, and the friction and minor losses are 0.45 ft and 0.3 ft, respectively. The pump efficiency is 60%. Using BHP = Q x TDH / (3960 x efficiency), with Q in gpm and TDH in ft, what is the theoretical input power required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Groundwater is pumped from a shallow aquifer for irrigation at a required discharge of 300 gpm. The suction head is 8 ft, the maximum drawdown is 10 ft, and the friction and minor losses are 0.45 ft and 0.3 ft, respectively. The pump efficiency is 60%. Using BHP = Q x TDH / (3960 x efficiency), with Q in gpm and TDH in ft, what is the theoretical input power required?', 'single_choice', 'medium', 'Given: Q = 300 gpm; suction head = 8 ft; drawdown = 10 ft; friction loss = 0.45 ft; minor loss = 0.3 ft; efficiency = 0.60. TDH = 8 + 10 + 0.45 + 0.3 = 18.75 ft. BHP = (300 x 18.75) / (3960 x 0.60) = 5,625 / 2,376 = 2.37, or about 2.4 hp. The water horsepower alone is 1.42 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.9 hp', false, 0),
      (v_question_id, '1.4 hp', false, 1),
      (v_question_id, '0.85 hp', false, 2),
      (v_question_id, '2.4 hp', true, 3);
  END IF;

  -- 23. Pump discharge for irrigation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 2-ha field is irrigated by pumping. Evapotranspiration is 6 mm/day, percolation is 2 mm/day, the irrigation interval is 4 days, the pump operates 8 hours per irrigation, and the irrigation efficiency is 75%. What pump discharge is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 2-ha field is irrigated by pumping. Evapotranspiration is 6 mm/day, percolation is 2 mm/day, the irrigation interval is 4 days, the pump operates 8 hours per irrigation, and the irrigation efficiency is 75%. What pump discharge is required?', 'single_choice', 'hard', 'Given: A = 2 ha = 20,000 m2; ET + percolation = 6 + 2 = 8 mm/day; interval = 4 days; time = 8 h; efficiency = 0.75. Net depth = 8 x 4 = 32 mm; gross depth = 32 / 0.75 = 42.67 mm. Volume = 0.04267 m x 20,000 m2 = 853.3 m3. Q = 853.3 / (8 x 3,600 s) = 0.0296 m3/s = 29.6 L/s.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '29.6 L/s', true, 0),
      (v_question_id, '22.2 L/s', false, 1),
      (v_question_id, '118.5 L/s', false, 2),
      (v_question_id, '39.5 L/s', false, 3);
  END IF;

  -- 24. Affinity law: head vs speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A centrifugal pump running at 1,500 rpm delivers 200 m3/h at a head of 30 m. The speed is increased to 1,800 rpm with the same impeller. Assuming the pump affinity laws apply, what is the new head?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A centrifugal pump running at 1,500 rpm delivers 200 m3/h at a head of 30 m. The speed is increased to 1,800 rpm with the same impeller. Assuming the pump affinity laws apply, what is the new head?', 'single_choice', 'easy', 'Given: N1 = 1,500 rpm; N2 = 1,800 rpm; H1 = 30 m. Head varies with the square of the speed: H2 = H1 x (N2/N1)^2 = 30 x (1.2)^2 = 30 x 1.44 = 43.2 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '51.8 m', false, 0),
      (v_question_id, '36.0 m', false, 1),
      (v_question_id, '43.2 m', true, 2),
      (v_question_id, '20.8 m', false, 3);
  END IF;

  -- 25. Affinity law: power vs speed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The speed of an irrigation centrifugal pump is increased by 30% with the impeller diameter unchanged. By what percentage does the power requirement increase, assuming the pump affinity laws apply?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The speed of an irrigation centrifugal pump is increased by 30% with the impeller diameter unchanged. By what percentage does the power requirement increase, assuming the pump affinity laws apply?', 'single_choice', 'medium', 'Given: N2 = 1.3 N1. Power varies with the cube of the speed: P2/P1 = (1.3)^3 = 2.197. The power requirement becomes 2.197 times the original, an increase of 119.7%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'About 119.7%', true, 0),
      (v_question_id, '219.7%', false, 1),
      (v_question_id, '69%', false, 2),
      (v_question_id, '30%', false, 3);
  END IF;

  -- 26. Affinity law: head vs impeller diameter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A centrifugal pump with a 250-mm impeller, running at a constant speed, develops a head of 40 m. The impeller is trimmed to 200 mm. Assuming the pump affinity laws apply, what is the new head?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A centrifugal pump with a 250-mm impeller, running at a constant speed, develops a head of 40 m. The impeller is trimmed to 200 mm. Assuming the pump affinity laws apply, what is the new head?', 'single_choice', 'medium', 'Given: D1 = 250 mm; D2 = 200 mm; H1 = 40 m; speed constant. Head varies with the square of the impeller diameter: H2 = H1 x (D2/D1)^2 = 40 x (0.8)^2 = 40 x 0.64 = 25.6 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20.5 m', false, 0),
      (v_question_id, '32.0 m', false, 1),
      (v_question_id, '62.5 m', false, 2),
      (v_question_id, '25.6 m', true, 3);
  END IF;

  -- 27. Total dynamic head of a shallow tubewell
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In sizing the pump of a shallow tubewell per PAES 615:2016, the static water level is 6.0 m, the friction losses in the pipes are 1.10 m, and the maximum drawdown at the design discharge is 2.5 m. An allowance of 0.6 m is added for other head losses. What is the total dynamic head?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In sizing the pump of a shallow tubewell per PAES 615:2016, the static water level is 6.0 m, the friction losses in the pipes are 1.10 m, and the maximum drawdown at the design discharge is 2.5 m. An allowance of 0.6 m is added for other head losses. What is the total dynamic head?', 'single_choice', 'medium', 'Given: SWL = 6.0 m; Hf = 1.10 m; DD = 2.5 m; Hsf = 0.6 m. TDH = SWL + Hf + DD + Hsf = 6.0 + 1.10 + 2.5 + 0.6 = 10.20 m.', NULL, NULL, 'draft', false, NULL, true, 'PAES 615:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10.80 m', false, 0),
      (v_question_id, '9.60 m', false, 1),
      (v_question_id, '10.20 m', true, 2),
      (v_question_id, '9.10 m', false, 3);
  END IF;

  -- 28. Brake horsepower of a shallow tubewell pump
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 615:2016, the brake horsepower of a shallow tubewell pump is BHP = TDH x Qd / (102 x Ep), where BHP is in kW, TDH is in m, Qd is the design pump discharge in L/s, and Ep is the pump efficiency. For a TDH of 15 m, a design discharge of 12 L/s, and the pump efficiency of 55% assumed by the standard, what is the brake horsepower?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 615:2016, the brake horsepower of a shallow tubewell pump is BHP = TDH x Qd / (102 x Ep), where BHP is in kW, TDH is in m, Qd is the design pump discharge in L/s, and Ep is the pump efficiency. For a TDH of 15 m, a design discharge of 12 L/s, and the pump efficiency of 55% assumed by the standard, what is the brake horsepower?', 'single_choice', 'medium', 'Given: TDH = 15 m; Qd = 12 L/s; Ep = 0.55. BHP = (15 x 12) / (102 x 0.55) = 180 / 56.1 = 3.21 kW. Omitting the efficiency gives 1.76 kW.', NULL, NULL, 'draft', false, NULL, true, 'PAES 615:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.76 kW', false, 0),
      (v_question_id, '3.21 kW', true, 1),
      (v_question_id, '4.30 kW', false, 2),
      (v_question_id, '0.97 kW', false, 3);
  END IF;

  -- 29. Prime mover power rating
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 615:2016 Table 5, which prime mover has an estimated body indicated power rating of 1.40 to 1.50 times the pump brake horsepower?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 615:2016 Table 5, which prime mover has an estimated body indicated power rating of 1.40 to 1.50 times the pump brake horsepower?', 'single_choice', 'hard', 'Table 5 ratings relative to BHP: electric motor 1.15; diesel water-cooled 1.25 to 1.30; diesel air-cooled 1.30 to 1.35; gasoline water-cooled 1.35 to 1.40; gasoline air-cooled 1.40 to 1.50.', NULL, NULL, 'draft', false, NULL, true, 'PAES 615:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diesel engine, air-cooled', false, 0),
      (v_question_id, 'Gasoline engine, air-cooled', true, 1),
      (v_question_id, 'Gasoline engine, water-cooled', false, 2),
      (v_question_id, 'Electric motor', false, 3);
  END IF;

  -- 30. Sprinkler system pump power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 608:2016 Part A (sprinkler irrigation), the pump power requirement is P = Q x TDH / (360 x Ep), where P is in kW, Q is the system capacity in m3/h, TDH is in m, and Ep is the pump efficiency. A sprinkler system has a capacity of 100 m3/h, a total dynamic head of 40 m, and a pump efficiency of 70%. What is the pump power requirement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 608:2016 Part A (sprinkler irrigation), the pump power requirement is P = Q x TDH / (360 x Ep), where P is in kW, Q is the system capacity in m3/h, TDH is in m, and Ep is the pump efficiency. A sprinkler system has a capacity of 100 m3/h, a total dynamic head of 40 m, and a pump efficiency of 70%. What is the pump power requirement?', 'single_choice', 'medium', 'Given: Q = 100 m3/h; TDH = 40 m; Ep = 0.70. P = (100 x 40) / (360 x 0.70) = 4,000 / 252 = 15.87 kW.', NULL, NULL, 'draft', false, NULL, true, 'PAES 608:2016')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15.87 kW', true, 0),
      (v_question_id, '11.11 kW', false, 1),
      (v_question_id, '7.78 kW', false, 2),
      (v_question_id, '22.68 kW', false, 3);
  END IF;

  -- 31. Test water temperature
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 115:2000 clause 4.4.1, the water used during a pump test shall be clean and have a temperature within the range of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 115:2000 clause 4.4.1, the water used during a pump test shall be clean and have a temperature within the range of:', 'single_choice', 'easy', 'Clause 4.4.1: the water to be used during the test shall be clean with a temperature range of 10 - 40 °C. The same range applies to the cavitation test (clause 5.3.2.2) and to the water used to fill the priming chamber (clause 5.4.4).', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20 - 50 °C', false, 0),
      (v_question_id, '15 - 40 °C', false, 1),
      (v_question_id, '10 - 30 °C', false, 2),
      (v_question_id, '10 - 40 °C', true, 3);
  END IF;

  -- 32. Cavitation test procedure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the cavitation test of PAES 115:2000, the pump is operated at constant discharge and at the speed recommended by the manufacturer. Which quantity is varied, starting from low to maximum?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the cavitation test of PAES 115:2000, the pump is operated at constant discharge and at the speed recommended by the manufacturer. Which quantity is varied, starting from low to maximum?', 'single_choice', 'hard', 'Clause 5.3.3: the cavitation test is conducted at constant discharge and recommended speed while the suction pressure is varied from low to maximum. Data on discharge, suction and discharge pressure, and power are recorded at every suction pressure setting. The test determines the suction conditions of the pump.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The pump speed', false, 0),
      (v_question_id, 'The temperature of the test water', false, 1),
      (v_question_id, 'The suction pressure', true, 2),
      (v_question_id, 'The input shaft torque', false, 3);
  END IF;

  -- 33. Priming test static lift
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the priming test of a self-priming pump under PAES 115:2000 clause 5.4.2, the pump is mounted on a test set-up with a static lift between the eye of the impeller and the water level of at least:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the priming test of a self-priming pump under PAES 115:2000 clause 5.4.2, the pump is mounted on a test set-up with a static lift between the eye of the impeller and the water level of at least:', 'single_choice', 'medium', 'Clause 5.4.2: the static lift between the eye of the impeller and the water level shall be at least 3 m. No check or foot valves shall be installed in the suction piping, and the priming time is the time from starting the unit to a steady discharge gauge reading or full flow through the discharge nozzle.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 m', false, 0),
      (v_question_id, '5 m', false, 1),
      (v_question_id, '2 m', false, 2),
      (v_question_id, '3 m', true, 3);
  END IF;

  -- 34. Pressure tapping positions
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to Annex B of PAES 115:2000, the suction and discharge sides of the pump under test are connected to a straight pipe of a minimum length of how many times the bore diameter, and at what distance from each pump flange is the pressure tapping located?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to Annex B of PAES 115:2000, the suction and discharge sides of the pump under test are connected to a straight pipe of a minimum length of how many times the bore diameter, and at what distance from each pump flange is the pressure tapping located?', 'single_choice', 'hard', 'Annex B1: the suction and discharge sides are connected to a straight pipe with a length of at least 4 times the diameter of each bore, and one pressure tapping is provided at a distance of twice the diameter from each flange surface of the pump, at right angle to the plane of the bend or of the spiral curve of the pump.', NULL, NULL, 'draft', false, NULL, true, 'PAES 115:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Minimum straight pipe of 6 times the diameter, with the tapping at 3 times the diameter from each flange', false, 0),
      (v_question_id, 'Minimum straight pipe of 4 times the diameter, with the tapping at 2 times the diameter from each flange', true, 1),
      (v_question_id, 'Minimum straight pipe of 2 times the diameter, with the tapping at 4 times the diameter from each flange', false, 2),
      (v_question_id, 'Minimum straight pipe of 10 times the diameter, with the tapping at 5 times the diameter from each flange', false, 3);
  END IF;

  -- 35. Hand pump volumetric efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the PAES 154:2010 volumetric efficiency test of a hand pump, the piston displacement per stroke is Pd = pi x D^2 x h / 4, and the volumetric efficiency is the actual discharge per stroke divided by Pd, times 100. A bucket collects 8.2 L of water in 10 full strokes. The cylinder inside diameter is 76 mm and the maximum stroke length is 200 mm. What is the volumetric efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the PAES 154:2010 volumetric efficiency test of a hand pump, the piston displacement per stroke is Pd = pi x D^2 x h / 4, and the volumetric efficiency is the actual discharge per stroke divided by Pd, times 100. A bucket collects 8.2 L of water in 10 full strokes. The cylinder inside diameter is 76 mm and the maximum stroke length is 200 mm. What is the volumetric efficiency?', 'single_choice', 'hard', 'Given: actual discharge = 8.2 L in 10 strokes = 0.82 L per stroke; D = 0.076 m; h = 0.200 m. Pd = pi x (0.076)^2 x 0.200 / 4 = 0.000907 m3 = 0.907 L. Volumetric efficiency = (0.82 / 0.907) x 100 = 90.4%.', NULL, NULL, 'draft', false, NULL, true, 'PAES 154:2010')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90.4%', true, 0),
      (v_question_id, '9.04%', false, 1),
      (v_question_id, '22.6%', false, 2),
      (v_question_id, '110.6%', false, 3);
  END IF;

END $$;
