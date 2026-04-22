import type { LucideIcon } from "lucide-react";
import {
  Activity,
  Battery,
  Bot,
  Cable,
  CircuitBoard,
  Cpu,
  Gauge,
  Grid3x3,
  Lightbulb,
  Mic,
  Microchip,
  Radio,
  Ruler,
  Speaker,
  Sparkles,
  ToggleLeft,
  Volume2,
  Waypoints,
  Wrench,
  Zap,
} from "lucide-react";

export type ComponentCategory =
  | "led"
  | "resistor"
  | "sensor"
  | "motor"
  | "display"
  | "switch"
  | "ic"
  | "board"
  | "tool"
  | "wire";

export type ComponentStatus = "done" | "remaining" | "locked";

export interface ComponentCard {
  slug: string;
  name: string;
  category: ComponentCategory;
  status: ComponentStatus;
  icon: LucideIcon;
  blurb: string;
}

export const CATEGORY_LABEL: Record<ComponentCategory, string> = {
  led: "LEDs",
  resistor: "Passives",
  sensor: "Sensors",
  motor: "Motors",
  display: "Displays",
  switch: "Switches",
  ic: "ICs",
  board: "Boards",
  tool: "Tools",
  wire: "Wiring",
};

// 13 core components from spec §212-399
export const COMPONENTS: ComponentCard[] = [
  {
    slug: "resistor",
    name: "Resistors",
    category: "resistor",
    status: "done",
    icon: Activity,
    blurb: "Limit current. Color codes + Ohm's law.",
  },
  {
    slug: "led",
    name: "LEDs",
    category: "led",
    status: "done",
    icon: Lightbulb,
    blurb: "Polarized diode. Long leg = anode.",
  },
  {
    slug: "transistor",
    name: "Transistors",
    category: "ic",
    status: "done",
    icon: Cpu,
    blurb: "PN2222 NPN. Tiny signal → big current.",
  },
  {
    slug: "button",
    name: "Tactile buttons",
    category: "switch",
    status: "done",
    icon: ToggleLeft,
    blurb: "Momentary switch. Pull-up / pull-down.",
  },
  {
    slug: "potentiometer",
    name: "Potentiometer",
    category: "sensor",
    status: "done",
    icon: Gauge,
    blurb: "10KΩ variable resistor. analogRead 0-1023.",
  },
  {
    slug: "buzzer",
    name: "Buzzers",
    category: "sensor",
    status: "done",
    icon: Volume2,
    blurb: "Active (fixed) + passive (tone melodies).",
  },
  {
    slug: "relay",
    name: "Relay module",
    category: "ic",
    status: "done",
    icon: Zap,
    blurb: "Magnetic isolated switch. Up to 220V load.",
  },
  {
    slug: "diode",
    name: "Diodes",
    category: "resistor",
    status: "remaining",
    icon: Activity,
    blurb: "1N4007 one-way valve. Flyback protection.",
  },
  {
    slug: "capacitor",
    name: "Capacitors",
    category: "resistor",
    status: "remaining",
    icon: Battery,
    blurb: "Store charge. Smoothing + decoupling.",
  },
  {
    slug: "photoresistor",
    name: "Photoresistor",
    category: "sensor",
    status: "remaining",
    icon: Sparkles,
    blurb: "Light-dependent resistor. Analog input.",
  },
  {
    slug: "servo",
    name: "Servo motor",
    category: "motor",
    status: "remaining",
    icon: Radio,
    blurb: "SG90. Precise 0-180° angle via PWM.",
  },
  {
    slug: "dc-motor",
    name: "DC motor",
    category: "motor",
    status: "remaining",
    icon: CircuitBoard,
    blurb: "Free-spin. Needs L293D driver.",
  },
  {
    slug: "shift-register",
    name: "74HC595",
    category: "ic",
    status: "remaining",
    icon: Microchip,
    blurb: "Shift register: 3 pins → 8 outputs.",
  },
  // Equipment / tooling that the hands-on lessons assume you have.
  {
    slug: "arduino-uno",
    name: "Arduino Uno R3",
    category: "board",
    status: "done",
    icon: CircuitBoard,
    blurb: "ATmega328P · 14 digital pins (6 PWM), 6 analog · 5V logic.",
  },
  {
    slug: "breadboard",
    name: "Breadboard",
    category: "board",
    status: "done",
    icon: Grid3x3,
    blurb: "830-point layout. Columns vertical, rails horizontal.",
  },
  {
    slug: "jumper-wires",
    name: "Jumper wires",
    category: "wire",
    status: "done",
    icon: Cable,
    blurb: "M-M for breadboard, F-M for Arduino pins.",
  },
  {
    slug: "multimeter",
    name: "Multimeter",
    category: "tool",
    status: "done",
    icon: Ruler,
    blurb: "Resistance, voltage, current, continuity.",
  },
  {
    slug: "esp32",
    name: "ESP32 Dev Board",
    category: "board",
    status: "remaining",
    icon: Cpu,
    blurb: "WiFi + BT + dual-core 240 MHz. 3.3V logic.",
  },
  {
    slug: "l293d",
    name: "L293D H-bridge",
    category: "ic",
    status: "remaining",
    icon: Zap,
    blurb: "Motor driver. Direction + PWM speed for 2 DC motors.",
  },
  {
    slug: "ultrasonic",
    name: "HC-SR04 ultrasonic",
    category: "sensor",
    status: "remaining",
    icon: Waypoints,
    blurb: "Distance 2cm-4m via echo-time. Trigger + echo pins.",
  },
  {
    slug: "robot-chassis",
    name: "Robot chassis (2WD)",
    category: "motor",
    status: "remaining",
    icon: Bot,
    blurb: "Acrylic base + 2 geared motors + wheels + caster.",
  },
  {
    slug: "i2s-mic",
    name: "I2S microphone",
    category: "sensor",
    status: "remaining",
    icon: Mic,
    blurb: "INMP441 digital mic. 24-bit 16-48 kHz audio input.",
  },
  {
    slug: "i2s-speaker",
    name: "I2S DAC + speaker",
    category: "sensor",
    status: "remaining",
    icon: Speaker,
    blurb: "MAX98357A amp + 3W speaker. 3-wire I2S output.",
  },
];

