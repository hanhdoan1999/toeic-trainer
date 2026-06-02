export function pctClass(p) {
  return p >= 70 ? "hi" : p >= 50 ? "mid" : "lo";
}

// scores: array of percentages (oldest -> newest)
export function Sparkline({ values, w = 72, h = 26 }) {
  const pad = 2;
  if (!values || values.length < 2) {
    return <svg className="spark" width={w} height={h} />;
  }
  const max = Math.max(...values);
  const min = Math.min(...values);
  const rng = max - min || 1;
  const pts = values.map((v, i) => {
    const x = pad + (i * (w - 2 * pad)) / (values.length - 1);
    const y = h - pad - ((v - min) / rng) * (h - 2 * pad);
    return [x, y];
  });
  const d = pts.map((p, i) => (i ? "L" : "M") + p[0].toFixed(1) + " " + p[1].toFixed(1)).join(" ");
  const last = pts[pts.length - 1];
  return (
    <svg className="spark" width={w} height={h} viewBox={`0 0 ${w} ${h}`}>
      <path d={d} fill="none" stroke="var(--accent)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
      <circle cx={last[0].toFixed(1)} cy={last[1].toFixed(1)} r="2.6" fill="var(--accent-deep)" />
    </svg>
  );
}
