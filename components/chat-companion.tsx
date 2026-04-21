"use client";

import { MessageSquare } from "lucide-react";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { ChatPanel } from "@/components/chat-panel";
import { SAMPLE_CHAT } from "@/lib/data/mock";

export function ChatCompanion({ lessonContext }: { lessonContext?: string }) {
  return (
    <Sheet>
      <SheetTrigger
        render={
          <Button
            size="lg"
            className="fixed bottom-6 right-6 h-14 gap-2 rounded-full px-5 shadow-lg"
          />
        }
      >
        <MessageSquare className="size-5" />
        Ask tutor
      </SheetTrigger>
      <SheetContent
        side="right"
        className="w-full p-0 sm:max-w-xl"
      >
        <SheetHeader className="border-b px-4 py-3">
          <SheetTitle>Tutor chat</SheetTitle>
        </SheetHeader>
        <div className="h-[calc(100dvh-3.5rem)]">
          <ChatPanel
            lessonContext={lessonContext}
            initialMessages={lessonContext ? [] : SAMPLE_CHAT}
          />
        </div>
      </SheetContent>
    </Sheet>
  );
}