export interface Module {
  slug: string;
  number: string;
  title: string;
  kind: "theory" | "handson" | "code" | "project";
  status: "complete" | "in-progress" | "preview" | "not-started";
  estimatedMinutes: number;
  summary: string;
}

// Modules from spec §24-34
export const PHASE_ONE_MODULES: Module[] = [
  {
    slug: "electronics-fundamentals",
    number: "1.1",
    title: "Electronics Fundamentals",
    kind: "theory",
    status: "complete",
    estimatedMinutes: 25,
    summary:
      "Voltage, current, resistance — water-pipe analogy. Ohm's law as a diagnostic tool. AC vs DC.",
  },
  {
    slug: "multimeter-mastery",
    number: "1.2",
    title: "Multimeter Mastery",
    kind: "handson",
    status: "complete",
    estimatedMinutes: 30,
    summary:
      "Resistance, DC voltage, current (series!), continuity testing. Real LTDm900E measurements.",
  },
  {
    slug: "breadboard-basics",
    number: "1.3",
    title: "Breadboard & Circuit Basics",
    kind: "handson",
    status: "complete",
    estimatedMinutes: 20,
    summary:
      "830-point layout. Column vs rail connections. Series vs parallel LEDs.",
  },
  {
    slug: "core-components",
    number: "1.4",
    title: "Core Components Deep Dive",
    kind: "handson",
    status: "in-progress",
    estimatedMinutes: 90,
    summary:
      "Thirteen components. 7 done: resistor, LED, transistor, button, pot, buzzer, relay.",
  },
  {
    slug: "arduino-ecosystem",
    number: "1.5",
    title: "The Arduino Ecosystem",
    kind: "theory",
    status: "preview",
    estimatedMinutes: 15,
    summary:
      "Board comparison (Uno / Nano / Mega / ESP32). 5V vs 3.3V logic.",
  },
  {
    slug: "arduino-ide",
    number: "1.6",
    title: "Arduino IDE & First Sketch",
    kind: "handson",
    status: "not-started",
    estimatedMinutes: 25,
    summary:
      "Install IDE 2.x. Blink. setup(), loop(), pinMode, digitalWrite.",
  },
  {
    slug: "programming-fundamentals",
    number: "1.7",
    title: "Programming Fundamentals",
    kind: "code",
    status: "not-started",
    estimatedMinutes: 40,
    summary:
      "What's different from TS: memory, async, int sizes, millis(), Serial.print.",
  },
  {
    slug: "first-projects",
    number: "1.8",
    title: "First Real Projects",
    kind: "project",
    status: "not-started",
    estimatedMinutes: 60,
    summary:
      "Traffic light, debounced button LED, pot dimmer, buzzer melody, DHT11 reader.",
  },
];

export const PHASES = [
  { number: 1, title: "Foundations", status: "in-progress" as const },
  { number: 2, title: "37 Sensor Modules", status: "locked" as const },
  { number: 3, title: "Multi-Sensor Projects", status: "locked" as const },
  { number: 4, title: "IoT Integration", status: "locked" as const },
];

