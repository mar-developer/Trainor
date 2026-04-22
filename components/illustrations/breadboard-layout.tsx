// Minimal 830-point breadboard layout cheat sheet. Highlights the
// column-wise connections and the center gap.
export function BreadboardLayout() {
  const rows = 8;
  return (
    <svg
      viewBox="0 0 640 240"
      className="w-full"
      role="img"
      aria-label="Breadboard: columns a-e connected vertically, center gap not connected, columns f-j connected vertically, power rails along top and bottom"
    >
      <rect x="20" y="20" width="600" height="200" rx="6" fill="var(--color-board)" opacity="0.08" stroke="var(--color-board)" strokeWidth="1" />

      {/* Top power rail */}
      <rect x="40" y="32" width="560" height="20" rx="3" fill="var(--color-led)" opacity="0.18" />
      <text x="30" y="47" fontSize="10" textAnchor="end" fill="var(--color-led)" fontWeight="700">+</text>
      <text x="610" y="47" fontSize="9" textAnchor="start" fill="currentColor" opacity="0.6">connected horizontally</text>

      {/* Bottom power rail */}
      <rect x="40" y="188" width="560" height="20" rx="3" fill="currentColor" opacity="0.18" />
      <text x="30" y="203" fontSize="10" textAnchor="end" fill="currentColor" fontWeight="700">−</text>

      {/* Column headers */}
      {["a", "b", "c", "d", "e"].map((c, i) => (
        <text key={c} x={60 + i * 24} y="72" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.55">{c}</text>
      ))}
      {["f", "g", "h", "i", "j"].map((c, i) => (
        <text key={c} x={400 + i * 24} y="72" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.55">{c}</text>
      ))}

      {/* Left column area */}
      {[...Array(rows)].map((_, r) =>
        [...Array(5)].map((__, col) => (
          <circle
            key={`l-${r}-${col}`}
            cx={60 + col * 24}
            cy={88 + r * 14}
            r="2.5"
            fill={col === 2 && r === 2 ? "var(--color-info)" : "currentColor"}
            opacity={col === 2 && r === 2 ? "1" : "0.5"}
          />
        )),
      )}

      {/* Connected-vertically band hint (column c, highlighted) */}
      <line
        x1="108" y1="84" x2="108" y2="198"
        stroke="var(--color-info)" strokeWidth="1.5" strokeDasharray="3 3" opacity="0.7"
      />
      <text x="118" y="108" fontSize="9" fill="var(--color-info)" fontWeight="600">
        a-e connected
      </text>

      {/* Center gap */}
      <line x1="320" y1="80" x2="320" y2="178" stroke="var(--color-danger)" strokeWidth="2" strokeDasharray="4 3" />
      <text x="330" y="134" fontSize="10" fill="var(--color-danger)" fontWeight="600">
        center gap: NOT connected
      </text>

      {/* Right column area */}
      {[...Array(rows)].map((_, r) =>
        [...Array(5)].map((__, col) => (
          <circle
            key={`r-${r}-${col}`}
            cx={400 + col * 24}
            cy={88 + r * 14}
            r="2.5"
            fill="currentColor"
            opacity="0.5"
          />
        )),
      )}

      <text x="540" y="108" fontSize="9" textAnchor="end" fill="currentColor" opacity="0.6">
        f-j connected vertically
      </text>
    </svg>
  );
}
