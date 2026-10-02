-- Coffee processing machinery standards (coffee pulper, huller, roaster, grinder)
-- quiz batch (31 questions, 1 topic). Every question, correct answer, and
-- distractor is drawn directly from the standards' actual clauses and
-- performance tables (read in full, 2026-10-02) — no invented facts. No
-- facility-level layout/sizing standard was available, so this batch covers the
-- equipment specifications of a coffee processing facility only.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored), and is_paes=true with paes_reference
-- set to the relevant standard number.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Design and Specifications of Coffee Processing Facility (STRUCTURES_ENVIRONMENT) — 31 question(s)
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
    RAISE EXCEPTION 'Topic not found: Design and Specifications of Coffee Processing Facility';
  END IF;

  -- 1. Pulper max shaft speed, mechanized
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), what is the maximum speed for the shaft of a mechanized coffee pulper?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), what is the maximum speed for the shaft of a mechanized coffee pulper?', 'single_choice', 'easy', 'Clause 5.8: the maximum speed for the shaft of the mechanized coffee pulper shall be 120 rpm. (The manual pulper limit in clause 5.9 is 60 rpm.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60 rpm', false, 0),
      (v_question_id, '90 rpm', false, 1),
      (v_question_id, '120 rpm', true, 2),
      (v_question_id, '150 rpm', false, 3);
  END IF;

  -- 2. Pulper max shaft speed, manual
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), what is the maximum speed for the shaft of a manually operated coffee pulper?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), what is the maximum speed for the shaft of a manually operated coffee pulper?', 'single_choice', 'easy', 'Clause 5.9: the maximum speed for the shaft of the manual coffee pulper shall be 60 rpm. (The mechanized pulper limit in clause 5.8 is 120 rpm.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 rpm', false, 0),
      (v_question_id, '60 rpm', true, 1),
      (v_question_id, '90 rpm', false, 2),
      (v_question_id, '120 rpm', false, 3);
  END IF;

  -- 3. Pulping recovery min
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria (Table 1) of PAES 252:2011 (Coffee Pulper), what is the minimum pulping recovery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria (Table 1) of PAES 252:2011 (Coffee Pulper), what is the minimum pulping recovery?', 'single_choice', 'medium', 'Table 1 of clause 6.2: pulping recovery, minimum, is 93.5 percent. (Pulping efficiency, minimum, is 95.0 percent.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '91.5%', false, 0),
      (v_question_id, '93.5%', true, 1),
      (v_question_id, '95.0%', false, 2),
      (v_question_id, '98.0%', false, 3);
  END IF;

  -- 4. Pulping efficiency definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), the ratio of the total weight of parchment coffee collected at ALL outlets to the total coffee cherry input to the machine, expressed in percent, is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), the ratio of the total weight of parchment coffee collected at ALL outlets to the total coffee cherry input to the machine, expressed in percent, is called:', 'single_choice', 'medium', 'Clause 3.14 defines pulping efficiency as the ratio of the total weight of parchment coffee collected at all outlets to the total coffee cherry input. Pulping recovery (clause 3.15) counts only the parchment coffee collected at the main outlet.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pulping recovery', false, 0),
      (v_question_id, 'Pulping efficiency', true, 1),
      (v_question_id, 'Separation loss', false, 2),
      (v_question_id, 'Purity', false, 3);
  END IF;

  -- 5. Pulper scattering loss max
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria of PAES 252:2011 (Coffee Pulper), what is the maximum allowable scattering loss?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria of PAES 252:2011 (Coffee Pulper), what is the maximum allowable scattering loss?', 'single_choice', 'medium', 'Table 1 of clause 6.2 lists losses, maximum: separation loss 1.0 percent, unpulped loss 5.0 percent, and scattering loss 0.5 percent.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5%', true, 0),
      (v_question_id, '1.0%', false, 1),
      (v_question_id, '3.5%', false, 2),
      (v_question_id, '5.0%', false, 3);
  END IF;

  -- 6. Pulper numeric recovery
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee pulper is fed 200 kg of coffee cherries during a test. For the pulper to meet the minimum pulping recovery of PAES 252:2011, what is the least weight of parchment coffee that must be collected at the main parchment coffee outlet?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee pulper is fed 200 kg of coffee cherries during a test. For the pulper to meet the minimum pulping recovery of PAES 252:2011, what is the least weight of parchment coffee that must be collected at the main parchment coffee outlet?', 'single_choice', 'hard', 'Pulping recovery is the ratio of the parchment coffee collected at the main outlet to the total cherry input (clause 3.15), and the minimum is 93.5 percent (Table 1). Minimum main-outlet parchment = 0.935 x 200 kg = 187.0 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '175.0 kg', false, 0),
      (v_question_id, '187.0 kg', true, 1),
      (v_question_id, '190.0 kg', false, 2),
      (v_question_id, '196.0 kg', false, 3);
  END IF;

  -- 7. Pulper material
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), the pulping mechanism or pulping chamber shall be made of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), the pulping mechanism or pulping chamber shall be made of:', 'single_choice', 'easy', 'Clause 5.2: pulping mechanisms/pulping chamber shall be made of food grade and non-corrosive materials, e.g. stainless steel grade 304.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Food grade, non-corrosive material such as stainless steel grade 304', true, 0),
      (v_question_id, 'Gray cast iron with a protective paint coating', false, 1),
      (v_question_id, 'Heavy-duty mild steel with a zinc coating', false, 2),
      (v_question_id, 'Aluminum sheet of any grade', false, 3);
  END IF;

  -- 8. Pulper clearance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), the clearance between the rotating disc or cylinder and the fixed cover shall be:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), the clearance between the rotating disc or cylinder and the fixed cover shall be:', 'single_choice', 'medium', 'Clause 5.3: the clearance between the rotating disc or cylinder and the fixed cover shall be adjustable, and it shall be gradually decreasing in size.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fixed and uniform along the chamber', false, 0),
      (v_question_id, 'Adjustable and gradually decreasing in size', true, 1),
      (v_question_id, 'Adjustable and gradually increasing in size', false, 2),
      (v_question_id, 'Fixed and gradually decreasing in size', false, 3);
  END IF;

  -- 9. Wet feeding hopper water inlet
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), what must be provided on a wet feeding hopper to avoid clogging of pulp and beans during operation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), what must be provided on a wet feeding hopper to avoid clogging of pulp and beans during operation?', 'single_choice', 'medium', 'Clause 5.4: for a wet feeding hopper, an inlet for the intake water shall be provided to avoid clogging of pulp and beans during operation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A vibrating screen at the hopper mouth', false, 0),
      (v_question_id, 'An inlet for intake water', true, 1),
      (v_question_id, 'A magnetic separator', false, 2),
      (v_question_id, 'A pulp recirculation chute', false, 3);
  END IF;

  -- 10. Pulper weld requirements
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper) clause 7 on safety, workmanship and finish, welded joints shall NOT be less than ____ side fillet, and undercut shall NOT exceed ____ for any length of weld.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper) clause 7 on safety, workmanship and finish, welded joints shall NOT be less than ____ side fillet, and undercut shall NOT exceed ____ for any length of weld.', 'single_choice', 'hard', 'Clause 7.10: welded joints shall not be less than 4 mm (1/8 inch) side fillet welded, and undercut shall not exceed 2 mm (1/16 inch) for any length of weld.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 mm; 4 mm', false, 0),
      (v_question_id, '3 mm; 1 mm', false, 1),
      (v_question_id, '4 mm; 2 mm', true, 2),
      (v_question_id, '6 mm; 3 mm', false, 3);
  END IF;

  -- 11. Disc pulper mechanism
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the classification in PAES 252:2011 (Coffee Pulper), which pulper type removes the pulp from parchment coffee by the rubbing action of disc bulbs and chop rails?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the classification in PAES 252:2011 (Coffee Pulper), which pulper type removes the pulp from parchment coffee by the rubbing action of disc bulbs and chop rails?', 'single_choice', 'medium', 'Clause 4.1.1: the disc pulper uses the rubbing action of disc bulbs and chop rails to remove the pulp from parchment coffee. The drum pulper uses a rotating fluted cylinder inside a fixed pressed plate, and the slotted plate pulper uses a fixed slotted metal screen with a rotating cylinder.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drum pulper', false, 0),
      (v_question_id, 'Slotted plate pulper', false, 1),
      (v_question_id, 'Disc pulper', true, 2),
      (v_question_id, 'Fluted cylinder pulper', false, 3);
  END IF;

  -- 12. Pulper mech damaged parchment max
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria of PAES 252:2011 (Coffee Pulper), what is the maximum allowable percentage of mechanically damaged parchment coffee?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria of PAES 252:2011 (Coffee Pulper), what is the maximum allowable percentage of mechanically damaged parchment coffee?', 'single_choice', 'medium', 'Table 1 of clause 6.2 sets mechanically damaged parchment coffee at 3.5 percent, maximum. (Purity is 98 percent, minimum.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5%', false, 0),
      (v_question_id, '1.0%', false, 1),
      (v_question_id, '3.5%', true, 2),
      (v_question_id, '5.0%', false, 3);
  END IF;

  -- 13. Huller rubber roll
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the rubber roll huller shall be used for:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the rubber roll huller shall be used for:', 'single_choice', 'easy', 'Clause 4.1.2: the rubber roll huller shall be used for wet processed coffee beans.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Dried coffee cherry only', false, 0),
      (v_question_id, 'Wet processed coffee beans', true, 1),
      (v_question_id, 'Roasted coffee beans', false, 2),
      (v_question_id, 'Ground coffee', false, 3);
  END IF;

  -- 14. Hulling recovery parchment min
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria (Table 1) of PNS/BAFS/PAES 212:2017 (Coffee Huller), what is the minimum hulling recovery when the input is dried parchment coffee?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria (Table 1) of PNS/BAFS/PAES 212:2017 (Coffee Huller), what is the minimum hulling recovery when the input is dried parchment coffee?', 'single_choice', 'medium', 'Table 1 of clause 6.2: hulling recovery, minimum, is 80 percent for dried parchment coffee and 40 percent for dried coffee cherry.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40%', false, 0),
      (v_question_id, '80%', true, 1),
      (v_question_id, '95%', false, 2),
      (v_question_id, '97%', false, 3);
  END IF;

  -- 15. Huller numeric recovery
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During a test, 500 kg of dried parchment coffee is fed into a coffee huller. To meet the minimum hulling recovery of PNS/BAFS/PAES 212:2017, what is the least weight of green coffee beans that must be collected at the GCB outlet?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'During a test, 500 kg of dried parchment coffee is fed into a coffee huller. To meet the minimum hulling recovery of PNS/BAFS/PAES 212:2017, what is the least weight of green coffee beans that must be collected at the GCB outlet?', 'single_choice', 'hard', 'Hulling recovery is the ratio of the weight of GCB collected at the GCB outlet to the weight of input dried parchment coffee (clause 3.10). The minimum for dried parchment coffee is 80 percent (Table 1). Minimum GCB at the outlet = 0.80 x 500 kg = 400 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '200 kg', false, 0),
      (v_question_id, '400 kg', true, 1),
      (v_question_id, '475 kg', false, 2),
      (v_question_id, '485 kg', false, 3);
  END IF;

  -- 16. Hulling efficiency definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the ratio of the total weight of cleaned green coffee beans collected at ALL outlets to the input GCB, expressed in percent, is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the ratio of the total weight of cleaned green coffee beans collected at ALL outlets to the input GCB, expressed in percent, is called:', 'single_choice', 'medium', 'Clause 3.9 defines hulling efficiency as the ratio of the total weight of the cleaned GCB collected at all outlets to the input GCB. Hulling recovery (clause 3.10) considers only the GCB collected at the GCB outlet.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hulling recovery', false, 0),
      (v_question_id, 'Blower loss', false, 1),
      (v_question_id, 'Hulling efficiency', true, 2),
      (v_question_id, 'Purity', false, 3);
  END IF;

  -- 17. Huller mech damaged bean max
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria of PNS/BAFS/PAES 212:2017 (Coffee Huller), what is the maximum allowable percentage of mechanically damaged beans?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria of PNS/BAFS/PAES 212:2017 (Coffee Huller), what is the maximum allowable percentage of mechanically damaged beans?', 'single_choice', 'medium', 'Table 1 of clause 6.2: mechanically damaged bean, maximum, is 10 percent. (Hulling efficiency is 95 percent minimum and purity is 97 percent minimum.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3.5%', false, 0),
      (v_question_id, '5%', false, 1),
      (v_question_id, '10%', true, 2),
      (v_question_id, '20%', false, 3);
  END IF;

  -- 18. Huller noise 4 h
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee huller operator is exposed to noise for 4 hours per day. Using the permissible noise exposure table referenced in PNS/BAFS/PAES 212:2017, what is the maximum permissible sound level?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee huller operator is exposed to noise for 4 hours per day. Using the permissible noise exposure table referenced in PNS/BAFS/PAES 212:2017, what is the maximum permissible sound level?', 'single_choice', 'hard', 'Table 2 (permissible noise exposure): 8 h = 90 dB(A), 6 h = 92 dB(A), 4 h = 95 dB(A), 3 h = 97 dB(A), 2 h = 100 dB(A). For 4 hours per day the limit is 95 dB(A).', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90 dB(A)', false, 0),
      (v_question_id, '92 dB(A)', false, 1),
      (v_question_id, '95 dB(A)', true, 2),
      (v_question_id, '100 dB(A)', false, 3);
  END IF;

  -- 19. Huller magnets
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller) fabrication requirements, which provision is recommended ("should") to prevent metallic materials from entering the hulling chamber?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller) fabrication requirements, which provision is recommended ("should") to prevent metallic materials from entering the hulling chamber?', 'single_choice', 'medium', 'Clause 5.4: there should be provision of magnets to prevent metallic materials from entering the hulling chamber.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rubber shock mounts', false, 0),
      (v_question_id, 'Magnets', true, 1),
      (v_question_id, 'A water spray nozzle', false, 2),
      (v_question_id, 'A double-layer hopper cover', false, 3);
  END IF;

  -- 20. Roaster recovery min
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria (Table 1) of PNS/BAFS/PAES 214:2017 (Coffee Roaster), what is the minimum roasting recovery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria (Table 1) of PNS/BAFS/PAES 214:2017 (Coffee Roaster), what is the minimum roasting recovery?', 'single_choice', 'easy', 'Table 1 of clause 6.2: roasting recovery, minimum, is 80 percent; broken beans, maximum, is 1 percent.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60%', false, 0),
      (v_question_id, '70%', false, 1),
      (v_question_id, '80%', true, 2),
      (v_question_id, '95%', false, 3);
  END IF;

  -- 21. Roaster broken beans max
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria of PNS/BAFS/PAES 214:2017 (Coffee Roaster), what is the maximum allowable percentage of broken beans?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria of PNS/BAFS/PAES 214:2017 (Coffee Roaster), what is the maximum allowable percentage of broken beans?', 'single_choice', 'medium', 'Table 1 of clause 6.2: broken beans, maximum, is 1 percent.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1%', true, 0),
      (v_question_id, '3.5%', false, 1),
      (v_question_id, '5%', false, 2),
      (v_question_id, '10%', false, 3);
  END IF;

  -- 22. Roaster required accessories
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster), coffee roasters shall be provided with an appropriate temperature gauge, a cooling tray with stirrer, and an inspection window. What additional item shall be provided for drum roasters?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster), coffee roasters shall be provided with an appropriate temperature gauge, a cooling tray with stirrer, and an inspection window. What additional item shall be provided for drum roasters?', 'single_choice', 'medium', 'Clause 5.2: the roaster shall be provided with a temperature gauge, cooling tray with stirrer and inspection window, and for drum roasters a trier shall be provided. A coffee trier (clause 3.5) is a metal scoop used to sample a small portion of GCB for examination during roasting.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A trier', true, 0),
      (v_question_id, 'A chaff collector', false, 1),
      (v_question_id, 'A water quench tank', false, 2),
      (v_question_id, 'A hopper magnet', false, 3);
  END IF;

  -- 23. Roaster diesel heat exchanger
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster), which component shall be provided if diesel is used as the heat source?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster), which component shall be provided if diesel is used as the heat source?', 'single_choice', 'medium', 'Clause 5.3: coffee roaster should use LPG, electricity, or diesel. A heat exchanger shall be provided if diesel will be used.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A water quench system', false, 0),
      (v_question_id, 'A catalytic converter', false, 1),
      (v_question_id, 'A heat exchanger', true, 2),
      (v_question_id, 'A secondary electric heater', false, 3);
  END IF;

  -- 24. Roast degree 215C
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Coffee beans are roasted to an internal temperature of 215 degrees C and show a medium brown color with no oil on the surface. Per the degree-of-roast definitions in PNS/BAFS/PAES 214:2017, this is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Coffee beans are roasted to an internal temperature of 215 degrees C and show a medium brown color with no oil on the surface. Per the degree-of-roast definitions in PNS/BAFS/PAES 214:2017, this is classified as:', 'single_choice', 'hard', 'Clause 3.6: light roast has an internal temperature of 180-205 degrees C; medium roast (city roast) 210-220 degrees C, medium brown with no surface oil; medium-dark roast (full-city) around 225-230 degrees C; dark roast (French) 240-250 degrees C. At 215 degrees C with no oil, the beans are a medium (city) roast.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Light roast', false, 0),
      (v_question_id, 'Medium roast (city roast)', true, 1),
      (v_question_id, 'Medium-dark roast (full-city roast)', false, 2),
      (v_question_id, 'Dark roast (French roast)', false, 3);
  END IF;

  -- 25. Roaster convection
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster), an air roaster, which uses forced hot air to agitate and roast green coffee beans, employs which heating method?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster), an air roaster, which uses forced hot air to agitate and roast green coffee beans, employs which heating method?', 'single_choice', 'medium', 'Clauses 3.2 and 4.1.2: an air roaster uses forced hot air, and convection (transfer of heat through heated air) is the heating method employed by air roasters. Conduction (clause 4.1.1) is employed by drum roasters through a hot metal drum surface.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conduction', false, 0),
      (v_question_id, 'Convection', true, 1),
      (v_question_id, 'Direct radiation', false, 2),
      (v_question_id, 'Induction', false, 3);
  END IF;

  -- 26. Roaster numeric recovery
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A batch of 50 kg of green coffee beans is loaded into a coffee roaster. To meet the minimum roasting recovery of PNS/BAFS/PAES 214:2017, what is the least weight of roasted coffee beans that must be collected at the outlet?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A batch of 50 kg of green coffee beans is loaded into a coffee roaster. To meet the minimum roasting recovery of PNS/BAFS/PAES 214:2017, what is the least weight of roasted coffee beans that must be collected at the outlet?', 'single_choice', 'hard', 'Roasting recovery is the ratio of the total weight of roasted coffee beans collected at the outlet to the total weight of input GCB (clause 3.14), with a minimum of 80 percent (Table 1). Minimum RCB = 0.80 x 50 kg = 40 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30 kg', false, 0),
      (v_question_id, '40 kg', true, 1),
      (v_question_id, '45 kg', false, 2),
      (v_question_id, '49 kg', false, 3);
  END IF;

  -- 27. Grinder recovery min
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria (Table 1) of PNS/BAFS PAES 188:2018 (Coffee Grinder), what is the minimum grinding recovery?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria (Table 1) of PNS/BAFS PAES 188:2018 (Coffee Grinder), what is the minimum grinding recovery?', 'single_choice', 'easy', 'Table 1 of clause 6.2: grinding recovery, minimum, is 96 percent; average particle size, maximum, is 1.5 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '90%', false, 0),
      (v_question_id, '93.5%', false, 1),
      (v_question_id, '96%', true, 2),
      (v_question_id, '98%', false, 3);
  END IF;

  -- 28. Grinder particle size max
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the performance criteria of PNS/BAFS PAES 188:2018 (Coffee Grinder), what is the maximum average particle size of the ground coffee?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the performance criteria of PNS/BAFS PAES 188:2018 (Coffee Grinder), what is the maximum average particle size of the ground coffee?', 'single_choice', 'medium', 'Table 1 of clause 6.2: average particle size, maximum, is 1.5 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.5 mm', false, 0),
      (v_question_id, '1.0 mm', false, 1),
      (v_question_id, '1.5 mm', true, 2),
      (v_question_id, '2.0 mm', false, 3);
  END IF;

  -- 29. Grinder prime mover
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS PAES 188:2018 (Coffee Grinder) fabrication requirements, the coffee grinder shall use which prime mover?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS PAES 188:2018 (Coffee Grinder) fabrication requirements, the coffee grinder shall use which prime mover?', 'single_choice', 'easy', 'Clause 5.2: the coffee grinder shall use an electric motor as prime mover. The scope (clause 1) likewise covers coffee grinders particularly those run by an electric motor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diesel engine', false, 0),
      (v_question_id, 'Gasoline engine', false, 1),
      (v_question_id, 'Electric motor', true, 2),
      (v_question_id, 'Manual hand crank', false, 3);
  END IF;

  -- 30. Conical burr grinder
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS PAES 188:2018 (Coffee Grinder), which grinding mechanism has a conical shaped grinding surface and grinds roasted coffee beans at a slower and quieter rate than the flat burr grinder, usually on low speed and gear reduction grinders?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS PAES 188:2018 (Coffee Grinder), which grinding mechanism has a conical shaped grinding surface and grinds roasted coffee beans at a slower and quieter rate than the flat burr grinder, usually on low speed and gear reduction grinders?', 'single_choice', 'medium', 'Clause 4.1.2.2: the conical burr grinder has a conical shaped grinding surface capable of grinding RCB at a slower and quieter rate than the flat burr grinder. The hammer-type grinder crushes by impact and the blade grinder chops with a whirling metal blade.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hammer-type grinder', false, 0),
      (v_question_id, 'Blade grinder', false, 1),
      (v_question_id, 'Conical burr grinder', true, 2),
      (v_question_id, 'Flat burr grinder', false, 3);
  END IF;

  -- 31. Grinder numeric recovery
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee grinder is fed 25 kg of roasted coffee beans. To meet the minimum grinding recovery of PNS/BAFS PAES 188:2018, what is the least weight of ground coffee that must be collected at the ground coffee outlet?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee grinder is fed 25 kg of roasted coffee beans. To meet the minimum grinding recovery of PNS/BAFS PAES 188:2018, what is the least weight of ground coffee that must be collected at the ground coffee outlet?', 'single_choice', 'hard', 'Grinding recovery is the ratio of the total weight of ground coffee collected at the outlet to the total weight of input RCB (clause 3.5), with a minimum of 96 percent (Table 1). Minimum ground coffee = 0.96 x 25 kg = 24 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '20.0 kg', false, 0),
      (v_question_id, '22.5 kg', false, 1),
      (v_question_id, '24.0 kg', true, 2),
      (v_question_id, '25.0 kg', false, 3);
  END IF;
END $$;
