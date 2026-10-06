-- Mathematics and Basic Engineering Sciences quiz batch (26 questions, 1 topic). Every
-- problem, formula, and worked answer is drawn from a review-material solved
-- problem set on applied mathematics (algebra, progressions, work/mixture/
-- motion/variation problems, probability and counting, plane and analytic
-- geometry, differential and integral calculus) read in full on 2026-10-02.
-- Every numeric answer was re-derived independently against the shown
-- worked solution before being used here; items whose printed solution was
-- inconsistent, ambiguous, or had more than one valid answer were skipped.
-- No invented facts.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since these are general applied-mathematics review problems, not PAES
-- standard clauses.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Mathematics and Basic Engineering Sciences (MATH_BASIC_ENGG) — 26 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'MATH_BASIC_ENGG';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: MATH_BASIC_ENGG';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Mathematics and Basic Engineering Sciences' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Mathematics and Basic Engineering Sciences';
  END IF;

  -- 1. Distance between foci of an ellipse
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The length of the major and minor axes of an ellipse are 10 m and 8 m, respectively. Find the distance between the foci.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The length of the major and minor axes of an ellipse are 10 m and 8 m, respectively. Find the distance between the foci.', 'single_choice', 'easy', 'Major axis 2a = 10, so a = 5; minor axis 2b = 8, so b = 4. c = sqrt(a² − b²) = sqrt(25 − 16) = 3, and the distance between the foci is 2c = 2(3) = 6 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '3 m', false, 0),
      (v_question_id, '6 m', true, 1),
      (v_question_id, '8 m', false, 2),
      (v_question_id, '10 m', false, 3);
  END IF;

  -- 2. Distance from point to line
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the distance from the point (2, 1) to the line 4x − 3y + 5 = 0.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Find the distance from the point (2, 1) to the line 4x − 3y + 5 = 0.', 'single_choice', 'easy', 'd = |Ax1 + By1 + C| / sqrt(A² + B²) = |4(2) − 3(1) + 5| / sqrt(4² + (−3)²) = 10 / 5 = 2 units.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 unit', false, 0),
      (v_question_id, '2 units', true, 1),
      (v_question_id, '3 units', false, 2),
      (v_question_id, '5 units', false, 3);
  END IF;

  -- 3. 30th term of an AP
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the 30th term of the arithmetic progression 4, 7, 10, ...';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Find the 30th term of the arithmetic progression 4, 7, 10, ...', 'single_choice', 'easy', 'The common difference is d = 3. a30 = a1 + 29d = 4 + 29(3) = 91.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '87', false, 0),
      (v_question_id, '88', false, 1),
      (v_question_id, '91', true, 2),
      (v_question_id, '94', false, 3);
  END IF;

  -- 4. Interior angle of a dodecagon
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Each interior angle of a regular dodecagon is equal to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Each interior angle of a regular dodecagon is equal to:', 'single_choice', 'easy', 'A dodecagon has 12 sides. Each interior angle = (n − 2)(180°) / n = (12 − 2)(180°) / 12 = 150°.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '135°', false, 0),
      (v_question_id, '144°', false, 1),
      (v_question_id, '150°', true, 2),
      (v_question_id, '165°', false, 3);
  END IF;

  -- 5. Mean proportional
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the mean proportional of 4 and 36?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the mean proportional of 4 and 36?', 'single_choice', 'easy', 'If 4 / x = x / 36, then x² = 4 × 36 = 144, so x = 12.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9', false, 0),
      (v_question_id, '12', true, 1),
      (v_question_id, '18', false, 2),
      (v_question_id, '20', false, 3);
  END IF;

  -- 6. Mean after removing two values
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The arithmetic mean of 80 numbers is 55. If two numbers, 250 and 850, are removed, what is the arithmetic mean of the remaining numbers?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The arithmetic mean of 80 numbers is 55. If two numbers, 250 and 850, are removed, what is the arithmetic mean of the remaining numbers?', 'single_choice', 'medium', 'Sum of the 80 numbers = 80 × 55 = 4,400. After removing 250 and 850 (total 1,100), the remaining sum is 3,300 for 78 numbers. New mean = 3,300 / 78 = 42.31.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '42.31', true, 0),
      (v_question_id, '44.00', false, 1),
      (v_question_id, '52.50', false, 2),
      (v_question_id, '55.00', false, 3);
  END IF;

  -- 7. Two numbers added to a set
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The arithmetic mean of 6 numbers is 17. If two more numbers are added, the new set of 8 numbers has an arithmetic mean of 19. What are the two added numbers if their difference is 4?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The arithmetic mean of 6 numbers is 17. If two more numbers are added, the new set of 8 numbers has an arithmetic mean of 19. What are the two added numbers if their difference is 4?', 'single_choice', 'medium', 'Sum of the original 6 numbers = 6 × 17 = 102. Let the added numbers be x and x + 4. Then (102 + x + x + 4) / 8 = 19, so 2x + 106 = 152 and x = 23. The numbers are 23 and 27.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '21 and 25', false, 0),
      (v_question_id, '22 and 26', false, 1),
      (v_question_id, '23 and 27', true, 2),
      (v_question_id, '24 and 28', false, 3);
  END IF;

  -- 8. Three pipes filling a tank
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A tank can be filled in 9 hours by one pipe and in 12 hours by a second pipe. It can be drained when full by a third pipe in 15 hours. How long will it take to fill the empty tank with all three pipes in operation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A tank can be filled in 9 hours by one pipe and in 12 hours by a second pipe. It can be drained when full by a third pipe in 15 hours. How long will it take to fill the empty tank with all three pipes in operation?', 'single_choice', 'medium', 'Combined rate = 1/9 + 1/12 − 1/15 = (20 + 15 − 12) / 180 = 23/180 of the tank per hour. Time = 180 / 23 = 7.826 hours (about 7 hours 50 minutes).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5.14 hours', false, 0),
      (v_question_id, '6.00 hours', false, 1),
      (v_question_id, '7.83 hours', true, 2),
      (v_question_id, '9.00 hours', false, 3);
  END IF;

  -- 9. Painters working then one leaves
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Glenn can paint a house in 9 hours while Stewart can paint the same house in 16 hours. They work together for 4 hours, then Stewart leaves and Glenn finishes the job alone. How many more hours does Glenn need to finish the job?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Glenn can paint a house in 9 hours while Stewart can paint the same house in 16 hours. They work together for 4 hours, then Stewart leaves and Glenn finishes the job alone. How many more hours does Glenn need to finish the job?', 'single_choice', 'medium', 'Work done together in 4 hours = 4(1/9 + 1/16) = 4(25/144) = 25/36 of the job. Remaining work = 1 − 25/36 = 11/36. Glenn''s rate is 1/9 per hour, so the time = (11/36) / (1/9) = 2.75 hours.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.50 hours', false, 0),
      (v_question_id, '2.75 hours', true, 1),
      (v_question_id, '4.00 hours', false, 2),
      (v_question_id, '6.75 hours', false, 3);
  END IF;

  -- 10. Salt solution mixture
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ten liters of 25% salt solution and 15 liters of 35% salt solution are poured into a drum originally containing 30 liters of 10% salt solution. What is the percent concentration of salt in the mixture?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Ten liters of 25% salt solution and 15 liters of 35% salt solution are poured into a drum originally containing 30 liters of 10% salt solution. What is the percent concentration of salt in the mixture?', 'single_choice', 'medium', 'Salt in mixture = 0.25(10) + 0.35(15) + 0.10(30) = 2.5 + 5.25 + 3 = 10.75 liters. Total volume = 10 + 15 + 30 = 55 liters. Concentration = 10.75 / 55 = 0.1955, or 19.55%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '15.00%', false, 0),
      (v_question_id, '19.55%', true, 1),
      (v_question_id, '23.33%', false, 2),
      (v_question_id, '30.00%', false, 3);
  END IF;

  -- 11. Boat in still water
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A boat travels downstream in 2/3 of the time it takes to travel the same distance upstream. If the velocity of the river current is 8 kph, determine the velocity of the boat in still water.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A boat travels downstream in 2/3 of the time it takes to travel the same distance upstream. If the velocity of the river current is 8 kph, determine the velocity of the boat in still water.', 'single_choice', 'medium', 'The distances are equal: (V − 8)t = (V + 8)(2/3)t. Then V − 8 = (2/3)V + 16/3, so V/3 = 40/3 and V = 40 kph.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 kph', false, 0),
      (v_question_id, '32 kph', false, 1),
      (v_question_id, '40 kph', true, 2),
      (v_question_id, '48 kph', false, 3);
  END IF;

  -- 12. Successive profit markups
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Jojo bought a second-hand VCR and sold it to Rudy at a profit of 40%. Rudy then sold it to Noel at a profit of 20%. If Noel paid P2,856 more than Jojo paid, how much did Jojo pay for the unit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Jojo bought a second-hand VCR and sold it to Rudy at a profit of 40%. Rudy then sold it to Noel at a profit of 20%. If Noel paid P2,856 more than Jojo paid, how much did Jojo pay for the unit?', 'single_choice', 'medium', 'Let x be Jojo''s cost. Rudy paid 1.4x and Noel paid 1.2(1.4x) = 1.68x. Then 1.68x = x + 2,856, so 0.68x = 2,856 and x = P4,200.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P2,856', false, 0),
      (v_question_id, 'P3,500', false, 1),
      (v_question_id, 'P4,200', true, 2),
      (v_question_id, 'P4,800', false, 3);
  END IF;

  -- 13. Number of terms for a given AP sum
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How many terms of the progression 3, 5, 7, ... must be taken so that their sum is 2,600?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How many terms of the progression 3, 5, 7, ... must be taken so that their sum is 2,600?', 'single_choice', 'medium', 'Here a1 = 3 and d = 2. S = (n/2)[2(3) + (n − 1)(2)] = (n/2)(2n + 4) = n² + 2n. Setting n² + 2n = 2,600 gives n = 50 terms.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '25 terms', false, 0),
      (v_question_id, '48 terms', false, 1),
      (v_question_id, '50 terms', true, 2),
      (v_question_id, '52 terms', false, 3);
  END IF;

  -- 14. 8th term of a geometric progression
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The fourth term of a geometric progression is 216 and the sixth term is 1,944. Find the eighth term.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The fourth term of a geometric progression is 216 and the sixth term is 1,944. Find the eighth term.', 'single_choice', 'medium', 'a6 / a4 = r² = 1,944 / 216 = 9, so r = 3. Then a1 = 216 / 3³ = 8 and a8 = a1·r⁷ = 8(3⁷) = 8(2,187) = 17,496.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5,832', false, 0),
      (v_question_id, '17,496', true, 1),
      (v_question_id, '52,488', false, 2),
      (v_question_id, '157,464', false, 3);
  END IF;

  -- 15. Alternate seating arrangement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In how many ways can 4 boys and 4 girls be seated alternately in a row of 8 seats?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In how many ways can 4 boys and 4 girls be seated alternately in a row of 8 seats?', 'single_choice', 'medium', 'The boys can be arranged in 4! ways and the girls in 4! ways, and either gender can start the row (2 patterns). Total = 2(4!)(4!) = 2(24)(24) = 1,152 ways.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '576 ways', false, 0),
      (v_question_id, '1,152 ways', true, 1),
      (v_question_id, '2,304 ways', false, 2),
      (v_question_id, '40,320 ways', false, 3);
  END IF;

  -- 16. At least one student gets a credit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The probability of getting a credit in an examination is 1/3. If three students are selected at random, what is the probability that at least one of them gets a credit?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The probability of getting a credit in an examination is 1/3. If three students are selected at random, what is the probability that at least one of them gets a credit?', 'single_choice', 'medium', 'P(at least one) = 1 − P(none) = 1 − (2/3)³ = 1 − 8/27 = 19/27. (Equivalently, 12/27 + 6/27 + 1/27 = 19/27 for exactly one, two, and three students.)', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8/27', false, 0),
      (v_question_id, '1/3', false, 1),
      (v_question_id, '19/27', true, 2),
      (v_question_id, '26/27', false, 3);
  END IF;

  -- 17. Inscribed circle radius of a triangle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The sides of a triangle are 8 cm, 10 cm and 14 cm. Determine the radius of the inscribed circle.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The sides of a triangle are 8 cm, 10 cm and 14 cm. Determine the radius of the inscribed circle.', 'single_choice', 'medium', 'Semi-perimeter s = (8 + 10 + 14) / 2 = 16 cm. By Heron''s formula, A = sqrt[16(16 − 8)(16 − 10)(16 − 14)] = sqrt(1,536) = 39.19 cm². Since A = r·s, r = 39.19 / 16 = 2.45 cm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.45 cm', true, 0),
      (v_question_id, '3.20 cm', false, 1),
      (v_question_id, '4.90 cm', false, 2),
      (v_question_id, '7.14 cm', false, 3);
  END IF;

  -- 18. Area between a parabola and a line
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the area of the region bounded by y² = 8x and y = 2x.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Find the area of the region bounded by y² = 8x and y = 2x.', 'single_choice', 'medium', 'Intersection: (2x)² = 8x gives x = 0 and x = 2. A = integral from 0 to 2 of (sqrt(8x) − 2x) dx = [(2·sqrt(2))(2/3)x^(3/2) − x²] from 0 to 2 = 16/3 − 4 = 4/3 square units.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2/3 sq unit', false, 0),
      (v_question_id, '4/3 sq units', true, 1),
      (v_question_id, '8/3 sq units', false, 2),
      (v_question_id, '16/3 sq units', false, 3);
  END IF;

  -- 19. Three painters with relative speeds
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Pedro can paint a fence 50% faster than Juan and 20% faster than Pilar. Together, the three can paint the fence in 4 hours. How long would it take Pedro to paint the same fence working alone?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Pedro can paint a fence 50% faster than Juan and 20% faster than Pilar. Together, the three can paint the fence in 4 hours. How long would it take Pedro to paint the same fence working alone?', 'single_choice', 'hard', 'Let Pedro''s rate be 1/A. Juan''s rate = (1/A)/1.5 = 0.6667(1/A) and Pilar''s rate = (1/A)/1.2 = 0.8333(1/A). Together: (1/A)(1 + 0.6667 + 0.8333) = 2.5/A = 1/4, so A = 10 hours.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '7.5 hours', false, 0),
      (v_question_id, '10 hours', true, 1),
      (v_question_id, '12 hours', false, 2),
      (v_question_id, '16 hours', false, 3);
  END IF;

  -- 20. Two planes with different ground speeds
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two planes leave Manila for a southern city 900 km away. Plane A travels at a ground speed 90 kph faster than plane B and arrives 2 hours and 15 minutes ahead of plane B. What is the ground speed of plane A?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two planes leave Manila for a southern city 900 km away. Plane A travels at a ground speed 90 kph faster than plane B and arrives 2 hours and 15 minutes ahead of plane B. What is the ground speed of plane A?', 'single_choice', 'hard', 'Let plane B''s speed be V. Then 900/V − 900/(V + 90) = 2.25. This simplifies to 2.25V² + 202.5V − 81,000 = 0, giving V = 150 kph for plane B. Plane A''s ground speed is 150 + 90 = 240 kph (check: 900/150 = 6 h and 900/240 = 3.75 h, a difference of 2.25 h).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '180 kph', false, 0),
      (v_question_id, '210 kph', false, 1),
      (v_question_id, '240 kph', true, 2),
      (v_question_id, '270 kph', false, 3);
  END IF;

  -- 21. Elevator motor size (variation)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The time required for an elevator to lift a weight varies directly with the weight and the distance through which it is lifted, and inversely with the power of the motor. If it takes 30 seconds for a 10-hp motor to lift 100 lb through 50 ft, what size of motor is required to lift 800 lb through 40 ft in 40 seconds?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The time required for an elevator to lift a weight varies directly with the weight and the distance through which it is lifted, and inversely with the power of the motor. If it takes 30 seconds for a 10-hp motor to lift 100 lb through 50 ft, what size of motor is required to lift 800 lb through 40 ft in 40 seconds?', 'single_choice', 'hard', 't = k·W·S / P. From the first case, k = P·t / (W·S) = (10)(30) / [(100)(50)] = 0.06. Then P = k·W·S / t = (0.06)(800)(40) / 40 = 48 hp.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '24 hp', false, 0),
      (v_question_id, '40 hp', false, 1),
      (v_question_id, '48 hp', true, 2),
      (v_question_id, '60 hp', false, 3);
  END IF;

  -- 22. 11th term of a harmonic progression
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The third term of a harmonic progression is 15 and the ninth term is 6. Find the 11th term.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The third term of a harmonic progression is 15 and the ninth term is 6. Find the 11th term.', 'single_choice', 'hard', 'The reciprocals form an arithmetic progression: a3 = 1/15 and a9 = 1/6. Then 6d = 1/6 − 1/15 = 1/10, so d = 1/60 and a1 = 1/15 − 2/60 = 1/30. a11 = 1/30 + 10/60 = 1/5, so the 11th term of the harmonic progression is 5.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1/5', false, 0),
      (v_question_id, '4', false, 1),
      (v_question_id, '5', true, 2),
      (v_question_id, '6', false, 3);
  END IF;

  -- 23. Air pump strokes (geometric progression)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'If one third of the air in a tank is removed by each stroke of an air pump, what fractional part of the total air is removed after 6 strokes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'If one third of the air in a tank is removed by each stroke of an air pump, what fractional part of the total air is removed after 6 strokes?', 'single_choice', 'hard', 'Each stroke leaves 2/3 of the air that was present, so the air left after 6 strokes is (2/3)⁶ = 64/729 of the original. The fraction removed is 1 − 64/729 = 665/729, or about 0.912.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '64/729', false, 0),
      (v_question_id, '2/3', false, 1),
      (v_question_id, '665/729', true, 2),
      (v_question_id, '728/729', false, 3);
  END IF;

  -- 24. At least two of three subjects passed
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a board examination, the probability that an examinee will pass each subject is 0.8. Assuming the subjects are independent, what is the probability that an examinee will pass at least two of the three subjects?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a board examination, the probability that an examinee will pass each subject is 0.8. Assuming the subjects are independent, what is the probability that an examinee will pass at least two of the three subjects?', 'single_choice', 'hard', 'P(exactly two) = 3C2(0.8)²(0.2) = 3(0.64)(0.2) = 0.384. P(all three) = (0.8)³ = 0.512. P(at least two) = 0.384 + 0.512 = 0.896, or 89.6%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.384', false, 0),
      (v_question_id, '0.512', false, 1),
      (v_question_id, '0.896', true, 2),
      (v_question_id, '0.992', false, 3);
  END IF;

  -- 25. Minimum surface area of a closed cylinder
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Find the minimum amount of tin sheet that can be made into a closed cylinder having a volume of 108 in³.';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Find the minimum amount of tin sheet that can be made into a closed cylinder having a volume of 108 in³.', 'single_choice', 'hard', 'V = πr²h = 108, so h = 108 / (πr²). Surface area A = 2πr² + 2πrh = 2πr² + 216/r. Setting dA/dr = 4πr − 216/r² = 0 gives r³ = 54/π, so r = 2.58 in and h = 108 / (π(2.58)²) = 5.16 in (h = 2r). A = 2π(2.58)² + 2π(2.58)(5.16) = 6π(2.58)² ≈ 125.5 in².', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '98.4 in²', false, 0),
      (v_question_id, '112.0 in²', false, 1),
      (v_question_id, '125.5 in²', true, 2),
      (v_question_id, '150.8 in²', false, 3);
  END IF;

  -- 26. Related rates: conical cistern
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Water flows into an inverted conical cistern at the rate of 8 m³/min. The cone is 12 m high and its circular opening has a radius of 6 m. How fast is the water level rising when the water is 4 m deep?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Water flows into an inverted conical cistern at the rate of 8 m³/min. The cone is 12 m high and its circular opening has a radius of 6 m. How fast is the water level rising when the water is 4 m deep?', 'single_choice', 'hard', 'By similar triangles, r / h = 6 / 12, so r = h/2. V = (1/3)πr²h = πh³/12, so dV/dt = (πh²/4)(dh/dt). With dV/dt = 8 m³/min and h = 4 m: dh/dt = 8 / (π(16)/4) = 2/π ≈ 0.64 m/min.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.16 m/min', false, 0),
      (v_question_id, '0.64 m/min', true, 1),
      (v_question_id, '1.27 m/min', false, 2),
      (v_question_id, '2.55 m/min', false, 3);
  END IF;

END $$;
