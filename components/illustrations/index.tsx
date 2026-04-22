import { WaterPipeIllustration } from "./water-pipe";
import { OhmsTriangle } from "./ohms-triangle";
import { LedCircuit } from "./led-circuit";
import { BreadboardLayout } from "./breadboard-layout";
import { SeriesVsParallel } from "./series-vs-parallel";
import { MultimeterDial } from "./multimeter-dial";
import { SetupLoopLifecycle } from "./setup-loop-lifecycle";
import { LogicLevels } from "./logic-levels";
import { DebounceIllustration } from "./debounce";
import { VoltageDivider } from "./voltage-divider";
import { AnalogVsDigital } from "./analog-vs-digital";
import { ProjectFlow } from "./project-flow";
import { IotArchitecture } from "./iot-architecture";

const REGISTRY: Record<string, () => React.ReactElement> = {
  "water-pipe": WaterPipeIllustration,
  "ohms-triangle": OhmsTriangle,
  "led-circuit": LedCircuit,
  "breadboard-layout": BreadboardLayout,
  "series-vs-parallel": SeriesVsParallel,
  "multimeter-dial": MultimeterDial,
  "setup-loop": SetupLoopLifecycle,
  "logic-levels": LogicLevels,
  "debounce": DebounceIllustration,
  "voltage-divider": VoltageDivider,
  "analog-vs-digital": AnalogVsDigital,
  "project-flow": ProjectFlow,
  "iot-architecture": IotArchitecture,
};

export function Illustration({ id }: { id: string }) {
  const Draw = REGISTRY[id];
  if (!Draw) {
    return (
      <div className="rounded-lg border border-dashed bg-muted/40 p-4 text-xs text-muted-foreground">
        (missing illustration: <code className="font-mono">{id}</code>)
      </div>
    );
  }
  return (
    <figure className="my-4 overflow-hidden rounded-xl border bg-background/60 p-4">
      <Draw />
    </figure>
  );
}

/**
 * Split lesson markdown on `<!-- ill:NAME -->` markers, yielding segments
 * where each one is either plain markdown (string) or an illustration id.
 */
export function splitLessonBody(md: string): Array<
  | { kind: "md"; text: string }
  | { kind: "ill"; id: string }
> {
  const out: ReturnType<typeof splitLessonBody> = [];
  const pattern = /<!--\s*ill:([a-z0-9-]+)\s*-->/gi;
  const matches = Array.from(md.matchAll(pattern));
  let cursor = 0;
  for (const m of matches) {
    const start = m.index ?? 0;
    if (start > cursor) {
      out.push({ kind: "md", text: md.slice(cursor, start) });
    }
    out.push({ kind: "ill", id: m[1] });
    cursor = start + m[0].length;
  }
  if (cursor < md.length) {
    out.push({ kind: "md", text: md.slice(cursor) });
  }
  return out;
}

export const ILLUSTRATION_IDS = Object.keys(REGISTRY);
