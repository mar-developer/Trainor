export function SetupLoopLifecycle() {
  return (
    <svg
      viewBox="0 0 520 260"
      className="w-full"
      role="img"
      aria-label="setup runs once at boot, then loop runs forever"
    >
      {/* Power-on */}
      <g>
        <circle cx="60" cy="130" r="30" fill="var(--color-led)" opacity="0.2" stroke="var(--color-led)" strokeWidth="1.5" />
        <text x="60" y="126" fontSize="10" textAnchor="middle" fill="currentColor" fontWeight="700">Power</text>
        <text x="60" y="140" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">on</text>
      </g>

      {/* setup() box */}
      <g>
        <rect x="120" y="80" width="140" height="100" rx="12" fill="var(--color-info)" opacity="0.15" stroke="var(--color-info)" strokeWidth="1.5" />
        <text x="190" y="108" fontSize="13" textAnchor="middle" fill="var(--color-info)" fontWeight="700">setup()</text>
        <text x="190" y="128" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">runs exactly once</text>
        <text x="190" y="146" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">pinMode(…), Serial.begin(…)</text>
        <text x="190" y="164" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">initial configuration</text>
      </g>

      {/* loop() box */}
      <g>
        <rect x="320" y="80" width="160" height="100" rx="12" fill="var(--color-sensor)" opacity="0.15" stroke="var(--color-sensor)" strokeWidth="1.5" />
        <text x="400" y="108" fontSize="13" textAnchor="middle" fill="var(--color-sensor)" fontWeight="700">loop()</text>
        <text x="400" y="128" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">runs forever</text>
        <text x="400" y="146" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">digitalWrite(…), read sensors</text>
        <text x="400" y="164" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">do work, repeat</text>
      </g>

      {/* Arrows */}
      <defs>
        <marker id="arrow" viewBox="0 0 10 10" refX="10" refY="5" markerWidth="8" markerHeight="8" orient="auto">
          <path d="M 0 0 L 10 5 L 0 10 z" fill="currentColor" />
        </marker>
      </defs>

      <line x1="90" y1="130" x2="118" y2="130" stroke="currentColor" strokeWidth="2" markerEnd="url(#arrow)" />
      <line x1="262" y1="130" x2="318" y2="130" stroke="currentColor" strokeWidth="2" markerEnd="url(#arrow)" />

      {/* Loop back */}
      <path
        d="M 400 180 Q 400 220 320 220 Q 320 220 320 180"
        fill="none" stroke="var(--color-sensor)" strokeWidth="2"
        strokeDasharray="6 4"
        markerEnd="url(#arrow)"
      >
        <animate attributeName="stroke-dashoffset" from="0" to="-20" dur="0.8s" repeatCount="indefinite" />
      </path>
      <text x="400" y="245" fontSize="10" textAnchor="middle" fill="var(--color-sensor)" fontWeight="600">
        repeats until power off
      </text>

      <text x="260" y="30" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.6">
        Every Arduino sketch: two functions, this flow.
      </text>
    </svg>
  );
}
