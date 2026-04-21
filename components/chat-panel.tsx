"use client";

import { useState } from "react";
import { useChat } from "@ai-sdk/react";
import { DefaultChatTransport, type UIMessage } from "ai";
import { Loader2, Send, Sparkles, User2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { InlineCitation, CitationList, type Citation } from "@/components/citations";
import { toast } from "sonner";
import type { ChatMessageSeed } from "@/lib/data/mock";

const SUGGESTED_PROMPTS = [
  "Why did my LED burn out after the power surge?",
  "What's the pinout of the PN2222 transistor?",
  "How do I wire a pull-down resistor for a button?",
  "When should I use NO vs NC on the relay?",
];

export function ChatPanel({
  initialMessages = [],
  lessonContext,
}: {
  initialMessages?: ChatMessageSeed[];
  lessonContext?: string;
}) {
  const [input, setInput] = useState("");

  const { messages, sendMessage, status } = useChat({
    transport: new DefaultChatTransport({ api: "/api/chat" }),
    messages: initialMessages.map(seedToUIMessage),
    onError: (err) => {
      toast.error(
        "Chat failed. Is AI_GATEWAY_API_KEY set and Supabase running?",
      );
      console.error(err);
    },
  });

  const onSend = () => {
    const trimmed = input.trim();
    if (!trimmed || status === "streaming") return;
    sendMessage({ text: trimmed });
    setInput("");
  };

  const isEmpty = messages.length === 0;

  return (
    <div className="flex h-full flex-col">
      {lessonContext && (
        <div className="flex items-center gap-2 border-b bg-muted/40 px-4 py-2 text-xs text-muted-foreground">
          <Sparkles className="size-3.5 text-info" />
          Context:{" "}
          <span className="font-medium text-foreground">{lessonContext}</span>
        </div>
      )}

      <div className="flex-1 space-y-4 overflow-y-auto p-4">
        {isEmpty && (
          <div className="space-y-3 rounded-xl border bg-card p-5">
            <div className="flex items-center gap-2">
              <Sparkles className="size-4 text-info" />
              <h3 className="font-semibold">Ask your tutor anything</h3>
            </div>
            <p className="text-sm text-muted-foreground">
              Grounded in your curriculum, Arduino docs, and component
              datasheets. Every answer cites its sources.
            </p>
            <div className="grid gap-2 sm:grid-cols-2">
              {SUGGESTED_PROMPTS.map((p) => (
                <button
                  key={p}
                  onClick={() => setInput(p)}
                  className="rounded-lg border bg-background px-3 py-2 text-left text-xs text-muted-foreground transition hover:border-foreground/30 hover:text-foreground"
                >
                  {p}
                </button>
              ))}
            </div>
          </div>
        )}

        {messages.map((m) => (
          <MessageBubble key={m.id} message={m} />
        ))}

        {status === "streaming" && messages.at(-1)?.role === "user" && (
          <div className="flex gap-3">
            <AssistantAvatar />
            <div className="inline-flex items-center gap-2 rounded-xl border bg-card px-4 py-3 text-sm text-muted-foreground">
              <Loader2 className="size-4 animate-spin" />
              Thinking…
            </div>
          </div>
        )}
      </div>

      <div className="border-t p-3">
        <div className="flex items-end gap-2">
          <Textarea
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                onSend();
              }
            }}
            placeholder="Ask about a component, debug a circuit, or request an explanation…"
            rows={2}
            className="resize-none"
            disabled={status === "streaming"}
          />
          <Button
            onClick={onSend}
            size="icon"
            className="size-10 shrink-0"
            disabled={status === "streaming" || !input.trim()}
          >
            {status === "streaming" ? (
              <Loader2 className="size-4 animate-spin" />
            ) : (
              <Send className="size-4" />
            )}
          </Button>
        </div>
        <p className="mt-2 text-[0.7rem] text-muted-foreground">
          Shift + Enter for new line · answers cite sources with [n]
        </p>
      </div>
    </div>
  );
}

function MessageBubble({ message }: { message: UIMessage }) {
  const isUser = message.role === "user";
  const text = message.parts
    .filter((p): p is { type: "text"; text: string } => p.type === "text")
    .map((p) => p.text)
    .join("");
  const citations: Citation[] =
    (message as UIMessage & { metadata?: { citations?: Citation[] } }).metadata
      ?.citations ?? [];

  return (
    <div className={cn("flex gap-3", isUser ? "flex-row-reverse" : "flex-row")}>
      {isUser ? <UserAvatar /> : <AssistantAvatar />}
      <div
        className={cn(
          "max-w-[80%] rounded-xl px-4 py-3 text-sm leading-relaxed",
          isUser
            ? "bg-primary text-primary-foreground"
            : "border bg-card text-card-foreground",
        )}
      >
        <RenderedText text={text} />
        {!isUser && citations.length > 0 && (
          <CitationList citations={citations} />
        )}
      </div>
    </div>
  );
}

function RenderedText({ text }: { text: string }) {
  const parts = text.split(/(\[\d+\])/g);
  return (
    <div className="space-y-2 whitespace-pre-wrap">
      {parts.map((part, i) => {
        const m = part.match(/^\[(\d+)\]$/);
        if (m) return <InlineCitation key={i} index={Number(m[1])} />;
        return <span key={i}>{part}</span>;
      })}
    </div>
  );
}

function AssistantAvatar() {
  return (
    <div className="flex size-8 shrink-0 items-center justify-center rounded-full bg-info/15 text-info">
      <Sparkles className="size-4" />
    </div>
  );
}

function UserAvatar() {
  return (
    <div className="flex size-8 shrink-0 items-center justify-center rounded-full bg-foreground text-background">
      <User2 className="size-4" />
    </div>
  );
}

function seedToUIMessage(seed: ChatMessageSeed): UIMessage {
  return {
    id: seed.id,
    role: seed.role,
    parts: [{ type: "text", text: seed.content }],
    ...(seed.citations
      ? { metadata: { citations: seed.citations } as unknown as never }
      : {}),
  } as UIMessage;
}
