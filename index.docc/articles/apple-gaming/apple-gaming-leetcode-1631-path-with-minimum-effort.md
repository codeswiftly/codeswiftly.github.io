# Gaming Deep Dive — LeetCode 1631: Path with Minimum Effort

@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-1631-path-with-minimum-effort-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-1631-path-with-minimum-effort-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-1631-path-with-minimum-effort-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1631 — Path With Minimum Effort")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1631-path-with-minimum-effort-icon.codex", alt: "Gaming Deep Dive — 1631 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1631-path-with-minimum-effort-card.codex", alt: "Gaming Deep Dive — 1631 card")
  @CallToAction(url: "https://leetcode.com/problems/path-with-minimum-effort/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1631-path-with-minimum-effort-hero.codex", alt: "Gaming Deep Dive LeetCode 1631 Path With Minimum Effort hero")

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
