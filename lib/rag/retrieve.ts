import { embed } from "ai";
import { createClient as createServiceClient } from "@supabase/supabase-js";
import { AI_MODELS } from "@/lib/ai/gateway";

export interface RetrievedChunk {
  chunkId: string;
  source: "spec" | "arduino_docs" | "datasheet" | "obsidian" | "tutorial";
  title: string;
  url: string | null;
  headingPath: string | null;
  content: string;
  similarity: number;
}

// Retrieval is read-only against public tables — safe with the anon key.
// We use a service client when NEXT_PUBLIC_SUPABASE_URL isn't set (build /
// script contexts), but normally server code creates its own client.
function supabase() {
  return createServiceClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY ??
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    { auth: { persistSession: false } },
  );
}

export async function retrieveChunks(
  query: string,
  topK = 6,
): Promise<RetrievedChunk[]> {
  const { embedding } = await embed({
    model: AI_MODELS.embedding,
    value: query,
  });

  const { data, error } = await supabase().rpc("match_chunks", {
    query_embedding: embedding,
    match_count: topK,
  });
  if (error) throw error;

  return (data ?? []).map((row: Record<string, unknown>) => ({
    chunkId: row.chunk_id as string,
    source: row.source as RetrievedChunk["source"],
    title: row.title as string,
    url: (row.url as string) ?? null,
    headingPath: (row.heading_path as string) ?? null,
    content: row.content as string,
    similarity: row.similarity as number,
  }));
}

export function formatContext(chunks: RetrievedChunk[]): string {
  if (!chunks.length) return "(no relevant context found)";
  return chunks
    .map((c, i) => {
      const path = c.headingPath ?? c.title;
      return `[${i + 1}] ${c.title} › ${path}\n${c.content}`;
    })
    .join("\n\n---\n\n");
}

export function citationsFromChunks(chunks: RetrievedChunk[]) {
  return chunks.map((c, i) => {
    // Strip the document title from the heading path — the UI shows the
    // title separately as the source label, so repeating it is noise.
    let heading = c.headingPath ?? "";
    const prefix = `${c.title} › `;
    if (heading.startsWith(prefix)) heading = heading.slice(prefix.length);
    if (heading === c.title) heading = "";
    return {
      index: i + 1,
      source: c.title,
      heading, // "" when the chunk is the document root — let the UI degrade
      chunkId: c.chunkId,
      url: c.url,
    };
  });
}
