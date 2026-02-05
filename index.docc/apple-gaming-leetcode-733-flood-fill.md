# Gaming Deep Dive — LeetCode 733: Flood Fill

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 733 — Flood Fill")
  @CallToAction(url: "https://leetcode.com/problems/flood-fill/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Grid traversal with either BFS or DFS; repaint connected components.

## Invariant

- Only repaint cells matching the original color; track visited to avoid cycles.

## Approach

- BFS queue or DFS recursion; for each cell, push neighbors with the original color before repaint.

## Complexity

- O(m·n) time, O(m·n) space worst‑case.

## Test Plan

1. Start color equals new color (no‑op).
2. Single‑cell repaint; border cases.
3. Large connected region vs multiple small regions.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-733-flood-fill>
}
