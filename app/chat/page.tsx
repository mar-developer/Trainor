import { ChatPanel } from "@/components/chat-panel";
import { SAMPLE_CHAT } from "@/lib/data/mock";

export default function ChatPage() {
  return (
    <div className="flex-1">
      <header className="flex h-16 items-center border-b px-4 sm:px-6">
        <div>
          <p className="text-xs uppercase tracking-wide text-muted-foreground">
            Tutor chat
          </p>
          <h1 className="text-sm font-semibold">
            Grounded in your curriculum + Arduino docs + datasheets
          </h1>
        </div>
      </header>

      <div className="mx-auto h-[calc(100dvh-4rem)] max-w-4xl">
        <ChatPanel initialMessages={SAMPLE_CHAT} />
      </div>
    </div>
  );
}
