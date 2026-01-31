# Gaming Deep Dive — LeetCode 529: Minesweeper

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 529 — Minesweeper")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-529-minesweeper-icon.codex", alt: "Gaming Deep Dive — 529 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-529-minesweeper-card.codex", alt: "Gaming Deep Dive — 529 card")
  @CallToAction(url: "https://leetcode.com/problems/minesweeper/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-529-minesweeper-hero.codex", alt: "Gaming Deep Dive LeetCode 529 Minesweeper hero")

## Overview

Reveal logic with adjacency counts; BFS/DFS propagation when zeros expand.

## Invariant

- A click on mine → X; a click on empty → numbered cell or blank with expansion.

## Approach

- Count adjacent mines; if zero, push neighbors; else set the digit.

## Complexity

- O(m·n) with O(m·n) worst‑case space.

## Test Plan

1. Clicking a mine marks X.
2. Clicking near a mine sets the correct digit.
3. Expansion fills all connected zeros and borders.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-529-minesweeper>
}
