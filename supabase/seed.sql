-- Trainor curriculum seed.
-- Matches the Phase 1 structure from docs/arduino_trainer_spec.md.
-- This seed is deterministic: only curriculum content. Per-user data
-- (progress, experiments, chats) comes from real user interaction.

-- ───────────────────────────────────────── course ─────
insert into public.courses (id, slug, title, description) values
  ('00000000-0000-0000-0000-0000000000aa',
   'arduino-electronics-trainer',
   'Arduino Electronics Trainer',
   'Zero-to-IoT curriculum for web developers. Learn electronics from scratch with hands-on, measurement-driven tutorials.');

-- ───────────────────────────────────────── phases ─────
insert into public.phases (id, course_id, "order", title) values
  ('00000000-0000-0000-0000-0000000000b1', '00000000-0000-0000-0000-0000000000aa', 1, 'Foundations'),
  ('00000000-0000-0000-0000-0000000000b2', '00000000-0000-0000-0000-0000000000aa', 2, '37 Sensor Modules'),
  ('00000000-0000-0000-0000-0000000000b3', '00000000-0000-0000-0000-0000000000aa', 3, 'Multi-Sensor Projects'),
  ('00000000-0000-0000-0000-0000000000b4', '00000000-0000-0000-0000-0000000000aa', 4, 'IoT Integration');

-- ───────────────────────────────────────── modules ─────
insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b1', 1, 'electronics-fundamentals', '1.1',
   'Electronics Fundamentals', 'theory', 'complete', 25,
   'Voltage, current, resistance — water-pipe analogy. Ohm''s law as a diagnostic tool. AC vs DC.'),
  ('00000000-0000-0000-0000-0000000000b1', 2, 'multimeter-mastery',       '1.2',
   'Multimeter Mastery', 'handson', 'complete', 30,
   'Resistance, DC voltage, current (series!), continuity testing. Real LTDm900E measurements.'),
  ('00000000-0000-0000-0000-0000000000b1', 3, 'breadboard-basics',        '1.3',
   'Breadboard & Circuit Basics', 'handson', 'complete', 20,
   '830-point layout. Column vs rail connections. Series vs parallel LEDs.'),
  ('00000000-0000-0000-0000-0000000000b1', 4, 'core-components',          '1.4',
   'Core Components Deep Dive', 'handson', 'in_progress', 90,
   'Thirteen components. 7 done: resistor, LED, transistor, button, pot, buzzer, relay.'),
  ('00000000-0000-0000-0000-0000000000b1', 5, 'arduino-ecosystem',        '1.5',
   'The Arduino Ecosystem', 'theory', 'preview', 15,
   'Board comparison (Uno / Nano / Mega / ESP32). 5V vs 3.3V logic.'),
  ('00000000-0000-0000-0000-0000000000b1', 6, 'arduino-ide',              '1.6',
   'Arduino IDE & First Sketch', 'handson', 'not_started', 25,
   'Install IDE 2.x. Blink. setup(), loop(), pinMode, digitalWrite.'),
  ('00000000-0000-0000-0000-0000000000b1', 7, 'programming-fundamentals', '1.7',
   'Programming Fundamentals', 'code', 'not_started', 40,
   'What''s different from TS: memory, async, int sizes, millis(), Serial.print.'),
  ('00000000-0000-0000-0000-0000000000b1', 8, 'first-projects',           '1.8',
   'First Real Projects', 'project', 'not_started', 60,
   'Traffic light, debounced button LED, pot dimmer, buzzer melody, DHT11 reader.');

-- ───────────────────────────────────────── components ─────
insert into public.components (slug, name, category, blurb, status) values
  ('resistor',        'Resistors',        'resistor', 'Limit current. Color codes + Ohm''s law.',                    'complete'),
  ('led',             'LEDs',             'led',      'Polarized diode. Long leg = anode.',                          'complete'),
  ('transistor',      'Transistors',      'ic',       'PN2222 NPN. Tiny signal → big current.',                      'complete'),
  ('button',          'Tactile buttons',  'switch',   'Momentary switch. Pull-up / pull-down.',                      'complete'),
  ('potentiometer',   'Potentiometer',    'sensor',   '10KΩ variable resistor. analogRead 0-1023.',                  'complete'),
  ('buzzer',          'Buzzers',          'sensor',   'Active (fixed) + passive (tone melodies).',                   'complete'),
  ('relay',           'Relay module',     'ic',       'Magnetic isolated switch. Up to 220V load.',                  'complete'),
  ('diode',           'Diodes',           'resistor', '1N4007 one-way valve. Flyback protection.',                   'not_started'),
  ('capacitor',       'Capacitors',       'resistor', 'Store charge. Smoothing + decoupling.',                       'not_started'),
  ('photoresistor',   'Photoresistor',    'sensor',   'Light-dependent resistor. Analog input.',                     'not_started'),
  ('servo',           'Servo motor',      'motor',    'SG90. Precise 0-180° angle via PWM.',                         'not_started'),
  ('dc-motor',        'DC motor',         'motor',    'Free-spin. Needs L293D driver.',                              'not_started'),
  ('shift-register',  '74HC595',          'ic',       'Shift register: 3 pins → 8 outputs.',                         'not_started');

