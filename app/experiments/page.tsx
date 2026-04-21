import { FlaskConical } from "lucide-react";
import { NewExperimentDialog } from "@/components/new-experiment-dialog";
import { getExperiments } from "@/lib/data/repo";

export default async function ExperimentsPage() {
  const experiments = await getExperiments();
  return (
    <div className="flex-1">
      <header className="flex h-16 items-center justify-between border-b px-4 sm:px-6">
        <div>
          <p className="text-xs uppercase tracking-wide text-muted-foreground">
            Experiments
          </p>
          <h1 className="text-sm font-semibold">
            Circuits you designed without a tutorial
          </h1>
        </div>
        <NewExperimentDialog />
      </header>

      <div className="mx-auto w-full max-w-4xl space-y-4 px-4 py-6 sm:px-6">
        {experiments.length === 0 ? (
          <div className="rounded-xl border border-dashed bg-card p-12 text-center">
            <FlaskConical className="mx-auto size-10 text-muted-foreground/60" />
            <h2 className="mt-3 font-semibold">No experiments yet</h2>
            <p className="mx-auto mt-1 max-w-sm text-sm text-muted-foreground">
              When you wire up a circuit that isn't in the lesson — log it
              here with what you observed. Even the failures are worth
              keeping.
            </p>
          </div>
        ) : (
          experiments.map((e) => (
            <article key={e.id} className="rounded-xl border bg-card p-5">
              <div className="flex items-start gap-3">
                <div className="flex size-10 items-center justify-center rounded-full bg-sensor/15 text-sensor">
                  <FlaskConical className="size-5" />
                </div>
                <div className="flex-1 space-y-1">
                  <div className="flex items-center justify-between">
                    <h2 className="font-semibold">{e.title}</h2>
                    <time className="text-xs text-muted-foreground">
                      {e.createdAt}
                    </time>
                  </div>
                  <p className="text-sm text-muted-foreground">
                    {e.observation}
                  </p>
                </div>
              </div>
            </article>
          ))
        )}
      </div>
    </div>
  );
}
