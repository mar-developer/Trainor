import { Check, Lock } from "lucide-react";
import { cn } from "@/lib/utils";
import { PHASES } from "@/lib/data/mock";

export function PhaseRoadmap({
  currentModule,
  completedInPhase,
  totalInPhase,
}: {
  currentModule: string;
  completedInPhase: number;
  totalInPhase: number;
}) {
  const activeIdx = PHASES.findIndex((p) => p.status === "in-progress");
  const pct = Math.round((completedInPhase / totalInPhase) * 100);

  return (
    <div className="rounded-xl border bg-card p-5">
      <div className="flex flex-col gap-1 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-xs uppercase tracking-wide text-muted-foreground">
            Learning path
          </p>
          <h2 className="text-xl font-semibold">
            Phase 1 · Foundations ({completedInPhase}/{totalInPhase})
          </h2>
          <p className="text-sm text-muted-foreground">
            Currently on{" "}
            <span className="font-medium text-foreground">{currentModule}</span>
          </p>
        </div>
        <div className="flex items-center gap-2 text-sm">
          <span className="font-mono tabular-nums">{pct}%</span>
          <div className="h-2 w-40 overflow-hidden rounded-full bg-muted">
            <div
              className="h-full rounded-full bg-primary transition-all"
              style={{ width: `${pct}%` }}
            />
          </div>
        </div>
      </div>

      <div className="mt-5 grid gap-3 sm:grid-cols-4">
        {PHASES.map((p, idx) => {
          const complete = idx < activeIdx;
          const active = idx === activeIdx;
          const locked = p.status === "locked";
          return (
            <div
              key={p.number}
              className={cn(
                "flex items-center gap-3 rounded-lg border p-3 text-sm",
                active && "border-primary bg-primary/5",
                complete && "bg-muted/60",
                locked && "opacity-60",
              )}
            >
              <div
                className={cn(
                  "flex size-8 shrink-0 items-center justify-center rounded-full border text-xs font-semibold",
                  complete && "bg-foreground text-background border-foreground",
                  active && "bg-primary text-primary-foreground border-primary",
                  locked && "bg-muted text-muted-foreground",
                )}
              >
                {complete ? (
                  <Check className="size-4" />
                ) : locked ? (
                  <Lock className="size-3.5" />
                ) : (
                  p.number
                )}
              </div>
              <div className="min-w-0 flex-1">
                <p className="truncate font-medium">{p.title}</p>
                <p className="text-xs text-muted-foreground">
                  {p.status === "in-progress"
                    ? "in progress"
                    : p.status === "locked"
                      ? "locked"
                      : "done"}
                </p>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
