-- Marketing and Management quiz batch (50 questions, 1 topic). Every fact is
-- drawn directly from a full review-notes transcript covering agribusiness
-- marketing and farm/agribusiness management concepts (management functions,
-- leadership styles, farm risk management, financial ratios, market
-- structures, pricing strategies, marketing channels, intermediaries, and
-- product/market classification), plus a short supplementary set on
-- agricultural mechanization marketing, all read in full (2026-10-02) — no
-- invented facts. This topic had zero published questions before this batch.
-- Idempotent: safe to re-run; skips questions that already exist (matched by
-- topic_id + question_text).
-- All questions inserted as status='draft' with source/source_reference left
-- NULL (no source attribution stored). is_paes=false and paes_reference=NULL
-- unless a question is grounded in an actual PAES standard (none here).
-- Paste into the Supabase SQL Editor and run.

-- =====================================================================
-- Topic: Marketing and Management (PROJECT_MGMT_RDE) — 50 question(s)
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

  SELECT id INTO v_topic_id FROM public.topics WHERE name = 'Marketing and Management' AND exam_area_id = v_exam_area_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic not found: Marketing and Management';
  END IF;

  -- 1. Definition of management
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Management is best described as which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Management is best described as which of the following?', 'single_choice', 'easy', 'Management is the process of setting and achieving goals through the execution of the management functions (planning, organizing, staffing, directing, controlling, leading) that utilize human, financial, and material resources.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The process of maximizing resources to produce the highest possible output, regardless of goals', false, 0),
      (v_question_id, 'The process of setting and achieving goals through the execution of management functions that utilize human, financial, and material resources', true, 1),
      (v_question_id, 'The process of recruiting and placing qualified personnel within an organization', false, 2),
      (v_question_id, 'The process of persuading customers to buy a product through advertising', false, 3);
  END IF;

  -- 2. Managerial characteristic: Mediator
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which characteristic of a manager describes one who resolves disputes with skill and tact?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which characteristic of a manager describes one who resolves disputes with skill and tact?', 'single_choice', 'easy', 'A manager acting as a Mediator resolves disputes with skill and tact, distinct from a Politician (uses persuasion and compromise), a Diplomat (represents the unit in meetings and external relations), and a Decision-maker (solves problems and stands by tough choices).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Politician', false, 0),
      (v_question_id, 'Mediator', true, 1),
      (v_question_id, 'Diplomat', false, 2),
      (v_question_id, 'Decision-maker', false, 3);
  END IF;

  -- 3. Effectiveness = doing the right things
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Choosing the right actions to achieve success, summarized as "doing the right things," describes which management concept?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Choosing the right actions to achieve success, summarized as "doing the right things," describes which management concept?', 'single_choice', 'easy', 'Effectiveness means doing the right things — choosing the right actions to achieve success — while Efficiency means doing things right, minimizing resources for maximum results.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Efficiency', false, 0),
      (v_question_id, 'Effectiveness', true, 1),
      (v_question_id, 'Leadership', false, 2),
      (v_question_id, 'Controlling', false, 3);
  END IF;

  -- 4. Ways of promoting efficiency
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which of the following is one of the stated ways of promoting efficiency?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which of the following is one of the stated ways of promoting efficiency?', 'single_choice', 'medium', 'The stated ways of promoting efficiency are: same input with more output, less input with more output, and less input with the same output. "More input, more output" and "more input, less output" are not among the stated ways.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'More input, more output', false, 0),
      (v_question_id, 'Less input, more output', true, 1),
      (v_question_id, 'More input, less output', false, 2),
      (v_question_id, 'More input, same output', false, 3);
  END IF;

  -- 5. Staffing function
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which management function involves recruiting and placing qualified personnel?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which management function involves recruiting and placing qualified personnel?', 'single_choice', 'easy', 'Staffing is the management function concerned with recruiting and placing qualified personnel, distinct from Directing (guiding and motivating employees) and Controlling (ensuring performance aligns with plans).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Directing', false, 0),
      (v_question_id, 'Staffing', true, 1),
      (v_question_id, 'Controlling', false, 2),
      (v_question_id, 'Organizing', false, 3);
  END IF;

  -- 6. Exploitative Authoritative (System 1) leadership
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In which leadership style do managers make all the decisions, using threats for failure to ensure compliance?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In which leadership style do managers make all the decisions, using threats for failure to ensure compliance?', 'single_choice', 'medium', 'In the Exploitative Authoritative style (System 1), managers make all decisions and use threats for failure. This contrasts with Benevolent Authoritative (System 2, where subordinates may comment and rewards exist), Consultative (System 3, where managers discuss before deciding), and Participative (System 4, where the group decides together).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Benevolent Authoritative (System 2)', false, 0),
      (v_question_id, 'Exploitative Authoritative (System 1)', true, 1),
      (v_question_id, 'Consultative (System 3)', false, 2),
      (v_question_id, 'Participative (System 4)', false, 3);
  END IF;

  -- 7. Fieldwork classification of farm jobs
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Plowing, seedbed preparation, and planting crops belong to which classification of farm jobs, best done in clear weather with moderately dry soil?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Plowing, seedbed preparation, and planting crops belong to which classification of farm jobs, best done in clear weather with moderately dry soil?', 'single_choice', 'easy', 'Fieldwork tasks such as plowing, seedbed preparation, and planting should be prioritized in clear weather with moderately dry soil for effectiveness, unlike Outside Work (which can be delayed) or Work for Rainy Days (indoor tasks).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Fieldwork', true, 0),
      (v_question_id, 'Outside Work (can be delayed)', false, 1),
      (v_question_id, 'Work for Rainy Days', false, 2),
      (v_question_id, 'Hired Labor', false, 3);
  END IF;

  -- 8. Work for Rainy Days classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Repairing machinery, sharpening mower sickles, and oiling equipment are indoor tasks best completed during which classification of farm jobs?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Repairing machinery, sharpening mower sickles, and oiling equipment are indoor tasks best completed during which classification of farm jobs?', 'single_choice', 'easy', 'Work for Rainy Days covers indoor tasks like repairing machinery, sharpening mower sickles, and oiling equipment, completed during wet weather to maximize productivity.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Outside Work (can be delayed)', false, 0),
      (v_question_id, 'Fieldwork', false, 1),
      (v_question_id, 'Work for Rainy Days', true, 2),
      (v_question_id, 'Family Labor', false, 3);
  END IF;

  -- 9. Future Contract risk method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which method of reducing risk in an agricultural farm involves locking in prices for future sales to mitigate market volatility?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which method of reducing risk in an agricultural farm involves locking in prices for future sales to mitigate market volatility?', 'single_choice', 'medium', 'A Future Contract locks in prices for future sales to mitigate market price volatility, distinct from Diversification (spreading risk across crops/livestock), Insurance (protecting against disaster losses), and Liquidity (ensuring access to cash).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Diversification', false, 0),
      (v_question_id, 'Insurance', false, 1),
      (v_question_id, 'Future Contract', true, 2),
      (v_question_id, 'Liquidity', false, 3);
  END IF;

  -- 10. Diversification risk method
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Spreading risk by investing in various crops or livestock instead of relying on one is an example of which risk-reduction method?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Spreading risk by investing in various crops or livestock instead of relying on one is an example of which risk-reduction method?', 'single_choice', 'medium', 'Diversification spreads risk by investing in various crops or livestock instead of relying on one, while Flexibility allows adaptation of production strategies to changing conditions.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Flexibility', false, 0),
      (v_question_id, 'Diversification', true, 1),
      (v_question_id, 'Future Contract', false, 2),
      (v_question_id, 'Insurance', false, 3);
  END IF;

  -- 11. Current Ratio ideal value
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the ideal value of the Current Ratio (Liquidity/Solvency Ratio), which measures a company''s ability to cover short-term liabilities with short-term assets?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the ideal value of the Current Ratio (Liquidity/Solvency Ratio), which measures a company''s ability to cover short-term liabilities with short-term assets?', 'single_choice', 'medium', 'The Current Ratio (Current Assets / Current Liabilities) should ideally be at least 2:1, while the stricter Quick/Acid-Test Ratio should ideally be at least 1:1.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'At least 1:1', false, 0),
      (v_question_id, 'At least 2:1', true, 1),
      (v_question_id, 'At least 3:1', false, 2),
      (v_question_id, 'At least 1:2', false, 3);
  END IF;

  -- 12. Quick/Acid-Test Ratio excludes inventories
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The Quick (Acid-Test) Ratio differs from the Current Ratio because it excludes which item from current assets?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The Quick (Acid-Test) Ratio differs from the Current Ratio because it excludes which item from current assets?', 'single_choice', 'medium', 'The Quick/Acid-Test Ratio is calculated as (Current Assets − Inventories) / Current Liabilities, showing whether a company can pay short-term bills without selling inventory, with an ideal value of at least 1:1.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Cash', false, 0),
      (v_question_id, 'Accounts receivable', false, 1),
      (v_question_id, 'Inventories', true, 2),
      (v_question_id, 'Fixed assets', false, 3);
  END IF;

  -- 13. Net Working Capital
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Net Working Capital represents which of the following?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Net Working Capital represents which of the following?', 'single_choice', 'easy', 'Net Working Capital (Current Assets − Current Liabilities) represents the amount of funds available for day-to-day operations.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'The total value of a farm''s fixed assets', false, 0),
      (v_question_id, 'The amount of funds available for day-to-day operations', true, 1),
      (v_question_id, 'The total revenue from the sale of goods', false, 2),
      (v_question_id, 'The cost of producing one additional unit of output', false, 3);
  END IF;

  -- 14. Marketing vs Selling
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How does marketing relate to selling?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How does marketing relate to selling?', 'single_choice', 'easy', 'Marketing is not equal to selling. Selling is an important activity of marketing and a central foundation in daily business operations, but it is only part of the broader marketing process.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Marketing and selling are identical concepts', false, 0),
      (v_question_id, 'Selling is an important activity and foundation of marketing, but marketing is broader than selling', true, 1),
      (v_question_id, 'Selling has no relationship to marketing', false, 2),
      (v_question_id, 'Marketing is only concerned with advertising, not selling', false, 3);
  END IF;

  -- 15. Marketing vs Advertising
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'What is the relationship between marketing and advertising?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'What is the relationship between marketing and advertising?', 'single_choice', 'easy', 'Marketing is not equal to advertising. Like selling, advertising is merely one of the many functions of marketing.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Advertising is the ultimate goal of marketing', false, 0),
      (v_question_id, 'Marketing is a subset of advertising', false, 1),
      (v_question_id, 'Advertising, like selling, is merely one of the many functions of marketing', true, 2),
      (v_question_id, 'Advertising replaces the need for selling in marketing', false, 3);
  END IF;

  -- 16. Consumer Market
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A market consisting of the end-users of products and services is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A market consisting of the end-users of products and services is called the:', 'single_choice', 'medium', 'The Consumer Market consists of end-users of products and services, while the Business Market buys products to produce another product or resell to other markets.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Business Market', false, 0),
      (v_question_id, 'Consumer Market', true, 1),
      (v_question_id, 'Target Market', false, 2),
      (v_question_id, 'Wholesale Market', false, 3);
  END IF;

  -- 17. Hypermarket vs Supermarket product range
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'How does a hypermarket''s product range typically differ from a supermarket''s?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'How does a hypermarket''s product range typically differ from a supermarket''s?', 'single_choice', 'medium', 'A hypermarket is very large and carries groceries plus general merchandise for one-stop shopping, while a supermarket is large and carries mostly groceries for daily essentials.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A hypermarket carries groceries plus general merchandise, while a supermarket carries mostly groceries', true, 0),
      (v_question_id, 'A hypermarket only sells groceries while a supermarket sells general merchandise', false, 1),
      (v_question_id, 'Both formats carry an identical product range', false, 2),
      (v_question_id, 'A supermarket carries more general merchandise than a hypermarket', false, 3);
  END IF;

  -- 18. 3Cs: Competitor KRA = Market Share
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'In the 3 Cs of Marketing framework (Customer, Company, Competitor), which Key Results Area corresponds to the Competitor?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'In the 3 Cs of Marketing framework (Customer, Company, Competitor), which Key Results Area corresponds to the Competitor?', 'single_choice', 'medium', 'The output of the 3 Cs is collectively called the Key Results Area: Customer corresponds to Sales, Company corresponds to Profit, and Competitor corresponds to Market Share.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Sales', false, 0),
      (v_question_id, 'Profit', false, 1),
      (v_question_id, 'Market Share', true, 2),
      (v_question_id, 'Customer Value', false, 3);
  END IF;

  -- 19. Demand definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A want for a specific product that is backed up by an ability and willingness to buy it is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A want for a specific product that is backed up by an ability and willingness to buy it is called:', 'single_choice', 'easy', 'Demand is a want for a specific product backed up by an ability and willingness to buy it, distinct from a Need (a state of felt deprivation) and a Want (a need directed at a specific object).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Need', false, 0),
      (v_question_id, 'Want', false, 1),
      (v_question_id, 'Demand', true, 2),
      (v_question_id, 'Customer Value', false, 3);
  END IF;

  -- 20. Needs definition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = '"States of felt deprivation" best describes which marketing concept?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, '"States of felt deprivation" best describes which marketing concept?', 'single_choice', 'easy', 'Needs are states of felt deprivation. When needs become directed at specific objects that might satisfy them, they become Wants; when a want is backed by ability and willingness to buy, it becomes Demand.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Needs', true, 0),
      (v_question_id, 'Wants', false, 1),
      (v_question_id, 'Demands', false, 2),
      (v_question_id, 'Value Proposition', false, 3);
  END IF;

  -- 21. Value Proposition
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A broad promise of value that a company offers to customers, focusing on all the benefits a customer receives — including quality, service, experience, and emotional satisfaction — is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A broad promise of value that a company offers to customers, focusing on all the benefits a customer receives — including quality, service, experience, and emotional satisfaction — is called:', 'single_choice', 'medium', 'A Value Proposition is a broad promise of value covering all the benefits a customer receives, while a Unique Selling Proposition (USP) is a specific feature or benefit that differentiates a product from competitors.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Unique Selling Proposition (USP)', false, 0),
      (v_question_id, 'Value Proposition', true, 1),
      (v_question_id, 'Customer Value', false, 2),
      (v_question_id, 'Marketing Channel', false, 3);
  END IF;

  -- 22. USP
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A specific feature or benefit that makes a product different or better than competitors is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A specific feature or benefit that makes a product different or better than competitors is called:', 'single_choice', 'easy', 'The Unique Selling Proposition (USP) is a specific feature or benefit that differentiates a product in a crowded market, unlike the broader Value Proposition which covers all the benefits offered.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Value Proposition', false, 0),
      (v_question_id, 'Unique Selling Proposition (USP)', true, 1),
      (v_question_id, 'Market Segmentation', false, 2),
      (v_question_id, 'Customer Value', false, 3);
  END IF;

  -- 23. Demographic segmentation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Segmenting a market based on age, gender, income, and education is an example of which type of market segmentation?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Segmenting a market based on age, gender, income, and education is an example of which type of market segmentation?', 'single_choice', 'medium', 'Demographic segmentation groups consumers by age, gender, income, and education, while Geographic segmentation groups by region/climate/location, Psychographic by lifestyle/values/personality, and Behavioral by usage/loyalty/buying behavior.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Geographic', false, 0),
      (v_question_id, 'Demographic', true, 1),
      (v_question_id, 'Psychographic', false, 2),
      (v_question_id, 'Behavioral', false, 3);
  END IF;

  -- 24. Psychographic segmentation
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Market segmentation based on lifestyle, values, and personality is known as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Market segmentation based on lifestyle, values, and personality is known as:', 'single_choice', 'medium', 'Psychographic segmentation groups consumers by lifestyle, values, and personality, distinct from Demographic (age, gender, income, education) and Behavioral (usage, loyalty, buying behavior) segmentation.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Demographic segmentation', false, 0),
      (v_question_id, 'Psychographic segmentation', true, 1),
      (v_question_id, 'Geographic segmentation', false, 2),
      (v_question_id, 'Behavioral segmentation', false, 3);
  END IF;

  -- 25. Customer Value formula
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Customer Value is best expressed by which formula?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Customer Value is best expressed by which formula?', 'single_choice', 'easy', 'Customer Value = Benefits − Costs, representing the difference between the benefits a customer gets from a product and the costs they pay (money, time, effort).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Value = Price − Discount', false, 0),
      (v_question_id, 'Value = Benefits − Costs', true, 1),
      (v_question_id, 'Value = Revenue − Expenses', false, 2),
      (v_question_id, 'Value = Benefits + Costs', false, 3);
  END IF;

  -- 26. Distribution Channels
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Physical or digital pathways through which products are delivered or made available to customers are called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Physical or digital pathways through which products are delivered or made available to customers are called:', 'single_choice', 'medium', 'Distribution Channels are the physical or digital pathways through which products are delivered, as opposed to Communication Channels (deliver/receive messages from buyers) and Service Channels (carry out and facilitate transactions).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Communication Channels', false, 0),
      (v_question_id, 'Distribution Channels', true, 1),
      (v_question_id, 'Service Channels', false, 2),
      (v_question_id, 'Marketing System Participants', false, 3);
  END IF;

  -- 27. Form Utility
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Processing raw materials, such as turning wheat into flour, into more useful products illustrates which type of utility?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Processing raw materials, such as turning wheat into flour, into more useful products illustrates which type of utility?', 'single_choice', 'easy', 'Form Utility is created when processing changes raw materials into more useful products (e.g., wheat into flour), distinct from Place Utility (transportation), Time Utility (storage), and Possession Utility (transfer of ownership).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Place Utility', false, 0),
      (v_question_id, 'Form Utility', true, 1),
      (v_question_id, 'Time Utility', false, 2),
      (v_question_id, 'Possession Utility', false, 3);
  END IF;

  -- 28. Time Utility
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Ensuring product availability through storage when needed represents which type of utility?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Ensuring product availability through storage when needed represents which type of utility?', 'single_choice', 'medium', 'Time Utility is created through storage, which ensures product availability when needed, unlike Place Utility (moving products to areas of need) and Possession Utility (transferring ownership to those who value it more).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Form Utility', false, 0),
      (v_question_id, 'Place Utility', false, 1),
      (v_question_id, 'Time Utility', true, 2),
      (v_question_id, 'Possession Utility', false, 3);
  END IF;

  -- 29. Blue Ocean
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Competing in a market space where the other players are not present describes which type of competition?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Competing in a market space where the other players are not present describes which type of competition?', 'single_choice', 'easy', 'Blue Ocean competition means competing where the other players are not, as opposed to Red Ocean competition, which means competing where the other players already are.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Red Ocean', false, 0),
      (v_question_id, 'Blue Ocean', true, 1),
      (v_question_id, 'Perfect Competition', false, 2),
      (v_question_id, 'Monopolistic Competition', false, 3);
  END IF;

  -- 30. Production Concept philosophy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which marketing management philosophy assumes customers prefer products that are widely available and low-cost, summarized as "make it cheap and make it available"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which marketing management philosophy assumes customers prefer products that are widely available and low-cost, summarized as "make it cheap and make it available"?', 'single_choice', 'medium', 'The Production Concept assumes customers prefer widely available, low-cost products ("make it cheap and make it available"), unlike the Product Concept ("build a better product, and they will come") or the Selling Concept ("make them buy it").', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Product Concept', false, 0),
      (v_question_id, 'Production Concept', true, 1),
      (v_question_id, 'Selling Concept', false, 2),
      (v_question_id, 'Marketing Concept', false, 3);
  END IF;

  -- 31. Marketing Concept philosophy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which marketing management philosophy starts with the customer rather than the product, summarized as "find what they want, give it better than anyone else"?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which marketing management philosophy starts with the customer rather than the product, summarized as "find what they want, give it better than anyone else"?', 'single_choice', 'medium', 'The Marketing Concept starts with the customer, not the product: "find what they want, give it better than anyone else," as opposed to the Production Concept, Product Concept, or Selling Concept.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Production Concept', false, 0),
      (v_question_id, 'Product Concept', false, 1),
      (v_question_id, 'Selling Concept', false, 2),
      (v_question_id, 'Marketing Concept', true, 3);
  END IF;

  -- 32. Monopoly market structure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A market structure in which one firm controls the market with no close substitutes, high barriers to entry, and full price-setting power — exemplified by a local electricity provider — is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A market structure in which one firm controls the market with no close substitutes, high barriers to entry, and full price-setting power — exemplified by a local electricity provider — is called:', 'single_choice', 'hard', 'A Monopoly has one firm controlling the market, no competition or close substitutes, high barriers to entry, and price-setting power as a price maker (e.g., a local electricity provider).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Oligopoly', false, 0),
      (v_question_id, 'Monopoly', true, 1),
      (v_question_id, 'Monopolistic Competition', false, 2),
      (v_question_id, 'Perfect Competition', false, 3);
  END IF;

  -- 33. Oligopoly market structure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A market structure where few firms control the market, are interdependent in pricing and output decisions, and may engage in collusion or price wars — exemplified by the telecom industry — is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A market structure where few firms control the market, are interdependent in pricing and output decisions, and may engage in collusion or price wars — exemplified by the telecom industry — is called:', 'single_choice', 'hard', 'An Oligopoly has few firms controlling the market, interdependent in pricing/output decisions with possible collusion or price wars, moderate-to-high barriers to entry (e.g., telecom and automobile industries).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Monopoly', false, 0),
      (v_question_id, 'Oligopoly', true, 1),
      (v_question_id, 'Monopolistic Competition', false, 2),
      (v_question_id, 'Perfect Competition', false, 3);
  END IF;

  -- 34. Monopolistic Competition market structure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A market structure with many sellers offering differentiated (not identical) products, where firms have some price control due to brand identity and barriers to entry are low — exemplified by fast food chains — is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A market structure with many sellers offering differentiated (not identical) products, where firms have some price control due to brand identity and barriers to entry are low — exemplified by fast food chains — is called:', 'single_choice', 'medium', 'Monopolistic Competition has many sellers with differentiated products, some price control due to brand identity, and low barriers to entry so new firms can enter easily (e.g., fast food chains, clothing brands).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Monopoly', false, 0),
      (v_question_id, 'Oligopoly', false, 1),
      (v_question_id, 'Monopolistic Competition', true, 2),
      (v_question_id, 'Perfect Competition', false, 3);
  END IF;

  -- 35. Perfect Competition market structure
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which market structure is exemplified by agricultural products and the stock market, where many small firms sell identical products, there are no barriers to entry or exit, and firms must accept the market price?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which market structure is exemplified by agricultural products and the stock market, where many small firms sell identical products, there are no barriers to entry or exit, and firms must accept the market price?', 'single_choice', 'hard', 'Perfect Competition has many small firms selling identical products, no barriers to entry or exit, and firms must accept the market price; agricultural products and the stock market are given as examples where buyers and sellers know everything about the product and market.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Monopolistic Competition', false, 0),
      (v_question_id, 'Oligopoly', false, 1),
      (v_question_id, 'Perfect Competition', true, 2),
      (v_question_id, 'Monopoly', false, 3);
  END IF;

  -- 36. Elastic Demand
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Demand is described as "elastic" when:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Demand is described as "elastic" when:', 'single_choice', 'medium', 'Elastic Demand occurs when a decrease in price results in higher total revenue, while Inelastic Demand results in revenue loss when prices are lowered.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'A decrease in price results in higher total revenue', true, 0),
      (v_question_id, 'A decrease in price results in revenue loss', false, 1),
      (v_question_id, 'An increase in price leads to no change in quantity demanded', false, 2),
      (v_question_id, 'Demand changes infinitely with a very small change in price', false, 3);
  END IF;

  -- 37. Inelastic Demand
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Which type of demand results in revenue loss when prices are lowered?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Which type of demand results in revenue loss when prices are lowered?', 'single_choice', 'medium', 'Inelastic Demand results in revenue loss when prices are lowered, as opposed to Elastic Demand, where a price decrease results in higher total revenue.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Elastic Demand', false, 0),
      (v_question_id, 'Inelastic Demand', true, 1),
      (v_question_id, 'Perfectly Elastic Demand', false, 2),
      (v_question_id, 'Perfectly Inelastic Demand', false, 3);
  END IF;

  -- 38. Penetration Pricing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Setting low prices initially to gain market share, as the opposite approach to starting with high prices and lowering them, is known as which agricultural pricing strategy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Setting low prices initially to gain market share, as the opposite approach to starting with high prices and lowering them, is known as which agricultural pricing strategy?', 'single_choice', 'medium', 'Penetration Pricing sets low prices to gain market share, the opposite of starting high and lowering prices as competitors enter. It differs from Prestige Pricing (high prices for an image of exclusivity) and Value Pricing (price high if the product is seen as superior).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Prestige Pricing', false, 0),
      (v_question_id, 'Value Pricing', false, 1),
      (v_question_id, 'Penetration Pricing', true, 2),
      (v_question_id, 'Odd-Even Pricing', false, 3);
  END IF;

  -- 39. Odd-Even Pricing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Pricing a product at P98.99 instead of P99 to create a psychological impression of being cheaper is an example of which pricing strategy?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Pricing a product at P98.99 instead of P99 to create a psychological impression of being cheaper is an example of which pricing strategy?', 'single_choice', 'easy', 'Odd-Even Pricing uses prices like P98.99 for psychological appeal, making the price seem cheaper than a round number like P99.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Prestige Pricing', false, 0),
      (v_question_id, 'Odd-Even Pricing', true, 1),
      (v_question_id, 'Price Lining', false, 2),
      (v_question_id, 'Bundle Pricing', false, 3);
  END IF;

  -- 40. Bundle Pricing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Selling multiple products together at a discount, common with farm produce bundles, is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Selling multiple products together at a discount, common with farm produce bundles, is called:', 'single_choice', 'medium', 'Bundle Pricing sells multiple products together at a discount, commonly used with farm produce bundles, unlike Price Lining (offering products at specific set price levels).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Price Lining', false, 0),
      (v_question_id, 'Bundle Pricing', true, 1),
      (v_question_id, 'Trade Discount', false, 2),
      (v_question_id, 'Quantity Discount', false, 3);
  END IF;

  -- 41. Trade Discount
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'A discount that allows retailers or wholesalers to recover costs and generate profits is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'A discount that allows retailers or wholesalers to recover costs and generate profits is called a:', 'single_choice', 'medium', 'A Trade Discount allows retailers/wholesalers to recover costs and generate profits, distinct from a Quantity Discount (based on amount purchased), Cash Discount (for paying within a set period), and Promotional Discount (tied to sales promotions).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Quantity Discount', false, 0),
      (v_question_id, 'Trade Discount', true, 1),
      (v_question_id, 'Cash Discount', false, 2),
      (v_question_id, 'Promotional Discount', false, 3);
  END IF;

  -- 42. Price Fixing
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Illegal collaboration among competitors to set the same price for similar products is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Illegal collaboration among competitors to set the same price for similar products is called:', 'single_choice', 'hard', 'Price Fixing is illegal collaboration among competitors to set the same price for similar products, distinct from Price Discrimination (offering different prices to different customers), Price Deception (hiding the true price), and Price Dumping (selling below cost internationally).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Price Discrimination', false, 0),
      (v_question_id, 'Price Fixing', true, 1),
      (v_question_id, 'Price Deception', false, 2),
      (v_question_id, 'Price Dumping', false, 3);
  END IF;

  -- 43. Price Dumping
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Selling products internationally below cost, combining price discrimination and predatory pricing, is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Selling products internationally below cost, combining price discrimination and predatory pricing, is called:', 'single_choice', 'hard', 'Price Dumping is selling products internationally below cost, combining price discrimination and predatory pricing — an illegal pricing practice distinct from Price Fixing, Price Discrimination, and Price Deception.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Price Fixing', false, 0),
      (v_question_id, 'Price Discrimination', false, 1),
      (v_question_id, 'Price Deception', false, 2),
      (v_question_id, 'Price Dumping', true, 3);
  END IF;

  -- 44. Wholesalers
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Market participants who buy in bulk from producers and sell smaller quantities to retailers, without dealing with end-users of products, are called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Market participants who buy in bulk from producers and sell smaller quantities to retailers, without dealing with end-users of products, are called:', 'single_choice', 'medium', 'Wholesalers buy in bulk from producers and sell smaller quantities to retailers, not dealing with end-users (e.g., a distributor selling grains to grocery stores), unlike Retailers (who sell directly to consumers).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Assemblers', false, 0),
      (v_question_id, 'Wholesalers', true, 1),
      (v_question_id, 'Retailers', false, 2),
      (v_question_id, 'Brokers', false, 3);
  END IF;

  -- 45. Brokers
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Market participants who negotiate sales in larger markets without owning the products being sold, such as assisting with organic produce sales, are called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Market participants who negotiate sales in larger markets without owning the products being sold, such as assisting with organic produce sales, are called:', 'single_choice', 'hard', 'Brokers negotiate sales in larger markets without owning the products (e.g., a broker assisting with organic produce sales), while Agents facilitate transactions between producers and buyers for a commission.', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Agents', false, 0),
      (v_question_id, 'Wholesalers', false, 1),
      (v_question_id, 'Brokers', true, 2),
      (v_question_id, 'Dealers', false, 3);
  END IF;

  -- 46. Fresh Products classification
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Products directly harvested from the farms that do not pass through higher levels of transformation are classified as:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Products directly harvested from the farms that do not pass through higher levels of transformation are classified as:', 'single_choice', 'easy', 'Fresh Products are directly harvested from farms and do not pass through higher levels of transformation, unlike Semi-processed Products (which undergo a secondary level of transformation) or Finished Products (ready for direct consumption).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Semi-processed Products', false, 0),
      (v_question_id, 'Fresh Products', true, 1),
      (v_question_id, 'Finished Products', false, 2),
      (v_question_id, 'Value-added Products', false, 3);
  END IF;

  -- 47. Packaging as most common ag marketing strategy
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'For agricultural products, which strategy of "dressing the product" is stated as the most common way to improve marketability, shelf life, and appeal?';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'For agricultural products, which strategy of "dressing the product" is stated as the most common way to improve marketability, shelf life, and appeal?', 'single_choice', 'easy', 'For agricultural products, Packaging is the most common strategy used to improve marketability, shelf life, and appeal, distinct from Branding (identity/recognition) and Labeling (providing product information).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Branding', false, 0),
      (v_question_id, 'Packaging', true, 1),
      (v_question_id, 'Labeling', false, 2),
      (v_question_id, 'Advertising', false, 3);
  END IF;

  -- 48. Indirect Marketing place option
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'Selling farm products through intermediaries rather than directly transacting with the buyer is called:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'Selling farm products through intermediaries rather than directly transacting with the buyer is called:', 'single_choice', 'easy', 'Indirect Marketing involves selling through intermediaries, one of the place options under the facilitating functions of agricultural marketing channels, as opposed to Direct Marketing (direct communication and transaction with the buyer).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Direct Marketing', false, 0),
      (v_question_id, 'Indirect Marketing', true, 1),
      (v_question_id, 'Distribution Channel', false, 2),
      (v_question_id, 'Facilitating Function', false, 3);
  END IF;

  -- 49. Break-Even Point
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'The sales volume at which a farm neither makes a profit nor a loss is called the:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'The sales volume at which a farm neither makes a profit nor a loss is called the:', 'single_choice', 'hard', 'The Break-Even Point is the sales volume where a farm neither makes a profit nor a loss, distinct from Marginal Cost (cost of producing one additional unit) and Opportunity Cost (value of what is forgone).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Break-Even Point', true, 0),
      (v_question_id, 'Marginal Cost', false, 1),
      (v_question_id, 'Net Working Capital', false, 2),
      (v_question_id, 'Opportunity Cost', false, 3);
  END IF;

  -- 50. Cooperative
  SELECT id INTO v_question_id FROM public.questions WHERE topic_id = v_topic_id AND question_text = 'An organization owned collectively by members who share in its profits and benefits is called a:';
  IF v_question_id IS NULL THEN
    INSERT INTO public.questions (topic_id, subtopic_id, question_text, question_type, difficulty, explanation, source, source_reference, status, is_recalled, recalled_batch, is_paes, paes_reference)
    VALUES (v_topic_id, NULL, 'An organization owned collectively by members who share in its profits and benefits is called a:', 'single_choice', 'hard', 'A Cooperative is an organization owned collectively by members who share its profits and benefits, distinct from Compact Farming (grouping land holdings to operate as one farm with pooled resources).', NULL, NULL, 'draft', false, NULL, false, NULL)
    RETURNING id INTO v_question_id;
    INSERT INTO public.choices (question_id, choice_text, is_correct, sort_order) VALUES
      (v_question_id, 'Corporation', false, 0),
      (v_question_id, 'Cooperative', true, 1),
      (v_question_id, 'Compact Farm', false, 2),
      (v_question_id, 'Partnership', false, 3);
  END IF;

END $$;
