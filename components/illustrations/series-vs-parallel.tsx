export function SeriesVsParallel() {
  return (
    <svg
      viewBox="0 0 720 260"
      className="w-full"
      role="img"
      aria-label="Series vs parallel LED circuits — series shares one resistor, parallel gives each LED its own"
    >
      {/* ── PARALLEL (left) ── */}
      <g>
        <line x1="40" y1="40" x2="300" y2="40" stroke="var(--color-led)" strokeWidth="1.8" />
        <line x1="40" y1="220" x2="300" y2="220" stroke="currentColor" strokeWidth="1.8" opacity="0.4" />
        <text x="40" y="30" fontSize="10" fill="var(--color-led)" fontWeight="700">5V</text>
        <text x="40" y="238" fontSize="10" fill="currentColor" opacity="0.6">GND</text>

        {[80, 180, 260].map((x, i) => (
          <g key={x}>
            <line x1={x} y1="40" x2={x} y2="80" stroke="currentColor" strokeWidth="1.5" />
            <path
              d={`M ${x} 80 L ${x + 10} 90 L ${x - 10} 100 L ${x + 10} 110 L ${x - 10} 120 L ${x + 10} 130 L ${x} 140`}
              fill="none" stroke="var(--color-resistor)" strokeWidth="2"
            />
            <line x1={x} y1="140" x2={x} y2="160" stroke="currentColor" strokeWidth="1.5" />
            <polygon points={`${x - 10},160 ${x + 10},160 ${x},185`} fill={["var(--color-led)", "var(--color-sensor)", "var(--color-info)"][i]} opacity="0.85">
              <animate attributeName="opacity" values="0.4;1;0.4" dur="1.4s" repeatCount="indefinite" begin={`${i * 0.2}s`} />
            </polygon>
            <line x1={x - 12} y1="185" x2={x + 12} y2="185" stroke="currentColor" strokeWidth="1.8" />
            <line x1={x} y1="185" x2={x} y2="220" stroke="currentColor" strokeWidth="1.5" />
          </g>
        ))}

        <text x="170" y="252" fontSize="12" textAnchor="middle" fill="currentColor" fontWeight="700">PARALLEL</text>
        <text x="170" y="14" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">each LED has its own resistor · bright · independent</text>
      </g>

      {/* Divider */}
      <line x1="370" y1="20" x2="370" y2="240" stroke="currentColor" opacity="0.15" strokeWidth="1" strokeDasharray="4 3" />

      {/* ── SERIES (right) ── */}
      <g transform="translate(370, 0)">
        <line x1="40" y1="40" x2="300" y2="40" stroke="var(--color-led)" strokeWidth="1.8" />
        <line x1="40" y1="220" x2="300" y2="220" stroke="currentColor" strokeWidth="1.8" opacity="0.4" />
        <text x="40" y="30" fontSize="10" fill="var(--color-led)" fontWeight="700">5V</text>
        <text x="40" y="238" fontSize="10" fill="currentColor" opacity="0.6">GND</text>

        {/* Single wire path down-through-chain-up */}
        <line x1="170" y1="40" x2="170" y2="60" stroke="currentColor" strokeWidth="1.5" />
        <path
          d="M 170 60 L 180 70 L 160 80 L 180 90 L 160 100 L 180 110 L 170 120"
          fill="none" stroke="var(--color-resistor)" strokeWidth="2"
        />
        {/* Three LEDs stacked */}
        {[140, 168, 196].map((y, i) => (
          <g key={y}>
            <line x1="170" y1={y} x2="170" y2={y + 6} stroke="currentColor" strokeWidth="1.5" />
            <polygon points={`160,${y + 6} 180,${y + 6} 170,${y + 22}`} fill="var(--color-led)" opacity="0.7">
              <animate attributeName="opacity" values="0.3;0.7;0.3" dur="2s" repeatCount="indefinite" begin={`${i * 0.4}s`} />
            </polygon>
            <line x1="158" y1={y + 22} x2="182" y2={y + 22} stroke="currentColor" strokeWidth="1.5" />
          </g>
        ))}
        <line x1="170" y1="220" x2="170" y2="220" stroke="currentColor" strokeWidth="1.5" />

        <text x="170" y="252" fontSize="12" textAnchor="middle" fill="currentColor" fontWeight="700">SERIES</text>
        <text x="170" y="14" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">one resistor for all · dimmer · one dies, chain dies</text>
      </g>
    </svg>
  );
}
