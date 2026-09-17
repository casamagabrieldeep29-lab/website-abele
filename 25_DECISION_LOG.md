# 25. DECISION LOG

Architectural and product decisions, and why they were made. Append new entries at the bottom; never delete history — if a decision is reversed, add a new entry explaining the reversal instead of editing the old one.

---

### 2026-09-18 — Product name and branding direction
**Decision:** Name the platform "ABELIEVER". Green-forward color palette (agriculture association), exact shades left to implementation.
**Why:** Gabriel's choice; ABE + "believer" pun fits the target audience (ABE licensure examinees).

---

### 2026-09-18 — Initial scope: small invite-only group, not public platform
**Decision:** Build for Gabriel + a small, possibly-growing group of classmates/reviewees. Invite-only accounts via magic-link email. Gabriel is sole admin.
**Why:** Real near-term need is a small trusted group studying for a November 2026 exam, not a public product launch. Avoids building public-signup/abuse-prevention/multi-admin-permission complexity that isn't needed yet.
**How to apply:** Don't hard-code a fixed small group size anywhere (Gabriel confirmed the group could grow) — auth/db design should scale without a rewrite, even though initial usage is small.

---

### 2026-09-18 — Build sequencing: real architecture now, features shipped incrementally
**Decision:** Set up the actual database schema, auth, and project structure correctly up front (matching the full master-instructions ambition), but prioritize shipping a working Practice Mode + Mock Exam experience within weeks rather than completing every master-doc section in order first.
**Why:** November 2026 exam deadline means a usable review tool is needed soon; but Gabriel explicitly wants the "full platform" architecture, not a throwaway prototype. This sequencing gets both: no rework later, but usable value early.

---

### 2026-09-18 — Tech stack: Next.js + Supabase + Vercel, TypeScript, Tailwind + shadcn/ui
**Decision:** Next.js (TypeScript) for the app, Supabase for database/auth/storage, Vercel for hosting, Tailwind CSS + shadcn/ui for styling.
**Why:** Gabriel had no existing preference and accepted the recommendation. This stack covers auth + database + hosting on generous free tiers, fits a small-to-growing user base, and Tailwind + shadcn avoids the "glassmorphism / decorative clutter" the master doc explicitly warns against (Section 15).
**How to apply:** Don't introduce a second framework/database technology without a matching decision log entry explaining why the above no longer fits.

---

### 2026-09-18 — Repository and code location
**Decision:** Application code lives in this same repo (`website-abele`), in a dedicated `/platform` subfolder, alongside the existing docs (root) and source materials (`ABELE TOP 1/`, `OFFICIAL_SOURCE_FILES/`).
**Why:** Gabriel preferred one repo for everything over splitting code and content across repos, given the small-team/personal-project scale.

---

### 2026-09-18 — Deployment target: Vercel free URL, no custom domain yet
**Decision:** Deploy to a free `*.vercel.app` URL initially. Default to free tiers on all services; a small paid upgrade is acceptable only if a free-tier limit genuinely becomes a blocker, and only with explicit confirmation before spending.
**Why:** No domain owned yet; budget is limited but not zero.

---

### 2026-09-18 — Content strategy: transcribe existing verified Q&A rather than generate new questions
**Decision:** For the pilot content build, extract the exact questions, choices, and answers already present in the `ABELE TOP 1/` review-center materials (which include actual tests with answer keys — e.g. consolidated tests, pre/post tests, area exams), rather than having AI author new exam questions from raw lecture content.
**Why:** This is materially different from the master doc's default assumption (Section 22, content review workflow) that AI-drafted educational content needs human technical review before publishing — here the "authoring" is transcription of already-answer-keyed source material, not invention. Gabriel explicitly directed this ("use the exact questions and answers from the materials, everything is in there") and confirmed he has the right to use this content for personal + group study.
**How to apply:** Transcription accuracy (did we copy the question/choices/answer correctly from the PDF/PPTX) still needs spot-checking — OCR/manual extraction errors are a real risk even when the source is "correct." If new questions are ever authored (not transcribed) for this platform in the future, the default Section 22 human-review workflow applies again — this decision does not blanket-waive review for all future content, only for transcription of existing answer-keyed source material.
**Content boundary:** Raw source PDFs/PPTX/DOCX stay private (never served to or downloadable by end users) — only extracted, structured question/lesson data is exposed through the app, and only to invited/logged-in users, per `01_PROJECT_CONTEXT.md` Section 7.

---

### 2026-09-18 — Content build order: pilot on Area 1 + Area 2 source materials
**Decision:** Build the content extraction pipeline and first working question bank against the source folder's "Area 1" and "Area 2" materials (mapping to Power/Energy/Machinery Engineering and Land & Water Resources Engineering, both 18%-weighted per the PRC Table of Specifications), before extending to Area 3 and the remaining lower-weighted official exam areas.
**Why:** Follows official TOS weighting (highest-value areas first) per Gabriel's choice, and these two source folders have the most complete existing material to pilot against.

---

### 2026-09-18 — Skip password-protected source PDFs for now
**Decision:** Files in `ABELE TOP 1/` with "protected" in the filename are excluded from content extraction until a password is available.
**Why:** No passwords currently available; better to proceed with accessible material than block the pipeline.
