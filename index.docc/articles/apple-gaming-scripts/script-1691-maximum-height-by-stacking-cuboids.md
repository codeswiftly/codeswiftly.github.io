# Script — LeetCode 1691: Maximum Height by Stacking Cuboids (3:00)


@Metadata {
  @TitleHeading("Script — 1691 Maximum Height by Stacking Cuboids")
}


Pattern Focus: Sort + DP (LIS‑style). Normalize each cuboid’s dimensions by sorting within, then sort all cuboids; DP on whether one fits on another.

Duration: 3:00

## Narration

00:00–00:15 Hook — “3D Russian‑doll boxes — make it LIS.”

00:15–00:40 Setup — “Stack cuboids to maximize height; can rotate each cuboid.”

00:40–01:30 Core idea — “Sort each triple so w≤l≤h; then sort cuboids by (w,l,h). Let `dp[i]` be max height ending at i. For j<i, if cuboid[j] fits into cuboid[i] (w≤, l≤, h≤), update dp[i] = max(dp[i], dp[j] + h[i]). Answer is max dp.”

01:30–02:10 Code beats — implement `fits(a,b)` and the two‑level loop; O(n^2).”

02:10–02:35 Complexity — O(n^2) time, O(n) space; n up to typical constraints.

02:35–03:00 Wrap — “Classic transform → sort → LIS; same technique powers envelopes.”

## Visual Prompts

Walkthrough article: <doc:leetcode-1691-maximum-height-by-stacking-cuboids>

- 3D boxes stacked by height; annotate sorted triples.

<!-- TODO: Mermaid diagram for DP flow -->
