// Sensor → Logic → Output — the skeleton every Phase 3 project follows.
export function ProjectFlow() {
  return (
    <svg
      viewBox="0 0 680 260"
      className="w-full"
      role="img"
      aria-label="Project flow: sensors feed logic, logic drives outputs, outputs may feed back into state"
    >
      <defs>
        <marker id="pf-arrow" viewBox="0 0 10 10" refX="10" refY="5" markerWidth="8" markerHeight="8" orient="auto">
          <path d="M 0 0 L 10 5 L 0 10 z" fill="currentColor" />
        </marker>
      </defs>

      {/* Sensors column */}
      <g>
        <text x="80" y="32" fontSize="12" textAnchor="middle" fontWeight="700" fill="var(--color-sensor)">SENSORS</text>
        {[
          { y: 60, label: "DHT11" },
          { y: 108, label: "LDR" },
          { y: 156, label: "Button" },
        ].map((s) => (
          <g key={s.label}>
            <rect x="20" y={s.y} width="120" height="36" rx="8" fill="var(--color-sensor)" opacity="0.15" stroke="var(--color-sensor)" strokeWidth="1.5" />
            <text x="80" y={s.y + 22} fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">{s.label}</text>
          </g>
        ))}
      </g>

      {/* Logic */}
      <g>
        <text x="340" y="32" fontSize="12" textAnchor="middle" fontWeight="700" fill="var(--color-info)">LOGIC (loop)</text>
        <rect x="250" y="60" width="180" height="132" rx="10" fill="var(--color-info)" opacity="0.1" stroke="var(--color-info)" strokeWidth="1.5" />
        <text x="340" y="90" fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">state machine</text>
        <text x="340" y="108" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">non-blocking via millis()</text>
        <text x="340" y="130" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">condition thresholds</text>
        <text x="340" y="148" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">event debouncing</text>
        <text x="340" y="170" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">Serial debug</text>
      </g>

      {/* Outputs column */}
      <g>
        <text x="600" y="32" fontSize="12" textAnchor="middle" fontWeight="700" fill="var(--color-led)">OUTPUTS</text>
        {[
          { y: 60, label: "RGB LED" },
          { y: 108, label: "Buzzer" },
          { y: 156, label: "Serial" },
        ].map((o) => (
          <g key={o.label}>
            <rect x="540" y={o.y} width="120" height="36" rx="8" fill="var(--color-led)" opacity="0.15" stroke="var(--color-led)" strokeWidth="1.5" />
            <text x="600" y={o.y + 22} fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">{o.label}</text>
          </g>
        ))}
      </g>

      {/* Arrows — sensors → logic */}
      {[78, 126, 174].map((y) => (
        <line key={`s-${y}`} x1="145" y1={y} x2="245" y2="110" stroke="currentColor" strokeWidth="1.5" markerEnd="url(#pf-arrow)" />
      ))}

      {/* Arrows — logic → outputs */}
      {[78, 126, 174].map((y) => (
        <line key={`o-${y}`} x1="435" y1="110" x2="535" y2={y} stroke="currentColor" strokeWidth="1.5" markerEnd="url(#pf-arrow)" />
      ))}

      {/* Feedback loop */}
      <path
        d="M 600 192 Q 600 230 340 230 Q 80 230 80 200"
        fill="none" stroke="var(--color-motor)" strokeWidth="1.5"
        strokeDasharray="5 4"
        markerEnd="url(#pf-arrow)"
      />
      <text x="340" y="250" fontSize="10" textAnchor="middle" fill="var(--color-motor)" fontWeight="600">
        outputs often become inputs to the next iteration
      </text>
    </svg>
  );
}
