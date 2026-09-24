import "server-only";
import { OpenAICompatibleProvider } from "./openai-compatible";

// OpenRouter tags its zero-cost models with a ":free" suffix — a real
// model id, not a placeholder, but OpenRouter's free model lineup does
// change over time, so verify at openrouter.ai/models?max_price=0 if this
// one ever starts erroring (it'll just fall through to the next provider
// in the chain rather than break anything).
export class OpenRouterProvider extends OpenAICompatibleProvider {
  constructor(apiKey: string, model: string) {
    super("https://openrouter.ai/api/v1/chat/completions", apiKey, model, "OpenRouter");
  }
}
