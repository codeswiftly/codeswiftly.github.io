# Gaming Deep Dive — LeetCode 1631: Path with Minimum Effort


@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1631 — Path With Minimum Effort")
  @CallToAction(url: "https://leetcode.com/problems/path-with-minimum-effort/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Minimize the maximum absolute difference between adjacent cells along a path from top‑left to bottom‑right.

## Invariant

- The path cost is `max(|Δh|)` along the route. Dijkstra with edge weight `|Δh|` or binary search on effort with BFS both work.

## Approach

- Dijkstra: relax neighbor with `newCost = max(currCost, |Δh|)`; return when reaching target.
- Binary search: check if target is reachable with only edges `<= mid`.

## Complexity

- Dijkstra: O(m·n log(m·n)) time, O(m·n) space. Binary search adds a log factor with O(m·n) per check.

## Test Plan

1. Flat grid → effort 0.
2. Single steep edge → effort equals that edge.
3. Multiple routes where a longer but flatter path wins.
