@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-847-shortest-path-visiting-all-nodes-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-847-shortest-path-visiting-all-nodes-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-847-shortest-path-visiting-all-nodes-icon.codex", alt: "Placeholder icon")
# Gaming Deep Dive — LeetCode 847: Shortest Path Visiting All Nodes

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 847 — Shortest Path Visiting All Nodes")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-847-shortest-path-visiting-all-nodes-icon.codex", alt: "Gaming Deep Dive — 847 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-847-shortest-path-visiting-all-nodes-card.codex", alt: "Gaming Deep Dive — 847 card")
  @CallToAction(url: "https://leetcode.com/problems/shortest-path-visiting-all-nodes/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-847-shortest-path-visiting-all-nodes-hero.codex", alt: "Gaming Deep Dive LeetCode 847 Shortest Path Visiting All Nodes hero")

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