-- ───────────────────────────────────────── lessons ─────
-- One lesson per module as a preview. The RAG pipeline will expand these with
-- full chunked content from docs/arduino_trainer_spec.md for retrieval.
insert into public.lessons (id, module_id, "order", title, body_md) values
  ('00000000-0000-0000-0000-0000000000c0',
   (select id from public.modules where slug = 'electronics-fundamentals'),
   1,
   'Electronics Fundamentals',
   'The mental model that everything else builds on.

**Water-pipe analogy (use throughout):**
- Voltage (V) = water pressure (what pushes current)
- Current (I) = water flow rate (how much flows)
- Resistance (R) = valve tightness (what limits flow)
- Power (P) = how much work is being done

**Ohm''s Law — the single most important formula:**
```
V = I × R    I = V / R    R = V / I    P = V × I
```

Ohm''s law isn''t just a formula — it''s a diagnostic tool. When measured values don''t match predictions, something is wrong in the circuit.

**Arduino Uno power limits** (damage happens fast):
- Per digital pin: 40 mA max (20 mA recommended)
- Total from 5V pin: ~200 mA
- Exceeding these can damage the board permanently.'),

  ('00000000-0000-0000-0000-0000000000c2',
   (select id from public.modules where slug = 'multimeter-mastery'),
   1,
   'Multimeter Mastery',
   'Resistance, DC voltage, current (meter goes IN SERIES), and the continuity beeper — your fastest debugging tool.

Measured values from the session with the Lotus LTDm900E:
| Resistor | Reading | Within Tolerance |
|---|---|---|
| 100Ω (5%) | 102-104Ω | ✓ |
| 1KΩ (5%) | ~980Ω | ✓ |
| 220Ω (1%) | 217-221Ω | ✓ |

**Arduino 5V pin measured:** 5.05V — use this, not the nominal 5.00V, in calculations.

**Current measurement gotcha:** the meter must be IN SERIES (break the circuit, insert meter in the gap). Putting it across a component in current mode blows the fuse.'),

  ('00000000-0000-0000-0000-0000000000c3',
   (select id from public.modules where slug = 'breadboard-basics'),
   1,
   'Breadboard & Circuit Basics',
   'The 830-point breadboard is a grid of hidden connections. Misread it once and you short your circuit.

**Critical rules:**
1. Same column (a-e or f-j) = electrically connected
2. Center gap (e to f) = NOT connected
3. On 830-point boards, top and bottom power rails are NOT connected — must bridge with jumpers
4. Components must SPAN ACROSS columns
5. Both legs in the same column = bypassed = short circuit

Hands-on you already completed: single LED with 220Ω (~10-11 mA measured), parallel LEDs of different colors, series LEDs with one shared resistor.'),

  ('00000000-0000-0000-0000-0000000000c1',
   (select id from public.modules where slug = 'core-components'),
   1,
   'Core Components Deep Dive',
   'Thirteen components from the Super Starter Kit, each with pinout, circuit rules, and a developer analogy. You''ve cleared 7 of 13 — pick up with **capacitors** next, or drill into any completed component for review.

> **Water-pipe analogy recap:** every hands-on in this module should end with an Ohm''s-law diagnostic. If actual current ≠ predicted, something in the circuit is wrong.'),

  ('00000000-0000-0000-0000-0000000000c5',
   (select id from public.modules where slug = 'arduino-ecosystem'),
   1,
   'The Arduino Ecosystem',
   'The Uno R3 is your learning board, but the ecosystem stretches from tiny Nanos to WiFi-enabled ESP32s.

| Board | Chip | GPIO | Logic | WiFi |
|---|---|---|---|---|
| Uno R3 | ATmega328P | 14 (6 PWM) | 5V | No |
| Nano | ATmega328P | 14 (6 PWM) | 5V | No |
| Mega 2560 | ATmega2560 | 54 (15 PWM) | 5V | No |
| **ESP32** | Xtensa | 34 | **3.3V** | Yes |

**Critical 5V vs 3.3V:** cannot directly connect 5V output to 3.3V input — damages the board. Need a logic level converter.

**Your path:** Phase 1-2 on Uno R3 → Phase 3 Nano (same code) → Phase 4 ESP32 (WiFi, web dashboards).'),

  ('00000000-0000-0000-0000-0000000000c6',
   (select id from public.modules where slug = 'arduino-ide'),
   1,
   'Arduino IDE & First Sketch',
   'Install IDE 2.x, plug in the Uno, pick Tools → Board → Arduino Uno and Tools → Port → COMx.

Your first sketch — Blink:
```cpp
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(500);
  digitalWrite(LED_BUILTIN, LOW);
  delay(500);
}
```

`setup()` runs once. `loop()` runs forever. That''s the whole model.'),

  ('00000000-0000-0000-0000-0000000000c7',
   (select id from public.modules where slug = 'programming-fundamentals'),
   1,
   'Programming Fundamentals',
   'TypeScript mental model vs Arduino C++ — what''s different:

| TS | Arduino |
|---|---|
| `console.log()` | `Serial.print()` |
| `Date.now()` | `millis()` |
| Garbage collector | Manual memory |
| async/await | Single-threaded, blocking |
| `number` arbitrary precision | `int` = 16-bit on Uno |

You''ll cover: variables, `pinMode`/`digitalRead`/`digitalWrite`, `analogRead`, PWM via `analogWrite`, Serial communication, debouncing with `millis()`, the `map()` function, and arrays.'),

  ('00000000-0000-0000-0000-0000000000c8',
   (select id from public.modules where slug = 'first-projects'),
   1,
   'First Real Projects',
   'Five projects that combine everything:

1. **Traffic light** — three LEDs on a timed sequence
2. **Debounced button LED** — hardware + software debounce
3. **Potentiometer dimmer** — `analogRead` → `analogWrite` with `map()`
4. **Buzzer melody** — passive buzzer + `tone()` with note frequencies
5. **DHT11 reader** — temperature + humidity to Serial monitor

Each project ends with a "verify with multimeter" step so you confirm it works at the electrical level, not just visually.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c1', 1,
   'Wire a single red LED from 5V → 220Ω → LED → GND. Measure current with meter in series.',
   '10–11 mA. If you see ~80 mA, your resistor is bypassed.'),
  ('00000000-0000-0000-0000-0000000000c1', 2,
   'Replace the 220Ω with a 10KΩ potentiometer as a variable resistor (2-pin mode). Sweep the knob.',
   'Current range roughly 0.3 mA (max R) to 11 mA (min R). LED visibly dims and brightens.'),
  ('00000000-0000-0000-0000-0000000000c1', 3,
   'Continuity-test the relay module''s COM, NO and NC terminals — first with relay de-energized, then touching Signal to 5V.',
   'Off: COM↔NC beeps. On: audible click, then COM↔NO beeps.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c1', 1, 'danger',
   'Never touch the relay''s screw-terminal side while 220V is connected. Mains voltage is lethal and not a beginner project.'),
  ('00000000-0000-0000-0000-0000000000c1', 2, 'caution',
   'If you see a USB ''Power surge'' popup, disconnect immediately. It means a short — usually a resistor bypassed (both legs in the same breadboard column).'),
  ('00000000-0000-0000-0000-0000000000c1', 3, 'info',
   'Measure your actual 5V pin (typically 5.05V). Use the real reading in calculations for more accurate predictions.');

-- ───────────────────────────────────── local dev user ─────
-- Single-user mode: seed a deterministic auth.users row so progress,
-- experiments, and chats can reference it. The on_auth_user_created
-- trigger auto-creates the matching public.profiles row.
-- Swap to real Supabase Auth later by removing this block.
insert into auth.users (
  id, instance_id, aud, role, email, encrypted_password,
  email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
  created_at, updated_at
)
values (
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000000',
  'authenticated', 'authenticated',
  'dev@local', '',
  now(),
  '{"provider":"email","providers":["email"]}',
  '{"display_name":"Reymar"}',
  now(), now()
)
on conflict (id) do nothing;

-- Seed some initial experiments so the dashboard feels populated on a
-- fresh checkout (matches docs/arduino_trainer_spec.md §403-431).
insert into public.experiments (user_id, title, circuit_description, observation)
values
  ('00000000-0000-0000-0000-000000000001',
   'Pot + Buzzer + LED parallel',
   'Path A (buzzer): 5V → Pot Pin 1 → Wiper → Buzzer → GND. Path B (LED): 5V → Pot Pin 1 → full strip → Pin 3 → LED → GND.',
   'Turning the knob adjusts BOTH buzzer volume and LED brightness. Loading effect at the wiper.'),
  ('00000000-0000-0000-0000-000000000001',
   'Loading effect verification',
   'Disconnected buzzer, only LED on Pin 3.',
   'With only LED on Pin 3, brightness stays constant regardless of knob position — proving pot strip is always 10KΩ.'),
  ('00000000-0000-0000-0000-000000000001',
   'LED on Pin 3 without external resistor',
   'LED from Pin 3 to GND directly.',
   'Pot''s 10KΩ strip alone limits current to 0.3mA. 50× safer than 20mA max. The pot IS the resistor.')
on conflict do nothing;
