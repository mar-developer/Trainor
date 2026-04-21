import Link from "next/link";
import { ArrowRight, FlaskConical, Sparkles } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { PhaseRoadmap } from "@/components/phase-roadmap";
import { ComponentExplorer } from "@/components/component-explorer";
import { ModuleCard } from "@/components/module-card";
import { ChatCompanion } from "@/components/chat-companion";
import {
  getComponents,
  getExperiments,
  getModuleProgressSummary,
  getPhaseOneModules,
} from "@/lib/data/repo";
import { isLessonComplete } from "@/lib/progress";

export default async function DashboardPage() {
  const [modules, components, experiments] = await Promise.all([
    getPhaseOneModules(),
    getComponents(),
    getExperiments(),
  ]);

  // Apply rule-b: if the seeded "in_progress" module is actually complete
  // by current progress, advance to the next not-yet-complete module.
  const seeded =
    modules.find((m) => m.status === "in-progress") ?? modules[0];
  const seededProgress = await getModuleProgressSummary(seeded.slug);
  const seededComplete =
    seededProgress.totalSteps > 0 && isLessonComplete(seededProgress);

  const current = seededComplete
    ? (modules.slice(modules.indexOf(seeded) + 1).find(
        (m) => m.status !== "complete",
      ) ?? seeded)
    : seeded;

  const completedInPhase =
    modules.filter((m) => m.status === "complete").length +
    (seededComplete ? 1 : 0);

  return (
    <div className="relative flex-1">
      <Header />

      <div className="mx-auto w-full max-w-6xl space-y-8 px-4 py-6 sm:px-6">
        {/* Hero / continue */}
        <section className="rounded-2xl border bg-gradient-to-br from-primary/10 via-background to-info/10 p-6 sm:p-8">
          <div className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
            <div className="space-y-2">
              <p className="inline-flex items-center gap-2 text-xs uppercase tracking-wide text-muted-foreground">
                <Sparkles className="size-3.5 text-info" /> Continue where you
                left off
              </p>
              <h1 className="text-2xl font-semibold sm:text-3xl">
                Module {current.number} · {current.title}
              </h1>
              <p className="max-w-xl text-sm text-muted-foreground">
                {current.summary}
              </p>
            </div>
            <Link
              href={`/modules/${current.slug}`}
              className={cn(
                buttonVariants({ size: "lg" }),
                "gap-2",
              )}
            >
              Resume module
              <ArrowRight className="size-4" />
            </Link>
          </div>
        </section>

        {/* Phase roadmap */}
        <PhaseRoadmap
          currentModule={`${current.number} · ${current.title}`}
          completedInPhase={completedInPhase}
          totalInPhase={modules.length}
        />

        {/* Component explorer */}
        <section>
          <ComponentExplorer components={components} />
        </section>

        {/* Modules list + experiments side by side */}
        <div className="grid gap-6 lg:grid-cols-[1fr_20rem]">
          <section className="space-y-4">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-semibold">Phase 1 modules</h2>
              <Link
                href="/modules/core-components"
                className={buttonVariants({ variant: "ghost", size: "sm" })}
              >
                View curriculum <ArrowRight className="size-3.5" />
              </Link>
            </div>
            <div className="grid gap-3 sm:grid-cols-2">
              {modules.map((m) => (
                <ModuleCard key={m.slug} module={m} />
              ))}
            </div>
          </section>

          <section className="space-y-4">
            <div className="flex items-center justify-between">
              <h2 className="inline-flex items-center gap-2 text-lg font-semibold">
                <FlaskConical className="size-4 text-sensor" /> Your experiments
              </h2>
              <Link
                href="/experiments"
                className={buttonVariants({ variant: "ghost", size: "sm" })}
              >
                All <ArrowRight className="size-3.5" />
              </Link>
            </div>
            <ol className="space-y-3">
              {experiments.map((e) => (
                <li
                  key={e.id}
                  className="rounded-xl border bg-card p-3 text-sm"
                >
                  <div className="flex items-center justify-between">
                    <p className="font-medium">{e.title}</p>
                    <time className="text-xs text-muted-foreground">
                      {e.createdAt}
                    </time>
                  </div>
                  <p className="mt-1 text-xs text-muted-foreground">
                    {e.observation}
                  </p>
                </li>
              ))}
            </ol>
          </section>
        </div>
      </div>

      <ChatCompanion />
    </div>
  );
}

function Header() {
  return (
    <header className="sticky top-0 z-10 flex h-16 items-center justify-between border-b bg-background/80 px-4 backdrop-blur sm:px-6">
      <div>
        <p className="text-xs uppercase tracking-wide text-muted-foreground">
          Dashboard
        </p>
        <h1 className="text-sm font-semibold">
          Hey Reymar — 7 of 13 components down.
        </h1>
      </div>
      <Link
        href="/chat"
        className={buttonVariants({ variant: "outline", size: "sm" })}
      >
        Open tutor chat
      </Link>
    </header>
  );
}
