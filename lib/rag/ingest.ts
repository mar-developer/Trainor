// Shared ingestion helper. Handles document checksum dedupe, batched
// embedding, and upsert of chunks + vectors. Called by per-source scripts
// (ingest-spec, ingest-arduino-docs, ingest-datasheets).

import { createHash } from "node:crypto";
import { embedMany } from "ai";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { AI_MODELS } from "@/lib/ai/gateway";
import type { Chunk } from "@/lib/rag/chunk";

export type IngestSource =
  | "spec"
  | "arduino_docs"
  | "datasheet"
  | "obsidian"
  | "tutorial";

export interface IngestInput {
  source: IngestSource;
  title: string;
  url?: string;
  /** Raw content used to compute a checksum for incremental dedupe. */
  raw: string;
  chunks: Chunk[];
}

export function supabaseFromEnv(): SupabaseClient {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !serviceKey) {
    throw new Error(
      "Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env.local",
    );
  }
  return createClient(url, serviceKey, { auth: { persistSession: false } });
}

export async function ingestDocument(
  supabase: SupabaseClient,
  input: IngestInput,
): Promise<{ skipped: boolean; chunkCount: number }> {
  const checksum = createHash("sha256").update(input.raw).digest("hex");

  // Dedupe key = (source, url) with a fallback of (source, title).
  const query = supabase.from("documents").select("id, checksum").eq("source", input.source);
  const { data: existing } = input.url
    ? await query.eq("url", input.url).maybeSingle()
    : await query.eq("title", input.title).maybeSingle();

  if (existing?.checksum === checksum) {
    return { skipped: true, chunkCount: 0 };
  }

  // Embed in batches.
  const BATCH = 64;
  const allEmbeddings: number[][] = [];
  for (let i = 0; i < input.chunks.length; i += BATCH) {
    const batch = input.chunks.slice(i, i + BATCH);
    const { embeddings } = await embedMany({
      model: AI_MODELS.embedding,
      values: batch.map((c) => c.content),
    });
    allEmbeddings.push(...embeddings);
  }

  let documentId: string;
  if (existing) {
    const { error } = await supabase
      .from("documents")
      .update({ checksum, ingested_at: new Date().toISOString() })
      .eq("id", existing.id);
    if (error) throw error;
    documentId = existing.id;
    await supabase.from("chunks").delete().eq("document_id", documentId);
  } else {
    const { data, error } = await supabase
      .from("documents")
      .insert({
        source: input.source,
        title: input.title,
        url: input.url ?? null,
        checksum,
      })
      .select("id")
      .single();
    if (error) throw error;
    documentId = data.id;
  }

  const chunkRows = input.chunks.map((c) => ({
    document_id: documentId,
    content: c.content,
    token_count: c.tokenCount,
    heading_path: c.headingPath,
  }));

  const { data: insertedChunks, error: chunkErr } = await supabase
    .from("chunks")
    .insert(chunkRows)
    .select("id");
  if (chunkErr) throw chunkErr;

  const embedRows = insertedChunks!.map((c, i) => ({
    chunk_id: c.id,
    embedding: allEmbeddings[i],
  }));
  const { error: embedErr } = await supabase
    .from("embeddings")
    .insert(embedRows);
  if (embedErr) throw embedErr;

  return { skipped: false, chunkCount: input.chunks.length };
}
