# Gaming Deep Dive — LeetCode 1293: Shortest Path in a Grid with Obstacles Elimination

@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-1293-shortest-path-in-a-grid-with-obstacles-elimination-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-1293-shortest-path-in-a-grid-with-obstacles-elimination-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-1293-shortest-path-in-a-grid-with-obstacles-elimination-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1293 — Shortest Path k‑Obstacle Elimination")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1293-shortest-path-in-a-grid-with-obstacles-elimination-icon.codex", alt: "Gaming Deep Dive — 1293 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1293-shortest-path-in-a-grid-with-obstacles-elimination-card.codex", alt: "Gaming Deep Dive — 1293 card")
  @CallToAction(url: "https://leetcode.com/problems/shortest-path-in-a-grid-with-obstacles-elimination/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1293-shortest-path-in-a-grid-with-obstacles-elimination-hero.codex", alt: "Gaming Deep Dive LeetCode 1293 Shortest Path in a Grid with Obstacles Elimination hero")

## Overview

Find the minimum steps from start to end in a grid when you can remove up to `k` obstacles.

## Invariant

- State is `(r, c, kLeft)`; visited must include remaining eliminations to avoid pruning a better path.

## Approach

- BFS from `(0,0,k)`; when hitting a wall and `kLeft>0`, continue with `kLeft-1`.
- Early exit: if `k >= rows+cols-2`, the Manhattan path is always possible → answer is `rows+cols-2`.

## Complexity

- O(rows·cols·k) states; queue edges 4x each. Space proportional to visited states.

## Test Plan

1. No obstacles → Manhattan distance.
2. Exactly one obstacle on the only path with `k=1`.
3. Multiple detours where more `k` shortens the route.
