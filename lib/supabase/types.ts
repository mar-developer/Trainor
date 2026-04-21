// Placeholder Database types. Regenerate with:
//   npx supabase gen types typescript --local > lib/supabase/types.ts
// (or --project-id <id> --schema public for cloud projects)
export type Database = {
  public: {
    Tables: Record<string, { Row: Record<string, unknown>; Insert: Record<string, unknown>; Update: Record<string, unknown> }>;
    Views: Record<string, never>;
    Functions: Record<string, never>;
    Enums: Record<string, never>;
  };
};
