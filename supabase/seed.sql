-- Trainor curriculum seed.
-- Matches the Phase 1 structure from docs/arduino_trainer_spec.md.
-- This seed is deterministic: only curriculum content. Per-user data
-- (progress, experiments, chats) comes from real user interaction.

-- ───────────────────────────────────────── course ─────
insert into public.courses (id, slug, title, description) values
  ('00000000-0000-0000-0000-0000000000aa',
   'arduino-electronics-trainer',
   'Arduino Electronics Trainer',
   'Zero-to-robot curriculum for web developers. Electronics from scratch, the 37-in-1 kit, multi-sensor projects, and a wheeled-robot capstone.'),
  ('00000000-0000-0000-0000-0000000000ab',
   'iot-with-esp32',
   'IoT & Intelligent Devices with ESP32',
   'From Arduino to IoT. WiFi, web servers, MQTT, FreeRTOS, BLE, OTA — ending with an AI voice companion you can talk to.');

-- ───────────────────────────────────────── phases ─────
insert into public.phases (id, course_id, "order", title) values
  ('00000000-0000-0000-0000-0000000000b1', '00000000-0000-0000-0000-0000000000aa', 1, 'Foundations'),
  ('00000000-0000-0000-0000-0000000000b2', '00000000-0000-0000-0000-0000000000aa', 2, '37 Sensor Modules'),
  ('00000000-0000-0000-0000-0000000000b3', '00000000-0000-0000-0000-0000000000aa', 3, 'Multi-Sensor Projects'),
  ('00000000-0000-0000-0000-0000000000b4', '00000000-0000-0000-0000-0000000000aa', 4, 'Capstone: Autonomous Robot'),
  -- ESP32 course phases
  ('00000000-0000-0000-0000-0000000000b5', '00000000-0000-0000-0000-0000000000ab', 1, 'IoT Fundamentals'),
  ('00000000-0000-0000-0000-0000000000b6', '00000000-0000-0000-0000-0000000000ab', 2, 'ESP32 Deep Dive'),
  ('00000000-0000-0000-0000-0000000000b7', '00000000-0000-0000-0000-0000000000ab', 3, 'Capstone: AI Companion');

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
  ('shift-register',  '74HC595',          'ic',       'Shift register: 3 pins → 8 outputs.',                         'not_started'),
  -- Equipment / tooling the hands-on lessons assume you have.
  ('arduino-uno',     'Arduino Uno R3',   'board',    'ATmega328P · 14 digital pins (6 PWM), 6 analog · 5V logic.',   'complete'),
  ('breadboard',      'Breadboard',       'board',    '830-point layout. Columns vertical, rails horizontal.',        'complete'),
  ('jumper-wires',    'Jumper wires',     'wire',     'M-M for breadboard, F-M for Arduino pins.',                    'complete'),
  ('multimeter',      'Multimeter',       'tool',     'Lotus LTDm900E. Resistance, voltage, current, continuity.',    'complete'),

  -- Phase 2 — 37-in-1 sensor kit. All start as not_started; status flips as you study each.
  -- Switches & mechanical sensors
  ('tilt-switch',     'Tilt switch',          'switch', 'Ball-in-tube. Closes/opens when tilted past a threshold.',   'not_started'),
  ('reed-switch',     'Reed switch',          'switch', 'Magnetic reed. Closes when a magnet is nearby.',              'not_started'),
  ('mercury-switch',  'Mercury switch',       'switch', 'Liquid mercury ball. Tilt-activated, very sensitive.',        'not_started'),
  ('shock-switch',    'Shock switch',         'switch', 'Spring-based. Pulses briefly when the board is struck.',      'not_started'),
  ('knock-sensor',    'Knock sensor',         'sensor', 'Piezo disc. Detects sharp taps as a short pulse.',            'not_started'),
  ('photo-interrupter','Photo-interrupter',   'sensor', 'IR LED + phototransistor across a slot. Beam break = event.', 'not_started'),

  -- Analog sensors
  ('thermistor',      'Thermistor',           'sensor', 'NTC — resistance drops as temp rises. Needs voltage divider.','not_started'),
  ('analog-hall',     'Analog hall sensor',   'sensor', 'Output voltage tracks magnetic field strength + polarity.',   'not_started'),
  ('linear-hall',     'Linear hall sensor',   'sensor', 'Analog variant tuned for gradient (proximity) readings.',     'not_started'),
  ('flame-sensor',    'Flame sensor',         'sensor', 'IR photodiode tuned to flame wavelengths (760–1100 nm).',     'not_started'),
  ('sound-sensor',    'Sound sensor',         'sensor', 'Electret mic + op-amp. Analog envelope + digital threshold.', 'not_started'),

  -- IR & light
  ('ir-emitter',      'IR emitter module',    'sensor', '940 nm IR LED. Pair with receiver for beam-break or remotes.','not_started'),
  ('ir-receiver',     'IR receiver module',   'sensor', '38 kHz demodulator. Decodes TV-remote style pulse trains.',   'not_started'),
  ('ir-avoidance',    'IR avoidance module',  'sensor', 'IR LED + photodiode. Detects surfaces 2–30 cm away.',          'not_started'),
  ('ir-tracking',     'IR line-tracking',     'sensor', 'Reflection sensor for black-line vs white-surface contrast.', 'not_started'),
  ('laser-module',    'Laser module',         'display','5 V red laser diode on a PCB. Looks like an LED, focuses tight.','not_started'),

  -- Digital environmental sensors
  ('dht11',           'DHT11',                'sensor', 'Digital temperature + humidity. Single-wire protocol. 1 Hz.', 'not_started'),
  ('ds18b20',         'DS18B20',              'sensor', '1-Wire digital temp sensor, 0.5 °C precision, ±0.5 °C accuracy.','not_started'),
  ('heartbeat-sensor','Heartbeat sensor',     'sensor', 'IR reflectance on fingertip. Outputs a pulse per heartbeat.', 'not_started'),

  -- User input modules
  ('rotary-encoder',  'Rotary encoder',       'switch', 'Quadrature A/B + push. Infinite rotation with direction.',    'not_started'),
  ('joystick',        'Joystick module',      'switch', '2 analog pots + a button. X, Y, SW.',                          'not_started'),
  ('touch-sensor',    'Touch sensor',         'switch', 'Capacitive TTP223. Digital HIGH when a finger is near.',       'not_started'),

  -- Output modules
  ('rgb-module',      'RGB LED module',       'led',    'Common-anode RGB with 3 current-limiting resistors on-board.','not_started'),
  ('flash-led',       '7-color flash LED',    'led',    'Auto-cycling RGB — just VCC + GND, no Arduino needed.',       'not_started'),
  ('dual-color-led',  'Dual-color LED',       'led',    'Red + green in one package. Mix for yellow via PWM.',         'not_started'),

  -- Phase 4 — IoT integration. ESP32 is the new board of choice for WiFi projects.
  ('esp32',           'ESP32 Dev Board',      'board',  'WiFi + BT + dual-core 240 MHz · 34 GPIO · 3.3V logic.',       'not_started'),

  -- Phase 4 Arduino (robot capstone) + ESP32 course (AI companion, deep dive)
  ('l293d',           'L293D H-bridge',        'ic',     'Motor driver IC. Controls 2 DC motors (direction + PWM speed).','not_started'),
  ('ultrasonic',      'HC-SR04 ultrasonic',    'sensor', 'Distance sensor 2cm-4m. Trigger pulse → echo time → distance.','not_started'),
  ('robot-chassis',   'Robot chassis (2WD)',   'motor',  'Acrylic base + 2 geared motors + wheels + caster + battery box.','not_started'),
  ('i2s-mic',         'I2S microphone',        'sensor', 'INMP441 digital mic. 3-wire I2S audio input, 24-bit 16-48 kHz.','not_started'),
  ('i2s-speaker',     'I2S DAC + speaker',     'sensor', 'MAX98357A amplifier + 3W speaker. 3-wire I2S output.',        'not_started');

-- ───────────────────────────────────────── lessons ─────
-- Rich markdown bodies. `<!-- ill:NAME -->` markers are replaced by inline
-- React SVG illustrations (see components/illustrations/). Tables, code
-- fences, blockquotes and lists are all rendered via react-markdown + GFM.
insert into public.lessons (id, module_id, "order", title, body_md) values
  ('00000000-0000-0000-0000-0000000000c0',
   (select id from public.modules where slug = 'electronics-fundamentals'),
   1,
   'Electronics Fundamentals',
   '## The mental model

Before any code, before any board, you need **one analogy** that stays with you through every circuit you build.

<!-- ill:water-pipe -->

Think of electricity as water moving through pipes:

| Electrical term | Water analogy | What it does |
|---|---|---|
| **Voltage (V)** | Pressure at the tap | Pushes charge through the circuit |
| **Current (I)** | Flow rate | How much charge moves per second |
| **Resistance (R)** | Valve tightness | Restricts the flow |
| **Power (P)** | How fast work gets done | Voltage × current |

This isn''t just a teaching trick — every mental picture you''ll build from this module onward (why a resistor protects an LED, why a short circuit is dangerous, why you need a current-limiting resistor for the base of a transistor) comes back to this pipe-and-valve model.

## Ohm''s law

One formula, three forms. Use the triangle: **cover the letter you want, multiply or divide the other two**.

<!-- ill:ohms-triangle -->

```
V = I × R      I = V ÷ R      R = V ÷ I      P = V × I
```

> **Ohm''s law as a diagnostic tool.** When a measured value doesn''t match what you predicted, work backwards. Measured 80 mA but calculated 14 mA? Something short-circuited a resistor. Measured 11 mA instead of 14 mA? The LED''s forward voltage is higher than the assumed 2.0 V. Every mismatch points at a real-world detail you didn''t account for.

## LED + resistor: the first real calculation

Protecting an LED means sizing a resistor so current stays under its rated maximum (typically **20 mA**).

```
R = (V_supply − V_LED) / I_desired
```

For a red LED (V_LED ≈ 2.0 V) at 10 mA from a 5 V supply:

```
R = (5 − 2) / 0.010 = 300 Ω   →  use 330 Ω (next standard value up)
```

<!-- ill:led-circuit -->

Use the **next standard value up** rather than the exact calculation — a slightly higher resistance is always safer.

### LED forward voltages by colour

| Colour | Typical V_F |
|---|---|
| Red / Yellow | 1.8 – 2.2 V |
| Green | 2.0 – 3.0 V |
| Blue / White | 3.0 – 3.5 V |

## AC vs DC

| Type | Example | Direction | Where you meet it |
|---|---|---|---|
| **DC** (Direct Current) | Batteries, USB, Arduino | One direction | Everything in Phase 1–4 |
| **AC** (Alternating Current) | Wall outlet (220 V / 60 Hz in PH) | Alternates | Don''t touch. Ever. |

## Series vs parallel — one-paragraph intro

You''ll build both kinds in Module 1.3, but lock in the vocabulary now:

- **Series** — one path. Same current through every component. Voltages add up. One fails → everything dies.
- **Parallel** — multiple paths. Same voltage across each branch. Currents add up. One fails → the others keep working.

## Arduino Uno power budget

These aren''t soft limits. Exceeding them blows the pin — or the chip.

| Limit | Value |
|---|---|
| Per digital pin | **40 mA** absolute max, **20 mA** recommended |
| Total from the 5 V pin | ~200 mA |
| Total from the board | ~500 mA (USB-limited) |
| Whole-board power | ~1 W |

**Rule of thumb:** if you''re driving anything bigger than a single LED — motors, relays, long LED strips — put a **transistor** between the Arduino and the load. (Module 1.4 covers that.)

## Takeaway

Everything in electronics is pressure pushing flow through resistance. Voltage × current = power. A resistor is a deliberate valve. An LED is a one-way light-up valve with a specific forward voltage. Every circuit you''ll ever debug boils down to: where''s the voltage dropping, and how much current is flowing through what?'),

  ('00000000-0000-0000-0000-0000000000c2',
   (select id from public.modules where slug = 'multimeter-mastery'),
   1,
   'Multimeter Mastery',
   '## Your fastest debugging tool

A multimeter turns "I think the circuit is shorted" into a number. Every hands-on you do from here on should end with at least one measurement.

This course assumes the **Lotus LTDm900E 2000C** (manual-ranging, continuity beep, True-RMS, backlit). Older models like the DT-830D work too — they just lack the continuity beeper, which slows debugging.

<!-- ill:multimeter-dial -->

## The four modes you''ll live in

### 1) Resistance (Ω)

Rotate to a range **just above** the expected value. Touch the probes to the component leads **out of circuit** (don''t measure a resistor still wired into a live circuit — the surrounding components throw the reading off).

| Resistor (nominal) | Range | Actual reading | Within tolerance? |
|---|---|---|---|
| 100 Ω (5%) | 2000 Ω | 102 – 104 Ω | ✓ (95 – 105) |
| 220 Ω (1%) | 2000 Ω | 217 – 221 Ω | ✓ (217.8 – 222.2) |
| 1 KΩ (5%) | 2000 Ω | ~980 Ω | ✓ (950 – 1050) |

> **Last-digit wobble** of ±1-3 counts is normal. A reading of `1` on the display with no other digits means **over-range** — bump to the next range up.

### Resistor colour code refresher

Five-band resistors (the ones in your kit) read: **digit · digit · digit · multiplier · tolerance**.

| Colour | Digit | Multiplier |
|---|---|---|
| Black | 0 | ×1 |
| Brown | 1 | ×10 |
| Red | 2 | ×100 |
| Orange | 3 | ×1 K |
| Yellow | 4 | ×10 K |
| Green | 5 | ×100 K |
| Blue | 6 | ×1 M |
| Violet | 7 | ×10 M |
| Gray | 8 | — |
| White | 9 | — |

Example — **220 Ω ±1%**: Red · Red · Black · Black · Brown.

Mnemonic: *"Bad Beer Rots Our Young Guts But Vodka Goes Well"*.

### 2) DC voltage (V̄ / DCV)

Red probe in the V port, dial to DCV 20. Black probe to GND, red probe to the test point.

| Pin | Nominal | Measured |
|---|---|---|
| Arduino 5V | 5.00 V | **5.05 V** |
| Arduino 3.3V | 3.30 V | **3.31 V** |

> **Use your actual reading** in calculations, not the nominal. An LED calc with 5.05 V and a measured 218 Ω resistor gets you within 0.1 mA of the prediction every time.

### 3) Current (A / mA) — the one that blows fuses

Current goes **through** the meter, not across a component. You physically break the circuit and insert the meter in the gap. This is called putting the meter **in series**.

<!-- ill:led-circuit -->

| Wrong | Right |
|---|---|
| Meter across a component (parallel) | Meter in the gap (series) |
| Tries to short the component | Current flows through the meter |
| Blows the internal fuse | Reads the real current |

Move the red probe to the **mA port** before turning the dial to a current range. Turning the dial to "A" with the probe still in the voltage port + probes touching anywhere will blow the fuse on contact.

### 4) Continuity (⊸))

Touching the probes together gives a beep — your fastest "is this wire actually connected?" test. Use it:

- End-to-end on a jumper wire (no beep → broken wire)
- Across breadboard rows to verify your column wiring
- From the Arduino GND pin to every GND in your breadboard (proves the ground rail is tied)

## Three real debugging stories

### Issue 1 — "USB power surge" error

Windows popped up a power-surge warning the moment the Uno was plugged in.

- **Symptom:** Uno resets, LED doesn''t light, error dialog.
- **Cause:** Resistor had both legs in the **same breadboard column** — the resistor was bypassed, so a short existed between 5V and GND.
- **Fix:** Move one resistor lead to a different column. Continuity-test the 5V ↔ GND rails afterwards — they should **not** beep.

### Issue 2 — Dead LED

After the power surge, the LED never lit again.

- **Symptom:** LED stays dark. Diode mode on the meter shows no forward-voltage drop.
- **Cause:** When the resistor was bypassed, ~80 mA flowed through the LED (safe max is 20 mA). The LED junction overheated.
- **Fix:** Replace the LED. Lesson: **measure current in series** every time you wire a fresh circuit.

### Issue 3 — Predicted vs measured mismatch

Circuit math said 14 mA. Meter said 10.5 mA.

- **Symptom:** Less current than expected.
- **Diagnosis:** Measure the actual voltages. The resistor dropped 2.289 V (10.5 mA × 218 Ω), so the LED was actually at 5.05 V − 2.289 V = **2.76 V** — higher V_F than the textbook 2.0 V.
- **Takeaway:** Textbook forward voltages are estimates. Measure yours if you want a precise prediction.

## Takeaway

Resistance: out of circuit, range just above expected. Voltage: probes in V port, in parallel with the thing you''re measuring. Current: probes in **mA port, in series with the circuit**. Continuity: the fastest debug tool you own.'),

  ('00000000-0000-0000-0000-0000000000c3',
   (select id from public.modules where slug = 'breadboard-basics'),
   1,
   'Breadboard & Circuit Basics',
   '## A grid of invisible connections

A breadboard looks like a matrix of identical holes, but underneath each column and rail is a copper strip that silently ties certain holes together. Misread that, and you''ve made a short circuit.

<!-- ill:breadboard-layout -->

## The rules (memorise these)

1. **Same column, letters a-e** = electrically one node. Same for f-j on the other side.
2. **Center gap** between e and f = NOT connected. This is where you span ICs like the 74HC595.
3. **Top/bottom rails** run horizontally along the edges. They''re typically marked `+` (red) and `−` (blue/black).
4. On **830-point boards**, the top pair of rails and the bottom pair are **not internally connected to each other**. If you need the same 5V and GND on both, bridge them with two jumper wires.
5. Components must **span across two different columns** to actually be "in" the circuit. Both legs of a resistor in column `c` = a short-circuited resistor = exactly the bug that caused the USB power-surge incident in Module 1.2.

## Your first real circuit — and the two it will grow into

Before running any Arduino code, wire a pure-hardware LED:

```
5V rail → jumper → 220 Ω (spanning two columns) → LED (long leg = anode = +) → GND rail
```

<!-- ill:led-circuit -->

Measure it. You should see **~10-11 mA** on the mA range. If the meter reads 60-80 mA, the resistor is bypassed — unplug USB, check both resistor legs are in different columns, retest.

## Series vs parallel — see them side by side

<!-- ill:series-vs-parallel -->

| Property | Parallel | Series |
|---|---|---|
| Wiring | Each LED gets its own resistor | One resistor for the whole chain |
| Brightness | All LEDs bright at similar levels | All dimmer (V_F values stack) |
| Independence | Pull one out, others stay on | Pull one out, chain dies |
| Use when | You want predictable brightness | You want to save parts |

### Parallel example

```
5V → 220Ω → red LED  → GND
5V → 220Ω → green LED → GND     (same 5V, same GND, two independent branches)
5V → 220Ω → blue LED  → GND
```

Each branch sees ~5 V, draws ~10 mA, totals ~30 mA. That''s still well under the 200 mA budget of the 5 V pin.

### Series example

```
5V → 220Ω → red LED → green LED → blue LED → GND
```

The three V_F values (~2.0 + 2.1 + 3.0 = 7.1 V) exceed your 5 V supply — the chain will barely light. Three red LEDs in series (2 + 2 + 2 = 6 V) won''t light at all. This is why series is rare in Arduino work.

## Common bugs & how to spot them

| Symptom | Likely cause | Check with |
|---|---|---|
| LED doesn''t light | Wrong polarity | Long leg = +, LED faces the resistor side |
| LED dim or flickery | Bad contact in breadboard | Push the leads firmly, try a new row |
| "USB power surge" | Short between 5V and GND | Continuity-test the rails — should be silent |
| Only half the circuit works | Power rails not bridged | 830-point board: link top and bottom rails |

## Takeaway

Breadboards are fast and forgiving, but they lie if you misread them. When something doesn''t work: disconnect USB → visualise where the invisible copper strips go → trace the circuit with the meter''s continuity beeper → fix the one column that''s wrong. Then reconnect.'),

  ('00000000-0000-0000-0000-0000000000c1',
   (select id from public.modules where slug = 'core-components'),
   1,
   'Core Components Deep Dive',
   '## Thirteen parts, one kit

This module is the biggest hands-on block in Phase 1. Every component in the Super Starter Kit gets its own treatment — identification, pinout, circuit rules, and a developer analogy so it sticks.

> **Water-pipe recap:** every hands-on in this module should end with an Ohm''s-law sanity check. If actual current ≠ predicted, something in the circuit is wrong. That''s the diagnostic loop you''ve built in the last three modules — keep using it here.

## Where to click

Each of the 7 components you''ve cleared has its own detail page with an interactive pinout diagram and the exact circuit rules:

- [Resistors](/components/resistor) — colour codes + Ohm''s-law calculator
- [LEDs](/components/led) — polarity + forward-voltage table
- [Transistors](/components/transistor) — PN2222 NPN, base → collector → emitter
- [Tactile buttons](/components/button) — 4-leg layout + pull-up/pull-down
- [Potentiometer](/components/potentiometer) — 3-pin voltage divider vs 2-pin variable resistor
- [Buzzers](/components/buzzer) — active vs passive, `digitalWrite` vs `tone()`
- [Relay module](/components/relay) — **dangerous side warning** + NC/NO decision

The Components tab at the top of this page shows all 17 items (13 parts + 4 pieces of equipment) that this module assumes you have on your bench.

## Remaining (6 of 13)

Each unblocks new projects:

| Component | What it enables |
|---|---|
| **Diodes** (1N4007) | Flyback protection for motors/relays |
| **Capacitors** | Decoupling, smoothing, debouncing |
| **Photoresistor** | Your first analog sensor — day/night detection |
| **Servo motor** (SG90) | Precise 0–180° angle control via PWM |
| **DC motor** | Needs an L293D driver; direction via polarity |
| **74HC595** | Turns 3 Arduino pins into 8 outputs |

## The method

For each component, the process is the same:

1. **Physically identify** it (photo vs what''s in your hand)
2. **Multimeter test** — diode mode on an LED, resistance on a fixed resistor, etc.
3. **Build the simplest circuit** that uses it
4. **Predict with Ohm''s law**, measure, reconcile
5. **Log anything surprising** to your experiments feed

The [experiments page](/experiments) is for circuits you design yourself, beyond what the lesson tells you to build. Three are already logged there from the earlier sessions — use them as the template.'),

  ('00000000-0000-0000-0000-0000000000c5',
   (select id from public.modules where slug = 'arduino-ecosystem'),
   1,
   'The Arduino Ecosystem',
   '## One language, many boards

Every board in the ecosystem runs the same `setup()`/`loop()` C++ dialect and uses the same `digitalWrite`/`analogRead` API. What changes is **the silicon underneath**: pin count, memory, clock speed, and crucially, **logic-level voltage**.

## The boards you''ll actually meet

| Board | Chip | Digital | Analog | Flash | RAM | Clock | Logic | WiFi | BT |
|---|---|---|---|---|---|---|---|---|---|
| **Uno R3** | ATmega328P | 14 (6 PWM) | 6 | 32 KB | 2 KB | 16 MHz | 5 V | ✗ | ✗ |
| Nano | ATmega328P | 14 (6 PWM) | 8 | 32 KB | 2 KB | 16 MHz | 5 V | ✗ | ✗ |
| Mega 2560 | ATmega2560 | 54 (15 PWM) | 16 | 256 KB | 8 KB | 16 MHz | 5 V | ✗ | ✗ |
| **ESP32** | Xtensa | 34 GPIO | 18 | 4 MB | 520 KB | 240 MHz | **3.3 V** | ✓ | ✓ |
| ESP8266 | Xtensa | 11 GPIO | 1 | 4 MB | 80 KB | 80 MHz | **3.3 V** | ✓ | ✗ |
| Leonardo | ATmega32U4 | 20 (7 PWM) | 12 | 32 KB | 2.5 KB | 16 MHz | 5 V | ✗ | ✗ |
| Pi Pico | RP2040 | 26 GPIO | 3 | 2 MB | 264 KB | 133 MHz | **3.3 V** | ✗* | ✗ |

\\* Pico W (a different SKU) does have WiFi.

## The danger: 5V → 3.3V

Connecting a 5 V logic output directly to a 3.3 V logic input **damages the 3.3 V board**. Not "might" — *will*, slowly, every time.

<!-- ill:logic-levels -->

The fix is a tiny breakout called a **logic level converter** (also called a "level shifter"). It has a 5V side and a 3.3V side and translates signals between them. Plan on one if you mix an Uno with an ESP32.

## Your learning path

- **Phase 1–2** — Uno R3: learn fundamentals + all 37 sensors
- **Phase 3** — switch to Nano: same code, smaller footprint, fits in project boxes
- **Phase 4** — ESP32: unlock WiFi and Bluetooth. Build dashboards in the browser (this is where your web-dev skills earn back the electronics investment)

> **Why ESP32 last?** It''s the most capable board *and* the one where the 3.3 V gotcha matters most. Getting the electrical fundamentals nailed on a forgiving 5 V board first means fewer fried chips when you move up.'),

  ('00000000-0000-0000-0000-0000000000c6',
   (select id from public.modules where slug = 'arduino-ide'),
   1,
   'Arduino IDE & First Sketch',
   '## Setting up

1. Download **Arduino IDE 2.x** from [arduino.cc](https://www.arduino.cc/en/software).
2. Install with the defaults (Windows will ask about drivers — accept all).
3. Plug in the Uno via USB. The on-board green `ON` LED lights up.
4. In the IDE, pick `Tools → Board → Arduino Uno` and `Tools → Port → COMx` (usually COM3 or higher on Windows).

If the port is greyed out, unplug/replug the USB cable. If it''s still greyed, install the **CH340** driver — cheap Uno clones use that USB chip instead of the ATmega16U2 used on genuine boards.

## The entire Arduino model, in one diagram

<!-- ill:setup-loop -->

Every sketch has exactly two functions: `setup()` runs once at boot, `loop()` runs forever. That''s it. There''s no `main()`, no event loop, no framework hiding things — the Arduino runtime calls these two for you.

## Your first sketch — Blink

```cpp
void setup() {
  // LED_BUILTIN is pin 13 on the Uno — there''s a surface-mount LED next to the pin header.
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);  // LED on
  delay(500);                        // pause 500 ms (blocking)
  digitalWrite(LED_BUILTIN, LOW);   // LED off
  delay(500);
}
```

**What''s happening:**

- `pinMode(pin, OUTPUT)` tells the microcontroller "I want to drive this pin". You must do this in `setup()` or the pin stays configured as a floating input.
- `digitalWrite(pin, HIGH)` sets the pin to 5 V. `LOW` is 0 V.
- `delay(ms)` blocks for that many milliseconds. **Don''t use this in real projects** — it freezes the whole microcontroller. Module 1.7 covers `millis()` which doesn''t block.

## Upload flow

1. **Verify** (✓ icon) — compiles your sketch, catches syntax errors.
2. **Upload** (→ icon) — compiles + flashes the Uno. The TX/RX LEDs flash while uploading.
3. The Uno resets and starts running your sketch immediately after upload.

If upload fails with "programmer not responding":

- Wrong port selected — recheck `Tools → Port`.
- Serial monitor is open — close it (only one thing can own the port at a time).
- Cable is power-only — try a different USB cable. Some cheap cables are charge-only.

## Serial monitor

Your `console.log()` equivalent. Open with `Ctrl+Shift+M` or the monocle icon.

```cpp
void setup() {
  Serial.begin(9600);   // start serial at 9600 baud
  Serial.println("Hello from Uno!");
}

void loop() {
  Serial.print("uptime: ");
  Serial.println(millis());
  delay(1000);
}
```

Set the monitor to **9600 baud** (or whatever you passed to `Serial.begin`) — mismatched baud = garbage output.

## What comes next

Module 1.7 (Programming Fundamentals) teaches the C++ you''ll actually write: variables, loops, `millis()`, debouncing, and the quirks of a 16-bit `int`. Then Module 1.8 strings it all together into five real projects.'),

  ('00000000-0000-0000-0000-0000000000c7',
   (select id from public.modules where slug = 'programming-fundamentals'),
   1,
   'Programming Fundamentals',
   '## Arduino C++ from a TypeScript mindset

You already know how to write code. The language surface is different, though, and a few differences bite hard on a microcontroller.

| Concept | TypeScript | Arduino C++ |
|---|---|---|
| Print to console | `console.log()` | `Serial.println()` |
| Time since boot | `Date.now()` | `millis()` |
| Strings | `string` (GC-managed) | `char[]` or `String` (careful) |
| Memory | Garbage collector | Manual — you decide |
| Concurrency | `async`/`await`, Promises | Single-threaded, blocking |
| `int` range | ~ ±9e15 (Number) | **±32 767** (16-bit on Uno!) |
| Arrays | Dynamic | Fixed size at compile time |

## `millis()` vs `delay()` — the most important pattern

`delay()` is fine for Blink, but in a real project it freezes everything — no sensor reads, no button checks, no Serial output. Use `millis()` + comparison instead.

### Blocking (bad in real projects)

```cpp
void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(500);                  // nothing else happens for 500 ms
  digitalWrite(LED_BUILTIN, LOW);
  delay(500);
}
```

### Non-blocking (scales)

```cpp
unsigned long lastToggle = 0;
bool ledOn = false;

void loop() {
  // … read buttons, sensors, Serial here …

  if (millis() - lastToggle >= 500) {
    ledOn = !ledOn;
    digitalWrite(LED_BUILTIN, ledOn ? HIGH : LOW);
    lastToggle = millis();
  }
}
```

This is the **Arduino equivalent of `setInterval`** — the loop keeps spinning and the LED just toggles on its own schedule. You can run multiple independent timers this way.

## Debouncing a button

A physical button **bounces** for 5–20 ms when pressed — the contacts make and break multiple times before settling. Without filtering, `digitalRead` sees 5–10 rapid transitions for what felt like one click.

<!-- ill:debounce -->

```cpp
const uint8_t BTN = 2;
unsigned long lastPress = 0;

void setup() {
  pinMode(BTN, INPUT_PULLUP);  // internal pull-up, no external resistor needed
}

void loop() {
  if (digitalRead(BTN) == LOW && millis() - lastPress > 50) {
    // real press — do something
    lastPress = millis();
  }
}
```

The `50` ms window is long enough to filter the bounce and short enough that users don''t notice.

## `analogRead` and `analogWrite`

Different thing entirely — these aren''t opposites.

| Function | Direction | Range | Pins |
|---|---|---|---|
| `analogRead(pin)` | **Input** — real voltage to 10-bit int | 0 – 1023 | A0 – A5 |
| `analogWrite(pin, v)` | **Output** — PWM (duty-cycle ratio) | 0 – 255 | 3, 5, 6, 9, 10, 11 |

Reading a potentiometer:

```cpp
int raw = analogRead(A0);        // 0–1023 across 0–5 V
int brightness = map(raw, 0, 1023, 0, 255);
analogWrite(LED_PIN, brightness);
```

`map()` is essentially Arduino''s version of scaling a number between two ranges — there''s no direct TS equivalent in the standard library.

## Gotchas that will bite you

- **`int` is 16-bit on Uno.** `int x = 50000;` silently wraps. Use `long` (32-bit) when in doubt.
- **`String` on the heap fragments memory.** For serious code, prefer `char[]` with a known max size.
- **`delay()` blocks `millis()`.** It doesn''t advance in the background — use the non-blocking pattern above.
- **Pins float until `pinMode()` is called.** An uninitialised input picks up noise and flips randomly.

## What you''ll use in Module 1.8

Every pattern above shows up in the next module''s five projects: non-blocking timing for the traffic light, debouncing for the button-controlled LED, `map()` for the potentiometer dimmer, `tone()` for the buzzer, and `Serial.println()` for the DHT11 reader.'),

  ('00000000-0000-0000-0000-0000000000c8',
   (select id from public.modules where slug = 'first-projects'),
   1,
   'First Real Projects',
   '## Five projects that combine everything

Each project uses patterns from the previous modules — non-blocking timing, component polarity, debouncing, analogue I/O, and one new library per project. Every one ends with a **verify with multimeter** step so you confirm it works at the electrical level, not just visually.

## 1. Traffic light

Three LEDs on a timed sequence: red → red+yellow → green → yellow → red.

- **Uses:** three digital outputs, non-blocking timing, an enum-like state
- **Key lesson:** driving multiple outputs from one `loop()` without `delay()`

```cpp
enum Phase { RED, RED_YELLOW, GREEN, YELLOW };
Phase phase = RED;
unsigned long phaseStart = 0;
const unsigned long DURATION[] = {5000, 1500, 5000, 1500};  // ms per phase

void loop() {
  if (millis() - phaseStart >= DURATION[phase]) {
    phase = (Phase)((phase + 1) % 4);
    phaseStart = millis();
    applyLights(phase);
  }
}
```

## 2. Debounced button LED

Press the button, the LED toggles. No bounce-generated flicker.

- **Uses:** `INPUT_PULLUP`, `millis()` debounce, edge detection
- **Key lesson:** button is a *press event*, not a continuous signal

## 3. Potentiometer dimmer

Turn the knob, LED brightness changes smoothly.

- **Uses:** `analogRead` → `analogWrite` via `map()`, PWM output
- **Key lesson:** 10-bit input, 8-bit output — `map()` bridges the ranges

```cpp
int raw = analogRead(A0);                 // 0-1023
int pwm = map(raw, 0, 1023, 0, 255);      // 0-255
analogWrite(LED_PIN, pwm);
```

## 4. Buzzer melody

Play a recognisable tune on a passive buzzer.

- **Uses:** `tone(pin, frequency, duration)`, `noTone()`, note-frequency lookup table
- **Key lesson:** passive buzzers make *any* frequency; actives make one

```cpp
const int NOTES[] = {262, 294, 330, 349, 392, 440, 494, 523};  // C4 … C5
for (int n : NOTES) { tone(BUZZER, n, 300); delay(320); }
```

## 5. DHT11 temperature + humidity reader

Read a DHT11 sensor and print to the Serial monitor.

- **Uses:** `DHT.h` library (install via Library Manager), `Serial.print`
- **Key lesson:** sensors have drivers — you rarely bit-bang the protocol yourself

```cpp
#include <DHT.h>
DHT dht(2, DHT11);

void setup() { Serial.begin(9600); dht.begin(); }

void loop() {
  Serial.print(dht.readTemperature()); Serial.print("°C  ");
  Serial.print(dht.readHumidity());    Serial.println("%");
  delay(2000);   // DHT11 can''t sample faster than 1 Hz
}
```

## How to approach each one

1. **Sketch the circuit on paper** before touching the breadboard.
2. **Measure 5 V and GND** on the rails with the multimeter before powering anything interesting.
3. **Upload, verify, measure** — predicted current, actual current, any anomalies.
4. **Log it in experiments** — especially anything that surprised you. Future-you will want the notes.

By the end of this module you''ve used every component you''ve touched so far, written non-blocking C++, and used at least one third-party library. Phase 2 (37 sensors) is unlocked next.');

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

-- ─────────────────────── hands-on: 1.1 Electronics Fundamentals ─────
-- Pure theory module — exercises are paper calculations.
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c0', 1,
   'Given a 5V supply and a 220Ω resistor with a red LED (Vf ≈ 2V), calculate the expected current through the LED.',
   'I = (5V − 2V) / 220Ω ≈ 13.6 mA. Well below the 20 mA safe limit for a digital pin.'),
  ('00000000-0000-0000-0000-0000000000c0', 2,
   'If you measure 80 mA in the same circuit, what''s the most likely cause?',
   'The resistor is bypassed (both legs in the same breadboard column). The LED is seeing ~5V directly — it will burn out in seconds.'),
  ('00000000-0000-0000-0000-0000000000c0', 3,
   'What resistor keeps a blue LED (Vf ≈ 3.3V) at a safe 10 mA from a 5V supply?',
   'R = (5V − 3.3V) / 0.01 A = 170Ω. Use 220Ω (next standard value up) to be safe — the extra resistance barely changes brightness.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c0', 1, 'caution',
   'Arduino digital pin max = 40 mA (20 mA recommended). Exceeding this can permanently damage the microcontroller.'),
  ('00000000-0000-0000-0000-0000000000c0', 2, 'info',
   'LED forward voltages vary by color: red ~2.0V, yellow ~2.1V, green ~2.2V, blue/white ~3.3V. Pick your resistor per colour.');

-- ───────────────────────── hands-on: 1.2 Multimeter Mastery ────────
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c2', 1,
   'Set the dial to the 2000Ω range. Touch the probes to each end of a 220Ω 1% resistor.',
   '217–221Ω. The 1% tolerance band is on the right side of the resistor body.'),
  ('00000000-0000-0000-0000-0000000000c2', 2,
   'In DCV 20V mode, probe Arduino 5V to GND. Then probe 3.3V to GND.',
   'Around 5.05V and 3.31V. Use your actual readings in later calculations — they are more accurate than the nominal values.'),
  ('00000000-0000-0000-0000-0000000000c2', 3,
   'Switch to continuity/diode mode (speaker icon). Short the probes first — you should hear a beep.',
   'Continuous beep when probes touch = meter is working. Silence = broken or wrong mode.'),
  ('00000000-0000-0000-0000-0000000000c2', 4,
   'Move the red probe to the mA port. Break your 220Ω + red LED circuit and insert the meter in the gap.',
   '10–11 mA flowing through the LED. If the reading flickers to 0 and never comes back, the internal fuse blew — you probably measured in parallel instead of series.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c2', 1, 'caution',
   'Current mode = meter IN SERIES. Touching the probes across a component in current mode short-circuits it through the meter and blows the internal fuse.'),
  ('00000000-0000-0000-0000-0000000000c2', 2, 'info',
   'Last-digit wobble (±1-3 counts) is normal. Any larger drift means your contacts aren''t clean or the resistor is out of tolerance.');

-- ───────────────────────── hands-on: 1.3 Breadboard & Circuit Basics
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c3', 1,
   'Wire a single red LED: 5V rail → jumper → 220Ω (spanning two columns) → LED (long leg to +) → GND rail. Measure current with meter in series.',
   'LED lights. Current: 10–11 mA. If you read 80+ mA, the resistor is bypassed — both legs are in the same column.'),
  ('00000000-0000-0000-0000-0000000000c3', 2,
   'Add a second LED in parallel — each with its own 220Ω. Use different colours.',
   'Both LEDs lit, similar brightness. Pulling one out doesn''t affect the other — that''s the parallel property.'),
  ('00000000-0000-0000-0000-0000000000c3', 3,
   'Now rewire them in series with ONE shared 220Ω resistor.',
   'Both LEDs noticeably dimmer. Vf values add: 2V + 2V = 4V, leaving only ~1V across the resistor → much less current. Pulling either LED kills both.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c3', 1, 'danger',
   'If Windows shows "Power surge on USB port" — disconnect the USB cable immediately. That error means a short; leaving it connected can damage the Uno.'),
  ('00000000-0000-0000-0000-0000000000c3', 2, 'caution',
   'The center gap (between columns e and f) is NOT connected. Components must span across it to complete a circuit.'),
  ('00000000-0000-0000-0000-0000000000c3', 3, 'info',
   '830-point boards have TWO power rails (top and bottom) that aren''t connected by default — bridge them with jumpers or you''ll chase a missing-power bug.');

-- ─────────────────────── hands-on: 1.5 The Arduino Ecosystem ─────
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c5', 1,
   'Locate the 5V, 3.3V, and GND pins on your Uno. Then count how many digital pins it has (header along the top edge).',
   '5V + 3.3V + several GND pins on the power header. 14 digital pins (0–13) along the top row.'),
  ('00000000-0000-0000-0000-0000000000c5', 2,
   'Look at an ESP32 pinout online. Which Uno pin, wired directly to an ESP32 GPIO, would damage the ESP32?',
   'Any 5V output. ESP32 GPIOs are 3.3V tolerant — driving them with 5V will slowly fry the pin. Solution: a logic level converter.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c5', 1, 'info',
   'Your migration path when you''re ready: Uno → Nano (same code, smaller) → ESP32 (WiFi + Bluetooth, 3.3V logic).');

-- ─────────────────────── lesson ↔ components mapping ─────
-- Only the components/equipment actually relevant to each lesson.
insert into public.lesson_components (lesson_id, component_slug, "order") values
  -- 1.1 Electronics Fundamentals — referenced in Ohm''s law examples.
  ('00000000-0000-0000-0000-0000000000c0', 'arduino-uno',   1),
  ('00000000-0000-0000-0000-0000000000c0', 'resistor',      2),
  ('00000000-0000-0000-0000-0000000000c0', 'led',           3),
  -- 1.2 Multimeter Mastery
  ('00000000-0000-0000-0000-0000000000c2', 'multimeter',    1),
  ('00000000-0000-0000-0000-0000000000c2', 'arduino-uno',   2),
  ('00000000-0000-0000-0000-0000000000c2', 'resistor',      3),
  ('00000000-0000-0000-0000-0000000000c2', 'jumper-wires',  4),
  ('00000000-0000-0000-0000-0000000000c2', 'led',           5),
  -- 1.3 Breadboard & Circuit Basics
  ('00000000-0000-0000-0000-0000000000c3', 'breadboard',    1),
  ('00000000-0000-0000-0000-0000000000c3', 'jumper-wires',  2),
  ('00000000-0000-0000-0000-0000000000c3', 'arduino-uno',   3),
  ('00000000-0000-0000-0000-0000000000c3', 'resistor',      4),
  ('00000000-0000-0000-0000-0000000000c3', 'led',           5),
  ('00000000-0000-0000-0000-0000000000c3', 'multimeter',    6),
  -- 1.4 Core Components Deep Dive — full kit + equipment
  ('00000000-0000-0000-0000-0000000000c1', 'breadboard',     1),
  ('00000000-0000-0000-0000-0000000000c1', 'jumper-wires',   2),
  ('00000000-0000-0000-0000-0000000000c1', 'arduino-uno',    3),
  ('00000000-0000-0000-0000-0000000000c1', 'multimeter',     4),
  ('00000000-0000-0000-0000-0000000000c1', 'resistor',       5),
  ('00000000-0000-0000-0000-0000000000c1', 'led',            6),
  ('00000000-0000-0000-0000-0000000000c1', 'transistor',     7),
  ('00000000-0000-0000-0000-0000000000c1', 'button',         8),
  ('00000000-0000-0000-0000-0000000000c1', 'potentiometer',  9),
  ('00000000-0000-0000-0000-0000000000c1', 'buzzer',        10),
  ('00000000-0000-0000-0000-0000000000c1', 'relay',         11),
  ('00000000-0000-0000-0000-0000000000c1', 'diode',         12),
  ('00000000-0000-0000-0000-0000000000c1', 'capacitor',     13),
  ('00000000-0000-0000-0000-0000000000c1', 'photoresistor', 14),
  ('00000000-0000-0000-0000-0000000000c1', 'servo',         15),
  ('00000000-0000-0000-0000-0000000000c1', 'dc-motor',      16),
  ('00000000-0000-0000-0000-0000000000c1', 'shift-register',17),
  -- 1.5 Arduino Ecosystem — just the board for reference.
  ('00000000-0000-0000-0000-0000000000c5', 'arduino-uno',   1),
  -- 1.6 Arduino IDE — first sketch on the Uno.
  ('00000000-0000-0000-0000-0000000000c6', 'arduino-uno',   1),
  ('00000000-0000-0000-0000-0000000000c6', 'jumper-wires',  2),
  -- 1.7 Programming Fundamentals — theory but references the Uno.
  ('00000000-0000-0000-0000-0000000000c7', 'arduino-uno',   1)
on conflict do nothing;

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
insert into public.experiments (user_id, course_id, title, circuit_description, observation)
values
  ('00000000-0000-0000-0000-000000000001',
   '00000000-0000-0000-0000-0000000000aa',
   'Pot + Buzzer + LED parallel',
   'Path A (buzzer): 5V → Pot Pin 1 → Wiper → Buzzer → GND. Path B (LED): 5V → Pot Pin 1 → full strip → Pin 3 → LED → GND.',
   'Turning the knob adjusts BOTH buzzer volume and LED brightness. Loading effect at the wiper.'),
  ('00000000-0000-0000-0000-000000000001',
   '00000000-0000-0000-0000-0000000000aa',
   'Loading effect verification',
   'Disconnected buzzer, only LED on Pin 3.',
   'With only LED on Pin 3, brightness stays constant regardless of knob position — proving pot strip is always 10KΩ.'),
  ('00000000-0000-0000-0000-000000000001',
   '00000000-0000-0000-0000-0000000000aa',
   'LED on Pin 3 without external resistor',
   'LED from Pin 3 to GND directly.',
   'Pot''s 10KΩ strip alone limits current to 0.3mA. 50× safer than 20mA max. The pot IS the resistor.')
on conflict do nothing;

-- ───────────────────────── hands-on: 1.5 more depth ─────
-- Three additional exercises on top of the two already seeded for 1.5.
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c5', 3,
   'With the meter in DCV 20V, measure the 5V and 3.3V pins on your Uno. Write the actual values down.',
   '5V reads ≈ 5.05V, 3.3V reads ≈ 3.31V. These values are specific to your board — save them for future LED/transistor calcs.'),
  ('00000000-0000-0000-0000-0000000000c5', 4,
   'Calculate: with the 5V pin budget of ~200 mA, how many red LEDs (10 mA each with their own 220Ω) can you safely run in parallel?',
   'About 20. That''s the theoretical ceiling — stay well below it, especially if anything else is also drawing from 5V.'),
  ('00000000-0000-0000-0000-0000000000c5', 5,
   'Look up your next target board (Nano or ESP32). Note its operating voltage, pin count, and any shared peripherals with the Uno.',
   'Nano: same 5V/ATmega328P, 8 analog pins instead of 6. ESP32: 3.3V, WiFi, 34 GPIO, ~10× faster clock.');

-- ───────────────────────── hands-on: 1.6 Arduino IDE & First Sketch ─────
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c6', 1,
   'Install Arduino IDE 2.x. Launch it, accept all driver prompts, then plug in your Uno via USB.',
   'IDE opens to an empty sketch. The on-board green `ON` LED is lit. Windows shows a notification about installing drivers — let it finish.'),
  ('00000000-0000-0000-0000-0000000000c6', 2,
   'Open Tools → Board. Pick "Arduino Uno". Then Tools → Port — a COMx entry should appear (typically COM3 or higher).',
   'Board shows "Arduino Uno" in the bottom-right. Port is selected and not greyed out. If Port stays greyed, install the CH340 driver for cheap clones.'),
  ('00000000-0000-0000-0000-0000000000c6', 3,
   'Open File → Examples → 01.Basics → Blink. Click the "Upload" arrow. Watch the TX/RX LEDs flash during upload.',
   'Upload succeeds in ~5 seconds. The on-board LED (pin 13) starts blinking at 1 Hz. If it fails with "programmer not responding", close any open Serial Monitor and retry.'),
  ('00000000-0000-0000-0000-0000000000c6', 4,
   'Change both `delay(1000)` calls to `delay(200)`. Re-upload.',
   'The LED now blinks ~5× faster. Proves your edit-compile-upload loop works — the code you type is now running on the chip.'),
  ('00000000-0000-0000-0000-0000000000c6', 5,
   'Wire an external LED: pin 13 → 220Ω → LED(+) → GND. Re-upload Blink. Remove the external LED momentarily to see only the on-board one blink.',
   'Both LEDs blink in sync when connected. The external LED follows pin 13 directly — you''ve just used a digital output to drive a real component.'),
  ('00000000-0000-0000-0000-0000000000c6', 6,
   'Add `Serial.begin(9600);` in setup() and `Serial.println("hello");` in loop() (with a `delay(1000)` gate). Upload, then open Tools → Serial Monitor at 9600 baud.',
   'The monitor prints "hello" once per second. Wrong baud = gibberish — make sure the dropdown says 9600.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c6', 1, 'info',
   'Only one program can own the serial port at a time. Close the Serial Monitor before uploading, or you''ll get a "programmer not responding" error.'),
  ('00000000-0000-0000-0000-0000000000c6', 2, 'caution',
   'Pin 13 has a built-in LED + resistor on the board. Driving external things directly off pin 13 works, but you''ll see weird dimming because some current goes through the on-board LED.');

-- ───────────────────────── hands-on: 1.7 Programming Fundamentals ─────
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c7', 1,
   'Rewrite Blink using `millis()` instead of `delay()` — toggle the LED every 500 ms without blocking the loop.',
   'LED still blinks at 1 Hz. Bonus: `Serial.println(millis());` inside loop() prints ~thousands of times per second because the loop no longer pauses.'),
  ('00000000-0000-0000-0000-0000000000c7', 2,
   'Wire a potentiometer (5V → Pin1, Pin3 → GND, Pin2 → A0). Read `analogRead(A0)` and `Serial.println` the result.',
   '0 at one extreme, 1023 at the other, smooth progression as you turn the knob. Fast refresh (10+ readings/second) because there''s no delay.'),
  ('00000000-0000-0000-0000-0000000000c7', 3,
   'Use `map(raw, 0, 1023, 0, 255)` to convert the pot reading and `analogWrite` it to a PWM-capable pin (3, 5, 6, 9, 10, or 11) driving an LED with 220Ω.',
   'LED dims smoothly as you turn the pot. Fully off at 0, full brightness at 1023.'),
  ('00000000-0000-0000-0000-0000000000c7', 4,
   'Add a tactile button on pin 2 with `INPUT_PULLUP`. Print "pressed" to Serial whenever you read LOW.',
   'Holding the button prints "pressed" many times per second (fast loop). That''s the problem debouncing fixes in the next step.'),
  ('00000000-0000-0000-0000-0000000000c7', 5,
   'Add a `millis()` debounce — only register a press if at least 50 ms have elapsed since the last one. Print only on the real transitions.',
   'Single press → single "pressed" line. No duplicates from contact bounce. Release + re-press also registers cleanly.'),
  ('00000000-0000-0000-0000-0000000000c7', 6,
   'Combine 3 + 5: pressing the button should cycle through three brightness levels (0%, 50%, 100%).',
   'Each press advances the LED state. The `millis()` pattern lets the pot read AND the button debounce run at the same time — single-threaded but cooperative.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c7', 1, 'caution',
   '`int` on the Uno is 16-bit. If you accumulate milliseconds into `int`, it overflows after ~32 seconds. Use `unsigned long` for anything holding `millis()`.'),
  ('00000000-0000-0000-0000-0000000000c7', 2, 'info',
   'PWM is only available on pins 3, 5, 6, 9, 10, and 11. Calling analogWrite on any other pin silently falls back to HIGH/LOW at a 50% threshold — no error, just broken dimming.');

-- ───────────────────────── hands-on: 1.8 First Real Projects ─────
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-0000000000c8', 1,
   'Project 1 — Traffic light. Wire three LEDs (red, yellow, green) each with their own 220Ω to pins 4, 5, 6. Cycle them on a timed sequence using `millis()` (NOT `delay()`).',
   'Red (5s) → red+yellow (1.5s) → green (5s) → yellow (1.5s) → loop. No pauses, no blocking. Serial.println the phase name on each transition.'),
  ('00000000-0000-0000-0000-0000000000c8', 2,
   'Project 2 — Debounced button LED. Tactile button on pin 2 with INPUT_PULLUP. Every real press toggles an LED on pin 13.',
   'LED flips state once per press. No double-flips from bounce. Measure the current draw when on: 10–11 mA on pin 13 through the built-in LED + resistor.'),
  ('00000000-0000-0000-0000-0000000000c8', 3,
   'Project 3 — Potentiometer dimmer. Pot → A0 → analogRead → map(…,0,255) → analogWrite on a PWM pin driving an external LED.',
   'Full dark at one knob extreme, full bright at the other. Confirm with the meter in mA mode: ~0 mA when dim, ~10 mA when max.'),
  ('00000000-0000-0000-0000-0000000000c8', 4,
   'Project 4 — Buzzer melody. Passive buzzer on pin 8. Play C4-D4-E4-F4-G4-A4-B4-C5 using `tone(8, freq, 300)` with 320 ms gaps.',
   'Clean ascending scale, each note clearly distinct. If it sounds like a single buzz, you''re using the active (not passive) buzzer — swap it.'),
  ('00000000-0000-0000-0000-0000000000c8', 5,
   'Project 5 — DHT11 reader. Install the DHT library via Library Manager. DHT11 VCC→5V, GND→GND, DATA→pin 2. Read temperature + humidity, Serial.println every 2 seconds.',
   'Prints "22°C  60%" style lines. Values should change if you breathe on the sensor for 5 seconds (humidity rises first, then temperature).'),
  ('00000000-0000-0000-0000-0000000000c8', 6,
   'Stretch — combine any two: e.g. DHT11 reading drives a 3-LED "traffic light" status (cold=blue, ok=green, hot=red). Ship it to the experiments feed.',
   'A working composite project. This is the transition point: the next phase (Phase 2) teaches sensors; these 5 patterns recur in every project you build from here on.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-0000000000c8', 1, 'info',
   'Before powering each project, continuity-test 5V ↔ GND. No beep = no short. Do this every time you rewire.'),
  ('00000000-0000-0000-0000-0000000000c8', 2, 'caution',
   'Don''t reuse the same GPIO pin across two projects without double-checking pinMode. Forgetting to re-init a pin between sketches causes the weirdest symptoms.'),
  ('00000000-0000-0000-0000-0000000000c8', 3, 'info',
   'Each finished project belongs on the experiments feed with a one-paragraph "what I learned" note. Future-you needs the log.');

-- ─────────────────────── lesson_components for 1.8 ─────
-- Covers parts/equipment used across the five final projects.
insert into public.lesson_components (lesson_id, component_slug, "order") values
  ('00000000-0000-0000-0000-0000000000c8', 'arduino-uno',    1),
  ('00000000-0000-0000-0000-0000000000c8', 'breadboard',     2),
  ('00000000-0000-0000-0000-0000000000c8', 'jumper-wires',   3),
  ('00000000-0000-0000-0000-0000000000c8', 'multimeter',     4),
  ('00000000-0000-0000-0000-0000000000c8', 'resistor',       5),
  ('00000000-0000-0000-0000-0000000000c8', 'led',            6),
  ('00000000-0000-0000-0000-0000000000c8', 'button',         7),
  ('00000000-0000-0000-0000-0000000000c8', 'potentiometer',  8),
  ('00000000-0000-0000-0000-0000000000c8', 'buzzer',         9)
on conflict do nothing;

-- ═══════════════════════════════════════════════════════════════════
-- ══════════════════════ PHASE 2 — 37 SENSORS ═══════════════════════
-- ═══════════════════════════════════════════════════════════════════

-- ───────────────────────── Phase 2 modules ─────
-- 2.1 is "preview" so the phase unlocks on the curriculum outline;
-- the rest start as not_started until the learner opens them.
insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b2', 1, 'sensor-fundamentals',      '2.1',
   'Sensor Fundamentals', 'theory', 'preview', 30,
   'ADC, voltage dividers, pull-ups — the building blocks you''ll reuse for every sensor in the 37-in-1 kit.'),
  ('00000000-0000-0000-0000-0000000000b2', 2, 'switches-mechanical',      '2.2',
   'Switches & Mechanical Sensors', 'handson', 'not_started', 40,
   'Tilt, reed, shock, knock, mercury, photo-interrupter. Six ways to detect "something happened".'),
  ('00000000-0000-0000-0000-0000000000b2', 3, 'analog-sensors',           '2.3',
   'Analog Sensors', 'handson', 'not_started', 50,
   'Thermistor, hall, flame, sound. Voltage-divider + op-amp patterns for real-world measurements.'),
  ('00000000-0000-0000-0000-0000000000b2', 4, 'ir-line-following',        '2.4',
   'IR Sensors & Line Following', 'handson', 'not_started', 45,
   'IR emitter/receiver, avoidance, tracking, laser. Basis for remote controls and simple robots.'),
  ('00000000-0000-0000-0000-0000000000b2', 5, 'digital-environmental',    '2.5',
   'Digital Environmental Sensors', 'handson', 'not_started', 40,
   'DHT11, DS18B20, heartbeat. Sensors that do their own ADC and hand you calibrated numbers.'),
  ('00000000-0000-0000-0000-0000000000b2', 6, 'user-input-modules',       '2.6',
   'User Input Modules', 'handson', 'not_started', 35,
   'Rotary encoder, joystick, touch. Building blocks for menus, navigation, and physical UI.'),
  ('00000000-0000-0000-0000-0000000000b2', 7, 'output-modules',           '2.7',
   'Output Modules', 'handson', 'not_started', 35,
   'RGB, flash LED, dual-color, buzzer modules. Pre-built outputs that save wiring time.');

