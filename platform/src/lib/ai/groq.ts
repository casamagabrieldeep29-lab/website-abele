import "server-only";
import { OpenAICompatibleProvider } from "./openai-compatible";

export class GroqProvider extends OpenAICompatibleProvider {
  constructor(apiKey: string, model: string, label = "Groq") {
    super("https://api.groq.com/openai/v1/chat/completions", apiKey, model, label);
  }
}
