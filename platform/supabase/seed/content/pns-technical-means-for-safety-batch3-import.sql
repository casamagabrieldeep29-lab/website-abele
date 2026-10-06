-- PAES 101:2000 "Agricultural Machinery - Technical Means for Ensuring Safety -
-- General" additional quiz batch (33 questions, 1 topic). Every question,
-- correct answer and distractor is drawn from the clauses, tables and Foreword
-- of the standard text (read in full, 2026-10-05) - no invented facts. Adds new
-- angles on clauses not yet covered by the earlier 25-question draft import.
-- Computation-style items restate every table value they need in the question.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes=true with paes_reference
-- set to 'PAES 101'.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Philippine National Standards on Technical Means for Ensuring Safety (POWER_ENERGY_MACHINERY) - 33 question(s)
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

  -- 1. Predecessor standard
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 101:2000 (Agricultural Machinery - Technical Means for Ensuring Safety - General) is a revision of which earlier Philippine National Standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 101:2000 (Agricultural Machinery - Technical Means for Ensuring Safety - General) is a revision of which earlier Philippine National Standard?', 'single_choice', 'easy', 'The Foreword states that PAES 101:2000 is a revision of PNS 606:1991, "General Code of Safety for Agricultural Machinery". PNS 01:Part 4:1998 is the drafting-rules standard followed in the revision, while ISO 4252-1:1989 and ASAE S318.8:1985 were documents considered in preparing it.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ASAE S318.8:1985 - Safety for Agricultural Equipment', false, 0),
      (v_question_id, 'PNS 606:1991 - General Code of Safety for Agricultural Machinery', true, 1),
      (v_question_id, 'ISO 4252-1:1989 - Technical Means for Ensuring Safety - General', false, 2),
      (v_question_id, 'PNS 01:Part 4:1998 - Rules for the Structure and Drafting of Philippine National Standards', false, 3);
  END IF;

  -- 2. Initiating agency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which body initiated the revision that produced PAES 101:2000?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which body initiated the revision that produced PAES 101:2000?', 'single_choice', 'easy', 'The Foreword states that the revision was initiated by the Agricultural Machinery Testing and Evaluation Center (AMTEC). The project was funded by the Bureau of Agricultural Research (BAR), the standard was presented to the Philippine Society of Agricultural Engineers (PSAE), and the public hearing was organized by the National Agriculture and Fisheries Council (NAFC).', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Bureau of Agricultural Research (BAR)', false, 0),
      (v_question_id, 'National Agriculture and Fisheries Council (NAFC)', false, 1),
      (v_question_id, 'Agricultural Machinery Testing and Evaluation Center (AMTEC)', true, 2),
      (v_question_id, 'Philippine Society of Agricultural Engineers (PSAE)', false, 3);
  END IF;

  -- 3. Drawbar requirements source (Foreword)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Foreword of PAES 101:2000 states that its safety requirements on the drawbar were lifted from which international standard?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Foreword of PAES 101:2000 states that its safety requirements on the drawbar were lifted from which international standard?', 'single_choice', 'hard', 'Per the Foreword, the drawbar requirements were lifted from ISO 500:1979 (Agricultural tractors - Power-take-off and drawbar - Specifications). The clutch location and operation requirements were lifted from ISO 3789-2:1982, while ISO 5692 and ISO 6489-1 are the normative references for hitch rings and hitch hooks.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ISO 5692:1979', false, 0),
      (v_question_id, 'ISO 6489-1:1991', false, 1),
      (v_question_id, 'ISO 3789-2:1982', false, 2),
      (v_question_id, 'ISO 500:1979', true, 3);
  END IF;

  -- 4. Safety primarily by design (clause 3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 3, the safety requirements for operating and maintaining agricultural machinery shall primarily be met by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 3, the safety requirements for operating and maintaining agricultural machinery shall primarily be met by:', 'single_choice', 'medium', 'Clause 3: the requirements shall primarily be met by the design of the machine. Only when this is not possible shall the machine be equipped with special means such as guards or a safe location of dangerous parts, with a warning of the hazard indicated on the machine.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Guards fitted after the machine is built', false, 0),
      (v_question_id, 'The design of the machine', true, 1),
      (v_question_id, 'Operator training on the manufacturer''s instructions', false, 2),
      (v_question_id, 'Warning notices affixed to the machine', false, 3);
  END IF;

  -- 5. Permanent attachment of guards (clause 6)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 6, guards shall normally be permanently attached to the machine. "Permanent attachment" includes the use of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 6, guards shall normally be permanently attached to the machine. "Permanent attachment" includes the use of:', 'single_choice', 'medium', 'Clause 6: "Permanent attachment" includes the use of threaded fasteners, split pins, or other means that can be dismantled with common hand tools.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Welding or riveting that cannot be dismantled', false, 0),
      (v_question_id, 'Adhesives or sealants only', false, 1),
      (v_question_id, 'Threaded fasteners, split pins, or other means that can be dismantled with common hand tools', true, 2),
      (v_question_id, 'Fasteners that can be removed by hand without any tools', false, 3);
  END IF;

  -- 6. Guards that can be opened (clause 6)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A guard on a machine is designed to be easily opened for servicing. Per PAES 101:2000 clause 6, how should it be arranged?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A guard on a machine is designed to be easily opened for servicing. Per PAES 101:2000 clause 6, how should it be arranged?', 'single_choice', 'medium', 'Clause 6: guards that may be easily opened should remain attached to the machine in some way, for example by a hinge, slide, linkage or other suitable means, and should be provided with a convenient means to keep them closed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It should be fixed so that only the manufacturer can open it', false, 0),
      (v_question_id, 'It should be fully detachable and stored away from the machine', false, 1),
      (v_question_id, 'It should be held closed by friction only, without any closing device', false, 2),
      (v_question_id, 'It should remain attached to the machine, e.g. by a hinge, slide or linkage, with a convenient means to keep it closed', true, 3);
  END IF;

  -- 7. Interlocked guards (clause 6)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 6, in some circumstances a guard that can be opened must be designed so that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 6, in some circumstances a guard that can be opened must be designed so that:', 'single_choice', 'hard', 'Clause 6: the movement of the dangerous parts is automatically stopped when the guard is opened, or the design prevents the guard from being opened until all movement of the dangerous parts has ceased. A suitable warning notice shall be fitted to all such guards and to any opening in them without such securing devices.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The movement of dangerous parts is automatically stopped when the guard is opened, or the guard cannot be opened until movement has ceased', true, 0),
      (v_question_id, 'The guard opens automatically when the machine is switched off', false, 1),
      (v_question_id, 'The machine speed is reduced by half when the guard is opened', false, 2),
      (v_question_id, 'The guard can be opened only with a special key held by the operator', false, 3);
  END IF;

  -- 8. Factors for reach over barriers (clause 7.1.3)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 7.1.3, the safety distance for sideward or downward reach over barriers of 1,000 mm or greater height depends on all of the following EXCEPT:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 7.1.3, the safety distance for sideward or downward reach over barriers of 1,000 mm or greater height depends on all of the following EXCEPT:', 'single_choice', 'medium', 'Clause 7.1.3 lists three factors: (a) the distance from ground level to the dangerous part, (b) the height of the guard, and (c) the horizontal distance between the dangerous part and the guard. The rated power of the prime mover is not a factor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The distance from the ground level to the dangerous part', false, 0),
      (v_question_id, 'The rated power of the machine''s prime mover', true, 1),
      (v_question_id, 'The horizontal distance between the dangerous part and the guard', false, 2),
      (v_question_id, 'The height of the guard', false, 3);
  END IF;

  -- 9. Polygonal openings (clause 7.1.6.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 7.1.6.1, a polygonal guard opening is treated like a round opening when:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 7.1.6.1, a polygonal guard opening is treated like a round opening when:', 'single_choice', 'hard', 'Clause 7.1.6.1: polygonal openings where the diameter of the largest inscribed circle is not less than the distance between the two apexes that are furthest apart meet the same requirements as round openings (the inscribed circle diameter is taken as the opening size). All other polygonal openings are regarded as slots.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The polygon has more than six sides', false, 0),
      (v_question_id, 'The area of the polygon is less than that of a 20 mm circle', false, 1),
      (v_question_id, 'The diameter of the largest inscribed circle is not less than the distance between the two furthest-apart apexes', true, 2),
      (v_question_id, 'The polygon has equal sides regardless of its shape', false, 3);
  END IF;

  -- 10. Wide apertures (Table 3a note)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the note to Table 3a of PAES 101:2000, when the width of a rectangular opening or slot in a guard is greater than 135 mm, which safety distances apply?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the note to Table 3a of PAES 101:2000, when the width of a rectangular opening or slot in a guard is greater than 135 mm, which safety distances apply?', 'single_choice', 'hard', 'Table 3a note 1: when the width is greater than 135 mm, part of the body can also pass through the aperture, so the safety distances specified in clause 7.2 (pinching points) shall be observed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The safety distances of clause 7.2 shall be observed because part of the body can pass through', true, 0),
      (v_question_id, 'The finger reach distance of b > 120 mm applies', false, 1),
      (v_question_id, 'The arm reach distance of b > 850 mm still applies', false, 2),
      (v_question_id, 'No safety distance is required', false, 3);
  END IF;

  -- 11. Revolving hitch warning (clause 8.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 8.1, operating manuals shall include a warning that a revolving hitch or revolving clevis shall NOT be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 8.1, operating manuals shall include a warning that a revolving hitch or revolving clevis shall NOT be:', 'single_choice', 'medium', 'Clause 8.1: operating manuals shall include a warning that a revolving hitch or a revolving clevis shall not be connected with a mating unit which also revolves on a towed machine or trailer.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Used with a drawbar eye', false, 0),
      (v_question_id, 'Lubricated while the machine is running', false, 1),
      (v_question_id, 'Used on machines with a hydraulic lift', false, 2),
      (v_question_id, 'Connected with a mating unit which also revolves on a towed machine or trailer', true, 3);
  END IF;

  -- 12. Warning notices for lowering parts (clause 8.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Besides parts that present danger to the operator, per PAES 101:2000 clause 8.2 durable warning notices shall also be affixed to the machine in circumstances where:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Besides parts that present danger to the operator, per PAES 101:2000 clause 8.2 durable warning notices shall also be affixed to the machine in circumstances where:', 'single_choice', 'easy', 'Clause 8.2: durable warning notices shall be affixed where parts present danger to the operator, and also in circumstances where the inadvertent lowering of parts of equipment can cause danger.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The machine is stored outdoors', false, 0),
      (v_question_id, 'The inadvertent lowering of parts of equipment can cause danger', true, 1),
      (v_question_id, 'The machine is operated at night', false, 2),
      (v_question_id, 'The machine is transported on public roads', false, 3);
  END IF;

  -- 13. Hydraulically raised components (clause 9)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 9, hydraulically raised components that must be held in a raised position for servicing or adjustment shall be provided with:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 9, hydraulically raised components that must be held in a raised position for servicing or adjustment shall be provided with:', 'single_choice', 'medium', 'Clause 9 (Working stability): such components shall be provided with an independent and reliable means of retaining them in the required position. Machines and trailers that may tilt because of a shifting center of gravity (e.g. when emptying or filling) must also have means of preventing that danger.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An independent and reliable means of retaining them in the required position', true, 0),
      (v_question_id, 'The hydraulic system pressure alone to hold them up', false, 1),
      (v_question_id, 'A spring-loaded return valve', false, 2),
      (v_question_id, 'A warning notice only', false, 3);
  END IF;

  -- 14. Steps (clause 10.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.1, steps provided for mounting and dismounting a machine shall have:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.1, steps provided for mounting and dismounting a machine shall have:', 'single_choice', 'medium', 'Clause 10.1: steps shall have a non-slip surface and a vertical retainer at both sides. Handholds and steps may be parts of the machine if suitably designed and placed, and where moving parts form trapping areas with the steps, a suitable means of protection shall be provided.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A non-slip surface and a vertical retainer at both sides', true, 0),
      (v_question_id, 'A smooth painted surface and an open front', false, 1),
      (v_question_id, 'A rubber cover on the first step only', false, 2),
      (v_question_id, 'A retainer on one side only', false, 3);
  END IF;

  -- 15. Exceptions to platform guards (clause 10.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.2, a foot-guard or fixed guard-rail on an operator''s platform is NOT required when:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.2, a foot-guard or fixed guard-rail on an operator''s platform is NOT required when:', 'single_choice', 'hard', 'Clause 10.2: it is not required (a) when the machine itself affords protection at least equal to that which the foot-guard and guard-rail would provide, or (b) when the operation permits access of persons or movement of material, in which case a rail or chain shall be provided across the access while the machine is operating.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The operator is experienced', false, 0),
      (v_question_id, 'The machine is operated only in daytime', false, 1),
      (v_question_id, 'The platform has a non-slip surface', false, 2),
      (v_question_id, 'The machine itself affords protection at least equal to that of the foot-guard and guard-rail', true, 3);
  END IF;

  -- 16. Toe-board position (clause 10.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.2(a), the foot-guard (toe-board) of an operator''s platform shall be fitted around the edge of the platform or not more than how far away from it?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.2(a), the foot-guard (toe-board) of an operator''s platform shall be fitted around the edge of the platform or not more than how far away from it?', 'single_choice', 'hard', 'Clause 10.2(a): the foot-guard shall be fitted on all sides, around the edge of the platform or not more than 50 mm farther away, and extend not less than 75 mm above the platform.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 mm', false, 0),
      (v_question_id, '75 mm', false, 1),
      (v_question_id, '50 mm', true, 2),
      (v_question_id, '100 mm', false, 3);
  END IF;

  -- 17. Steering mechanism (clause 10.4.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.4.1, the steering mechanism shall be designed so as to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.4.1, the steering mechanism shall be designed so as to:', 'single_choice', 'medium', 'Clause 10.4.1: the steering mechanism shall reduce the force of any sudden movement of the steering wheel or steering lever(s) due to reaction from the steered wheel(s).', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Limit the turning angle to 45 degrees', false, 0),
      (v_question_id, 'Increase the steering effort at high speed', false, 1),
      (v_question_id, 'Lock automatically when the engine is stopped', false, 2),
      (v_question_id, 'Reduce the force of any sudden movement of the steering wheel or levers due to reaction from the steered wheels', true, 3);
  END IF;

  -- 18. Stopping device on unmanned machines (clause 10.4.4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.4.4, on an unmanned machine the stopping device for the power source shall be readily accessible:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.4.4, on an unmanned machine the stopping device for the power source shall be readily accessible:', 'single_choice', 'medium', 'Clause 10.4.4: the device shall be readily accessible to the operator in the normal operating position on manned machines, and on or near the power source or near the operating control position on unmanned machines.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At the end of the discharge chute', false, 0),
      (v_question_id, 'On or near the power source or near the operating control position', true, 1),
      (v_question_id, 'Only through a remote radio controller', false, 2),
      (v_question_id, 'At the operator''s seat of the towing tractor', false, 3);
  END IF;

  -- 19. Differential lock (clause 10.4.7)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 10.4.7, a manually operated differential lock shall be designed and fitted so that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 10.4.7, a manually operated differential lock shall be designed and fitted so that:', 'single_choice', 'medium', 'Clause 10.4.7: there is a clear indication to the operator that the lock is engaged, and the design minimizes the possibility of inadvertent actuation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It can be engaged only while the machine is moving at full speed', false, 0),
      (v_question_id, 'It is operated only by a tool kept in the tool box', false, 1),
      (v_question_id, 'There is a clear indication to the operator that the lock is engaged, and inadvertent actuation is minimized', true, 2),
      (v_question_id, 'It engages automatically whenever the machine turns', false, 3);
  END IF;

  -- 20. Stand for mechanically picked-up drawbar (clause 11.2.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 11.2.2, a machine or trailer with a drawbar designed to be picked up mechanically by the towing vehicle must still be fitted with a stand capable of securely supporting the drawbar with the hitch point at what height above ground level?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 11.2.2, a machine or trailer with a drawbar designed to be picked up mechanically by the towing vehicle must still be fitted with a stand capable of securely supporting the drawbar with the hitch point at what height above ground level?', 'single_choice', 'hard', 'Clause 11.2.2: the jack requirement does not apply to such a machine or trailer, but a stand capable of securely supporting the drawbar with the hitch point 150 mm above the ground level shall be fitted.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '150 mm', true, 0),
      (v_question_id, '250 mm', false, 1),
      (v_question_id, '400 mm', false, 2),
      (v_question_id, '500 mm', false, 3);
  END IF;

  -- 21. PTO in use (clause 12.1.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 12.1.1, when the PTO is in use, what protection shall be fitted?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 12.1.1, when the PTO is in use, what protection shall be fitted?', 'single_choice', 'easy', 'Clause 12.1.1: when in use, a cover or, if necessary, a casing that protects the sides of the PTO shall be fitted.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'No guard, to allow free rotation', false, 0),
      (v_question_id, 'A warning light on the instrument panel', false, 1),
      (v_question_id, 'A rope barrier around the tractor', false, 2),
      (v_question_id, 'A cover or, if necessary, a casing that protects the sides of the PTO', true, 3);
  END IF;

  -- 22. Power intake connection (clause 12.2.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 12.2.1, the casing fitted to the power intake connection (PIC) shall:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 12.2.1, the casing fitted to the power intake connection (PIC) shall:', 'single_choice', 'medium', 'Clause 12.2.1: a casing which completely encloses the PIC and overlaps the casing fitted to the PTO drive-shaft shall be fitted, so that no part of the shaft (or couplings, clutches, etc.) is exposed at any time.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Be removable without tools at any time', false, 0),
      (v_question_id, 'Cover only the upper half of the PIC', false, 1),
      (v_question_id, 'Completely enclose the PIC and overlap the casing fitted to the PTO drive-shaft', true, 2),
      (v_question_id, 'Be separated from the PTO drive-shaft casing by a visible gap', false, 3);
  END IF;

  -- 23. PTO drive-shaft guard (clause 12.3.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 12.3.2, the guard protecting a PTO drive-shaft shall be firmly mounted, meaning it shall be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 12.3.2, the guard protecting a PTO drive-shaft shall be firmly mounted, meaning it shall be:', 'single_choice', 'medium', 'Clause 12.3.2: the guard shall be firmly mounted, i.e. detachable only by means of tools; it may be permanently fitted to the shaft. Clause 12.3.1 requires the casing to protect the shaft throughout its length.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Replaced by a warning label when the shaft is idle', false, 0),
      (v_question_id, 'Detachable only by means of tools', true, 1),
      (v_question_id, 'Detachable by hand for quick servicing', false, 2),
      (v_question_id, 'Fitted over the driven end only', false, 3);
  END IF;

  -- 24. Slot width 12 mm (Table 3a)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A guard has a rectangular slot 12 mm wide. Using Table 3a of PAES 101:2000 (finger tip: 4 < a < 8 mm, b > 15 mm; finger: 8 < a < 20 mm, b > 120 mm; hand: 20 < a < 30 mm, b > 200 mm; arm: 30 < a < 135 mm, b > 850 mm), what is the minimum safety distance b from the slot to the danger source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A guard has a rectangular slot 12 mm wide. Using Table 3a of PAES 101:2000 (finger tip: 4 < a < 8 mm, b > 15 mm; finger: 8 < a < 20 mm, b > 120 mm; hand: 20 < a < 30 mm, b > 200 mm; arm: 30 < a < 135 mm, b > 850 mm), what is the minimum safety distance b from the slot to the danger source?', 'single_choice', 'medium', 'Given: slot width a = 12 mm. 12 mm falls in the range 8 < a < 20 mm, which corresponds to finger access, so the safety distance is b > 120 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'b > 120 mm', true, 0),
      (v_question_id, 'b > 200 mm', false, 1),
      (v_question_id, 'b > 15 mm', false, 2),
      (v_question_id, 'b > 850 mm', false, 3);
  END IF;

  -- 25. Slot width 6 mm (Table 3a)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A guard has a rectangular slot 6 mm wide. Using Table 3a of PAES 101:2000 (finger tip: 4 < a < 8 mm, b > 15 mm; finger: 8 < a < 20 mm, b > 120 mm; hand: 20 < a < 30 mm, b > 200 mm; arm: 30 < a < 135 mm, b > 850 mm), what is the minimum safety distance b from the slot to the danger source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A guard has a rectangular slot 6 mm wide. Using Table 3a of PAES 101:2000 (finger tip: 4 < a < 8 mm, b > 15 mm; finger: 8 < a < 20 mm, b > 120 mm; hand: 20 < a < 30 mm, b > 200 mm; arm: 30 < a < 135 mm, b > 850 mm), what is the minimum safety distance b from the slot to the danger source?', 'single_choice', 'easy', 'Given: slot width a = 6 mm. 6 mm falls in the range 4 < a < 8 mm, which corresponds to finger-tip access, so the safety distance is b > 15 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'b > 15 mm', true, 0),
      (v_question_id, 'b > 850 mm', false, 1),
      (v_question_id, 'b > 120 mm', false, 2),
      (v_question_id, 'b > 200 mm', false, 3);
  END IF;

  -- 26. Slot width 100 mm (Table 3a)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A guard has a rectangular slot 100 mm wide. Using Table 3a of PAES 101:2000 (finger: 8 < a < 20 mm, b > 120 mm; hand: 20 < a < 30 mm, b > 200 mm; arm: 30 < a < 135 mm, b > 850 mm), what is the minimum safety distance b from the slot to the danger source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A guard has a rectangular slot 100 mm wide. Using Table 3a of PAES 101:2000 (finger: 8 < a < 20 mm, b > 120 mm; hand: 20 < a < 30 mm, b > 200 mm; arm: 30 < a < 135 mm, b > 850 mm), what is the minimum safety distance b from the slot to the danger source?', 'single_choice', 'medium', 'Given: slot width a = 100 mm. 100 mm falls in the range 30 < a < 135 mm, which corresponds to arm access (a is not greater than 135 mm, so the body cannot pass), so the safety distance is b > 850 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'b > 500 mm', false, 0),
      (v_question_id, 'b > 850 mm', true, 1),
      (v_question_id, 'b > 200 mm', false, 2),
      (v_question_id, 'b > 120 mm', false, 3);
  END IF;

  -- 27. Mesh opening 35 mm (Table 3b)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A guard is made of welded mesh with openings 35 mm wide. Using Table 3b of PAES 101:2000 (finger tip: 4 < a < 8 mm, b > 15 mm; finger: 8 < a < 25 mm, b > 120 mm; hand: 20 < a < 40 mm, b > 200 mm; arm: 40 < a < 250 mm, b > 850 mm), what is the minimum distance b from the mesh to the danger source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A guard is made of welded mesh with openings 35 mm wide. Using Table 3b of PAES 101:2000 (finger tip: 4 < a < 8 mm, b > 15 mm; finger: 8 < a < 25 mm, b > 120 mm; hand: 20 < a < 40 mm, b > 200 mm; arm: 40 < a < 250 mm, b > 850 mm), what is the minimum distance b from the mesh to the danger source?', 'single_choice', 'hard', 'Given: mesh opening a = 35 mm. 35 mm lies outside the finger range (8 to 25 mm) and within 20 < a < 40 mm, which corresponds to hand access, so the safety distance is b > 200 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'b > 850 mm', false, 0),
      (v_question_id, 'b > 15 mm', false, 1),
      (v_question_id, 'b > 120 mm', false, 2),
      (v_question_id, 'b > 200 mm', true, 3);
  END IF;

  -- 28. Pinching gap of 110 mm (Table 4)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pinching point on a machine has a clear gap of 110 mm. Using Table 4 of PAES 101:2000 (minimum separation distance: finger 25 mm; hand, wrist or fist 100 mm; arm 120 mm; foot 120 mm; leg 180 mm; body 500 mm), for which of the following body parts does the gap meet the minimum separation distance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pinching point on a machine has a clear gap of 110 mm. Using Table 4 of PAES 101:2000 (minimum separation distance: finger 25 mm; hand, wrist or fist 100 mm; arm 120 mm; foot 120 mm; leg 180 mm; body 500 mm), for which of the following body parts does the gap meet the minimum separation distance?', 'single_choice', 'medium', 'Given: gap = 110 mm. The gap is at least 100 mm, so it satisfies the finger (25 mm) and the hand, wrist or fist (100 mm). It is less than 120 mm (arm, foot), 180 mm (leg) and 500 mm (body), so those parts could be pinched. Answer: the fist.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Body', false, 0),
      (v_question_id, 'Arm', false, 1),
      (v_question_id, 'Fist', true, 2),
      (v_question_id, 'Leg', false, 3);
  END IF;

  -- 29. Intermediate guard-rail (clause 10.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A platform guard-rail is installed 1,100 mm above the platform, with a single intermediate rail. Per PAES 101:2000 clause 10.2(b), the vertical distance between any two rails shall not exceed 500 mm. What is the lowest height above the platform at which the intermediate rail may be placed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A platform guard-rail is installed 1,100 mm above the platform, with a single intermediate rail. Per PAES 101:2000 clause 10.2(b), the vertical distance between any two rails shall not exceed 500 mm. What is the lowest height above the platform at which the intermediate rail may be placed?', 'single_choice', 'medium', 'Given: top rail at 1,100 mm; maximum vertical distance between rails = 500 mm. Lowest intermediate rail height = 1,100 - 500 = 600 mm above the platform.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '550 mm', false, 0),
      (v_question_id, '600 mm', true, 1),
      (v_question_id, '700 mm', false, 2),
      (v_question_id, '500 mm', false, 3);
  END IF;

  -- 30. Drawbar hole tolerance (clause 11.1.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 101:2000 clause 11.1.2, the hole in a tractor drawbar is specified as 33 mm with a tolerance of +0.5 mm and -0 mm. Which range of hole diameters is acceptable?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 101:2000 clause 11.1.2, the hole in a tractor drawbar is specified as 33 mm with a tolerance of +0.5 mm and -0 mm. Which range of hole diameters is acceptable?', 'single_choice', 'hard', 'Given: nominal 33 mm, +0.5 mm upper tolerance, -0 mm lower tolerance. Minimum = 33 - 0 = 33.0 mm; maximum = 33 + 0.5 = 33.5 mm. Acceptable range: 33.0 mm to 33.5 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '33.0 mm to 34.0 mm', false, 0),
      (v_question_id, '32.5 mm to 33.5 mm', false, 1),
      (v_question_id, '32.5 mm to 33.0 mm', false, 2),
      (v_question_id, '33.0 mm to 33.5 mm', true, 3);
  END IF;

  -- 31. Jack requirement by hitch force (clause 11.2.2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A towed machine that is not a trailer is unladen, and the downward force acting through its drawbar at the hitch point measures 300 N, with the machine stationary on horizontal ground and the hitch point 400 mm above the ground. Its drawbar is not designed to be picked up mechanically. Per PAES 101:2000 clause 11.2.2, is a jack for raising and lowering the drawbar required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A towed machine that is not a trailer is unladen, and the downward force acting through its drawbar at the hitch point measures 300 N, with the machine stationary on horizontal ground and the hitch point 400 mm above the ground. Its drawbar is not designed to be picked up mechanically. Per PAES 101:2000 clause 11.2.2, is a jack for raising and lowering the drawbar required?', 'single_choice', 'medium', 'Given: unladen downward force at the hitch point = 300 N, measured on horizontal ground with the hitch point at 400 mm height. Clause 11.2.2 requires a jack on any other machine when this force exceeds 250 N. Since 300 N > 250 N, a jack is required (the 500 kg unladen mass criterion applies to trailers).', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Yes, because 300 N exceeds 250 N', true, 0),
      (v_question_id, 'Yes, but only if the machine mass also exceeds 500 kg', false, 1),
      (v_question_id, 'No, because 300 N is below 400 N', false, 2),
      (v_question_id, 'No, because the 500 kg unladen mass criterion applies to every machine', false, 3);
  END IF;

  -- 32. Round reach of 600 mm (Table 2)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dangerous component that is not independently guarded lies 600 mm around the edge of a barrier. Using Table 2 of PAES 101:2000 (finger base to finger tip r > 120 mm; wrist to finger tip r > 230 mm; elbow to finger tip r > 550 mm; shoulder to finger tip r > 850 mm), what is the largest limb reach for which this distance is adequate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A dangerous component that is not independently guarded lies 600 mm around the edge of a barrier. Using Table 2 of PAES 101:2000 (finger base to finger tip r > 120 mm; wrist to finger tip r > 230 mm; elbow to finger tip r > 550 mm; shoulder to finger tip r > 850 mm), what is the largest limb reach for which this distance is adequate?', 'single_choice', 'medium', 'Given: distance r = 600 mm. It exceeds 120 mm, 230 mm and 550 mm, so it is adequate for finger base, wrist and elbow reach, but it is less than 850 mm, so it is not adequate for shoulder reach. The largest limb reach covered is the elbow to finger tip.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Wrist to finger tip', false, 0),
      (v_question_id, 'Finger base to finger tip', false, 1),
      (v_question_id, 'Elbow to finger tip', true, 2),
      (v_question_id, 'Shoulder to finger tip', false, 3);
  END IF;

  -- 33. Component 2,300 mm overhead (clause 7.1.1)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An unguarded dangerous part is located 2,300 mm above the location where a person stands upright to operate the machine. Per PAES 101:2000 clause 7.1.1, which statement is correct?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An unguarded dangerous part is located 2,300 mm above the location where a person stands upright to operate the machine. Per PAES 101:2000 clause 7.1.1, which statement is correct?', 'single_choice', 'easy', 'Given: part height = 2,300 mm above the standing location. The upward reach safety distance for persons standing upright is 2,500 mm. Since 2,300 mm < 2,500 mm, the part is within reach and must be guarded or relocated.', NULL, NULL, 'draft', false, NULL, true, 'PAES 101')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The part is out of reach, since 2,300 mm exceeds the 1,800 mm upward-reach safety distance', false, 0),
      (v_question_id, 'The part is within reach, since 2,300 mm is less than the 2,500 mm safety distance for upward reach', true, 1),
      (v_question_id, 'The part is within reach only if the person stands on a box', false, 2),
      (v_question_id, 'The part is out of reach, since 2,300 mm is greater than 2,000 mm', false, 3);
  END IF;

END $$;
