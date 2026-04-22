"use client";

import Link from "next/link";
import { useState } from "react";
import {
  Check,
  ChevronDown,
  Circle,
  Dot,
  Lock,
  Sparkles,
} from "lucide-react";
import { cn } from "@/lib/utils";
import type { CurriculumPhase } from "@/lib/data/repo";

export function CurriculumOutline({ phases }: { phases: CurriculumPhase[] }) {
  // Default: the first non-locked phase open, everything else collapsed.
  const firstOpen =
    phases.find((p) => !p.locked)?.id ?? phases[0]?.id ?? null;
  const [openIds, setOpenIds] = useState<Set<string>>(
    new Set(firstOpen ? [firstOpen] : []),
  );

  const toggle = (id: string) => {
    setOpenIds((prev) => {
      const next = new Set(prev);
      next.has(id) ? next.delete(id) : next.add(id);
      return next;
    });
  };

  if (!phases.length) {
    return (
      <div className="rounded-xl border border-dashed bg-card p-6 text-sm text-muted-foreground">
        Curriculum outline will appear here once phases are seeded.
      </div>
    );
  }

  return (
    <section className="space-y-3">
      <div className="flex items-baseline justify-between">
        <h2 className="text-lg font-semibold">Curriculum</h2>
        <p className="text-xs text-muted-foreground">
          Every phase, every module — the full master plan.
        </p>
      </div>

      <div className="divide-y overflow-hidden rounded-xl border bg-card">
        {phases.map((phase) => {
          const open = openIds.has(phase.id);
          return (
            <div key={phase.id}>
              <button
                type="button"
                onClick={() => !phase.locked && toggle(phase.id)}
                disabled={phase.locked}
                className={cn(
                  "flex w-full items-center gap-3 px-4 py-3 text-left transition",
                  phase.locked
                    ? "cursor-not-allowed opacity-60"
                    : "hover:bg-muted/50",
                )}
                aria-expanded={open}
              >
                <span
                  className={cn(
                    "flex size-7 shrink-0 items-center justify-center rounded-full text-xs font-semibold",
                    phase.locked
                      ? "bg-muted text-muted-foreground"
                      : phase.completeCount === phase.moduleCount &&
                          phase.moduleCount > 0
                        ? "bg-sensor text-white"
                        : "bg-primary/10 text-primary",
                  )}
                >
                  {phase.locked ? (
                    <Lock className="size-3.5" />
                  ) : phase.completeCount === phase.moduleCount &&
                    phase.moduleCount > 0 ? (
                    <Check className="size-4" />
                  ) : (
                    phase.order
                  )}
                </span>
                <div className="flex-1 min-w-0">
                  <p className="text-xs uppercase tracking-wide text-muted-foreground">
                    Phase {phase.order}
                  </p>
                  <h3 className="truncate font-semibold">{phase.title}</h3>
                </div>
                <div className="flex items-center gap-3 text-xs text-muted-foreground">
                  {phase.locked ? (
                    <span>locked</span>
                  ) : (
                    <span className="font-mono tabular-nums">
                      {phase.completeCount}/{phase.moduleCount}
                    </span>
                  )}
                  {!phase.locked && (
                    <ChevronDown
                      className={cn(
                        "size-4 transition-transform",
                        open && "rotate-180",
                      )}
                    />
                  )}
                </div>
              </button>

              {open && !phase.locked && (
                <ol className="divide-y bg-background/40">
                  {phase.modules.map((m) => (
                    <ModuleRow key={m.slug} module={m} />
                  ))}
                </ol>
              )}
            </div>
          );
        })}
      </div>
    </section>
  );
}

function ModuleRow({
  module,
}: {
  module: CurriculumPhase["modules"][number];
}) {
  const hasProgress = module.totalSteps > 0 && !module.complete;

  return (
    <li>
      <Link
        href={`/modules/${module.slug}`}
        className="flex items-start gap-3 px-4 py-3 transition hover:bg-muted/40"
      >
        <StatusGlyph module={module} />
        <div className="flex-1 min-w-0 space-y-1">
          <div className="flex items-center gap-2">
            <span className="font-mono text-xs text-muted-foreground">
              {module.number}
            </span>
            <h4
              className={cn(
                "truncate text-sm font-medium",
                module.complete && "text-muted-foreground",
              )}
            >
              {module.title}
            </h4>
          </div>
          {module.lessonTitles.length > 0 && (
            <ul className="space-y-0.5 pl-1 text-xs text-muted-foreground">
              {module.lessonTitles.map((t, i) => (
                <li key={i} className="flex items-center gap-1.5">
                  <Dot className="size-3.5 shrink-0" />
                  <span className="truncate">{t}</span>
                </li>
              ))}
            </ul>
          )}
        </div>
        <div className="flex shrink-0 items-center gap-2 pt-0.5 text-xs text-muted-foreground">
          {hasProgress && (
            <span className="font-mono tabular-nums">
              {module.completedSteps}/{module.totalSteps}
            </span>
          )}
          <span>~{module.estimatedMinutes}m</span>
        </div>
      </Link>
    </li>
  );
}

function StatusGlyph({
  module,
}: {
  module: CurriculumPhase["modules"][number];
}) {
  if (module.complete) {
    return (
      <span className="mt-0.5 flex size-5 items-center justify-center rounded-full bg-sensor text-white">
        <Check className="size-3" />
      </span>
    );
  }
  if (module.status === "in-progress" || module.completedSteps > 0) {
    return (
      <span className="mt-0.5 flex size-5 items-center justify-center rounded-full bg-primary/15 text-primary">
        <Sparkles className="size-3" />
      </span>
    );
  }
  if (module.status === "preview") {
    return (
      <span className="mt-0.5 flex size-5 items-center justify-center rounded-full bg-info/15 text-info">
        <Circle className="size-3" />
      </span>
    );
  }
  return (
    <span className="mt-0.5 flex size-5 items-center justify-center rounded-full border border-dashed border-muted-foreground/40 text-muted-foreground">
      <Circle className="size-3" />
    </span>
  );
}