-- ───────────────────────── Phase 2 lessons (rich bodies) ─────
insert into public.lessons (id, module_id, "order", title, body_md) values
  -- 2.1 Sensor Fundamentals
  ('00000000-0000-0000-0000-00000000020c',
   (select id from public.modules where slug = 'sensor-fundamentals'),
   1,
   'Sensor Fundamentals',
   '## Analog vs digital — the first question

Every sensor on the 37-in-1 board belongs to one of two worlds. Knowing which one you''re holding tells you which Arduino pin type to use and which function to call.

<!-- ill:analog-vs-digital -->

| Trait | Analog | Digital |
|---|---|---|
| Signal | Smooth, any voltage 0–5V | Two states: HIGH (5V) or LOW (0V) |
| Arduino pin | A0–A5 | D2–D13 |
| Read with | `analogRead(pin)` → 0–1023 | `digitalRead(pin)` → HIGH / LOW |
| Kit examples | LDR, thermistor, sound, hall | tilt, reed, PIR, photo-interrupter |

Many modules expose **both** — an analog pin for the raw reading plus a digital pin that fires HIGH when the reading crosses a threshold set by a trim-pot on the module. Use the analog pin for measurement, digital for "did it cross the line".

## The ADC — how analog becomes a number

Arduino''s **10-bit ADC** quantises 0–5 V into 1024 discrete levels.

```
analogRead(A0) = round( V_pin / 5.0 × 1023 )
```

| V_pin | analogRead |
|---|---|
| 0.00 V | 0 |
| 1.25 V | ~256 |
| 2.50 V | ~512 |
| 5.00 V | 1023 |

> **Resolution:** ~4.9 mV per step. Enough for most hobby sensors; not enough for sub-millivolt precision (you''d use an external ADC like the ADS1115 for that).

## The voltage divider — sensor ↔ Arduino glue

Most analog sensors in the kit (LDR, thermistor, flame, linear hall) work by changing resistance. Arduino can''t read resistance directly — only voltage. You turn the resistance into a voltage with a **voltage divider**.

<!-- ill:voltage-divider -->

```
V_A0 = 5V × R_sensor / (R_reference + R_sensor)
```

- Bright room → LDR resistance drops → V_A0 drops → low `analogRead`
- Dark room → LDR resistance rises → V_A0 rises → high `analogRead`

Pick `R_reference` close to the sensor''s mid-range resistance. For a 10 KΩ photoresistor in typical room light, a 10 KΩ fixed resistor gives ~2.5 V at A0 — plenty of headroom in either direction.

## Pull-up / pull-down — digital sensor glue

Unconnected (floating) input pins pick up noise and flip randomly. Fix by tying them to a known voltage through a high-value resistor.

| Pattern | Rest state | On event | External R |
|---|---|---|---|
| **Pull-up** | HIGH (5V) | LOW | 10 KΩ to 5V, or `INPUT_PULLUP` |
| **Pull-down** | LOW (0V) | HIGH | 10 KΩ to GND |

Arduino has **built-in pull-ups**: `pinMode(pin, INPUT_PULLUP)`. Skip the external resistor unless you need a pull-**down** (external required — the Uno has no `INPUT_PULLDOWN`).

## Working with sensor modules (the boards on the 37-in-1)

Each module is a small PCB with the sensor plus supporting parts already wired. Common layouts:

| Pins | Meaning | Example modules |
|---|---|---|
| VCC · GND · D | 3-pin digital only | tilt, reed, flame-digital |
| VCC · GND · A | 3-pin analog only | LM35, linear hall |
| VCC · GND · D · A | 4-pin combined | sound, flame, gas |
| 5+ pins | Specialised (joystick, encoder) | |

The **onboard potentiometer** (small blue/white trim-pot) sets the digital threshold. Turn it with a screwdriver while watching the on-board indicator LED to calibrate.

## Takeaway

Before you touch any new sensor, answer three questions:

1. **Analog or digital output?** (Where does it plug in?)
2. **Does it need a voltage divider?** (Is the sensor a variable resistor?)
3. **Does the module have a threshold pot?** (Any calibration needed?)

The rest of Phase 2 uses these answers for every module you''ll meet.'),

  -- 2.2 Switches & Mechanical Sensors
  ('00000000-0000-0000-0000-00000000020d',
   (select id from public.modules where slug = 'switches-mechanical'),
   1,
   'Switches & Mechanical Sensors',
   '## Six ways to say "something just happened"

This module groups six purely-digital sensors — each one is essentially a switch that opens or closes under a specific physical stimulus.

| Sensor | Event | Output |
|---|---|---|
| **Tilt switch** | Orientation past threshold | LOW when tilted |
| **Reed switch** | Magnet nearby | LOW when magnet close |
| **Mercury switch** | Orientation (sensitive) | LOW when tilted |
| **Shock switch** | Sharp impact | Brief LOW pulse |
| **Knock sensor** | Tap on surface | Brief LOW pulse |
| **Photo-interrupter** | Beam broken | HIGH when blocked |

All of them plug in the same way: **VCC → 5V, GND → GND, D → any digital pin with `INPUT_PULLUP`**.

## The common pattern

```cpp
const uint8_t SENSOR = 2;  // any digital pin

void setup() {
  Serial.begin(9600);
  pinMode(SENSOR, INPUT_PULLUP);
}

void loop() {
  int state = digitalRead(SENSOR);
  Serial.println(state == LOW ? "triggered" : "resting");
  delay(50);
}
```

With `INPUT_PULLUP`, the pin reads HIGH when the switch is open, LOW when closed. Most modules also have an on-board **red indicator LED** that lights during an event — useful for wiring verification before you even write code.

## Edge detection — "turn this into an event, not a state"

A raw `digitalRead` loop prints "triggered" as long as the switch is pressed, which can be hundreds of times per second. You usually want the **transition** instead:

```cpp
int last = HIGH;

void loop() {
  int now = digitalRead(SENSOR);
  if (last == HIGH && now == LOW) {
    // just went active — log once
    Serial.println("event!");
  }
  last = now;
  delay(5);   // small debounce
}
```

Same pattern as the debounced button from Module 1.7 — just applied to a different physical trigger.

## Sensor-specific notes

**Tilt / mercury switches** are extremely simple — a conductive ball (or mercury droplet) completes a circuit when gravity points the right way. Mercury is more sensitive but the kit''s module uses a sealed capsule so it''s safe to handle.

**Reed switch** closes when a magnetic field crosses a threshold. Glue a small magnet to a door + the reed to the frame and you have a door-open sensor.

**Shock + knock** both output brief (5–50 ms) pulses. Use `attachInterrupt()` instead of polling if you need to catch every single event, since a `delay(50)` in the main loop might miss one.

**Photo-interrupter** has an IR LED + phototransistor facing each other across a 5 mm slot. Insert something opaque between them and the output flips. Classic use: a slotted disc on a motor shaft for RPM counting.

## Takeaway

Six switches, one wiring pattern, one code pattern. You''ve already written the code in Module 1.7 — now you''re pointing it at different physical events.'),

  -- 2.3 Analog Sensors
  ('00000000-0000-0000-0000-00000000020e',
   (select id from public.modules where slug = 'analog-sensors'),
   1,
   'Analog Sensors',
   '## The analog family

These sensors don''t say "on" or "off" — they give you a continuous voltage that tracks some physical quantity. Your job is to read it with `analogRead` and map it to something meaningful.

<!-- ill:voltage-divider -->

| Sensor | Measures | Voltage behavior |
|---|---|---|
| **Thermistor** (NTC) | Temperature | R drops as T rises → V_A0 rises |
| **Analog hall** | Magnetic field | ~2.5V at rest, deflects with polarity |
| **Linear hall** | Field gradient | Smooth ramp as magnet approaches |
| **Flame sensor** (analog) | IR around 760–1100 nm | Falls sharply near flame |
| **Sound sensor** | Noise envelope | Spikes on transient peaks |

## Reading pattern (works for all of them)

```cpp
const uint8_t PIN = A0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int raw = analogRead(PIN);         // 0-1023
  float volts = raw * (5.05 / 1023); // use your measured 5V!
  Serial.print(raw);
  Serial.print("  ");
  Serial.print(volts, 3);
  Serial.println(" V");
  delay(100);
}
```

## Thermistor: resistance → temperature

A 10 KΩ NTC thermistor + 10 KΩ reference gives you a simple divider. The Steinhart-Hart equation is the rigorous way to convert resistance to temperature, but for room-temp work a two-point linear fit is plenty:

```
raw at 25 °C (measured) = X
raw at ice water (~0 °C) = Y
T °C ≈ (raw − Y) / (X − Y) × 25
```

Calibrate once, use the linear fit forever. The DS18B20 (Module 2.5) does all of this for you in hardware if you need more precision.

## Hall sensors — finding a magnet

**Analog hall** outputs ~2.5 V with no magnet, rises toward 5 V with a N pole, drops toward 0 V with a S pole. Great for detecting *presence + polarity*.

**Linear hall** has a smoother gradient — better for measuring distance to a magnet (the closer, the more the voltage shifts). Useful for non-contact position sensing.

```cpp
int raw = analogRead(A0);
int signed_val = raw - 512;  // 0 = no field; ±512 = full deflection
```

## Flame sensor: not a thermometer

The flame module is an IR photodiode tuned to flame wavelengths. It doesn''t read temperature — it reads *infrared light*. Candles, lighters, and direct sunlight all trigger it.

- Low `analogRead` value near flame (photodiode pulled low)
- High value in normal light

Point it away from windows if you want reliable detection indoors.

## Sound sensor — instantaneous vs envelope

The electret mic picks up rapid pressure oscillations. The on-board op-amp gives you two useful outputs:

- **Analog pin** — the rectified envelope. Reads peak loudness.
- **Digital pin** — HIGH when the envelope crosses the trim-pot threshold.

For **clap detection**, poll the digital pin with a short debounce:

```cpp
if (digitalRead(SOUND_D) == HIGH) {
  Serial.println("clap!");
  delay(200);  // debounce — one clap = one event
}
```

## Takeaway

The voltage-divider pattern is doing the heavy lifting for every sensor here. Your calibration work is mostly: (1) measure the raw values at known conditions, (2) map those values to meaningful units with a simple linear formula.'),

  -- 2.4 IR Sensors & Line Following
  ('00000000-0000-0000-0000-00000000020f',
   (select id from public.modules where slug = 'ir-line-following'),
   1,
   'IR Sensors & Line Following',
   '## Invisible light, visible uses

Infrared (IR) is just light in the 700 nm – 1 mm range — too long-wavelength for human eyes, but perfect for short-range wireless signalling. Five modules in the kit use IR in different ways:

| Module | Pattern | Typical use |
|---|---|---|
| **IR emitter** | 940 nm LED driven by Arduino | Beam-break, remote transmit |
| **IR receiver** | 38 kHz demodulator IC | TV remote decode |
| **IR avoidance** | Emitter + receiver paired | Obstacle detection 2–30 cm |
| **IR line-tracking** | Emitter + receiver reflect off surface | Black line on white |
| **Laser module** | Red 650 nm laser diode | Beam-break over long range |

## IR avoidance — how it actually works

An on-board IR LED constantly emits 940 nm light. A nearby phototransistor is shaded from the direct LED output but picks up the *reflection* off any surface in front of the module.

- No surface → no reflection → phototransistor sees no IR → output HIGH
- Surface within range → reflection detected → output LOW

Calibration comes from the trim-pot on the module — turn it while waving your hand in front to set the trigger distance.

```cpp
const uint8_t AVOID = 2;
void setup() {
  pinMode(AVOID, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);
}
void loop() {
  digitalWrite(LED_BUILTIN, digitalRead(AVOID) == LOW ? HIGH : LOW);
}
```

## Line-tracking — robot vision for $2

Same IR-reflection trick, but aimed straight down at a surface. Black paint absorbs IR → low reflection → output one way. White paper reflects → output the other way.

Wire three tracking modules across the front of a robot chassis:

- All three see white → go straight
- Left sees black → line drifting left → steer left
- Right sees black → line drifting right → steer right

This is the classic "line-following robot" foundation.

## IR receiver — decoding a TV remote

The receiver module has a 38 kHz band-pass demodulator that filters out ambient IR and lets you read the pulse train from any standard remote.

Install the **IRremote** library (Library Manager → "IRremote"), then:

```cpp
#include <IRremote.hpp>

void setup() {
  Serial.begin(9600);
  IrReceiver.begin(2, ENABLE_LED_FEEDBACK);
}

void loop() {
  if (IrReceiver.decode()) {
    Serial.println(IrReceiver.decodedIRData.command, HEX);
    IrReceiver.resume();
  }
}
```

Press any button on any TV remote — a hex code prints. Different brands use different protocols but the library handles them all.

## Laser module

A focused 5 V red laser diode. From Arduino''s perspective it''s just an LED — `digitalWrite(pin, HIGH)` turns it on, `LOW` turns it off. PWM works too if you want to modulate it for a beam-break detector.

## Safety

Never shine the laser (or direct-line IR at close range) at eyes. The kit''s laser is low-power (Class 2, <1 mW) but still uncomfortable and, with sustained exposure, harmful.

## Takeaway

Every IR module is just "emit IR, look for reflection (or absence)". The module does the heavy lifting; your code only sees HIGH/LOW transitions. This is how surface-following robots, TV remotes, and many proximity sensors work under the hood.'),

  -- 2.5 Digital Environmental Sensors
  ('00000000-0000-0000-0000-000000000210',
   (select id from public.modules where slug = 'digital-environmental'),
   1,
   'Digital Environmental Sensors',
   '## "Just give me the number"

Analog sensors hand you a voltage — you''re responsible for calibration and conversion. **Digital environmental sensors** have their own ADC, their own calibration curve, and a microcontroller that talks to Arduino over a dedicated protocol.

You get **calibrated, ready-to-use values**. The cost: an extra library and one unusual wire.

| Sensor | Protocol | Outputs | Library |
|---|---|---|---|
| **DHT11** | Single-wire proprietary | Temp (±2°C), humidity (±5%) | `DHT sensor library` |
| **DS18B20** | 1-Wire | Temp (±0.5°C) | `OneWire` + `DallasTemperature` |
| **Heartbeat** | Analog output from IR reflectance | BPM (software-computed) | none needed |

## DHT11 — the cheap workhorse

- **Range:** 0–50°C, 20–90% RH
- **Rate:** 1 Hz max — don''t poll faster
- **Wiring:** VCC → 5V, GND → GND, DATA → any digital pin (module adds its own pull-up)

```cpp
#include <DHT.h>

DHT dht(2, DHT11);

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  float t = dht.readTemperature();
  float h = dht.readHumidity();
  if (!isnan(t)) {
    Serial.print(t);
    Serial.print("°C  ");
    Serial.print(h);
    Serial.println("%");
  }
  delay(2000);
}
```

The `isnan()` check matters — occasional bit-errors on the data line make `readTemperature()` return NaN. Retry in 2 seconds.

## DS18B20 — 1-Wire precision temperature

One signal wire, up to 100+ sensors on the same pin (each has a unique 64-bit address). You usually only have one, but the protocol is the same either way.

- **Range:** −55 to +125 °C
- **Resolution:** 9–12 bits, configurable (9-bit reads faster, 12-bit is more precise)
- **Wiring:** VCC → 5V, GND → GND, DATA → digital pin **with a 4.7 KΩ pull-up to 5V** (the kit module adds this on-board)

```cpp
#include <OneWire.h>
#include <DallasTemperature.h>

OneWire oneWire(2);
DallasTemperature sensors(&oneWire);

void setup() {
  Serial.begin(9600);
  sensors.begin();
}

void loop() {
  sensors.requestTemperatures();
  Serial.println(sensors.getTempCByIndex(0));
  delay(500);
}
```

## Heartbeat sensor — not quite medical

The module is a red/IR LED + phototransistor pair. Your finger modulates the reflectance with every pulse. Raw output is noisy — useful values come from **detecting peaks over a rolling window**.

```cpp
// Rough BPM detector — use PulseSensor library for real apps.
int raw = analogRead(A0);
// Look for rising edges above a threshold...
// Track peak-to-peak intervals...
// BPM = 60000 / interval_ms
```

For any real heart-rate work use the **PulseSensor Playground** library — it handles filtering, peak detection, and BPM output.

## Takeaway

Digital environmental sensors hide the hard parts (ADC, calibration, temperature compensation) behind a short wire and a library call. The trade-off is slower updates (DHT11 is 1 Hz, DS18B20 is 1–2 Hz at 12-bit resolution). For any "what is the temperature *right now*?" use-case, they''re the right answer.'),

  -- 2.6 User Input Modules
  ('00000000-0000-0000-0000-000000000211',
   (select id from public.modules where slug = 'user-input-modules'),
   1,
   'User Input Modules',
   '## Inputs beyond buttons

A single button is great for "do one thing". Building actual UI — menus, volume, precise aim — needs richer inputs.

| Module | Gives you | Best for |
|---|---|---|
| **Rotary encoder** | Direction + clicks + push | Volume, scroll, menu selection |
| **Joystick** | 2D position + button | Direction + confirm |
| **Touch sensor** | Digital HIGH on proximity | Invisible switches, capacitive UI |

## Rotary encoder — the infinite dial

Unlike a potentiometer, an encoder has **no end stops**. Rotate it forever in either direction — the module outputs two quadrature signals (A and B) plus a built-in momentary switch on press.

**Quadrature decoding** in one sentence: A and B are two square waves, 90° out of phase. The *order* they change tells you direction:

| A changes then B → | clockwise |
| B changes then A → | counter-clockwise |

Use the **Encoder** library (install via Library Manager):

```cpp
#include <Encoder.h>

Encoder enc(2, 3);   // CLK on pin 2, DT on pin 3

void setup() { Serial.begin(9600); }

void loop() {
  long pos = enc.read();  // monotonic count, ±
  Serial.println(pos);
  delay(50);
}
```

Each detent = 4 counts (encoder does 4 state transitions per click). Divide by 4 if you want detents-as-ticks.

## Joystick — 2 analog + 1 digital

The module has two 10 KΩ pots (X and Y axes) plus a push switch (SW) triggered by pressing down on the stick.

| Pin | Reads |
|---|---|
| VCC | 5V |
| GND | GND |
| VRx | A0 — X axis: 0 (left) … ~512 (center) … 1023 (right) |
| VRy | A1 — Y axis: 0 (up) … ~512 (center) … 1023 (down) |
| SW | D2 (with INPUT_PULLUP) — LOW when pressed |

**Centers are not exactly 512** — each joystick has a small offset. Calibrate by reading the values on power-up (before the user touches it) and using that as zero.

```cpp
int zeroX, zeroY;

void setup() {
  pinMode(2, INPUT_PULLUP);
  delay(100);                          // let pots settle
  zeroX = analogRead(A0);
  zeroY = analogRead(A1);
}

void loop() {
  int dx = analogRead(A0) - zeroX;     // ± relative to rest
  int dy = analogRead(A1) - zeroY;
  if (digitalRead(2) == LOW) Serial.println("click");
}
```

## Touch sensor — capacitive UI

The TTP223 touch module looks like a small metal pad. It has a built-in capacitive sense IC that measures the change in capacitance when a finger (or any grounded conductor) is nearby.

- VCC → 5V
- GND → GND
- SIG → digital pin — HIGH when touched

**Two modes** (set by jumper or pad on the back of the module):

| Mode | Behavior |
|---|---|
| **Momentary (default)** | HIGH while touched, LOW when released |
| **Toggle** | Flips state on each touch |

Great for invisible buttons behind a thin non-conductive layer — glue the pad to the underside of a plastic panel and the panel feels like it''s just part of the enclosure.

## Takeaway

Rotary encoder for *continuous* input, joystick for *2D direction*, touch sensor for *clean, moving-partless buttons*. Combine any two (encoder + touch = scroll-wheel with click) and you have a decent UI primitive.'),

  -- 2.7 Output Modules
  ('00000000-0000-0000-0000-000000000212',
   (select id from public.modules where slug = 'output-modules'),
   1,
   'Output Modules',
   '## Pre-wired outputs

Most of these exist so you don''t have to wire the same thing from scratch every time. A common-cathode RGB LED + three current-limiting resistors + a header is a tiny board — not a new electrical concept.

| Module | Control | Notes |
|---|---|---|
| **RGB LED module** | 3 PWM pins (R/G/B) | On-board resistors. Common-anode — LOW = on. |
| **7-color flash LED** | VCC + GND only | Auto-cycles colors. No Arduino control. |
| **Dual-color LED** | 2 digital or PWM pins | Red + green → yellow when both on. |
| **Passive buzzer module** | `tone(pin, freq)` | Same as the bare passive buzzer in 1.4. |

## RGB module — mixing colors with PWM

Three PWM pins, one per channel. On a **common-anode** module, `analogWrite(pin, 0)` is **full brightness** (current flows from VCC through the LED to ground via the pin). `analogWrite(pin, 255)` = off.

```cpp
const uint8_t R = 9, G = 10, B = 11;

void setup() {
  pinMode(R, OUTPUT); pinMode(G, OUTPUT); pinMode(B, OUTPUT);
}

void setColor(uint8_t r, uint8_t g, uint8_t b) {
  // Invert because this module is common-anode.
  analogWrite(R, 255 - r);
  analogWrite(G, 255 - g);
  analogWrite(B, 255 - b);
}

void loop() {
  setColor(255, 0, 0); delay(500);     // red
  setColor(0, 255, 0); delay(500);     // green
  setColor(0, 0, 255); delay(500);     // blue
  setColor(255, 128, 0); delay(500);   // orange
  setColor(128, 0, 255); delay(500);   // purple
}
```

If you wire the same code to a **common-cathode** RGB (less common but possible) the colors will be inverted — drop the `255 -` from the writes.

## 7-color flash LED — instant gratification

Two pins, no code. Connect VCC + GND and it auto-cycles through seven colors. Useful for:

- Testing 5V is reachable somewhere on your circuit
- Indicator you haven''t wired anything weird
- Quick "something''s alive" LED on a new build

Can''t be controlled from Arduino — the cycle is baked into a tiny on-board IC.

## Dual-color LED (red + green in one)

Two pins for two LEDs sharing one body. Classic uses:

| R on | G on | Perceived |
|---|---|---|
| ✗ | ✗ | Off |
| ✓ | ✗ | Red |
| ✗ | ✓ | Green |
| ✓ | ✓ | Yellow (orange-ish) |
| PWM | PWM | Anywhere on the red↔green spectrum |

Great for status indicators — "warming up" could be PWM-mixed orange, "ready" is green.

## Passive buzzer module vs the bare passive buzzer

Electrically the same — an unpowered piezo that only makes noise when you drive it with a square wave. The module adds a transistor + resistor + header for safety, but the Arduino-facing interface is identical to what you learned in Module 1.4:

```cpp
tone(BUZZER, 440);      // A4 note
delay(500);
noTone(BUZZER);
```

## When to use modules vs bare parts

| Use the module when… | Use bare parts when… |
|---|---|
| You''re prototyping quickly | You''re designing a custom board |
| The sensor needs supporting parts you don''t remember | You want minimum cost in volume |
| You want protection (reverse-polarity, ESD) | You understand the full circuit |

For Phase 2, **modules are the right call** — you''re learning sensors, not component layout. Phase 3+ may shift back to bare parts once you''re designing integrated projects.

## Takeaway

Modules package a sensor + its supporting circuitry into a 3-4 pin breakout. You write the same `digitalWrite` / `analogRead` / `analogWrite` / `tone` that you''ve been writing all along — the wiring just got a lot simpler.');

-- ───────────────────────── Phase 2 hands-on + safety + mappings ─────

-- 2.1 Sensor Fundamentals
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000020c', 1,
   'Write a sketch that reads A0 with nothing connected. Serial.println(analogRead(A0)) every 100 ms.',
   'Values jump wildly between 0 and 1023 — the pin is floating and picking up ambient noise. This is why inputs need to be tied to a known state.'),
  ('00000000-0000-0000-0000-00000000020c', 2,
   'Wire a simple voltage divider: 5V → 10KΩ → 10KΩ → GND. Tap the midpoint to A0. Read the value.',
   'Expect ~512 (half of 1023). Compute: V_A0 = 5V × 10K / 20K = 2.5V. Matches your meter''s DCV reading on the midpoint.'),
  ('00000000-0000-0000-0000-00000000020c', 3,
   'Replace the bottom 10KΩ with a photoresistor. Read A0 under three light levels: covered, room, flashlight.',
   'Covered: high resistance → high V_A0 (maybe 900+). Room: middle (~500). Flashlight: low resistance → low V_A0 (~100). Confirms the divider math.'),
  ('00000000-0000-0000-0000-00000000020c', 4,
   'Wire a tilt switch with INPUT_PULLUP on pin 2. Read in a loop. Flip the board on its side.',
   'Reads HIGH when upright, LOW when tilted (or vice versa depending on orientation). Without INPUT_PULLUP, the pin would float and jitter.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000020c', 1, 'info',
   'ADC is 10-bit on the Uno — 1024 levels across 5V = ~4.9 mV per step. If you need finer resolution, look up external ADCs like the ADS1115.'),
  ('00000000-0000-0000-0000-00000000020c', 2, 'caution',
   'Never connect a voltage higher than VCC (5V on the Uno) directly to an analog pin. Use a voltage divider to bring higher voltages down first.');

-- 2.2 Switches & Mechanical
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000020d', 1,
   'Wire a tilt switch to pin 2 with INPUT_PULLUP. Write code that prints "tilted" only on the transition LOW → HIGH (edge detection).',
   'One "tilted" print per physical tilt event, regardless of how long you hold it tilted. On-board indicator LED should also light during the tilt.'),
  ('00000000-0000-0000-0000-00000000020d', 2,
   'Swap in the reed switch module. Wave a fridge magnet near it while the code runs.',
   'Trigger fires once per magnet approach. Pulling the magnet away should re-arm it. Distance threshold: typically 1–2 cm.'),
  ('00000000-0000-0000-0000-00000000020d', 3,
   'Wire the knock sensor. Tap the breadboard sharply (not the module itself) and count events in a 5-second window.',
   'Each tap registers as one brief pulse. Too-light taps will be missed; consistent firm taps produce reliable counts.'),
  ('00000000-0000-0000-0000-00000000020d', 4,
   'Place an opaque object (a piece of paper) in and out of the photo-interrupter slot.',
   'Output flips each time the beam is broken. No debouncing needed — the transition is clean because there''s no mechanical contact.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000020d', 1, 'info',
   'Mercury switches in the kit are sealed — safe to handle — but treat them with respect. The mercury itself is toxic if the capsule breaks.'),
  ('00000000-0000-0000-0000-00000000020d', 2, 'caution',
   'Shock and knock pulses are very brief (5–50 ms). If you''re polling with a 100 ms delay, you WILL miss some. Use attachInterrupt() for accurate event counts.');

-- 2.3 Analog Sensors
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000020e', 1,
   'Wire a thermistor + 10KΩ fixed resistor as a voltage divider. Log raw analogRead at room temperature, then after cupping your hand around the thermistor for 30 seconds.',
   'Raw value rises by 30–80 counts with warmth. Proves the inverse-resistance behavior of the NTC thermistor.'),
  ('00000000-0000-0000-0000-00000000020e', 2,
   'Calibrate: log raw value at ice-water temp (~0°C) and at your hand temp (~34°C). Write a linear conversion.',
   'Two-point linear fit. Plug in a third temperature (like room air) and compare to a real thermometer — should be within 2-3°C.'),
  ('00000000-0000-0000-0000-00000000020e', 3,
   'Wire the analog hall sensor to A0. Read with no magnet, then hold a magnet near it with different orientations.',
   '~512 with no magnet. North pole increases the reading toward 1023; south pole decreases it toward 0.'),
  ('00000000-0000-0000-0000-00000000020e', 4,
   'Wire the flame sensor to A0. Read in normal room light, then hold a lit lighter 10 cm away (carefully).',
   'Raw value drops sharply near flame — flame IR saturates the photodiode. Candles, lighters, and direct sunlight all trigger it.'),
  ('00000000-0000-0000-0000-00000000020e', 5,
   'Wire the sound sensor''s analog output to A0 and digital output to D2. Clap near it while both are logged.',
   'Analog spikes on each clap. Digital goes HIGH when the envelope crosses the trim-pot threshold. Adjust the pot while clapping to dial in sensitivity.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000020e', 1, 'caution',
   'The flame sensor is tuned for infrared around 760–1100 nm — direct sunlight and incandescent bulbs will trigger it just like flames. Shield it for reliable fire-only detection.'),
  ('00000000-0000-0000-0000-00000000020e', 2, 'info',
   'Thermistor math uses the Steinhart-Hart equation for precision. For hobby use, a two-point linear fit works fine from 0–60°C.');

-- 2.4 IR Sensors & Line Following
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000020f', 1,
   'Wire the IR avoidance module. D → pin 2 with no INPUT_PULLUP (module drives it actively). Mirror the reading to LED_BUILTIN.',
   'On-board LED stays on when nothing is in front; LED_BUILTIN lights when you wave your hand within ~15 cm. Adjust the trim-pot to change the threshold.'),
  ('00000000-0000-0000-0000-00000000020f', 2,
   'Swap to the IR line-tracking module. Tape a strip of black electrical tape to a piece of white paper. Slide the module across.',
   'Output flips between HIGH and LOW at the tape edges. The white surface reflects IR well; the black tape absorbs it.'),
  ('00000000-0000-0000-0000-00000000020f', 3,
   'Install the IRremote library. Wire the IR receiver to pin 2. Point any TV or AC remote at it and press buttons.',
   'Hex codes scroll in Serial Monitor. Same button pressed twice = same hex code. Different buttons = different codes.'),
  ('00000000-0000-0000-0000-00000000020f', 4,
   'Wire the laser module to pin 8 via a 220Ω resistor. Add a simple Blink to toggle it on/off at 1 Hz.',
   'Red beam blinks visibly. Use the beam to break a photo-interrupter a meter away — you''ve built a long-range beam-break detector.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000020f', 1, 'danger',
   'Never shine the laser module (or direct-line IR at close range) at anyone''s eyes — including your own. The kit''s diode is low-power but still uncomfortable and, with sustained exposure, harmful.'),
  ('00000000-0000-0000-0000-00000000020f', 2, 'info',
   'The IR receiver demodulates at 38 kHz — remotes transmit bursts at that carrier frequency so ambient IR (sunlight, incandescent bulbs) gets filtered out. This is why one receiver works with every remote brand.');

-- 2.5 Digital Environmental Sensors
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000210', 1,
   'Install the DHT sensor library. Wire DHT11: VCC → 5V, GND → GND, DATA → pin 2. Print temperature + humidity every 2 seconds.',
   'Prints like "24.0°C  60%". Values update smoothly over minutes. Breathe on the sensor for 5 seconds — humidity should jump by 10%+.'),
  ('00000000-0000-0000-0000-000000000210', 2,
   'Install OneWire + DallasTemperature libraries. Wire the DS18B20 module to pin 2. Read + print temperature every 500 ms.',
   'Readings update 2× per second at 12-bit resolution. Compare to DHT11 at the same ambient — DS18B20 is typically within 0.2°C of the true value.'),
  ('00000000-0000-0000-0000-000000000210', 3,
   'Wire the heartbeat sensor''s analog output to A0. Place a fingertip on the IR surface. Log the raw value continuously.',
   'Raw value oscillates in a rhythmic pattern ~1 Hz matching your pulse. Peak-to-peak amplitude depends on finger pressure and placement.'),
  ('00000000-0000-0000-0000-000000000210', 4,
   'Extend step 3: detect peaks over a 2-second window and compute BPM = 60000 / average_interval_ms. Log only the BPM.',
   'BPM stabilises in the 60–90 range for most adults at rest. Inaccurate in the first few seconds — the moving window needs 3–4 beats to converge.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000210', 1, 'info',
   'DHT11 samples at 1 Hz max — polling faster returns NaN. Wrap readings in isnan() checks and retry after 2 seconds.'),
  ('00000000-0000-0000-0000-000000000210', 2, 'caution',
   'The heartbeat module is a teaching tool, not a medical device. For any real health monitoring use the PulseSensor Playground library on a proper MAX30102 sensor.');

-- 2.6 User Input Modules
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000211', 1,
   'Install the Encoder library. Wire the rotary encoder: CLK → pin 2, DT → pin 3, GND → GND, + → 5V. Print enc.read() as you turn.',
   'Clockwise increments in steps of 4 per detent; counter-clockwise decrements. Divide by 4 to get detent counts.'),
  ('00000000-0000-0000-0000-000000000211', 2,
   'Wire SW → pin 4 with INPUT_PULLUP. Use the encoder to pick from 3 Serial-printed options; press to "select" and print the chosen one.',
   'Each detent advances the selection; each press prints the current option. Feels like a menu dial.'),
  ('00000000-0000-0000-0000-000000000211', 3,
   'Wire the joystick: VRx → A0, VRy → A1, SW → pin 2. Calibrate center on setup(). Print dx, dy, and click events.',
   'At rest: dx and dy hover around 0 (±5). Full deflection: ±500. Pressing the stick prints "click" once per press.'),
  ('00000000-0000-0000-0000-000000000211', 4,
   'Wire the touch sensor''s SIG pin to pin 2 (no external resistor). Print state transitions.',
   'Transitions LOW → HIGH when you touch the pad. Try placing a sheet of paper between your finger and the pad — still triggers. A finger''s worth of capacitance wins through thin non-conductive material.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000211', 1, 'info',
   'Joystick center values drift per-unit (~±10 counts from 512). Always calibrate on boot by reading once before the user touches it.');

-- 2.7 Output Modules
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000212', 1,
   'Wire the RGB module: R → 9, G → 10, B → 11, GND. Fade through the color wheel with analogWrite() (common-anode: 0 = on).',
   'Smooth color transitions. No single channel at max too long (you''ll see it dominates). All three at 255 = dark if common-anode; swap to 0 for white.'),
  ('00000000-0000-0000-0000-000000000212', 2,
   'Power the 7-color flash LED with VCC + GND only. No Arduino code.',
   'LED auto-cycles through 7 hues on a fixed timer. Useful for a "power is live" indicator without code.'),
  ('00000000-0000-0000-0000-000000000212', 3,
   'Wire the dual-color LED: R → pin 9 (PWM), G → pin 10 (PWM). Cycle red-only, green-only, both, then a smooth fade between.',
   'Both on = orange/yellow. PWM-mixed values produce every shade between red and green. Useful for "warming up / ready / overheat" indicators.'),
  ('00000000-0000-0000-0000-000000000212', 4,
   'Wire the passive buzzer module to pin 8. Play a 5-note scale using tone(pin, freq, duration).',
   'Five distinct notes. If it''s a single buzz regardless of frequency, you have the active module — swap to the passive one (check the label on the bottom PCB).');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000212', 1, 'info',
   'Most RGB LED modules in the 37-in-1 are common-anode — LOW = on, HIGH = off. Check the silkscreen; if you see "CA" it''s common-anode.'),
  ('00000000-0000-0000-0000-000000000212', 2, 'caution',
   'Driving bare RGB LEDs without current-limiting resistors will kill them. The module has resistors on-board; if you swap to a bare RGB LED, add three 220Ω resistors.');

