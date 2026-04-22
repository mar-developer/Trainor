export function MultimeterDial() {
  const modes = [
    { label: "Ω", angle: 290, color: "var(--color-resistor)", note: "resistance" },
    { label: "V̄", angle: 340, color: "var(--color-info)", note: "DC voltage" },
    { label: "V~", angle: 30, color: "var(--color-danger)", note: "AC — don't" },
    { label: "A", angle: 80, color: "var(--color-led)", note: "current, in series" },
    { label: "⊸))", angle: 210, color: "var(--color-sensor)", note: "continuity" },
  ];
  const cx = 160;
  const cy = 150;
  const r = 100;

  return (
    <svg
      viewBox="0 0 360 280"
      className="w-full max-w-md mx-auto"
      role="img"
      aria-label="Multimeter dial modes: resistance, DC voltage, AC voltage, current, continuity"
    >
      <circle cx={cx} cy={cy} r={r + 18} fill="currentColor" opacity="0.05" />
      <circle cx={cx} cy={cy} r={r} fill="var(--color-tool)" opacity="0.15" stroke="var(--color-tool)" strokeWidth="1.5" />

      {modes.map((m) => {
        const rad = (m.angle * Math.PI) / 180;
        const x = cx + Math.cos(rad) * (r - 16);
        const y = cy + Math.sin(rad) * (r - 16);
        return (
          <g key={m.label}>
            <circle cx={x} cy={y} r="12" fill={m.color} opacity="0.85" />
            <text x={x} y={y + 4} fontSize="12" textAnchor="middle" fontWeight="700" fill="white">{m.label}</text>
          </g>
        );
      })}

      {/* Center pointer — points at continuity-mode by default, animates */}
      <g style={{ transformOrigin: `${cx}px ${cy}px` }} className="animate-[dial_6s_ease-in-out_infinite]">
        <line x1={cx} y1={cy} x2={cx} y2={cy - r + 28} stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
        <circle cx={cx} cy={cy} r="8" fill="currentColor" />
      </g>

      {/* Legend */}
      <g transform="translate(260, 40)">
        {modes.map((m, i) => (
          <g key={m.label} transform={`translate(0, ${i * 20})`}>
            <circle cx="6" cy="6" r="5" fill={m.color} />
            <text x="18" y="10" fontSize="10" fill="currentColor" fontWeight="600">{m.label}</text>
            <text x="36" y="10" fontSize="10" fill="currentColor" opacity="0.6">{m.note}</text>
          </g>
        ))}
      </g>
    </svg>
  );
}
