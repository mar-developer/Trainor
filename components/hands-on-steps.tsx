"use client";

import { useOptimistic, useState, useTransition } from "react";
import { Check, CircleDot, CircleDashed, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import type { HandsOnStep } from "@/lib/data/mock";
import { saveStepReport, toggleStepComplete } from "@/app/actions/progress";

export function HandsOnSteps({
  steps,
  lessonId,
  moduleSlug,
}: {
  steps: HandsOnStep[];
  lessonId?: string;
  moduleSlug: string;
}) {
  // Persistence requires both a lesson UUID (from the DB) and a step UUID.
  // When either is missing (mock-only fallback), fall back to local-only state.
  const canPersist = Boolean(lessonId);

  const initialDone = new Set(
    steps.filter((s) => s.completedAt).map((s) => s.order),
  );
  const [localDone, setLocalDone] = useState<Set<number>>(initialDone);
  const [optimisticDone, applyOptimistic] = useOptimistic(
    localDone,
    (prev, change: { order: number; done: boolean }) => {
      const next = new Set(prev);
      change.done ? next.add(change.order) : next.delete(change.order);
      return next;
    },
  );

  const initialReports = Object.fromEntries(
    steps.map((s) => [s.order, s.selfReport ?? ""]),
  );
  const [reports, setReports] = useState<Record<number, string>>(initialReports);
  const [pending, startTransition] = useTransition();

  const toggle = (step: HandsOnStep) => {
    const nextDone = !optimisticDone.has(step.order);
    applyOptimistic({ order: step.order, done: nextDone });

    if (!canPersist || !step.id || !lessonId) {
      // Mock mode — local only.
      setLocalDone((prev) => {
        const next = new Set(prev);
        nextDone ? next.add(step.order) : next.delete(step.order);
        return next;
      });
      return;
    }

    startTransition(async () => {
      try {
        await toggleStepComplete({
          lessonId,
          stepId: step.id!,
          moduleSlug,
          done: nextDone,
        });
        setLocalDone((prev) => {
          const next = new Set(prev);
          nextDone ? next.add(step.order) : next.delete(step.order);
          return next;
        });
      } catch (err) {
        console.error(err);
        toast.error("Could not save — check the dev server logs.");
      }
    });
  };

  const submitReport = (step: HandsOnStep) => {
    const value = reports[step.order]?.trim();
    if (!value) {
      toast.error("Please paste what you measured before submitting.");
      return;
    }

    if (!canPersist || !step.id || !lessonId) {
      toast.success("Saved locally. (Enable Supabase to persist.)");
      applyOptimistic({ order: step.order, done: true });
      setLocalDone((prev) => new Set(prev).add(step.order));
      return;
    }

    startTransition(async () => {
      try {
        await saveStepReport({
          lessonId,
          stepId: step.id!,
          moduleSlug,
          text: value,
        });
        setLocalDone((prev) => new Set(prev).add(step.order));
        toast.success("Measurement logged. Nice work.");
      } catch (err) {
        console.error(err);
        toast.error("Could not save your reading.");
      }
    });
  };

  return (
    <ol className="space-y-3">
      {steps.map((step) => {
        const isDone = optimisticDone.has(step.order);
        return (
          <li
            key={step.order}
            className={cn(
              "rounded-xl border bg-card p-4 transition",
              isDone && "bg-muted/50",
            )}
          >
            <div className="flex items-start gap-3">
              <button
                type="button"
                onClick={() => toggle(step)}
                disabled={pending}
                className={cn(
                  "mt-0.5 flex size-6 shrink-0 items-center justify-center rounded-full border transition",
                  isDone
                    ? "border-foreground bg-foreground text-background"
                    : "border-border text-muted-foreground hover:text-foreground",
                  pending && "opacity-70",
                )}
                aria-label={isDone ? "Mark incomplete" : "Mark complete"}
              >
                {pending ? (
                  <Loader2 className="size-3.5 animate-spin" />
                ) : isDone ? (
                  <Check className="size-3.5" />
                ) : (
                  <CircleDashed className="size-3.5" />
                )}
              </button>

              <div className="flex-1 space-y-3">
                <div className="flex items-baseline gap-2">
                  <span className="font-mono text-xs text-muted-foreground">
                    Step {step.order}
                  </span>
                </div>
                <p className="text-sm leading-relaxed">{step.instruction}</p>

                {step.expected && (
                  <div className="flex items-start gap-2 rounded-md bg-muted/60 px-3 py-2 text-xs">
                    <CircleDot className="mt-0.5 size-3.5 shrink-0 text-sensor" />
                    <span>
                      <span className="font-medium">Expected:</span>{" "}
                      {step.expected}
                    </span>
                  </div>
                )}

                <div className="space-y-2">
                  <Label
                    htmlFor={`report-${step.order}`}
                    className="text-xs text-muted-foreground"
                  >
                    What did you measure?
                  </Label>
                  <Textarea
                    id={`report-${step.order}`}
                    placeholder="e.g. Current: 10.8 mA at 5.05 V supply, 218 Ω resistor, 2.76 V across red LED"
                    value={reports[step.order] ?? ""}
                    onChange={(e) =>
                      setReports((r) => ({
                        ...r,
                        [step.order]: e.target.value,
                      }))
                    }
                    rows={2}
                  />
                  <Button
                    size="sm"
                    onClick={() => submitReport(step)}
                    variant={isDone ? "outline" : "default"}
                    disabled={pending}
                  >
                    {isDone ? "Update reading" : "Log reading"}
                  </Button>
                </div>
              </div>
            </div>
          </li>
        );
      })}
    </ol>
  );
}
