-- PAES Library support: lets a reviewer_entries row (formula/table/constant)
-- be tagged with the specific PAES standard number it comes from, mirroring
-- questions.paes_reference (024_paes_questions.sql) exactly. This is what
-- lets the PAES Library group entries by standard, the PAES Number Bank
-- filter to numeric entries with a reference, and a quiz question's
-- "Practice This PAES" link find the matching Library content.

alter table public.reviewer_entries add column if not exists paes_reference text;

create index if not exists reviewer_entries_paes_reference_idx
  on public.reviewer_entries (paes_reference) where paes_reference is not null;

create index if not exists questions_paes_reference_idx
  on public.questions (paes_reference) where paes_reference is not null;
