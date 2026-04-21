"use server";

// Experiment CRUD actions for the logged experiments page.
import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createServiceClient } from "@/lib/supabase/service";
import { getCurrentUserId } from "@/lib/auth";

const createSchema = z.object({
  title: z.string().min(1).max(200),
  circuitDescription: z.string().max(2000).optional(),
  observation: z.string().min(1).max(2000),
});

export type CreateExperimentInput = z.infer<typeof createSchema>;

export async function createExperiment(input: CreateExperimentInput) {
  const parsed = createSchema.parse(input);
  const userId = await getCurrentUserId();
  const supabase = createServiceClient();

  const { error } = await supabase.from("experiments").insert({
    user_id: userId,
    title: parsed.title,
    circuit_description: parsed.circuitDescription ?? null,
    observation: parsed.observation,
  });
  if (error) throw error;

  revalidatePath("/experiments");
  revalidatePath("/");
}
