-- Design and Specifications of Coffee Processing Facility, batch 3
-- quiz batch (33 questions, 1 topic). Every question, correct answer and
-- distractor is drawn from the coffee pulper, huller, roaster and grinder
-- standards (PAES 252, PNS/BAFS/PAES 212, 214 and PNS/BAFS PAES 188) and from the
-- National Building Code (PD 1096) sections on room size, air space, windows
-- and ventilation, all read in full - no invented facts. Angles differ from the
-- 31 draft and 13 published questions already in this topic.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). Machinery-standard questions carry
-- is_paes=true with the standard number in paes_reference; building-code and
-- facility-guideline questions have is_paes=false and paes_reference=NULL.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Design and Specifications of Coffee Processing Facility (STRUCTURES_ENVIRONMENT) - 33 question(s)
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

  -- 1. Pulper noise limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Table 1 of PAES 252:2011 (Coffee Pulper) limits the noise level of the machine, based on six hours of continuous exposure. What is the maximum noise level?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Table 1 of PAES 252:2011 (Coffee Pulper) limits the noise level of the machine, based on six hours of continuous exposure. What is the maximum noise level?', 'single_choice', 'medium', 'Table 1 of clause 6.2 lists the noise level, maximum, as 92.0 dB(A), the allowable level for six hours of continuous exposure.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '85.0 dB(A)', false, 0),
      (v_question_id, '92.0 dB(A)', true, 1),
      (v_question_id, '95.0 dB(A)', false, 2),
      (v_question_id, '90.0 dB(A)', false, 3);
  END IF;

  -- 2. Separation loss definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), the ratio of the total weight of parchment coffee that comes out of the pulp outlet to the total input weight of coffee cherry, expressed in percent, is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), the ratio of the total weight of parchment coffee that comes out of the pulp outlet to the total input weight of coffee cherry, expressed in percent, is called:', 'single_choice', 'medium', 'Clause 3.16 defines separation loss as the parchment coffee that leaves through the pulp outlet relative to the total cherry input. Unpulped loss (3.17) counts unpulped cherry, and scattering loss (3.18) counts parchment that falls around the base of the machine.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Unpulped loss', false, 0),
      (v_question_id, 'Pulping recovery', false, 1),
      (v_question_id, 'Separation loss', true, 2),
      (v_question_id, 'Scattering loss', false, 3);
  END IF;

  -- 3. Fluted cylinder flute inclination
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the classification in PAES 252:2011 (Coffee Pulper), fluted cylinder pulpers are classified according to flute inclination. Which set of inclination angles is listed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the classification in PAES 252:2011 (Coffee Pulper), fluted cylinder pulpers are classified according to flute inclination. Which set of inclination angles is listed?', 'single_choice', 'hard', 'Clause 4.1.3 classifies fluted cylinder pulpers by flute inclination: 43 degrees (4.1.3.1), 50 degrees (4.1.3.2) and 60 degrees (4.1.3.3).', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '40, 50 and 70 degrees', false, 0),
      (v_question_id, '30, 45 and 60 degrees', false, 1),
      (v_question_id, '35, 45 and 55 degrees', false, 2),
      (v_question_id, '43, 50 and 60 degrees', true, 3);
  END IF;

  -- 4. Drum pulper definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), which pulper type uses a rotating cylinder with flutes inside a fixed pressed plate that has pulping channels and ribs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), which pulper type uses a rotating cylinder with flutes inside a fixed pressed plate that has pulping channels and ribs?', 'single_choice', 'medium', 'Clause 4.1.2: the drum pulper uses a rotating cylinder with flutes inside a fixed pressed plate with pulping channels and ribs. The disc pulper rubs with disc bulbs and chop rails, and the slotted plate pulper uses a fixed slotted metal screen with a rotating cylinder.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Drum pulper', true, 0),
      (v_question_id, 'Screw-press pulper', false, 1),
      (v_question_id, 'Disc pulper', false, 2),
      (v_question_id, 'Slotted plate pulper', false, 3);
  END IF;

  -- 5. Dry feeding
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the mode-of-feeding classification of PAES 252:2011 (Coffee Pulper), coffee cherries fed into the hopper of the pulper without using water are classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the mode-of-feeding classification of PAES 252:2011 (Coffee Pulper), coffee cherries fed into the hopper of the pulper without using water are classified as:', 'single_choice', 'easy', 'Clause 4.2.1 defines dry feeding as feeding coffee cherry into the hopper without using water. Wet feeding (4.2.2) uses water.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gravity feeding', false, 0),
      (v_question_id, 'Wet feeding', false, 1),
      (v_question_id, 'Dry feeding', true, 2),
      (v_question_id, 'Forced feeding', false, 3);
  END IF;

  -- 6. Oscillating conveyor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper) clause 5.5, a water-pulp-parchment conveyor, if provided, shall be designed to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper) clause 5.5, a water-pulp-parchment conveyor, if provided, shall be designed to:', 'single_choice', 'medium', 'Clause 5.5: the water-pulp-parchment conveyor (if available) shall be designed to oscillate to avoid pulp and parchment getting stuck on the conveyor.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rotate continuously at not more than 60 rpm', false, 0),
      (v_question_id, 'Oscillate so that pulp and parchment do not get stuck on it', true, 1),
      (v_question_id, 'Be inclined at a fixed 45-degree angle', false, 2),
      (v_question_id, 'Be made of rubber-coated mild steel', false, 3);
  END IF;

  -- 7. Pulper warranty period
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 252:2011 (Coffee Pulper), the warranty against defective materials and workmanship, excluding normal wear of consumable parts such as belts, is provided within how long from the date of purchase?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 252:2011 (Coffee Pulper), the warranty against defective materials and workmanship, excluding normal wear of consumable parts such as belts, is provided within how long from the date of purchase?', 'single_choice', 'easy', 'Clause 8.1 provides the warranty within six months from the date of purchase, and clause 8.2 requires the construction to be durable without breakdown of its major components for at least six months from the date of purchase.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Six months', true, 0),
      (v_question_id, 'Two years', false, 1),
      (v_question_id, 'Three months', false, 2),
      (v_question_id, 'One year', false, 3);
  END IF;

  -- 8. Mucilage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the definitions in PAES 252:2011 (Coffee Pulper), the slimy layer found between the pulp and adhering to the parchment is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the definitions in PAES 252:2011 (Coffee Pulper), the slimy layer found between the pulp and adhering to the parchment is called:', 'single_choice', 'easy', 'Clause 3.8 defines mucilage as the slimy layer found between the pulp and adhering to the parchment. (Hull is the dried parchment and husk is the dried cherry pulp, as defined for coffee hullers.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hull', false, 0),
      (v_question_id, 'Husk', false, 1),
      (v_question_id, 'Silverskin', false, 2),
      (v_question_id, 'Mucilage', true, 3);
  END IF;

  -- 9. Husk definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the dried cherry pulp, or the assembled external envelopes (pericarp) of the dried coffee fruit, is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the dried cherry pulp, or the assembled external envelopes (pericarp) of the dried coffee fruit, is called the:', 'single_choice', 'easy', 'Clause 3.11 defines husk as the dried cherry pulp, the assembled external envelopes (pericarp) of the dried coffee fruit. Hull (3.6) is the dried parchment, that is, the dried endocarp of the parchment coffee.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Green coffee bean', false, 0),
      (v_question_id, 'Hull', false, 1),
      (v_question_id, 'Husk', true, 2),
      (v_question_id, 'Parchment coffee', false, 3);
  END IF;

  -- 10. Blower loss definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the ratio of the weight of green coffee bean blown by the huller fan, including the GCB in the blown unhulled coffee beans, to the input GCB, expressed in percent, is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 212:2017 (Coffee Huller), the ratio of the weight of green coffee bean blown by the huller fan, including the GCB in the blown unhulled coffee beans, to the input GCB, expressed in percent, is called:', 'single_choice', 'hard', 'Clause 3.1 defines blower loss as the GCB blown by the huller fan (including the GCB inside blown unhulled beans) over the input GCB. Hulling recovery (3.10) and hulling efficiency (3.9) both concern GCB that is collected, not blown away.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hulling efficiency', false, 0),
      (v_question_id, 'Blower loss', true, 1),
      (v_question_id, 'Purity', false, 2),
      (v_question_id, 'Hulling recovery', false, 3);
  END IF;

  -- 11. Hulling wet method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the definition of hulling in PNS/BAFS/PAES 212:2017 (Coffee Huller), the wet method of processing requires hulling to separate which materials from the green coffee beans?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the definition of hulling in PNS/BAFS/PAES 212:2017 (Coffee Huller), the wet method of processing requires hulling to separate which materials from the green coffee beans?', 'single_choice', 'medium', 'Clause 3.7 defines hulling (dehusking) as the primary processing step that separates the dried pericarp (in the dry method) or the dried parchment and silver skin (in the wet method) from the green coffee beans.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Chaff and roasted skin', false, 0),
      (v_question_id, 'Mucilage and fresh pulp', false, 1),
      (v_question_id, 'Dried pericarp only', false, 2),
      (v_question_id, 'Dried parchment and silver skin', true, 3);
  END IF;

  -- 12. First crack
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per the definitions in PNS/BAFS/PAES 214:2017 (Coffee Roaster), which roasting stage involves complex chemical reactions as the green coffee beans reach 160 degrees C, causing an audible cracking sound?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per the definitions in PNS/BAFS/PAES 214:2017 (Coffee Roaster), which roasting stage involves complex chemical reactions as the green coffee beans reach 160 degrees C, causing an audible cracking sound?', 'single_choice', 'medium', 'Clause 3.8 defines the first crack as the stage where complex chemical reactions occur as the GCB reach 160 degrees C, causing an audible cracking sound. The second crack (3.17) is the later stage where the beans are dehydrated and brittle, with cracking and carbonization.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'First crack', true, 0),
      (v_question_id, 'Water quench', false, 1),
      (v_question_id, 'Air quench', false, 2),
      (v_question_id, 'Second crack', false, 3);
  END IF;

  -- 13. Dark roast scenario
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Roasted coffee beans are dark brown and covered in oil on the surface, with an internal temperature of 245 degrees C at about the end of the second crack. Per the degree-of-roast definitions in PNS/BAFS/PAES 214:2017, this is classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Roasted coffee beans are dark brown and covered in oil on the surface, with an internal temperature of 245 degrees C at about the end of the second crack. Per the degree-of-roast definitions in PNS/BAFS/PAES 214:2017, this is classified as:', 'single_choice', 'medium', 'Clause 3.6(d): dark roast (French roast) is dark brown with the roasted beans covered in oil, roasted to an internal temperature of 240 to 250 degrees C at about the end of the second crack.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Medium-dark roast (full-city roast)', false, 0),
      (v_question_id, 'Medium roast (city roast)', false, 1),
      (v_question_id, 'Dark roast (French roast)', true, 2),
      (v_question_id, 'Light roast', false, 3);
  END IF;

  -- 14. Roaster heat adjustment shall
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster) clause 5.5, which adjustment mechanism is mandatory (shall) on every coffee roaster, while the other adjustments are only recommended (should), as applicable?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster) clause 5.5, which adjustment mechanism is mandatory (shall) on every coffee roaster, while the other adjustments are only recommended (should), as applicable?', 'single_choice', 'hard', 'Clause 5.5: the roaster shall have a mechanism for adjustment of heat, and should have a mechanism for adjustment of airflow and drum speed, as applicable.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Adjustment of drum speed', false, 0),
      (v_question_id, 'Adjustment of heat', true, 1),
      (v_question_id, 'Adjustment of airflow', false, 2),
      (v_question_id, 'Adjustment of the cooling tray height', false, 3);
  END IF;

  -- 15. Grinder materials
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS PAES 188:2018 (Coffee Grinder) clause 5.1, parts in direct contact with the roasted coffee beans, such as the grinding mechanism and grinding chamber, shall be made of corrosion resistant and food grade material, for example stainless steel grade:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS PAES 188:2018 (Coffee Grinder) clause 5.1, parts in direct contact with the roasted coffee beans, such as the grinding mechanism and grinding chamber, shall be made of corrosion resistant and food grade material, for example stainless steel grade:', 'single_choice', 'medium', 'Clause 5.1 gives stainless steel grade 304 or 316 as examples of corrosion resistant, food grade material for parts in direct contact with the RCB.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '304 or 316', true, 0),
      (v_question_id, '201 or 202', false, 1),
      (v_question_id, '430 or 446', false, 2),
      (v_question_id, '410 or 430', false, 3);
  END IF;

  -- 16. Grinder noise duration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee grinder produces a sound level of 100 dB(A) at the operator position. Using the permissible noise exposure table referenced in PNS/BAFS PAES 188:2018, what is the maximum permissible daily exposure duration?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee grinder produces a sound level of 100 dB(A) at the operator position. Using the permissible noise exposure table referenced in PNS/BAFS PAES 188:2018, what is the maximum permissible daily exposure duration?', 'single_choice', 'hard', 'Table 2 (permissible noise exposure): 8 h = 90, 6 h = 92, 4 h = 95, 3 h = 97, 2 h = 100, 1.5 h = 102 and 1 h = 105 dB(A). A level of 100 dB(A) is permitted for 2 hours per day.', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 hour', false, 0),
      (v_question_id, '3 hours', false, 1),
      (v_question_id, '4 hours', false, 2),
      (v_question_id, '2 hours', true, 3);
  END IF;

  -- 17. Machinery room ventilation purpose
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under Section 811 of the National Building Code (PD 1096), rooms or spaces housing industrial or heating equipment, such as a coffee roasting room, shall be provided with artificial means of ventilation to prevent:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under Section 811 of the National Building Code (PD 1096), rooms or spaces housing industrial or heating equipment, such as a coffee roasting room, shall be provided with artificial means of ventilation to prevent:', 'single_choice', 'medium', 'Section 811(a) of PD 1096: rooms or spaces housing industrial or heating equipment shall be provided with artificial means of ventilation to prevent excessive accumulation of hot and/or polluted air.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Excessive accumulation of hot and/or polluted air', true, 0),
      (v_question_id, 'Noise transmission to adjacent rooms', false, 1),
      (v_question_id, 'Condensation on the ceiling only', false, 2),
      (v_question_id, 'The entry of insects only', false, 3);
  END IF;

  -- 18. GCB storage moisture
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the recommended moisture content range of green coffee beans placed in storage in a coffee processing facility?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the recommended moisture content range of green coffee beans placed in storage in a coffee processing facility?', 'single_choice', 'easy', 'Green coffee beans are stored at 9 to 12 percent moisture content together with 60 to 80 percent relative humidity, which prevents the beans from rewetting and degrading.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5% to 7%', false, 0),
      (v_question_id, '9% to 12%', true, 1),
      (v_question_id, '18% to 20%', false, 2),
      (v_question_id, '14% to 16%', false, 3);
  END IF;

  -- 19. Safety marking color
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster) clause 12.2, safety or precautionary markings shall be stated in English and Filipino and printed in:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PNS/BAFS/PAES 214:2017 (Coffee Roaster) clause 12.2, safety or precautionary markings shall be stated in English and Filipino and printed in:', 'single_choice', 'easy', 'Clause 12.2: safety/precautionary markings shall be stated in English and Filipino and printed in red color with a white background.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Black letters on a yellow background', false, 0),
      (v_question_id, 'White letters on a red background', false, 1),
      (v_question_id, 'Red color with a white background', true, 2),
      (v_question_id, 'Yellow letters on a black background', false, 3);
  END IF;

  -- 20. Separation loss compliance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee pulper is fed 200 kg of coffee cherries during a test, and 3 kg of parchment coffee is collected at the pulp outlet. Using the definition of separation loss in PAES 252:2011 and its maximum allowable separation loss of 1.0 percent, what is the separation loss of the machine and does it conform?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee pulper is fed 200 kg of coffee cherries during a test, and 3 kg of parchment coffee is collected at the pulp outlet. Using the definition of separation loss in PAES 252:2011 and its maximum allowable separation loss of 1.0 percent, what is the separation loss of the machine and does it conform?', 'single_choice', 'hard', 'Given: cherry input = 200 kg; parchment at the pulp outlet = 3 kg; maximum separation loss = 1.0 percent. Separation loss = 3 / 200 x 100 = 1.5 percent, which is greater than 1.0 percent, so the pulper does not conform.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.15 percent, which is within the maximum', false, 0),
      (v_question_id, '1.5 percent, which is within the maximum', false, 1),
      (v_question_id, '15 percent, which exceeds the maximum', false, 2),
      (v_question_id, '1.5 percent, which exceeds the maximum', true, 3);
  END IF;

  -- 21. Scattering loss computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'During a pulper test, 400 kg of coffee cherries is fed into the machine and 2.4 kg of parchment coffee is found scattered around the base of the pulper. Using the definition in PAES 252:2011 (Coffee Pulper), what is the scattering loss?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'During a pulper test, 400 kg of coffee cherries is fed into the machine and 2.4 kg of parchment coffee is found scattered around the base of the pulper. Using the definition in PAES 252:2011 (Coffee Pulper), what is the scattering loss?', 'single_choice', 'easy', 'Given: cherry input = 400 kg; scattered parchment = 2.4 kg. Scattering loss = 2.4 / 400 x 100 = 0.6 percent (above the 0.5 percent maximum of Table 1).', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.6%', true, 0),
      (v_question_id, '0.06%', false, 1),
      (v_question_id, '166.7%', false, 2),
      (v_question_id, '6.0%', false, 3);
  END IF;

  -- 22. Pulping efficiency computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee pulper is fed 300 kg of coffee cherries. The parchment coffee collected is 280 kg at the main parchment coffee outlet and 6 kg at the pulp outlet. Using the definitions in PAES 252:2011, what is the pulping efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee pulper is fed 300 kg of coffee cherries. The parchment coffee collected is 280 kg at the main parchment coffee outlet and 6 kg at the pulp outlet. Using the definitions in PAES 252:2011, what is the pulping efficiency?', 'single_choice', 'hard', 'Given: cherry input = 300 kg; parchment at the main outlet = 280 kg; parchment at the pulp outlet = 6 kg. Pulping efficiency counts parchment collected at all outlets: (280 + 6) / 300 x 100 = 95.3 percent, which meets the 95.0 percent minimum. (Using only the main outlet, 280 / 300 = 93.3 percent, is the pulping recovery.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '93.3%', false, 0),
      (v_question_id, '2.0%', false, 1),
      (v_question_id, '98.0%', false, 2),
      (v_question_id, '95.3%', true, 3);
  END IF;

  -- 23. Pulper purity computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 500 g sample of parchment coffee is taken from the main outlet of a coffee pulper. After cleaning, the sample weighs 492 g free of foreign matter. What is the purity of the parchment coffee?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 500 g sample of parchment coffee is taken from the main outlet of a coffee pulper. After cleaning, the sample weighs 492 g free of foreign matter. What is the purity of the parchment coffee?', 'single_choice', 'medium', 'Given: sample weight = 500 g; cleaned parchment = 492 g. Purity = cleaned weight / sample weight x 100 = 492 / 500 x 100 = 98.4 percent, which meets the 98 percent minimum purity of PAES 252:2011.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '97.6%', false, 0),
      (v_question_id, '98.4%', true, 1),
      (v_question_id, '99.2%', false, 2),
      (v_question_id, '1.6%', false, 3);
  END IF;

  -- 24. Hulling efficiency computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a hulling test, the input GCB is 400 kg. The cleaned green coffee beans collected are 372 kg at the GCB outlet and 12 kg at the other outlets. Using the definition in PNS/BAFS/PAES 212:2017, what is the hulling efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a hulling test, the input GCB is 400 kg. The cleaned green coffee beans collected are 372 kg at the GCB outlet and 12 kg at the other outlets. Using the definition in PNS/BAFS/PAES 212:2017, what is the hulling efficiency?', 'single_choice', 'hard', 'Given: input GCB = 400 kg; cleaned GCB = 372 kg at the GCB outlet + 12 kg at other outlets. Hulling efficiency counts the cleaned GCB at all outlets: (372 + 12) / 400 x 100 = 96.0 percent, which meets the 95 percent minimum. (The GCB outlet alone, 372 / 400 = 93.0 percent, is the hulling recovery.)', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '93.0%', false, 0),
      (v_question_id, '104.2%', false, 1),
      (v_question_id, '96.0%', true, 2),
      (v_question_id, '99.0%', false, 3);
  END IF;

  -- 25. Hulling capacity computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee huller is fed 450 kg of dried parchment coffee in a total operating time of 2.5 hours. Using the definition of hulling capacity in PNS/BAFS/PAES 212:2017, what is the hulling capacity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee huller is fed 450 kg of dried parchment coffee in a total operating time of 2.5 hours. Using the definition of hulling capacity in PNS/BAFS/PAES 212:2017, what is the hulling capacity?', 'single_choice', 'easy', 'Given: dried parchment coffee fed = 450 kg; operating time = 2.5 h. Hulling capacity = weight fed / operating time = 450 / 2.5 = 180 kg/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '225 kg/h', false, 0),
      (v_question_id, '180 kg/h', true, 1),
      (v_question_id, '1125 kg/h', false, 2),
      (v_question_id, '150 kg/h', false, 3);
  END IF;

  -- 26. Roasting recovery verdict
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee roaster is loaded with 60 kg of green coffee beans and 47 kg of roasted coffee beans is collected at the outlet. Using the definition of roasting recovery and the 80 percent minimum in PNS/BAFS/PAES 214:2017, what is the roasting recovery and does the roaster conform?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee roaster is loaded with 60 kg of green coffee beans and 47 kg of roasted coffee beans is collected at the outlet. Using the definition of roasting recovery and the 80 percent minimum in PNS/BAFS/PAES 214:2017, what is the roasting recovery and does the roaster conform?', 'single_choice', 'hard', 'Given: GCB input = 60 kg; RCB collected = 47 kg; minimum roasting recovery = 80 percent. Roasting recovery = 47 / 60 x 100 = 78.3 percent, which is below 80 percent, so the roaster does not conform.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '78.3 percent, which does not meet the minimum', true, 0),
      (v_question_id, '127.7 percent, which meets the minimum', false, 1),
      (v_question_id, '78.3 percent, which meets the minimum', false, 2),
      (v_question_id, '21.7 percent, which does not meet the minimum', false, 3);
  END IF;

  -- 27. Roasting capacity computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee roaster produces four batches of roasted coffee beans of 12 kg each during a total machine operating time of 3 hours. Using the definition of roasting capacity in PNS/BAFS/PAES 214:2017, what is the roasting capacity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee roaster produces four batches of roasted coffee beans of 12 kg each during a total machine operating time of 3 hours. Using the definition of roasting capacity in PNS/BAFS/PAES 214:2017, what is the roasting capacity?', 'single_choice', 'medium', 'Given: 4 batches x 12 kg of roasted beans; operating time = 3 h. Roasting capacity = total roasted beans / total operating time = (4 x 12) / 3 = 48 / 3 = 16 kg/h.', NULL, NULL, 'draft', false, NULL, true, 'PAES 214')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 kg/h', false, 0),
      (v_question_id, '4 kg/h', false, 1),
      (v_question_id, '48 kg/h', false, 2),
      (v_question_id, '16 kg/h', true, 3);
  END IF;

  -- 28. Grinder maximum shortfall
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee grinder is fed 40 kg of roasted coffee beans. Based on the minimum grinding recovery of PNS/BAFS PAES 188:2018, what is the greatest weight of material that may fail to be recovered at the ground coffee outlet while the machine still conforms?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee grinder is fed 40 kg of roasted coffee beans. Based on the minimum grinding recovery of PNS/BAFS PAES 188:2018, what is the greatest weight of material that may fail to be recovered at the ground coffee outlet while the machine still conforms?', 'single_choice', 'medium', 'The minimum grinding recovery is 96 percent (Table 1). Minimum ground coffee = 0.96 x 40 kg = 38.4 kg, so the largest allowable shortfall = 40 - 38.4 = 1.6 kg (equivalently 4 percent of 40 kg).', NULL, NULL, 'draft', false, NULL, true, 'PAES 188')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4.0 kg', false, 0),
      (v_question_id, '0.4 kg', false, 1),
      (v_question_id, '1.6 kg', true, 2),
      (v_question_id, '2.0 kg', false, 3);
  END IF;

  -- 29. Unpulped loss maximum
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A coffee pulper is fed 600 kg of coffee cherries. Based on the maximum unpulped loss in Table 1 of PAES 252:2011, what is the greatest weight of unpulped coffee cherries that the machine may leave while still conforming?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A coffee pulper is fed 600 kg of coffee cherries. Based on the maximum unpulped loss in Table 1 of PAES 252:2011, what is the greatest weight of unpulped coffee cherries that the machine may leave while still conforming?', 'single_choice', 'medium', 'Table 1 of clause 6.2 sets the unpulped loss at 5.0 percent, maximum. Maximum unpulped cherry = 0.05 x 600 kg = 30 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 252')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60 kg', false, 0),
      (v_question_id, '30 kg', true, 1),
      (v_question_id, '6 kg', false, 2),
      (v_question_id, '3 kg', false, 3);
  END IF;

  -- 30. Huller minimum efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The input GCB to a coffee huller during a test is 600 kg. Based on the minimum hulling efficiency in Table 1 of PNS/BAFS/PAES 212:2017, what is the least total weight of cleaned GCB that must be collected at all outlets?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The input GCB to a coffee huller during a test is 600 kg. Based on the minimum hulling efficiency in Table 1 of PNS/BAFS/PAES 212:2017, what is the least total weight of cleaned GCB that must be collected at all outlets?', 'single_choice', 'medium', 'Table 1 of clause 6.2: hulling efficiency, minimum, is 95 percent. Least cleaned GCB at all outlets = 0.95 x 600 kg = 570 kg.', NULL, NULL, 'draft', false, NULL, true, 'PAES 212')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '480 kg', false, 0),
      (v_question_id, '540 kg', false, 1),
      (v_question_id, '582 kg', false, 2),
      (v_question_id, '570 kg', true, 3);
  END IF;

  -- 31. Boiler room ventilation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A boiler room serving a coffee processing facility measures 6 m x 5 m with a ceiling height of 3 m and is entirely above grade. Under Section 811 of the National Building Code (PD 1096), what is the minimum ventilation rate that artificial ventilation must supply to this room?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A boiler room serving a coffee processing facility measures 6 m x 5 m with a ceiling height of 3 m and is entirely above grade. Under Section 811 of the National Building Code (PD 1096), what is the minimum ventilation rate that artificial ventilation must supply to this room?', 'single_choice', 'hard', 'Section 811(b)(2) of PD 1096 requires not less than ten changes of air per hour for boiler rooms entirely above grade. Given: room volume = 6 x 5 x 3 = 90 m3. Minimum rate = 10 x 90 = 900 m3/h. (Three changes per hour, 270 m3/h, applies to factories, workshops and machinery rooms.)', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '270 m3/h', false, 0),
      (v_question_id, '300 m3/h', false, 1),
      (v_question_id, '900 m3/h', true, 2),
      (v_question_id, '90 m3/h', false, 3);
  END IF;

  -- 32. Roasting room occupancy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A roasting room of a coffee processing facility measures 8 m x 6 m with a ceiling height of 2.7 m. Under the air space requirement for workshops and factories in Section 807 of the National Building Code (PD 1096), what is the maximum number of persons who may occupy the room?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A roasting room of a coffee processing facility measures 8 m x 6 m with a ceiling height of 2.7 m. Under the air space requirement for workshops and factories in Section 807 of the National Building Code (PD 1096), what is the maximum number of persons who may occupy the room?', 'single_choice', 'hard', 'Section 807 of PD 1096 requires 12.00 m3 of air space per person in workshops, factories and offices. Given: room volume = 8 x 6 x 2.7 = 129.6 m3. Persons = 129.6 / 12 = 10.8, so a maximum of 10 persons (whole persons only).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 persons', true, 0),
      (v_question_id, '11 persons', false, 1),
      (v_question_id, '9 persons', false, 2),
      (v_question_id, '4 persons', false, 3);
  END IF;

  -- 33. Window opening area
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A sorting room of a coffee processing facility measures 7.5 m x 4 m and has no artificial ventilation system. Under Section 808 of the National Building Code (PD 1096), what is the minimum total free area of window openings?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A sorting room of a coffee processing facility measures 7.5 m x 4 m and has no artificial ventilation system. Under Section 808 of the National Building Code (PD 1096), what is the minimum total free area of window openings?', 'single_choice', 'medium', 'Section 808 of PD 1096: a room without artificial ventilation shall have windows with a total free area of openings equal to at least ten percent of the floor area. Given: floor area = 7.5 x 4 = 30 m2. Minimum free area = 0.10 x 30 = 3.0 m2.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.3 m2', false, 0),
      (v_question_id, '1.5 m2', false, 1),
      (v_question_id, '3.0 m2', true, 2),
      (v_question_id, '6.0 m2', false, 3);
  END IF;
END $$;