-- ───────────────────────── Phase 2 lesson ↔ components ─────
insert into public.lesson_components (lesson_id, component_slug, "order") values
  -- 2.1 Sensor Fundamentals — equipment + a couple of sensors as teaching examples
  ('00000000-0000-0000-0000-00000000020c', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000020c', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000020c', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000020c', 'multimeter',       4),
  ('00000000-0000-0000-0000-00000000020c', 'resistor',         5),
  ('00000000-0000-0000-0000-00000000020c', 'photoresistor',    6),
  ('00000000-0000-0000-0000-00000000020c', 'tilt-switch',      7),

  -- 2.2 Switches & Mechanical
  ('00000000-0000-0000-0000-00000000020d', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000020d', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000020d', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000020d', 'tilt-switch',      4),
  ('00000000-0000-0000-0000-00000000020d', 'reed-switch',      5),
  ('00000000-0000-0000-0000-00000000020d', 'mercury-switch',   6),
  ('00000000-0000-0000-0000-00000000020d', 'shock-switch',     7),
  ('00000000-0000-0000-0000-00000000020d', 'knock-sensor',     8),
  ('00000000-0000-0000-0000-00000000020d', 'photo-interrupter',9),

  -- 2.3 Analog Sensors
  ('00000000-0000-0000-0000-00000000020e', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000020e', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000020e', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000020e', 'multimeter',       4),
  ('00000000-0000-0000-0000-00000000020e', 'resistor',         5),
  ('00000000-0000-0000-0000-00000000020e', 'thermistor',       6),
  ('00000000-0000-0000-0000-00000000020e', 'analog-hall',      7),
  ('00000000-0000-0000-0000-00000000020e', 'linear-hall',      8),
  ('00000000-0000-0000-0000-00000000020e', 'flame-sensor',     9),
  ('00000000-0000-0000-0000-00000000020e', 'sound-sensor',    10),

  -- 2.4 IR Sensors & Line Following
  ('00000000-0000-0000-0000-00000000020f', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000020f', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000020f', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000020f', 'resistor',         4),
  ('00000000-0000-0000-0000-00000000020f', 'ir-emitter',       5),
  ('00000000-0000-0000-0000-00000000020f', 'ir-receiver',      6),
  ('00000000-0000-0000-0000-00000000020f', 'ir-avoidance',     7),
  ('00000000-0000-0000-0000-00000000020f', 'ir-tracking',      8),
  ('00000000-0000-0000-0000-00000000020f', 'laser-module',     9),
  ('00000000-0000-0000-0000-00000000020f', 'photo-interrupter',10),

  -- 2.5 Digital Environmental Sensors
  ('00000000-0000-0000-0000-000000000210', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-000000000210', 'breadboard',       2),
  ('00000000-0000-0000-0000-000000000210', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-000000000210', 'dht11',            4),
  ('00000000-0000-0000-0000-000000000210', 'ds18b20',          5),
  ('00000000-0000-0000-0000-000000000210', 'heartbeat-sensor', 6),

  -- 2.6 User Input Modules
  ('00000000-0000-0000-0000-000000000211', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-000000000211', 'breadboard',       2),
  ('00000000-0000-0000-0000-000000000211', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-000000000211', 'rotary-encoder',   4),
  ('00000000-0000-0000-0000-000000000211', 'joystick',         5),
  ('00000000-0000-0000-0000-000000000211', 'touch-sensor',     6),

  -- 2.7 Output Modules
  ('00000000-0000-0000-0000-000000000212', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-000000000212', 'breadboard',       2),
  ('00000000-0000-0000-0000-000000000212', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-000000000212', 'resistor',         4),
  ('00000000-0000-0000-0000-000000000212', 'rgb-module',       5),
  ('00000000-0000-0000-0000-000000000212', 'flash-led',        6),
  ('00000000-0000-0000-0000-000000000212', 'dual-color-led',   7),
  ('00000000-0000-0000-0000-000000000212', 'buzzer',           8)
on conflict do nothing;

-- ═══════════════════════════════════════════════════════════════════
-- ══════════════════ PHASE 3 — MULTI-SENSOR PROJECTS ════════════════
-- ═══════════════════════════════════════════════════════════════════

-- ───────────────────────── Phase 3 modules ─────
-- 3.1 is "preview" to unlock the phase. Each project builds on Phase 1 patterns + Phase 2 sensors.
insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b3', 1, 'project-design-patterns', '3.1',
   'Project Design Patterns', 'theory', 'preview', 25,
   'Sensor → Logic → Output. State machines, non-blocking architecture, and the debug habits every multi-sensor project needs.'),
  ('00000000-0000-0000-0000-0000000000b3', 2, 'weather-station',         '3.2',
   'Weather Station', 'project', 'not_started', 60,
   'DHT11 + LDR + button. Print temperature, humidity, and ambient-light category on a rolling update — with min/max tracking.'),
  ('00000000-0000-0000-0000-0000000000b3', 3, 'motion-activated-light',  '3.3',
   'Motion-Activated Light', 'project', 'not_started', 45,
   'IR avoidance + LDR + LED. Light only comes on when it''s dark AND someone is moving. Configurable timeout.'),
  ('00000000-0000-0000-0000-0000000000b3', 4, 'remote-controlled-lamp',  '3.4',
   'Remote-Controlled RGB Lamp', 'project', 'not_started', 50,
   'IR receiver + RGB module + potentiometer. Pick a colour with remote buttons, adjust brightness with the knob.'),
  ('00000000-0000-0000-0000-0000000000b3', 5, 'secret-knock-lock',       '3.5',
   'Secret-Knock Detector', 'project', 'not_started', 55,
   'Knock sensor + button + LED. Record a rhythm, match it within tolerance. Green = unlock, red = denied.'),
  ('00000000-0000-0000-0000-0000000000b3', 6, 'reaction-time-game',      '3.6',
   'Reaction Time Game', 'project', 'not_started', 45,
   'Button + LED + buzzer + pot. Random delay, flash, measure your reflex time. Best-of-5 scoring.');

-- ───────────────────────── Phase 3 lessons (rich bodies) ─────
insert into public.lessons (id, module_id, "order", title, body_md) values
  -- 3.1 Project Design Patterns
  ('00000000-0000-0000-0000-00000000030c',
   (select id from public.modules where slug = 'project-design-patterns'),
   1,
   'Project Design Patterns',
   '## From lesson to project

Phase 2 taught you sensors one at a time. A project is different: **multiple sensors feeding into one piece of logic that drives multiple outputs, running forever without freezing.** Same code patterns, more coordination.

<!-- ill:project-flow -->

Every Phase 3 project follows the same skeleton:

1. **Sensors** — read them as quickly as the sensor allows (DHT11 = 1 Hz, analog = 100 Hz easy)
2. **Logic** — decide what just happened and what to do next
3. **Outputs** — drive an LED, buzzer, servo, or Serial line
4. **Feedback** — the output may change future sensor readings (fan cools temp, light changes LDR)

## State machines — the #1 pattern

Most projects are "the device behaves differently depending on what mode it''s in". That''s a state machine.

```cpp
enum State { IDLE, RECORDING, PLAYING_BACK };
State state = IDLE;
unsigned long stateEntered = 0;

void enterState(State s) {
  state = s;
  stateEntered = millis();
  Serial.print("→ state: "); Serial.println(s);
}

void loop() {
  switch (state) {
    case IDLE:        handleIdle();       break;
    case RECORDING:   handleRecording();  break;
    case PLAYING_BACK: handlePlayback();  break;
  }
}
```

Every `case` handler is small: check its sensors, decide if conditions warrant a state change, call `enterState()` if so. Never put `delay()` inside a handler — use `millis() - stateEntered` for timing.

## Non-blocking architecture

Phase 1.7 taught you `millis()` instead of `delay()`. In a project, this isn''t optional. Any `delay(100)` freezes every sensor read for 100 ms — you miss button presses, sensor events, and Serial commands.

**Rule of thumb:** `delay()` is allowed in `setup()` and in one-shot startup code. Never in `loop()` or anything it calls.

## The debug habit

Print every state transition. Print every sensor event. Print nothing during steady state.

```cpp
if (state != last_state) {
  Serial.print("state ");
  Serial.print(last_state);
  Serial.print(" → ");
  Serial.println(state);
  last_state = state;
}
```

When something goes wrong, the Serial log tells you *exactly* where the logic stopped behaving. Without these prints, debugging means rebuilding the circuit mentally from scratch.

## Testing methodology

1. **Build the skeleton first** — empty handlers that just print their state name. Upload. Verify states transition as you trigger inputs.
2. **Add one output at a time** — wire the buzzer, test it beeps on state entry. Then wire the RGB. Then the servo.
3. **Add each sensor in isolation** — unplug everything else, test the new sensor reads the way you expect.
4. **Combine** — now the full system. Bugs at this stage are almost always **wiring**, not logic, because the pieces worked alone.

## Takeaway

A project isn''t a bigger lesson. It''s a coordination problem: making 3–5 small subsystems agree on what''s happening *right now*. State machines + `millis()` + Serial debug are the three tools that make it tractable.'),

  -- 3.2 Weather Station
  ('00000000-0000-0000-0000-00000000030d',
   (select id from public.modules where slug = 'weather-station'),
   1,
   'Weather Station',
   '## The project

Build a desk-top weather station that prints a single line of live readings every 2 seconds:

```
23.5°C  58%  room-light  |  min 22.1°C  max 25.3°C  since boot
```

Three sensors, one button, one combined output. The patterns here (timed polling, min/max tracking, unit-toggle via button) show up in *every* project that follows.

## Parts

| Part | Role |
|---|---|
| DHT11 | Temperature + humidity — the headline reading |
| Photoresistor (LDR) + 10 KΩ | Light level via voltage divider |
| Tactile button | Toggle units °C ↔ °F |
| Arduino Uno | Everything runs here |

## Wiring

```
DHT11:   VCC → 5V, GND → GND, DATA → D2
LDR:     5V → 10KΩ → A0 → LDR → GND
Button:  D3 ↔ GND (INPUT_PULLUP handles the other side)
```

<!-- ill:voltage-divider -->

## The code shape

```cpp
#include <DHT.h>

DHT dht(2, DHT11);
const uint8_t LDR = A0;
const uint8_t BTN = 3;

bool fahrenheit = false;
float tMin = 999, tMax = -999;
unsigned long lastRead = 0;
unsigned long lastPress = 0;

void setup() {
  Serial.begin(9600);
  dht.begin();
  pinMode(BTN, INPUT_PULLUP);
}

void loop() {
  handleButton();
  if (millis() - lastRead >= 2000) readAndPrint();
}

void handleButton() {
  if (digitalRead(BTN) == LOW && millis() - lastPress > 200) {
    fahrenheit = !fahrenheit;
    lastPress = millis();
    Serial.print("→ units: ");
    Serial.println(fahrenheit ? "°F" : "°C");
  }
}

void readAndPrint() {
  lastRead = millis();
  float t = dht.readTemperature();
  float h = dht.readHumidity();
  int lightRaw = analogRead(LDR);
  if (isnan(t) || isnan(h)) { Serial.println("[DHT read failed]"); return; }

  tMin = min(tMin, t);
  tMax = max(tMax, t);

  Serial.print(fahrenheit ? t * 9/5 + 32 : t);
  Serial.print(fahrenheit ? "°F  " : "°C  ");
  Serial.print(h); Serial.print("%  ");
  Serial.print(classifyLight(lightRaw));
  Serial.print("  |  min ");
  Serial.print(fahrenheit ? tMin * 9/5 + 32 : tMin);
  Serial.print("  max ");
  Serial.println(fahrenheit ? tMax * 9/5 + 32 : tMax);
}

const char* classifyLight(int raw) {
  if (raw < 200) return "dark";
  if (raw < 500) return "dim";
  if (raw < 850) return "room-light";
  return "bright";
}
```

## Why it works

- **Non-blocking** — `handleButton()` runs every loop so presses feel instant; `readAndPrint()` self-throttles to 2 Hz via a `millis()` check.
- **DHT11 polling rate** — matches the sensor''s 1 Hz max.
- **Min/max tracking** — two floats, updated each read. Cheap.
- **Unit toggle** — one `bool` + a conditional at print time. No recalculation.
- **LDR classification** — simple thresholds. Tune them by reading your raw values in different rooms.

## Takeaway

You''ve just combined three Phase 2 patterns (digital sensor library, voltage divider, debounced button) into one cohesive device. Every later project reuses this skeleton.'),

  -- 3.3 Motion-Activated Light
  ('00000000-0000-0000-0000-00000000030e',
   (select id from public.modules where slug = 'motion-activated-light'),
   1,
   'Motion-Activated Light',
   '## The project

A light that only comes on when **both** conditions are met:
- It''s dark enough to need light (LDR reading below threshold)
- Someone is moving nearby (IR avoidance module triggers)

Stays on for a configurable timeout after the last motion, then fades off. This is the logic behind hallway/stairway auto-lights, but you''re building it from first principles.

## Parts

| Part | Role |
|---|---|
| IR avoidance module | Motion trigger (LOW = obstacle detected) |
| Photoresistor + 10 KΩ | Ambient light sensing |
| LED + 220Ω | Output (replace with a relay for real bulbs later) |

## The conditional logic

```
      dark?        motion?      → lamp
────────────────────────────────────────
      yes          yes          → ON, reset timeout
      yes          no           → ON while within timeout, else OFF
      no           yes          → OFF (it''s bright, don''t bother)
      no           no           → OFF
```

## The code

```cpp
const uint8_t LDR_PIN = A0;
const uint8_t PIR_PIN = 2;
const uint8_t LED_PIN = 9;   // PWM for fade

const int DARK_THRESHOLD = 400;
const unsigned long TIMEOUT = 10000;  // 10 s

unsigned long lastMotion = 0;

void setup() {
  Serial.begin(9600);
  pinMode(PIR_PIN, INPUT);
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  bool dark   = analogRead(LDR_PIN) < DARK_THRESHOLD;
  bool motion = digitalRead(PIR_PIN) == LOW;  // module is active-low

  if (motion) {
    lastMotion = millis();
    Serial.println("motion!");
  }

  bool recent = (millis() - lastMotion) < TIMEOUT;

  if (dark && recent) {
    analogWrite(LED_PIN, 255);
  } else {
    analogWrite(LED_PIN, 0);
  }
}
```

## Improvements to try

- **Fade** — instead of snap-on, ramp `analogWrite` over 300 ms. Smoother feel.
- **Trim pot on threshold** — feed `DARK_THRESHOLD` from a second analog pin so you can calibrate live.
- **Replace LED with a relay** — drive an AC lamp (**only** with proper mains safety per Module 1.4''s relay warning).
- **Debounce motion** — require 3 triggers in 2 seconds instead of 1, to reject flicker.

## Takeaway

Two simple sensors + one conditional = behavior that feels *smart*. The "debounced with a timeout" pattern (keep the output asserted for N seconds after the last trigger) shows up everywhere — security lights, bathroom fans, hand dryers.'),

  -- 3.4 Remote-Controlled RGB Lamp
  ('00000000-0000-0000-0000-00000000030f',
   (select id from public.modules where slug = 'remote-controlled-lamp'),
   1,
   'Remote-Controlled RGB Lamp',
   '## The project

Pick up any TV or AC remote. Press number keys 1–7 and the lamp switches colour. Turn a physical knob and it adjusts overall brightness. Press `0` to turn off.

This is **input translation**: converting IR codes + analog positions into LED states.

## Parts

| Part | Role |
|---|---|
| IR receiver module | Decodes remote button codes |
| RGB LED module | Three PWM channels for R/G/B |
| Potentiometer | Global brightness (0-100%) |
| Arduino Uno | Maps codes to colors |

## Step 1 — learn your remote

Every remote outputs different codes. Run this sketch and write down the hex code your remote''s "1", "2", "3"... buttons emit.

```cpp
#include <IRremote.hpp>

void setup() {
  Serial.begin(9600);
  IrReceiver.begin(2, ENABLE_LED_FEEDBACK);
}

void loop() {
  if (IrReceiver.decode()) {
    Serial.println(IrReceiver.decodedIRData.command, HEX);
    IrReceiver.resume();
  }
}
```

You''ll get a hex value per button, e.g. `16` for "1", `17` for "2", etc. These vary between remotes.

## Step 2 — the colour table

```cpp
struct Preset { uint8_t key; uint8_t r, g, b; };

Preset PRESETS[] = {
  // Fill in YOUR codes from step 1.
  { 0x16, 255,   0,   0 },   // 1 → red
  { 0x17, 255, 165,   0 },   // 2 → orange
  { 0x18, 255, 255,   0 },   // 3 → yellow
  { 0x19,   0, 255,   0 },   // 4 → green
  { 0x1A,   0, 255, 255 },   // 5 → cyan
  { 0x1B,   0,   0, 255 },   // 6 → blue
  { 0x1C, 128,   0, 255 },   // 7 → violet
  { 0x15,   0,   0,   0 },   // 0 → off
};
const size_t N = sizeof(PRESETS) / sizeof(PRESETS[0]);
```

## Step 3 — combine it all

```cpp
#include <IRremote.hpp>

const uint8_t R = 9, G = 10, B = 11;  // PWM
const uint8_t POT = A0;
uint8_t curR = 0, curG = 0, curB = 0;

void setColor(uint8_t r, uint8_t g, uint8_t b) {
  float brightness = analogRead(POT) / 1023.0;
  // Common-anode RGB module: LOW = on, so we invert.
  analogWrite(R, 255 - r * brightness);
  analogWrite(G, 255 - g * brightness);
  analogWrite(B, 255 - b * brightness);
}

void setup() {
  Serial.begin(9600);
  IrReceiver.begin(2, ENABLE_LED_FEEDBACK);
  pinMode(R, OUTPUT); pinMode(G, OUTPUT); pinMode(B, OUTPUT);
  setColor(0, 0, 0);
}

void loop() {
  // Re-apply on every loop so pot changes affect brightness immediately.
  setColor(curR, curG, curB);

  if (IrReceiver.decode()) {
    uint8_t code = IrReceiver.decodedIRData.command;
    for (size_t i = 0; i < N; i++) {
      if (PRESETS[i].key == code) {
        curR = PRESETS[i].r;
        curG = PRESETS[i].g;
        curB = PRESETS[i].b;
        Serial.print("preset "); Serial.println(code, HEX);
      }
    }
    IrReceiver.resume();
  }
}
```

## Takeaway

Three independent input streams (IR codes, pot position, time) combined into one output. The pattern of "re-apply outputs every loop from current state" keeps the pot feeling instantly responsive even though codes only arrive when you press a remote button.'),

  -- 3.5 Secret-Knock Detector
  ('00000000-0000-0000-0000-000000000310',
   (select id from public.modules where slug = 'secret-knock-lock'),
   1,
   'Secret-Knock Detector',
   '## The project

Knock a rhythm on the breadboard. The Arduino compares it to a stored pattern. Green LED + chirp = match; red LED + buzz = denied.

This is your first **pattern recognition** project. The "sensor" is a timing sequence, not a steady value.

## Parts

| Part | Role |
|---|---|
| Knock sensor (piezo) | Detects taps |
| Button | Enters "learn new pattern" mode |
| Green LED + 220Ω | Success indicator |
| Red LED + 220Ω | Failure indicator |
| Passive buzzer | Audible feedback |

## State machine

```
IDLE ── (sensor spike) ──→ RECORDING
  ↑                          │
  │ (timeout / complete)     │
  └──────────────────────────┘
       ↓
   VERIFYING → MATCH / NO MATCH → IDLE
```

## The pattern data

A "knock" is a moment in time. A "pattern" is the sequence of gaps between knocks:

```
Stored:   [500, 500, 1000, 500]   // 4 knocks: short-short-LONG-short
Heard:    [520, 480,  990, 540]   // close enough!
```

Matching = compare each gap with a tolerance (e.g., ±30%). Count and gap-count must also match.

## The code skeleton

```cpp
const uint8_t KNOCK = A0;
const uint8_t BTN_LEARN = 2;
const uint8_t LED_OK = 3;
const uint8_t LED_BAD = 4;
const uint8_t BUZZER = 5;

const int THRESHOLD = 30;             // raw reading threshold
const unsigned long KNOCK_TIMEOUT = 2000;  // end of pattern silence
const float TOLERANCE = 0.30;         // ±30%

unsigned long taps[10];      // timestamps
uint8_t nTaps = 0;
unsigned long lastTap = 0;
int pattern[9];              // stored gaps (nTaps - 1)
uint8_t patternLen = 0;
bool learning = false;

void setup() {
  Serial.begin(9600);
  pinMode(BTN_LEARN, INPUT_PULLUP);
  pinMode(LED_OK, OUTPUT);
  pinMode(LED_BAD, OUTPUT);
}

void loop() {
  if (digitalRead(BTN_LEARN) == LOW) {
    learning = true;
    nTaps = 0;
    Serial.println("learning...");
  }

  if (analogRead(KNOCK) > THRESHOLD && millis() - lastTap > 80) {
    taps[nTaps++] = millis();
    lastTap = millis();
    Serial.print("knock "); Serial.println(nTaps);
  }

  if (nTaps > 0 && millis() - lastTap > KNOCK_TIMEOUT) {
    // End of pattern — decide what to do.
    if (learning) storePattern();
    else          verifyPattern();
    nTaps = 0;
    learning = false;
  }
}

void storePattern() {
  patternLen = nTaps - 1;
  for (uint8_t i = 0; i < patternLen; i++) pattern[i] = taps[i + 1] - taps[i];
  Serial.println("stored!");
  tone(BUZZER, 1000, 200);
  digitalWrite(LED_OK, HIGH); delay(300); digitalWrite(LED_OK, LOW);
}

void verifyPattern() {
  if (nTaps - 1 != patternLen) return fail();
  for (uint8_t i = 0; i < patternLen; i++) {
    int gap = taps[i + 1] - taps[i];
    float ratio = (float)gap / pattern[i];
    if (ratio < 1 - TOLERANCE || ratio > 1 + TOLERANCE) return fail();
  }
  // match
  tone(BUZZER, 1500, 150);
  digitalWrite(LED_OK, HIGH); delay(500); digitalWrite(LED_OK, LOW);
  Serial.println("MATCH");
}

void fail() {
  tone(BUZZER, 300, 400);
  digitalWrite(LED_BAD, HIGH); delay(500); digitalWrite(LED_BAD, LOW);
  Serial.println("no match");
}
```

## Tweaks worth making

- **EEPROM storage** — `EEPROM.put(0, pattern)` survives power-off. Otherwise the pattern resets on every boot.
- **Servo latch** — swap the success LED for a servo that rotates 90° to "unlock" a small latch.
- **Visual countdown** — blink the buzzer/LED twice to signal "ready for pattern" before listening.

## Takeaway

Pattern matching boils down to: collect events + timestamps → compute intervals → compare to a reference. This same approach (tolerance on ratios, not absolute ms) is how rhythm games and gesture recognition work.'),

  -- 3.6 Reaction Time Game
  ('00000000-0000-0000-0000-000000000311',
   (select id from public.modules where slug = 'reaction-time-game'),
   1,
   'Reaction Time Game',
   '## The project

Arduino says "ready", waits a random moment, flashes the LED + beeps. You press the button. Arduino prints your reaction time in milliseconds. Best-of-5 gets logged. False starts (pressing before the LED) subtract time.

This is your first **game loop** — timing measurements, scoring, and multiple rounds.

## Parts

| Part | Role |
|---|---|
| Tactile button (INPUT_PULLUP) | Player input |
| LED + 220Ω | Visual cue |
| Passive buzzer | Audible cue + confirmation |
| Potentiometer | Difficulty (random-wait range) |

## State machine

```
IDLE      "press button to start"
WAITING   random 1–5 s delay (no early press!)
ACTIVE    LED + beep, timer starts
RESULT    button pressed — record time, return to IDLE
FAIL      pressed during WAITING — false start, return to IDLE
```

## The code

```cpp
const uint8_t BTN = 2;
const uint8_t LED = 9;
const uint8_t BUZZER = 8;
const uint8_t DIFF_POT = A0;

enum State { IDLE, WAITING, ACTIVE, RESULT, FAIL };
State state = IDLE;
unsigned long stateEntered = 0;
unsigned long waitUntil = 0;
int history[5] = {0};
uint8_t roundIdx = 0;

void setup() {
  Serial.begin(9600);
  pinMode(BTN, INPUT_PULLUP);
  pinMode(LED, OUTPUT);
  Serial.println("press button to start");
}

void enter(State s) {
  state = s;
  stateEntered = millis();
}

void loop() {
  bool pressed = (digitalRead(BTN) == LOW);

  switch (state) {
    case IDLE:
      if (pressed) {
        int diffMax = map(analogRead(DIFF_POT), 0, 1023, 2000, 5000);
        waitUntil = millis() + random(1000, diffMax);
        Serial.println("wait...");
        enter(WAITING);
      }
      break;

    case WAITING:
      if (pressed) {
        Serial.println("TOO SOON!");
        tone(BUZZER, 200, 400);
        enter(FAIL);
      } else if (millis() >= waitUntil) {
        digitalWrite(LED, HIGH);
        tone(BUZZER, 1500, 80);
        enter(ACTIVE);
      }
      break;

    case ACTIVE:
      if (pressed) {
        int t = millis() - stateEntered;
        Serial.print("reaction: "); Serial.print(t); Serial.println(" ms");
        history[roundIdx++ % 5] = t;
        digitalWrite(LED, LOW);
        if (roundIdx >= 5) printSummary();
        enter(RESULT);
      }
      break;

    case RESULT:
    case FAIL:
      if (millis() - stateEntered > 1500 && !pressed) enter(IDLE);
      break;
  }
}

void printSummary() {
  int best = 9999, sum = 0;
  for (int t : history) { if (t > 0 && t < best) best = t; sum += t; }
  Serial.print("best: "); Serial.print(best);
  Serial.print("  avg: "); Serial.println(sum / 5);
  roundIdx = 0;
}
```

## Good numbers

- **Typical human reaction** to visual cue: 200–250 ms
- **Audible cue**: 150–200 ms (faster)
- **Fast gamer territory**: sub-200 ms

Beat 150 and you''re statistically excellent. Sub-100 = you cheated.

## Stretch additions

- **RGB instead of LED** — color codes the cue type (red = visual only, blue = audio+visual)
- **Score saving** — EEPROM + per-session best
- **Two-player mode** — two buttons, whoever presses first wins each round

## Takeaway

You''ve built a multi-state system with real-time measurement, input validation (false-start detection), and rolling history. Every pattern here scales directly to rhythm games, arcade machines, and precision timing tests.');

-- ───────────────────────── Phase 3 hands-on + safety + mappings ─────

-- 3.1 Project Design Patterns
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000030c', 1,
   'Pick one of the Phase 3 projects (weather station, knock lock, reaction game). On paper, draw a block diagram with three boxes: SENSORS, LOGIC, OUTPUTS. Connect them with arrows.',
   'A diagram that fits on one sheet. Each box lists 2–4 items. Arrows show which direction data flows.'),
  ('00000000-0000-0000-0000-00000000030c', 2,
   'List the state machine for your chosen project. Three to six states. For each state, write one sentence for "what it does" and one for "how it exits".',
   'Enum-like list. Every state has an entry condition and an exit condition. No orphan states.'),
  ('00000000-0000-0000-0000-00000000030c', 3,
   'Write the C++ skeleton: an `enum State`, a `State state` variable, a `loop()` with a `switch`. Each case is a stub that Serial.println its own name.',
   'Code compiles. When you upload and open Serial Monitor, you see the starting state''s name printed. No real sensors yet.'),
  ('00000000-0000-0000-0000-00000000030c', 4,
   'Add one manual transition: pressing a button moves the state forward. Verify in Serial that state changes propagate only on button edges, not continuously.',
   'Each single press → one state-transition line in Serial. Holding the button shouldn''t spam transitions.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000030c', 1, 'info',
   'Projects fail most often at the seams between states. Draw the transitions BEFORE wiring anything — fixing a broken diagram is free; rewiring is slow.'),
  ('00000000-0000-0000-0000-00000000030c', 2, 'caution',
   'Avoid `delay()` anywhere inside `loop()` or its callees. One sneaky 500 ms delay means a button press feels unresponsive half the time.');

-- 3.2 Weather Station
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000030d', 1,
   'Install the DHT sensor library. Wire DHT11 to pin 2. Print temperature + humidity every 2 seconds.',
   'Readings update reliably. If you see NaN, you''re polling faster than 1 Hz — add the 2-second gate.'),
  ('00000000-0000-0000-0000-00000000030d', 2,
   'Add an LDR voltage divider (5V → 10KΩ → A0 → LDR → GND). Classify into dark / dim / room / bright based on raw readings at each light level.',
   'Write down raw values for each category — this is your per-environment calibration. Thresholds in code should come from YOUR readings, not generic numbers.'),
  ('00000000-0000-0000-0000-00000000030d', 3,
   'Merge into one compact output line: `23.5°C  58%  room-light`. Use `Serial.print` without newlines until the end.',
   'One line every 2 seconds with all three readings. Easy to paste into a spreadsheet later.'),
  ('00000000-0000-0000-0000-00000000030d', 4,
   'Track min and max temperature since boot. Print them after the live reading.',
   'Min/max update only when a new extreme shows up. Min stays at the coldest temp you''ve seen, max at the warmest.'),
  ('00000000-0000-0000-0000-00000000030d', 5,
   'Add a debounced button on pin 3. Press flips the display between °C and °F.',
   'Single press → single toggle. Held button doesn''t flicker. Serial line immediately shows the new unit.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000030d', 1, 'info',
   'DHT11 is ±2°C accuracy. For actual weather-logging fidelity, swap to DHT22 or DS18B20 (same wiring pattern, better specs).');

-- 3.3 Motion-Activated Light
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000030e', 1,
   'Wire the IR avoidance module D → pin 2. Print "motion!" every time the output goes LOW. Wave your hand to trigger.',
   'On-board module LED lights during wave; Serial prints "motion!" once per approach, not continuously.'),
  ('00000000-0000-0000-0000-00000000030e', 2,
   'Add the LDR voltage divider on A0. Print the raw value once per second. Use your values to pick a DARK_THRESHOLD.',
   'Raw in room light: 600-800. Covered with hand: 50-150. Threshold around 400 gives clean dark/light decisions.'),
  ('00000000-0000-0000-0000-00000000030e', 3,
   'Combine: LED on pin 9 stays on ONLY when (ambient is dark) AND (motion detected in last 10 seconds).',
   'Hand-wave in bright room → LED stays off. Hand-wave under a cover → LED lights for 10s, then auto-off.'),
  ('00000000-0000-0000-0000-00000000030e', 4,
   'Smooth the turn-off: instead of snap-off at timeout, fade from 255 to 0 over 500 ms using analogWrite().',
   'LED noticeably fades rather than cutting out. Feels more natural.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000030e', 1, 'caution',
   'The IR avoidance module''s range varies with surface reflectivity. A black couch gives shorter range than white paint — calibrate the trim pot for your environment.'),
  ('00000000-0000-0000-0000-00000000030e', 2, 'info',
   'To drive a real lamp instead of an LED, wire a relay module on the output and follow Module 1.4''s mains-voltage safety rules.');

-- 3.4 Remote-Controlled RGB Lamp
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000030f', 1,
   'Install the IRremote library. Wire the IR receiver to pin 2. Point any TV/AC remote at it and press numbers 0–7.',
   'Serial Monitor prints a different hex code per button. Copy them down — you''ll use them as keys in your preset table.'),
  ('00000000-0000-0000-0000-00000000030f', 2,
   'Wire the RGB module: R → 9, G → 10, B → 11, GND. Manually cycle it through red, green, blue using analogWrite() calls in setup().',
   'Each color shows briefly during boot. If the module is common-anode (most are), remember LOW = on — invert your PWM values.'),
  ('00000000-0000-0000-0000-00000000030f', 3,
   'Populate the PRESETS table with YOUR remote''s codes. Pressing each key on the remote should change the lamp color.',
   'Press "1" → red. "7" → violet. "0" → off. Instant response (no perceptible lag).'),
  ('00000000-0000-0000-0000-00000000030f', 4,
   'Add the potentiometer on A0 for brightness. Turn knob — all colors dim/brighten together without changing hue.',
   'Knob at 0 = lamp appears off regardless of color. Knob at max = full saturation. Transitions smooth.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000030f', 1, 'info',
   'IR codes differ between remotes. If your "1" is `0x16`, a different remote''s "1" might be `0x40`. Always learn the codes from your own remote before hard-coding.');

-- 3.5 Secret-Knock Detector
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000310', 1,
   'Wire the knock sensor to A0. Print analogRead(A0) in a tight loop while tapping the breadboard.',
   'Idle: 0–10. Firm tap: 50–400 depending on force. Pick a THRESHOLD that catches deliberate taps but not ambient vibration.'),
  ('00000000-0000-0000-0000-000000000310', 2,
   'Store every knock''s timestamp in an array. When 2 seconds pass with no new knock, print the list of gaps between consecutive knocks.',
   'Tap a rhythm, pause. Serial prints "[500, 500, 1000, 500]" (or similar) — the time gaps that define your pattern.'),
  ('00000000-0000-0000-0000-000000000310', 3,
   'Wire a button on pin 2 with INPUT_PULLUP. Pressing it enters LEARN mode: the next tapped rhythm replaces the stored pattern.',
   'Serial says "learning..." when you press the button. Subsequent knocks fill in the pattern. Next silent window stores it.'),
  ('00000000-0000-0000-0000-000000000310', 4,
   'Add verification: after a knock pattern ends (NOT in learn mode), compare gap-by-gap to the stored pattern with ±30% tolerance. Print MATCH or no match.',
   'Exact repro → MATCH. Rough repro (close timing) → MATCH. Wildly off or wrong count → no match.'),
  ('00000000-0000-0000-0000-000000000310', 5,
   'Wire green LED on pin 3, red LED on pin 4, passive buzzer on pin 5. Light + chirp on match, light + buzz on fail.',
   'Visual + audible feedback on each attempt. Green LED + high-pitch chirp = unlocked. Red + low buzz = denied.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000310', 1, 'info',
   'Store the pattern in EEPROM if you want it to survive power cycles. `EEPROM.put(0, pattern)` writes it once; `EEPROM.get(0, pattern)` reads it on boot.'),
  ('00000000-0000-0000-0000-000000000310', 2, 'caution',
   'Tolerance too tight = nobody can reproduce the pattern. Tolerance too loose = anyone can. 25–35% is the sweet spot for human-played rhythms.');

-- 3.6 Reaction Time Game
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000311', 1,
   'Wire button on pin 2 (INPUT_PULLUP), LED on pin 9 with 220Ω. Passive buzzer on pin 8.',
   'Manual test: digitalWrite(LED, HIGH) lights the LED. tone(8, 1500, 100) beeps briefly. Both ready.'),
  ('00000000-0000-0000-0000-000000000311', 2,
   'Implement the state machine: IDLE → WAITING → ACTIVE → RESULT. Transition on button press or time elapsed.',
   'Serial shows "IDLE → WAITING → ACTIVE → RESULT" each round. No state skipped. No duplicate prints.'),
  ('00000000-0000-0000-0000-000000000311', 3,
   'Time the interval between ACTIVE entry and button press. Print it as your reaction time in ms.',
   'First few rounds: 250–350 ms typical. You will improve with practice.'),
  ('00000000-0000-0000-0000-000000000311', 4,
   'Add false-start detection: if the button is pressed during WAITING, flash red + low buzz, back to IDLE. No time recorded.',
   'Pressing early = "TOO SOON!". Round doesn''t count toward the 5.'),
  ('00000000-0000-0000-0000-000000000311', 5,
   'Track the last 5 rounds. After round 5, print best and average. Reset for the next session.',
   'After 5 rounds: "best: 195  avg: 243". Then game resets for next series.'),
  ('00000000-0000-0000-0000-000000000311', 6,
   'Add a potentiometer on A0 to set difficulty — maps to the max random-wait range. Knob high = longer worst-case wait.',
   'Knob at min → consistent 1–2 s waits. Knob at max → unpredictable 1–5 s. Harder to pre-time the press.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000311', 1, 'info',
   'Reaction time under 100 ms is statistically impossible for humans — that''s a false start that slipped past detection. Tighten the WAITING guard if you see sub-100 ms reports.');

-- ───────────────────────── Phase 3 lesson ↔ components ─────
insert into public.lesson_components (lesson_id, component_slug, "order") values
  -- 3.1 Project Design Patterns — skeleton only
  ('00000000-0000-0000-0000-00000000030c', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000030c', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000030c', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000030c', 'button',           4),

  -- 3.2 Weather Station
  ('00000000-0000-0000-0000-00000000030d', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000030d', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000030d', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000030d', 'dht11',            4),
  ('00000000-0000-0000-0000-00000000030d', 'photoresistor',    5),
  ('00000000-0000-0000-0000-00000000030d', 'resistor',         6),
  ('00000000-0000-0000-0000-00000000030d', 'button',           7),

  -- 3.3 Motion-Activated Light
  ('00000000-0000-0000-0000-00000000030e', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000030e', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000030e', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000030e', 'ir-avoidance',     4),
  ('00000000-0000-0000-0000-00000000030e', 'photoresistor',    5),
  ('00000000-0000-0000-0000-00000000030e', 'resistor',         6),
  ('00000000-0000-0000-0000-00000000030e', 'led',              7),

  -- 3.4 Remote-Controlled RGB Lamp
  ('00000000-0000-0000-0000-00000000030f', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-00000000030f', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000030f', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000030f', 'ir-receiver',      4),
  ('00000000-0000-0000-0000-00000000030f', 'rgb-module',       5),
  ('00000000-0000-0000-0000-00000000030f', 'potentiometer',    6),

  -- 3.5 Secret-Knock Detector
  ('00000000-0000-0000-0000-000000000310', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-000000000310', 'breadboard',       2),
  ('00000000-0000-0000-0000-000000000310', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-000000000310', 'knock-sensor',     4),
  ('00000000-0000-0000-0000-000000000310', 'button',           5),
  ('00000000-0000-0000-0000-000000000310', 'led',              6),
  ('00000000-0000-0000-0000-000000000310', 'resistor',         7),
  ('00000000-0000-0000-0000-000000000310', 'buzzer',           8),

  -- 3.6 Reaction Time Game
  ('00000000-0000-0000-0000-000000000311', 'arduino-uno',      1),
  ('00000000-0000-0000-0000-000000000311', 'breadboard',       2),
  ('00000000-0000-0000-0000-000000000311', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-000000000311', 'button',           4),
  ('00000000-0000-0000-0000-000000000311', 'led',              5),
  ('00000000-0000-0000-0000-000000000311', 'resistor',         6),
  ('00000000-0000-0000-0000-000000000311', 'buzzer',           7),
  ('00000000-0000-0000-0000-000000000311', 'potentiometer',    8)
on conflict do nothing;

-- ═══════════════════════════════════════════════════════════════════
-- ══════════════════ PHASE 4 — IOT INTEGRATION ══════════════════════
-- ═══════════════════════════════════════════════════════════════════
-- Pivot point: ESP32 takes over from the Uno. WiFi, HTTP, web servers,
-- MQTT — the ingredients for turning every project into a networked
-- thing you can check from your phone.

-- ───────────────────────── Phase 4 modules ─────
insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b5', 1, 'esp32-setup',           '1.1',
   'ESP32 Setup & Migration', 'theory', 'preview', 35,
   'Switch from the Uno to the ESP32. Install board support, handle the 3.3V logic change, flash your first ESP32 Blink.'),
  ('00000000-0000-0000-0000-0000000000b5', 2, 'wifi-fundamentals',     '1.2',
   'WiFi Fundamentals', 'handson', 'not_started', 45,
   'Connect to WPA2, scan nearby networks, and write the auto-reconnect pattern every real IoT sketch eventually needs.'),
  ('00000000-0000-0000-0000-0000000000b5', 3, 'http-client',           '1.3',
   'HTTP Client: Consuming APIs', 'handson', 'not_started', 50,
   'Fetch JSON from public APIs with HTTPClient. Parse with ArduinoJson. Handle retries, timeouts, and HTTPS.'),
  ('00000000-0000-0000-0000-0000000000b5', 4, 'web-server-dashboard',  '1.4',
   'Web Server: Dashboard on the Device', 'handson', 'not_started', 70,
   'Serve HTML/CSS/JS from the ESP32 itself. Live sensor readings over REST and Server-Sent Events. The payoff moment for web devs.'),
  ('00000000-0000-0000-0000-0000000000b5', 5, 'mqtt-pub-sub',          '1.5',
   'MQTT Pub/Sub for IoT', 'handson', 'not_started', 55,
   'Connect to a broker. Publish sensor readings. Subscribe to commands. The protocol every home-automation system runs on.'),
  ('00000000-0000-0000-0000-0000000000b5', 6, 'iot-capstone',          '1.6',
   'IoT Capstone: Networked Weather Station', 'project', 'not_started', 90,
   'Combine it all. DHT11 + LDR on ESP32. Local dashboard + MQTT publish + OTA updates. The thing you''ve been working towards.');

-- ───────────────────────── Phase 4 lessons (rich bodies) ─────
insert into public.lessons (id, module_id, "order", title, body_md) values
  -- 4.1 ESP32 Setup & Migration
  ('00000000-0000-0000-0000-00000000040c',
   (select id from public.modules where slug = 'esp32-setup'),
   1,
   'ESP32 Setup & Migration',
   '## Why switch boards now

The Uno has carried you through 3 phases of electronics. It can''t do WiFi. Every IoT project from here needs a radio and more memory — enter the ESP32.

<!-- ill:logic-levels -->

| | Uno R3 | ESP32 |
|---|---|---|
| Clock | 16 MHz | **240 MHz dual-core** |
| Flash | 32 KB | **4 MB** |
| RAM | 2 KB | **520 KB** |
| WiFi | ✗ | **✓ 802.11 b/g/n** |
| Bluetooth | ✗ | **✓ Classic + LE** |
| Logic level | 5 V | **3.3 V** |
| Digital pins | 14 | **~25 usable** |
| Analog inputs | 6 × 10-bit | **~18 × 12-bit** |

The ESP32 isn''t just faster — it''s a different silicon architecture (Tensilica Xtensa, not ATmega). Your existing sketches *mostly* port over, but there are traps.

## Install board support

The ESP32 isn''t known to Arduino IDE out of the box. Add it:

1. `File → Preferences → Additional Board Manager URLs` → add:

   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```

2. `Tools → Board → Boards Manager` → search **"esp32"** → install *esp32 by Espressif Systems*. This takes 5–10 minutes on first install (downloads the toolchain).

3. `Tools → Board → esp32 → "ESP32 Dev Module"` (or your specific board name).

4. Install the USB driver: most ESP32 dev boards use **CP210x** or **CH34x**. If `Tools → Port` stays greyed out after plugging in the board, search for your chip and install the right driver.

## Boot mode quirks

Some older ESP32 boards need you to **hold the BOOT button while uploading** — modern boards auto-handle this. If upload fails with "Failed to connect":

- Hold BOOT, press RESET, release RESET, release BOOT — then retry upload.
- Or swap to a lower upload speed: `Tools → Upload Speed → 115200`.

## First sketch — ESP32 Blink

The on-board LED is usually on **GPIO 2** (check your board''s silkscreen). Note that `LED_BUILTIN` is defined for most ESP32 boards — use it when you can.

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

Looks identical to Uno Blink. That''s the point — the Arduino framework abstracts enough that basic GPIO works the same way.

## What''s actually different

### 3.3 V logic everywhere

Every GPIO outputs 3.3 V, not 5 V. Anything you wired that needed 5 V (sensors labeled "5V only", some servos) needs either a level-shifter module or a separate 5 V supply.

### ADC resolution and range

- Uno: `analogRead()` → 0–1023 (10-bit), input 0–5 V
- ESP32: `analogRead()` → 0–4095 (12-bit), input 0–3.3 V

Your `map(raw, 0, 1023, 0, 255)` calls need updating to `map(raw, 0, 4095, 0, 255)` for PWM.

### PWM is different

ESP32 uses the **LEDC peripheral** for PWM instead of simple `analogWrite`. The Arduino core provides an `analogWrite` shim, but for real projects use `ledcSetup` + `ledcAttachPin` + `ledcWrite`:

```cpp
const int CHANNEL = 0, FREQ = 5000, RES = 8;  // 8-bit = 0-255

void setup() {
  ledcSetup(CHANNEL, FREQ, RES);
  ledcAttachPin(13, CHANNEL);
}

void loop() {
  ledcWrite(CHANNEL, 128);  // 50% duty
}
```

16 independent PWM channels on any pin. Much more flexible than the Uno''s 6 hardware-fixed pins.

### Reserved pins — do not use

- **GPIO 6–11**: wired to the flash chip. Don''t use.
- **GPIO 34–39**: input-only (no internal pull-up/-down, no output drive).
- **GPIO 0, 2**: boot-strap pins — OK to use but the board needs specific levels at boot.

## Takeaway

Your Uno code ports with 3 changes: `analogRead` range, `analogWrite` replaced with `ledcWrite`, and any 5V-assuming sensors re-wired. After Blink works, Module 4.2 connects to WiFi — the part the Uno could never do.'),

  -- 4.2 WiFi Fundamentals
  ('00000000-0000-0000-0000-00000000040d',
   (select id from public.modules where slug = 'wifi-fundamentals'),
   1,
   'WiFi Fundamentals',
   '## The 20-line "hello WiFi" sketch

```cpp
#include <WiFi.h>

const char* SSID = "YOUR_SSID";
const char* PASS = "YOUR_PASSWORD";

void setup() {
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);           // station mode — we''re a client, not an AP
  WiFi.begin(SSID, PASS);

  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.print("connected  IP: ");
  Serial.println(WiFi.localIP());
}

void loop() { }
```

Upload, open Serial Monitor at **115200 baud**. You should see `connecting....connected  IP: 192.168.x.x` within 10 seconds.

## The three WiFi modes

| Mode | What it does | Use when |
|---|---|---|
| `WIFI_STA` | Client — joins an existing AP | Talking to your home network (default) |
| `WIFI_AP` | Access point — devices connect TO the ESP32 | Provisioning, setup flow |
| `WIFI_AP_STA` | Both — client + its own AP | Mesh-ish topologies, repeaters |

## WiFi.status() — the 8 states that matter

| Constant | Meaning |
|---|---|
| `WL_IDLE_STATUS` | Just initialised, no attempt yet |
| `WL_NO_SSID_AVAIL` | SSID not found in scan — wrong name or out of range |
| `WL_SCAN_COMPLETED` | Scan finished (transient) |
| `WL_CONNECTED` | Connected, IP acquired |
| `WL_CONNECT_FAILED` | Wrong password, usually |
| `WL_CONNECTION_LOST` | Was connected, lost signal |
| `WL_DISCONNECTED` | Intentional disconnect |

## Scanning available networks

Useful for a setup UI where the user picks their network:

```cpp
int n = WiFi.scanNetworks();
for (int i = 0; i < n; i++) {
  Serial.print(WiFi.SSID(i));
  Serial.print("  RSSI=");
  Serial.print(WiFi.RSSI(i));
  Serial.print("  ch=");
  Serial.println(WiFi.channel(i));
}
```

**RSSI** is signal strength: closer to 0 = stronger. -30 is excellent, -70 is marginal, -80 and worse is unreliable.

## Auto-reconnect — the pattern that makes WiFi actually reliable

Home WiFi drops. The router reboots. Your neighbour microwaves popcorn. A real sketch handles all of it:

```cpp
const unsigned long RECONNECT_INTERVAL = 5000;
unsigned long lastAttempt = 0;

void ensureWiFi() {
  if (WiFi.status() == WL_CONNECTED) return;
  if (millis() - lastAttempt < RECONNECT_INTERVAL) return;
  lastAttempt = millis();

  Serial.println("reconnecting...");
  WiFi.disconnect();
  WiFi.begin(SSID, PASS);
}

void loop() {
  ensureWiFi();
  // ... your app code ...
}
```

Drop this into every WiFi sketch. The radio recovers automatically without your app noticing.

## Secrets hygiene

Don''t commit your password to git. Put them in a separate header:

```cpp
// File: secrets.h (add to .gitignore)
#define WIFI_SSID "YourNetwork"
#define WIFI_PASS "YourPassword"
```

```cpp
#include "secrets.h"
WiFi.begin(WIFI_SSID, WIFI_PASS);
```

## Takeaway

`WiFi.begin()` + `WiFi.status()` polling = basic connect. Add `ensureWiFi()` called every loop for reliability. With those two pieces you''re ready to make HTTP calls in Module 4.3.'),

  -- 4.3 HTTP Client
  ('00000000-0000-0000-0000-00000000040e',
   (select id from public.modules where slug = 'http-client'),
   1,
   'HTTP Client: Consuming APIs',
   '## Fetch like you would in JavaScript

Now that WiFi is stable, you can talk to any HTTPS endpoint on the internet. The `HTTPClient` library makes it feel familiar to a web dev:

```cpp
#include <WiFi.h>
#include <HTTPClient.h>

void httpGet(const char* url) {
  HTTPClient http;
  http.begin(url);
  int code = http.GET();

  if (code > 0) {
    Serial.printf("HTTP %d\\n", code);
    String body = http.getString();
    Serial.println(body);
  } else {
    Serial.printf("error: %s\\n", http.errorToString(code).c_str());
  }
  http.end();
}
```

Call `httpGet("http://worldtimeapi.org/api/timezone/Asia/Manila")` and you''ll see the current time as JSON in Serial.

## Parse JSON with ArduinoJson

`String` parsing by hand is painful. Install **ArduinoJson** via Library Manager (make sure it''s v7.x) and parse like this:

```cpp
#include <ArduinoJson.h>

void parseWorldTime(const String& json) {
  JsonDocument doc;
  DeserializationError err = deserializeJson(doc, json);
  if (err) { Serial.println("bad JSON"); return; }

  const char* dt = doc["datetime"];
  int unixtime   = doc["unixtime"];
  Serial.printf("now: %s  (%d)\\n", dt, unixtime);
}
```

`JsonDocument` auto-sizes on the heap in v7. Keep the document alive for as long as you need the parsed values — the `const char*` fields point into its internal buffer.

## POST with a JSON body

Send sensor readings to your own API:

```cpp
void postReading(float temp, float humidity) {
  HTTPClient http;
  http.begin("https://api.example.com/readings");
  http.addHeader("Content-Type", "application/json");

  JsonDocument doc;
  doc["temp"] = temp;
  doc["humidity"] = humidity;
  doc["device"] = "esp32-kitchen";

  String body;
  serializeJson(doc, body);

  int code = http.POST(body);
  Serial.printf("POST → %d\\n", code);
  http.end();
}
```

## HTTPS — the extra step

Plain HTTP works as shown. HTTPS needs a **root certificate** so the ESP32 can verify the server. Easiest approach: use `WiFiClientSecure` with `setInsecure()` for local dev, then switch to real certs for production:

```cpp
WiFiClientSecure client;
client.setInsecure();    // dev only — skips cert verification
HTTPClient http;
http.begin(client, "https://api.example.com/endpoint");
```

For production, pin the server''s cert:

```cpp
const char* ROOT_CA = "-----BEGIN CERTIFICATE-----\\nMII...\\n-----END CERTIFICATE-----";
client.setCACert(ROOT_CA);
```

## Retry + timeout pattern

Real APIs sometimes return 500s. Real WiFi sometimes drops mid-request. Wrap every call:

```cpp
bool fetchWithRetry(const char* url, String& out, int maxTries = 3) {
  for (int i = 0; i < maxTries; i++) {
    HTTPClient http;
    http.setTimeout(5000);   // 5 s request timeout
    http.begin(url);
    int code = http.GET();
    if (code == 200) {
      out = http.getString();
      http.end();
      return true;
    }
    http.end();
    delay(1000 * (i + 1));   // backoff: 1s, 2s, 3s
  }
  return false;
}
```

## Takeaway

`HTTPClient` + `ArduinoJson` cover ~90% of IoT "fetch from a service" needs. The retry+backoff helper above belongs in every production sketch. Module 4.4 flips the direction — instead of calling APIs, you''ll serve one.'),

  -- 4.4 Web Server + Dashboard
  ('00000000-0000-0000-0000-00000000040f',
   (select id from public.modules where slug = 'web-server-dashboard'),
   1,
   'Web Server: Dashboard on the Device',
   '## The moment IoT clicks

Type `http://192.168.1.42/` into your laptop browser. The page that loads is served *by the ESP32 on your desk*. This is the payoff moment for a web developer.

## Minimum viable server

```cpp
#include <WiFi.h>
#include <WebServer.h>

WebServer server(80);

void handleRoot() {
  server.send(200, "text/html",
    "<!doctype html><h1>Hello from ESP32</h1>"
    "<p>Uptime: " + String(millis() / 1000) + " s</p>");
}

void setup() {
  Serial.begin(115200);
  WiFi.begin("YOUR_SSID", "YOUR_PASS");
  while (WiFi.status() != WL_CONNECTED) delay(500);
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.begin();
}

void loop() {
  server.handleClient();
}
```

Upload. Open the printed IP in your browser. Done.

## Serving real HTML+CSS+JS

Inlining HTML in your sketch is fine for tiny pages. For anything bigger, use a raw string literal:

```cpp
const char PAGE[] PROGMEM = R"rawliteral(
<!doctype html>
<html>
<head>
  <title>ESP32 Dashboard</title>
  <style>
    body { font: 16px system-ui; padding: 2rem; background: #0b1020; color: #eef; }
    .card { background: #1a2040; border-radius: 12px; padding: 1.5rem; max-width: 320px; }
    .big { font-size: 2.5rem; color: #6af; margin: 0; }
  </style>
</head>
<body>
  <div class="card">
    <h2>Living Room</h2>
    <p class="big" id="temp">–</p>
    <p>humidity: <span id="hum">–</span>%</p>
  </div>
  <script>
    async function tick() {
      const r = await fetch("/api/reading");
      const d = await r.json();
      document.getElementById("temp").textContent = d.temp.toFixed(1) + " °C";
      document.getElementById("hum").textContent  = d.humidity.toFixed(0);
    }
    setInterval(tick, 2000);
    tick();
  </script>
</body>
</html>
)rawliteral";

void handleRoot() { server.send(200, "text/html", PAGE); }
```

The `PROGMEM` qualifier keeps the HTML string in flash instead of RAM — important for larger pages.

## REST endpoints for your sensors

```cpp
void handleReading() {
  float t = dht.readTemperature();
  float h = dht.readHumidity();
  String json = "{\"temp\":" + String(t, 1) +
                ",\"humidity\":" + String(h, 0) + "}";
  server.send(200, "application/json", json);
}

// ...
server.on("/api/reading", handleReading);
```

For more complex data shapes use ArduinoJson — same pattern as Module 4.3 but `serializeJson(doc, out)` writes into a String before sending.

## Live updates — polling vs SSE

**Polling** (above) — browser fetches `/api/reading` every 2 s. Simple, works anywhere, wasteful if data rarely changes.

**Server-Sent Events** (SSE) — browser opens *one* connection and ESP32 pushes new readings whenever they change. Much more efficient for 1+ Hz updates:

```cpp
// ESP32 side:
server.sendHeader("Content-Type", "text/event-stream");
server.sendHeader("Cache-Control", "no-cache");
server.send(200);
while (true) {
  server.sendContent("data: " + String(dht.readTemperature()) + "\\n\\n");
  delay(2000);
}
```

```js
// Browser side:
const es = new EventSource("/api/stream");
es.onmessage = (e) => console.log(e.data);
```

SSE is one-way (server → browser). For bidirectional, use **WebSockets** via the `WebSocketsServer` library.

## Hosting a bigger site

For a multi-page dashboard with separate HTML/CSS/JS files, use **LittleFS** (a flash filesystem). Upload files via the **ESP32 Sketch Data Upload** tool, then serve with:

```cpp
#include <LittleFS.h>

void setup() {
  LittleFS.begin();
  server.serveStatic("/", LittleFS, "/www/");
}
```

Now any file in `/data/www/` gets served at `/`. Put your built React/Svelte/Vue bundle there.

## Takeaway

A $3 ESP32 can serve a real web dashboard over WiFi. Pair that with MQTT (Module 4.5) and you have the full home-automation stack, no cloud required.'),

  -- 4.5 MQTT Pub/Sub
  ('00000000-0000-0000-0000-000000000410',
   (select id from public.modules where slug = 'mqtt-pub-sub'),
   1,
   'MQTT Pub/Sub for IoT',
   '## The protocol every smart home speaks

MQTT is publish/subscribe messaging: devices send messages tagged with a **topic**; other devices subscribe to topics they care about. A **broker** in the middle routes everything.

<!-- ill:iot-architecture -->

| You want | Pattern |
|---|---|
| Temperature readings from every room | Subscribe to `home/+/temp` |
| Only kitchen humidity | Subscribe to `home/kitchen/humidity` |
| All sensor data | Subscribe to `home/#` |

Wildcards: `+` matches one level, `#` matches any levels at the end.

## Install a broker (10 minutes)

Easiest options:

- **Mosquitto** (local, open source): `apt install mosquitto` on a Raspberry Pi or any Linux box. Runs on port 1883.
- **HiveMQ public broker** (cloud, free for testing): host `broker.hivemq.com`, port 1883. Anyone can read your messages — fine for learning, not production.
- **AWS IoT Core / Azure IoT Hub** — production-grade, managed, expensive.

For this module use HiveMQ public — zero setup.

## The PubSubClient library

Install **PubSubClient** via Library Manager. Minimal publisher:

```cpp
#include <WiFi.h>
#include <PubSubClient.h>

WiFiClient wifi;
PubSubClient mqtt(wifi);

void setup() {
  Serial.begin(115200);
  WiFi.begin("SSID", "PASS");
  while (WiFi.status() != WL_CONNECTED) delay(500);

  mqtt.setServer("broker.hivemq.com", 1883);
  while (!mqtt.connected()) {
    mqtt.connect("esp32-trainor-demo");
    delay(1000);
  }
}

void loop() {
  static unsigned long last = 0;
  if (millis() - last > 2000) {
    last = millis();
    float t = 22.5 + random(-20, 20) / 10.0;
    String msg = String(t);
    mqtt.publish("trainor/demo/temp", msg.c_str());
    Serial.println("published: " + msg);
  }
  mqtt.loop();   // must run every iteration
}
```

Test it: on your laptop, `mosquitto_sub -h broker.hivemq.com -t trainor/demo/temp -v`. You should see live messages.

## Subscribing

Messages arrive via a callback you register:

```cpp
void onMessage(char* topic, byte* payload, unsigned int len) {
  String msg;
  for (unsigned int i = 0; i < len; i++) msg += (char)payload[i];
  Serial.printf("[%s] %s\\n", topic, msg.c_str());

  if (String(topic) == "trainor/demo/cmd" && msg == "on") {
    digitalWrite(LED_BUILTIN, HIGH);
  }
}

void setup() {
  // ... WiFi + broker connect ...
  mqtt.setCallback(onMessage);
  mqtt.subscribe("trainor/demo/cmd");
}
```

Publish to `trainor/demo/cmd` with payload `on` from any MQTT client → LED lights up instantly.

## QoS levels — pick 1 for most cases

| QoS | Delivery | Use when |
|---|---|---|
| 0 | At most once (fire and forget) | Rapid sensor streams — loss of one reading is fine |
| 1 | At least once (may duplicate) | Commands — "turn light on" should never be missed |
| 2 | Exactly once (slowest) | Billing, irreversible operations — rarely needed |

`PubSubClient` defaults to QoS 0. Pass `true` as the last arg to `publish()` for QoS 1.

## Retained messages — state for new subscribers

A retained message is stored by the broker and sent to every new subscriber:

```cpp
mqtt.publish("home/livingroom/temp", "23.4", true);   // retain
```

Great for state values. Bad for streaming data (gets stale fast).

## Authentication

Public brokers are fine for testing. Production needs credentials:

```cpp
mqtt.connect("client-id", "username", "password");
```

For TLS, swap `WiFiClient` for `WiFiClientSecure` and set `mqtt.setServer(host, 8883)`.

## Reconnect pattern

```cpp
void ensureMQTT() {
  if (mqtt.connected()) { mqtt.loop(); return; }
  static unsigned long lastTry = 0;
  if (millis() - lastTry < 5000) return;
  lastTry = millis();
  if (mqtt.connect("esp32-client")) {
    mqtt.subscribe("trainor/demo/cmd");
    Serial.println("MQTT up");
  }
}
```

Call it every loop. Pairs with `ensureWiFi()` from Module 4.2.

## Takeaway

Publish readings on a topic, subscribe to commands on another — that''s the entire IoT messaging model. Plug a broker + dashboard (Node-RED, Home Assistant, your own) and you have home automation.'),

  -- 4.6 IoT Capstone
  ('00000000-0000-0000-0000-000000000411',
   (select id from public.modules where slug = 'iot-capstone'),
   1,
   'IoT Capstone: Networked Weather Station',
   '## What you''re building

Remember the Phase 3 weather station (module 3.2) that printed to Serial? Now rebuild it with the full stack:

- **Sensors:** DHT11 + LDR, read every 2 seconds (same as 3.2)
- **Local dashboard:** `http://<esp32-ip>/` shows live values in a browser
- **MQTT publish:** broadcasts readings to `home/weather/<metric>` every 30 seconds
- **MQTT subscribe:** commands on `home/weather/cmd` (`reset-minmax`, `sample-now`)
- **OTA updates:** `http://<esp32-ip>/update` lets you flash new firmware without USB

This is a real IoT device. Everything you''ve learned in Phases 1-4 lands here.

<!-- ill:project-flow -->

## Parts

| | Role |
|---|---|
| ESP32 Dev Board | MCU + WiFi |
| DHT11 | Temp + humidity |
| Photoresistor + 10 KΩ | Ambient light |
| Breadboard + jumper wires | Everything stays a prototype |

## Wiring

```
DHT11:  DATA → GPIO 4, VCC → 3V3, GND → GND
LDR:    3V3 → 10 KΩ → GPIO 34 → LDR → GND   (GPIO 34 is input-only — perfect for analog)
```

> **Remember:** DHT11 on 3.3V works fine for the sensor''s power rail. The DATA line swings 0-3.3V which ESP32 reads natively.

## The sketch (skeleton — fill in code from earlier modules)

```cpp
#include <WiFi.h>
#include <WebServer.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include <Update.h>
#include <DHT.h>
#include "secrets.h"   // WIFI_SSID, WIFI_PASS, MQTT_HOST, MQTT_USER, MQTT_PASS

DHT dht(4, DHT11);
WebServer server(80);
WiFiClient wifiClient;
PubSubClient mqtt(wifiClient);

float curT = 0, curH = 0, tMin = 999, tMax = -999;
int curLight = 0;
unsigned long lastRead = 0, lastPublish = 0;

// ─── sensor loop ─────────────────────────────
void sample() {
  float t = dht.readTemperature();
  float h = dht.readHumidity();
  if (!isnan(t)) { curT = t; tMin = min(tMin, t); tMax = max(tMax, t); }
  if (!isnan(h)) { curH = h; }
  curLight = analogRead(34);
}

// ─── HTTP ────────────────────────────────────
void handleRoot() {
  server.send(200, "text/html", /* the dashboard HTML from Module 4.4 */);
}
void handleApi() {
  JsonDocument d;
  d["temp"] = curT;
  d["humidity"] = curH;
  d["light"] = curLight;
  d["min"] = tMin;
  d["max"] = tMax;
  String out;
  serializeJson(d, out);
  server.send(200, "application/json", out);
}

// ─── MQTT ────────────────────────────────────
void onMessage(char* topic, byte* payload, unsigned int len) {
  String msg;
  for (unsigned int i = 0; i < len; i++) msg += (char)payload[i];
  if (msg == "reset-minmax") { tMin = curT; tMax = curT; }
  if (msg == "sample-now")   { sample(); }
}

void publishReadings() {
  mqtt.publish("home/weather/temp",     String(curT).c_str(), true);
  mqtt.publish("home/weather/humidity", String(curH).c_str(), true);
  mqtt.publish("home/weather/light",    String(curLight).c_str(), true);
}

// ─── main ────────────────────────────────────
void setup() {
  Serial.begin(115200);
  dht.begin();

  // WiFi connect (Module 4.2)
  // MQTT connect + subscribe (Module 4.5)
  // HTTP routes + server.begin()
  // OTA setup — /update route via ESP32''s built-in HTTPUpdateServer
}

void loop() {
  ensureWiFi();
  ensureMQTT();
  server.handleClient();
  mqtt.loop();

  if (millis() - lastRead > 2000) { sample(); lastRead = millis(); }
  if (millis() - lastPublish > 30000) { publishReadings(); lastPublish = millis(); }
}
```

## OTA updates — flash over WiFi

The `HTTPUpdateServer` class (from `Update.h` + `WebServer.h`) adds an `/update` route that lets you upload a new `.bin` file directly. No more USB cable once the device is in the wall.

```cpp
#include <HTTPUpdateServer.h>

HTTPUpdateServer httpUpdater;

void setup() {
  // ...
  httpUpdater.setup(&server);   // attach /update handler
  server.begin();
}
```

Build your sketch, then `Sketch → Export Compiled Binary`. Upload the resulting `.bin` to `http://<esp32-ip>/update`. Reboots automatically when done.

**Security:** `HTTPUpdateServer.setup(&server, "user", "pass")` gates it behind basic auth. Use it.

## Verify the full stack

1. Power on. Serial shows `WiFi up` → `MQTT up`.
2. Open `http://<esp32-ip>/` — dashboard shows live values.
3. `mosquitto_sub -h broker.example.com -t home/weather/#` — messages arrive every 30 s.
4. `mosquitto_pub -h broker.example.com -t home/weather/cmd -m "reset-minmax"` — device clears its min/max and logs it.
5. Export a modified binary, upload to `/update` — device reboots with new behavior.

## Takeaway

You''ve gone from "LED blinks via delay()" to "networked device with live web UI, MQTT messaging, and over-the-air firmware updates" across 4 phases. That same pattern — sensors → edge logic → network → dashboard — is the core of real industrial IoT.

Everything beyond this (multiple devices in a mesh, battery-operated sensors, LoRa for long range, cloud analytics) is variations on this skeleton.

**Phase 5+** is where you take this out into the world: robotics, custom PCBs, batteries, enclosures. But right here, at this module''s end, you have a genuine IoT device you built from zero electronics. Ship it.');

-- ───────────────────────── Phase 4 hands-on + safety + mappings ─────

-- 4.1 ESP32 Setup & Migration
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000040c', 1,
   'Add the ESP32 boards-manager URL in File → Preferences, install "esp32 by Espressif" via Boards Manager, and pick "ESP32 Dev Module" under Tools → Board.',
   'Board dropdown shows ESP32 variants. Install takes 5-10 minutes — toolchain download is large.'),
  ('00000000-0000-0000-0000-00000000040c', 2,
   'Plug in the ESP32. Check Tools → Port for a new COMx. If greyed out, install the CP210x or CH34x USB-to-UART driver that matches your board''s bridge chip.',
   'Port appears. If not, the driver is missing — check the chip near the USB port (silkscreen) and grab the matching driver from SiLabs or WCH.'),
  ('00000000-0000-0000-0000-00000000040c', 3,
   'Upload the built-in Blink example (uses LED_BUILTIN). If "Failed to connect" appears, hold the BOOT button during upload.',
   'Board''s on-board LED (usually GPIO 2) blinks at 1 Hz. You''ve compiled + flashed your first ESP32 sketch.'),
  ('00000000-0000-0000-0000-00000000040c', 4,
   'Change the delays to 100 ms. Upload. Open Serial Monitor at 115200 baud (not 9600 — ESP32 defaults to the higher rate).',
   'Faster blink. Serial output only appears at 115200 baud — wrong baud gives garbage, same as on the Uno.'),
  ('00000000-0000-0000-0000-00000000040c', 5,
   'Wire a 5V-labeled sensor (any one from Phase 2) to the ESP32''s 3.3V rail. Verify with the multimeter that the sensor''s output swings 0–3.3V, not 0–5V.',
   'Sensor output stays under 3.3V. If it needs true 5V to function, either swap to a 3.3V-tolerant variant or add a logic level converter.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000040c', 1, 'danger',
   'Never connect a 5V output (Uno pin, USB hub power, external supply) directly to an ESP32 GPIO. You''ll damage the pin or the entire chip. Use a level shifter for 5V ↔ 3.3V mixing.'),
  ('00000000-0000-0000-0000-00000000040c', 2, 'caution',
   'Avoid GPIO 6-11 (connected to the onboard flash) and note GPIO 34-39 are input-only with no internal pull-ups. Your Phase 1-3 sketches may need pin reassignments.'),
  ('00000000-0000-0000-0000-00000000040c', 3, 'info',
   'ESP32 ADC is 12-bit (0-4095) over 0-3.3V — update any `map(raw, 0, 1023, ...)` from Uno code to `map(raw, 0, 4095, ...)`.');

-- 4.2 WiFi Fundamentals
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000040d', 1,
   'Create `secrets.h` with your SSID + password. `.gitignore` that file so credentials never reach a repo.',
   'Two `#define` macros, file not tracked in git. `git status` confirms it''s ignored.'),
  ('00000000-0000-0000-0000-00000000040d', 2,
   'Write the minimum connect sketch. Upload. Open Serial at 115200.',
   'Prints "connecting..." then "connected IP: 192.168.x.y" within 5-10 s. Wrong password → prints forever (WL_CONNECT_FAILED in status).'),
  ('00000000-0000-0000-0000-00000000040d', 3,
   'Add `WiFi.scanNetworks()` in setup(). Loop through results and print SSID + RSSI + channel.',
   'List of networks visible to the ESP32. RSSI between -30 (great) and -90 (terrible). Your target network''s RSSI tells you if placement will be a problem.'),
  ('00000000-0000-0000-0000-00000000040d', 4,
   'Implement the `ensureWiFi()` auto-reconnect pattern. Test it: unplug your router briefly, then plug it back in. Confirm the ESP32 rejoins automatically.',
   'After router comes back, Serial prints "reconnecting..." then "connected" again within a few seconds. No manual reset needed.'),
  ('00000000-0000-0000-0000-00000000040d', 5,
   'Print `WiFi.RSSI()` every 5 seconds while moving the ESP32 around the room.',
   'Signal strength changes by 10-30 dB depending on walls and distance. Useful for placing the device before building an enclosure.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000040d', 1, 'info',
   'ESP32 is a 2.4 GHz device only. 5 GHz networks won''t connect — check your router is in mixed mode or keep a 2.4 GHz SSID available.'),
  ('00000000-0000-0000-0000-00000000040d', 2, 'caution',
   'Never commit your WiFi password to a public repo. Always put it in an ignored `secrets.h` — several GitHub repos leak credentials this way every week.');

-- 4.3 HTTP Client
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000040e', 1,
   'GET `http://worldtimeapi.org/api/timezone/Asia/Manila` (or any public JSON API) and print the raw body.',
   'Serial shows a JSON blob with `datetime`, `timezone`, `unixtime`. HTTP code 200.'),
  ('00000000-0000-0000-0000-00000000040e', 2,
   'Install ArduinoJson v7 via Library Manager. Parse the response and print only the `datetime` and `unixtime` fields.',
   'Two clean lines per request: ISO timestamp + unix epoch seconds.'),
  ('00000000-0000-0000-0000-00000000040e', 3,
   'Wrap the GET in the retry-with-backoff helper (3 attempts, 1s/2s/3s backoff).',
   'Simulate failure by disabling your internet — Serial shows 3 retry attempts, each longer than the last. Re-enable — next call succeeds.'),
  ('00000000-0000-0000-0000-00000000040e', 4,
   'POST a JSON body to httpbin.org/post. Include a `device` field and a sensor reading.',
   'httpbin echoes your JSON back in its response. POST returns 200. Full round-trip works.'),
  ('00000000-0000-0000-0000-00000000040e', 5,
   'Swap the URL to an HTTPS endpoint. Use `WiFiClientSecure` + `setInsecure()` for local dev.',
   'HTTPS request succeeds. If you see certificate errors, either `setInsecure()` is missing or the server requires SNI (most public APIs don''t).');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000040e', 1, 'info',
   'Call `http.end()` on every HTTPClient instance — it releases the underlying socket. Forgetting this eventually exhausts the available connection pool.'),
  ('00000000-0000-0000-0000-00000000040e', 2, 'caution',
   '`setInsecure()` skips certificate verification — fine for local dev but a security hole in production. For real deployments pin the root CA.');

-- 4.4 Web Server + Dashboard
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-00000000040f', 1,
   'Write a minimal WebServer sketch that serves an HTML page with the ESP32''s uptime. Point your laptop browser at its IP.',
   'Browser loads the page. Refreshing shows incrementing uptime. Note the IP — you''ll use it for every test.'),
  ('00000000-0000-0000-0000-00000000040f', 2,
   'Add a `/api/reading` endpoint that returns JSON: `{"temp": 22.5, "humidity": 60}` (hardcoded for now).',
   'Browser shows the JSON directly. curl + jq pipeline works the same way as against a real API.'),
  ('00000000-0000-0000-0000-00000000040f', 3,
   'Flesh out the root page with HTML + CSS + JS that polls `/api/reading` every 2 s and updates two big DOM numbers.',
   'Live-updating dashboard visible in the browser. Change the JSON values in code, re-upload, page reflects new values after each poll tick.'),
  ('00000000-0000-0000-0000-00000000040f', 4,
   'Wire a DHT11 to GPIO 4. Read real values and return them via `/api/reading`. The dashboard now shows live room temp/humidity.',
   'Dashboard numbers update as you breathe on the sensor. Humidity responds faster than temperature — matches the DHT11''s physics.'),
  ('00000000-0000-0000-0000-00000000040f', 5,
   'Add a second endpoint `/api/reset` that zeroes the min/max tracking. Add a button to the HTML that POSTs to it.',
   'Clicking "Reset" immediately clears min/max values visible on the dashboard. UI → server → state change round-trip confirmed.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-00000000040f', 1, 'info',
   'The ESP32 WebServer handles one request at a time. Multiple browsers polling will queue — fine for a home dashboard, a problem if you scale past a few clients. For high concurrency use ESPAsyncWebServer.'),
  ('00000000-0000-0000-0000-00000000040f', 2, 'caution',
   'Do not expose your dashboard to the public internet without authentication. A naked /reset endpoint is a denial-of-service invitation.');

-- 4.5 MQTT Pub/Sub
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000410', 1,
   'Install PubSubClient via Library Manager. Connect to broker.hivemq.com:1883 with a unique client ID.',
   'Serial prints "MQTT connected". If it hangs on "mqtt.connect(...)", your client ID is taken — append a random number.'),
  ('00000000-0000-0000-0000-000000000410', 2,
   'Publish a fake temperature reading to `trainor/YOUR_NAME/temp` every 2 seconds. Verify from your laptop: `mosquitto_sub -h broker.hivemq.com -t trainor/YOUR_NAME/temp`.',
   'Your laptop sees live messages scrolling. Any typos in the topic on either side = no messages visible.'),
  ('00000000-0000-0000-0000-000000000410', 3,
   'Subscribe to `trainor/YOUR_NAME/cmd`. Register a callback that toggles the built-in LED on "on"/"off" payloads.',
   'From your laptop: `mosquitto_pub -t trainor/YOUR_NAME/cmd -m "on"` → ESP32 LED lights. `-m "off"` turns it off. End-to-end control works.'),
  ('00000000-0000-0000-0000-000000000410', 4,
   'Publish one reading with the retain flag set. Disconnect and reconnect a subscriber — verify the old retained value arrives immediately on (re)subscribe.',
   'New subscriber receives the last retained message without waiting for a new publish. Perfect for device state.'),
  ('00000000-0000-0000-0000-000000000410', 5,
   'Implement the `ensureMQTT()` reconnect pattern. Test: kill WiFi briefly, then restore.',
   'MQTT reconnects automatically after WiFi comes back. Subscription is re-registered. Publishing resumes.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000410', 1, 'info',
   'Public brokers (HiveMQ, test.mosquitto.org) are readable by anyone. Fine for learning, never for real data. Run your own broker or use a managed one with auth + TLS for anything real.'),
  ('00000000-0000-0000-0000-000000000410', 2, 'caution',
   'Call `mqtt.loop()` every iteration of the main loop — it processes incoming messages and maintains the keepalive. Without it, subscriptions stop firing.');

-- 4.6 IoT Capstone
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000411', 1,
   'Wire DHT11 on GPIO 4 and LDR on GPIO 34 (input-only, ideal for analog). Confirm both read correctly in Serial before adding networking.',
   'DHT11 shows current room values. LDR returns 0-4095 raw (remember: ESP32 is 12-bit), changes with light.'),
  ('00000000-0000-0000-0000-000000000411', 2,
   'Add the WiFi + WebServer code from Module 4.4 so the dashboard serves live DHT+LDR values at http://<esp32-ip>/.',
   'Dashboard loads in browser. Temperature + humidity update every 2 s. Light level classified dark/dim/bright based on thresholds you chose.'),
  ('00000000-0000-0000-0000-000000000411', 3,
   'Layer in MQTT. Every 30 s publish temp/humidity/light to `home/weather/<metric>` with retain=true. Subscribe to `home/weather/cmd` for "reset-minmax" and "sample-now".',
   'mosquitto_sub shows publishes landing every 30 s. Sending "reset-minmax" from mosquitto_pub immediately clears the tracked min/max on the dashboard.'),
  ('00000000-0000-0000-0000-000000000411', 4,
   'Add the HTTPUpdateServer to expose /update. Gate it with basic auth. Try flashing a tiny cosmetic change (dashboard title) over WiFi.',
   'Visit http://<esp32-ip>/update in a browser. Upload a new .bin exported from Arduino IDE. Device reboots. Dashboard now shows new title. No USB cable touched.'),
  ('00000000-0000-0000-0000-000000000411', 5,
   'Run the device continuously for 24 hours. Log min/max temp, any reconnects, any crashes.',
   'Uptime reports 24h+ without resets. Dashboard + MQTT both still working. A real device.'),
  ('00000000-0000-0000-0000-000000000411', 6,
   'Add a second subscriber elsewhere — a home-automation tool (Node-RED, Home Assistant) subscribed to `home/weather/#` that rings an alert when temp crosses a threshold.',
   'Cross-device event triggers based on your ESP32''s readings. The weather station is now an input into a bigger system — that''s what "IoT" means in practice.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000411', 1, 'danger',
   'Any device exposed to the internet (port-forwarded /update, public MQTT broker without auth) is a back door to your LAN. Default to local-only unless you can secure it properly.'),
  ('00000000-0000-0000-0000-000000000411', 2, 'caution',
   'Flash wear matters for 24/7 devices. Every ESP32 OTA write costs a flash erase cycle. Don''t auto-update from a CI pipeline that rebuilds on every commit — gate firmware releases manually.'),
  ('00000000-0000-0000-0000-000000000411', 3, 'info',
   'This capstone covers ~80% of real home-IoT work. Beyond here: LoRa for long range, battery + deep-sleep for remote sensors, time-series databases (InfluxDB) for historical charts, and Grafana dashboards.');

-- ───────────────────────── Phase 4 lesson ↔ components ─────
insert into public.lesson_components (lesson_id, component_slug, "order") values
  -- 4.1 ESP32 Setup
  ('00000000-0000-0000-0000-00000000040c', 'esp32',            1),
  ('00000000-0000-0000-0000-00000000040c', 'jumper-wires',     2),
  ('00000000-0000-0000-0000-00000000040c', 'multimeter',       3),
  ('00000000-0000-0000-0000-00000000040c', 'led',              4),
  ('00000000-0000-0000-0000-00000000040c', 'resistor',         5),

  -- 4.2 WiFi Fundamentals
  ('00000000-0000-0000-0000-00000000040d', 'esp32',            1),
  ('00000000-0000-0000-0000-00000000040d', 'jumper-wires',     2),

  -- 4.3 HTTP Client
  ('00000000-0000-0000-0000-00000000040e', 'esp32',            1),
  ('00000000-0000-0000-0000-00000000040e', 'jumper-wires',     2),

  -- 4.4 Web Server + Dashboard
  ('00000000-0000-0000-0000-00000000040f', 'esp32',            1),
  ('00000000-0000-0000-0000-00000000040f', 'breadboard',       2),
  ('00000000-0000-0000-0000-00000000040f', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-00000000040f', 'dht11',            4),

  -- 4.5 MQTT Pub/Sub
  ('00000000-0000-0000-0000-000000000410', 'esp32',            1),
  ('00000000-0000-0000-0000-000000000410', 'jumper-wires',     2),

  -- 4.6 IoT Capstone
  ('00000000-0000-0000-0000-000000000411', 'esp32',            1),
  ('00000000-0000-0000-0000-000000000411', 'breadboard',       2),
  ('00000000-0000-0000-0000-000000000411', 'jumper-wires',     3),
  ('00000000-0000-0000-0000-000000000411', 'dht11',            4),
  ('00000000-0000-0000-0000-000000000411', 'photoresistor',    5),
  ('00000000-0000-0000-0000-000000000411', 'resistor',         6)
on conflict do nothing;

-- ═══════════════════════════════════════════════════════════════════
-- ══════ ARDUINO PHASE 4 — CAPSTONE: AUTONOMOUS WHEELED ROBOT ═══════
-- ═══════════════════════════════════════════════════════════════════
-- Rewrites phase 4 of the Arduino course. The ESP32 IoT modules moved
-- to the new iot-with-esp32 course (phase id b5).

insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b4', 1, 'robot-motor-control',   '4.1',
   'Motor Control & Drive', 'handson', 'preview', 50,
   'L293D H-bridge, PWM speed, differential drive. How two geared motors plus an Arduino makes a platform that moves on command.'),
  ('00000000-0000-0000-0000-0000000000b4', 2, 'robot-sensing',         '4.2',
   'Sensing for Navigation', 'handson', 'not_started', 55,
   'HC-SR04 ultrasonic + IR avoidance + IR line-tracking. Fuse three sensors into the robot''s picture of the world in front of it.'),
  ('00000000-0000-0000-0000-0000000000b4', 3, 'robot-navigation',      '4.3',
   'Navigation State Machine', 'handson', 'not_started', 60,
   'Wander, follow-the-line, avoid-and-turn. Picking the right state machine turns raw sensor readings into actual movement choices.'),
  ('00000000-0000-0000-0000-0000000000b4', 4, 'robot-build',           '4.4',
   'Full Robot Build', 'project', 'not_started', 120,
   'Chassis assembly, battery, wiring everything together, final sketch. The wheeled robot that avoids obstacles, follows lines, and ships it.');

-- Lessons
insert into public.lessons (id, module_id, "order", title, body_md) values
  -- 4.1 Motor Control & Drive
  ('00000000-0000-0000-0000-000000000420',
   (select id from public.modules where slug = 'robot-motor-control'),
   1,
   'Motor Control & Drive',
   '## Why not just `digitalWrite` a motor?

Arduino pins source ~20 mA. A geared DC motor draws 150–500 mA. Hook the motor directly and you''ll kill the pin (and maybe the chip). Motors also need **reversible** current for forward/backward — a single pin can''t do that.

**Solution: the L293D H-bridge.** A 16-pin IC that sits between Arduino and the motor. Arduino sends logic-level commands; the L293D switches up to 600 mA from a separate battery supply.

## Differential drive

Two wheels, each driven by its own motor. Steering is *differential*: if both wheels spin the same speed → straight ahead. If one spins faster → turn. If they spin opposite directions → pivot in place. Dead simple mechanically.

| Left wheel | Right wheel | Result |
|---|---|---|
| Forward | Forward | Drive straight |
| Forward | Off | Gentle right curve |
| Forward | Reverse | Pivot right in place |
| Reverse | Reverse | Back up |

## L293D wiring cheat sheet

The chip has two channels (2 motors). Per motor:

| L293D pin | Connects to |
|---|---|
| Enable (EN1 / EN2) | Arduino **PWM pin** — controls speed 0–255 |
| Input 1 | Arduino digital pin — "direction A" |
| Input 2 | Arduino digital pin — "direction B" |
| Output 1 + 2 | Motor wires |
| Vcc1 (logic) | Arduino 5V |
| Vcc2 (motor) | Battery pack 6-9V |
| GND | Common ground between Arduino and battery |

**Two power supplies, one ground.** This is non-negotiable: the motor''s battery must share ground with the Arduino or the L293D sees inconsistent voltages and behaves randomly.

## The drive library you''ll build

Instead of remembering pin states, wrap them into intent-based functions:

```cpp
const int ENA = 5, IN1 = 6, IN2 = 7;       // left motor
const int ENB = 10, IN3 = 8, IN4 = 9;      // right motor

void motorL(int speed) {
  digitalWrite(IN1, speed >= 0 ? HIGH : LOW);
  digitalWrite(IN2, speed >= 0 ? LOW : HIGH);
  analogWrite(ENA, abs(speed));
}

void motorR(int speed) { /* same pattern */ }

void forward(int s) { motorL(s);   motorR(s); }
void back(int s)    { motorL(-s);  motorR(-s); }
void left(int s)    { motorL(-s);  motorR(s); }
void right(int s)   { motorL(s);   motorR(-s); }
void stop()         { motorL(0);   motorR(0); }
```

Now every higher layer (obstacle-avoidance, line-follow) just calls `forward(150)` or `left(180)`. Clean separation of intent from pin state.

## Calibration: matching left and right speeds

Two motors of the same model will still spin slightly differently. When you call `forward(150)`, the robot will curve gently. Compensate with per-motor trim:

```cpp
const float L_TRIM = 1.00;
const float R_TRIM = 0.92;   // this motor runs 8% hotter — scale it down

void forward(int s) {
  motorL(s * L_TRIM);
  motorR(s * R_TRIM);
}
```

Calibrate on a flat surface: drive forward for 3 seconds, measure how far it drifts left vs right, adjust trim, repeat.

## Takeaway

Motors need an H-bridge and their own power. Differential drive is two-wheel + differential speeds = all the steering you need. Wrap pin-poking in `forward/back/left/right` so your higher-level logic stays readable.'),

  -- 4.2 Sensing for Navigation
  ('00000000-0000-0000-0000-000000000421',
   (select id from public.modules where slug = 'robot-sensing'),
   1,
   'Sensing for Navigation',
   '## Three sensors, three questions

A mobile robot needs to answer three questions every few tens of milliseconds:

| Question | Sensor | Range |
|---|---|---|
| What''s directly ahead? | HC-SR04 ultrasonic | 2cm – 4m |
| Is something close on the sides? | IR avoidance modules | ~15cm |
| Is the floor a line or open? | IR line-tracking | surface contact |

Each alone is brittle; combined, they let the robot handle a living-room floor reliably.

## HC-SR04 ultrasonic — the robot''s "eyes forward"

Two pins: `TRIG` (pulse to send ping) and `ECHO` (pulse-width = return time). Distance in cm = `echo_µs / 58`.

```cpp
const int TRIG = 11, ECHO = 12;

float readDistance() {
  digitalWrite(TRIG, LOW);   delayMicroseconds(2);
  digitalWrite(TRIG, HIGH);  delayMicroseconds(10);
  digitalWrite(TRIG, LOW);
  long us = pulseIn(ECHO, HIGH, 30000);   // 30 ms timeout = max ~5m
  return us / 58.0;
}
```

**Quirks:**

- `pulseIn` *blocks* for up to its timeout. For a tight main loop, poll at ~10 Hz not faster.
- Soft/absorbent surfaces (curtains, carpets) scatter the ping — reading is noisy.
- Smooth at ≈30° off-axis, nothing returns.

## IR avoidance modules — "is there a wall on my side?"

Two modules mounted 45° left and right of center. Output is digital: LOW when something is within ~15 cm.

```cpp
const int AVOID_L = A0, AVOID_R = A1;   // either digital or analog input works

bool leftClear()  { return digitalRead(AVOID_L) == HIGH; }
bool rightClear() { return digitalRead(AVOID_R) == HIGH; }
```

Faster than ultrasonic (no pulseIn timing), lower range, simpler. Perfect for side-detection.

## IR line-tracking — "am I still on the line?"

Three modules underneath the chassis facing down, ~5 mm above the floor. Each outputs LOW on a black surface, HIGH on white.

```cpp
// 3-sensor array
int left   = digitalRead(TRACK_L);
int center = digitalRead(TRACK_C);
int right  = digitalRead(TRACK_R);

// encode as a bitfield
int pattern = (left << 2) | (center << 1) | right;

switch (pattern) {
  case 0b010: /* centered */ break;
  case 0b011:
  case 0b001: /* drifting right */ break;
  case 0b110:
  case 0b100: /* drifting left */ break;
  case 0b111: /* lost line */ break;
}
```

This is how classic line-following robots work.

## Sensor fusion pattern

Don''t trust any one reading. Sample all three, then decide:

```cpp
struct World {
  float dist;       // ahead distance in cm
  bool  leftBlocked;
  bool  rightBlocked;
  int   linePattern;
};

World sense() {
  World w;
  w.dist         = readDistance();
  w.leftBlocked  = !leftClear();
  w.rightBlocked = !rightClear();
  w.linePattern  = readLinePattern();
  return w;
}
```

The navigation state machine (Module 4.3) consumes one `World` per loop iteration and picks actions accordingly.

## Takeaway

Ultrasonic for forward distance, IR for side proximity, line-tracking for ground pattern. Poll all three at ~10 Hz, bundle into a `World` struct, hand to the navigator.'),

  -- 4.3 Navigation State Machine
  ('00000000-0000-0000-0000-000000000422',
   (select id from public.modules where slug = 'robot-navigation'),
   1,
   'Navigation State Machine',
   '## The decision layer

Sensors give you `World`. Motors take `forward(speed)`. Between them is the navigator: a state machine that picks the next motor action based on what the sensors just said.

## Two modes, one chassis

We''ll support **two distinct behaviors** the user can switch between:

### Mode A — Wander & Avoid (free-roaming)

```
FORWARD   → if dist < 25cm → AVOID
AVOID     → back up 300ms → pick turn direction (based on which side is clearer) → turn 500ms → FORWARD
STUCK     → if still blocked after 3 avoid attempts → 180° turn → FORWARD
```

### Mode B — Line Following

```
ON_LINE    → line pattern 010 → forward at normal speed
DRIFT_L    → pattern 011 or 001 → slight right correction
DRIFT_R    → pattern 110 or 100 → slight left correction
LOST       → pattern 111 or 000 → stop + search (sweep left/right until line reappears)
```

## The skeleton

```cpp
enum Mode { AVOID_MODE, LINE_MODE };
enum AvoidState { FORWARD, BACKING, TURNING, STUCK };

Mode mode = AVOID_MODE;
AvoidState aState = FORWARD;
unsigned long stateEntered = 0;
int avoidAttempts = 0;

void enter(AvoidState s) {
  aState = s;
  stateEntered = millis();
  Serial.print("→ ");
  Serial.println(s);
}

void loop() {
  World w = sense();

  if (mode == AVOID_MODE) navigateAvoid(w);
  else                    navigateLine(w);
}

void navigateAvoid(World w) {
  switch (aState) {
    case FORWARD:
      if (w.dist < 25 && w.dist > 2) { enter(BACKING); back(140); break; }
      forward(150);
      break;

    case BACKING:
      if (millis() - stateEntered > 300) { enter(TURNING); break; }
      break;

    case TURNING: {
      if (millis() - stateEntered == 0) {
        // Pick direction: turn toward the clearer side.
        if (w.leftBlocked && !w.rightBlocked)      right(160);
        else if (w.rightBlocked && !w.leftBlocked) left(160);
        else                                        left(160);  // default
      }
      if (millis() - stateEntered > 500) {
        avoidAttempts++;
        if (avoidAttempts >= 3) { enter(STUCK); break; }
        enter(FORWARD);
      }
      break;
    }

    case STUCK:
      left(180);
      if (millis() - stateEntered > 1000) { avoidAttempts = 0; enter(FORWARD); }
      break;
  }
}
```

## Why states, not flags

First-attempt code tends to look like:

```cpp
if (tooClose) {
  back(140); delay(300);
  right(160); delay(500);
  // robot is frozen for 800ms doing nothing else
}
```

`delay(800)` blocks everything — the robot can''t react to a newly-appearing obstacle, can''t check if the turn is long enough, can''t honor a mode switch. The state-machine version is **non-blocking**: every case handler runs in microseconds, the loop spins at kHz, and every 100 ms the behavior re-evaluates based on fresh sensor data.

## Mode switching

A button (or an IR remote code, or a specific serial command) toggles between `AVOID_MODE` and `LINE_MODE`:

```cpp
if (digitalRead(MODE_BTN) == LOW && millis() - lastSwitch > 300) {
  mode = (mode == AVOID_MODE) ? LINE_MODE : AVOID_MODE;
  lastSwitch = millis();
  stop();
  Serial.print("mode: "); Serial.println(mode);
}
```

## Debug tips

- **LED per state** — wire 4 small LEDs, light one based on `aState`. Watching them flicker is faster than staring at Serial.
- **Print only on transitions** — `if (newState != lastState)` gate. Otherwise you drown the monitor.
- **Start slow** — first runs at `forward(100)`, not `forward(255)`. A fast mistake hits the wall hard.

## Takeaway

The navigator is a state machine that consumes sensor data and emits motor commands. Every state handler is a few lines. Every transition is either a sensor threshold or a time elapsed. No delays anywhere. The robot feels alive because it''s actually checking the world ten times per second.'),

  -- 4.4 Full Robot Build
  ('00000000-0000-0000-0000-000000000423',
   (select id from public.modules where slug = 'robot-build'),
   1,
   'Full Robot Build',
   '## Ship the robot

You have the motor library (4.1), the sensor fusion (4.2), and the state machine (4.3). Now assemble it all into something that rolls on a real floor.

## Parts shopping list

| | Item | Source |
|---|---|---|
| 1 | 2WD acrylic chassis (plate + motors + wheels + caster) | Amazon/AliExpress "Arduino 2WD smart car kit" |
| 1 | L293D IC | from your kit |
| 1 | HC-SR04 ultrasonic | from the 37-in-1 or separate |
| 2 | IR avoidance modules | 37-in-1 |
| 3 | IR line-tracking modules | 37-in-1 (if included) or separate |
| 1 | 9V battery + holder OR 4× AA pack | Anywhere |
| 1 | Arduino Uno | Yours |
| 1 | Mini breadboard (400-tie) | Fits on chassis |

## Wiring — the whole beast

```
┌───────────────────── Arduino Uno ─────────────────────┐
│                                                       │
│ 5V ────────┐         6,7,8,9 ──→ L293D IN1-4          │
│ GND ──────┬┘         5,10 ────→ L293D EN1,EN2 (PWM)   │
│           │          11 ─────→ HC-SR04 TRIG            │
│           │          12 ─────→ HC-SR04 ECHO            │
│           │          A0,A1 ──→ IR avoidance L,R        │
│           │          A2,A3,A4→ Line-track L,C,R        │
│           │          2 ──────→ Mode button (INPUT_PULLUP)
│           │                                           │
└───────────┼───────────────────────────────────────────┘
            │
            ↓
        common GND ←──── battery pack GND
        battery pack + ──→ L293D Vcc2 (motor power, 6-9V)
        L293D OUT1,2 ──→ left motor
        L293D OUT3,4 ──→ right motor
```

**Critical:** the battery''s negative terminal must connect to the Arduino''s GND. Without the shared ground, the L293D sees floating logic levels and the motors twitch randomly.

## Build order

1. **Mechanical first** — assemble the chassis, mount the motors, attach wheels + caster. Verify wheels spin freely when you push them.
2. **Wire the motor circuit standalone** — just Arduino, L293D, motors, battery. Upload a sketch that does `forward(150); delay(2000); stop(); delay(1000); back(150); delay(2000); stop();` Confirm both motors behave as expected.
3. **Calibrate the trim** — drive forward for 3 seconds, measure drift, adjust `L_TRIM` / `R_TRIM`.
4. **Add ultrasonic** — mount on the front of the chassis, wire, print distance in Serial while waving a hand in front.
5. **Add IR avoidance** — side-mount modules at 45°, wire, verify LOW on proximity.
6. **Add line-tracking** — mount 3 modules underneath facing down, ~5 mm gap. Use a black-taped test track.
7. **Merge the sketch** — pull in motor lib + sensor fusion + navigator. Upload. Watch Serial as the robot does its thing on the floor.
8. **Tune** — speed too high? Slow it down. Turning not enough? Increase turn duration. Lost-line detection too sensitive? Adjust thresholds.

## The final sketch (skeleton)

```cpp
void setup() {
  Serial.begin(9600);
  // pinMode for motor pins, line-track, mode button (INPUT_PULLUP)
  // no pinMode needed for analogRead pins
  stop();
  delay(2000);   // settle time before the wheels start turning
}

void loop() {
  handleModeButton();
  World w = sense();

  if (mode == AVOID_MODE) navigateAvoid(w);
  else                    navigateLine(w);
}
```

Upload. Put it on the floor. Let go.

## Where to take it next

The same chassis + microcontroller + this codebase is the foundation for:

- **Robotic arm with hand gestures** — swap chassis for a 6-DOF arm kit; feed gesture data (MPU6050 glove) over wires into the motor library. Arduino is fine for up to 6 servos.
- **Phone-controlled drone** — genuinely different animal. Drones need brushless motors, ESCs, a flight controller (the math for attitude stabilization is non-trivial). Not a 4-module capstone — but if you want to tackle it, start with a ready-made flight controller (KK2.1 or Naze32) and build the radio/phone layer on top.
- **Maze-solver** — keep the current chassis, add wall-follow logic (always hug the right wall), plus a short history buffer to detect "I''ve been here before".

## Takeaway

You''ve gone from "LED blinks" in Phase 1 to "autonomous vehicle" in Phase 4. Every piece — motor control, sensor fusion, state machines, non-blocking timing — is a pattern that transfers directly to any robotics or IoT project. The Arduino curriculum ends here. **The ESP32 course** is where your web-dev skills finally pay off — open that up next.');

-- Hands-on, safety, components for Arduino Phase 4
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000420', 1,
   'Wire one DC motor to L293D: EN to pin 5, IN1 to 6, IN2 to 7, OUT1/OUT2 to the motor. Power the L293D motor side (Vcc2) from a 9V battery, logic side (Vcc1) from Arduino 5V. Connect both grounds.',
   'Upload a test sketch that spins the motor forward for 2s, then reverse for 2s. Motor turns smoothly in both directions. If it only goes one way, swap IN1 and IN2.'),
  ('00000000-0000-0000-0000-000000000420', 2,
   'Add PWM speed control: vary the enable pin with analogWrite(EN, 80) then 160 then 240.',
   'Motor speed increases noticeably at each step. Below ~50 the motor stalls (not enough torque to overcome friction). Find your minimum usable PWM value.'),
  ('00000000-0000-0000-0000-000000000420', 3,
   'Wire the second motor on EN=10, IN3=8, IN4=9. Write forward(), back(), left(), right(), stop() wrapper functions.',
   'Call each in sequence with delay(1000) between. Both motors behave correctly: forward = same dir, left = opposite dirs for pivot.'),
  ('00000000-0000-0000-0000-000000000420', 4,
   'Mount both motors to the chassis, add wheels + caster. Drive forward on a flat floor for 3 seconds. Measure how far it drifts left or right.',
   'Drift < 5cm over 3 seconds = good enough. More? Adjust L_TRIM/R_TRIM (start at 1.00 and 0.95, iterate).');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000420', 1, 'danger',
   'Never power motors from the Arduino 5V pin. Pin limit is 200 mA; a single geared motor draws 150-500 mA. You WILL fry the regulator.'),
  ('00000000-0000-0000-0000-000000000420', 2, 'caution',
   'Battery pack GND and Arduino GND MUST be connected. Without a shared ground, the L293D sees undefined logic levels and motors behave randomly.'),
  ('00000000-0000-0000-0000-000000000420', 3, 'info',
   'Add a 0.1 µF ceramic capacitor across each motor''s terminals. Kills the high-frequency noise that otherwise makes sensors flicker.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000421', 1,
   'Wire HC-SR04: TRIG to pin 11, ECHO to pin 12, VCC to 5V, GND to GND. Write the trigger-pulse + pulseIn pattern. Print distance in cm every 200 ms.',
   'Distance reading tracks your hand: ~10 cm close, ~40 cm at arm''s length, ~200+ cm pointing at the ceiling. Numbers wobble by 1-2 cm — normal.'),
  ('00000000-0000-0000-0000-000000000421', 2,
   'Wire two IR avoidance modules on A0 (left) and A1 (right). Print HIGH/LOW of each every 100 ms while passing your hand in front.',
   'Module outputs flip to LOW when hand is within ~15cm. On-board LEDs light when triggered. Adjust trim-pots if the range feels wrong.'),
  ('00000000-0000-0000-0000-000000000421', 3,
   'If you have 3 IR line-tracking modules: mount under the chassis facing down, wire to A2/A3/A4. Slide the robot across a black-taped white paper. Print the 3-bit pattern (left<<2 | center<<1 | right).',
   'Over white: pattern 0. Over the taped line: one or more bits light up (010 centered, 011/001 drifting, etc.). Readings change sharply at the tape edge.'),
  ('00000000-0000-0000-0000-000000000421', 4,
   'Build the World struct and a sense() function that returns all four readings at once. Call it at 10 Hz from loop().',
   'One compact Serial line every 100 ms: dist=42.3 L=0 R=0 pat=010. Single source of truth for the navigator.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000421', 1, 'caution',
   'HC-SR04''s pulseIn call blocks for up to 30 ms (the default timeout). Don''t sample it faster than 10 Hz or your loop slows down noticeably.'),
  ('00000000-0000-0000-0000-000000000421', 2, 'info',
   'Ultrasonic readings get noisy over soft surfaces (carpet, curtains). If your robot misses couches, mount the sensor higher so it pings hard backs, not cushions.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000422', 1,
   'Implement the AvoidState enum and FORWARD/BACKING/TURNING/STUCK handlers. Each handler prints its state name on entry, only on transitions.',
   'Drive toward a wall. Serial shows: FORWARD → BACKING → TURNING → FORWARD. No duplicate prints.'),
  ('00000000-0000-0000-0000-000000000422', 2,
   'Add the "turn toward the clearer side" logic using leftBlocked / rightBlocked. Test at a corner.',
   'Robot approaches corner, picks the open side instead of always defaulting to left. Serial shows the decision.'),
  ('00000000-0000-0000-0000-000000000422', 3,
   'Add STUCK state: after 3 failed avoid attempts, execute a 180° rotation. Tune the rotation duration on your chassis.',
   'Cornered robot escapes by spinning ~180° and trying a new direction. Rotation takes ~1 second on most 2WD chassis.'),
  ('00000000-0000-0000-0000-000000000422', 4,
   'Add a mode button on pin 2 (INPUT_PULLUP). Press cycles between AVOID_MODE and LINE_MODE. Print the mode on change.',
   'Single press → single mode switch. Held button doesn''t spam transitions. Motors stop during the switch.'),
  ('00000000-0000-0000-0000-000000000422', 5,
   'Implement the LINE_MODE navigator. Test on a taped track. Tune correction intensity until the robot follows a sharp curve cleanly.',
   'Robot stays on the line through straight sections AND a 90° turn. If it runs off, gentle corrections aren''t strong enough — increase the turn speed.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000422', 1, 'info',
   'Set `forward(100)` for the first test drive. You can crank it up later; you can''t un-break a wall.'),
  ('00000000-0000-0000-0000-000000000422', 2, 'caution',
   '`delay()` anywhere inside loop() or its callees = robot becomes blind for that duration. A 100 ms delay means your obstacle check happens at 10 Hz max — fine. A 500 ms delay means you hit walls.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000423', 1,
   'Assemble the acrylic chassis per its instructions. Mount motors, wheels, caster. Spin each wheel by hand — should rotate freely with slight resistance.',
   'Chassis assembled. Wheels spin smoothly. If there''s binding, loosen the motor mounts and re-tighten gradually.'),
  ('00000000-0000-0000-0000-000000000423', 2,
   'Mount the mini breadboard + Arduino on the top plate. Wire the L293D as in Module 4.1. Run the "forward 2s / back 2s" test with the chassis elevated (wheels spinning in the air).',
   'Both wheels spin in sync forward, then reverse. If one is reversed, swap its IN1/IN2 wiring (not the physical motor wires).'),
  ('00000000-0000-0000-0000-000000000423', 3,
   'Mount the HC-SR04 on the chassis front (looking ahead) and two IR avoidance modules at 45° off the sides. Wire and verify with Serial prints while hand-waving.',
   'Ultrasonic returns distance to your hand. Both IR modules flip to LOW when hand is nearby. Robot (still airborne) stops backing up when no obstacle.'),
  ('00000000-0000-0000-0000-000000000423', 4,
   'Put robot on the floor. Upload the AVOID-mode sketch from 4.3. Let go.',
   'Robot drives forward, encounters wall, backs up, turns, continues. Runs for 2+ minutes without getting stuck. If stuck often, extend the STUCK-state rotation.'),
  ('00000000-0000-0000-0000-000000000423', 5,
   'Mount 3 IR line-trackers underneath (~5mm above the floor, centered). Tape a 2-3 meter black-tape track on white paper. Switch to LINE mode.',
   'Robot follows the tape through straight sections + a 90° curve. Keeps line within its 3-sensor array the whole way.'),
  ('00000000-0000-0000-0000-000000000423', 6,
   'Log the build to your experiments feed with a 2-paragraph reflection: what surprised you, what you''d change. Export the sketch as a named file for reuse.',
   'Experiment entry exists. Sketch saved to `arduino-robot-v1.ino`. You own a working autonomous robot. Course done.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000423', 1, 'danger',
   'Never leave a running robot unattended on a raised surface. It WILL find the edge of the table.'),
  ('00000000-0000-0000-0000-000000000423', 2, 'caution',
   'Fresh 9V batteries last 20-40 minutes driving motors. Budget for rechargeables if you run long tests. A dying battery = erratic behavior as voltage sags.'),
  ('00000000-0000-0000-0000-000000000423', 3, 'info',
   'The same chassis + codebase extends to a robotic-arm build (swap drive motors for servos + gesture glove) or a maze-solver (add wall-follow logic). Phone-controlled drones are a different beast entirely — see the final section of this lesson.');

-- lesson_components
insert into public.lesson_components (lesson_id, component_slug, "order") values
  ('00000000-0000-0000-0000-000000000420', 'arduino-uno',    1),
  ('00000000-0000-0000-0000-000000000420', 'breadboard',     2),
  ('00000000-0000-0000-0000-000000000420', 'jumper-wires',   3),
  ('00000000-0000-0000-0000-000000000420', 'l293d',          4),
  ('00000000-0000-0000-0000-000000000420', 'dc-motor',       5),
  ('00000000-0000-0000-0000-000000000420', 'robot-chassis',  6),
  ('00000000-0000-0000-0000-000000000420', 'multimeter',     7),

  ('00000000-0000-0000-0000-000000000421', 'arduino-uno',    1),
  ('00000000-0000-0000-0000-000000000421', 'breadboard',     2),
  ('00000000-0000-0000-0000-000000000421', 'jumper-wires',   3),
  ('00000000-0000-0000-0000-000000000421', 'ultrasonic',     4),
  ('00000000-0000-0000-0000-000000000421', 'ir-avoidance',   5),
  ('00000000-0000-0000-0000-000000000421', 'ir-tracking',    6),

  ('00000000-0000-0000-0000-000000000422', 'arduino-uno',    1),
  ('00000000-0000-0000-0000-000000000422', 'robot-chassis',  2),
  ('00000000-0000-0000-0000-000000000422', 'l293d',          3),
  ('00000000-0000-0000-0000-000000000422', 'dc-motor',       4),
  ('00000000-0000-0000-0000-000000000422', 'ultrasonic',     5),
  ('00000000-0000-0000-0000-000000000422', 'ir-avoidance',   6),
  ('00000000-0000-0000-0000-000000000422', 'ir-tracking',    7),
  ('00000000-0000-0000-0000-000000000422', 'button',         8),

  ('00000000-0000-0000-0000-000000000423', 'arduino-uno',    1),
  ('00000000-0000-0000-0000-000000000423', 'robot-chassis',  2),
  ('00000000-0000-0000-0000-000000000423', 'l293d',          3),
  ('00000000-0000-0000-0000-000000000423', 'dc-motor',       4),
  ('00000000-0000-0000-0000-000000000423', 'ultrasonic',     5),
  ('00000000-0000-0000-0000-000000000423', 'ir-avoidance',   6),
  ('00000000-0000-0000-0000-000000000423', 'ir-tracking',    7),
  ('00000000-0000-0000-0000-000000000423', 'breadboard',     8),
  ('00000000-0000-0000-0000-000000000423', 'jumper-wires',   9),
  ('00000000-0000-0000-0000-000000000423', 'multimeter',    10)
on conflict do nothing;

-- ═══════════════════════════════════════════════════════════════════
-- ════════════════ ESP32 COURSE · PHASE 2 · DEEP DIVE ═══════════════
-- ═══════════════════════════════════════════════════════════════════

insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b6', 1, 'freertos-multitasking',  '2.1',
   'FreeRTOS: Multi-tasking', 'handson', 'preview', 55,
   'Run concurrent tasks on the ESP32''s dual cores. Queues + semaphores + priorities — the real power of the chip.'),
  ('00000000-0000-0000-0000-0000000000b6', 2, 'deep-sleep-battery',     '2.2',
   'Deep Sleep & Battery Operation', 'handson', 'not_started', 45,
   'Wake on timer, wake on GPIO, wake on touch. Take an ESP32 from 150 mA awake to 10 µA asleep. Run for a year on a coin cell.'),
  ('00000000-0000-0000-0000-0000000000b6', 3, 'bluetooth-le',           '2.3',
   'Bluetooth LE', 'handson', 'not_started', 55,
   'Advertise a GATT service. Pair with your phone. Read sensor data over BLE. The protocol every fitness tracker speaks.'),
  ('00000000-0000-0000-0000-0000000000b6', 4, 'esp-now',                '2.4',
   'ESP-NOW: Router-less Mesh', 'handson', 'not_started', 40,
   'Direct ESP32 ↔ ESP32 messaging. 250 kbps, ~200 m range, no WiFi router in the middle. Perfect for sensor nets.'),
  ('00000000-0000-0000-0000-0000000000b6', 5, 'secure-mqtt',            '2.5',
   'Secure MQTT with TLS + mTLS', 'handson', 'not_started', 50,
   'TLS on port 8883 for encryption. Mutual TLS with client certificates for identity. Production-grade auth.'),
  ('00000000-0000-0000-0000-0000000000b6', 6, 'ota-strategies',         '2.6',
   'OTA Strategies That Don''t Brick Devices', 'theory', 'not_started', 40,
   'A/B partitions, rollback, staged rollouts, signature verification. How production IoT fleets update 10,000 devices without losing half.');

-- Lessons
insert into public.lessons (id, module_id, "order", title, body_md) values
  ('00000000-0000-0000-0000-000000000430',
   (select id from public.modules where slug = 'freertos-multitasking'),
   1,
   'FreeRTOS: Multi-tasking',
   '## The dual core is real

The ESP32 has two 240 MHz Xtensa cores (LX6) and runs FreeRTOS underneath the Arduino framework. Every `loop()` you''ve written so far runs in a single task pinned to one core — with the other one sitting idle. FreeRTOS lets you fix that.

## Tasks — the unit of concurrency

A task is a function that runs independently with its own stack. Multiple tasks time-slice within a core; two cores give you real parallelism.

```cpp
void sensorTask(void* param) {
  while (true) {
    float t = readTemp();
    Serial.printf("[sensor] %.1f\\n", t);
    vTaskDelay(pdMS_TO_TICKS(1000));   // yield for 1 second
  }
}

void networkTask(void* param) {
  while (true) {
    mqttPublishIfConnected();
    vTaskDelay(pdMS_TO_TICKS(5000));
  }
}

void setup() {
  Serial.begin(115200);
  // xTaskCreatePinnedToCore(fn, name, stackSize, param, priority, handle, core)
  xTaskCreatePinnedToCore(sensorTask,  "sensor",  4096, NULL, 1, NULL, 0);
  xTaskCreatePinnedToCore(networkTask, "network", 8192, NULL, 1, NULL, 1);
}

void loop() { vTaskDelete(NULL); }  // we don''t need the default loop task
```

Two tasks, one per core, running truly in parallel. `vTaskDelay` yields the CPU — use it instead of `delay()` inside tasks.

## Queues — passing data between tasks

```cpp
QueueHandle_t readingsQ;

void producer(void* p) {
  while (true) {
    float v = readTemp();
    xQueueSend(readingsQ, &v, 0);
    vTaskDelay(pdMS_TO_TICKS(1000));
  }
}

void consumer(void* p) {
  float v;
  while (true) {
    if (xQueueReceive(readingsQ, &v, portMAX_DELAY) == pdTRUE) {
      mqtt.publish("sensor/temp", String(v).c_str());
    }
  }
}

void setup() {
  readingsQ = xQueueCreate(10, sizeof(float));  // 10-slot buffer
  xTaskCreate(producer, "p", 2048, NULL, 1, NULL);
  xTaskCreate(consumer, "c", 4096, NULL, 1, NULL);
}
```

Bounded buffer with blocking semantics. If the consumer falls behind, `xQueueSend` can optionally block the producer.

## Semaphores — protecting shared state

```cpp
SemaphoreHandle_t i2cMutex;

void taskA(void* p) {
  while (true) {
    xSemaphoreTake(i2cMutex, portMAX_DELAY);
    /* read from I2C sensor here */
    xSemaphoreGive(i2cMutex);
    vTaskDelay(pdMS_TO_TICKS(100));
  }
}
```

Only one task can own the mutex at a time. Essential when two tasks share a bus (I2C, SPI).

## Priority + starvation

Task priorities are 0–24. Higher = more urgent. A high-priority task that never yields will starve lower-priority ones. Rule: any task that loops forever MUST call `vTaskDelay()`, `xQueueReceive()`, or similar blocking primitive.

## Debug: watch the tasks

```cpp
char buf[512];
vTaskList(buf);
Serial.println(buf);
```

Prints every task''s state, priority, and free stack. Useful for finding stack overflows.

## Takeaway

Tasks + queues + semaphores are the building blocks. Pin heavy work (WiFi, audio processing) to core 1, keep sensor loops on core 0. Never call a blocking primitive inside an ISR.'),

  ('00000000-0000-0000-0000-000000000431',
   (select id from public.modules where slug = 'deep-sleep-battery'),
   1,
   'Deep Sleep & Battery Operation',
   '## 150 mA down to 10 µA

An awake ESP32 draws 80-240 mA (WiFi peaks). Deep sleep strips everything down to the RTC + optional ULP coprocessor — **10 µA** in the right config. That''s the difference between a 2-hour battery life and a year.

## Power consumption cheat sheet

| Mode | Current | Uses |
|---|---|---|
| Active (WiFi TX) | 240 mA | Network operations |
| Active (no radio) | 80 mA | Compute, GPIO |
| Modem sleep | 20 mA | Pause WiFi briefly |
| Light sleep | 0.8 mA | CPU halted, RAM retained |
| **Deep sleep** | **10 µA** | RTC runs, everything else off |

Deep sleep loses all RAM *except* RTC slow memory (8 KB) — values you put there survive the wake/sleep cycle.

## The sleep cycle

```cpp
#include <esp_sleep.h>

RTC_DATA_ATTR int bootCount = 0;   // survives deep sleep

void setup() {
  Serial.begin(115200);
  bootCount++;
  Serial.printf("boot #%d\\n", bootCount);

  // ... do work here (sensor read, publish, etc.) ...

  Serial.println("sleeping 10s");
  esp_sleep_enable_timer_wakeup(10 * 1000000ULL);   // microseconds
  esp_deep_sleep_start();
}

void loop() {}   // never reached
```

Each wake is a fresh boot. Your app lives entirely in `setup()`. Keep the awake time minimal: WiFi connect + MQTT publish + sleep is ~3-8 seconds on a good network.

## Wake sources

| Source | Enable | Typical use |
|---|---|---|
| **Timer** | `esp_sleep_enable_timer_wakeup()` | Periodic sensor reports |
| **EXT0** (single GPIO) | `esp_sleep_enable_ext0_wakeup(GPIO_NUM_33, HIGH)` | Button, door reed switch |
| **EXT1** (multi GPIO) | `esp_sleep_enable_ext1_wakeup(mask, mode)` | Multi-button wake |
| **Touch** | `touchAttachInterrupt()` | Capacitive wake pad |
| **ULP** | ULP script | Wake only if sensor threshold crossed |

Check the reason on wake:

```cpp
esp_sleep_wakeup_cause_t cause = esp_sleep_get_wakeup_cause();
if (cause == ESP_SLEEP_WAKEUP_EXT0) { /* button */ }
```

## Hardware gotchas that cost battery

- **Onboard LEDs** — dev board power LEDs alone draw 5-15 mA. In production, physically desolder them or use a board without them.
- **Voltage regulator quiescent current** — AMS1117 (common on dev boards) wastes 5-10 mA even when the ESP32 is asleep. For real battery projects, swap for an HT7833 or MCP1700 (both <5 µA quiescent).
- **Serial chip (CP2102)** — stays powered unless you cut its VCC trace.

A naked ESP32-WROOM module on a custom PCB with a proper LDO can genuinely hit 10 µA. Off-the-shelf dev boards land around 200-500 µA, still good for weeks/months on a coin cell.

## Battery math

AA alkaline: ~2500 mAh. Device that sleeps 99.9% of the time averaging 250 µA:

```
2500 mAh / 0.25 mA = 10,000 hours ≈ 14 months
```

A 2000 mAh LiPo (rechargeable, common with solar + TP4056 charger) can run a well-designed sensor node indefinitely.

## Takeaway

Build your sketch as "wake → do one thing → sleep immediately". Every millisecond awake costs 100× the sleep current. Combine with a timer wakeup for periodic reports; combine with EXT0 for event-driven sensors.'),

  ('00000000-0000-0000-0000-000000000432',
   (select id from public.modules where slug = 'bluetooth-le'),
   1,
   'Bluetooth LE',
   '## Why BLE instead of (or as well as) WiFi?

BLE is a different radio with different tradeoffs:

| | WiFi | BLE |
|---|---|---|
| Throughput | 20+ Mbps | 250 kbps typical |
| Range | 30-100 m | 10-30 m |
| Power | 100+ mA while active | 1-10 mA typical |
| Pairing flow | Requires router, DHCP | Direct to phone |
| Typical use | Dashboards, streaming | Sensors, notifications, fitness |

BLE is the protocol behind every fitness band, every smart lock, every "tap your phone to configure" IoT device.

## GATT — BLE''s data model

GATT (Generic Attribute Profile) organizes data into a 3-level hierarchy:

```
Device
├── Service (UUID)         e.g. Heart Rate Service 0x180D
│   ├── Characteristic A   Heart Rate Measurement 0x2A37 (notify)
│   ├── Characteristic B   Body Sensor Location 0x2A38 (read)
│   └── ...
└── Service (another UUID)
```

- **Read** — client fetches current value
- **Write** — client sets a new value
- **Notify** — server pushes updates to subscribed clients

## A minimum peripheral (ESP32 as BLE server)

```cpp
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

// Invent UUIDs (or use https://www.uuidgenerator.net)
#define SERVICE_UUID        "12345678-0000-1000-8000-00805f9b34fb"
#define CHARACTERISTIC_UUID "12345678-0001-1000-8000-00805f9b34fb"

BLECharacteristic* characteristic;

void setup() {
  Serial.begin(115200);
  BLEDevice::init("trainor-esp32");
  BLEServer* server = BLEDevice::createServer();
  BLEService* service = server->createService(SERVICE_UUID);

  characteristic = service->createCharacteristic(
    CHARACTERISTIC_UUID,
    BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY
  );
  characteristic->addDescriptor(new BLE2902());   // enables notifications

  service->start();
  BLEAdvertising* adv = BLEDevice::getAdvertising();
  adv->addServiceUUID(SERVICE_UUID);
  adv->start();
}

void loop() {
  float v = random(200, 300) / 10.0;   // fake sensor
  characteristic->setValue(String(v).c_str());
  characteristic->notify();
  delay(1000);
}
```

Upload. On your phone, install **nRF Connect** (free, iOS + Android). Scan — you''ll see `trainor-esp32`. Tap it, expand the service, tap the characteristic, hit "subscribe to notifications". Values stream in every second.

## Writing from phone to ESP32

Add `PROPERTY_WRITE` and a callback:

```cpp
class Callback : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic* c) override {
    std::string val = c->getValue();
    Serial.printf("got: %s\\n", val.c_str());
    if (val == "on")  digitalWrite(LED_BUILTIN, HIGH);
    if (val == "off") digitalWrite(LED_BUILTIN, LOW);
  }
};

characteristic->setCallbacks(new Callback());
```

Now the phone can send `"on"` or `"off"` to the characteristic; LED responds.

## Takeaway

BLE is perfect for low-power sensor nodes and phone-pairing flows. The ESP32''s BLE stack is heavy (~100 KB flash, 30 KB RAM) — budget accordingly. For battery projects, BLE-only + deep sleep between advertises wins over WiFi.'),

  ('00000000-0000-0000-0000-000000000433',
   (select id from public.modules where slug = 'esp-now'),
   1,
   'ESP-NOW: Router-less Mesh',
   '## WiFi without WiFi

ESP-NOW is Espressif''s proprietary peer-to-peer protocol that rides on the WiFi radio but **doesn''t need an access point**. Two ESP32s find each other by MAC address and exchange up to 250 bytes per message at ~250 kbps over a claimed 200-meter line-of-sight range.

Use cases:

- Sensor network in a barn or greenhouse (no router out there)
- Quick device-to-device telemetry (two robots coordinating)
- Fallback channel when main WiFi is down

## The programming model — send and receive callbacks

```cpp
#include <esp_now.h>
#include <WiFi.h>

// Peer MAC — get this from the receiver''s WiFi.macAddress()
uint8_t peerMac[] = { 0x24, 0x6F, 0x28, 0xAA, 0xBB, 0xCC };

typedef struct {
  int id;
  float temp;
  float humidity;
} Reading;

void onSent(const uint8_t* mac, esp_now_send_status_t status) {
  Serial.printf("sent: %s\\n", status == ESP_NOW_SEND_SUCCESS ? "ok" : "fail");
}

void setup() {
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  esp_now_init();
  esp_now_register_send_cb(onSent);

  esp_now_peer_info_t peer = {};
  memcpy(peer.peer_addr, peerMac, 6);
  peer.channel = 0;
  peer.encrypt = false;
  esp_now_add_peer(&peer);
}

void loop() {
  Reading r = { .id = 1, .temp = 22.5, .humidity = 58 };
  esp_now_send(peerMac, (uint8_t*)&r, sizeof(r));
  delay(5000);
}
```

Receiver side:

```cpp
void onReceive(const uint8_t* mac, const uint8_t* data, int len) {
  Reading r;
  memcpy(&r, data, sizeof(r));
  Serial.printf("node %d: %.1f°C %.0f%%\\n", r.id, r.temp, r.humidity);
}

void setup() {
  WiFi.mode(WIFI_STA);
  esp_now_init();
  esp_now_register_recv_cb(onReceive);
}
```

No handshake, no connection state — ESP-NOW is essentially broadcast with optional unicast.

## Pros and cons vs WiFi+MQTT

| | ESP-NOW | WiFi+MQTT |
|---|---|---|
| Setup complexity | Low (just MACs) | High (broker + WiFi creds) |
| Power | Can pair with deep sleep cleanly | WiFi connect takes 2-5s per wake |
| Range | Better (no AP in path) | Depends on AP placement |
| Scalability | ~20 peers practical | Hundreds via broker |
| Cross-platform | ESP32 / ESP8266 only | Any MQTT client |

For a handful of sensor nodes talking to a gateway, ESP-NOW is usually better. For anything web/dashboard-facing, MQTT wins.

## Takeaway

ESP-NOW fills the gap when WiFi is overkill or unavailable. One gateway can be hybrid — receives ESP-NOW from peripheral nodes, publishes to MQTT for the rest of the world.'),

  ('00000000-0000-0000-0000-000000000434',
   (select id from public.modules where slug = 'secure-mqtt'),
   1,
   'Secure MQTT with TLS + mTLS',
   '## Why plain MQTT isn''t safe for production

Module 1.5 connected to `broker.hivemq.com:1883` without auth or encryption. Every message was readable by anyone on the network. For homework that''s fine; for anything real — not.

## TLS on port 8883 — encryption

The first upgrade: encrypt the connection. Use `WiFiClientSecure` instead of `WiFiClient`:

```cpp
#include <WiFi.h>
#include <WiFiClientSecure.h>
#include <PubSubClient.h>

WiFiClientSecure wifi;
PubSubClient mqtt(wifi);

// Server certificate (HiveMQ or your broker''s CA). Keep the BEGIN/END CERTIFICATE lines!
const char* ROOT_CA = R"cert(
-----BEGIN CERTIFICATE-----
MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBh
... (paste the whole PEM here) ...
-----END CERTIFICATE-----
)cert";

void setup() {
  WiFi.begin(SSID, PASS);
  while (WiFi.status() != WL_CONNECTED) delay(500);

  wifi.setCACert(ROOT_CA);
  mqtt.setServer("your-broker.example.com", 8883);
  mqtt.connect("client-id", "username", "password");
}
```

Server cert pinning means the ESP32 verifies the broker''s identity. An attacker-in-the-middle presenting a fake cert gets rejected.

**For quick dev**: `wifi.setInsecure()` skips verification. Never ship that.

## mTLS — the ESP32 proves identity too

In plain TLS, only the broker has a certificate. In **mutual TLS**, the client (your ESP32) also has a cert + private key. The broker checks both sides before accepting the connection.

```cpp
wifi.setCACert(BROKER_CA);        // server''s cert
wifi.setCertificate(CLIENT_CERT); // our cert
wifi.setPrivateKey(CLIENT_KEY);   // our private key
```

Generate the client pair with OpenSSL (or CloudFlare, AWS IoT, etc. do it for you when provisioning devices). Store the cert as `PROGMEM` like the server CA.

## Key management

The private key is a secret. Four ways to store it safely:

| Method | Security | Ease |
|---|---|---|
| Hardcoded in flash | Low (extractable) | Easy |
| Flash-encryption-enabled ESP32 | Medium | Medium |
| NVS-encrypted | Medium | Medium |
| Hardware Secure Element (ATECC608A) | **High** | Hard |

For most projects hardcoded + flash encryption is enough. For anything commercial touching regulated data, the secure-element chip is the right call.

## Client-ID uniqueness

MQTT requires unique client IDs per device. For a fleet, use the ESP32''s MAC:

```cpp
String clientId = "esp32-" + WiFi.macAddress();
mqtt.connect(clientId.c_str());
```

Each device has a different ID out of the box.

## Takeaway

Ladder: plain MQTT (dev) → TLS + password (hobby/home) → TLS + mTLS (production). Never ship setInsecure(). Manage your private keys like secrets.'),

  ('00000000-0000-0000-0000-000000000435',
   (select id from public.modules where slug = 'ota-strategies'),
   1,
   'OTA Strategies That Don''t Brick Devices',
   '## The problem

You deploy 100 devices. You push firmware v2. Something in v2 crashes on boot. Now 100 devices are bricks requiring physical USB rescue. This has ended careers.

This module is about the patterns that prevent that — all available on the ESP32 out of the box.

## Partitioning: A/B slots

The ESP32 flash can be split into two app partitions (`ota_0`, `ota_1`) plus an OTA data partition that records which one is active.

```
| nvs | otadata | ota_0 | ota_1 | spiffs |
```

Update flow:

1. Running from `ota_0`
2. Download new firmware → write to `ota_1`
3. Verify signature + checksum
4. Update `otadata` → next boot from `ota_1`
5. Reboot
6. `ota_1` boots, calls `esp_ota_mark_app_valid_cancel_rollback()` to confirm

If step 6 doesn''t happen within ~30 seconds (device crashes), the bootloader notices the "rollback pending" flag and reverts to `ota_0` on next boot.

Result: **a bad update cannot brick the device.**

## Using Arduino''s Update library

The simple version (dev-friendly, no rollback):

```cpp
#include <Update.h>

void performOTA(WiFiClient& stream, size_t size) {
  if (!Update.begin(size)) {
    Serial.println("begin failed");
    return;
  }
  size_t written = Update.writeStream(stream);
  if (written != size) { Update.abort(); return; }
  if (!Update.end(true)) { /* fail */ }
  ESP.restart();
}
```

For production, use the ESP-IDF `esp_ota_*` API (still callable from Arduino) which supports rollback.

## Signature verification

Anyone who can reach your update server can send malicious firmware. Sign every binary:

1. Generate a keypair once.
2. At build time, append a signature of the `.bin` using the private key.
3. The ESP32 has the public key embedded. Before flashing, verify the signature.
4. Reject any binary that doesn''t match.

Espressif''s "secure boot v2" does this end-to-end. With it enabled, the bootloader itself verifies signatures — even bypassing your app doesn''t help an attacker.

## Staged rollouts

Never update all devices at once.

```
Day 1: 1% of fleet → watch crash reports
Day 2: 10% → watch telemetry
Day 3: 50% → compare metrics to old version
Day 4: 100% (if healthy)
```

A bad build hits 1% before you notice, not 100%. This is the most important "strategy" — the technical rollback mechanics matter less if you don''t push to everyone simultaneously.

## Metrics to watch during rollout

| Metric | What it catches |
|---|---|
| Boot success rate | Total bricks |
| Uptime histogram | Crashes within N minutes |
| WiFi reconnect count | Regression in networking |
| Heap free | Memory leaks |
| MQTT publish success | Downstream integration breaks |

Every device publishes these to your fleet-management system on every boot. If v2''s boot-success drops even 0.5%, you freeze the rollout.

## Takeaway

The mechanics — A/B partitions, rollback, signed binaries — give you the safety net. The discipline — staged rollouts, watching metrics — is what keeps devices alive. Both matter. Either alone doesn''t.');

-- Hands-on, safety, components for ESP32 Phase 2 (condensed)
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000430', 1,
   'Write two tasks — one that Serial.prints "A" every 500 ms, another "B" every 1000 ms — and run them concurrently via xTaskCreatePinnedToCore.',
   'Serial output: A A B A A B A A B. Both tasks run independently; neither delays the other.'),
  ('00000000-0000-0000-0000-000000000430', 2,
   'Create a queue of floats. Producer task pushes fake sensor readings at 1 Hz; consumer task prints them.',
   'Consumer prints at 1 Hz regardless of how slow the print operation is. Queue smooths out timing jitter.'),
  ('00000000-0000-0000-0000-000000000430', 3,
   'Protect a shared counter with a semaphore. Two tasks increment it 10000 times each. Final value should be exactly 20000.',
   'Without the semaphore the counter ends somewhere between 10000-20000 (race condition). With it, exactly 20000.'),
  ('00000000-0000-0000-0000-000000000430', 4,
   'Print vTaskList in your main loop every 10 seconds. Watch stack and priority values.',
   'List shows all created tasks with their state (R=running, B=blocked, S=suspended), high-water mark of stack, priority. No task near zero stack.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000430', 1, 'caution',
   'Never call a blocking function (delay, Serial.print over slow baud) inside an ISR. Use xQueueSendFromISR or xSemaphoreGiveFromISR instead.'),
  ('00000000-0000-0000-0000-000000000430', 2, 'info',
   'Core 0 runs your Arduino loop() + WiFi by default. Pin audio/network-heavy tasks to core 1 to avoid interference.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000431', 1,
   'Write a sketch that prints boot count (from RTC_DATA_ATTR variable), sleeps for 5 seconds, wakes on timer. Run for 1 minute.',
   'Boot count increments on every wake, persists across sleeps. Serial shows ~12 wakes per minute.'),
  ('00000000-0000-0000-0000-000000000431', 2,
   'Add EXT0 wake on GPIO 33 going HIGH. Wire a button to that pin. Press to wake early.',
   'Device wakes on timer OR button press. Check esp_sleep_get_wakeup_cause() to differentiate them.'),
  ('00000000-0000-0000-0000-000000000431', 3,
   'Measure current with a multimeter in mA mode in series with VCC. Compare active, light-sleep, deep-sleep.',
   'Active: 80+ mA. Light sleep: ~1 mA. Deep sleep: 0.5-5 mA on dev boards (10+ µA on bare modules). Orders of magnitude difference.'),
  ('00000000-0000-0000-0000-000000000431', 4,
   'Build a "sensor reporter" sketch: wake → WiFi connect → MQTT publish → sleep 5 min. Log total awake time per cycle.',
   'Awake time ~3-5 seconds per cycle. With 5 min sleep intervals, duty cycle is <2% → 50x battery life vs always-on.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000431', 1, 'info',
   'Every millisecond awake costs 100-500x the sleep current. Your biggest optimization is always reducing the awake window.'),
  ('00000000-0000-0000-0000-000000000431', 2, 'caution',
   'Dev board LEDs + voltage regulator drain 5-15 mA even during deep sleep. For real battery projects, use bare ESP32-WROOM modules on custom PCBs.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000432', 1,
   'Install nRF Connect on your phone (free on iOS and Android).',
   'App installed. Scanning will show nearby BLE devices including AirTags, fitness bands, laptops.'),
  ('00000000-0000-0000-0000-000000000432', 2,
   'Upload the peripheral sketch with your own random UUIDs (uuidgenerator.net). Open nRF Connect, scan, find trainor-esp32.',
   'Device appears in scan. Tap to connect. Service + characteristic are listed.'),
  ('00000000-0000-0000-0000-000000000432', 3,
   'Subscribe to notifications on the characteristic. Watch values update in real time.',
   'Every 1 second a new float appears in nRF Connect. Values match what the ESP32 Serial.println outputs.'),
  ('00000000-0000-0000-0000-000000000432', 4,
   'Add a PROPERTY_WRITE characteristic. Send "on"/"off" from nRF Connect. Wire the built-in LED to respond.',
   'Writing "on" from the app lights the LED. "off" turns it off. Round-trip works.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000432', 1, 'info',
   'The BLE stack is heavy: ~100 KB flash, ~30 KB RAM. If you see "sketch too big" errors after adding BLE, increase the partition scheme (Tools → Partition Scheme → "Minimal SPIFFS").');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000433', 1,
   'Flash WiFi.macAddress() to Serial on two ESP32 boards. Record both MACs.',
   'Each board prints a unique 6-byte MAC. Write them down — you''ll hard-code them in each sketch.'),
  ('00000000-0000-0000-0000-000000000433', 2,
   'Upload the sender sketch on one board (with the OTHER board''s MAC). Upload the receiver sketch on the other.',
   'Receiver Serial shows incoming Reading structs every 5 seconds. "sent: ok" on the sender.'),
  ('00000000-0000-0000-0000-000000000433', 3,
   'Disconnect your WiFi router. Verify the two ESP32s still talk to each other.',
   'Messages still flow. ESP-NOW runs directly over the WiFi radio without any infrastructure.'),
  ('00000000-0000-0000-0000-000000000433', 4,
   'Move the sender progressively further away. Note the range at which packets start dropping.',
   'Indoor with walls: 30-50 m. Open line-of-sight: 100+ m. Packet loss rises sharply past the threshold.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000433', 1, 'info',
   'ESP-NOW and WiFi-station mode can coexist but must share the same channel. If you use both, call WiFi.setChannel() to pin a specific channel before esp_now_init().');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000434', 1,
   'Set up Mosquitto locally with TLS on port 8883. Generate a server certificate (self-signed is fine for dev).',
   'Broker starts listening. mosquitto_sub -h localhost -p 8883 --cafile ca.crt works from your laptop.'),
  ('00000000-0000-0000-0000-000000000434', 2,
   'Modify your Module 1.5 MQTT sketch: swap WiFiClient for WiFiClientSecure, add setCACert() with your broker''s cert.',
   'Connection succeeds over TLS (port 8883). Publishes + subscribes work as before. Wireshark capture shows encrypted traffic.'),
  ('00000000-0000-0000-0000-000000000434', 3,
   'Generate a client certificate + key pair. Configure the broker to require client certs. Update ESP32 sketch with setCertificate + setPrivateKey.',
   'Connection succeeds only when client cert is present. Removing either cert or key fails the handshake. That''s mTLS working.'),
  ('00000000-0000-0000-0000-000000000434', 4,
   'Use the ESP32 MAC as the client ID for a 2nd device. Both connect simultaneously with different certs.',
   'Two devices publish to the same topic with distinguishable client IDs. Mosquitto logs show both authenticated with their respective certs.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000434', 1, 'danger',
   'Never ship setInsecure() to production. Skipping cert verification means a MITM can read all your traffic. Pin server certs; rotate them before expiry.'),
  ('00000000-0000-0000-0000-000000000434', 2, 'caution',
   'Private keys in flash are extractable if attackers get physical access. Flash encryption + secure-boot v2 are the next steps for commercial products.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000435', 1,
   'Read Espressif''s "OTA Firmware Upgrade" doc. Understand the partition-table concept and the otadata partition.',
   'You can name: ota_0, ota_1, otadata partitions, which one''s active, and what happens on bad update.'),
  ('00000000-0000-0000-0000-000000000435', 2,
   'Enable "default partition scheme with OTA" in Arduino IDE (Tools → Partition Scheme). Confirm your sketch still fits.',
   'Sketch compiles; ~1.2 MB available per OTA slot. Smaller sketches fit easily; large ones may need the Minimal SPIFFS scheme.'),
  ('00000000-0000-0000-0000-000000000435', 3,
   'Write a "simulated bad update" — a sketch that boot-loops. Flash it via OTA, watch the rollback happen on next boot.',
   'Device reverts to the previous good image after the bootloader detects repeated boot failures. It does NOT brick.'),
  ('00000000-0000-0000-0000-000000000435', 4,
   'Document your OTA rollout checklist: what metrics you track, what percentage you roll to each day, what triggers a freeze.',
   'One-page runbook. Covers: build signing, staged rollout percentages, observability (crash, boot-time, reconnect count), rollback trigger.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000435', 1, 'danger',
   'Never push untested firmware to 100% of devices. Staged rollouts are non-negotiable for any fleet bigger than ~10 units.'),
  ('00000000-0000-0000-0000-000000000435', 2, 'caution',
   'Flash wear: each ESP32 partition handles ~100,000 erase cycles. CI that rebuilds + OTAs on every commit will wear out devices in a couple of years.');

-- lesson_components for Phase 2
insert into public.lesson_components (lesson_id, component_slug, "order") values
  ('00000000-0000-0000-0000-000000000430', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000430', 'jumper-wires',  2),
  ('00000000-0000-0000-0000-000000000431', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000431', 'jumper-wires',  2),
  ('00000000-0000-0000-0000-000000000431', 'multimeter',    3),
  ('00000000-0000-0000-0000-000000000431', 'button',        4),
  ('00000000-0000-0000-0000-000000000432', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000432', 'jumper-wires',  2),
  ('00000000-0000-0000-0000-000000000432', 'led',           3),
  ('00000000-0000-0000-0000-000000000433', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000433', 'jumper-wires',  2),
  ('00000000-0000-0000-0000-000000000434', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000434', 'jumper-wires',  2),
  ('00000000-0000-0000-0000-000000000435', 'esp32',         1)
on conflict do nothing;

-- ═══════════════════════════════════════════════════════════════════
-- ══════════ ESP32 COURSE · PHASE 3 · CAPSTONE: AI COMPANION ════════
-- ═══════════════════════════════════════════════════════════════════

insert into public.modules (phase_id, "order", slug, number, title, kind, status, estimated_minutes, summary) values
  ('00000000-0000-0000-0000-0000000000b7', 1, 'audio-i2s',               '3.1',
   'Audio I/O: I2S Mic + Speaker', 'handson', 'preview', 60,
   'INMP441 digital mic + MAX98357A amp/speaker over I2S. Record your voice, play back, measure sample quality.'),
  ('00000000-0000-0000-0000-0000000000b7', 2, 'llm-integration',         '3.2',
   'Cloud LLM Integration', 'handson', 'not_started', 70,
   'Stream audio → transcription → Claude/GPT → TTS → speaker. The round-trip that makes an ESP32 feel intelligent.'),
  ('00000000-0000-0000-0000-0000000000b7', 3, 'wake-word-vad',           '3.3',
   'Wake-Word Detection & Voice Activity', 'handson', 'not_started', 60,
   '"Hey Trainor" as always-listening trigger. On-device VAD decides when to start + stop recording. Privacy + battery savings.'),
  ('00000000-0000-0000-0000-0000000000b7', 4, 'ai-companion-build',      '3.4',
   'The Complete Companion', 'project', 'not_started', 120,
   'Full build. Mic + speaker + wake-word + LLM + TTS, running on a single ESP32. An actual talking device.');

insert into public.lessons (id, module_id, "order", title, body_md) values
  ('00000000-0000-0000-0000-000000000440',
   (select id from public.modules where slug = 'audio-i2s'),
   1,
   'Audio I/O: I2S Mic + Speaker',
   '## I2S — audio''s standard bus

I2S (Inter-IC Sound) is a 3-wire serial protocol for digital audio. Unlike analog audio, there''s no op-amps, no divider networks, no ADC calibration — just clean bits clocked between devices.

| I2S wire | Direction | Purpose |
|---|---|---|
| **BCK** (bit clock) | master → peripheral | Clocks each bit |
| **WS** / LRCK | master → peripheral | Channel select (left/right) |
| **DATA** | depends on role | Actual sample bits |

The ESP32 has two dedicated I2S peripherals (I2S0, I2S1). Either can be TX (output to speaker) or RX (input from mic).

## Parts you''ll use

| | Role | Wiring |
|---|---|---|
| **INMP441** | Digital MEMS mic, I2S output | VDD, GND, WS, SCK, SD, L/R |
| **MAX98357A** | 3W class-D amp + I2S input | VIN, GND, BCLK, LRC, DIN, Gain |
| 3W speaker (8Ω) | Plugs into MAX98357A | + / − screw terminals |

## Wiring (ESP32 pinout)

```
INMP441 (mic):                 MAX98357A (speaker):
  VDD  → 3V3                    VIN  → 5V
  GND  → GND                    GND  → GND
  WS   → GPIO 25                LRC  → GPIO 26
  SCK  → GPIO 33                BCLK → GPIO 27
  SD   → GPIO 32                DIN  → GPIO 22
  L/R  → GND (left ch)          Gain → leave floating (9dB default)
```

Mic and speaker use different I2S peripherals (I2S0 for mic, I2S1 for speaker) so they can run concurrently.

## Reading from the mic

```cpp
#include <driver/i2s.h>

void setupMic() {
  i2s_config_t cfg = {
    .mode                 = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_RX),
    .sample_rate          = 16000,
    .bits_per_sample      = I2S_BITS_PER_SAMPLE_16BIT,
    .channel_format       = I2S_CHANNEL_FMT_ONLY_LEFT,
    .communication_format = I2S_COMM_FORMAT_STAND_I2S,
    .intr_alloc_flags     = 0,
    .dma_buf_count        = 4,
    .dma_buf_len          = 512,
  };
  i2s_pin_config_t pins = {
    .bck_io_num   = 33,
    .ws_io_num    = 25,
    .data_out_num = I2S_PIN_NO_CHANGE,
    .data_in_num  = 32,
  };
  i2s_driver_install(I2S_NUM_0, &cfg, 0, NULL);
  i2s_set_pin(I2S_NUM_0, &pins);
}

int16_t samples[512];

void loop() {
  size_t bytesRead;
  i2s_read(I2S_NUM_0, samples, sizeof(samples), &bytesRead, portMAX_DELAY);
  // samples now contains 256 × int16_t raw PCM samples
}
```

## Playing to the speaker

Same library, different direction:

```cpp
void setupSpeaker() {
  i2s_config_t cfg = {
    .mode                 = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_TX),
    .sample_rate          = 16000,
    .bits_per_sample      = I2S_BITS_PER_SAMPLE_16BIT,
    .channel_format       = I2S_CHANNEL_FMT_ONLY_LEFT,
    .communication_format = I2S_COMM_FORMAT_STAND_I2S,
    .intr_alloc_flags     = 0,
    .dma_buf_count        = 4,
    .dma_buf_len          = 512,
  };
  i2s_pin_config_t pins = {
    .bck_io_num   = 27,
    .ws_io_num    = 26,
    .data_out_num = 22,
    .data_in_num  = I2S_PIN_NO_CHANGE,
  };
  i2s_driver_install(I2S_NUM_1, &cfg, 0, NULL);
  i2s_set_pin(I2S_NUM_1, &pins);
}

// Play a sine wave
void toneBurst(int freq, int ms) {
  int16_t buf[256];
  for (int t = 0; t < (16000 * ms / 1000) / 256; t++) {
    for (int i = 0; i < 256; i++) {
      buf[i] = 10000 * sin(2 * PI * freq * i / 16000);
    }
    size_t w;
    i2s_write(I2S_NUM_1, buf, sizeof(buf), &w, portMAX_DELAY);
  }
}
```

## Record → playback test

The canonical "does it work" exercise: record 3 seconds, then immediately play it back.

```cpp
const int SAMPLES_PER_SEC = 16000;
const int SECS = 3;
int16_t buffer[SAMPLES_PER_SEC * SECS];

void recordAndPlay() {
  size_t rx;
  i2s_read(I2S_NUM_0, buffer, sizeof(buffer), &rx, portMAX_DELAY);
  Serial.println("playing back");
  size_t tx;
  i2s_write(I2S_NUM_1, buffer, sizeof(buffer), &tx, portMAX_DELAY);
}
```

Talk for 3 seconds; hear yourself back. Latency feels surprising — raw PCM, no compression.

## Takeaway

I2S mic + I2S amp + ESP32 = a complete audio I/O stack in ~$10 of parts. From here we can send audio to cloud services (Module 3.2) and build real voice interfaces.'),

  ('00000000-0000-0000-0000-000000000441',
   (select id from public.modules where slug = 'llm-integration'),
   1,
   'Cloud LLM Integration',
   '## The round-trip

A voice assistant is a pipeline of 4 operations:

```
Microphone → Speech-to-Text → LLM → Text-to-Speech → Speaker
```

On an ESP32 you don''t run any of these locally — you pipe raw audio to cloud APIs. The chip''s job is routing + state management, not compute.

<!-- ill:iot-architecture -->

## Picking providers

| Stage | Options | Ease |
|---|---|---|
| **STT** | OpenAI Whisper, Deepgram, Google Cloud Speech | Low latency = Deepgram (streaming) |
| **LLM** | Claude, GPT-4, Gemini, local Ollama | Anthropic Claude via AI Gateway is clean |
| **TTS** | ElevenLabs, OpenAI TTS, Google | ElevenLabs sounds best; OpenAI is fastest |

For this module we''ll use **Whisper (STT) + Claude (LLM) + OpenAI TTS**. Swap any with similar patterns.

## Storing API keys

Do NOT hardcode them. Store in flash via NVS (preferences library):

```cpp
#include <Preferences.h>
Preferences prefs;

void saveKey(const String& name, const String& value) {
  prefs.begin("keys", false);
  prefs.putString(name.c_str(), value);
  prefs.end();
}

String readKey(const String& name) {
  prefs.begin("keys", true);
  String v = prefs.getString(name.c_str(), "");
  prefs.end();
  return v;
}
```

Provision once via a serial command (`setkey OPENAI_API_KEY sk-...`) or a one-time setup page. Flash encryption + secure boot protect them from extraction.

## STT: audio → text

Whisper''s HTTPS endpoint takes a WAV/FLAC blob and returns JSON. To minimize payload, compress int16 PCM into an in-memory WAV header + data, then multipart-POST:

```cpp
String transcribe(const int16_t* samples, size_t count) {
  WiFiClientSecure client;
  client.setCACert(OPENAI_CA);
  HTTPClient http;
  http.begin(client, "https://api.openai.com/v1/audio/transcriptions");
  http.addHeader("Authorization", "Bearer " + readKey("OPENAI_API_KEY"));

  String boundary = "----trainor-mic";
  http.addHeader("Content-Type", "multipart/form-data; boundary=" + boundary);

  String prefix =
    "--" + boundary + "\\r\\n"
    "Content-Disposition: form-data; name=\\"model\\"\\r\\n\\r\\n"
    "whisper-1\\r\\n"
    "--" + boundary + "\\r\\n"
    "Content-Disposition: form-data; name=\\"file\\"; filename=\\"audio.wav\\"\\r\\n"
    "Content-Type: audio/wav\\r\\n\\r\\n";
  String suffix = "\\r\\n--" + boundary + "--\\r\\n";

  // Build WAV header + PCM payload then send.
  // ... (see full sketch in the project lesson) ...

  int code = http.POST(payload);
  String body = http.getString();
  http.end();

  JsonDocument doc;
  deserializeJson(doc, body);
  return doc["text"].as<String>();
}
```

## LLM: text → response

Claude via the Vercel AI Gateway keeps the code provider-agnostic:

```cpp
String askClaude(const String& userMessage) {
  WiFiClientSecure client;
  HTTPClient http;
  http.begin(client, "https://ai-gateway.vercel.sh/v1/chat/completions");
  http.addHeader("Authorization", "Bearer " + readKey("AI_GATEWAY_KEY"));
  http.addHeader("Content-Type", "application/json");

  JsonDocument body;
  body["model"] = "anthropic/claude-haiku-4-5";   // fast + cheap for chat
  JsonArray messages = body["messages"].to<JsonArray>();
  messages[0]["role"] = "system";
  messages[0]["content"] = "You are a friendly voice assistant. Keep replies to 1-2 short sentences.";
  messages[1]["role"] = "user";
  messages[1]["content"] = userMessage;

  String payload;
  serializeJson(body, payload);
  int code = http.POST(payload);
  String response = http.getString();
  http.end();

  JsonDocument doc;
  deserializeJson(doc, response);
  return doc["choices"][0]["message"]["content"].as<String>();
}
```

Prompting for **short** responses matters — voice output that''s 30 seconds long kills usability. Constrain aggressively.

## TTS: text → audio bytes

OpenAI''s TTS returns MP3 bytes. You''ll need an MP3 decoder (the **ESP32-audioI2S** library handles streaming MP3 → I2S playback directly):

```cpp
#include <Audio.h>

Audio audio;

void setup() {
  audio.setPinout(27, 26, 22);  // BCLK, LRC, DOUT
  audio.setVolume(12);
}

void speak(const String& text) {
  // OpenAI TTS streaming URL with auth header
  audio.connecttohost("https://api.openai.com/v1/audio/speech?model=tts-1&voice=alloy&input=" + urlEncode(text));
}

void loop() {
  audio.loop();   // must run every iteration
}
```

Alternative (lower memory): use a relay TTS service on your own server that converts text → low-bitrate PCM stream, then i2s_write directly.

## The full pipeline

```cpp
void oneRound() {
  int16_t audio[16000 * 5];   // 5 seconds
  recordAudio(audio, 16000 * 5);
  String heard = transcribe(audio, 16000 * 5);
  String reply = askClaude(heard);
  speak(reply);
}
```

## Latency budget

| Step | Time |
|---|---|
| Record | 3-5 s (hard cap) |
| STT | 1-2 s |
| LLM | 1-3 s (depends on reply length) |
| TTS start | ~0.5 s |
| **Total to first audio** | ~6-10 s |

To feel snappier, stream audio TO the STT endpoint as you record (Deepgram supports this). And stream TTS as the LLM generates. Both are Phase 4 optimizations.

## Takeaway

ESP32 as the I/O + orchestration layer; cloud for the compute. The pipeline is a series of HTTP calls you already learned in Module 1.3. The "AI" is just the remote endpoint.'),

  ('00000000-0000-0000-0000-000000000442',
   (select id from public.modules where slug = 'wake-word-vad'),
   1,
   'Wake-Word Detection & Voice Activity',
   '## Why you need them

The naive "record 5s on a button press" pipeline of Module 3.2 works, but it''s a terrible UX. A real voice assistant:

1. **Listens always** but does nothing until it hears a specific wake word ("Hey Trainor")
2. **Starts recording** only after the wake word
3. **Stops recording** automatically when you stop talking (voice activity detection)
4. **Never sends audio** anywhere unless steps 1-3 all fire

That privacy + battery profile is what makes Alexa/Siri/Google tolerable to have in your house.

## Wake-word approaches

| Approach | Accuracy | Footprint | Latency |
|---|---|---|---|
| Simple energy threshold | Terrible (triggers on door slams) | Tiny | 0 ms |
| Match-filter correlation | Bad (needs exact utterance) | Small | ~100 ms |
| **Keyword-spotting NN (on device)** | Good | 50-200 KB model | ~200 ms |
| Cloud-based | Excellent | Audio streams constantly | 500+ ms |

Keyword-spotting is the sweet spot. Two options:

1. **ESP-Skainet** — Espressif''s own, free, supports custom wake words via web tool
2. **Porcupine** (Picovoice) — paid but polished, 50 KB models, 5 language wake words

For a hobby project, ESP-Skainet + the `esp-sr` component is the right pick.

## ESP-Skainet in Arduino

It''s primarily an ESP-IDF component but ships with Arduino wrappers:

```cpp
#include "esp_skainet.h"
#include "model_path.h"

model_iface_data_t* model;
esp_mn_iface_t* iface;

void setupWakeWord() {
  iface = &esp_mn_multinet1_hilexin;     // "Hi LeXin" default; custom models need a web form
  model = iface->create(MODEL_PATH, 6000);
  iface->print_active_speech_commands(model);
}

void loop() {
  int16_t audio[iface->get_samp_chunksize(model)];
  i2s_read(I2S_NUM_0, audio, sizeof(audio), &bytes, portMAX_DELAY);

  int command = iface->detect(model, audio);
  if (command == WAKE_UP) {
    Serial.println("wake word!");
    startConversation();   // the rest of Module 3.2 pipeline
  }
}
```

For custom wake words ("Hey Trainor"), Espressif''s web tool lets you train a small model with ~20 voice samples. Free for development, a commercial license for shipped products.

## VAD — when did the user stop talking?

After wake-up you want to record **exactly** what they said, not a fixed 5 seconds. Voice Activity Detection measures short-term energy + zero-crossing rate and decides "speech" vs "silence".

```cpp
bool isSpeech(const int16_t* chunk, size_t n) {
  long energy = 0;
  for (size_t i = 0; i < n; i++) energy += abs(chunk[i]);
  energy /= n;
  return energy > 800;   // threshold tuned for your mic + distance
}

void recordUntilSilence(int16_t* buffer, size_t maxSamples) {
  size_t total = 0;
  int silentChunks = 0;
  while (total < maxSamples) {
    int16_t chunk[256];
    size_t bytes;
    i2s_read(I2S_NUM_0, chunk, sizeof(chunk), &bytes, portMAX_DELAY);
    memcpy(buffer + total, chunk, bytes);
    total += bytes / 2;
    silentChunks = isSpeech(chunk, 256) ? 0 : silentChunks + 1;
    if (silentChunks >= 30) break;   // ~0.5s of silence = done
  }
}
```

Simple but works. For noisy environments use `webrtc_vad` (a small C library with a better algorithm).

## Putting it together

```cpp
void loop() {
  int16_t audio[CHUNK];
  i2s_read(I2S_NUM_0, audio, sizeof(audio), &bytes, portMAX_DELAY);

  if (iface->detect(model, audio) == WAKE_UP) {
    playTone(1200, 100);   // acknowledge beep
    int16_t speechBuffer[16000 * 10];   // max 10s of speech
    recordUntilSilence(speechBuffer, 16000 * 10);
    String heard = transcribe(speechBuffer, totalSamples);
    String reply = askClaude(heard);
    speak(reply);
  }
}
```

## Takeaway

Wake-word = gate. VAD = trim. Together they turn a microphone into a polite listener that only acts when spoken to. Local-first means no audio leaves the device unless a human said the magic words — privacy by design.'),

  ('00000000-0000-0000-0000-000000000443',
   (select id from public.modules where slug = 'ai-companion-build'),
   1,
   'The Complete Companion',
   '## What you''re building

A single ESP32 board + mic + speaker + button, running a complete voice assistant pipeline:

1. Boot → connect to WiFi
2. Always-on wake-word detection ("Hey Trainor")
3. Record your question until you stop talking
4. Transcribe via Whisper
5. Send to Claude for a reply
6. Speak the reply via TTS
7. Loop

No screen, no phone, no computer — just a small box that talks back.

## Bill of materials

| | Item | Notes |
|---|---|---|
| 1 | ESP32-WROOM dev board | Min 4 MB flash |
| 1 | INMP441 digital mic | I2S input |
| 1 | MAX98357A breakout | I2S amp |
| 1 | 3W 4Ω or 8Ω speaker | Small is fine; bigger is louder |
| 1 | Tactile button | Fallback "push to talk" |
| 1 | LiPo + TP4056 charger OR USB-C | Portable = LiPo |
| 1 | 3D-printed enclosure | Optional but classy |

## Full pin map

```
ESP32        Function
-------      --------------
GPIO 25      I2S mic WS
GPIO 33      I2S mic SCK
GPIO 32      I2S mic SD
GPIO 26      I2S amp LRC
GPIO 27      I2S amp BCLK
GPIO 22      I2S amp DIN
GPIO 0       Push-to-talk button (INPUT_PULLUP)
GPIO 2       Status LED (optional)
```

## Software architecture

One FreeRTOS task per major subsystem:

| Task | Core | Priority | Purpose |
|---|---|---|---|
| `audio_in_task` | 0 | 2 | Reads mic → wake-word → VAD |
| `ai_pipeline_task` | 1 | 1 | STT → LLM → TTS, blocking on a queue |
| `audio_out_task` | 1 | 2 | Plays whatever the pipeline produces |
| `housekeeping_task` | 0 | 1 | Reconnect WiFi, battery monitor |

The wake-word task hands raw audio through a queue to the pipeline task. The pipeline task drops its MP3 chunks into another queue that the speaker task consumes. Clean separation, no blocking.

## Prompting for voice UX

System prompt must be tuned for speech, not text. Examples of rules that matter:

```
You are a voice assistant running on a small device. Rules:
- Keep answers under 25 words.
- No markdown, no lists — you are being spoken aloud.
- If you don''t know, say so in one sentence.
- If the question is ambiguous, ask one short clarifying question.
- Use conversational tone, not formal.
```

Without these, Claude gives 3-paragraph markdown answers that are miserable to listen to.

## Memory budget on the ESP32

| | Size | Used for |
|---|---|---|
| Total flash | 4 MB | Sketch + OTA + model |
| Sketch partition | ~1.3 MB | App code |
| Model partition | ~500 KB | Wake-word model |
| **RAM (DRAM)** | ~300 KB | Audio buffers + HTTP SSL |
| PSRAM (if present) | 4-8 MB | Larger audio buffers |

**Without PSRAM you cannot** record > 5 seconds of PCM and keep it in RAM. Get a dev board with PSRAM (ESP32-WROVER variants) for comfort.

## The state machine (reuse from Phase 3 patterns)

```cpp
enum State { IDLE, WAKE_DETECTED, RECORDING, THINKING, SPEAKING };
State state = IDLE;

void loop() {
  switch (state) {
    case IDLE:          listenForWake();                break;
    case WAKE_DETECTED: playTone(1200, 80); enter(RECORDING); break;
    case RECORDING:     recordUntilSilence(); enter(THINKING); break;
    case THINKING:      runAIPipeline(); enter(SPEAKING); break;
    case SPEAKING:      if (!audio.isRunning()) enter(IDLE); break;
  }
}
```

Same pattern as the reaction-time game, just with a different domain. The Phase 3 (Arduino) muscle memory pays off here.

## Testing

1. Plug in. WiFi connects.
2. Say "Hey Trainor". Beep. Red LED lights.
3. Say "What''s the weather like today?". Silence triggers end-of-speech.
4. Wait ~5-8 seconds.
5. Hear a short voice reply through the speaker.

## Extensions — where to take it

- **Persistent memory** — store conversation history in NVS so it has context across power cycles
- **Local LLM via Ollama** — point at your home server instead of the cloud; privacy + no API costs
- **Multiple wake words** — "Hey Trainor" for questions; "Trainor, play music" for Spotify; "Trainor, lights off" for home automation via MQTT
- **Vision** — add an ESP32-CAM variant and a VLM (Claude''s multimodal endpoint) for "what do you see?" questions
- **Battery + deep sleep** — wake-word detection can run on ULP co-processor at <1 mA; full mic listening at 80 mA only during conversations

## You''re here

You started Phase 1 with "make an LED blink". You''re ending the ESP32 course with a device that **listens, thinks, and talks back**. Every phase has contributed:

- Phase 1 hands-on taught you when wires are wrong
- Phase 2 sensors taught you signal conditioning
- Phase 3 projects taught you state machines
- Phase 4 robot taught you sensor fusion
- ESP32 Phase 1 taught you networking
- ESP32 Phase 2 taught you power, BLE, OTA
- ESP32 Phase 3 taught you audio + cloud AI

The next step is yours. Some directions the instructor is not guiding you through (intentionally — they''re big):

- **Drone** — brushless motors + IMU + ESC + flight-control math. Start with a ready-made flight controller (SpeedyBee F405, Kakute H7) and own the radio/phone link instead of the attitude code.
- **Wearables** — tiny ESP32-S3 Mini + coin cell + flex PCB. Harder but physical-design-heavy.
- **Custom PCBs** — everything you''ve built on breadboards can become a real board with KiCad + JLCPCB. $5 for five copies of your design.

Ship something. Log it in the experiments feed. Tell someone.');

-- Hands-on, safety, components for ESP32 Phase 3
insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000440', 1,
   'Wire INMP441 mic as specified (WS/SCK/SD/L-R pins). Wire MAX98357A amp and connect a 4-8Ω speaker. Power both from 3V3 / 5V.',
   'Both modules detectable: mic draws ~1 mA, amp stays silent. No smoke.'),
  ('00000000-0000-0000-0000-000000000440', 2,
   'Upload an I2S test sketch that plays a 1 kHz sine wave for 1 second every 5 seconds. Use the speaker output path only.',
   'Clear beep from the speaker. If you hear static, check I2S pin assignments — BCK/LRC/DIN in the wrong order gives only noise.'),
  ('00000000-0000-0000-0000-000000000440', 3,
   'Add the mic path. Record 3 seconds of your voice into a buffer and immediately play it back.',
   'You hear yourself, slightly delayed, slightly tinny (16 kHz, 16-bit). Should be clearly recognizable.'),
  ('00000000-0000-0000-0000-000000000440', 4,
   'Implement a running RMS calculation on mic samples. Log to Serial every 100 ms.',
   'RMS idles around 20-80, jumps to 1000+ when you speak loudly. This is your signal threshold for VAD in Module 3.3.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000440', 1, 'caution',
   'I2S requires unique pins per peripheral but reusing pins across mic (I2S0) and speaker (I2S1) is fine. Double-check pin assignments — wrong assignment = white noise only.'),
  ('00000000-0000-0000-0000-000000000440', 2, 'info',
   'MAX98357A is loud. For initial testing, wire a series resistor (~100Ω) to the speaker to attenuate. Remove it once you''ve verified the pipeline works.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000441', 1,
   'Provision an OpenAI API key (or AI Gateway key) to NVS using Preferences. Do NOT hardcode it. Use a one-shot serial command like `setkey OPENAI sk-...`.',
   'Key saved. NVS survives reboot. `Preferences.getString("OPENAI")` returns it on next boot.'),
  ('00000000-0000-0000-0000-000000000441', 2,
   'Build the Whisper transcribe() function. Test with a 3-second "hello world" recording.',
   'JSON response from OpenAI returns { "text": "hello world" }. Round-trip takes ~2 seconds on good WiFi.'),
  ('00000000-0000-0000-0000-000000000441', 3,
   'Build the Claude (or AI Gateway) askClaude() function with a strict "short reply" system prompt. Test with "what''s 2+2".',
   'Response like "It''s 4." — one or two words. Long answers = your system prompt isn''t strict enough.'),
  ('00000000-0000-0000-0000-000000000441', 4,
   'Build the TTS speak() function using ESP32-audioI2S to stream MP3 → speaker.',
   'Text → audible speech from speaker within ~1 second of function call. Voice quality depends on the TTS provider you picked.'),
  ('00000000-0000-0000-0000-000000000441', 5,
   'Wire all 4 steps together: record → transcribe → ask → speak. Trigger on a button press.',
   'Full round-trip works. Press button, speak, release, wait 6-10 seconds, hear a reply. Log step timings to Serial so you can optimize the slow step.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000441', 1, 'danger',
   'NEVER commit API keys to git. Even a single leak of OpenAI/Claude keys can cost thousands in stolen quota before you notice.'),
  ('00000000-0000-0000-0000-000000000441', 2, 'caution',
   'Whisper + TTS charge per request. Budget $0.01-0.05 per round-trip. An always-listening device running 24/7 can run up real money — add a daily quota cap in your sketch.'),
  ('00000000-0000-0000-0000-000000000441', 3, 'info',
   'For faster responses, use Claude Haiku 4.5 (fast + cheap) instead of Opus. Voice UX wins when total latency drops under 5 seconds.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000442', 1,
   'Install Espressif''s ESP-Skainet (or a similar keyword-spotting component). Use the default wake-word model ("Hi LeXin" or "Alexa").',
   'Detection task loaded. Speaking the wake word triggers the callback. False-trigger rate acceptable in a quiet room.'),
  ('00000000-0000-0000-0000-000000000442', 2,
   'Implement the energy-based VAD function: isSpeech() returning true when RMS > threshold. Tune the threshold for your mic / room.',
   'isSpeech() returns true while you talk, false during silence. Threshold typically 500-1500 depending on mic placement + room.'),
  ('00000000-0000-0000-0000-000000000442', 3,
   'Build recordUntilSilence(): loop, read mic, append to buffer, stop when VAD sees 0.5s of continuous silence.',
   'Recording stops when you stop talking, not on a fixed timer. Buffer length matches actual speech duration.'),
  ('00000000-0000-0000-0000-000000000442', 4,
   'Chain: wake-word → tone beep → recordUntilSilence → print sample count + duration.',
   'Say "Hey Trainor what time is it" → beep → question recorded → Serial shows "~3.5s of audio captured". Exactly what was spoken, nothing more.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000442', 1, 'info',
   'Custom wake words need ~20 training samples via Espressif''s web tool. Free for dev, commercial license for products shipped at scale.'),
  ('00000000-0000-0000-0000-000000000442', 2, 'caution',
   'VAD fails in noisy environments (music, TV, air conditioner hum). For a real-world device, use webrtc_vad which distinguishes speech from noise more robustly.');

insert into public.hands_on_steps (lesson_id, "order", instruction, expected_measurement) values
  ('00000000-0000-0000-0000-000000000443', 1,
   'Pick an ESP32-WROVER (with PSRAM) dev board. Verify PSRAM is detected: Serial.println(ESP.getPsramSize()) should print 4194304 or similar.',
   'PSRAM detected. Without it, you cannot buffer > 5 seconds of audio reliably.'),
  ('00000000-0000-0000-0000-000000000443', 2,
   'Wire everything: mic on I2S0, amp on I2S1, button on GPIO 0, LED on GPIO 2. Use a breadboard for now; finalize on a perfboard later.',
   'All pins wired correctly. Smoke test: mic records, speaker plays, button works, LED blinks.'),
  ('00000000-0000-0000-0000-000000000443', 3,
   'Create 4 FreeRTOS tasks: audio_in (core 0), pipeline (core 1), audio_out (core 1), housekeeping (core 0). Use queues for audio-chunk passing.',
   'All 4 tasks visible in vTaskList. Queue between audio_in and pipeline is non-empty during conversations, empty otherwise.'),
  ('00000000-0000-0000-0000-000000000443', 4,
   'Integrate the full pipeline: wake-word → VAD-trimmed record → Whisper STT → Claude LLM → TTS → playback.',
   'Say "Hey Trainor, tell me a joke". Wait 6-10 seconds. Speaker plays a short joke. First joke is always the worst; they get better.'),
  ('00000000-0000-0000-0000-000000000443', 5,
   'Add OTA updates (Module 2.6 patterns). Flash your cosmetic tweak over WiFi.',
   'Device boots new firmware. Voice pipeline still works. No USB cable touched.'),
  ('00000000-0000-0000-0000-000000000443', 6,
   'Run for 24 hours. Log interaction count, average latency, any crashes. Log result to your experiments feed.',
   'Uptime 24h+ with no crashes. Average round-trip under 10 seconds. Final build documented. You''re done.');

insert into public.lesson_safety (lesson_id, "order", kind, message) values
  ('00000000-0000-0000-0000-000000000443', 1, 'danger',
   'An always-listening device with cloud API access is a privacy + cost liability if misconfigured. Always gate on wake-word detection. Add a kill switch (button hold for 3 seconds = disable) that users can physically trigger.'),
  ('00000000-0000-0000-0000-000000000443', 2, 'caution',
   'Voice UX is unforgiving — a pipeline that takes 15 seconds to answer feels broken. Measure every stage latency and cut the slowest one first.'),
  ('00000000-0000-0000-0000-000000000443', 3, 'info',
   'This capstone is a starting point, not an endpoint. Extensions: persistent conversation history via NVS, local Ollama LLM, multiple wake words for different commands, ESP32-CAM for vision. The skeleton is yours.');

-- lesson_components for Phase 3
insert into public.lesson_components (lesson_id, component_slug, "order") values
  ('00000000-0000-0000-0000-000000000440', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000440', 'breadboard',    2),
  ('00000000-0000-0000-0000-000000000440', 'jumper-wires',  3),
  ('00000000-0000-0000-0000-000000000440', 'i2s-mic',       4),
  ('00000000-0000-0000-0000-000000000440', 'i2s-speaker',   5),

  ('00000000-0000-0000-0000-000000000441', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000441', 'i2s-mic',       2),
  ('00000000-0000-0000-0000-000000000441', 'i2s-speaker',   3),
  ('00000000-0000-0000-0000-000000000441', 'button',        4),

  ('00000000-0000-0000-0000-000000000442', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000442', 'i2s-mic',       2),
  ('00000000-0000-0000-0000-000000000442', 'i2s-speaker',   3),

  ('00000000-0000-0000-0000-000000000443', 'esp32',         1),
  ('00000000-0000-0000-0000-000000000443', 'breadboard',    2),
  ('00000000-0000-0000-0000-000000000443', 'jumper-wires',  3),
  ('00000000-0000-0000-0000-000000000443', 'i2s-mic',       4),
  ('00000000-0000-0000-0000-000000000443', 'i2s-speaker',   5),
  ('00000000-0000-0000-0000-000000000443', 'button',        6),
  ('00000000-0000-0000-0000-000000000443', 'led',           7)
on conflict do nothing;
