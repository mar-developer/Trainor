// AI Gateway config. We use plain `"provider/model"` strings so swapping
// providers is a one-line change and observability is unified.
// See https://vercel.com/docs/ai-gateway

export const AI_MODELS = {
  // Chat — Claude Haiku 4.5: cheap, fast, free-tier-friendly, plenty smart
  // for RAG-grounded tutoring. Bump to "anthropic/claude-sonnet-4-6" or
  // "anthropic/claude-opus-4-7" when you want richer prose (both require
  // paid gateway credits).
  chat: "anthropic/claude-haiku-4-5" as const,
  // Embeddings — OpenAI text-embedding-3-small (1536-dim, cheap, fast).
  embedding: "openai/text-embedding-3-small" as const,
} as const;

export const EMBEDDING_DIM = 1536;

export const TUTOR_SYSTEM_PROMPT = `You are an Arduino electronics tutor for a learner with a web-development background.
Ground answers in the provided CONTEXT when it's relevant. Cite sources inline using [n] markers that match the context indices.
If the CONTEXT is thin for the question, say so plainly then give your best general answer.
Prefer developer analogies (debouncing is like JS debounce, pull-up/pull-down is like CSS defaults, etc.).
When circuits misbehave, reach for Ohm's law as a diagnostic tool — work backwards from the measured values to find the real component values.`;
