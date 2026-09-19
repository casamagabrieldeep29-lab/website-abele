-- Merges the duplicate "Laws/Ethics" topic that arose from two source files
-- naming the same subject differently:
--   source (5 questions): "AE Laws, Professional Ethics, Engineering
--     Contracts, Specifications and Legal Documents" (from
--     area1-tambong-part1.json)
--   target (15 questions): "Laws, Professional Standards, and Ethics"
--     (from boardexampro-vol2-part1.json)
-- Both already sit under the same LAWS_ETHICS exam area. Moves any
-- subtopics and all questions from source into target (merging any
-- identically-named subtopic rather than duplicating it), then deletes the
-- now-empty source topic. Safe to run once; running it again will simply
-- report that the source topic no longer exists.

DO $$
DECLARE
  v_source_id uuid;
  v_target_id uuid;
  v_sub record;
  v_existing_sub_id uuid;
BEGIN
  SELECT id INTO v_source_id FROM public.topics
    WHERE name = 'AE Laws, Professional Ethics, Engineering Contracts, Specifications and Legal Documents';
  SELECT id INTO v_target_id FROM public.topics
    WHERE name = 'Laws, Professional Standards, and Ethics';

  IF v_source_id IS NULL THEN
    RAISE NOTICE 'Source topic not found (already merged?) — nothing to do.';
    RETURN;
  END IF;
  IF v_target_id IS NULL THEN
    RAISE EXCEPTION 'Target topic "Laws, Professional Standards, and Ethics" not found.';
  END IF;

  -- Re-point subtopics: merge into an identically-named subtopic under the
  -- target if one exists, otherwise just move it under the target topic.
  FOR v_sub IN SELECT id, name FROM public.subtopics WHERE topic_id = v_source_id LOOP
    SELECT id INTO v_existing_sub_id FROM public.subtopics
      WHERE topic_id = v_target_id AND name = v_sub.name;
    IF v_existing_sub_id IS NOT NULL THEN
      UPDATE public.questions SET subtopic_id = v_existing_sub_id WHERE subtopic_id = v_sub.id;
      DELETE FROM public.subtopics WHERE id = v_sub.id;
    ELSE
      UPDATE public.subtopics SET topic_id = v_target_id WHERE id = v_sub.id;
    END IF;
  END LOOP;

  -- Move all questions from the source topic to the target topic.
  UPDATE public.questions SET topic_id = v_target_id WHERE topic_id = v_source_id;

  -- Source topic is now empty; remove it.
  DELETE FROM public.topics WHERE id = v_source_id;

  RAISE NOTICE 'Merged topic % into %', v_source_id, v_target_id;
END $$;
