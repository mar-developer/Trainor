// scripts/ingest-arduino-docs.ts — fetches raw AsciiDoc from the
// arduino/reference-en GitHub repo, normalizes it to plain markdown-ish
// text, chunks, and upserts.
//
// Why GitHub not docs.arduino.cc: the live docs site is 100% client-side
// rendered, so `fetch` returns an empty shell. The AsciiDoc source is the
// single source of truth and fetches cleanly.
//
// Add entries to ARDUINO_URLS to expand coverage. Each URL is ingested as
// its own document (checksum-gated re-runs stay cheap).
//
// Run: npm run ingest:arduino-docs

import { config as loadEnv } from "dotenv";
loadEnv({ path: ".env.local" });
loadEnv({ path: ".env", override: false });

import { chunkMarkdown } from "../lib/rag/chunk";
import { ingestDocument } from "../lib/rag/ingest";

const GH = "https://raw.githubusercontent.com/arduino/reference-en/master";

const ARDUINO_URLS: Array<{ path: string; title: string }> = [
  // Language — functions
  { path: "Language/Functions/Digital IO/digitalWrite.adoc",          title: "Arduino Reference — digitalWrite()" },
  { path: "Language/Functions/Digital IO/digitalRead.adoc",           title: "Arduino Reference — digitalRead()" },
  { path: "Language/Functions/Digital IO/pinMode.adoc",               title: "Arduino Reference — pinMode()" },
  { path: "Language/Functions/Analog IO/analogRead.adoc",             title: "Arduino Reference — analogRead()" },
  { path: "Language/Functions/Analog IO/analogWrite.adoc",            title: "Arduino Reference — analogWrite()" },
  { path: "Language/Functions/Advanced IO/tone.adoc",                 title: "Arduino Reference — tone()" },
  { path: "Language/Functions/Advanced IO/noTone.adoc",               title: "Arduino Reference — noTone()" },
  { path: "Language/Functions/Time/millis.adoc",                      title: "Arduino Reference — millis()" },
  { path: "Language/Functions/Time/delay.adoc",                       title: "Arduino Reference — delay()" },
  { path: "Language/Functions/Time/micros.adoc",                      title: "Arduino Reference — micros()" },
  { path: "Language/Functions/Math/map.adoc",                         title: "Arduino Reference — map()" },
  { path: "Language/Functions/Math/constrain.adoc",                   title: "Arduino Reference — constrain()" },
  { path: "Language/Functions/Communication/Serial.adoc",             title: "Arduino Reference — Serial" },
  { path: "Language/Functions/Communication/Serial/begin.adoc",       title: "Arduino Reference — Serial.begin()" },
  { path: "Language/Functions/Communication/Serial/println.adoc",     title: "Arduino Reference — Serial.println()" },
  { path: "Language/Functions/External Interrupts/attachInterrupt.adoc", title: "Arduino Reference — attachInterrupt()" },
  // Variables
  { path: "Language/Variables/Constants/HIGH.adoc",                   title: "Arduino Reference — HIGH / LOW" },
  { path: "Language/Variables/Constants/INPUT_PULLUP.adoc",           title: "Arduino Reference — INPUT_PULLUP" },
  // Structure
  { path: "Language/Structure/Sketch/setup.adoc",                     title: "Arduino Reference — setup()" },
  { path: "Language/Structure/Sketch/loop.adoc",                      title: "Arduino Reference — loop()" },
];

/**
 * Turn raw AsciiDoc into flat text the chunker can handle. We don't need a
 * full AsciiDoc parser — just strip the markers that aren't content.
 */
function adocToPlain(adoc: string): string {
  return (
    adoc
      // YAML frontmatter at top (--- ... ---)
      .replace(/^---\n[\s\S]*?\n---\n/m, "")
      // line comments (// …)
      .replace(/^\/\/.*$/gm, "")
      // attribute-definition lines (:name: value)
      .replace(/^:[a-zA-Z0-9_-]+:.*$/gm, "")
      // block attribute lines ([#id], [.role], [float], [%hardbreaks])
      .replace(/^\[(?:[#.]?[a-zA-Z0-9_%. -]+)\]$/gm, "")
      // open/close block markers (-- on its own line)
      .replace(/^--\s*$/gm, "")
      // inline [%hardbreaks] annotations
      .replace(/\[%hardbreaks\]/g, "")
      // link macros: http://example.com[display text^] → display text (http://example.com)
      .replace(/https?:\/\/[^\[\]\s]+\[([^\]]+?)\^?\]/g, "$1")
      // cross-reference macros: <<something,display>> → display
      .replace(/<<[^,>]+,([^>]+)>>/g, "$1")
      // collapse 3+ blank lines to 2
      .replace(/\n{3,}/g, "\n\n")
      .trim()
  );
}

async function main() {
  let ok = 0;
  let skipped = 0;
  let failed = 0;

  for (const { path, title } of ARDUINO_URLS) {
    const url = `${GH}/${path.replace(/ /g, "%20")}`;
    try {
      console.log(`→ ${title}`);
      const res = await fetch(url, {
        headers: { "user-agent": "trainor-ingester/1.0" },
      });
      if (!res.ok) {
        console.warn(`   skip: HTTP ${res.status}`);
        failed++;
        continue;
      }
      const adoc = await res.text();
      const text = adocToPlain(adoc);

      const chunks = chunkMarkdown(text, title);
      if (!chunks.length) {
        console.warn("   skip: no chunks produced after normalization");
        failed++;
        continue;
      }

      const result = await ingestDocument({
        source: "arduino_docs",
        title,
        url: `arduino-docs://${path}`,
        raw: text,
        chunks,
      });

      if (result.skipped) {
        skipped++;
        console.log("   = unchanged");
      } else {
        ok++;
        console.log(`   ✓ ${result.chunkCount} chunks`);
      }
    } catch (err) {
      failed++;
      console.error("   error:", err);
    }

    // Pace to stay friendly to both GitHub and the embedding gateway.
    await new Promise((r) => setTimeout(r, 300));
  }

  console.log(`\nDone. ${ok} ingested, ${skipped} unchanged, ${failed} failed.`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
