// scripts/ingest-lessons.ts — pulls every lesson body from Postgres and
// indexes it for RAG. Each lesson becomes its own document titled "Module
// X.Y — Title" so citations are human-readable out of the box.
//
// Run: npm run ingest:lessons
import { config as loadEnv } from "dotenv";
loadEnv({ path: ".env.local" });
loadEnv({ path: ".env", override: false });

import { chunkMarkdown } from "../lib/rag/chunk";
import { ingestDocument, supabaseFromEnv } from "../lib/rag/ingest";

async function main() {
  const supabase = supabaseFromEnv();

  // Pull every lesson joined up to its module + course so we can build
  // friendly document titles.
  const { data, error } = await supabase
    .from("lessons")
    .select(
      `
        id,
        title,
        body_md,
        modules!inner (
          number,
          title,
          phases!inner (
            courses!inner ( slug, title )
          )
        )
      `,
    );
  if (error) throw error;
  // PostgREST returns a single object for each many-to-one embed (lesson →
  // module → phase → course), but the generated types widen to-one embeds to
  // arrays. Cast through `unknown` to assert the real runtime shape.
  const rows = (data ?? []) as unknown as Array<{
    id: string;
    title: string;
    body_md: string | null;
    modules: {
      number: string;
      title: string;
      phases: { courses: { slug: string; title: string } };
    };
  }>;

  console.log(`Found ${rows.length} lessons to ingest.`);

  let ok = 0;
  let skipped = 0;
  let empty = 0;
  let failed = 0;

  for (const row of rows) {
    const body = (row.body_md ?? "").trim();
    if (!body) {
      empty++;
      continue;
    }

    const module = row.modules;
    const course = module.phases.courses;
    const title = `${module.number} · ${module.title}`;

    const chunks = chunkMarkdown(body, title);
    if (!chunks.length) {
      empty++;
      continue;
    }

    try {
      const result = await retryOnRateLimit(() =>
        ingestDocument(supabase, {
          source: "spec",
          title,
          // Use lesson id in the URL so each lesson is a unique document in
          // the checksum-dedup table (independent from the legacy spec file).
          url: `lesson://${course.slug}/${row.id}`,
          raw: body,
          chunks,
        }),
      );
      if (result.skipped) {
        skipped++;
        console.log(`  = ${title} (unchanged)`);
      } else {
        ok++;
        console.log(`  ✓ ${title} · ${result.chunkCount} chunks`);
      }
    } catch (err) {
      failed++;
      const msg = err instanceof Error ? err.message : String(err);
      console.error(`  × ${title}: ${msg.split("\n")[0]}`);
    }

    // Pace requests so free-tier rate limits don't saturate.
    await sleep(400);
  }

  console.log(
    `\nDone. ${ok} ingested, ${skipped} unchanged, ${empty} empty, ${failed} failed.`,
  );
  if (failed > 0) {
    console.log(
      "Tip: re-run `npm run ingest:lessons` to retry failures " +
        "(successful lessons are checksum-gated, won't re-embed).",
    );
  }
}

function sleep(ms: number) {
  return new Promise((r) => setTimeout(r, ms));
}

/**
 * Wraps a network call with explicit back-off when the gateway returns a
 * 429. The AI SDK already retries transparently; we sit on top of that so
 * long stalls (free-tier throttles) don't kill the whole corpus run.
 */
async function retryOnRateLimit<T>(
  fn: () => Promise<T>,
  attempts = 3,
  baseDelayMs = 45_000,
): Promise<T> {
  for (let i = 0; i < attempts; i++) {
    try {
      return await fn();
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      const isRateLimit = /rate[_ ]limit|429/i.test(msg);
      if (!isRateLimit || i === attempts - 1) throw err;
      const wait = baseDelayMs * (i + 1);
      console.log(
        `  ⏳ rate-limited — waiting ${wait / 1000}s before retry ${i + 1}/${attempts - 1}…`,
      );
      await sleep(wait);
    }
  }
  throw new Error("unreachable");
}

function titleToSlug(s: string) {
  return s
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
