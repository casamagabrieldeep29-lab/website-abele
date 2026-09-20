"use client";

import { Mail } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

const RECIPIENT = "casamagabrieldeep29@gmail.com";
const SUBJECT = "Transcription Request";
const BODY = `Hello Gabriel,

I would like to request a transcription.

Topic/Section/Pages to transcribe:


Additional instructions:


I have attached the study material to this email.

Thank you!`;

const GMAIL_COMPOSE_URL = `https://mail.google.com/mail/?view=cm&fs=1&to=${encodeURIComponent(RECIPIENT)}&su=${encodeURIComponent(SUBJECT)}&body=${encodeURIComponent(BODY)}`;

const CHECKLIST = [
  "Attach your study material",
  "Specify the topic, section, or page numbers",
  "Add any special instructions",
];

/**
 * Purely a Gmail-compose-link generator — no upload, no storage, no backend
 * involvement of any kind. The website never receives the actual file; the
 * student attaches it directly in Gmail after being redirected there.
 */
export function RequestTranscription() {
  return (
    <Dialog>
      <DialogTrigger render={<Button variant="outline" size="sm" />}>
        <Mail className="size-4" />
        Request Transcription
      </DialogTrigger>

      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Request Transcription</DialogTitle>
        </DialogHeader>

        <div className="space-y-4 text-sm">
          <div className="space-y-2 text-muted-foreground">
            <p>Need a topic, handout, reviewer, or study material transcribed?</p>
            <p>
              Send your file directly through Gmail and tell me exactly what topics, pages, or
              sections you want transcribed.
            </p>
          </div>

          <p className="text-xs text-muted-foreground">
            Transcription by: <span className="font-medium text-foreground">Gabriel Deep C. Casama</span>
          </p>

          <div>
            <p className="text-xs font-semibold uppercase tracking-wide text-primary">What to include</p>
            <ul className="mt-2 space-y-1">
              {CHECKLIST.map((item) => (
                <li key={item} className="flex items-start gap-2 text-muted-foreground">
                  <span className="mt-1.5 size-1 shrink-0 rounded-full bg-primary" />
                  {item}
                </li>
              ))}
            </ul>
          </div>

          <Button
            render={<a href={GMAIL_COMPOSE_URL} target="_blank" rel="noreferrer" />}
            nativeButton={false}
            className="w-full"
          >
            <Mail className="size-4" />
            Request via Gmail
          </Button>

          <p className="text-xs text-muted-foreground">
            Having trouble opening Gmail? You can email your transcription request directly to:{" "}
            <a href={`mailto:${RECIPIENT}`} className="text-primary underline underline-offset-2">
              {RECIPIENT}
            </a>
          </p>
        </div>
      </DialogContent>
    </Dialog>
  );
}
