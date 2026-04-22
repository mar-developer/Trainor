// Ohm's triangle: cover one, multiply/divide the other two.
export function OhmsTriangle() {
  return (
    <svg
      viewBox="0 0 320 260"
      className="w-full max-w-xs mx-auto"
      role="img"
      aria-label="Ohm's law triangle: V over I times R"
    >
      <polygon
        points="160,20 40,220 280,220"
        fill="var(--color-info)"
        opacity="0.1"
        stroke="var(--color-info)"
        strokeWidth="2"
      />
      <line x1="90" y1="130" x2="230" y2="130" stroke="var(--color-info)" strokeWidth="2" />
      <line x1="160" y1="130" x2="160" y2="220" stroke="var(--color-info)" strokeWidth="2" />

      <text x="160" y="105" fontSize="42" textAnchor="middle" fontWeight="700" fill="currentColor">V</text>
      <text x="118" y="195" fontSize="32" textAnchor="middle" fontWeight="700" fill="currentColor">I</text>
      <text x="200" y="195" fontSize="32" textAnchor="middle" fontWeight="700" fill="currentColor">R</text>

      <text x="160" y="247" fontSize="11" textAnchor="middle" fill="currentColor" opacity="0.6">
        V = I × R    I = V ÷ R    R = V ÷ I
      </text>
    </svg>
  );
}
