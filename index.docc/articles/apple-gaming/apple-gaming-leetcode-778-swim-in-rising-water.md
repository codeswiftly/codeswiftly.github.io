# Gaming Deep Dive — LeetCode 778: Swim in Rising Water


@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 778 — Swim in Rising Water")
  @CallToAction(url: "https://leetcode.com/problems/swim-in-rising-water/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


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
