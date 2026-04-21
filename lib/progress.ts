// Shared progress types + the completion rule.
// The actual "is a lesson complete?" decision is a business rule you should
// own — see the bottom of this file.

export interface StepProgress {
  stepOrder: number;
  completedAt: string | null; // ISO timestamp, null = not yet completed
  selfReport: string | null;   // what the user typed they measured
}

export interface LessonProgressInput {
  totalSteps: number;
  completedStepOrders: number[];
}

// Rule (b): "≥ 80% of steps checked" — lenient. A lesson counts as complete
// when the learner has marked at least 80% of its hands-on steps done.
// Lets learners skip the occasional edge-case step (e.g. a measurement they
// already did in a prior module) without being blocked from the next module.
// Zero-step lessons (pure theory) pass trivially.
export const COMPLETION_THRESHOLD = 0.8;

export function isLessonComplete(input: LessonProgressInput): boolean {
  if (input.totalSteps === 0) return true;
  return (
    input.completedStepOrders.length / input.totalSteps >= COMPLETION_THRESHOLD
  );
}

// Derived helper used by the UI progress bar.
export function lessonProgressPercent(input: LessonProgressInput): number {
  if (input.totalSteps === 0) return 0;
  return Math.round(
    (input.completedStepOrders.length / input.totalSteps) * 100,
  );
}
