@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-499-the-maze-iii-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-499-the-maze-iii-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-499-the-maze-iii-icon.codex", alt: "Placeholder icon")
# Gaming Deep Dive — LeetCode 499: The Maze III

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 499 — The Maze III")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-499-the-maze-iii-icon.codex", alt: "Gaming Deep Dive — 499 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-499-the-maze-iii-card.codex", alt: "Gaming Deep Dive — 499 card")
  @CallToAction(url: "https://leetcode.com/problems/the-maze-iii/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-499-the-maze-iii-hero.codex", alt: "Gaming Deep Dive LeetCode 499 The Maze III hero")

## Overview

Find the lexicographically smallest path to the hole with minimal distance; rolling until walls like The Maze I.

## Invariant

- Dijkstra over stop cells with tie‑break on path strings: `(dist, path)` as priority; neighbors computed by rolling until wall or hole.

## Approach

- Use a min‑heap keyed by `(dist, path)`; on roll, if you encounter the hole earlier, stop that direction; update when a better `(dist, path)` pair is found.

## Complexity

- O(m·n log m·n) with string comparisons in tie‑breaks; Space O(m·n).

## Test Plan

1. Multiple shortest routes with different path strings → choose lexicographically smallest.
2. No path to hole → return "impossible".
3. Simple corridor sanity checks.
