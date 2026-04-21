# Datasheets

Drop PDF datasheets in this folder to include them in the RAG index. The
filename (without the `.pdf` suffix) is used as the document title.

Suggested seeds for Phase 1:

- `PN2222.pdf` — transistor (already used)
- `SG90.pdf` — servo
- `HC-SR04.pdf` — ultrasonic distance sensor
- `DHT11.pdf` — temperature + humidity
- `ULN2003.pdf` — stepper driver
- `74HC595.pdf` — shift register
- `L293D.pdf` — DC motor driver

Ingest with:

```bash
npm run ingest:datasheets
```

PDF contents may be subject to the manufacturer's license. Do not commit
files you don't have the right to redistribute — this folder is gitignored
by default (see `.gitignore`).
