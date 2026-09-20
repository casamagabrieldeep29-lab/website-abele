-- One-time cleanup: the first flashcard pilot batch was written before the
-- "just Area 1/2/3, no per-subject topic" decision, so it landed on the
-- fine-grained MCQ topics (Hydrology, Irrigation and Drainage Engineering,
-- Geographic Information System, Agricultural and Bioprocess Engineering,
-- Engineering Economy and Project Feasibility Analysis) instead of the
-- Area 1/2/3 umbrella topics the later batch uses. That's why the admin
-- flashcards tabs show a mix of "Area 2" / "Area 3" alongside individual
-- topic names.
--
-- Reassigns every flashcard currently sitting on a non-Area topic to the
-- correct Area topic, based on that topic's own mock_area (the same Area
-- 1/2/3 split Mock Exam and the Practice page already use). Only touches
-- public.flashcards.topic_id/subtopic_id -- the underlying topics table and
-- every MCQ question's topic association are completely untouched, since
-- those fine-grained topics are still the correct home for questions.
--
-- Safe to re-run: once every flashcard is on an Area topic, the WHERE
-- clause matches nothing.

DO $$
DECLARE
  v_area1_id uuid;
  v_area2_id uuid;
  v_area3_id uuid;
  v_moved int;
BEGIN
  SELECT id INTO v_area1_id FROM public.topics WHERE name = 'Area 1';
  SELECT id INTO v_area2_id FROM public.topics WHERE name = 'Area 2';
  SELECT id INTO v_area3_id FROM public.topics WHERE name = 'Area 3';

  IF v_area1_id IS NULL OR v_area2_id IS NULL OR v_area3_id IS NULL THEN
    RAISE EXCEPTION 'Area 1/2/3 topics not found -- run the flashcards-by-area-*.sql batches first.';
  END IF;

  UPDATE public.flashcards f
  SET
    topic_id = CASE t.mock_area
      WHEN 'area_1' THEN v_area1_id
      WHEN 'area_2' THEN v_area2_id
      WHEN 'area_3' THEN v_area3_id
    END,
    subtopic_id = NULL
  FROM public.topics t
  WHERE f.topic_id = t.id
    AND t.id NOT IN (v_area1_id, v_area2_id, v_area3_id);

  GET DIAGNOSTICS v_moved = ROW_COUNT;
  RAISE NOTICE 'Reassigned % flashcard(s) onto Area 1/2/3.', v_moved;
END $$;
