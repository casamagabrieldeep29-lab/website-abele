import Link from "next/link";

const LAST_UPDATED = "September 28, 2026";
const CONTACT_EMAIL = "casamagabrieldeep29@gmail.com";

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="mt-8">
      <h2 className="text-lg font-semibold tracking-tight">{title}</h2>
      <div className="mt-2 space-y-3 text-sm leading-relaxed text-muted-foreground">{children}</div>
    </section>
  );
}

export default function PrivacyPolicyPage() {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border/70 bg-background/85">
        <div className="mx-auto flex max-w-3xl items-center justify-between px-6 py-4">
          <Link href="/" className="text-lg font-bold tracking-tight text-primary">
            ABELIEVER
          </Link>
          <Link href="/" className="text-sm text-muted-foreground hover:text-foreground hover:underline">
            ← Back home
          </Link>
        </div>
      </header>

      <main className="mx-auto max-w-3xl px-6 py-12">
        <h1 className="text-3xl font-bold tracking-tight">Privacy Policy</h1>
        <p className="mt-2 text-sm text-muted-foreground">Last updated {LAST_UPDATED}</p>

        <p className="mt-6 text-sm leading-relaxed text-muted-foreground">
          ABELIEVER is a review platform for the Philippine Agricultural and Biosystems Engineering (ABE)
          Licensure Examination. This page describes, in plain terms, what personal data we actually collect,
          why, and what your rights are under the Data Privacy Act of 2012 (Republic Act No. 10173) and its
          Implementing Rules and Regulations. It describes what this app really does — not a generic template.
        </p>

        <Section title="Who we are">
          <p>
            ABELIEVER is operated by an individual (not a registered company) as a small, invite-adjacent review
            platform for ABE students and reviewees. For any data privacy question, correction request, or
            complaint, contact <a href={`mailto:${CONTACT_EMAIL}`} className="text-primary hover:underline">{CONTACT_EMAIL}</a>.
          </p>
        </Section>

        <Section title="What we collect">
          <p>We collect only what the platform actually needs to work:</p>
          <ul className="list-disc space-y-1.5 pl-5">
            <li><strong>Account information:</strong> your email address, and a password if you choose to set one (you can also sign in with a one-time code emailed to you instead).</li>
            <li><strong>Profile details you choose to share:</strong> display name, school, and whether you&apos;re still studying or reviewing for the boards. All optional.</li>
            <li><strong>Study activity:</strong> your practice and mock exam answers, accuracy, mastery per topic, streaks, notes, bookmarks, and flashcard/quiz progress — this is the data that makes your dashboard and progress tracking work.</li>
            <li><strong>Payment verification details:</strong> if you upgrade, the payment method you used (GCash, Maya, or Landbank), the reference/transaction number, the payer name, and — if you choose to attach one — a screenshot of your receipt. We do not collect or store your card, bank, or e-wallet credentials; payment itself happens directly in your GCash/Maya/Landbank app, outside ABELIEVER.</li>
            <li><strong>Basic technical data:</strong> when you were last active, used only to show whether your account is currently online (visible to admin) and to enforce trial/session limits.</li>
          </ul>
        </Section>

        <Section title="How your data is used">
          <p>We process your personal data to:</p>
          <ul className="list-disc space-y-1.5 pl-5">
            <li>Create and secure your account, and let you sign in.</li>
            <li>Run the actual features you use — practice sessions, mock exams, mistake review, progress/mastery tracking, flashcards, and quizzes.</li>
            <li>Generate AI explanations when you ask for one (e.g. &quot;Teach Me This&quot; or the Study Assistant) — this sends the relevant question text to our AI provider (see below) to generate a response.</li>
            <li>Verify a payment you&apos;ve submitted, including using AI to check whether a submitted receipt image shows the reference number and name you provided, before approving or routing it for manual review.</li>
            <li>Communicate with you about your account (e.g. login links, confirmation emails).</li>
          </ul>
          <p>We do not sell your personal data, and we do not use it for advertising.</p>
        </Section>

        <Section title="Who we share it with">
          <p>
            We don&apos;t sell or rent your data to third parties. A small number of service providers process
            data on our behalf, strictly to run the platform:
          </p>
          <ul className="list-disc space-y-1.5 pl-5">
            <li><strong>Supabase</strong> — our database, authentication, and file storage provider. Your account, study data, and any receipt image you upload are stored there.</li>
            <li><strong>Google (Gemini API)</strong> — used to generate AI explanations and to verify payment receipts. Relevant question text or receipt images are sent to this API to produce a response; they are not used by us to train any model.</li>
            <li><strong>Vercel</strong> — hosts and serves the ABELIEVER web application itself.</li>
          </ul>
          <p>
            We may also disclose personal data if required by law, or to a competent authority such as the
            National Privacy Commission, if properly requested.
          </p>
        </Section>

        <Section title="How long we keep it">
          <p>
            We keep your account and study data for as long as your account exists, so your progress stays
            available to you. If you delete your account (Settings → Delete Account), your profile and study
            data are permanently removed. Payment verification records are kept for a reasonable period for
            our own bookkeeping and to resolve disputes, even after an account is deleted, as permitted under
            the Data Privacy Act.
          </p>
        </Section>

        <Section title="How we protect it">
          <p>
            Your data is protected by row-level security at the database level — meaning the system itself
            only allows you (or an administrator, for account-management purposes) to read or write your own
            data, enforced on every request, not just in the app&apos;s interface. Passwords are never stored
            in plain text. Payment receipt images are kept in a private storage bucket, not publicly
            accessible.
          </p>
        </Section>

        <Section title="Your rights under the Data Privacy Act">
          <p>As a data subject under RA 10173, you have the right to:</p>
          <ul className="list-disc space-y-1.5 pl-5">
            <li><strong>Be informed</strong> that your personal data is being processed — this page, and the account/consent screens themselves, are how we do that.</li>
            <li><strong>Access</strong> your personal data that we hold.</li>
            <li><strong>Object</strong> to processing you didn&apos;t consent to, or dispute an automated decision that significantly affects you.</li>
            <li><strong>Correct</strong> inaccurate or outdated data — most of your own profile fields can be edited directly in Settings; contact us for anything you can&apos;t change yourself.</li>
            <li><strong>Erasure or blocking</strong> of your data, including by deleting your account entirely.</li>
            <li><strong>Data portability</strong> — a copy of your data in an electronic format, on request.</li>
            <li><strong>Damages</strong> for harm caused by inaccurate, unlawful, or unauthorized processing of your data.</li>
            <li><strong>Lodge a complaint</strong> with the National Privacy Commission (privacy.gov.ph) if you believe your rights under the Data Privacy Act have been violated.</li>
          </ul>
          <p>
            To exercise any of these rights, email <a href={`mailto:${CONTACT_EMAIL}`} className="text-primary hover:underline">{CONTACT_EMAIL}</a>.
          </p>
        </Section>

        <Section title="Cookies and sessions">
          <p>
            ABELIEVER uses a small number of essential cookies to keep you signed in between visits. We don&apos;t
            use third-party advertising or tracking cookies.
          </p>
        </Section>

        <Section title="Changes to this policy">
          <p>
            If how we handle your data changes in a meaningful way, we&apos;ll update this page and change the
            &quot;last updated&quot; date above.
          </p>
        </Section>
      </main>

      <footer className="border-t px-6 py-6 text-center text-xs text-muted-foreground">
        ABELIEVER — private ABE Licensure Exam review platform.
      </footer>
    </div>
  );
}
