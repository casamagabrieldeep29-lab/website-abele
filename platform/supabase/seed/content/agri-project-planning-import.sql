-- Agricultural Project Planning and Analysis quiz batch (33 questions, 1 topic). Questions cover
-- project networks and scheduling (PERT/CPM: activities, events, paths, critical path,
-- forward and backward pass, slack and float, dummy activities, crashing), worked
-- critical-path problems, project performance evaluation criteria and rating scales, and
-- feasibility study components and indicators, all drawn directly from review-material
-- lectures and problem sets read in full (2026-10-02). Every numeric answer was re-derived
-- independently (forward and backward pass); no invented facts.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since these are general project-management review items, not PAES standard clauses.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Agricultural Project Planning and Analysis (PROJECT_MGMT_RDE) — 33 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'PROJECT_MGMT_RDE';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: PROJECT_MGMT_RDE';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Agricultural Project Planning and Analysis' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Agricultural Project Planning and Analysis';
  END IF;

  -- 1. Project network basics
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PERT/CPM is a project management tool used in the construction industry to do which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PERT/CPM is a project management tool used in the construction industry to do which of the following?', 'single_choice', 'easy', 'PERT/CPM is a project management tool used to plan, schedule, and control projects. It represents the project as a project network.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Plan, schedule, and control projects', true, 0),
      (v_question_id, 'Design, estimate, and appraise projects', false, 1),
      (v_question_id, 'Finance, insure, and audit projects', false, 2),
      (v_question_id, 'Procure, store, and distribute project materials', false, 3);
  END IF;

  -- 2. Basic information for a network
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which set lists the three basic pieces of information needed to build a project network?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which set lists the three basic pieces of information needed to build a project network?', 'single_choice', 'medium', 'A project network is built from (1) activity information (the detail of each activity, e.g., excavation, masonry, finishing), (2) precedence relationship (identification of the immediate predecessor), and (3) time information (the estimate of the activity duration).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Activity information, cost information, and resource information', false, 0),
      (v_question_id, 'Event information, budget information, and time information', false, 1),
      (v_question_id, 'Activity information, precedence relationship, and time information', true, 2),
      (v_question_id, 'Precedence relationship, risk information, and quality information', false, 3);
  END IF;

  -- 3. Event definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In an activity-on-arc project network, an event is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In an activity-on-arc project network, an event is best described as:', 'single_choice', 'medium', 'In an activity-on-arc network, an event is a milestone that signifies the beginning or completion of activities; it does not consume time or resources. An activity is the task that consumes time and resources and is drawn as the arc.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'a task that consumes both time and resources', false, 0),
      (v_question_id, 'an artificial activity that preserves a logical relationship', false, 1),
      (v_question_id, 'the longest route from start to finish', false, 2),
      (v_question_id, 'a milestone that marks the beginning or completion of activities and consumes no time or resources', true, 3);
  END IF;

  -- 4. Critical path
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a project network, the critical path is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a project network, the critical path is the:', 'single_choice', 'easy', 'The length of a path is the sum of the durations of its activities. The critical path is the longest path from start to finish, so it fixes the minimum project duration.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'shortest path from start to finish', false, 0),
      (v_question_id, 'longest path from start to finish', true, 1),
      (v_question_id, 'path containing the most expensive activities', false, 2),
      (v_question_id, 'path containing the fewest activities', false, 3);
  END IF;

  -- 5. Dummy activity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dummy activity in a project network is used to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A dummy activity in a project network is used to:', 'single_choice', 'medium', 'A dummy is an artificial activity (drawn as a broken arrow) that preserves the logical relationship between activities. It takes no time and no resources.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'preserve a logical relationship between activities without consuming time or resources', true, 0),
      (v_question_id, 'represent the activity with the longest duration', false, 1),
      (v_question_id, 'show the extra time available to a noncritical activity', false, 2),
      (v_question_id, 'mark the completion of the critical path', false, 3);
  END IF;

  -- 6. Forward pass
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which computation in a project network assumes that the estimated activity durations are followed and yields the earliest possible start and finish times?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which computation in a project network assumes that the estimated activity durations are followed and yields the earliest possible start and finish times?', 'single_choice', 'medium', 'The forward pass assumes the estimated durations are followed and gives the early start and early finish of each activity, i.e., the earliest possible start and finish times without delay.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Backward pass', false, 0),
      (v_question_id, 'Crashing', false, 1),
      (v_question_id, 'Forward pass', true, 2),
      (v_question_id, 'Probabilistic time estimation', false, 3);
  END IF;

  -- 7. Backward pass
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What does the backward pass determine in a project network?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What does the backward pass determine in a project network?', 'single_choice', 'medium', 'The backward pass determines how much later than indicated an activity can start or finish without delaying the project, i.e., the late start and late finish times.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The latest start and finish times of each activity that will not delay the project', true, 0),
      (v_question_id, 'The earliest start and finish times of each activity', false, 1),
      (v_question_id, 'The cost increase when an activity is shortened', false, 2),
      (v_question_id, 'The probability of finishing the project on a given date', false, 3);
  END IF;

  -- 8. Slack or float
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The slack (float) of an activity is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The slack (float) of an activity is the:', 'single_choice', 'easy', 'Slack or float is the allowable time for an activity to be delayed without delaying the overall project duration.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'time needed to crash the activity', false, 0),
      (v_question_id, 'allowable delay of the activity that does not delay the overall project duration', true, 1),
      (v_question_id, 'time between the optimistic and pessimistic estimates', false, 2),
      (v_question_id, 'total duration of the longest path', false, 3);
  END IF;

  -- 9. Critical path and slack
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement about the critical path is correct?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement about the critical path is correct?', 'single_choice', 'medium', 'The critical path has zero slack or float. Delaying any activity on it delays the overall project duration.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Its activities have zero slack, so delaying any of them delays the overall project duration', true, 0),
      (v_question_id, 'Its activities have the largest float in the network', false, 1),
      (v_question_id, 'Delaying an activity on it does not affect the project completion date', false, 2),
      (v_question_id, 'It is always the path with the fewest activities', false, 3);
  END IF;

  -- 10. PERT versus CPM
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which statement correctly contrasts PERT and CPM?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which statement correctly contrasts PERT and CPM?', 'single_choice', 'medium', 'PERT (Program Evaluation and Review Technique) is probabilistic and event oriented, and it considers time uncertainty in completing an activity. CPM (Critical Path Method) is deterministic and activity oriented, and it assumes that activities follow their estimated durations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'PERT is deterministic and activity oriented, while CPM is probabilistic and event oriented', false, 0),
      (v_question_id, 'PERT is probabilistic and event oriented, while CPM is deterministic and activity oriented', true, 1),
      (v_question_id, 'PERT is deterministic and event oriented, while CPM is probabilistic and activity oriented', false, 2),
      (v_question_id, 'PERT and CPM are both deterministic and differ only in the symbols used', false, 3);
  END IF;

  -- 11. Crashing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In CPM, crashing an activity means:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In CPM, crashing an activity means:', 'single_choice', 'medium', 'Crashing is reducing the duration of an activity at a cost. It is the basis of the time-cost tradeoff analysis in CPM.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'increasing its duration to save cost', false, 0),
      (v_question_id, 'removing it from the network', false, 1),
      (v_question_id, 'reducing its duration at an added cost', true, 2),
      (v_question_id, 'assigning it a dummy predecessor', false, 3);
  END IF;

  -- 12. Free float
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The amount of time an activity can be delayed without affecting the early start of a following activity is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The amount of time an activity can be delayed without affecting the early start of a following activity is called:', 'single_choice', 'medium', 'Free float is the time an activity can be delayed without affecting the early start of the following activity. Zero slack describes activities with no float, whose delay delays the whole project.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Free float', true, 0),
      (v_question_id, 'Zero slack', false, 1),
      (v_question_id, 'Dummy duration', false, 2),
      (v_question_id, 'Critical time', false, 3);
  END IF;

  -- 13. Small network minimum duration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 4 (A); D 5 (A); E 2 (B, D); F 3 (C, E). What is the minimum project duration?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 4 (A); D 5 (A); E 2 (B, D); F 3 (C, E). What is the minimum project duration?', 'single_choice', 'medium', 'Trace each path: A-B-E-F = 2 + 1 + 2 + 3 = 8 days; A-C-F = 2 + 4 + 3 = 9 days; A-D-E-F = 2 + 5 + 2 + 3 = 12 days. The critical path is the longest path, A-D-E-F, so the minimum project duration is 12 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '9 days', false, 0),
      (v_question_id, '17 days', false, 1),
      (v_question_id, '10 days', false, 2),
      (v_question_id, '12 days', true, 3);
  END IF;

  -- 14. Small network slack of C
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 4 (A); D 5 (A); E 2 (B, D); F 3 (C, E). What is the total slack of activity C?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 4 (A); D 5 (A); E 2 (B, D); F 3 (C, E). What is the total slack of activity C?', 'single_choice', 'hard', 'Forward pass: A finishes at day 2; B finishes at day 3 and D at day 7; E starts at day 7 (after both B and D) and finishes at day 9; F starts at day 9. Activity C starts at day 2 and finishes at day 6, but its successor F cannot start before day 9. Slack of C = 9 - 6 = 3 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0 days', false, 0),
      (v_question_id, '3 days', true, 1),
      (v_question_id, '4 days', false, 2),
      (v_question_id, '5 days', false, 3);
  END IF;

  -- 15. Flood control project duration
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A flood control channel project has the following activities (duration in weeks; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 1 (A); D 2 (B, C); E 1 (D); F 2 (D); G 3 (E, F); H 1 (G); I 2 (H); J 3 (I); K 2 (J); L 3 (G, J); M 2 (K, L); N 1 (M). What is the minimum project duration?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A flood control channel project has the following activities (duration in weeks; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 1 (A); D 2 (B, C); E 1 (D); F 2 (D); G 3 (E, F); H 1 (G); I 2 (H); J 3 (I); K 2 (J); L 3 (G, J); M 2 (K, L); N 1 (M). What is the minimum project duration?', 'single_choice', 'hard', 'Forward pass (finish times in weeks): A 2; B and C 3; D 5; E 6 and F 7; G 10; H 11; I 13; J 16; K 18; L 19 (starts after G and J); M 21 (starts after K at 18 and L at 19, so at 19); N 22. The minimum project duration is 22 weeks.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '21 weeks', false, 0),
      (v_question_id, '25 weeks', false, 1),
      (v_question_id, '22 weeks', true, 2),
      (v_question_id, '19 weeks', false, 3);
  END IF;

  -- 16. Flood control project float
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A flood control channel project has the following activities (duration in weeks; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 1 (A); D 2 (B, C); E 1 (D); F 2 (D); G 3 (E, F); H 1 (G); I 2 (H); J 3 (I); K 2 (J); L 3 (G, J); M 2 (K, L); N 1 (M). Which of the following activities has a total float of 1 week?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A flood control channel project has the following activities (duration in weeks; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 1 (A); D 2 (B, C); E 1 (D); F 2 (D); G 3 (E, F); H 1 (G); I 2 (H); J 3 (I); K 2 (J); L 3 (G, J); M 2 (K, L); N 1 (M). Which of the following activities has a total float of 1 week?', 'single_choice', 'hard', 'Activity E finishes at week 6, but G cannot start before week 7 because it also waits for F (finishing at week 7). Activity E therefore has a float of 1 week. Activities F, H, and L lie on the critical path and have zero float.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Activity E', true, 0),
      (v_question_id, 'Activity F', false, 1),
      (v_question_id, 'Activity H', false, 2),
      (v_question_id, 'Activity L', false, 3);
  END IF;

  -- 17. Flood control project earliest start
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A flood control channel project has the following activities (duration in weeks; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 1 (A); D 2 (B, C); E 1 (D); F 2 (D); G 3 (E, F); H 1 (G); I 2 (H); J 3 (I); K 2 (J); L 3 (G, J); M 2 (K, L); N 1 (M). What is the earliest start time of activity M, measured in weeks from the start of the project?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A flood control channel project has the following activities (duration in weeks; immediate predecessors in parentheses): A 2 (none); B 1 (A); C 1 (A); D 2 (B, C); E 1 (D); F 2 (D); G 3 (E, F); H 1 (G); I 2 (H); J 3 (I); K 2 (J); L 3 (G, J); M 2 (K, L); N 1 (M). What is the earliest start time of activity M, measured in weeks from the start of the project?', 'single_choice', 'hard', 'K finishes at week 18 (J finishes at week 16 plus 2 weeks). L starts at week 16 (after J) and finishes at week 19. Activity M needs both K and L, so its earliest start is the later of 18 and 19, which is week 19.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Week 18', false, 0),
      (v_question_id, 'Week 16', false, 1),
      (v_question_id, 'Week 21', false, 2),
      (v_question_id, 'Week 19', true, 3);
  END IF;

  -- 18. Critical path duration problem
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 12 (none); B 11 (A); C 13 (A); D 19 (B); E 15 (C); F 12 (D); G 21 (E, F). What is the minimum project duration?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 12 (none); B 11 (A); C 13 (A); D 19 (B); E 15 (C); F 12 (D); G 21 (E, F). What is the minimum project duration?', 'single_choice', 'hard', 'Path A-B-D-F-G = 12 + 11 + 19 + 12 + 21 = 75 days. Path A-C-E-G = 12 + 13 + 15 + 21 = 61 days. The longest path governs, so the minimum project duration is 75 days.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '61 days', false, 0),
      (v_question_id, '75 days', true, 1),
      (v_question_id, '54 days', false, 2),
      (v_question_id, '42 days', false, 3);
  END IF;

  -- 19. Critical path identification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 12 (none); B 11 (A); C 13 (A); D 19 (B); E 15 (C); F 12 (D); G 21 (E, F). Which path is the critical path?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 12 (none); B 11 (A); C 13 (A); D 19 (B); E 15 (C); F 12 (D); G 21 (E, F). Which path is the critical path?', 'single_choice', 'hard', 'Path A-B-D-F-G = 75 days is longer than path A-C-E-G = 61 days. The critical path is therefore A-B-D-F-G.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A-C-E-G', false, 0),
      (v_question_id, 'A-B-D-E', false, 1),
      (v_question_id, 'A-B-D-F-G', true, 2),
      (v_question_id, 'A-B-D-E-G', false, 3);
  END IF;

  -- 20. Float on noncritical path
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 12 (none); B 11 (A); C 13 (A); D 19 (B); E 15 (C); F 12 (D); G 21 (E, F). What is the total float of activity C?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A project has the following activities (duration in days; immediate predecessors in parentheses): A 12 (none); B 11 (A); C 13 (A); D 19 (B); E 15 (C); F 12 (D); G 21 (E, F). What is the total float of activity C?', 'single_choice', 'hard', 'The critical path is A-B-D-F-G at 75 days. The path through C is A-C-E-G at 12 + 13 + 15 + 21 = 61 days, so activities C and E can be delayed by a total of 75 - 61 = 14 days without delaying the project.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '14 days', true, 0),
      (v_question_id, '42 days', false, 1),
      (v_question_id, '12 days', false, 2),
      (v_question_id, '13 days', false, 3);
  END IF;

  -- 21. CPES definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The system of grading the performance of a constructor for a specific kind of project using a set of criteria is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The system of grading the performance of a constructor for a specific kind of project using a set of criteria is called the:', 'single_choice', 'easy', 'The Constructor''s Performance Evaluation System (CPES) grades the performance of a constructor for a specific kind of project using a set of criteria.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Program Evaluation and Review Technique (PERT)', false, 0),
      (v_question_id, 'Constructor''s Performance Evaluation System (CPES)', true, 1),
      (v_question_id, 'Critical Path Method (CPM)', false, 2),
      (v_question_id, 'Philippine Construction Accreditation Board licensing system', false, 3);
  END IF;

  -- 22. CPE minimum experience
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the minimum qualifications of a Constructor''s Performance Evaluator (CPE) is a licensed Engineer or Architect with at least how many years of experience in the construction industry?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among the minimum qualifications of a Constructor''s Performance Evaluator (CPE) is a licensed Engineer or Architect with at least how many years of experience in the construction industry?', 'single_choice', 'medium', 'A CPE must be a licensed Engineer or Architect with at least 5 years of experience in the construction industry, not convicted of a crime of moral turpitude or a crime with a penalty of 6 months imprisonment, and willing to undergo the screening requirements and accreditation course for CPEs.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '5 years', true, 0),
      (v_question_id, '2 years', false, 1),
      (v_question_id, '3 years', false, 2),
      (v_question_id, '10 years', false, 3);
  END IF;

  -- 23. CPES time weight upon completion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the CPES upon-completion evaluation, Workmanship carries a weight of 0.50 and Materials 0.20. If the criteria weights total 1.00, what weight is given to Time?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the CPES upon-completion evaluation, Workmanship carries a weight of 0.50 and Materials 0.20. If the criteria weights total 1.00, what weight is given to Time?', 'single_choice', 'medium', 'The upon-completion criteria are Workmanship, Materials, and Time. Time = 1.00 - 0.50 - 0.20 = 0.30.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.15', false, 0),
      (v_question_id, '0.25', false, 1),
      (v_question_id, '0.50', false, 2),
      (v_question_id, '0.30', true, 3);
  END IF;

  -- 24. CPES weights for horizontal projects
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For horizontal projects under CPES, what percentage of the evaluation is given to the during-construction evaluation and to the upon-completion evaluation, respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For horizontal projects under CPES, what percentage of the evaluation is given to the during-construction evaluation and to the upon-completion evaluation, respectively?', 'single_choice', 'medium', 'For horizontal projects, the evaluation during construction carries 60% and the evaluation upon completion carries 40%. For vertical projects the weights are 70% and 30%.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '60% and 40%', true, 0),
      (v_question_id, '70% and 30%', false, 1),
      (v_question_id, '40% and 60%', false, 2),
      (v_question_id, '50% and 50%', false, 3);
  END IF;

  -- 25. CPES vertical project
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under CPES, which of the following is classified as a vertical project?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under CPES, which of the following is classified as a vertical project?', 'single_choice', 'medium', 'Vertical projects include housing, buildings, power transmission lines, and substations and diesel power plants. Roads and bridges, ports and harbors, irrigation and flood control, water supply and sewerage, and mooring facilities for power barges are horizontal projects.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Roads and bridges', false, 0),
      (v_question_id, 'Irrigation and flood control', false, 1),
      (v_question_id, 'Substation and diesel power plant', true, 2),
      (v_question_id, 'Water supply and sewerage', false, 3);
  END IF;

  -- 26. CPES adjective rating
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A constructor obtains a final CPES rating of 79%. What is the adjective rating?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A constructor obtains a final CPES rating of 79%. What is the adjective rating?', 'single_choice', 'medium', 'CPES adjective ratings: Outstanding, above 96%; Very Satisfactory, above 89% to 96%; Satisfactory, above 82% to 89%; Unsatisfactory, 75% to 82%; Poor, below 75%. A rating of 79% falls under Unsatisfactory.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Satisfactory', false, 0),
      (v_question_id, 'Unsatisfactory', true, 1),
      (v_question_id, 'Poor', false, 2),
      (v_question_id, 'Very Satisfactory', false, 3);
  END IF;

  -- 27. CPES consequence of low rating
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under CPES in the construction industry, a constructor whose final rating is Poor or Unsatisfactory is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under CPES in the construction industry, a constructor whose final rating is Poor or Unsatisfactory is:', 'single_choice', 'medium', 'A constructor with a final rating of Poor or Unsatisfactory is blacklisted. A constructor needs at least a Satisfactory rating for agency shortlisting, and at least Satisfactory with no zero rating for Time in post-qualification.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'blacklisted', true, 0),
      (v_question_id, 'shortlisted with a warning', false, 1),
      (v_question_id, 'promoted to the next license category', false, 2),
      (v_question_id, 'required only to submit a corrective action plan', false, 3);
  END IF;

  -- 28. CPES final rating computation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A horizontal project is rated 90% in the CPES evaluation during construction and 80% in the evaluation upon completion. Using the CPES weights for horizontal projects, what is the final rating?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A horizontal project is rated 90% in the CPES evaluation during construction and 80% in the evaluation upon completion. Using the CPES weights for horizontal projects, what is the final rating?', 'single_choice', 'hard', 'For horizontal projects the weights are 60% during construction and 40% upon completion. Final rating = 0.60 x 90 + 0.40 x 80 = 54 + 32 = 86%, which is Satisfactory (above 82% to 89%).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '85%', false, 0),
      (v_question_id, '87%', false, 1),
      (v_question_id, '86%', true, 2),
      (v_question_id, '84%', false, 3);
  END IF;

  -- 29. CPES number of visits
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A construction project has a duration of 75 calendar days. How many CPES evaluation visits are made during construction?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A construction project has a duration of 75 calendar days. How many CPES evaluation visits are made during construction?', 'single_choice', 'medium', 'One visit is made during construction for projects having 90 calendar days and below. Longer projects require a minimum of 2 visits once actual accomplishment is at least 30%. A final visit is made for 100% completion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2 visits', false, 0),
      (v_question_id, '1 visit', true, 1),
      (v_question_id, '3 visits', false, 2),
      (v_question_id, '4 visits', false, 3);
  END IF;

  -- 30. Feasibility study definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A feasibility study is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A feasibility study is best described as:', 'single_choice', 'easy', 'A feasibility study is an exploratory and evaluation tool used to determine whether an intended venture or business idea is viable or profitable. The evaluation uses past and existing information projected into the future and serves as the basis for deciding whether to pursue the proposed idea.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'an exploratory and evaluation tool for determining whether a proposed venture is viable or profitable', true, 0),
      (v_question_id, 'a scheduling tool that identifies the longest path in a project', false, 1),
      (v_question_id, 'an audit of project outputs after implementation', false, 2),
      (v_question_id, 'a document that transfers ownership of project assets', false, 3);
  END IF;

  -- 31. Parts of a feasibility study
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT one of the standard parts of a project feasibility study?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT one of the standard parts of a project feasibility study?', 'single_choice', 'medium', 'A standard feasibility study contains the project summary and the market, technical, financial, socio-economic, and management feasibility sections. Political feasibility is not one of the listed parts.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Market feasibility', false, 0),
      (v_question_id, 'Socio-economic feasibility', false, 1),
      (v_question_id, 'Management feasibility', false, 2),
      (v_question_id, 'Political feasibility', true, 3);
  END IF;

  -- 32. Advantage of a feasibility study
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is an advantage of preparing a feasibility study?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is an advantage of preparing a feasibility study?', 'single_choice', 'easy', 'Advantages: it shows whether valuable resources may be committed to an undertaking, it reduces the potential risk of failure, and it identifies critical issues and critical resources. Its disadvantages are that it requires technical knowledge, initial expenses, and time and effort.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It requires initial expenses', false, 0),
      (v_question_id, 'It reduces the potential risk of failure of an undertaking', true, 1),
      (v_question_id, 'It requires technical knowledge', false, 2),
      (v_question_id, 'It requires time and effort', false, 3);
  END IF;

  -- 33. Ranking of feasibility indicators
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Five feasibility indicators for financial and economic analyses are ranked by importance. Which indicator ranks first and which ranks last?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Five feasibility indicators for financial and economic analyses are ranked by importance. Which indicator ranks first and which ranks last?', 'single_choice', 'medium', 'The indicators ranked by importance are: (1) Net Present Value, (2) Internal Rate of Return, (3) Benefit-Cost Ratio, (4) Return on Investment, and (5) Payback Period. NPV ranks first and Payback Period ranks last.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'IRR first; ROI last', false, 0),
      (v_question_id, 'BCR first; NPV last', false, 1),
      (v_question_id, 'NPV first; Payback Period last', true, 2),
      (v_question_id, 'ROI first; Payback Period last', false, 3);
  END IF;

END $$;
