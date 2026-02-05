# Gaming Deep Dive — LeetCode 1091: Shortest Path in Binary Matrix

@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-1091-shortest-path-in-binary-matrix-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-1091-shortest-path-in-binary-matrix-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-1091-shortest-path-in-binary-matrix-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1091 — Shortest Path in Binary Matrix")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1091-shortest-path-in-binary-matrix-icon.codex", alt: "Gaming Deep Dive — 1091 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1091-shortest-path-in-binary-matrix-card.codex", alt: "Gaming Deep Dive — 1091 card")
  @CallToAction(url: "https://leetcode.com/problems/shortest-path-in-binary-matrix/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1091-shortest-path-in-binary-matrix-hero.codex", alt: "Gaming Deep Dive LeetCode 1091 Shortest Path in Binary Matrix hero")

## Overview

8‑directional BFS to reach bottom‑right through zeros (1s are blocked).

## Invariant

- Visit each valid zero cell once; queue stores distance so the first arrival at the goal is minimal.

## Approach

- If start or end is 1, return −1. BFS from (0,0) over 8 neighbors, skipping bounds/ones/visited.

## Complexity

- O(n²) time and space.

## Test Plan

1. Start blocked → −1.
2. Simple diagonal route.
3. Larger grid with winding path.
