-- Merges topics that ended up duplicated because independent source files
-- named the same subject differently (or, in the irrigation case, literally
-- split one continuous source topic across a page boundary between two
-- files). For each pair, moves subtopics (merging into an identically-named
-- subtopic under the target if one exists) and all questions from source
-- into target, then deletes the now-empty source topic.
--
--   source (17q) "Irrigation and Drainage Systems"
--     -> target (24q) "Irrigation and Drainage Engineering"
--     Confirmed via boardexampro-vol2-part1.json's own transcription notes:
--     this is one continuous source topic that page 70 cuts off mid-question
--     on, continuing on page 71 in the other file/session.
--
--   source (19q) "Design and Construction of Agricultural Buildings and Facilities"
--     -> target (30q) "Agricultural Building and Structures"
--     Both are agricultural structures/building design content from two
--     different source volumes.
--
--   source (3q)  "Agricultural Machinery Management, Extension and Marketing"
--     -> target (15q) "Farm Machinery and Mechanization, Economics, Management, and Marketing"
--     The 3-question source is a stub of basic term definitions (machinery,
--     management, marketing) that belongs inside the broader topic, which
--     already covers machinery economics/management/marketing.
--
-- Safe to run once; running it again just reports each pair as already
-- merged instead of erroring.

DO $$
DECLARE
  v_pairs text[][] := ARRAY[
    ARRAY['Irrigation and Drainage Systems', 'Irrigation and Drainage Engineering'],
    ARRAY['Design and Construction of Agricultural Buildings and Facilities', 'Agricultural Building and Structures'],
    ARRAY['Agricultural Machinery Management, Extension and Marketing', 'Farm Machinery and Mechanization, Economics, Management, and Marketing']
  ];
  v_pair text[];
  v_source_id uuid;
  v_target_id uuid;
  v_sub record;
  v_existing_sub_id uuid;
BEGIN
  FOREACH v_pair SLICE 1 IN ARRAY v_pairs LOOP
    SELECT id INTO v_source_id FROM public.topics WHERE name = v_pair[1];
    SELECT id INTO v_target_id FROM public.topics WHERE name = v_pair[2];

    IF v_source_id IS NULL THEN
      RAISE NOTICE 'Source topic "%" not found (already merged?) — skipping.', v_pair[1];
      CONTINUE;
    END IF;
    IF v_target_id IS NULL THEN
      RAISE EXCEPTION 'Target topic "%" not found.', v_pair[2];
    END IF;

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

    UPDATE public.questions SET topic_id = v_target_id WHERE topic_id = v_source_id;
    DELETE FROM public.topics WHERE id = v_source_id;

    RAISE NOTICE 'Merged topic "%" into "%"', v_pair[1], v_pair[2];
  END LOOP;
END $$;
