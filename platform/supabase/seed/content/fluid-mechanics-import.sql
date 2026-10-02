-- Fluid Mechanics quiz batch (65 questions, 1 topic). Every fact, formula,
-- and number is drawn directly from a fluid mechanics exam-review document
-- (7-page lecture notes covering fluid properties, hydrostatics, dams,
-- buoyancy, fluid flow fundamentals, energy/Bernoulli/continuity equations,
-- dimensionless numbers, flow-measuring instruments, weirs, and pipe head
-- losses) and a companion 33-slide practice-question deck with 13 solved
-- numerical/conceptual problems, both read in full (2026-10-02) — no
-- invented facts. This topic had zero published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- throughout, since this material is general engineering science, not a PAES
-- standard.
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Fluid Mechanics (MATH_BASIC_ENGG) — 65 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Fluid Mechanics' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Fluid Mechanics';
  END IF;

  -- 1. Definition of fluid mechanics
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fluid mechanics is best defined as which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Fluid mechanics is best defined as which of the following?', 'single_choice', 'easy', 'Fluid mechanics is the physical science dealing with the action of fluids at rest or in motion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The physical science dealing with the action of fluids at rest or in motion', true, 0),
      (v_question_id, 'The study of solid materials under stress', false, 1),
      (v_question_id, 'The branch of chemistry concerned with molecular bonding', false, 2),
      (v_question_id, 'The study of heat transfer in gases only', false, 3);
  END IF;

  -- 2. Fluid statics vs fluid dynamics
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which branch of fluid mechanics is concerned specifically with fluids in motion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which branch of fluid mechanics is concerned specifically with fluids in motion?', 'single_choice', 'easy', 'Fluid statics deals with fluids at rest, while fluid dynamics is concerned with fluids in motion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fluid statics', false, 0),
      (v_question_id, 'Fluid dynamics', true, 1),
      (v_question_id, 'Thermodynamics', false, 2),
      (v_question_id, 'Kinematics of solids', false, 3);
  END IF;

  -- 3. Hydraulics definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which term refers to the laws controlling the behavior of water and other liquids at rest and in motion, covering problems such as flow through pipes or open channels, dam design, pumps, and devices like nozzles?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which term refers to the laws controlling the behavior of water and other liquids at rest and in motion, covering problems such as flow through pipes or open channels, dam design, pumps, and devices like nozzles?', 'single_choice', 'medium', 'Hydraulics covers the laws controlling the behavior of water and other liquids at rest and in motion, including flow through pipes or open channels, the design of storage dams and pumps, and devices such as nozzles.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hydrostatics', false, 0),
      (v_question_id, 'Hydrodynamics', false, 1),
      (v_question_id, 'Hydraulics', true, 2),
      (v_question_id, 'Hydrokinetics', false, 3);
  END IF;

  -- 4. Hydrokinetics definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which branch of fluid mechanics deals with the geometry of motion of liquids without considering the forces that cause that motion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which branch of fluid mechanics deals with the geometry of motion of liquids without considering the forces that cause that motion?', 'single_choice', 'medium', 'Hydrokinetics deals with the geometry of motion of liquids without considering the forces causing that motion, while hydrodynamics deals with the forces exerted by or upon liquids in motion.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Hydrostatics', false, 0),
      (v_question_id, 'Hydrokinetics', true, 1),
      (v_question_id, 'Hydrodynamics', false, 2),
      (v_question_id, 'Hydraulics', false, 3);
  END IF;

  -- 5. Definition of a fluid
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A fluid is best defined as a substance that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A fluid is best defined as a substance that:', 'single_choice', 'easy', 'A fluid is any substance that deforms continuously so long as shear stress is applied.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Maintains a fixed shape regardless of applied forces', false, 0),
      (v_question_id, 'Deforms continuously so long as shear stress is applied', true, 1),
      (v_question_id, 'Can only exist in the liquid state', false, 2),
      (v_question_id, 'Has zero density', false, 3);
  END IF;

  -- 6. Ideal vs real fluid
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following correctly describes an assumption of an ideal fluid, as opposed to a real fluid?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following correctly describes an assumption of an ideal fluid, as opposed to a real fluid?', 'single_choice', 'medium', 'Ideal fluids are assumed to have no viscosity (no resistance to shear), are incompressible, have uniform velocity when flowing, and experience no friction or turbulence. Real fluids, by contrast, exhibit viscosity, are compressible, have non-uniform velocity distribution, and experience friction and turbulence.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'It exhibits infinite viscosity', false, 0),
      (v_question_id, 'It is compressible', false, 1),
      (v_question_id, 'It is assumed to have no viscosity and hence no resistance to shear', true, 2),
      (v_question_id, 'It experiences friction and turbulence in flow', false, 3);
  END IF;

  -- 7. Three fundamental principles of fluid motion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Fluids in motion are based on which three fundamental principles?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Fluids in motion are based on which three fundamental principles?', 'single_choice', 'easy', 'Fluids in motion are based on the principle of conservation of mass, the energy principle (kinetic and potential), and the principle of momentum.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conservation of mass, the energy principle, and the principle of momentum', true, 0),
      (v_question_id, 'Conservation of charge, conservation of energy, and Newton''s third law', false, 1),
      (v_question_id, 'The ideal gas law, Boyle''s law, and Charles''s law', false, 2),
      (v_question_id, 'Ohm''s law, Faraday''s law, and Lenz''s law', false, 3);
  END IF;

  -- 8. Density formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Density (ρ) of a fluid is defined by which relationship?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Density (ρ) of a fluid is defined by which relationship?', 'single_choice', 'easy', 'Density is the mass of fluid contained in a unit volume: ρ = m/∀ = γ/g.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ρ = m/∀ = γ/g', true, 0),
      (v_question_id, 'ρ = W/m', false, 1),
      (v_question_id, 'ρ = ∀/m', false, 2),
      (v_question_id, 'ρ = γ × g²', false, 3);
  END IF;

  -- 9. Specific weight formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The unit weight or specific weight (γ) of a fluid is calculated as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The unit weight or specific weight (γ) of a fluid is calculated as:', 'single_choice', 'medium', 'Unit weight/specific weight is the weight of fluid contained in a unit volume: γ = W/∀ = (m×g)/∀ = ρg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'γ = W/∀ = (m×g)/∀ = ρg', true, 0),
      (v_question_id, 'γ = m/∀', false, 1),
      (v_question_id, 'γ = ∀/m', false, 2),
      (v_question_id, 'γ = W × ∀', false, 3);
  END IF;

  -- 10. Specific gravity definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Specific gravity of a fluid is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Specific gravity of a fluid is best described as:', 'single_choice', 'easy', 'Specific gravity is a dimensionless ratio of the specific weight or density of a fluid to the specific weight or density of a standard substance (commonly water).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A dimensionless ratio of a fluid''s density (or specific weight) to that of a standard reference substance', true, 0),
      (v_question_id, 'The absolute weight of a fluid in Newtons', false, 1),
      (v_question_id, 'The volume occupied by a unit mass of fluid', false, 2),
      (v_question_id, 'The frictional resistance of a fluid to shear', false, 3);
  END IF;

  -- 11. Specific volume definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Specific volume (v) of a fluid is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Specific volume (v) of a fluid is defined as:', 'single_choice', 'medium', 'Specific volume is volume per unit mass of fluid, the inverse of density: v = ∀/m = 1/ρ.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The volume per unit mass of fluid, equal to the inverse of density: v = ∀/m = 1/ρ', true, 0),
      (v_question_id, 'The mass per unit volume of fluid', false, 1),
      (v_question_id, 'The weight per unit volume of fluid', false, 2),
      (v_question_id, 'The ratio of actual to theoretical volume', false, 3);
  END IF;

  -- 12. Compressibility and bulk modulus relationship
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The bulk modulus of elasticity (EB) of a fluid is related to compressibility (β) by which expression?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The bulk modulus of elasticity (EB) of a fluid is related to compressibility (β) by which expression?', 'single_choice', 'hard', 'Compressibility (β) is the frictional change in volume of a fluid per unit change in pressure at constant temperature: β = -(d∀/∀)/dp = 1/EB. So the bulk modulus of elasticity EB = -dp/(d∀/∀) = 1/β.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'EB = -dp/(d∀/∀) = 1/β', true, 0),
      (v_question_id, 'EB = β²', false, 1),
      (v_question_id, 'EB = ρ × β', false, 2),
      (v_question_id, 'EB = β/(ρg)', false, 3);
  END IF;

  -- 13. Dynamic viscosity + poise conversion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Dynamic (absolute) viscosity (μ) measures a fluid''s resistance to shear and is expressed in Pa-s or poise. What is the correct conversion between these units?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Dynamic (absolute) viscosity (μ) measures a fluid''s resistance to shear and is expressed in Pa-s or poise. What is the correct conversion between these units?', 'single_choice', 'medium', 'Dynamic/absolute viscosity (μ) is measured in Pa-s and poise, where 1 poise = 0.1 Pa-s.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 poise = 0.1 Pa-s', true, 0),
      (v_question_id, '1 poise = 10 Pa-s', false, 1),
      (v_question_id, '1 poise = 1 Pa-s', false, 2),
      (v_question_id, '1 poise = 100 Pa-s', false, 3);
  END IF;

  -- 14. Kinematic viscosity + stoke conversion
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Kinematic viscosity (ν) is the ratio of absolute viscosity to density, measured in m²/s or Stoke. What is the correct conversion?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Kinematic viscosity (ν) is the ratio of absolute viscosity to density, measured in m²/s or Stoke. What is the correct conversion?', 'single_choice', 'medium', 'Kinematic viscosity ν = μ/ρ is measured in m²/s and Stoke, where 1 Stoke = 0.0001 m²/s.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1 Stoke = 0.0001 m²/s', true, 0),
      (v_question_id, '1 Stoke = 1 m²/s', false, 1),
      (v_question_id, '1 Stoke = 0.1 m²/s', false, 2),
      (v_question_id, '1 Stoke = 100 m²/s', false, 3);
  END IF;

  -- 15. Capillarity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Capillarity refers to a fluid''s ability to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Capillarity refers to a fluid''s ability to:', 'single_choice', 'easy', 'Capillarity is the ability of a fluid to move through small spaces due to adhesive and cohesive forces.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Resist deformation under shear', false, 0),
      (v_question_id, 'Move through small spaces due to adhesive and cohesive forces', true, 1),
      (v_question_id, 'Change volume under pressure', false, 2),
      (v_question_id, 'Maintain constant density regardless of temperature', false, 3);
  END IF;

  -- 16. Surface tension
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Surface tension primarily affects:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Surface tension primarily affects:', 'single_choice', 'easy', 'Surface tension affects the behavior of liquids at the interface with other materials.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The compressibility of a fluid under pressure', false, 0),
      (v_question_id, 'The behavior of liquids at the interface with other materials', true, 1),
      (v_question_id, 'The viscosity of a fluid at high temperatures', false, 2),
      (v_question_id, 'The density of a fluid at standard conditions', false, 3);
  END IF;

  -- 17. Viscosity as resistance to flow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which fluid property is defined as a measure of a fluid''s resistance to flow, describing the internal friction of a moving fluid?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which fluid property is defined as a measure of a fluid''s resistance to flow, describing the internal friction of a moving fluid?', 'single_choice', 'easy', 'Viscosity is the property that measures a fluid''s resistance to flow and describes the internal friction of a moving fluid.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Density', false, 0),
      (v_question_id, 'Viscosity', true, 1),
      (v_question_id, 'Shear rate', false, 2),
      (v_question_id, 'Consistency', false, 3);
  END IF;

  -- 18. Pascal's Law
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Pascal''s Law, attributed to Blaise Pascal, states that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Pascal''s Law, attributed to Blaise Pascal, states that:', 'single_choice', 'easy', 'Pascal''s Law (Blaise Pascal) states that the pressure on a fluid is equal in all directions and in all parts of the container.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pressure on a fluid is equal in all directions and in all parts of the container', true, 0),
      (v_question_id, 'Pressure decreases uniformly with depth in any fluid', false, 1),
      (v_question_id, 'A body immersed in a fluid experiences an upward force equal to its own weight', false, 2),
      (v_question_id, 'Fluid velocity is inversely proportional to cross-sectional area', false, 3);
  END IF;

  -- 19. Absolute pressure formula and atmospheric equivalents
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Absolute pressure is related to atmospheric and gage pressure by which formula, and what is standard atmospheric pressure at sea level in SI units?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Absolute pressure is related to atmospheric and gage pressure by which formula, and what is standard atmospheric pressure at sea level in SI units?', 'single_choice', 'medium', 'Absolute pressure equals atmospheric pressure plus gage pressure (Pabs = Patm + Pgage). Under normal conditions at sea level, atmospheric pressure equals 101.325 kPa, equivalent to 14.7 psi and 760 mmHg.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Pabs = Patm + Pgage; standard atmospheric pressure = 101.325 kPa', true, 0),
      (v_question_id, 'Pabs = Patm - Pgage; standard atmospheric pressure = 14.7 kPa', false, 1),
      (v_question_id, 'Pabs = Pgage - Patm; standard atmospheric pressure = 76 kPa', false, 2),
      (v_question_id, 'Pabs = Patm × Pgage; standard atmospheric pressure = 1 kPa', false, 3);
  END IF;

  -- 20. Pressure head formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The energy contained in a fluid, expressed as head (h), in terms of pressure (P) and unit weight (γ), is given by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The energy contained in a fluid, expressed as head (h), in terms of pressure (P) and unit weight (γ), is given by:', 'single_choice', 'medium', 'The energy contained in a fluid (head) is given by h = P/γ.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'h = P/γ', true, 0),
      (v_question_id, 'h = P × γ', false, 1),
      (v_question_id, 'h = γ/P', false, 2),
      (v_question_id, 'h = P + γ', false, 3);
  END IF;

  -- 21. Purposes of dams
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Dams serve which of the following purposes?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Dams serve which of the following purposes?', 'single_choice', 'easy', 'Dams are structures that block the flow of a river or waterway; some divert flow into a pipeline, canal, or channel, or raise the level of inland waterways; many harness falling water to generate electric power; and they also hold water for drinking and crop irrigation, and provide flood control.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Blocking, diverting, or raising the level of flow in a waterway, generating power, holding water for irrigation/drinking, and flood control', true, 0),
      (v_question_id, 'Only generating hydroelectric power', false, 1),
      (v_question_id, 'Only providing flood control', false, 2),
      (v_question_id, 'Only diverting water for crop irrigation', false, 3);
  END IF;

  -- 22. Gravity dam
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A dam that uses only the force of gravity to resist water pressure is classified as a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A dam that uses only the force of gravity to resist water pressure is classified as a:', 'single_choice', 'medium', 'Gravity dams use only the force of gravity to resist water pressure.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gravity dam', true, 0),
      (v_question_id, 'Arch dam', false, 1),
      (v_question_id, 'Buttress dam', false, 2),
      (v_question_id, 'None of the above', false, 3);
  END IF;

  -- 23. Embankment dam
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An embankment dam is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An embankment dam is best described as:', 'single_choice', 'medium', 'An embankment dam is a gravity dam formed out of loose rock, earth, or a combination of these materials.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A gravity dam formed out of loose rock, earth, or a combination of these materials', true, 0),
      (v_question_id, 'A concrete structure curving upstream into a reservoir', false, 1),
      (v_question_id, 'A wall supported by several buttresses on the downstream side', false, 2),
      (v_question_id, 'A structure that relies solely on arch action to resist water pressure', false, 3);
  END IF;

  -- 24. Arch dam
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of dam consists of concrete or masonry structures that curve upstream into a reservoir, stretching from one wall of a river canyon to the other?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of dam consists of concrete or masonry structures that curve upstream into a reservoir, stretching from one wall of a river canyon to the other?', 'single_choice', 'medium', 'Arch dams are concrete or masonry structures that curve upstream into a reservoir, stretching from one wall of a river canyon to the other.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gravity dam', false, 0),
      (v_question_id, 'Embankment dam', false, 1),
      (v_question_id, 'Arch dam', true, 2),
      (v_question_id, 'Buttress dam', false, 3);
  END IF;

  -- 25. Uplift pressure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the analysis of gravity dams, the pressure under the dam that produces an overturning effect is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the analysis of gravity dams, the pressure under the dam that produces an overturning effect is called:', 'single_choice', 'medium', 'Uplift pressure is the pressure under a gravity dam that produces an overturning effect.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Wave pressure', false, 0),
      (v_question_id, 'Uplift pressure', true, 1),
      (v_question_id, 'Hydrostatic pressure', false, 2),
      (v_question_id, 'Tail water pressure', false, 3);
  END IF;

  -- 26. Wave pressure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The pressure that arises from wind-driven waves on a reservoir surface, exerting pressure on a dam''s upstream face, is known as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The pressure that arises from wind-driven waves on a reservoir surface, exerting pressure on a dam''s upstream face, is known as:', 'single_choice', 'medium', 'Wave pressure arises from wind-driven waves on the reservoir surface, exerting pressure on the dam''s upstream force.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Uplift pressure', false, 0),
      (v_question_id, 'Wave pressure', true, 1),
      (v_question_id, 'Tail water pressure', false, 2),
      (v_question_id, 'Dynamic pressure', false, 3);
  END IF;

  -- 27. Archimedes' Principle
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Archimedes'' Principle, also known as the law of hydrostatics, states that:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Archimedes'' Principle, also known as the law of hydrostatics, states that:', 'single_choice', 'easy', 'Archimedes'' Principle (the law of hydrostatics) states that any body immersed in a fluid is acted upon by an upward force (buoyant force) equal to the weight of the displaced fluid.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Any body immersed in a fluid is acted upon by an upward force (buoyant force) equal to the weight of the displaced fluid', true, 0),
      (v_question_id, 'Pressure in a fluid is equal in all directions', false, 1),
      (v_question_id, 'The total energy of a flowing fluid is constant along the flow path', false, 2),
      (v_question_id, 'The discharge at every section of a stream is the same', false, 3);
  END IF;

  -- 28. Buoyant force formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The buoyant force (FB) acting on an object immersed or floating in a fluid is calculated as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The buoyant force (FB) acting on an object immersed or floating in a fluid is calculated as:', 'single_choice', 'medium', 'An object immersed or floating in a fluid is acted upon by an upward buoyant force equal to the weight of the fluid displaced: FB = γ∀(fluid displaced), where γ is the unit weight of the fluid and ∀ is the volume of fluid displaced.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'FB = γ × ∀ (fluid displaced)', true, 0),
      (v_question_id, 'FB = ρ × A', false, 1),
      (v_question_id, 'FB = m × g × h', false, 2),
      (v_question_id, 'FB = γ/∀', false, 3);
  END IF;

  -- 29. Flow rate formulas
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which set of formulas correctly describes mass flow rate, weight flow rate, and volume flow rate (discharge), respectively?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which set of formulas correctly describes mass flow rate, weight flow rate, and volume flow rate (discharge), respectively?', 'single_choice', 'medium', 'Mass flow rate M = ρQ = ρAV (kg/s), weight flow rate W = γQ = ρgAV (kN/s), and volume flow rate Q = AV (m³/s or L/s).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'M = ρQ = ρAV (kg/s); W = γQ = ρgAV (kN/s); Q = AV (m³/s)', true, 0),
      (v_question_id, 'M = AV; W = ρQ; Q = γAV', false, 1),
      (v_question_id, 'M = γ/ρ; W = AV; Q = ρg', false, 2),
      (v_question_id, 'M = Q/A; W = Q/γ; Q = M × ρ', false, 3);
  END IF;

  -- 30. Steady flow definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A flow in which the discharge passing a given cross-section is constant with time is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A flow in which the discharge passing a given cross-section is constant with time is called:', 'single_choice', 'easy', 'Steady flow occurs when discharge passing a given cross-section is constant with time; if discharge varies with time, the flow is unsteady.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Uniform flow', false, 0),
      (v_question_id, 'Steady flow', true, 1),
      (v_question_id, 'Laminar flow', false, 2),
      (v_question_id, 'One-dimensional flow', false, 3);
  END IF;

  -- 31. Uniform flow definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A flow in which the average velocity is the same at every cross-section for a given length or reach of a stream is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A flow in which the average velocity is the same at every cross-section for a given length or reach of a stream is called:', 'single_choice', 'easy', 'Uniform flow occurs if, with steady flow for a given length or reach of a stream, the average velocity of flow is the same at every cross-section; this usually occurs when an incompressible fluid flows through a stream with uniform cross-section.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Steady flow', false, 0),
      (v_question_id, 'Uniform flow', true, 1),
      (v_question_id, 'Turbulent flow', false, 2),
      (v_question_id, 'Two-dimensional flow', false, 3);
  END IF;

  -- 32. Conical pipe flow classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Water flows at a constant rate through a conical pipe whose cross-sectional area changes along its length. What type of flow does this represent?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Water flows at a constant rate through a conical pipe whose cross-sectional area changes along its length. What type of flow does this represent?', 'single_choice', 'medium', 'Because the flow rate is constant over time, the flow is steady. Because the conical pipe''s cross-sectional area changes along its length, velocity changes from point to point along the pipe due to continuity (as area decreases, velocity increases, and vice versa), making the flow non-uniform. This combination is steady, non-uniform flow.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Unsteady, uniform flow', false, 0),
      (v_question_id, 'Steady, non-uniform flow', true, 1),
      (v_question_id, 'Unsteady, non-uniform flow', false, 2),
      (v_question_id, 'Steady, uniform flow', false, 3);
  END IF;

  -- 33. Hydraulic jump classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hydraulic jump, where a significant change in water depth occurs over a short distance, is an example of which type of flow?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A hydraulic jump, where a significant change in water depth occurs over a short distance, is an example of which type of flow?', 'single_choice', 'medium', 'Rapidly varied flow is a significant change in water depth over a short distance, which describes a hydraulic jump. Gradually varied flow, by contrast, is where water depth changes gradually over a large distance.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Gradually varied flow', false, 0),
      (v_question_id, 'Rapidly varied flow', true, 1),
      (v_question_id, 'Laminar flow', false, 2),
      (v_question_id, 'Uniform flow', false, 3);
  END IF;

  -- 34. Laminar vs turbulent Reynolds thresholds
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In terms of Reynolds number (Re), laminar flow and turbulent flow are generally classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In terms of Reynolds number (Re), laminar flow and turbulent flow are generally classified as:', 'single_choice', 'easy', 'Laminar flow, where fluid particle paths do not cross, occurs at Re < 2,000; turbulent flow, where particle paths are irregular and continuously cross, occurs at Re > 4,000. Between these is transitional flow.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Laminar: Re < 2,000; Turbulent: Re > 4,000', true, 0),
      (v_question_id, 'Laminar: Re > 4,000; Turbulent: Re < 2,000', false, 1),
      (v_question_id, 'Laminar: Re < 500; Turbulent: Re > 500', false, 2),
      (v_question_id, 'Laminar: Re = 0; Turbulent: Re > 0', false, 3);
  END IF;

  -- 35. Critical velocity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Critical velocity, in pipe flow, is best defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Critical velocity, in pipe flow, is best defined as:', 'single_choice', 'medium', 'Critical velocity is the velocity below which all turbulence is damped out by the viscosity of the fluid, represented by a Reynolds number of 2,000.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The velocity below which all turbulence is damped out by the viscosity of the fluid, represented by a Reynolds number of 2,000', true, 0),
      (v_question_id, 'The maximum velocity attainable in any pipe regardless of diameter', false, 1),
      (v_question_id, 'The velocity at which a fluid becomes compressible', false, 2),
      (v_question_id, 'The velocity at which a fluid''s viscosity becomes zero', false, 3);
  END IF;

  -- 36. Continuity equation (incompressible)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The continuity equation for incompressible fluids flowing through a pipe of varying cross-section is expressed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The continuity equation for incompressible fluids flowing through a pipe of varying cross-section is expressed as:', 'single_choice', 'medium', 'For incompressible fluids, the continuity equation (conservation of mass) states that the discharge at every section of the stream is the same: Q = A1v1 = A2v2 = A3v3 = constant.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A1v1 = A2v2 = A3v3 = constant', true, 0),
      (v_question_id, 'P1v1 = P2v2', false, 1),
      (v_question_id, 'ρ1 + A1 = ρ2 + A2', false, 2),
      (v_question_id, 'A1/v1 = A2/v2', false, 3);
  END IF;

  -- 37. Continuity equation (compressible)
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The continuity equation for compressible fluids flowing through a pipe of varying cross-section is expressed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The continuity equation for compressible fluids flowing through a pipe of varying cross-section is expressed as:', 'single_choice', 'hard', 'For compressible fluids, the continuity equation accounts for changing density along the flow: ρ1A1v1 = ρ2A2v2 = ρ3A3v3 = constant (equivalently, γ1A1v1 = γ2A2v2 = γ3A3v3).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'ρ1A1v1 = ρ2A2v2 = ρ3A3v3 = constant', true, 0),
      (v_question_id, 'A1v1 = A2v2 = A3v3 = constant', false, 1),
      (v_question_id, 'ρ1/A1 = ρ2/A2', false, 2),
      (v_question_id, 'ρ1 + v1 = ρ2 + v2', false, 3);
  END IF;

  -- 38. Bernoulli's theorem origin
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Bernoulli''s Energy Theorem, developed by Swiss mathematician and physicist Daniel Bernoulli in 1738, results from the application of which principle?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Bernoulli''s Energy Theorem, developed by Swiss mathematician and physicist Daniel Bernoulli in 1738, results from the application of which principle?', 'single_choice', 'easy', 'Bernoulli''s Energy Theorem results from the application of the principle of conservation of energy; as the speed of a moving fluid increases, the pressure within that fluid decreases, and the total energy in a steadily flowing fluid system is constant along the flow path.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Conservation of momentum', false, 0),
      (v_question_id, 'Conservation of energy', true, 1),
      (v_question_id, 'Conservation of charge', false, 2),
      (v_question_id, 'Newton''s second law only', false, 3);
  END IF;

  -- 39. Bernoulli's equation form
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Bernoulli''s equation for a flowing fluid between two points is correctly expressed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Bernoulli''s equation for a flowing fluid between two points is correctly expressed as:', 'single_choice', 'medium', 'Bernoulli''s equation expresses conservation of energy along a streamline: P1 + ½ρv1² + ρgh1 = P2 + ½ρv2² + ρgh2.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'P1 + ½ρv1² + ρgh1 = P2 + ½ρv2² + ρgh2', true, 0),
      (v_question_id, 'P1 × v1 = P2 × v2', false, 1),
      (v_question_id, 'P1 - ρgh1 = P2 + ρgh2', false, 2),
      (v_question_id, 'P1/v1² = P2/v2²', false, 3);
  END IF;

  -- 40. Darcy's equation application
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Darcy''s equation governs flow in which setting, and under what flow condition is it applicable?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Darcy''s equation governs flow in which setting, and under what flow condition is it applicable?', 'single_choice', 'medium', 'Darcy''s Equation governs flow in aquifers and wells and is only applicable for laminar flow.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flow in aquifers and wells, only applicable for laminar flow', true, 0),
      (v_question_id, 'Uniform flow in open channels, for any flow regime', false, 1),
      (v_question_id, 'Flow rate through a pipe, only for turbulent flow', false, 2),
      (v_question_id, 'Conservation of energy for a flowing fluid, for any flow regime', false, 3);
  END IF;

  -- 41. Manning's equation application
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Manning''s equation (V = (1/n)R^(2/3)√S) is applied to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Manning''s equation (V = (1/n)R^(2/3)√S) is applied to:', 'single_choice', 'medium', 'Manning''s Equation applies to uniform flow in open channels.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Uniform flow in open channels', true, 0),
      (v_question_id, 'Laminar flow through pipes', false, 1),
      (v_question_id, 'Flow in aquifers and wells', false, 2),
      (v_question_id, 'Conservation of momentum in a jet', false, 3);
  END IF;

  -- 42. Hagen-Poiseuille equation application
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Hagen-Poiseuille equation (ΔP = 8μLQ/πr⁴) is used to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Hagen-Poiseuille equation (ΔP = 8μLQ/πr⁴) is used to:', 'single_choice', 'medium', 'The Hagen-Poiseuille Equation is used to calculate the flow rate of a fluid through a pipe under laminar flow conditions.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Calculate the flow rate of a fluid through a pipe for laminar flow conditions', true, 0),
      (v_question_id, 'Calculate uniform flow in open channels', false, 1),
      (v_question_id, 'Determine the buoyant force on a submerged object', false, 2),
      (v_question_id, 'Determine the critical depth in a hydraulic jump', false, 3);
  END IF;

  -- 43. Reynolds number
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Reynolds number represents the ratio of which forces within a fluid, and how is it expressed?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Reynolds number represents the ratio of which forces within a fluid, and how is it expressed?', 'single_choice', 'medium', 'Reynolds number represents the ratio of inertial to viscous forces within a fluid: Re = vDρ/μ = vD/ν.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The ratio of inertial to viscous forces, Re = vDρ/μ = vD/ν', true, 0),
      (v_question_id, 'The ratio of gravitational to inertial forces, Fr = U/√(gd)', false, 1),
      (v_question_id, 'The ratio of viscosity to thermal conductivity', false, 2),
      (v_question_id, 'The ratio of convective to conductive heat transfer', false, 3);
  END IF;

  -- 44. Froude's number and flow regimes
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Froude''s number, which represents the ratio of inertial to gravitational forces and describes flow regimes in open channels, classifies flow as supercritical when:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Froude''s number, which represents the ratio of inertial to gravitational forces and describes flow regimes in open channels, classifies flow as supercritical when:', 'single_choice', 'medium', 'Froude''s number (Fr = U/√(gd)) describes open-channel flow regimes: Fr = 1 is critical flow, Fr > 1 is supercritical (fast, rapid) flow, and Fr < 1 is subcritical (slow, tranquil) flow.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fr = 1', false, 0),
      (v_question_id, 'Fr > 1', true, 1),
      (v_question_id, 'Fr < 1', false, 2),
      (v_question_id, 'Fr = 0', false, 3);
  END IF;

  -- 45. Manometer function
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which fluid mechanics measuring instrument is used to determine the difference in pressure between two points?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which fluid mechanics measuring instrument is used to determine the difference in pressure between two points?', 'single_choice', 'easy', 'A manometer is an instrument used to measure the difference in pressure between two points.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Venturi meter', false, 0),
      (v_question_id, 'Manometer', true, 1),
      (v_question_id, 'Pitot tube', false, 2),
      (v_question_id, 'Hydrometer', false, 3);
  END IF;

  -- 46. Hydrometer vs hygrometer
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A hydrometer is an instrument used to determine what characteristic of a fluid?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A hydrometer is an instrument used to determine what characteristic of a fluid?', 'single_choice', 'easy', 'A hydrometer measures the density (specific gravity) of liquids; this is distinct from a hygrometer, which measures humidity (water vapor in the air).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Humidity', false, 0),
      (v_question_id, 'Flow rate', false, 1),
      (v_question_id, 'Specific gravity', true, 2),
      (v_question_id, 'Velocity', false, 3);
  END IF;

  -- 47. Pitot tube
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Pitot tube, named after Henri Pitot, is a bent (L-shaped or U-shaped) tube with both ends open that is used to:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Pitot tube, named after Henri Pitot, is a bent (L-shaped or U-shaped) tube with both ends open that is used to:', 'single_choice', 'medium', 'The Pitot tube, named after Henri Pitot, is a bent tube with both ends open used to measure the velocity of fluid or air flow by measuring the difference between stagnation pressure and static pressure to determine local flow velocity at a specific point.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Measure the viscosity of a fluid', false, 0),
      (v_question_id, 'Measure the velocity of fluid flow or air flow, based on the difference between stagnation and static pressure', true, 1),
      (v_question_id, 'Measure the specific gravity of a liquid', false, 2),
      (v_question_id, 'Measure the discharge through a pipe directly from pipe diameter alone', false, 3);
  END IF;

  -- 48. Venturi meter
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A Venturi meter is primarily used to measure:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A Venturi meter is primarily used to measure:', 'single_choice', 'easy', 'A Venturi meter is an instrument used in measuring the discharge through pipes.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The viscosity of a fluid', false, 0),
      (v_question_id, 'The discharge (flow rate) of a fluid through a pipe', true, 1),
      (v_question_id, 'The humidity of air', false, 2),
      (v_question_id, 'The specific gravity of a liquid', false, 3);
  END IF;

  -- 49. Nozzle definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A nozzle is best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A nozzle is best described as:', 'single_choice', 'easy', 'A nozzle is a converging tube installed at the end of a pipe or hose for the purpose of increasing the velocity of the issuing jet, with discharge given by Q = CAn√(2gH).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A converging tube installed at the end of a pipe or hose to increase the velocity of the issuing jet', true, 0),
      (v_question_id, 'An opening with a closed perimeter through which fluid flows', false, 1),
      (v_question_id, 'An overflow structure built across an open channel', false, 2),
      (v_question_id, 'An in-line structure with a geometrically specified constriction in an open channel', false, 3);
  END IF;

  -- 50. Orifice definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An orifice is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An orifice is defined as:', 'single_choice', 'easy', 'An orifice is an opening (usually circular) with a closed perimeter through which fluid flows.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'An opening, usually circular, with a closed perimeter through which fluid flows', true, 0),
      (v_question_id, 'A converging tube that increases jet velocity', false, 1),
      (v_question_id, 'A bent tube used to measure flow velocity', false, 2),
      (v_question_id, 'An overflow structure for measuring flow in open channels', false, 3);
  END IF;

  -- 51. Coefficient of discharge
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The coefficient of discharge (C or Cd) of a flow-measuring device is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The coefficient of discharge (C or Cd) of a flow-measuring device is defined as:', 'single_choice', 'medium', 'The coefficient of discharge, C or Cd, is the ratio of the actual discharge through the device to the ideal or theoretical discharge which would occur without losses: C = Q/Qt.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The ratio of the actual discharge through the device to the ideal or theoretical discharge which would occur without losses', true, 0),
      (v_question_id, 'The ratio of actual velocity to theoretical velocity', false, 1),
      (v_question_id, 'The ratio of actual area of the jet to the area of the opening', false, 2),
      (v_question_id, 'The product of Cv and Cc', false, 3);
  END IF;

  -- 52. Coefficient of velocity
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The coefficient of velocity (Cv) of an orifice or jet is defined as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The coefficient of velocity (Cv) of an orifice or jet is defined as:', 'single_choice', 'medium', 'The coefficient of velocity, Cv, is the ratio of the actual mean velocity to the ideal or theoretical velocity which would occur without any losses: Cv = v/vt.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The ratio of the actual mean velocity to the ideal or theoretical velocity which would occur without any losses', true, 0),
      (v_question_id, 'The ratio of actual discharge to theoretical discharge', false, 1),
      (v_question_id, 'The ratio of the contracted jet area to the opening area', false, 2),
      (v_question_id, 'The product of Cc and Cd', false, 3);
  END IF;

  -- 53. Relationship of coefficients
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The coefficient of discharge (C), coefficient of contraction (Cc), and coefficient of velocity (Cv) of a flow-measuring device are related by which expression?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The coefficient of discharge (C), coefficient of contraction (Cc), and coefficient of velocity (Cv) of a flow-measuring device are related by which expression?', 'single_choice', 'hard', 'The relationship of the three device coefficients is C = Cc × Cv.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'C = Cc × Cv', true, 0),
      (v_question_id, 'C = Cc + Cv', false, 1),
      (v_question_id, 'C = Cc/Cv', false, 2),
      (v_question_id, 'C = Cc - Cv', false, 3);
  END IF;

  -- 54. Weir definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Weirs are best described as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Weirs are best described as:', 'single_choice', 'easy', 'Weirs are overflow structures which are built across an open channel for the purpose of measuring or controlling the flow of liquids.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Overflow structures built across an open channel for the purpose of measuring or controlling the flow of liquids', true, 0),
      (v_question_id, 'Closed conduits through which fluids flow under pressure', false, 1),
      (v_question_id, 'Bent tubes used to measure fluid velocity', false, 2),
      (v_question_id, 'Converging tubes that increase jet velocity', false, 3);
  END IF;

  -- 55. Francis weir formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The discharge (Q) over a Francis weir (without end contraction) is given by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The discharge (Q) over a Francis weir (without end contraction) is given by:', 'single_choice', 'medium', 'The discharge over a Francis weir is Q = 1.84LH^(3/2), where L is the weir length and H is the head over the weir.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Q = 1.84LH^(3/2)', true, 0),
      (v_question_id, 'Q = 1.86LH^(3/2)', false, 1),
      (v_question_id, 'Q = 1.38H^(5/2)', false, 2),
      (v_question_id, 'Q = 1.84(L-0.2H)H^(3/2)', false, 3);
  END IF;

  -- 56. Cipoletti (trapezoidal) weir formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The discharge (Q) over a trapezoidal (Cipoletti) weir is given by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The discharge (Q) over a trapezoidal (Cipoletti) weir is given by:', 'single_choice', 'medium', 'The discharge over a trapezoidal (Cipoletti) weir is Q = 1.86LH^(3/2).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Q = 1.84LH^(3/2)', false, 0),
      (v_question_id, 'Q = 1.86LH^(3/2)', true, 1),
      (v_question_id, 'Q = 1.38H^(5/2)', false, 2),
      (v_question_id, 'Q = 1.84(L-0.2H)H^(3/2)', false, 3);
  END IF;

  -- 57. Triangular (90°) weir formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The discharge (Q) over a 90-degree triangular (V-notch) weir is given by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The discharge (Q) over a 90-degree triangular (V-notch) weir is given by:', 'single_choice', 'medium', 'The discharge over a 90-degree triangular weir is Q = 1.38H^(5/2).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Q = 1.84LH^(3/2)', false, 0),
      (v_question_id, 'Q = 1.86LH^(3/2)', false, 1),
      (v_question_id, 'Q = 1.38H^(5/2)', true, 2),
      (v_question_id, 'Q = 1.84(L-0.2H)H^(3/2)', false, 3);
  END IF;

  -- 58. Francis weir with contraction
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The discharge (Q) over a Francis weir WITH end contraction is given by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The discharge (Q) over a Francis weir WITH end contraction is given by:', 'single_choice', 'hard', 'The discharge over a Francis weir with contraction accounts for the reduced effective crest length: Q = 1.84(L - 0.2H)H^(3/2).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Q = 1.84LH^(3/2)', false, 0),
      (v_question_id, 'Q = 1.84(L - 0.2H)H^(3/2)', true, 1),
      (v_question_id, 'Q = 1.86LH^(3/2)', false, 2),
      (v_question_id, 'Q = 1.38H^(5/2)', false, 3);
  END IF;

  -- 59. Darcy-Weisbach formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Darcy-Weisbach formula for head loss due to friction (hf) in pipe flow is expressed as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Darcy-Weisbach formula for head loss due to friction (hf) in pipe flow is expressed as:', 'single_choice', 'medium', 'The Darcy-Weisbach formula (pipe-friction equation) gives head loss as hf = (fL/D)(v²/2g), where f is the friction factor, L is pipe length, D is pipe diameter, and v is flow velocity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'hf = (fL/D)(v²/2g)', true, 0),
      (v_question_id, 'hf = fLD/v²', false, 1),
      (v_question_id, 'hf = f/(Lv²)', false, 2),
      (v_question_id, 'hf = (D/fL)(2g/v²)', false, 3);
  END IF;

  -- 60. Friction factor for laminar flow
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For laminar flow (Re < 2,000) in a pipe, the Darcy friction factor (f) used in the Darcy-Weisbach formula is given by:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For laminar flow (Re < 2,000) in a pipe, the Darcy friction factor (f) used in the Darcy-Weisbach formula is given by:', 'single_choice', 'medium', 'For laminar flow (Re < 2,000), the friction factor is f = 64/Re. For turbulent flow, f is instead estimated using the Blasius, Colebrook, or Haaland equations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'f = 64/Re', true, 0),
      (v_question_id, 'f = 0.316Re^-0.25', false, 1),
      (v_question_id, 'f = 1.8 log(Re)', false, 2),
      (v_question_id, 'f = Re/64', false, 3);
  END IF;

  -- 61. Numeric: coconut oil pipe discharge
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Coconut oil flows through a 2-inch pipe at a measured velocity of 0.02 m/s. What is the rate of flow (discharge)?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Coconut oil flows through a 2-inch pipe at a measured velocity of 0.02 m/s. What is the rate of flow (discharge)?', 'single_choice', 'hard', 'Using Q = Av = (πd²/4)v with d = 2 in × 0.0254 m/in = 0.0508 m: Q = (π(0.0508 m)²/4)(0.02 m/s) ≈ 0.00004054 m³/s, which is approximately 0.04 liters per second.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '0.01 lps', false, 0),
      (v_question_id, '0.02 lps', false, 1),
      (v_question_id, '0.03 lps', false, 2),
      (v_question_id, '0.04 lps', true, 3);
  END IF;

  -- 62. Numeric: mercury U-tube manometer gas pressure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A U-shaped tube contains mercury with a density of 13,595 kg/m³. The top of the mercury column open to the atmosphere is vertically below the top of the mercury column in contact with a gas reservoir, with a vertical distance h = 25 cm between the column tops. Using the liquid manometer equation ΔP = ρgΔh and standard atmospheric pressure, what is the pressure of the gas in the reservoir?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A U-shaped tube contains mercury with a density of 13,595 kg/m³. The top of the mercury column open to the atmosphere is vertically below the top of the mercury column in contact with a gas reservoir, with a vertical distance h = 25 cm between the column tops. Using the liquid manometer equation ΔP = ρgΔh and standard atmospheric pressure, what is the pressure of the gas in the reservoir?', 'single_choice', 'hard', 'Pg = Patm - ρgΔh = 101.3 kPa - (13,595 kg/m³)(9.81 m/s²)(0.25 m) ≈ 101.3 kPa - 33.34 kPa ≈ 68 kPa.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '33 kPa', false, 0),
      (v_question_id, '68 kPa', true, 1),
      (v_question_id, '101 kPa', false, 2),
      (v_question_id, '105 kPa', false, 3);
  END IF;

  -- 63. Numeric: oil manometer height difference
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Two gas reservoirs register pressures of 110.3 kPa and 110.1 kPa. A U-shaped tube containing oil with a density of 1,080 kg/m³ connects them. Using ΔP = ρgΔh, what is the vertical distance (h) between the tops of the oil columns?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Two gas reservoirs register pressures of 110.3 kPa and 110.1 kPa. A U-shaped tube containing oil with a density of 1,080 kg/m³ connects them. Using ΔP = ρgΔh, what is the vertical distance (h) between the tops of the oil columns?', 'single_choice', 'hard', 'ΔP = ρgΔh, so Δh = ΔP/(ρg) = (200 Pa)/((1,080 kg/m³)(9.81 m/s²)) ≈ 0.0189 m, or 1.89 cm.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '2.54 cm', false, 0),
      (v_question_id, '2.25 cm', false, 1),
      (v_question_id, '1.92 cm', false, 2),
      (v_question_id, '1.89 cm', true, 3);
  END IF;

  -- 64. Numeric: Bernoulli velocity at pipe end
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Using Bernoulli''s equation for a horizontal pipe, find the velocity at the end of the pipe given: entry velocity v1 = 0.8 m/s, P1 = 15 kPa, P2 = 13 kPa, and fluid density = 1.2 g/cc (1,200 kg/m³).';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Using Bernoulli''s equation for a horizontal pipe, find the velocity at the end of the pipe given: entry velocity v1 = 0.8 m/s, P1 = 15 kPa, P2 = 13 kPa, and fluid density = 1.2 g/cc (1,200 kg/m³).', 'single_choice', 'hard', 'Since the pipe is horizontal, elevation terms cancel: ½ρv1² + P1 = ½ρv2² + P2. Solving ½(1200)(0.8)² + 15000 = ½(1200)v2² + 13000 gives v2 ≈ 1.99 m/s.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '1.66 m/s', false, 0),
      (v_question_id, '1.77 m/s', false, 1),
      (v_question_id, '1.88 m/s', false, 2),
      (v_question_id, '1.99 m/s', true, 3);
  END IF;

  -- 65. Numeric: pipe height drop for target pressure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A pipe carries fluid of density 1,100 kg/m³ at constant velocity. If the initial pressure is atmospheric (101.3 kPa) and the fluid must reach a pressure of 2.5 atm, what must be the drop in height (Δh) of the pipe, using Bernoulli''s equation with constant velocity?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A pipe carries fluid of density 1,100 kg/m³ at constant velocity. If the initial pressure is atmospheric (101.3 kPa) and the fluid must reach a pressure of 2.5 atm, what must be the drop in height (Δh) of the pipe, using Bernoulli''s equation with constant velocity?', 'single_choice', 'hard', 'With constant velocity, Bernoulli''s equation reduces to ρgh1 + P1 = ρgh2 + P2, so Δh = (P1 - P2)/(ρg) = (101,300 - 253,312)/((1,100)(9.81)) ≈ -14.09 m.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '-14.09 m', true, 0),
      (v_question_id, '-18.2 m', false, 1),
      (v_question_id, '-16.57 m', false, 2),
      (v_question_id, '-14.33 m', false, 3);
  END IF;

  -- 66. Numeric: horizontal pipe trajectory discharge
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A horizontal, fully flowing 4-inch pipe discharges water as a jet. The horizontal (X) and vertical (Y) coordinates of the water trajectory, measured from the end of the pipe, are 1.5 m and 0.8 m, respectively, and the coefficient of discharge is 1.0. What is the discharge of the pipe?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A horizontal, fully flowing 4-inch pipe discharges water as a jet. The horizontal (X) and vertical (Y) coordinates of the water trajectory, measured from the end of the pipe, are 1.5 m and 0.8 m, respectively, and the coefficient of discharge is 1.0. What is the discharge of the pipe?', 'single_choice', 'hard', 'Using Q = CdA√(2g(X-Y)) with A = π(4 × 0.0254 m)²/4 and (X-Y) = 0.7 m: Q = (1.0)(π(0.1016 m)²/4)√(2 × 9.81 × 0.7) ≈ 0.03004 m³/s, or about 30.03 liters per second.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, '8.34 lps', false, 0),
      (v_question_id, '30.03 lps', true, 1),
      (v_question_id, '132.23 lps', false, 2),
      (v_question_id, '476.04 lps', false, 3);
  END IF;

END $$;
