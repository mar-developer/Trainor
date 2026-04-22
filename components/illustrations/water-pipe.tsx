// Water-pipe analogy: voltage = pressure, current = flow, resistance = valve.
export function WaterPipeIllustration() {
  return (
    <svg
      viewBox="0 0 640 240"
      className="w-full"
      role="img"
      aria-label="Water-pipe analogy: voltage is pressure, current is flow rate, resistance is valve tightness"
    >
      {/* Reservoir (voltage source) */}
      <rect x="20" y="40" width="110" height="160" rx="8" fill="var(--color-info)" opacity="0.15" stroke="var(--color-info)" strokeWidth="1.5" />
      <path d="M 30 80 Q 75 60 120 80 L 120 180 Q 75 200 30 180 Z" fill="var(--color-info)" opacity="0.35" />
      <text x="75" y="220" fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">Voltage (V)</text>
      <text x="75" y="234" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.6">pressure</text>

      {/* Pipe */}
      <rect x="130" y="110" width="380" height="26" fill="currentColor" opacity="0.1" stroke="currentColor" strokeOpacity="0.3" strokeWidth="1" />
      <text x="220" y="100" fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">Current (I)</text>
      <text x="220" y="155" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.6">flow rate</text>

      {/* Flowing dots (animated) */}
      <g className="[&_circle]:animate-[flow_2s_linear_infinite]">
        <circle cx="150" cy="123" r="4" fill="var(--color-info)" />
        <circle cx="190" cy="123" r="4" fill="var(--color-info)" style={{ animationDelay: "-0.4s" }} />
        <circle cx="230" cy="123" r="4" fill="var(--color-info)" style={{ animationDelay: "-0.8s" }} />
        <circle cx="270" cy="123" r="4" fill="var(--color-info)" style={{ animationDelay: "-1.2s" }} />
        <circle cx="310" cy="123" r="4" fill="var(--color-info)" style={{ animationDelay: "-1.6s" }} />
      </g>

      {/* Valve (resistance) */}
      <g>
        <rect x="360" y="92" width="40" height="62" fill="var(--color-resistor)" opacity="0.2" stroke="var(--color-resistor)" strokeWidth="1.5" />
        <circle cx="380" cy="78" r="10" fill="var(--color-resistor)" opacity="0.6" />
        <line x1="380" y1="64" x2="380" y2="92" stroke="var(--color-resistor)" strokeWidth="2" />
        <text x="380" y="180" fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">Resistance (R)</text>
        <text x="380" y="194" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.6">valve tightness</text>
      </g>

      {/* Outflow */}
      <rect x="400" y="110" width="110" height="26" fill="currentColor" opacity="0.1" stroke="currentColor" strokeOpacity="0.3" strokeWidth="1" />
      <g className="[&_circle]:animate-[flow_2s_linear_infinite]">
        <circle cx="420" cy="123" r="2" fill="var(--color-info)" opacity="0.5" />
        <circle cx="450" cy="123" r="2" fill="var(--color-info)" opacity="0.5" style={{ animationDelay: "-0.6s" }} />
        <circle cx="480" cy="123" r="2" fill="var(--color-info)" opacity="0.5" style={{ animationDelay: "-1.2s" }} />
      </g>
      <text x="460" y="100" fontSize="9" fill="currentColor" opacity="0.6">↓ flow drops after the valve</text>

      {/* Ground outlet */}
      <path d="M 510 110 L 530 110 L 530 136 L 510 136 Z" fill="currentColor" opacity="0.3" />
      <text x="555" y="127" fontSize="11" fill="currentColor" opacity="0.7">GND</text>
    </svg>
  );
}
