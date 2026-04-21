import Link from "next/link";
import { ArrowRight, BookOpen, Code2, FlaskConical, Wrench } from "lucide-react";
import { cn } from "@/lib/utils";
import type { Module } from "@/lib/data/mock";

const KIND_META: Record<
  Module["kind"],
  { icon: typeof BookOpen; label: string }
> = {
  theory: { icon: BookOpen, label: "Theory" },
  handson: { icon: Wrench, label: "Hands-on" },
  code: { icon: Code2, label: "Code" },
  project: { icon: FlaskConical, label: "Project" },
};

const STATUS_META: Record<
  Module["status"],
  { dot: string; label: string; className: string }
> = {
  complete: {
    dot: "bg-sensor",
    label: "Complete",
    className: "opacity-80",
  },
  "in-progress": {
    dot: "bg-primary",
    label: "In progress",
    className: "ring-2 ring-primary ring-offset-2 ring-offset-background",
  },
  preview: {
    dot: "bg-info",
    label: "Preview",
    className: "",
  },
  "not-started": {
    dot: "bg-muted-foreground/40",
    label: "Not started",
    className: "opacity-60",
  },
};

export function ModuleCard({ module }: { module: Module }) {
  const kind = KIND_META[module.kind];
  const status = STATUS_META[module.status];
  const KindIcon = kind.icon;

  return (
    <Link
      href={`/modules/${module.slug}`}
      className={cn(
        "group flex flex-col gap-3 rounded-xl border bg-card p-4 transition hover:border-foreground/30 hover:shadow-sm",
        status.className,
      )}
    >
      <div className="flex items-start justify-between">
        <div className="flex items-center gap-2">
          <span className="rounded-md bg-muted px-2 py-0.5 font-mono text-xs text-muted-foreground">
            {module.number}
          </span>
          <span className="inline-flex items-center gap-1 text-xs text-muted-foreground">
            <KindIcon className="size-3.5" /> {kind.label}
          </span>
        </div>
        <span className="inline-flex items-center gap-1.5 text-xs text-muted-foreground">
          <span className={cn("size-2 rounded-full", status.dot)} />
          {status.label}
        </span>
      </div>

      <h3 className="text-base font-semibold leading-tight">{module.title}</h3>

      <p className="text-sm text-muted-foreground">{module.summary}</p>

      <div className="mt-auto flex items-center justify-between pt-2 text-xs text-muted-foreground">
        <span>~{module.estimatedMinutes} min</span>
        <span className="inline-flex items-center gap-1 text-foreground opacity-0 transition group-hover:opacity-100">
          Open <ArrowRight className="size-3.5" />
        </span>
      </div>
    </Link>
  );
}
