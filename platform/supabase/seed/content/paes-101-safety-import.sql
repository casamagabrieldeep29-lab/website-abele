-- PAES 101:2000 "Agricultural Machinery — Technical Means for Ensuring Safety —
-- General" quiz batch (25 questions, 1 topic). Every question, correct answer,
-- and distractor is drawn directly from the standard's actual clauses (read in
-- full from "ABELE TOP 1/PAES/PRODUCTION (100 S)/Technical Means for Ensuring
-- Safety.pdf", 2026-10-02) — no invented facts. This topic had zero published
-- questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes=true with paes_reference
-- set to 'PAES 101'.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Philippine National Standards on Technical Means for Ensuring Safety (POWER_ENERGY_MACHINERY) — 25 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Philippine National Standards on Technical Means for Ensuring Safety' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Philippine National Standards on Technical Means for Ensuring Safety';
  END IF;

  -- 1. Scope (clause 1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 101:2000, what is the primary scope of the standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 101:2000, what is the primary scope of the standard?', 'single_choice', 'easy', 'Clause 1 (Scope): the standard provides guidelines for the prevention of accidents arising from the use of tractors and machinery for agriculture, and specifies technical means of improving the safety of operators and others during normal operation, service, and maintenance.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Preventing accidents from the use of tractors and machinery for agriculture, and improving operator safety', true, 0),
      (v_question_id, 'Setting fuel efficiency standards for agricultural tractors', false, 1),
      (v_question_id, 'Specifying the minimum horsepower rating for farm machinery', false, 2),
      (v_question_id, 'Regulating the import and sale of used agricultural equipment', false, 3);
  END IF;

  -- 2. Principle (clause 3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 3, if operating/maintaining a machine per the manufacturer''s instructions is not possible, what shall be provided instead?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 3, if operating/maintaining a machine per the manufacturer''s instructions is not possible, what shall be provided instead?', 'single_choice', 'medium', 'Clause 3: if the design-based requirement cannot be met, the machine shall be equipped with special means for ensuring safety — guards or safe location of dangerous parts — with functional components shielded as far as the intended function allows, plus a warning of the hazard on the machine.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Special means for ensuring safety, such as guards or safe location of dangerous parts', true, 0),
      (v_question_id, 'A reduction in the machine''s rated operating speed', false, 1),
      (v_question_id, 'Mandatory insurance coverage for the equipment operator', false, 2),
      (v_question_id, 'An extended warranty from the manufacturer', false, 3);
  END IF;

  -- 3. Moving parts treated as dangerous (clause 4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 101:2000 clause 4, particular attention to danger is drawn to all of the following EXCEPT:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 101:2000 clause 4, particular attention to danger is drawn to all of the following EXCEPT:', 'single_choice', 'medium', 'Clause 4 lists shafts/pulleys/flywheels/gearing/cables/sprockets/belts/chains/clutches/couplings/fan blades, the run-on point of any belt/chain/cable, protruding keyways/keys/grease nipples, pinch/shear points, and ground wheels or tracks adjacent to the operator''s position — not the fuel tank cap.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The run-on point of any belt, chain, or cable', false, 0),
      (v_question_id, 'Keyways, keys, and grease nipples protruding from moving parts', false, 1),
      (v_question_id, 'The fuel tank filler cap', true, 2),
      (v_question_id, 'Ground wheels or tracks adjacent to the operator''s position', false, 3);
  END IF;

  -- 4. Guard types (clause 5)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 101:2000 classifies guards designed to prevent contact with moving parts into three types. Which of the following is NOT one of them?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 101:2000 classifies guards designed to prevent contact with moving parts into three types. Which of the following is NOT one of them?', 'single_choice', 'easy', 'Clause 5: the three guard types are shield or cover (5.1), casing (5.2), and enclosure (5.3).', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shield or cover', false, 0),
      (v_question_id, 'Casing', false, 1),
      (v_question_id, 'Barrier mesh', true, 2),
      (v_question_id, 'Enclosure', false, 3);
  END IF;

  -- 5. Casing definition (clause 5.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 5.2, which guard type is defined as a protective device that prevents contact with the dangerous part from ALL sides?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 5.2, which guard type is defined as a protective device that prevents contact with the dangerous part from ALL sides?', 'single_choice', 'medium', 'Clause 5.2: casing is a protective device designed and fitted so that, alone or with other parts of the machine, it prevents contact with the dangerous part from all sides — unlike a shield/cover (5.1), which only covers the side(s) it faces.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shield', false, 0),
      (v_question_id, 'Cover', false, 1),
      (v_question_id, 'Casing', true, 2),
      (v_question_id, 'Enclosure', false, 3);
  END IF;

  -- 6. Enclosure definition (clause 5.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 101:2000 clause 5.3 describes a guard that, by means of a rail, fence, or frame, ensures the necessary safety distance so a dangerous part cannot be reached inadvertently. This is called a/an:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 101:2000 clause 5.3 describes a guard that, by means of a rail, fence, or frame, ensures the necessary safety distance so a dangerous part cannot be reached inadvertently. This is called a/an:', 'single_choice', 'easy', 'Clause 5.3: this is the definition of an enclosure.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shield', false, 0),
      (v_question_id, 'Casing', false, 1),
      (v_question_id, 'Enclosure', true, 2),
      (v_question_id, 'Cover', false, 3);
  END IF;

  -- 7. Guard static load (clause 6)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 6, unless clearly inappropriate, guards shall withstand a perpendicular static load of how many newtons without cracking, tearing, or permanently deflecting?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 6, unless clearly inappropriate, guards shall withstand a perpendicular static load of how many newtons without cracking, tearing, or permanently deflecting?', 'single_choice', 'medium', 'Clause 6: guards shall withstand a perpendicular static load of 1,200 N — the same 1,200 N also applies where a guard may occasionally be used as a step.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '800 N', false, 0),
      (v_question_id, '1,000 N', false, 1),
      (v_question_id, '1,200 N', true, 2),
      (v_question_id, '1,500 N', false, 3);
  END IF;

  -- 8. Safety distance, upward reach (clause 7.1.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 101:2000 clause 7.1.1, what is the safety distance for upward reach for a person standing upright?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 101:2000 clause 7.1.1, what is the safety distance for upward reach for a person standing upright?', 'single_choice', 'medium', 'Clause 7.1.1: the safety distance for upward reach is 2,500 mm for persons standing upright.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,000 mm', false, 0),
      (v_question_id, '1,800 mm', false, 1),
      (v_question_id, '2,500 mm', true, 2),
      (v_question_id, '3,000 mm', false, 3);
  END IF;

  -- 9. Barrier height (clause 7.1.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 7.1.3, a barrier intended to guard against reaching over it is NOT acceptable if its height above the location a person can occupy is less than:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 7.1.3, a barrier intended to guard against reaching over it is NOT acceptable if its height above the location a person can occupy is less than:', 'single_choice', 'medium', 'Clause 7.1.3: barriers less than 1,000 mm above the location a person can occupy shall not be acceptable.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '500 mm', false, 0),
      (v_question_id, '1,000 mm', true, 1),
      (v_question_id, '1,500 mm', false, 2),
      (v_question_id, '2,000 mm', false, 3);
  END IF;

  -- 10. Round reach, elbow to finger tip (Table 2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 2 of PAES 101:2000 (Extent of reach), what minimum safety distance r is required for the elbow-to-finger-tip limb measurement?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 2 of PAES 101:2000 (Extent of reach), what minimum safety distance r is required for the elbow-to-finger-tip limb measurement?', 'single_choice', 'hard', 'Table 2 gives safety distance r by limb: finger base to finger tip r>120 mm, wrist to finger tip r>230 mm, elbow to finger tip r>550 mm, shoulder to finger tip r>850 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'r > 120 mm', false, 0),
      (v_question_id, 'r > 230 mm', false, 1),
      (v_question_id, 'r > 550 mm', true, 2),
      (v_question_id, 'r > 850 mm', false, 3);
  END IF;

  -- 11. Round reach, shoulder to finger tip (Table 2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 2 of PAES 101:2000, which limb-to-finger-tip measurement requires the largest safety distance, r > 850 mm?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 2 of PAES 101:2000, which limb-to-finger-tip measurement requires the largest safety distance, r > 850 mm?', 'single_choice', 'medium', 'Table 2: shoulder to finger tip requires r > 850 mm, the largest of the four listed (finger base 120, wrist 230, elbow 550, shoulder 850).', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Finger base to finger tip', false, 0),
      (v_question_id, 'Wrist to finger tip', false, 1),
      (v_question_id, 'Elbow to finger tip', false, 2),
      (v_question_id, 'Shoulder to finger tip', true, 3);
  END IF;

  -- 12. Pinching point, body (Table 4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 4 of PAES 101:2000 (Minimum separation distance for pinching points), what is the required minimum separation distance for the body?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 4 of PAES 101:2000 (Minimum separation distance for pinching points), what is the required minimum separation distance for the body?', 'single_choice', 'hard', 'Table 4 minimum separation distances: finger 25 mm, hand/wrist/fist 100 mm, arm 120 mm, foot 120 mm, leg 180 mm, body 500 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '120 mm', false, 0),
      (v_question_id, '180 mm', false, 1),
      (v_question_id, '350 mm', false, 2),
      (v_question_id, '500 mm', true, 3);
  END IF;

  -- 13. Pinching point, finger (Table 4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per Table 4 of PAES 101:2000, what is the minimum separation distance required to protect a finger from a pinching point?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per Table 4 of PAES 101:2000, what is the minimum separation distance required to protect a finger from a pinching point?', 'single_choice', 'medium', 'Table 4: the finger requires a minimum separation distance of 25 mm, the smallest of all limbs listed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15 mm', false, 0),
      (v_question_id, '25 mm', true, 1),
      (v_question_id, '50 mm', false, 2),
      (v_question_id, '100 mm', false, 3);
  END IF;

  -- 14. Warning notices (clause 8.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 8.2, a warning notice affixed to a machine shall be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 8.2, a warning notice affixed to a machine shall be:', 'single_choice', 'easy', 'Clause 8.2: durable warning notices shall be affixed where parts present danger; the notice shall be either pictorial or text in a language acceptable to the user, or as the national regulating authority requires.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Durable, and either pictorial or text in a language acceptable to the user', true, 0),
      (v_question_id, 'Written only in English regardless of the operator''s language', false, 1),
      (v_question_id, 'Optional if the operator has prior training', false, 2),
      (v_question_id, 'Removable once the operator is familiar with the machine', false, 3);
  END IF;

  -- 15. Foot-guard / toe-board dimensions (clause 10.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.2, a platform''s foot-guard (toe-board) shall extend not less than how many millimeters above the platform?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.2, a platform''s foot-guard (toe-board) shall extend not less than how many millimeters above the platform?', 'single_choice', 'hard', 'Clause 10.2(a): the foot-guard (toe-board) shall be fitted around the edge of the platform (or not more than 50 mm farther away) and shall extend not less than 75 mm above the platform.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '50 mm', false, 0),
      (v_question_id, '75 mm', true, 1),
      (v_question_id, '100 mm', false, 2),
      (v_question_id, '150 mm', false, 3);
  END IF;

  -- 16. Guard-rail height (clause 10.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.2, a platform guard-rail shall be not less than 1,000 mm and not more than how many millimeters above the platform?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.2, a platform guard-rail shall be not less than 1,000 mm and not more than how many millimeters above the platform?', 'single_choice', 'medium', 'Clause 10.2(b): the guard-rail shall be not less than 1,000 mm and not more than 1,100 mm above the platform, with an intermediate rail so the vertical distance between any two rails does not exceed 500 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1,050 mm', false, 0),
      (v_question_id, '1,100 mm', true, 1),
      (v_question_id, '1,200 mm', false, 2),
      (v_question_id, '1,500 mm', false, 3);
  END IF;

  -- 17. Foot-operated clutch (clause 10.4.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.4.3(a), to disengage a foot-operated clutch, the pedal should be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.4.3(a), to disengage a foot-operated clutch, the pedal should be:', 'single_choice', 'medium', 'Clause 10.4.3(a): the foot-operated clutch should be located convenient to the operator''s left foot; to disengage, the pedal should be pushed forward. For a combined traction-drive/PTO clutch, the PTO shall be disengaged on the second stage.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pushed forward', true, 0),
      (v_question_id, 'Pulled rearward', false, 1),
      (v_question_id, 'Pressed and held for 3 seconds', false, 2),
      (v_question_id, 'Released gradually while steering', false, 3);
  END IF;

  -- 18. Hand-operated clutch (clause 10.4.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.4.3(b), to disengage a hand-operated clutch, the control should be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.4.3(b), to disengage a hand-operated clutch, the control should be:', 'single_choice', 'medium', 'Clause 10.4.3(b): the hand-operated clutch should be located convenient to the operator; to disengage, the control should be moved rearward, and it should be operated only with the operator in the operator''s station.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Moved forward', false, 0),
      (v_question_id, 'Moved rearward', true, 1),
      (v_question_id, 'Rotated clockwise', false, 2),
      (v_question_id, 'Pushed downward', false, 3);
  END IF;

  -- 19. Stopping device color (clause 10.4.4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.4.4, the control for a power source''s stopping device shall be what color?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.4.4, the control for a power source''s stopping device shall be what color?', 'single_choice', 'easy', 'Clause 10.4.4: the stopping device control shall be red in color and preferably in contrast with the background and other controls; once in the "stop" position, the power source cannot be started unless the device is reset manually.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Yellow', false, 0),
      (v_question_id, 'Red', true, 1),
      (v_question_id, 'Green', false, 2),
      (v_question_id, 'Black', false, 3);
  END IF;

  -- 20. Drawbar hole diameter (clause 11.1.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 11.1.2, the diameter of the hole in a tractor''s drawbar should be approximately how many millimeters?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 11.1.2, the diameter of the hole in a tractor''s drawbar should be approximately how many millimeters?', 'single_choice', 'hard', 'Clause 11.1.2: the drawbar shall be situated in the longitudinal mid-plane of the tractor; the diameter of the hole in the drawbar should be 33 mm (tolerance -0/+0.5 mm), and the thickness of the drawbar shall be not more than 32 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 mm', false, 0),
      (v_question_id, '33 mm', true, 1),
      (v_question_id, '40 mm', false, 2),
      (v_question_id, '50 mm', false, 3);
  END IF;

  -- 21. Jack requirement, trailer mass threshold (clause 11.2.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 11.2.2, a jack capable of raising/lowering the drawbar is required for all trailers with an unladen mass (bare weight) exceeding how many kilograms?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 11.2.2, a jack capable of raising/lowering the drawbar is required for all trailers with an unladen mass (bare weight) exceeding how many kilograms?', 'single_choice', 'hard', 'Clause 11.2.2: the jack requirement applies to all trailers of unladen mass (bare weight) exceeding 500 kg, or any other machine where the unladen downward force through the drawbar at the hitch point exceeds 250 N (measured on horizontal ground with the hitch point at 400 mm height).', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '250 kg', false, 0),
      (v_question_id, '500 kg', true, 1),
      (v_question_id, '750 kg', false, 2),
      (v_question_id, '1,000 kg', false, 3);
  END IF;

  -- 22. PTO protection when not in use (clause 12.1.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 12.1.2, when the PTO cover or casing is not in position and the PTO is not in use, what additional protection shall be provided?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 12.1.2, when the PTO cover or casing is not in position and the PTO is not in use, what additional protection shall be provided?', 'single_choice', 'medium', 'Clause 12.1.2: an additional non-rotating casing shall be provided, encasing the PTO completely and fixed to the tractor or machine body, when the regular cover or casing is not in position and the PTO is not in use.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An additional non-rotating casing encasing the PTO completely', true, 0),
      (v_question_id, 'A warning light near the operator''s seat only', false, 1),
      (v_question_id, 'A padlock on the PTO shaft', false, 2),
      (v_question_id, 'No additional protection is required', false, 3);
  END IF;

  -- 23. Exhaust pipe placement (clause 13.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 13.1, the outlet of a machine''s exhaust pipe shall be located and directed so that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 13.1, the outlet of a machine''s exhaust pipe shall be located and directed so that:', 'single_choice', 'easy', 'Clause 13.1: the exhaust outlet shall be located/directed so the driver or any operator obliged to stand on the machine is not normally exposed to harmful concentrations of noxious gases or fumes — for example, by locating it over or to the side of the operator''s head level or the cab''s air intake.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The driver/operator is not normally exposed to harmful concentrations of noxious gases or fumes', true, 0),
      (v_question_id, 'Exhaust noise is minimized for nearby residents', false, 1),
      (v_question_id, 'Fuel economy is maximized', false, 2),
      (v_question_id, 'The exhaust is aimed directly at the ground beneath the machine', false, 3);
  END IF;

  -- 24. Battery location (clause 13.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 13.3, the location of a machine''s batteries shall be such that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 13.3, the location of a machine''s batteries shall be such that:', 'single_choice', 'easy', 'Clause 13.3: the location of the batteries shall be such that hazards to the operator due to fumes and electrolyte are minimized.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hazards to the operator from fumes and electrolyte are minimized', true, 0),
      (v_question_id, 'Battery weight is evenly distributed for traction', false, 1),
      (v_question_id, 'Battery terminals face forward for easy jump-starting', false, 2),
      (v_question_id, 'Charging time is reduced', false, 3);
  END IF;

  -- 25. Hitch hook standard reference (clause 11.1.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 11.1.1, if a towing machine is equipped with a hitch hook, what must the towed machine have, in accordance with ISO 5692?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 11.1.1, if a towing machine is equipped with a hitch hook, what must the towed machine have, in accordance with ISO 5692?', 'single_choice', 'hard', 'Clause 11.1.1: if the towing machine is equipped with a hitch hook (per ISO 6489-1), the towed machine shall, in such case, have a drawbar eye according to ISO 5692.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A drawbar eye', true, 0),
      (v_question_id, 'A second hitch hook', false, 1),
      (v_question_id, 'A ball-type coupler', false, 2),
      (v_question_id, 'A fifth-wheel plate', false, 3);
  END IF;

END $$;
