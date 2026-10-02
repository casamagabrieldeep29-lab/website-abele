-- Process Control in Agricultural Process Engineering quiz batch (42
-- questions, 1 topic). Every fact is drawn directly from a compiled
-- automation/instrumentation/control-system reference (control-system
-- theory: feedback/feedforward/PID, sensors, actuators, measurement
-- systems), a bioprocessing/crop-processing glossary (crop-drying control
-- terminology: fail-safe control, modulate, pressure regulator, valve
-- types, supervision, pre-ventilation, plenum, aeration), and two
-- Philippine Agricultural Engineering Standards governing heated-air
-- mechanical grain dryers (PAES 201:2000 Specifications and PAES 202:2000
-- Methods of Test) — all read in full (2026-10-02). No invented facts.
-- This topic had only 10 published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- unless a question is grounded in an actual PAES standard (5 questions here
-- are grounded in PAES 201:2000 / PAES 202:2000).
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Process Control in Agricultural Process Engineering (BIOPROCESS) — 42 question(s)
-- =====================================================================
DO $$
DECLARE
  v_exam_area_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
BEGIN
  SELECT id INTO v_exam_area_id FROM public.exam_areas WHERE code = 'BIOPROCESS';
  IF v_exam_area_id IS NULL THEN
    RAISE EXCEPTION 'Exam area not found: BIOPROCESS';
  END IF;

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Process Control in Agricultural Process Engineering' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Process Control in Agricultural Process Engineering';
  END IF;

  -- 1. Closed-loop control system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What best describes a closed-loop control system in an automated agricultural process?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What best describes a closed-loop control system in an automated agricultural process?', 'single_choice', 'medium', 'Closed-loop systems utilize feedback to continuously adjust the output based on the difference from the desired set-point, unlike open-loop systems which operate on a single forward action without feedback.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It operates on a single forward action without feedback', false, 0),
      (v_question_id, 'It utilizes feedback to continuously adjust its output based on the difference from the desired set-point', true, 1),
      (v_question_id, 'It only acts before a disturbance occurs, based on predicted changes', false, 2),
      (v_question_id, 'It oversees and coordinates multiple control systems without direct control', false, 3);
  END IF;

  -- 2. Open-loop control system
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In process control, an open-loop system is one that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In process control, an open-loop system is one that:', 'single_choice', 'easy', 'Open-loop systems operate on a single forward action without feedback, in contrast to closed-loop systems which continuously adjust output using feedback.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Continuously adjusts output using feedback from the process', false, 0),
      (v_question_id, 'Operates on a single forward action without feedback', true, 1),
      (v_question_id, 'Uses a comparator to calculate an error signal', false, 2),
      (v_question_id, 'Anticipates future errors before they occur', false, 3);
  END IF;

  -- 3. Feedforward control
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which control strategy acts before a problem occurs by adjusting the system based on predicted changes, such as disturbances or inputs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which control strategy acts before a problem occurs by adjusting the system based on predicted changes, such as disturbances or inputs?', 'single_choice', 'easy', 'Feedforward control acts before a problem happens by adjusting the system based on predicted changes, preventing errors instead of reacting to them.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Feedforward control', true, 0),
      (v_question_id, 'PID control', false, 1),
      (v_question_id, 'Supervisory control', false, 2),
      (v_question_id, 'Closed-loop control', false, 3);
  END IF;

  -- 4. PID control general
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PID (Proportional-Integral-Derivative) control is best classified as what type of control method?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PID (Proportional-Integral-Derivative) control is best classified as what type of control method?', 'single_choice', 'easy', 'PID control is a feedback control method that fixes errors by adjusting output in real time.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An open-loop method that ignores system output', false, 0),
      (v_question_id, 'A feedforward method that only reacts to predicted disturbances', false, 1),
      (v_question_id, 'A feedback control method that fixes errors by adjusting output in real time', true, 2),
      (v_question_id, 'A supervisory method that coordinates multiple control systems', false, 3);
  END IF;

  -- 5. PID Integral component
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In PID control, which term is specifically responsible for correcting errors that occurred in the past?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In PID control, which term is specifically responsible for correcting errors that occurred in the past?', 'single_choice', 'medium', 'In PID control, the Proportional term reacts to the current error, the Integral term corrects past errors, and the Derivative term anticipates future errors.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Proportional', false, 0),
      (v_question_id, 'Integral', true, 1),
      (v_question_id, 'Derivative', false, 2),
      (v_question_id, 'Set-point', false, 3);
  END IF;

  -- 6. Comparator
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Within the structure of a control system, which device calculates the error signal by subtracting the measured output from the set-point?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Within the structure of a control system, which device calculates the error signal by subtracting the measured output from the set-point?', 'single_choice', 'medium', 'The comparator is the device that calculates the error signal by subtracting the measured output from the set-point.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sensor', false, 0),
      (v_question_id, 'Comparator', true, 1),
      (v_question_id, 'Control element', false, 2),
      (v_question_id, 'Actuator', false, 3);
  END IF;

  -- 7. Sensor (control system structure)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the structure of a control system, what is the function of the sensor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the structure of a control system, what is the function of the sensor?', 'single_choice', 'easy', 'The sensor is a device that measures the process output and converts it into a signal, such as voltage, that can be processed.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It physically alters the process variable based on the controller''s commands', false, 0),
      (v_question_id, 'It measures the process output and converts it into a signal, such as voltage, that can be processed', true, 1),
      (v_question_id, 'It calculates the error signal by subtracting the measured output from the set-point', false, 2),
      (v_question_id, 'It stores the desired value for the process variable', false, 3);
  END IF;

  -- 8. Control Element (fundamental element of process control)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Among the fundamental elements of process control, which one is the actuator that physically alters the process variable based on the controller''s commands?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Among the fundamental elements of process control, which one is the actuator that physically alters the process variable based on the controller''s commands?', 'single_choice', 'medium', 'The Control Element is the fundamental element of process control that acts as the actuator physically altering the process variable based on the controller''s commands.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Process', false, 0),
      (v_question_id, 'Measurement', false, 1),
      (v_question_id, 'Evaluation', false, 2),
      (v_question_id, 'Control Element', true, 3);
  END IF;

  -- 9. Measurement (fundamental element)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which fundamental element of process control refers to the act of quantifying a process parameter to gather information about the system state?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which fundamental element of process control refers to the act of quantifying a process parameter to gather information about the system state?', 'single_choice', 'easy', 'Measurement is the fundamental element of process control that refers to the act of quantifying the process parameter to gather information about the system state.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Measurement', true, 0),
      (v_question_id, 'Evaluation', false, 1),
      (v_question_id, 'Process', false, 2),
      (v_question_id, 'Control Element', false, 3);
  END IF;

  -- 10. Process (fundamental element)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the fundamental elements of process control, the term "Process" refers to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the fundamental elements of process control, the term "Process" refers to:', 'single_choice', 'easy', 'Process refers to the methods of transforming raw materials into finished products.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The assessment of a measurement to determine whether corrective action is needed', false, 0),
      (v_question_id, 'The methods of transforming raw materials into finished products', true, 1),
      (v_question_id, 'The actuator that alters the process variable', false, 2),
      (v_question_id, 'The act of quantifying a process parameter', false, 3);
  END IF;

  -- 11. Process lag
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which process characteristic refers to the delay in response of the controlled variable to changes in input or load?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which process characteristic refers to the delay in response of the controlled variable to changes in input or load?', 'single_choice', 'medium', 'Process Lag refers to the delay in response of the controlled variable to changes in input or load.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Process load', false, 0),
      (v_question_id, 'Process lag', true, 1),
      (v_question_id, 'Self-regulation', false, 2),
      (v_question_id, 'Dynamic variable', false, 3);
  END IF;

  -- 12. Self-regulation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A process that can reach a steady state without any control action after a change in input is said to exhibit:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A process that can reach a steady state without any control action after a change in input is said to exhibit:', 'single_choice', 'hard', 'Self-Regulation is the ability of a process to reach a steady state without control action after a change in input.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Process lag', false, 0),
      (v_question_id, 'Process load', false, 1),
      (v_question_id, 'Self-regulation', true, 2),
      (v_question_id, 'Supervisory control', false, 3);
  END IF;

  -- 13. Set-point
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a control system, the desired value for a process variable, such as temperature or pressure, that the system aims to maintain is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a control system, the desired value for a process variable, such as temperature or pressure, that the system aims to maintain is called the:', 'single_choice', 'easy', 'The Set-Point is the desired value for a process variable that the control system aims to maintain.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Error signal', false, 0),
      (v_question_id, 'Set-point', true, 1),
      (v_question_id, 'Dynamic variable', false, 2),
      (v_question_id, 'Process load', false, 3);
  END IF;

  -- 14. Error signal
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The difference between the measured output and the desired set-point, used by the controller to adjust the system, is known as the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The difference between the measured output and the desired set-point, used by the controller to adjust the system, is known as the:', 'single_choice', 'easy', 'The Error Signal is the difference between the measured output and the desired output (set-point), used by the controller to adjust the system.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Set-point', false, 0),
      (v_question_id, 'Dynamic variable', false, 1),
      (v_question_id, 'Error signal', true, 2),
      (v_question_id, 'Process lag', false, 3);
  END IF;

  -- 15. SCADA
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'SCADA, commonly used for remote monitoring and control of infrastructure and facility-based agricultural processes, stands for:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'SCADA, commonly used for remote monitoring and control of infrastructure and facility-based agricultural processes, stands for:', 'single_choice', 'medium', 'SCADA (Supervisory Control and Data Acquisition) is an industrial control system used for remote sensing and control of infrastructure and facility-based processes.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Supervisory Control and Data Acquisition', true, 0),
      (v_question_id, 'Sensor Calibration and Data Analysis', false, 1),
      (v_question_id, 'System Control and Dynamic Adjustment', false, 2),
      (v_question_id, 'Supervised Crop and Drying Automation', false, 3);
  END IF;

  -- 16. Supervisory control
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which control concept oversees and coordinates multiple control systems, focusing on high-level management rather than direct control?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which control concept oversees and coordinates multiple control systems, focusing on high-level management rather than direct control?', 'single_choice', 'medium', 'Supervisory control oversees and coordinates multiple control systems, focusing on high-level management rather than direct control, ensuring everything works together smoothly.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Feedforward control', false, 0),
      (v_question_id, 'PID control', false, 1),
      (v_question_id, 'Supervisory control', true, 2),
      (v_question_id, 'Closed-loop control', false, 3);
  END IF;

  -- 17. Transducer
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a measurement system, a transducer is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a measurement system, a transducer is best described as:', 'single_choice', 'easy', 'A transducer is a sensing device that converts a physical input into an output, usually a voltage.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An instrument that maintains sensor data for online monitoring', false, 0),
      (v_question_id, 'A device that performs filtering and amplification on a signal', false, 1),
      (v_question_id, 'A sensing device that converts a physical input into an output, usually a voltage', true, 2),
      (v_question_id, 'A device that oversees multiple control systems', false, 3);
  END IF;

  -- 18. Signal processor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the function of the signal processor in a measurement system?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the function of the signal processor in a measurement system?', 'single_choice', 'medium', 'The signal processor performs filtering, amplification, or other signal conditioning on the transducer output.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It converts a physical input into a voltage output', false, 0),
      (v_question_id, 'It performs filtering, amplification, or other signal conditioning on the transducer output', true, 1),
      (v_question_id, 'It maintains the sensor data for online monitoring or subsequent processing', false, 2),
      (v_question_id, 'It calculates the error signal from the set-point', false, 3);
  END IF;

  -- 19. Recorder
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a measurement system, a recorder is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a measurement system, a recorder is:', 'single_choice', 'medium', 'A recorder is an instrument, a computer, a hard-copy device, or simply a display that maintains the sensor data for online monitoring or subsequent processing.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A sensing device that converts a physical input into a voltage', false, 0),
      (v_question_id, 'A device that filters and amplifies the transducer''s signal', false, 1),
      (v_question_id, 'An instrument, computer, hard-copy device, or display that maintains the sensor data for online monitoring or subsequent processing', true, 2),
      (v_question_id, 'The comparator that calculates the error signal', false, 3);
  END IF;

  -- 20. Measurement system signal flow order
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the standard elements of a measurement system, such as a digital thermometer built from a thermocouple, amplifier, and LED display, what is the correct order of signal flow?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the standard elements of a measurement system, such as a digital thermometer built from a thermocouple, amplifier, and LED display, what is the correct order of signal flow?', 'single_choice', 'hard', 'A measurement system flows from the transducer (e.g., a thermocouple), to the signal processor (e.g., amplifier and A/D display decoder), to the recorder (e.g., LED display) that maintains the data for monitoring.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Signal processor, then transducer, then recorder', false, 0),
      (v_question_id, 'Recorder, then transducer, then signal processor', false, 1),
      (v_question_id, 'Transducer, then signal processor, then recorder', true, 2),
      (v_question_id, 'Transducer, then recorder, then signal processor', false, 3);
  END IF;

  -- 21. RTD
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A Resistive Temperature Device (RTD), known for high accuracy and stability and commonly used in greenhouse monitoring and process control, measures temperature using:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A Resistive Temperature Device (RTD), known for high accuracy and stability and commonly used in greenhouse monitoring and process control, measures temperature using:', 'single_choice', 'easy', 'An RTD measures temperature using a resistor that changes with heat, and is known for high accuracy and stability.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Infrared radiation emitted by objects', false, 0),
      (v_question_id, 'A resistor that changes with heat', true, 1),
      (v_question_id, 'High-frequency sound waves', false, 2),
      (v_question_id, 'Reflected near-infrared light', false, 3);
  END IF;

  -- 22. Thermal sensor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A thermal sensor used in agricultural monitoring detects temperature differences by sensing:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A thermal sensor used in agricultural monitoring detects temperature differences by sensing:', 'single_choice', 'easy', 'A thermal sensor detects infrared radiation (heat) emitted by objects to measure temperature differences.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Infrared radiation (heat) emitted by objects', true, 0),
      (v_question_id, 'Reflected visible red light', false, 1),
      (v_question_id, 'High-frequency sound waves', false, 2),
      (v_question_id, 'Atmospheric pressure', false, 3);
  END IF;

  -- 23. NDVI formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An NDVI (Normalized Difference Vegetation Index) sensor assesses vegetation health using which formula?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An NDVI (Normalized Difference Vegetation Index) sensor assesses vegetation health using which formula?', 'single_choice', 'hard', 'NDVI is calculated as (NIR - Red)/(NIR + Red), measuring vegetation health by capturing visible (red) and near-infrared (NIR) light reflected by plants.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'NDVI = (NIR + Red) / (NIR - Red)', false, 0),
      (v_question_id, 'NDVI = (NIR - Red) / (NIR + Red)', true, 1),
      (v_question_id, 'NDVI = (Red - NIR) / (Red + NIR)', false, 2),
      (v_question_id, 'NDVI = NIR / Red', false, 3);
  END IF;

  -- 24. Ultrasonic sensor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An ultrasonic sensor detects the distance or presence of objects by using:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An ultrasonic sensor detects the distance or presence of objects by using:', 'single_choice', 'easy', 'An ultrasonic sensor uses high-frequency sound waves to detect distance or the presence of objects.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Infrared radiation', false, 0),
      (v_question_id, 'High-frequency sound waves', true, 1),
      (v_question_id, 'Visible and near-infrared light', false, 2),
      (v_question_id, 'Atmospheric pressure changes', false, 3);
  END IF;

  -- 25. Pneumatic valve
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pneumatic valve used in air-powered agricultural machines such as sprayers and seeders controls air flow by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pneumatic valve used in air-powered agricultural machines such as sprayers and seeders controls air flow by:', 'single_choice', 'medium', 'A pneumatic valve controls air flow in a system using compressed air or air pressure, and is used in air-powered machines like sprayers, seeders, or robotic arms.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Opening and closing using an electromagnet', false, 0),
      (v_question_id, 'Using compressed air or air pressure', true, 1),
      (v_question_id, 'Moving in fixed steps via an electric motor', false, 2),
      (v_question_id, 'Creating precise straight-line motion via a servo motor', false, 3);
  END IF;

  -- 26. Linear servo motor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which actuator is an electric motor that creates precise straight-line motion, used for tasks like robotic positioning, cutting, or automated planting?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which actuator is an electric motor that creates precise straight-line motion, used for tasks like robotic positioning, cutting, or automated planting?', 'single_choice', 'medium', 'A linear servo motor is an electric motor that creates precise straight-line motion, offering high precision and control for tasks like robotic positioning, cutting, or automated planting.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Solenoid valve', false, 0),
      (v_question_id, 'Stepper motor', false, 1),
      (v_question_id, 'Linear servo motor', true, 2),
      (v_question_id, 'Pneumatic valve', false, 3);
  END IF;

  -- 27. Stepper motor
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An actuator that is an electric motor moving in fixed steps, good for precise positioning tasks such as automated dosing or feeders, is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An actuator that is an electric motor moving in fixed steps, good for precise positioning tasks such as automated dosing or feeders, is called a:', 'single_choice', 'medium', 'A stepper motor is an electric motor that moves in fixed steps, good for precise positioning like in 3D printers, feeders, or automated dosing.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Linear servo motor', false, 0),
      (v_question_id, 'Stepper motor', true, 1),
      (v_question_id, 'Solenoid valve', false, 2),
      (v_question_id, 'Pneumatic valve', false, 3);
  END IF;

  -- 28. Control (crop drying general definition)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the context of crop drying operations, the term "control" is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the context of crop drying operations, the term "control" is defined as:', 'single_choice', 'easy', 'In crop drying, "control" means to affect or limit any normal or abnormal condition of the drying operation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The rapid removal of moisture, usually to a very low level', false, 0),
      (v_question_id, 'Affecting or limiting any normal or abnormal condition of the drying operation', true, 1),
      (v_question_id, 'The movement of air at a low rate through a product to maintain or improve product quality', false, 2),
      (v_question_id, 'Equalization of moisture or temperature throughout the product', false, 3);
  END IF;

  -- 29. Fail-safe control
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fail-safe control, as applied to a crop dryer, is a control:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fail-safe control, as applied to a crop dryer, is a control:', 'single_choice', 'medium', 'Fail-safe control is designed so that a malfunction of any of its components will stop the operation of the device or equipment controlled by it.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Designed so that a malfunction of any of its components will stop the operation of the device or equipment it controls', true, 0),
      (v_question_id, 'That automatically governs fuel flow rate to maintain a constant temperature', false, 1),
      (v_question_id, 'That reduces fluid pressure to a relatively constant delivery pressure', false, 2),
      (v_question_id, 'That clears volatile gases from the plenum chamber before ignition', false, 3);
  END IF;

  -- 30. Modulate
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'As applied to crop drying in continuous flow, to "modulate" means to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'As applied to crop drying in continuous flow, to "modulate" means to:', 'single_choice', 'hard', 'To modulate means to automatically govern the rate of fuel flow by a control which is temperature-sensitive in order to maintain a constant temperature at the location of the sensing device.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Manually shut off fuel flow using a quick-acting valve', false, 0),
      (v_question_id, 'Automatically govern the rate of fuel flow using a temperature-sensitive control to maintain a constant temperature at the sensing device', true, 1),
      (v_question_id, 'Purge the plenum chamber of volatile gases before ignition', false, 2),
      (v_question_id, 'Continuously monitor and react to flame failure by shutting off gas flow', false, 3);
  END IF;

  -- 31. Pressure regulator
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pressure regulator in a crop dryer''s fuel system is a mechanical device that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pressure regulator in a crop dryer''s fuel system is a mechanical device that:', 'single_choice', 'medium', 'A pressure regulator is a mechanical device which reduces the fluid (liquid or gas) pressure to a relatively constant delivery pressure while the inlet pressure may vary and the volume of gas may also vary.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Reduces fluid (liquid or gas) pressure to a relatively constant delivery pressure while inlet pressure and gas volume may vary', true, 0),
      (v_question_id, 'Opens and closes using an electromagnet', false, 1),
      (v_question_id, 'Limits excessive fluid flow in one direction and closes automatically if exceeded', false, 2),
      (v_question_id, 'Purges volatile gases from the dryer duct before ignition', false, 3);
  END IF;

  -- 32. Valve, solenoid (crop dryer fuel train)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a crop dryer''s fuel train, a normally-closed solenoid valve is best described as a valve that is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a crop dryer''s fuel train, a normally-closed solenoid valve is best described as a valve that is:', 'single_choice', 'medium', 'A solenoid valve is opened or closed using a solenoid (electromagnet). In the normally-closed type, the valve is opened by the solenoid but closed by a return spring and held closed by the fluid pressure upstream from the valve.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Opened by the solenoid (electromagnet) but closed by a return spring and held closed by upstream fluid pressure', true, 0),
      (v_question_id, 'A check valve that closes automatically once a designated flow is exceeded', false, 1),
      (v_question_id, 'A manually operated valve for rapid shut-off of fuel flow', false, 2),
      (v_question_id, 'A device that reduces fluid pressure to a constant delivery pressure', false, 3);
  END IF;

  -- 33. Valve, excess-flow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An excess-flow valve in a crop dryer''s fuel system is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An excess-flow valve in a crop dryer''s fuel system is best described as:', 'single_choice', 'hard', 'An excess-flow valve is a check valve which permits flow of fluid in either direction but which limits excessive flow in one direction; if the designated flow is exceeded, the valve automatically closes.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A valve opened by a solenoid and closed by a spring', false, 0),
      (v_question_id, 'A check valve that permits flow in either direction but automatically closes if the designated flow is exceeded', true, 1),
      (v_question_id, 'A device that governs fuel flow rate based on a temperature-sensitive control', false, 2),
      (v_question_id, 'A safety device that opens to discharge fluid once a set pressure is reached', false, 3);
  END IF;

  -- 34. Pre-ventilation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '"Pre-ventilation," as applied to crop dryers, refers to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, '"Pre-ventilation," as applied to crop dryers, refers to:', 'single_choice', 'hard', 'Pre-ventilation refers to clearing or purging the plenum chamber or duct of any volatile gases prior to ignition of the burner, usually accomplished by a device ensuring the fan operates for a certain period before ignition is permitted.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The movement of air at a low rate through stored grain to cool it', false, 0),
      (v_question_id, 'Clearing or purging the plenum chamber or duct of any volatile gases prior to ignition of the burner', true, 1),
      (v_question_id, 'The return of a portion of exhaust air back to the air intake of the dryer', false, 2),
      (v_question_id, 'Continuous monitoring that reacts automatically to flame failure', false, 3);
  END IF;

  -- 35. Supervision (crop dryer safety monitoring)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a crop dryer''s safety and control system, "supervision" refers to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a crop dryer''s safety and control system, "supervision" refers to:', 'single_choice', 'medium', 'Supervision is continuous monitoring to react automatically to flame failure so as to shut off gas flow to the unit.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Continuous monitoring to react automatically to flame failure so as to shut off gas flow to the unit', true, 0),
      (v_question_id, 'Automatically governing fuel flow rate to maintain a constant temperature', false, 1),
      (v_question_id, 'Reducing fluid pressure to a constant delivery pressure', false, 2),
      (v_question_id, 'Purging the duct of volatile gases before ignition', false, 3);
  END IF;

  -- 36. Plenum
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In a grain dryer''s air distribution system, the plenum is:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In a grain dryer''s air distribution system, the plenum is:', 'single_choice', 'easy', 'The plenum is an air chamber maintained under pressure (positive or negative), usually connected to one or more distributing ducts, where air pressure is developed for uniform distribution of the heated air through the grain mass.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A device used to transfer heat from one fluid stream to another without intermixing', false, 0),
      (v_question_id, 'An air chamber maintained under pressure where air pressure is developed for uniform distribution of heated air through the grain mass', true, 1),
      (v_question_id, 'A mechanical device that reduces fuel pressure to a constant delivery pressure', false, 2),
      (v_question_id, 'A valve that opens and closes using an electromagnet', false, 3);
  END IF;

  -- 37. Static pressure (PAES 202:2000)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 202:2000 (Methods of Test for Heated-Air Mechanical Grain Dryers), static pressure is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 202:2000 (Methods of Test for Heated-Air Mechanical Grain Dryers), static pressure is defined as:', 'single_choice', 'medium', 'PAES 202:2000 defines static pressure as the pressure build-up in the plenum chamber to maintain uniform distribution of air flow through the grain mass, expressed in Pascal.', NULL, NULL, 'draft', false, NULL, true, 'PAES 202:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The ratio of heat released by fuel to the theoretical heat available from the fuel', false, 0),
      (v_question_id, 'The pressure build-up in the plenum chamber to maintain uniform distribution of airflow through the grain mass, expressed in Pascal', true, 1),
      (v_question_id, 'The mean temperature of air used for drying, measured near its entry to the grain bed', false, 2),
      (v_question_id, 'The amount of water removed per unit of time, expressed in kilograms per hour', false, 3);
  END IF;

  -- 38. PAES 201:2000 instrumentation requirement
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Under PAES 201:2000 (Specifications for Heated-Air Mechanical Grain Dryers), what instrumentation must the dryer be provided with?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Under PAES 201:2000 (Specifications for Heated-Air Mechanical Grain Dryers), what instrumentation must the dryer be provided with?', 'single_choice', 'medium', 'PAES 201:2000 requires the dryer to be provided with a thermometer to measure the actual air temperature entering the grain mass and a pressure gauge to measure the working static pressure in the plenum.', NULL, NULL, 'draft', false, NULL, true, 'PAES 201:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A pitot tube and a manometer only', false, 0),
      (v_question_id, 'A thermometer to measure air temperature entering the grain mass and a pressure gauge to measure the working static pressure in the plenum', true, 1),
      (v_question_id, 'An NDVI sensor and an ultrasonic sensor', false, 2),
      (v_question_id, 'A solenoid valve and a pressure regulator only', false, 3);
  END IF;

  -- 39. PAES 202:2000 thermometer locations
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Per PAES 202:2000 test set-up procedures, thermometers for temperature sensing during a grain dryer performance test shall be mounted at how many distinct locations?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Per PAES 202:2000 test set-up procedures, thermometers for temperature sensing during a grain dryer performance test shall be mounted at how many distinct locations?', 'single_choice', 'hard', 'PAES 202:2000 requires thermometers to be mounted at four locations: near the dryer to sense ambient temperature, at the grain-plenum interface, after the plenum, and immediately outside the dryer to sense exhaust air temperature.', NULL, NULL, 'draft', false, NULL, true, 'PAES 202:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Two', false, 0),
      (v_question_id, 'Three', false, 1),
      (v_question_id, 'Four', true, 2),
      (v_question_id, 'Five', false, 3);
  END IF;

  -- 40. PAES 202:2000 airflow/static pressure measuring apparatus
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'According to PAES 202:2000, which apparatus is installed for the measurement of airflow and static pressure during a grain dryer test?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'According to PAES 202:2000, which apparatus is installed for the measurement of airflow and static pressure during a grain dryer test?', 'single_choice', 'easy', 'PAES 202:2000 specifies that for the measurement of airflow and static pressure, a pitot tube and manometer or any other suitable apparatus shall be installed.', NULL, NULL, 'draft', false, NULL, true, 'PAES 202:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An NDVI multispectral camera', false, 0),
      (v_question_id, 'A pitot tube and manometer', true, 1),
      (v_question_id, 'A linear servo motor', false, 2),
      (v_question_id, 'An RTD sensor', false, 3);
  END IF;

  -- 41. Safety device (PAES 201:2000)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'PAES 201:2000 defines a "safety device" on a heated-air mechanical grain dryer as any device that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'PAES 201:2000 defines a "safety device" on a heated-air mechanical grain dryer as any device that:', 'single_choice', 'medium', 'PAES 201:2000 defines a safety device as any device that is used to avoid human accident and/or damage to the parts and components of the dryer during operation, and automatically shuts off the operation of the dryer in case of malfunction.', NULL, NULL, 'draft', false, NULL, true, 'PAES 201:2000')
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Automatically governs fuel flow to maintain a constant drying temperature', false, 0),
      (v_question_id, 'Is used to avoid human accident and/or damage to the dryer''s parts and components, automatically shutting off the dryer''s operation in case of malfunction', true, 1),
      (v_question_id, 'Reduces fluid pressure to a constant delivery pressure', false, 2),
      (v_question_id, 'Measures the moisture gradient of the dried grain', false, 3);
  END IF;

  -- 42. Aeration airflow rate limit
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In crop post-harvest processing, aeration (the movement of air at a low rate through stored product to maintain or improve its quality) typically uses air flow rates that do not exceed:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In crop post-harvest processing, aeration (the movement of air at a low rate through stored product to maintain or improve its quality) typically uses air flow rates that do not exceed:', 'single_choice', 'hard', 'Aeration air flow rates usually do not exceed 0.08 cubic meters per minute per cubic meter of product.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.008 cubic meters per minute per cubic meter of product', false, 0),
      (v_question_id, '0.08 cubic meters per minute per cubic meter of product', true, 1),
      (v_question_id, '0.8 cubic meters per minute per cubic meter of product', false, 2),
      (v_question_id, '8.0 cubic meters per minute per cubic meter of product', false, 3);
  END IF;

END $$;
