import "server-only";
import { AIProvider, AIProviderError } from "./types";

// Groq's API is OpenAI-compatible, so a plain fetch against its chat
// completions endpoint is enough — no extra SDK dependency needed.
const GROQ_ENDPOINT = "https://api.groq.com/openai/v1/chat/completions";

export class GroqProvider implements AIProvider {
  constructor(
    private apiKey: string,
    private model: string,
  ) {}

  async generate({ systemInstruction, prompt }: { systemInstruction: string; prompt: string }): Promise<string> {
    const response = await fetch(GROQ_ENDPOINT, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${this.apiKey}`,
      },
      body: JSON.stringify({
        model: this.model,
        messages: [
          { role: "system", content: systemInstruction },
          { role: "user", content: prompt },
        ],
      }),
    });

    if (!response.ok) {
      const body = await response.text().catch(() => "");
      throw new AIProviderError(`Groq request failed (${response.status}): ${body.slice(0, 300)}`);
    }

    const data = await response.json();
    const text = data?.choices?.[0]?.message?.content as string | undefined;
    if (!text || !text.trim()) {
      throw new AIProviderError("Groq returned an empty response.");
    }
    return text.trim();
  }
}
