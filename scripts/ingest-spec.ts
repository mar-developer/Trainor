// scripts/ingest-spec.ts — primary corpus: arduino_trainer_spec.md
import { config as loadEnv } from "dotenv";
import { readFile } from "node:fs/promises";
import { resolve } from "node:path";
loadEnv({ path: ".env.local" });
loadEnv({ path: ".env", override: false });

import { chunkMarkdown } from "../lib/rag/chunk";
import { ingestDocument } from "../lib/rag/ingest";

const SPEC_PATH = resolve(process.cwd(), "../docs/arduino_trainer_spec.md");
// User-facing label for citations — the raw filename is an implementation
// detail the learner doesn't need to see.
const TITLE = "Arduino Curriculum Guide";

async function main() {
  console.log(`Reading ${SPEC_PATH}`);
  const md = await readFile(SPEC_PATH, "utf8");

  const chunks = chunkMarkdown(md, TITLE);
  console.log(`Chunked into ${chunks.length} pieces`);

  const result = await ingestDocument({
    source: "spec",
    title: TITLE,
    raw: md,
    chunks,
  });

  if (result.skipped) {
    console.log("✓ checksum match — nothing to do");
  } else {
    console.log(`✓ ingested ${result.chunkCount} chunks for ${TITLE}`);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
