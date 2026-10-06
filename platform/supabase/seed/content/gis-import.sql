-- Geographic Information System quiz batch (40 questions, 1 topic). Every definition,
-- formula, and fact is drawn directly from geoinformatics review material read
-- in full (2026-10-02) -- no invented facts.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- since this is general GIS review material, not a PAES standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Geographic Information System (LAND_WATER) -- 40 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'LAND_WATER';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: LAND_WATER';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Geographic Information System' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Geographic Information System';
  END IF;

  -- 1.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The three core components of geoinformatics are:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The three core components of geoinformatics are:', 'single_choice', 'easy', 'Geoinformatics integrates three core components: Remote Sensing (RS), Geographic Information System (GIS), and Global Positioning System (GPS).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Remote Sensing, Geographic Information System, and Global Positioning System', true, 0),
      (v_question_id, 'Surveying, Cartography, and Photogrammetry', false, 1),
      (v_question_id, 'Remote Sensing, Hydrology, and Geodesy', false, 2),
      (v_question_id, 'Geographic Information System, Computer-Aided Design, and Total Station', false, 3);
  END IF;

  -- 2.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Obtaining information about the Earth''s surface without direct contact, typically through satellites or aerial sensors, is known as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Obtaining information about the Earth''s surface without direct contact, typically through satellites or aerial sensors, is known as:', 'single_choice', 'easy', 'Remote sensing is the science of obtaining information about the Earth''s surface without direct contact, typically through satellites or aerial sensors.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geocoding', false, 0),
      (v_question_id, 'Remote sensing', true, 1),
      (v_question_id, 'Triangulation', false, 2),
      (v_question_id, 'Digitizing', false, 3);
  END IF;

  -- 3.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which geoinformatics component is a satellite-based navigation system that provides real-time location and time data?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which geoinformatics component is a satellite-based navigation system that provides real-time location and time data?', 'single_choice', 'easy', 'The Global Positioning System (GPS) is a satellite-based navigation system that provides real-time location and time data. GIS, by contrast, is a computer-based tool for capturing, storing, analyzing, and visualizing spatial data.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geographic Information System (GIS)', false, 0),
      (v_question_id, 'Remote Sensing (RS)', false, 1),
      (v_question_id, 'Global Positioning System (GPS)', true, 2),
      (v_question_id, 'Database Management System (DBMS)', false, 3);
  END IF;

  -- 4.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A computerized system designed to capture, store, manipulate, analyze, manage, and present all types of spatial or geographical data is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A computerized system designed to capture, store, manipulate, analyze, manage, and present all types of spatial or geographical data is called a:', 'single_choice', 'easy', 'A Geographic Information System (GIS) is a computerized system designed to capture, store, manipulate, analyze, manage, and present all spatial or geographical data types.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geographic Information System', true, 0),
      (v_question_id, 'Supervisory control system', false, 1),
      (v_question_id, 'Global navigation receiver', false, 2),
      (v_question_id, 'Enterprise resource planning system', false, 3);
  END IF;

  -- 5.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The term "geographic information system" was first used in 1968 by which person, who is also acknowledged as the "father of GIS"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The term "geographic information system" was first used in 1968 by which person, who is also acknowledged as the "father of GIS"?', 'single_choice', 'easy', 'Roger Tomlinson first used the term "geographic information system" in 1968 in his paper "A Geographic Information System for Regional Planning," and is acknowledged as the "father of GIS."', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gerardus Mercator', false, 0),
      (v_question_id, 'Edmund Gunter', false, 1),
      (v_question_id, 'Roger Tomlinson', true, 2),
      (v_question_id, 'Carl Friedrich Gauss', false, 3);
  END IF;

  -- 6.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is NOT one of the five main components of a GIS?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is NOT one of the five main components of a GIS?', 'single_choice', 'hard', 'The main components of a GIS are hardware, software, data, users (people), and procedures (methods). A satellite transmitter is not a GIS component.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hardware', false, 0),
      (v_question_id, 'Procedures', false, 1),
      (v_question_id, 'Data', false, 2),
      (v_question_id, 'Satellite transmitter', true, 3);
  END IF;

  -- 7.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a GIS, data that are represented as points, lines, and polygons are classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a GIS, data that are represented as points, lines, and polygons are classified as:', 'single_choice', 'easy', 'Vector data are represented as points, lines, and polygons, whereas raster data are made up of pixels (grid cells).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Raster data', false, 0),
      (v_question_id, 'Vector data', true, 1),
      (v_question_id, 'Metadata', false, 2),
      (v_question_id, 'Tabular data', false, 3);
  END IF;

  -- 8.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a GIS, data made up of pixels arranged in grid cells, used to represent continuous data, are classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a GIS, data made up of pixels arranged in grid cells, used to represent continuous data, are classified as:', 'single_choice', 'easy', 'Raster data are made up of pixels (grid cells) and are used to represent continuous data. Vector data, on the other hand, are represented as points, lines, and polygons.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Vector data', false, 0),
      (v_question_id, 'Shapefile data', false, 1),
      (v_question_id, 'Raster data', true, 2),
      (v_question_id, 'Attribute-only data', false, 3);
  END IF;

  -- 9.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In remote sensing imagery, "spatial resolution" refers to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In remote sensing imagery, "spatial resolution" refers to:', 'single_choice', 'medium', 'Spatial resolution describes how much detail the image can capture. A pixel is the area represented by each cell and is the smallest unit of data.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The number of spectral bands recorded by the sensor', false, 0),
      (v_question_id, 'How much detail the image can capture', true, 1),
      (v_question_id, 'The time interval between successive satellite passes', false, 2),
      (v_question_id, 'The wavelength of the energy source', false, 3);
  END IF;

  -- 10.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A common file format for vector data in GIS that often comes with multiple files such as .shp, .shx, and .dbf is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A common file format for vector data in GIS that often comes with multiple files such as .shp, .shx, and .dbf is the:', 'single_choice', 'medium', 'A shapefile (.shp) is a common file format for vector data (points, lines, polygons) and often comes with multiple files, such as .shp, .shx, and .dbf.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Raster grid', false, 0),
      (v_question_id, 'Shapefile', true, 1),
      (v_question_id, 'Comma-separated values file', false, 2),
      (v_question_id, 'KMZ file', false, 3);
  END IF;

  -- 11.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A more advanced, organized file structure in GIS that can store multiple layers, tables, and relationships in one file is the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A more advanced, organized file structure in GIS that can store multiple layers, tables, and relationships in one file is the:', 'single_choice', 'medium', 'A geodatabase (.gdb) is a more advanced, organized file structure for storing GIS datasets; it can store multiple layers, tables, and relationships in one file.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shapefile', false, 0),
      (v_question_id, 'CSV file', false, 1),
      (v_question_id, 'Geodatabase', true, 2),
      (v_question_id, 'Scanned image', false, 3);
  END IF;

  -- 12.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a GIS, metadata provides:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a GIS, metadata provides:', 'single_choice', 'easy', 'Metadata provides information about the data, such as its source and accuracy.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Information about the data, such as source and accuracy', true, 0),
      (v_question_id, 'The shortest path between two locations', false, 1),
      (v_question_id, 'A zone around a feature at a specified distance', false, 2),
      (v_question_id, 'The coordinates of the Prime Meridian', false, 3);
  END IF;

  -- 13.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The act of assigning a physical location to objects on the Earth''s surface is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The act of assigning a physical location to objects on the Earth''s surface is called:', 'single_choice', 'easy', 'Georeferencing is the act of assigning physical location to objects on the Earth''s surface. It is essential because locations are the basis for many of the benefits of GIS, such as tying different kinds of information together because they refer to the same place, and measuring distances and areas.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reclassification', false, 0),
      (v_question_id, 'Dissolving', false, 1),
      (v_question_id, 'Georeferencing', true, 2),
      (v_question_id, 'Generalization', false, 3);
  END IF;

  -- 14.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which coordinate system is based on latitude and longitude and is regarded as the most comprehensive and powerful method of georeferencing locations of spatial features on the Earth''s surface?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which coordinate system is based on latitude and longitude and is regarded as the most comprehensive and powerful method of georeferencing locations of spatial features on the Earth''s surface?', 'single_choice', 'medium', 'The Geographic Coordinate System (GCS) is based on latitude and longitude and is the most comprehensive and powerful method of georeferencing for locating spatial features on the Earth''s surface.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geographic Coordinate System', true, 0),
      (v_question_id, 'Local plane rectangular system', false, 1),
      (v_question_id, 'Polar grid system', false, 2),
      (v_question_id, 'Cartesian drafting system', false, 3);
  END IF;

  -- 15.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Latitude is the angular distance, in degrees, minutes, and seconds, of a point:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Latitude is the angular distance, in degrees, minutes, and seconds, of a point:', 'single_choice', 'easy', 'Latitude is the angular distance of a point north or south of the Equator. Longitude is the angular distance of a point east or west of the Prime (Greenwich) Meridian.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'East or west of the Prime (Greenwich) Meridian', false, 0),
      (v_question_id, 'North or south of the Equator', true, 1),
      (v_question_id, 'Above or below mean sea level', false, 2),
      (v_question_id, 'North or south of the Prime Meridian', false, 3);
  END IF;

  -- 16.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Earth is more accurately modeled as a spheroid (ellipsoid) than as a sphere. A spheroid is formed by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Earth is more accurately modeled as a spheroid (ellipsoid) than as a sphere. A spheroid is formed by:', 'single_choice', 'medium', 'The Earth is slightly flattened, so the distance between the Poles is less than the diameter at the Equator. A spheroid is formed by rotating an ellipse about its shorter axis.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Rotating a circle about its diameter', false, 0),
      (v_question_id, 'Rotating an ellipse about its shorter axis', true, 1),
      (v_question_id, 'Rotating an ellipse about its longer axis', false, 2),
      (v_question_id, 'Wrapping a cylinder around the Equator', false, 3);
  END IF;

  -- 17.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The international standard coordinate system known as the World Geodesic System of 1984 is abbreviated as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The international standard coordinate system known as the World Geodesic System of 1984 is abbreviated as:', 'single_choice', 'easy', 'WGS 84 (World Geodesic System of 1984) is the international standard coordinate system that has been adopted today.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'UTM 84', false, 0),
      (v_question_id, 'WGS 84', true, 1),
      (v_question_id, 'GCS 1984', false, 2),
      (v_question_id, 'ITRF 84', false, 3);
  END IF;

  -- 18.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Map projections are the methods and procedures used to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Map projections are the methods and procedures used to:', 'single_choice', 'medium', 'Map projections refer to the methods and procedures used to transform the spherical, three-dimensional Earth into two-dimensional planar (flat) surfaces.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Convert a flat map into a three-dimensional globe', false, 0),
      (v_question_id, 'Assign attribute tables to vector features', false, 1),
      (v_question_id, 'Transform the spherical three-dimensional Earth into two-dimensional planar surfaces', true, 2),
      (v_question_id, 'Measure the time required for satellite signals to reach a receiver', false, 3);
  END IF;

  -- 19.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which property of a map projection refers to the correct representation of areas (sizes)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which property of a map projection refers to the correct representation of areas (sizes)?', 'single_choice', 'medium', 'The four properties of map projection are conformality (correct shapes), equidistance (correct distances), equivalence (correct areas or sizes), and azimuthality (correct directions).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conformality', false, 0),
      (v_question_id, 'Equidistance', false, 1),
      (v_question_id, 'Equivalence', true, 2),
      (v_question_id, 'Azimuthality', false, 3);
  END IF;

  -- 20.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Mercator projection is the best known cylindrical projection. Where does the cylinder touch the Earth, and where is distortion zero?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Mercator projection is the best known cylindrical projection. Where does the cylinder touch the Earth, and where is distortion zero?', 'single_choice', 'hard', 'In the Mercator projection the cylinder touches the Earth at the Equator and the projection preserves the conformal property. Distortion is zero at the Equator and increases away from it.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At the Poles; distortion is zero at the Poles', false, 0),
      (v_question_id, 'At the Equator; distortion is zero at the Equator', true, 1),
      (v_question_id, 'At the Prime Meridian; distortion is zero along that meridian', false, 2),
      (v_question_id, 'At the Tropic of Cancer; distortion is zero along that parallel', false, 3);
  END IF;

  -- 21.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Universal Transverse Mercator (UTM) projection is called "transverse" because:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Universal Transverse Mercator (UTM) projection is called "transverse" because:', 'single_choice', 'hard', 'UTM is a cylindrical projection implemented as an international standard coordinate system. It is a transverse Mercator because the cylinder is wrapped around the Poles, not the Equator.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The cylinder is wrapped around the Poles, not the Equator', true, 0),
      (v_question_id, 'The cylinder touches the Earth only at the Equator', false, 1),
      (v_question_id, 'It preserves areas instead of shapes', false, 2),
      (v_question_id, 'It is based on a flat plane touching the Earth at one point', false, 3);
  END IF;

  -- 22.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Map scale is defined as the ratio of:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Map scale is defined as the ratio of:', 'single_choice', 'easy', 'Map scale is the ratio of distance on the map to distance on the Earth''s surface. It can be expressed as text, as a representative fraction, or as a graphical scale bar.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Distance on the Earth''s surface to distance on the map', false, 0),
      (v_question_id, 'Distance on the map to distance on the Earth''s surface', true, 1),
      (v_question_id, 'Map area to the number of map layers', false, 2),
      (v_question_id, 'Map size to the paper size', false, 3);
  END IF;

  -- 23.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A map with a representative fraction of 1:24,000 means that the map:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A map with a representative fraction of 1:24,000 means that the map:', 'single_choice', 'medium', 'A representative fraction of 1:24,000 reduces everything on the Earth to one 24,000th of its real size.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Shows features at 24,000 times their real size', false, 0),
      (v_question_id, 'Covers an area of 24,000 square units', false, 1),
      (v_question_id, 'Reduces everything on the Earth to one 24,000th of its real size', true, 2),
      (v_question_id, 'Has a scale bar 24,000 units long', false, 3);
  END IF;

  -- 24.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following maps is considered a large-scale map?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following maps is considered a large-scale map?', 'single_choice', 'medium', 'Large-scale maps show more detail but cover less area, such as farm lots, building plans, or barangay-level maps, with a scale such as 1:1,000. Small-scale maps show less detail but cover a wider area, such as country or world maps (e.g., 1:1,000,000).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A world map at 1:1,000,000', false, 0),
      (v_question_id, 'A farm lot map at 1:1,000', true, 1),
      (v_question_id, 'A country map at 1:1,000,000', false, 2),
      (v_question_id, 'A regional map showing the whole archipelago', false, 3);
  END IF;

  -- 25.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'On a map drawn at a scale of 1:1,000, a distance of 8 cm measured on the map corresponds to what ground distance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'On a map drawn at a scale of 1:1,000, a distance of 8 cm measured on the map corresponds to what ground distance?', 'single_choice', 'hard', 'A scale of 1:1,000 means 1 unit on the map equals 1,000 units on the ground. Ground distance = 8 cm x 1,000 = 8,000 cm = 80 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8 m', false, 0),
      (v_question_id, '80 m', true, 1),
      (v_question_id, '800 m', false, 2),
      (v_question_id, '8,000 m', false, 3);
  END IF;

  -- 26.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of map shows property boundaries and is applied to land ownership and land titling?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of map shows property boundaries and is applied to land ownership and land titling?', 'single_choice', 'medium', 'A cadastral map shows property boundaries, and its application in agricultural and biosystems engineering includes land ownership and land titling.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Climate map', false, 0),
      (v_question_id, 'Hydrologic map', false, 1),
      (v_question_id, 'Cadastral map', true, 2),
      (v_question_id, 'Geologic map', false, 3);
  END IF;

  -- 27.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of map shows water resources and flow patterns, and is applied in drainage system design and water source mapping?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of map shows water resources and flow patterns, and is applied in drainage system design and water source mapping?', 'single_choice', 'medium', 'A hydrologic map shows water resources and flow patterns, with applications in drainage system design and water source mapping.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hydrologic map', true, 0),
      (v_question_id, 'Zoning map', false, 1),
      (v_question_id, 'Soil map', false, 2),
      (v_question_id, 'Navigation map', false, 3);
  END IF;

  -- 28.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which GIS overlay function combines two datasets and retains all features and attributes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which GIS overlay function combines two datasets and retains all features and attributes?', 'single_choice', 'medium', 'Union combines two datasets and retains all features and attributes. Intersect keeps only the overlapping areas, and merge combines multiple layers that have the same structure into one.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Intersect', false, 0),
      (v_question_id, 'Clip', false, 1),
      (v_question_id, 'Near', false, 2),
      (v_question_id, 'Union', true, 3);
  END IF;

  -- 29.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which GIS command merges two or more adjacent polygons into a single feature, summarizing data by grouping features into categories based on a shared attribute?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which GIS command merges two or more adjacent polygons into a single feature, summarizing data by grouping features into categories based on a shared attribute?', 'single_choice', 'medium', 'Dissolve merges features based on a shared attribute; it merges two or more adjacent polygons into a single feature and allows users to summarize data by grouping features into categories.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Buffer', false, 0),
      (v_question_id, 'Dissolve', true, 1),
      (v_question_id, 'Export', false, 2),
      (v_question_id, 'Intersect', false, 3);
  END IF;

  -- 30.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which GIS function joins non-spatial data, such as a table, to a spatial dataset based on a common field?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which GIS function joins non-spatial data, such as a table, to a spatial dataset based on a common field?', 'single_choice', 'medium', 'Join is the function used to join non-spatial data (like a table) to a spatial dataset based on a common field.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Join', true, 0),
      (v_question_id, 'Near', false, 1),
      (v_question_id, 'Clip', false, 2),
      (v_question_id, 'Georeferencing', false, 3);
  END IF;

  -- 31.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of GIS analysis is used to determine the shortest path between two locations?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of GIS analysis is used to determine the shortest path between two locations?', 'single_choice', 'medium', 'Network analysis is used to determine the shortest path between two locations. Overlay analysis, by contrast, overlays multiple spatial datasets to find relationships between them.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Network analysis', true, 0),
      (v_question_id, 'Overlay analysis', false, 1),
      (v_question_id, 'Buffer analysis', false, 2),
      (v_question_id, 'Metadata analysis', false, 3);
  END IF;

  -- 32.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The function of the input data subsystem in a GIS, which collects raw geographic data from sources such as cameras, GPS, and surveys, is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The function of the input data subsystem in a GIS, which collects raw geographic data from sources such as cameras, GPS, and surveys, is:', 'single_choice', 'medium', 'Data acquisition is the process of collecting or capturing raw geographic data from various sources (for example cameras, GPS, and surveys) to input into the GIS. Transform data converts data from one format or coordinate system to another, store data saves collected data in a database, and retrieve data accesses data in response to a query.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Transform data', false, 0),
      (v_question_id, 'Retrieve data', false, 1),
      (v_question_id, 'Store data', false, 2),
      (v_question_id, 'Data acquisition', true, 3);
  END IF;

  -- 33.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In remote sensing, a passive system:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In remote sensing, a passive system:', 'single_choice', 'easy', 'Passive remote sensing depends on a natural source to provide energy; the satellite sensor records primarily the radiation reflected from the target. Active remote sensing uses an artificial source of energy, for example a satellite that sends a pulse of energy to interact with the target.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sends its own pulse of energy to the target', false, 0),
      (v_question_id, 'Depends on a natural source of energy and records the radiation reflected from the target', true, 1),
      (v_question_id, 'Uses only microwave signals', false, 2),
      (v_question_id, 'Operates only underground', false, 3);
  END IF;

  -- 34.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which three fundamental energy interactions occur when electromagnetic energy strikes a surface?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which three fundamental energy interactions occur when electromagnetic energy strikes a surface?', 'single_choice', 'medium', 'The three fundamental energy interactions are reflection (energy bounces off the surface), absorption (energy is absorbed by the surface, which may convert it into heat or other forms), and transmission (energy passes through the surface and continues into another medium).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Refraction, scattering, and diffusion', false, 0),
      (v_question_id, 'Reflection, absorption, and transmission', true, 1),
      (v_question_id, 'Reflection, conduction, and convection', false, 2),
      (v_question_id, 'Absorption, radiation, and conduction', false, 3);
  END IF;

  -- 35.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which remote-sensing sensor type is an active sensor that emits microwave signals, can penetrate clouds, and operates at night?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which remote-sensing sensor type is an active sensor that emits microwave signals, can penetrate clouds, and operates at night?', 'single_choice', 'medium', 'Synthetic Aperture Radar (SAR) is an active sensor that emits microwave signals and measures the energy reflected back; it can penetrate clouds and operate at night, making it ideal for monitoring in all weather conditions (e.g., flood monitoring and soil moisture tracking).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Optical imagery', false, 0),
      (v_question_id, 'Thermal infrared imagery', false, 1),
      (v_question_id, 'Synthetic Aperture Radar (SAR)', true, 2),
      (v_question_id, 'Hyperspectral imagery', false, 3);
  END IF;

  -- 36.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'LiDAR (Light Detection and Ranging) creates high-resolution 3D maps of the Earth''s surface by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'LiDAR (Light Detection and Ranging) creates high-resolution 3D maps of the Earth''s surface by:', 'single_choice', 'hard', 'LiDAR uses laser pulses to create high-resolution 3D maps of the Earth''s surface. It measures the time taken by the laser pulse to bounce back from objects, which allows for precise elevation data (useful in topographic mapping and forest management).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Measuring the heat emitted by the surface', false, 0),
      (v_question_id, 'Recording the reflected natural sunlight', false, 1),
      (v_question_id, 'Measuring the time taken by laser pulses to bounce back from objects', true, 2),
      (v_question_id, 'Comparing the colors of satellite images', false, 3);
  END IF;

  -- 37.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which spectral band, covering 8-14 micrometers, is used for surface temperature, urban heat islands, and wildfire monitoring?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which spectral band, covering 8-14 micrometers, is used for surface temperature, urban heat islands, and wildfire monitoring?', 'single_choice', 'hard', 'The thermal infrared (TIR) band, 8-14 micrometers, is used for surface temperature, urban heat islands, and wildfire monitoring. TIR sensors detect heat emitted from the Earth''s surface.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blue band', false, 0),
      (v_question_id, 'Near-infrared band', false, 1),
      (v_question_id, 'Thermal infrared band', true, 2),
      (v_question_id, 'Red band', false, 3);
  END IF;

  -- 38.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Normalized Difference Vegetation Index (NDVI) is computed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Normalized Difference Vegetation Index (NDVI) is computed as:', 'single_choice', 'medium', 'NDVI = (NIR - Red)/(NIR + Red). It measures vegetation health using the red and near-infrared light reflected by plants.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '(NIR + Red)/(NIR - Red)', false, 0),
      (v_question_id, '(Red - NIR)/(Red + NIR)', false, 1),
      (v_question_id, '(NIR - Red)/(NIR + Red)', true, 2),
      (v_question_id, 'NIR x Red', false, 3);
  END IF;

  -- 39.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pixel in a multispectral image has a near-infrared reflectance of 0.50 and a red reflectance of 0.10. What is its NDVI?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pixel in a multispectral image has a near-infrared reflectance of 0.50 and a red reflectance of 0.10. What is its NDVI?', 'single_choice', 'hard', 'NDVI = (NIR - Red)/(NIR + Red) = (0.50 - 0.10)/(0.50 + 0.10) = 0.40/0.60 = 0.67.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.25', false, 0),
      (v_question_id, '0.40', false, 1),
      (v_question_id, '0.67', true, 2),
      (v_question_id, '1.50', false, 3);
  END IF;

  -- 40.
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'With GPS, positions on the Earth''s surface are quickly and accurately located by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'With GPS, positions on the Earth''s surface are quickly and accurately located by:', 'single_choice', 'medium', 'With GPS, positions on the Earth''s surface can be quickly and accurately located by measuring distances to orbiting satellites. This is done by determining the time required for radio signals broadcast by the satellites to travel to the points in question.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Measuring the time required for satellite radio signals to travel to the point in question', true, 0),
      (v_question_id, 'Measuring the angle between two ground stations', false, 1),
      (v_question_id, 'Reading the magnetic bearing of a compass', false, 2),
      (v_question_id, 'Counting the number of pixels in an aerial photograph', false, 3);
  END IF;

END $$;
