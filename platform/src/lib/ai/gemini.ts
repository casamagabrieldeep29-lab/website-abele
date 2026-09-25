import "server-only";
import { GoogleGenAI } from "@google/genai";
import { AIProvider, AIProviderError } from "./types";

export class GeminiProvider implements AIProvider {
  readonly label: string;
  private client: GoogleGenAI;
  private model: string;

  constructor(apiKey: string, model: string, label = "Gemini") {
    this.client = new GoogleGenAI({ apiKey });
    this.model = model;
    this.label = label;
  }

  async generate({ systemInstruction, prompt }: { systemInstruction: string; prompt: string }): Promise<string> {
    const response = await this.client.models.generateContent({
      model: this.model,
      contents: prompt,
      config: { systemInstruction },
    });

    const text = response.text;
    if (!text || !text.trim()) {
      throw new AIProviderError("Gemini returned an empty response.");
    }
    return text.trim();
  }
}
