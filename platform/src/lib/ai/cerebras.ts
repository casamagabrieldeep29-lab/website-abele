import "server-only";
import { OpenAICompatibleProvider } from "./openai-compatible";

export class CerebrasProvider extends OpenAICompatibleProvider {
  constructor(apiKey: string, model: string) {
    super("https://api.cerebras.ai/v1/chat/completions", apiKey, model, "Cerebras");
  }
}