export interface Experiment {
  id: string;
  title: string;
  observation: string;
  createdAt: string;
  /** Hydrated from the DB when reading the global experiments feed. */
  courseSlug?: string;
  courseTitle?: string;
}

// From spec §403-431
export const EXPERIMENTS: Experiment[] = [
  {
    id: "exp-1",
    title: "Pot + Buzzer + LED parallel",
    observation:
      "Turning the knob adjusts BOTH buzzer volume and LED brightness. Loading effect at the wiper.",
    createdAt: "2026-04-12",
  },
  {
    id: "exp-2",
    title: "Loading effect verification",
    observation:
      "With only LED on Pin 3, brightness stays constant regardless of knob position — proving pot strip is always 10KΩ.",
    createdAt: "2026-04-13",
  },
  {
    id: "exp-3",
    title: "LED on Pin 3 without external resistor",
    observation:
      "Pot's 10KΩ strip alone limits current to 0.3mA. 50× safer than the 20mA max. The pot IS the resistor.",
    createdAt: "2026-04-14",
  },
];

export interface HandsOnStep {
  /** DB UUID. Undefined when the step comes from mock data (no DB). */
  id?: string;
  order: number;
  instruction: string;
  expected?: string;
  /** Hydrated by the repo: null until the user marks this step done. */
  completedAt?: string | null;
  /** User's measurement report text. */
  selfReport?: string | null;
}

export interface LessonContent {
  moduleSlug: string;
  title: string;
  body: string;
  handsOn: HandsOnStep[];
  safety: Array<{ kind: "danger" | "caution" | "info"; message: string }>;
}

export const LESSONS: Record<string, LessonContent> = {
  "core-components": {
    moduleSlug: "core-components",
    title: "Core Components Deep Dive",
    body: `Thirteen components from the Super Starter Kit, each with pinout, circuit rules, and a developer analogy. You've cleared 7 of 13 — pick up where you left off with **capacitors** next, or drill into any completed component for review.

> **Water-pipe analogy recap:** every hands-on in this module should end with an Ohm's-law diagnostic. If actual current ≠ predicted, something in the circuit is wrong.`,
    handsOn: [
      {
        order: 1,
        instruction:
          "Wire a single red LED from 5V → 220Ω → LED → GND. Measure current with meter in series.",
        expected: "10–11 mA. If you see ~80 mA, your resistor is bypassed.",
      },
      {
        order: 2,
        instruction:
          "Replace the 220Ω with a 10KΩ potentiometer as a variable resistor (2-pin mode). Sweep the knob.",
        expected:
          "Current range roughly 0.3 mA (max R) to 11 mA (min R). LED visibly dims and brightens.",
      },
      {
        order: 3,
        instruction:
          "Continuity-test the relay module's COM, NO and NC terminals — first with relay de-energized, then touching Signal to 5V.",
        expected:
          "Off: COM↔NC beeps. On: audible click, then COM↔NO beeps.",
      },
    ],
    safety: [
      {
        kind: "danger",
        message:
          "Never touch the relay's screw-terminal side while 220V is connected. Mains voltage is lethal and not a beginner project.",
      },
      {
        kind: "caution",
        message:
          "If you see a USB 'Power surge' popup, disconnect immediately. It means a short — usually a resistor bypassed (both legs in the same breadboard column).",
      },
      {
        kind: "info",
        message:
          "Measure your actual 5V pin (typically 5.05V). Use the real reading in calculations for more accurate predictions.",
      },
    ],
  },
};

export interface ChatMessageSeed {
  id: string;
  role: "user" | "assistant";
  content: string;
  citations?: Array<{ index: number; source: string; heading: string }>;
}

export const SAMPLE_CHAT: ChatMessageSeed[] = [
  {
    id: "m1",
    role: "user",
    content: "Why did my LED burn out after the power surge?",
  },
  {
    id: "m2",
    role: "assistant",
    content: `Your resistor was bypassed — both legs landed in the same breadboard column, so current shunted straight through it. Without protection, the LED saw ~80 mA (vs the ~20 mA it tolerates), and the junction overheated. [1]

Fix: move one resistor leg to a different column so it actually spans the circuit. Verify with continuity before reconnecting USB. [2]`,
    citations: [
      {
        index: 1,
        source: "arduino_trainer_spec.md",
        heading: "Module 1.2 › Debugging Log › Issue 2: Dead LED",
      },
      {
        index: 2,
        source: "arduino_trainer_spec.md",
        heading: "Module 1.3 › Breadboard Layout › Critical rules",
      },
    ],
  },
];
