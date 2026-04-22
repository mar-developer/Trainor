"use client";

import { useState, useTransition } from "react";
import { Loader2, Plus } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import { createExperiment } from "@/app/actions/experiments";

export function NewExperimentDialog({
  courseSlug,
}: {
  /** Which course this experiment belongs to. Required. */
  courseSlug: string;
}) {
  const [open, setOpen] = useState(false);
  const [title, setTitle] = useState("");
  const [circuit, setCircuit] = useState("");
  const [observation, setObservation] = useState("");
  const [pending, startTransition] = useTransition();

  const reset = () => {
    setTitle("");
    setCircuit("");
    setObservation("");
  };

  const submit = () => {
    if (!title.trim() || !observation.trim()) {
      toast.error("Title and observation are required.");
      return;
    }
    startTransition(async () => {
      try {
        await createExperiment({
          courseSlug,
          title: title.trim(),
          circuitDescription: circuit.trim() || undefined,
          observation: observation.trim(),
        });
        toast.success("Experiment logged.");
        reset();
        setOpen(false);
      } catch (err) {
        console.error(err);
        toast.error("Could not save — check the dev server logs.");
      }
    });
  };

  return (
    <Dialog
      open={open}
      onOpenChange={(next) => {
        setOpen(next);
        if (!next) reset();
      }}
    >
      <DialogTrigger
        render={<Button size="sm" className="gap-2" />}
      >
        <Plus className="size-4" /> New experiment
      </DialogTrigger>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>Log a custom experiment</DialogTitle>
          <DialogDescription>
            A circuit you designed or tweaked yourself — describe the setup
            and what you observed.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-1.5">
            <Label htmlFor="exp-title">Title</Label>
            <Input
              id="exp-title"
              placeholder="e.g. Pot + Buzzer + LED parallel"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              disabled={pending}
            />
          </div>

          <div className="space-y-1.5">
            <Label htmlFor="exp-circuit">
              Circuit (optional)
            </Label>
            <Textarea
              id="exp-circuit"
              placeholder="5V → Pot Pin 1 → Wiper → Buzzer → GND (parallel with LED path)"
              rows={3}
              value={circuit}
              onChange={(e) => setCircuit(e.target.value)}
              disabled={pending}
            />
          </div>

          <div className="space-y-1.5">
            <Label htmlFor="exp-observation">Observation</Label>
            <Textarea
              id="exp-observation"
              placeholder="What happened, and what does it tell you about the circuit?"
              rows={3}
              value={observation}
              onChange={(e) => setObservation(e.target.value)}
              disabled={pending}
            />
          </div>
        </div>

        <DialogFooter>
          <Button
            variant="ghost"
            onClick={() => setOpen(false)}
            disabled={pending}
          >
            Cancel
          </Button>
          <Button onClick={submit} disabled={pending}>
            {pending && <Loader2 className="size-4 animate-spin" />}
            {pending ? "Saving…" : "Log experiment"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
