# 01. PROJECT CONTEXT
## ABELIEVER — ABE Licensure Exam Review Platform

This document captures the concrete, decided scope for this specific build. It is the source of truth for "what are we actually building" — `00_MASTER_PROJECT_INSTRUCTIONS.md` is the philosophy/framework; this file is the current reality. Update it whenever a decision below changes.

---

## 1. Name & Branding

- **Product name:** ABELIEVER
- **Color direction:** Green-forward palette (agriculture association), exact palette chosen by implementation, refinable later.
- **Tone:** professional, academic, engineering-oriented — per Section 5 of the master instructions. Not a gamified quiz app.

## 2. Who This Is For (current phase)

- **Primary users:** Gabriel + a small group of classmates/reviewees preparing for the ABE Licensure Exam.
- **Group size:** Unknown/could grow — do not hard-code assumptions that only work for a fixed tiny group.
- **Admin:** Gabriel only, for now (sole admin — inviting users, managing content, viewing group performance).
- This is **not yet** an open-signup public platform, but the architecture should not preclude growing into one later (per master doc ambition).

## 3. Timeline

- Target exam: **around November 2026.**
- Implication: need a genuinely usable Practice + Mock Exam experience within weeks, not just architecture.

## 4. Build Sequencing (how "full platform" gets built)

Decided approach: **build the real architecture now, ship working features incrementally.**

- Set up the actual database schema, auth, and project structure correctly from day one so nothing gets thrown away later.
- Get Practice Mode + Mock Exam working and usable within the first few weeks.
- Layer in analytics, admin CMS refinement, and content workflow tooling after the core review loop works.
- Do **not** attempt to fully build every section of the master doc in strict document order before any feature ships — that was explicitly rejected in favor of the above.

## 5. Tech Stack (decided)

| Layer | Choice |
|---|---|
| Framework | Next.js (TypeScript) |
| Database + Auth + Storage | Supabase |
| Hosting | Vercel |
| Styling | Tailwind CSS + shadcn/ui |
| Auth method | Magic link (passwordless email), invite-only — no public signup |

Accounts: Gabriel already has both a Supabase account and a Vercel account. Project-specific keys/URLs will be supplied when wiring each service (never committed to the repo — see `16_SECURITY_AND_PRIVACY.md` once written).

## 6. Repository & Deployment

- Everything lives in this same repo (`website-abele`) — docs, source review materials, and app code together.
- The Next.js application lives in its own subfolder: **`/platform`**.
- No custom domain yet — deploy to the free Vercel URL (e.g. `abeliever.vercel.app`) until a domain is acquired.
- Budget: default to free tiers everywhere; a small paid upgrade is acceptable if a free-tier limit genuinely blocks something (get confirmation before spending).

## 7. Public Surface

- The site has a **simple public landing page** (what ABELIEVER is, purpose, maybe a TOS/exam-area overview) with a login/magic-link entry point.
- Everything beyond the landing page (question bank, practice, mock exams, progress, admin) is gated behind invite-only login.
- Never expose the raw source materials (`ABELE TOP 1/`) publicly or make them downloadable through the app — only structured, extracted question/lesson content is surfaced.

## 8. Content Strategy — THIS IS A DEVIATION FROM THE DEFAULT MASTER-DOC WORKFLOW

Per Section 22 of the master instructions, AI-drafted content would normally require human review before publishing. **Gabriel has explicitly overridden this for this project's specific source material**, on the following basis:

- The `ABELE TOP 1/` materials already contain **actual review-center questions with answer keys** (e.g. consolidated tests, pre/post tests, "200 QUESTIONS", area exams by Tambong/Belonio/Tenorio) — not just raw lecture content that would need new questions invented.
- Decision: **extract/transcribe the exact questions and answers already present in these materials**, rather than generating new questions. This is transcription of existing verified content, not invention — but transcription accuracy (correct question text, correct choices, correct answer key, correct explanation where given) still matters and should be spot-checked, since OCR/manual extraction from PDFs/PPTX can introduce errors.
- Gabriel has confirmed he has the right to use this content for personal + small-group study use (materials he paid for / was given for this purpose). Content stays behind invite-only login, never public, per Section 7 above.
- Password-protected PDFs in the source folder (filenames containing "protected") are **skipped for now** — no passwords available. Revisit if/when a password is provided.

## 9. Content Build Order

Per the official PRC Table of Specifications weighting (Section 3 of master instructions), content extraction is prioritized by exam weight, starting with the two highest-value/most fully-populated areas:

1. **Pilot areas (build first):**
   - Area 1 materials → Agricultural and Biosystems Power, Energy and Machinery Engineering (18%) — also covers Laws/Ethics, Marketing & Management, Automation & Control, Engineering Economy as organized in the source folder.
   - Area 2 materials → Land and Water Resources Engineering (18%) — hydrology, irrigation & drainage, fluid mechanics, groundwater, surveying, pumps, open channel.
2. **Next up (after pilot proves the pipeline):** Area 3 materials, which span two official exam areas — Agricultural and Biosystems Structures and Environment Engineering (18%) and Agricultural and Bioprocess Engineering (18%).
3. **Later:** Project Management/Feasibility/R&D&E (8%), Fundamentals of Agri/Fishery/Ecological/Environmental Sciences (6%), Mathematics and Basic Engineering Principles (8%), Laws/Professional Standards/Ethics (6%) — cross-check against whatever hasn't already been absorbed from Area 1/3 materials above.

Note: the source folder's own "Area 1/2/3" grouping (ATTRC review-center convention) does not map 1:1 to the eight official PRC exam areas — this will need reconciling during content modeling (see `03_EXAM_CONTENT_STANDARDS.md` when written).

## 10. Open Items / Revisit Later

- Custom domain (none yet).
- Whether additional admins/reviewers get added (currently sole-admin).
- Password-protected source PDFs (currently skipped).
- Multi-select/advanced question types beyond what's in the pilot content.
- Formal content-review workflow (currently bypassed for materials with existing answer keys — reconsider if the platform starts accepting new, non-source-verified questions).
