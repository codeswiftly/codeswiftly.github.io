@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-778-swim-in-rising-water-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-778-swim-in-rising-water-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-778-swim-in-rising-water-icon.codex", alt: "Placeholder icon")
# Gaming Deep Dive — LeetCode 778: Swim in Rising Water

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 778 — Swim in Rising Water")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-778-swim-in-rising-water-icon.codex", alt: "Gaming Deep Dive — 778 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-778-swim-in-rising-water-card.codex", alt: "Gaming Deep Dive — 778 card")
  @CallToAction(url: "https://leetcode.com/problems/swim-in-rising-water/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-778-swim-in-rising-water-hero.codex", alt: "Gaming Deep Dive LeetCode 778 Swim in Rising Water hero")

## Overview

Minimum time to reach the bottom‑right cell where water rises to max(grid values) seen along the path.

## Invariant

- Best path minimizes the maximum edge weight (cell elevation) along the path — solve with Dijkstra/0‑1 style or binary search + BFS.

## Approach

- Dijkstra with priority of current path max elevation; push neighbor with `max(currMax, grid[n])`.
  - Alternative: binary search on time `t` and check reachability via BFS with `grid[r][c] <= t`.

## Complexity

- Dijkstra: O(n² log n). Space O(n²).

## Test Plan

1. Monotone increasing row/col grid.
2. Basins that force detours.
3. 2×2 minimal case.
