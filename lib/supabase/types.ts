export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          extensions?: Json
          operationName?: string
          query?: string
          variables?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      chats: {
        Row: {
          created_at: string
          id: string
          lesson_id: string | null
          title: string | null
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          lesson_id?: string | null
          title?: string | null
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          lesson_id?: string | null
          title?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "chats_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
        ]
      }
      chunks: {
        Row: {
          content: string
          created_at: string
          document_id: string
          heading_path: string | null
          id: string
          metadata: Json
          token_count: number
        }
        Insert: {
          content: string
          created_at?: string
          document_id: string
          heading_path?: string | null
          id?: string
          metadata?: Json
          token_count: number
        }
        Update: {
          content?: string
          created_at?: string
          document_id?: string
          heading_path?: string | null
          id?: string
          metadata?: Json
          token_count?: number
        }
        Relationships: [
          {
            foreignKeyName: "chunks_document_id_fkey"
            columns: ["document_id"]
            isOneToOne: false
            referencedRelation: "documents"
            referencedColumns: ["id"]
          },
        ]
      }
      components: {
        Row: {
          blurb: string
          category: Database["public"]["Enums"]["component_category"]
          datasheet_url: string | null
          id: string
          name: string
          pinout_svg: string | null
          slug: string
          status: Database["public"]["Enums"]["module_status"]
        }
        Insert: {
          blurb: string
          category: Database["public"]["Enums"]["component_category"]
          datasheet_url?: string | null
          id?: string
          name: string
          pinout_svg?: string | null
          slug: string
          status?: Database["public"]["Enums"]["module_status"]
        }
        Update: {
          blurb?: string
          category?: Database["public"]["Enums"]["component_category"]
          datasheet_url?: string | null
          id?: string
          name?: string
          pinout_svg?: string | null
          slug?: string
          status?: Database["public"]["Enums"]["module_status"]
        }
        Relationships: []
      }
      courses: {
        Row: {
          created_at: string
          description: string | null
          id: string
          slug: string
          title: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          slug: string
          title: string
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          slug?: string
          title?: string
        }
        Relationships: []
      }
      documents: {
        Row: {
          checksum: string
          id: string
          ingested_at: string
          source: Database["public"]["Enums"]["document_source"]
          title: string
          url: string | null
        }
        Insert: {
          checksum: string
          id?: string
          ingested_at?: string
          source: Database["public"]["Enums"]["document_source"]
          title: string
          url?: string | null
        }
        Update: {
          checksum?: string
          id?: string
          ingested_at?: string
          source?: Database["public"]["Enums"]["document_source"]
          title?: string
          url?: string | null
        }
        Relationships: []
      }
      embeddings: {
        Row: {
          chunk_id: string
          embedding: string
        }
        Insert: {
          chunk_id: string
          embedding: string
        }
        Update: {
          chunk_id?: string
          embedding?: string
        }
        Relationships: [
          {
            foreignKeyName: "embeddings_chunk_id_fkey"
            columns: ["chunk_id"]
            isOneToOne: true
            referencedRelation: "chunks"
            referencedColumns: ["id"]
          },
        ]
      }
      experiments: {
        Row: {
          circuit_description: string | null
          course_id: string | null
          created_at: string
          id: string
          observation: string | null
          title: string
          user_id: string
        }
        Insert: {
          circuit_description?: string | null
          course_id?: string | null
          created_at?: string
          id?: string
          observation?: string | null
          title: string
          user_id: string
        }
        Update: {
          circuit_description?: string | null
          course_id?: string | null
          created_at?: string
          id?: string
          observation?: string | null
          title?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "experiments_course_id_fkey"
            columns: ["course_id"]
            isOneToOne: false
            referencedRelation: "courses"
            referencedColumns: ["id"]
          },
        ]
      }
      hands_on_steps: {
        Row: {
          expected_measurement: string | null
          id: string
          instruction: string
          lesson_id: string
          order: number
        }
        Insert: {
          expected_measurement?: string | null
          id?: string
          instruction: string
          lesson_id: string
          order: number
        }
        Update: {
          expected_measurement?: string | null
          id?: string
          instruction?: string
          lesson_id?: string
          order?: number
        }
        Relationships: [
          {
            foreignKeyName: "hands_on_steps_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
        ]
      }
      lesson_components: {
        Row: {
          component_slug: string
          lesson_id: string
          order: number
        }
        Insert: {
          component_slug: string
          lesson_id: string
          order?: number
        }
        Update: {
          component_slug?: string
          lesson_id?: string
          order?: number
        }
        Relationships: [
          {
            foreignKeyName: "lesson_components_component_slug_fkey"
            columns: ["component_slug"]
            isOneToOne: false
            referencedRelation: "components"
            referencedColumns: ["slug"]
          },
          {
            foreignKeyName: "lesson_components_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
        ]
      }
      lesson_safety: {
        Row: {
          id: string
          kind: Database["public"]["Enums"]["safety_kind"]
          lesson_id: string
          message: string
          order: number
        }
        Insert: {
          id?: string
          kind: Database["public"]["Enums"]["safety_kind"]
          lesson_id: string
          message: string
          order: number
        }
        Update: {
          id?: string
          kind?: Database["public"]["Enums"]["safety_kind"]
          lesson_id?: string
          message?: string
          order?: number
        }
        Relationships: [
          {
            foreignKeyName: "lesson_safety_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
        ]
      }
      lessons: {
        Row: {
          body_md: string | null
          id: string
          module_id: string
          order: number
          title: string
        }
        Insert: {
          body_md?: string | null
          id?: string
          module_id: string
          order: number
          title: string
        }
        Update: {
          body_md?: string | null
          id?: string
          module_id?: string
          order?: number
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "lessons_module_id_fkey"
            columns: ["module_id"]
            isOneToOne: false
            referencedRelation: "modules"
            referencedColumns: ["id"]
          },
        ]
      }
      messages: {
        Row: {
          chat_id: string
          citations: Json
          content: string
          created_at: string
          id: string
          role: Database["public"]["Enums"]["message_role"]
        }
        Insert: {
          chat_id: string
          citations?: Json
          content: string
          created_at?: string
          id?: string
          role: Database["public"]["Enums"]["message_role"]
        }
        Update: {
          chat_id?: string
          citations?: Json
          content?: string
          created_at?: string
          id?: string
          role?: Database["public"]["Enums"]["message_role"]
        }
        Relationships: [
          {
            foreignKeyName: "messages_chat_id_fkey"
            columns: ["chat_id"]
            isOneToOne: false
            referencedRelation: "chats"
            referencedColumns: ["id"]
          },
        ]
      }
      modules: {
        Row: {
          estimated_minutes: number
          id: string
          kind: Database["public"]["Enums"]["module_kind"]
          number: string
          order: number
          phase_id: string
          slug: string
          status: Database["public"]["Enums"]["module_status"]
          summary: string | null
          title: string
        }
        Insert: {
          estimated_minutes?: number
          id?: string
          kind: Database["public"]["Enums"]["module_kind"]
          number: string
          order: number
          phase_id: string
          slug: string
          status?: Database["public"]["Enums"]["module_status"]
          summary?: string | null
          title: string
        }
        Update: {
          estimated_minutes?: number
          id?: string
          kind?: Database["public"]["Enums"]["module_kind"]
          number?: string
          order?: number
          phase_id?: string
          slug?: string
          status?: Database["public"]["Enums"]["module_status"]
          summary?: string | null
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "modules_phase_id_fkey"
            columns: ["phase_id"]
            isOneToOne: false
            referencedRelation: "phases"
            referencedColumns: ["id"]
          },
        ]
      }
      phases: {
        Row: {
          course_id: string
          id: string
          order: number
          title: string
        }
        Insert: {
          course_id: string
          id?: string
          order: number
          title: string
        }
        Update: {
          course_id?: string
          id?: string
          order?: number
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "phases_course_id_fkey"
            columns: ["course_id"]
            isOneToOne: false
            referencedRelation: "courses"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          avatar_url: string | null
          created_at: string
          display_name: string | null
          id: string
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string
          display_name?: string | null
          id: string
        }
        Update: {
          avatar_url?: string | null
          created_at?: string
          display_name?: string | null
          id?: string
        }
        Relationships: []
      }
      progress: {
        Row: {
          completed_at: string
          lesson_id: string
          self_report: Json | null
          step_id: string
          user_id: string
        }
        Insert: {
          completed_at?: string
          lesson_id: string
          self_report?: Json | null
          step_id: string
          user_id: string
        }
        Update: {
          completed_at?: string
          lesson_id?: string
          self_report?: Json | null
          step_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "progress_lesson_id_fkey"
            columns: ["lesson_id"]
            isOneToOne: false
            referencedRelation: "lessons"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "progress_step_id_fkey"
            columns: ["step_id"]
            isOneToOne: false
            referencedRelation: "hands_on_steps"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      match_chunks: {
        Args: { match_count?: number; query_embedding: string }
        Returns: {
          chunk_id: string
          content: string
          document_id: string
          heading_path: string
          similarity: number
          source: Database["public"]["Enums"]["document_source"]
          title: string
          url: string
        }[]
      }
    }
    Enums: {
      component_category:
        | "led"
        | "resistor"
        | "sensor"
        | "motor"
        | "display"
        | "switch"
        | "ic"
        | "board"
        | "tool"
        | "wire"
      document_source:
        | "spec"
        | "arduino_docs"
        | "datasheet"
        | "obsidian"
        | "tutorial"
      message_role: "user" | "assistant" | "system"
      module_kind: "theory" | "handson" | "code" | "project"
      module_status: "complete" | "in_progress" | "preview" | "not_started"
      safety_kind: "danger" | "caution" | "info"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {
      component_category: [
        "led",
        "resistor",
        "sensor",
        "motor",
        "display",
        "switch",
        "ic",
        "board",
        "tool",
        "wire",
      ],
      document_source: [
        "spec",
        "arduino_docs",
        "datasheet",
        "obsidian",
        "tutorial",
      ],
      message_role: ["user", "assistant", "system"],
      module_kind: ["theory", "handson", "code", "project"],
      module_status: ["complete", "in_progress", "preview", "not_started"],
      safety_kind: ["danger", "caution", "info"],
    },
  },
} as const

