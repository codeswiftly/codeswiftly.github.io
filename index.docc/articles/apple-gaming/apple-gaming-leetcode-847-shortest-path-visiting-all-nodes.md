# Gaming Deep Dive — LeetCode 847: Shortest Path Visiting All Nodes


@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 847 — Shortest Path Visiting All Nodes")
  @CallToAction(url: "https://leetcode.com/problems/shortest-path-visiting-all-nodes/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Traveling‑salesperson‑style BFS on a small graph using a bitmask of visited nodes.

## Invariant

- State is `(node, mask)` where `mask` has the bit of every visited node. First time we pop any state with `mask == fullMask` is the minimal steps.

## Approach

- Initialize queue with all single‑node states `(i, 1<<i)` at distance 0.
- BFS transitions to neighbors with `mask | (1<<neighbor)`; keep a visited set on `(node, mask)`.

## Complexity

- O(n·2^n) states; edges proportional to degree — feasible for n ≤ 12. Space O(n·2^n).

## Test Plan

1. Line graph 0‑1‑2‑… → answer `n-1`.
2. Star graph → hop to center and back out.
3. Fully connected → `n-1`.
