-- Agricultural Machinery Design, Fabrication/Manufacturing and Testing quiz batch 3 (43 questions, 1 topic).
-- Machine-design questions on shafts, keys and keyways, V-belts and pulleys, roller chains and
-- sprockets, spur, helical and bevel gears, anti-friction and journal bearings, bolts and nuts,
-- rivets, washers, clutches and couplings.
-- Every fact, number and formula is drawn directly from the reference standards on engineering
-- materials for agricultural machines (PAES 301 to PAES 318) - no invented facts.
-- Numeric problems state every given value in the question text and were re-derived before
-- the answer was marked.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=true with paes_reference set to the
-- standard number because every question is about a clause, table or formula of that standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Agricultural Machinery Design, Fabrication/Manufacturing and Testing (POWER_ENERGY_MACHINERY) -- 43 question(s)
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
    RAISE EXCEPTION 'Topic not found: Agricultural Machinery Design, Fabrication/Manufacturing and Testing';
  END IF;

  -- 1. Standard shaft material
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 305:2000, what is the usual material designation of standard shafts for agricultural machines, and which designations are used when stainless steel shafts are required for special purposes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 305:2000, what is the usual material designation of standard shafts for agricultural machines, and which designations are used when stainless steel shafts are required for special purposes?', 'single_choice', 'easy', 'Standard shafts are usually cold-rolled steel designation 1020. For special purposes, stainless steel shafts of designation 304 or 316 are used.', NULL, NULL, 'draft', false, NULL, true, 'PAES 305:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hot-rolled steel 1045 for standard shafts; stainless steel 410 for special purposes', false, 0),
      (v_question_id, 'Annealed steel 1020 for standard shafts; bronze for special purposes', false, 1),
      (v_question_id, 'Cold-rolled steel 1020 for standard shafts; stainless steel 304 or 316 for special purposes', true, 2),
      (v_question_id, 'Cast iron for standard shafts; stainless steel 430 for special purposes', false, 3);
  END IF;

  -- 2. Shaft power rating basis
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The power-rating tables of PAES 305:2000 for standard keyseated shafting are based on a safe shear stress of approximately';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The power-rating tables of PAES 305:2000 for standard keyseated shafting are based on a safe shear stress of approximately', 'single_choice', 'medium', 'The tables for standard keyseated shafting (Tables 2 to 4) use a safe shear stress of approximately 41.369 MPa (6,000 psi).', NULL, NULL, 'draft', false, NULL, true, 'PAES 305:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '68.948 MPa', false, 0),
      (v_question_id, '41.369 MPa', true, 1),
      (v_question_id, '10.342 MPa', false, 2),
      (v_question_id, '393 MPa', false, 3);
  END IF;

  -- 3. Safe shear stress for other materials
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For a shaft material that is not covered by the power-rating tables, PAES 305:2000 allows the safe shear stress to be taken as one-tenth of the nominal ultimate tensile strength. A shaft steel has a nominal ultimate tensile strength of 586 MPa. What safe shear stress should be used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For a shaft material that is not covered by the power-rating tables, PAES 305:2000 allows the safe shear stress to be taken as one-tenth of the nominal ultimate tensile strength. A shaft steel has a nominal ultimate tensile strength of 586 MPa. What safe shear stress should be used?', 'single_choice', 'easy', 'Given: ultimate tensile strength = 586 MPa; safe shear stress = 1/10 of ultimate tensile strength = 586 / 10 = 58.6 MPa.', NULL, NULL, 'draft', false, NULL, true, 'PAES 305:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '586 MPa', false, 0),
      (v_question_id, '117.2 MPa', false, 1),
      (v_question_id, '58.6 MPa', true, 2),
      (v_question_id, '293 MPa', false, 3);
  END IF;

  -- 4. Classes of keys
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 304:2000, keys for agricultural machines are classified into which three classes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 304:2000, keys for agricultural machines are classified into which three classes?', 'single_choice', 'easy', 'The standard classifies keys as parallel keys (longitudinal sides parallel), taper keys (tapered longitudinal section) and Woodruff keys (semi-circular cross-section).', NULL, NULL, 'draft', false, NULL, true, 'PAES 304:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sliding keys, fastening keys and gib-head keys', false, 0),
      (v_question_id, 'Parallel keys, taper keys and Woodruff keys', true, 1),
      (v_question_id, 'Flat keys, saddle keys and pin keys', false, 2),
      (v_question_id, 'Square keys, round keys and spline keys', false, 3);
  END IF;

  -- 5. Key material
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 304:2000 specifies that keys are made of AISI 1020 steel in the annealed condition with a tensile strength of 393 MPa. What additional requirement does the standard place on the shearing strength of the key?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 304:2000 specifies that keys are made of AISI 1020 steel in the annealed condition with a tensile strength of 393 MPa. What additional requirement does the standard place on the shearing strength of the key?', 'single_choice', 'medium', 'The key must have a lower shearing strength than the shaft and hub material, so that it fails first and protects the more costly shaft and hub.', NULL, NULL, 'draft', false, NULL, true, 'PAES 304:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'No limit is placed on its shearing strength', false, 0),
      (v_question_id, 'It must equal the shearing strength of the shaft only', false, 1),
      (v_question_id, 'It must be at least twice the shearing strength of the hub', false, 2),
      (v_question_id, 'It must have a lower shearing strength than the shaft and hub material', true, 3);
  END IF;

  -- 6. Assembly of shaft and hub allowing sliding
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which key can be used in the sliding type of shaft-and-hub assembly, where the hub can slide relative to the shaft in the axial direction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which key can be used in the sliding type of shaft-and-hub assembly, where the hub can slide relative to the shaft in the axial direction?', 'single_choice', 'medium', 'The sliding (normal) type of assembly uses a parallel key only. Fastening types may use parallel, taper or Woodruff keys.', NULL, NULL, 'draft', false, NULL, true, 'PAES 304:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Parallel key', true, 0),
      (v_question_id, 'Tapered key without gib head', false, 1),
      (v_question_id, 'Woodruff key', false, 2),
      (v_question_id, 'Tapered key with gib head', false, 3);
  END IF;

  -- 7. V-belt service factor for sickle bars
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A split-phase motor with a nameplate rating of 2,000 W drives the sickle bar (with counterweight) of a harvester through a V-belt drive. Using the service factor of 1.3 for cutting with a counterweighted sickle bar, what is the design power of the drive?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A split-phase motor with a nameplate rating of 2,000 W drives the sickle bar (with counterweight) of a harvester through a V-belt drive. Using the service factor of 1.3 for cutting with a counterweighted sickle bar, what is the design power of the drive?', 'single_choice', 'easy', 'Given: rated power = 2,000 W; service factor = 1.3. Design power = 1.3 x 2,000 W = 2,600 W.', NULL, NULL, 'draft', false, NULL, true, 'PAES 301:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3,000 W', false, 0),
      (v_question_id, '2,000 W', false, 1),
      (v_question_id, '1,538 W', false, 2),
      (v_question_id, '2,600 W', true, 3);
  END IF;

  -- 8. V-belt length calculation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A V-belt drive has a large pulley of 280 mm pitch diameter and a small pulley of 188 mm pitch diameter. The center distance is tentatively set at 1,000 mm. Using the approximate belt-length formula L = 2C + 1.57(DL + DS) + (DL - DS)^2 / (4C), what is the approximate belt length?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A V-belt drive has a large pulley of 280 mm pitch diameter and a small pulley of 188 mm pitch diameter. The center distance is tentatively set at 1,000 mm. Using the approximate belt-length formula L = 2C + 1.57(DL + DS) + (DL - DS)^2 / (4C), what is the approximate belt length?', 'single_choice', 'medium', 'Given: C = 1,000 mm; DL = 280 mm; DS = 188 mm. L = 2(1,000) + 1.57(280 + 188) + (280 - 188)^2 / (4 x 1,000) = 2,000 + 734.8 + 2.1 = about 2,737 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 301:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3,203 mm', false, 0),
      (v_question_id, '2,468 mm', false, 1),
      (v_question_id, '2,737 mm', true, 2),
      (v_question_id, '2,735 mm', false, 3);
  END IF;

  -- 9. Arc of contact on small pulley
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The arc of contact on the small pulley of a V-belt drive is approximated by 180 - 60(DL - DS)/C degrees. For a large pulley of 280 mm, a small pulley of 188 mm and a center distance of 1,000 mm, what is the arc of contact?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The arc of contact on the small pulley of a V-belt drive is approximated by 180 - 60(DL - DS)/C degrees. For a large pulley of 280 mm, a small pulley of 188 mm and a center distance of 1,000 mm, what is the arc of contact?', 'single_choice', 'medium', 'Given: DL = 280 mm; DS = 188 mm; C = 1,000 mm. Arc = 180 - 60(280 - 188)/1,000 = 180 - 5.52 = 174.5 degrees.', NULL, NULL, 'draft', false, NULL, true, 'PAES 301:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '185.5 degrees', false, 0),
      (v_question_id, '174.5 degrees', true, 1),
      (v_question_id, '179.9 degrees', false, 2),
      (v_question_id, '168.0 degrees', false, 3);
  END IF;

  -- 10. Small pulley diameter from speed ratio
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A 280 mm pitch-diameter driven (large) pulley is to run at 1,175 rpm. The driving (small) pulley turns at 1,750 rpm. What pitch diameter must the small pulley have, ignoring slip and creep?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A 280 mm pitch-diameter driven (large) pulley is to run at 1,175 rpm. The driving (small) pulley turns at 1,750 rpm. What pitch diameter must the small pulley have, ignoring slip and creep?', 'single_choice', 'medium', 'Given: DL = 280 mm; nL = 1,175 rpm; nS = 1,750 rpm. Pulley diameters are inversely proportional to speeds: DS = DL x nL / nS = 280 x 1,175 / 1,750 = 188 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 301:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '131 mm', false, 0),
      (v_question_id, '188 mm', true, 1),
      (v_question_id, '417 mm', false, 2),
      (v_question_id, '280 mm', false, 3);
  END IF;

  -- 11. Number of belts for multiple drive
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A V-belt drive must have a power capacity of 9,685 W. After the arc-of-contact and belt-length corrections are applied, the corrected power rating of one belt of the selected section is 2,400 W. How many belts are needed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A V-belt drive must have a power capacity of 9,685 W. After the arc-of-contact and belt-length corrections are applied, the corrected power rating of one belt of the selected section is 2,400 W. How many belts are needed?', 'single_choice', 'medium', 'Given: design power = 9,685 W; corrected rating per belt = 2,400 W. Number of belts = 9,685 / 2,400 = 4.04, which must be rounded up to 5 belts.', NULL, NULL, 'draft', false, NULL, true, 'PAES 301:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4 belts', false, 0),
      (v_question_id, '3 belts', false, 1),
      (v_question_id, '5 belts', true, 2),
      (v_question_id, '6 belts', false, 3);
  END IF;

  -- 12. Belt length and life
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Why is a belt-length correction factor applied in the design of V-belt drives?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Why is a belt-length correction factor applied in the design of V-belt drives?', 'single_choice', 'medium', 'Short belts are subjected to the action of load a greater number of times, so their hours of life are less than those of long belts. A belt-length correction factor is applied to arrive at a proper design.', NULL, NULL, 'draft', false, NULL, true, 'PAES 301:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Because short belts pass through the load more often, so their service life is shorter than that of long belts', true, 0),
      (v_question_id, 'Because the standard lengths are all multiples of the pitch diameter', false, 1),
      (v_question_id, 'Because short belts always have a smaller arc of contact', false, 2),
      (v_question_id, 'Because long belts stretch more and need extra capacity', false, 3);
  END IF;

  -- 13. Backlash
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In gear terminology, backlash is defined as the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In gear terminology, backlash is defined as the', 'single_choice', 'medium', 'Backlash is the tooth space minus the tooth thickness measured along the pitch circle; it is the clearance that allows meshing gears to run without binding.', NULL, NULL, 'draft', false, NULL, true, 'PAES 306:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'radial distance between the addendum circle and the dedendum circle', false, 0),
      (v_question_id, 'arc length of the pitch circle between two consecutive corresponding profiles', false, 1),
      (v_question_id, 'dedendum minus the addendum of the mating gear', false, 2),
      (v_question_id, 'tooth space minus the tooth thickness', true, 3);
  END IF;

  -- 14. Spur gear pitch and outside diameter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A standard spur gear has 24 teeth and a module of 3 mm. What are its pitch diameter and outside diameter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A standard spur gear has 24 teeth and a module of 3 mm. What are its pitch diameter and outside diameter?', 'single_choice', 'easy', 'Given: N = 24 teeth; module m = 3 mm. Pitch diameter = N x m = 24 x 3 = 72 mm. Addendum = module = 3 mm, so outside diameter = pitch diameter + 2 addendums = 72 + 6 = 78 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 306:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PD = 78 mm; OD = 84 mm', false, 0),
      (v_question_id, 'PD = 72 mm; OD = 75 mm', false, 1),
      (v_question_id, 'PD = 72 mm; OD = 78 mm', true, 2),
      (v_question_id, 'PD = 72 mm; OD = 80.5 mm', false, 3);
  END IF;

  -- 15. Spur gear center distance
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two standard spur gears of module 2.5 mm mesh. The driver has 20 teeth and the driven gear has 50 teeth. What is the center distance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two standard spur gears of module 2.5 mm mesh. The driver has 20 teeth and the driven gear has 50 teeth. What is the center distance?', 'single_choice', 'easy', 'Given: m = 2.5 mm; t1 = 20; t2 = 50. Center distance = m(t1 + t2)/2 = 2.5(20 + 50)/2 = 87.5 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 306:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '70 mm', false, 0),
      (v_question_id, '175 mm', false, 1),
      (v_question_id, '62.5 mm', false, 2),
      (v_question_id, '87.5 mm', true, 3);
  END IF;

  -- 16. Spur gear service factor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In selecting a spur gear drive, the total service factor is the sum of the service factor for load and the service factor for lubrication. A drive transmits 3,000 W with a load service factor of 1.0 and grease lubrication, for which the lubrication service factor is 0.4. What is the design power?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In selecting a spur gear drive, the total service factor is the sum of the service factor for load and the service factor for lubrication. A drive transmits 3,000 W with a load service factor of 1.0 and grease lubrication, for which the lubrication service factor is 0.4. What is the design power?', 'single_choice', 'medium', 'Given: power = 3,000 W; load factor = 1.0; grease lubrication factor = 0.4. Service factor = 1.0 + 0.4 = 1.4. Design power = 3,000 x 1.4 = 4,200 W.', NULL, NULL, 'draft', false, NULL, true, 'PAES 306:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '4,500 W', false, 0),
      (v_question_id, '4,200 W', true, 1),
      (v_question_id, '3,000 W', false, 2),
      (v_question_id, '3,600 W', false, 3);
  END IF;

  -- 17. Hunting tooth gear pair
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hunting tooth gear ratio is desired so that wear is distributed evenly. Following PAES 306:2000, in which the pair of meshing gears has no common divisor and the sum of the teeth is a prime number, which pair of tooth counts should be used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A hunting tooth gear ratio is desired so that wear is distributed evenly. Following PAES 306:2000, in which the pair of meshing gears has no common divisor and the sum of the teeth is a prime number, which pair of tooth counts should be used?', 'single_choice', 'hard', 'Hunting tooth ratios require that the teeth of the pair have no common divisor and that their sum be a prime number. 17 + 36 = 53, which is prime, and 17 and 36 share no common divisor. The other pairs sum to 54, 50 and 60, which are not prime.', NULL, NULL, 'draft', false, NULL, true, 'PAES 306:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '17 and 36 teeth', true, 0),
      (v_question_id, '18 and 36 teeth', false, 1),
      (v_question_id, '24 and 36 teeth', false, 2),
      (v_question_id, '20 and 30 teeth', false, 3);
  END IF;

  -- 18. Normal circular pitch
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A helical gear has a circular pitch of 12 mm and a helix angle of 30 degrees. What is its normal circular pitch, given that normal circular pitch is the product of the circular pitch and the cosine of the helix angle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A helical gear has a circular pitch of 12 mm and a helix angle of 30 degrees. What is its normal circular pitch, given that normal circular pitch is the product of the circular pitch and the cosine of the helix angle?', 'single_choice', 'medium', 'Given: circular pitch = 12 mm; helix angle = 30 degrees. Normal circular pitch = 12 x cos 30 = 12 x 0.866 = 10.39 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 307:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12.00 mm', false, 0),
      (v_question_id, '13.86 mm', false, 1),
      (v_question_id, '6.00 mm', false, 2),
      (v_question_id, '10.39 mm', true, 3);
  END IF;

  -- 19. Helical gear pitch diameter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A helical gear has 30 teeth, a normal module of 3 mm and a helix angle of 30 degrees. Using pitch diameter = number of teeth x normal module / cos(helix angle), what is its pitch diameter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A helical gear has 30 teeth, a normal module of 3 mm and a helix angle of 30 degrees. Using pitch diameter = number of teeth x normal module / cos(helix angle), what is its pitch diameter?', 'single_choice', 'medium', 'Given: N = 30; normal module = 3 mm; helix angle = 30 degrees. PD = 30 x 3 / cos 30 = 90 / 0.866 = 103.9 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 307:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '103.9 mm', true, 0),
      (v_question_id, '77.9 mm', false, 1),
      (v_question_id, '120.0 mm', false, 2),
      (v_question_id, '90.0 mm', false, 3);
  END IF;

  -- 20. Helix angle and power rating
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 307:2001, how does the power rating of 30-degree helical gears compare with 45-degree helical gears, and for what are the 45-degree gears used?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 307:2001, how does the power rating of 30-degree helical gears compare with 45-degree helical gears, and for what are the 45-degree gears used?', 'single_choice', 'hard', 'Helical gears with a 30-degree helix angle have a higher power rating than 45-degree gears. The 45-degree gears can operate at 90 degrees but their power is limited, so they are used for transmission of motion only.', NULL, NULL, 'draft', false, NULL, true, 'PAES 307:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '30-degree gears have the higher rating; 45-degree gears transmit motion only', true, 0),
      (v_question_id, '45-degree gears have the higher rating and are used for heavy power transmission', false, 1),
      (v_question_id, 'Both have equal ratings; 45-degree gears are used for linear motion only', false, 2),
      (v_question_id, '30-degree gears have the lower rating and are used only in parallel shafts', false, 3);
  END IF;

  -- 21. Miter gears
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which pair of gears is called miter gears?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which pair of gears is called miter gears?', 'single_choice', 'medium', 'Miter gears are bevel gears with equal numbers of teeth in the driver and driven gear that operate on axes at right angles.', NULL, NULL, 'draft', false, NULL, true, 'PAES 308:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Helical gears with 45-degree helix angle on parallel shafts', false, 0),
      (v_question_id, 'Spur gears of equal pitch that run on parallel shafts', false, 1),
      (v_question_id, 'Bevel gears with equal numbers of teeth on axes at right angles', true, 2),
      (v_question_id, 'Bevel gears with a 2:1 ratio on axes at right angles', false, 3);
  END IF;

  -- 22. Pitch angle of bevel pinion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A straight bevel pinion with 20 teeth meshes with a gear of 40 teeth on shafts at 90 degrees. Using pitch angle of pinion = arctan(t1 / t2), what is the pitch angle of the pinion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A straight bevel pinion with 20 teeth meshes with a gear of 40 teeth on shafts at 90 degrees. Using pitch angle of pinion = arctan(t1 / t2), what is the pitch angle of the pinion?', 'single_choice', 'hard', 'Given: t1 = 20; t2 = 40. Pitch angle = arctan(20/40) = arctan(0.5) = 26.57 degrees. The gear pitch angle is 63.43 degrees, so that the two add to the 90-degree shaft angle.', NULL, NULL, 'draft', false, NULL, true, 'PAES 308:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '45.00 degrees', false, 0),
      (v_question_id, '26.57 degrees', true, 1),
      (v_question_id, '30.00 degrees', false, 2),
      (v_question_id, '63.43 degrees', false, 3);
  END IF;

  -- 23. Bevel bearing spacing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 308:2001 states that the space between the bearings of a straddle-mounted or overhung-mounted bevel gear should never be less than what fraction of the pitch diameter of the gear?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 308:2001 states that the space between the bearings of a straddle-mounted or overhung-mounted bevel gear should never be less than what fraction of the pitch diameter of the gear?', 'single_choice', 'hard', 'The space between bearings should never be less than 70 percent of the pitch diameter of the gear. For overhung mounting, the spread should also be at least 2 1/2 times the overhang.', NULL, NULL, 'draft', false, NULL, true, 'PAES 308:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 percent', false, 0),
      (v_question_id, '50 percent', false, 1),
      (v_question_id, '70 percent', true, 2),
      (v_question_id, '100 percent', false, 3);
  END IF;

  -- 24. Roller chain number pitch
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the standard roller chain numbering system of PAES 303:2000, the left-hand figures of the chain number denote the number of 1/8 inch (3.175 mm) units in the pitch. What is the pitch of roller chain No. 40?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the standard roller chain numbering system of PAES 303:2000, the left-hand figures of the chain number denote the number of 1/8 inch (3.175 mm) units in the pitch. What is the pitch of roller chain No. 40?', 'single_choice', 'medium', 'Given: chain No. 40, whose left-hand figure is 4, meaning 4 units of 1/8 inch (3.175 mm) in the pitch. Pitch = 4 x 3.175 = 12.7 mm (1/2 inch).', NULL, NULL, 'draft', false, NULL, true, 'PAES 303:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25.4 mm', false, 0),
      (v_question_id, '15.875 mm', false, 1),
      (v_question_id, '9.525 mm', false, 2),
      (v_question_id, '12.7 mm', true, 3);
  END IF;

  -- 25. Sprocket center distance rule
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As a general rule under PAES 303:2000, the center-to-center distance between roller chain sprockets should be';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As a general rule under PAES 303:2000, the center-to-center distance between roller chain sprockets should be', 'single_choice', 'medium', 'The center distance should not be less than 1.5 times the diameter of the larger sprocket and not less than thirty times the pitch nor more than 50 times the pitch. A center distance of 80 pitches may be considered an approved maximum in certain cases.', NULL, NULL, 'draft', false, NULL, true, 'PAES 303:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'between 30 and 50 pitches, and not less than 1.5 times the larger sprocket diameter', true, 0),
      (v_question_id, 'at least 150 pitches', false, 1),
      (v_question_id, 'between 5 and 10 pitches', false, 2),
      (v_question_id, 'exactly equal to the diameter of the larger sprocket', false, 3);
  END IF;

  -- 26. Chain length in pitches
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A roller chain drive has a large sprocket of 40 teeth and a small sprocket of 20 teeth. The center distance is 40 pitches. Using L = 2C + (N + n)/2 + ((N - n)/(2 x pi))^2 / C, with L and C in pitches, what is the calculated chain length in pitches?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A roller chain drive has a large sprocket of 40 teeth and a small sprocket of 20 teeth. The center distance is 40 pitches. Using L = 2C + (N + n)/2 + ((N - n)/(2 x pi))^2 / C, with L and C in pitches, what is the calculated chain length in pitches?', 'single_choice', 'hard', 'Given: N = 40; n = 20; C = 40 pitches. L = 2(40) + (40 + 20)/2 + ((40 - 20)/6.2832)^2 / 40 = 80 + 30 + (3.183)^2/40 = 80 + 30 + 0.253 = 110.25 pitches.', NULL, NULL, 'draft', false, NULL, true, 'PAES 303:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '115.00 pitches', false, 0),
      (v_question_id, '110.25 pitches', true, 1),
      (v_question_id, '100.25 pitches', false, 2),
      (v_question_id, '120.25 pitches', false, 3);
  END IF;

  -- 27. Chain design power
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A roller chain drive must transmit 4,000 W with a service factor of 1.4. A double-strand chain with a multiple-strand factor of 1.7 is used. Using design power = power x service factor / multiple-strand factor, what design power should be used to select the chain from the single-strand power rating tables?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A roller chain drive must transmit 4,000 W with a service factor of 1.4. A double-strand chain with a multiple-strand factor of 1.7 is used. Using design power = power x service factor / multiple-strand factor, what design power should be used to select the chain from the single-strand power rating tables?', 'single_choice', 'hard', 'Given: power = 4,000 W; service factor = 1.4; multiple-strand factor = 1.7. Design power = 4,000 x 1.4 / 1.7 = 3,294 W.', NULL, NULL, 'draft', false, NULL, true, 'PAES 303:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2,857 W', false, 0),
      (v_question_id, '5,600 W', false, 1),
      (v_question_id, '3,294 W', true, 2),
      (v_question_id, '9,520 W', false, 3);
  END IF;

  -- 28. Rated bearing life
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The rated life of an anti-friction bearing is defined as the number of revolutions or hours at a given constant speed that';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The rated life of an anti-friction bearing is defined as the number of revolutions or hours at a given constant speed that', 'single_choice', 'medium', 'Rated life is the number of revolutions or hours at constant speed that 90 percent of an apparently identical group of bearings will complete or exceed before the first evidence of fatigue develops.', NULL, NULL, 'draft', false, NULL, true, 'PAES 309:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '10 percent of a group will complete before the first fatigue sign', false, 0),
      (v_question_id, 'half of a group of identical bearings will complete before failing', false, 1),
      (v_question_id, 'every bearing in a group will complete without any wear', false, 2),
      (v_question_id, '90 percent of an apparently identical group will complete or exceed before the first evidence of fatigue', true, 3);
  END IF;

  -- 29. Bearing bore code
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the anti-friction bearing designation of PAES 309:2001, the last two digits form the bore code. For bores from 20 to 480 mm, the bore code equals the bore diameter divided by 5. A roller bearing is designated NU 2312. What is its bore diameter?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the anti-friction bearing designation of PAES 309:2001, the last two digits form the bore code. For bores from 20 to 480 mm, the bore code equals the bore diameter divided by 5. A roller bearing is designated NU 2312. What is its bore diameter?', 'single_choice', 'medium', 'Given: bore code = 12; bore diameter = bore code x 5 = 12 x 5 = 60 mm.', NULL, NULL, 'draft', false, NULL, true, 'PAES 309:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '12 mm', false, 0),
      (v_question_id, '60 mm', true, 1),
      (v_question_id, '24 mm', false, 2),
      (v_question_id, '120 mm', false, 3);
  END IF;

  -- 30. Needle bearing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which bearing has rolling elements whose length is at least 4 times their diameter, is most useful where space is limited, and cannot support thrust loads?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which bearing has rolling elements whose length is at least 4 times their diameter, is most useful where space is limited, and cannot support thrust loads?', 'single_choice', 'medium', 'Needle bearings have rollers whose length is at least 4 times their diameter. They are useful where space is a factor and cannot support thrust loads.', NULL, NULL, 'draft', false, NULL, true, 'PAES 309:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Needle bearing', true, 0),
      (v_question_id, 'Spherical roller bearing', false, 1),
      (v_question_id, 'Tapered roller bearing', false, 2),
      (v_question_id, 'Deep-groove ball bearing', false, 3);
  END IF;

  -- 31. Tapered roller bearing use
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which anti-friction bearing is used for heavy radial and thrust loads and can be adjusted for a preload where maximum system rigidity is required?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which anti-friction bearing is used for heavy radial and thrust loads and can be adjusted for a preload where maximum system rigidity is required?', 'single_choice', 'medium', 'Tapered roller bearings carry heavy radial and thrust loads, and all elements of the rolling surface and raceways intersect at a common point on the axis, giving true rolling. They can be adjusted for a preload when maximum rigidity is required.', NULL, NULL, 'draft', false, NULL, true, 'PAES 309:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Tapered roller bearing', true, 0),
      (v_question_id, 'Cylindrical roller bearing', false, 1),
      (v_question_id, 'Needle bearing', false, 2),
      (v_question_id, 'Ball bushing', false, 3);
  END IF;

  -- 32. Hydrodynamic versus hydrostatic bearing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What distinguishes a hydrostatic journal bearing from a hydrodynamic one?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What distinguishes a hydrostatic journal bearing from a hydrodynamic one?', 'single_choice', 'medium', 'In a hydrostatic bearing the load is carried by fluid pressure generated outside the bearing, so it works even when the shaft is not rotating. In a hydrodynamic bearing the film pressure is self-generated by the bearing through viscosity, adhesion and the shape of the surfaces.', NULL, NULL, 'draft', false, NULL, true, 'PAES 310:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It operates without any fluid or lubricant', false, 0),
      (v_question_id, 'The load is carried by fluid pressure supplied from outside, so it works even when there is no relative motion', true, 1),
      (v_question_id, 'The pressure is generated only by the viscosity of the lubricant and shaft rotation', false, 2),
      (v_question_id, 'It uses rolling elements to separate the surfaces', false, 3);
  END IF;

  -- 33. PV factor computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A journal bearing carries a bearing pressure of 3.0 MPa at a sliding velocity of 1.5 m/s. What is its PV factor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A journal bearing carries a bearing pressure of 3.0 MPa at a sliding velocity of 1.5 m/s. What is its PV factor?', 'single_choice', 'easy', 'Given: P = 3.0 MPa; V = 1.5 m/s. PV = P x V = 3.0 x 1.5 = 4.5 MPa-m/s.', NULL, NULL, 'draft', false, NULL, true, 'PAES 310:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9.0 MPa-m/s', false, 0),
      (v_question_id, '2.0 MPa-m/s', false, 1),
      (v_question_id, '0.5 MPa-m/s', false, 2),
      (v_question_id, '4.5 MPa-m/s', true, 3);
  END IF;

  -- 34. Metric bolt grade yield strength
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 311:2001 designates metric bolt grades as xx.x, where xx is approximately one-hundredth of the minimum tensile strength in N/mm2 and .x is the ratio of minimum yield strength to minimum tensile strength. What is the minimum yield strength of a grade 8.8 bolt?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 311:2001 designates metric bolt grades as xx.x, where xx is approximately one-hundredth of the minimum tensile strength in N/mm2 and .x is the ratio of minimum yield strength to minimum tensile strength. What is the minimum yield strength of a grade 8.8 bolt?', 'single_choice', 'medium', 'Given: grade 8.8. Minimum tensile strength = 8 x 100 = 800 N/mm2 (consistent with the standard table value of 800). Yield ratio = 0.8. Minimum yield strength = 0.8 x 800 = 640 N/mm2.', NULL, NULL, 'draft', false, NULL, true, 'PAES 311:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '88 N/mm2', false, 0),
      (v_question_id, '800 N/mm2', false, 1),
      (v_question_id, '640 N/mm2', true, 2),
      (v_question_id, '704 N/mm2', false, 3);
  END IF;

  -- 35. Fine versus coarse thread
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 311:2001, when should the fine thread series be used instead of the coarse series?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 311:2001, when should the fine thread series be used instead of the coarse series?', 'single_choice', 'medium', 'Fine threads should be used where jar and vibration that tend to loosen the nut are present, such as in a thresher. Coarse threads are for general use, frequent disassembly and tapped holes in metals other than steel. Fine threads are not recommended for brittle materials.', NULL, NULL, 'draft', false, NULL, true, 'PAES 311:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Where tapped holes are in soft metals other than steel', false, 0),
      (v_question_id, 'Where parts are frequently disassembled', false, 1),
      (v_question_id, 'Where the bolt is made of a brittle material', false, 2),
      (v_question_id, 'Where jar and vibration tending to loosen the nut are present, as in a thresher', true, 3);
  END IF;

  -- 36. Left-hand thread use
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 311:2001 requires that left-hand threads be used on a fastener for a rotating member when';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 311:2001 requires that left-hand threads be used on a fastener for a rotating member when', 'single_choice', 'hard', 'Right-hand thread is used in almost all fastening applications. Left-hand thread is used for rotating members such that the thread winds in the opposite direction to the rotating member, for example impeller shafts of pumps and the shaft of a rice mill.', NULL, NULL, 'draft', false, NULL, true, 'PAES 311:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'the thread winds in the direction opposite to the rotation of the member, such as an impeller shaft', true, 0),
      (v_question_id, 'the bolt is made of stainless steel', false, 1),
      (v_question_id, 'a close-clearance hole is specified', false, 2),
      (v_question_id, 'the nut is a hexagonal flange nut', false, 3);
  END IF;

  -- 37. Hexagonal flange nut purpose
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the specific use of a hexagonal flange nut according to PAES 311:2001?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the specific use of a hexagonal flange nut according to PAES 311:2001?', 'single_choice', 'medium', 'Hexagonal flange nuts increase the bearing area, distributing the fastener load over a larger area, particularly on soft materials such as aluminum.', NULL, NULL, 'draft', false, NULL, true, 'PAES 311:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'To accept a pin that locks the assembly', false, 0),
      (v_question_id, 'To allow assembly where the side of the head is not accessible to a wrench', false, 1),
      (v_question_id, 'To increase the bearing area and spread the fastener load, particularly on soft materials such as aluminum', true, 2),
      (v_question_id, 'To give a smooth surface for aesthetic purposes', false, 3);
  END IF;

  -- 38. Rivet joint terms
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In riveted joints, the distance from the edge of the plate to the centerline of the nearest row of rivets is called the';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In riveted joints, the distance from the edge of the plate to the centerline of the nearest row of rivets is called the', 'single_choice', 'medium', 'Margin is the distance from the edge of the plate to the centerline of the nearest row of rivets. Pitch is the spacing between rivet centers.', NULL, NULL, 'draft', false, NULL, true, 'PAES 312:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'clinch allowance', false, 0),
      (v_question_id, 'margin', true, 1),
      (v_question_id, 'grip', false, 2),
      (v_question_id, 'pitch', false, 3);
  END IF;

  -- 39. Lap joint versus butt joint
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which description correctly identifies a riveted butt joint?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which description correctly identifies a riveted butt joint?', 'single_choice', 'medium', 'In a butt joint the plates being joined lie in the same plane and are joined by a cover plate or butt strap riveted to both plates. In a lap joint the plates overlap each other.', NULL, NULL, 'draft', false, NULL, true, 'PAES 312:2001')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Plates are in the same plane and are joined by a cover plate or butt strap riveted to both', true, 0),
      (v_question_id, 'A single plate is bent over and riveted to itself', false, 1),
      (v_question_id, 'Plates are joined by threads cut into both edges', false, 2),
      (v_question_id, 'Plates overlap and are held by one or more rows of rivets', false, 3);
  END IF;

  -- 40. Clutch versus coupling
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the difference between a clutch and a coupling in PAES 318:2002?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the difference between a clutch and a coupling in PAES 318:2002?', 'single_choice', 'easy', 'Couplings join lengths of shafting. Clutches are couplings that permit the disengagement of the coupled shafts during rotation.', NULL, NULL, 'draft', false, NULL, true, 'PAES 318:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A clutch is a coupling that permits disengagement of the coupled shafts during rotation', true, 0),
      (v_question_id, 'A clutch joins shafts permanently, while a coupling allows disengagement', false, 1),
      (v_question_id, 'A clutch transmits power from a shaft to a hub, while a coupling does not', false, 2),
      (v_question_id, 'There is no difference; the terms are interchangeable', false, 3);
  END IF;

  -- 41. Jaw clutch types
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In positive jaw clutches, which jaw form is used for unidirectional drive and which for driving in either direction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In positive jaw clutches, which jaw form is used for unidirectional drive and which for driving in either direction?', 'single_choice', 'medium', 'Positive jaw clutches transmit torque without slip. Square jaws are made for driving in either direction, while spiral jaws are for unidirectional drive.', NULL, NULL, 'draft', false, NULL, true, 'PAES 318:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Both forms are for either direction only', false, 0),
      (v_question_id, 'Both forms are for unidirectional drive only', false, 1),
      (v_question_id, 'Square jaws for unidirectional drive; spiral jaws for either direction', false, 2),
      (v_question_id, 'Spiral jaws for unidirectional drive; square jaws for either direction', true, 3);
  END IF;

  -- 42. Coupling for large misalignment
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which coupling does PAES 318:2002 describe as able to connect shafts with much larger misalignment than the other flexible couplings can tolerate?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which coupling does PAES 318:2002 describe as able to connect shafts with much larger misalignment than the other flexible couplings can tolerate?', 'single_choice', 'medium', 'Universal joints are used to connect shafts with much larger values of misalignment than can be tolerated by the other types of flexible couplings.', NULL, NULL, 'draft', false, NULL, true, 'PAES 318:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Clamp shaft coupling', false, 0),
      (v_question_id, 'Rubber-flexible coupling', false, 1),
      (v_question_id, 'Flange face coupling', false, 2),
      (v_question_id, 'Universal joint', true, 3);
  END IF;

  -- 43. Rubber-bushed coupling advantage
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which flexible coupling is especially suited to damping shock and momentary overload, allows free axial movement for motor end play, and affords electrical insulation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which flexible coupling is especially suited to damping shock and momentary overload, allows free axial movement for motor end play, and affords electrical insulation?', 'single_choice', 'hard', 'The rubber-bushed coupling cushions through steel pins sliding in rubber-cushioned bronze bushings. It allows free axial movement, damps shock and overload and gives electrical insulation, preventing electrolysis in direct motor-driven pumps.', NULL, NULL, 'draft', false, NULL, true, 'PAES 318:2002')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gear-type coupling', false, 0),
      (v_question_id, 'Oldham coupling', false, 1),
      (v_question_id, 'Rubber-bushed coupling', true, 2),
      (v_question_id, 'Clamp shaft coupling', false, 3);
  END IF;

END $$;
