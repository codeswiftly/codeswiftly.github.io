# Gaming Deep Dive — LeetCode 348: Design Tic‑Tac‑Toe

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 348 — Design Tic‑Tac‑Toe")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-348-design-tic-tac-toe-icon.codex", alt: "Gaming Deep Dive — 348 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-348-design-tic-tac-toe-card.codex", alt: "Gaming Deep Dive — 348 card")
  @CallToAction(url: "https://leetcode.com/problems/design-tic-tac-toe/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-348-design-tic-tac-toe-hero.codex", alt: "Gaming Deep Dive LeetCode 348 Design Tic Tac Toe hero")

## Overview

Object design for a game with incremental winner checks.

## Invariant

- Same counters as 1275 (rows/cols/diagonals) but encapsulated in a class; turn ordering is enforced externally.

## Approach

- Update the four counters and return the winner (`1`/`2`) or `0`.

## Complexity

- O(1) per move.

## Test Plan

1. Immediate win scenarios per line.
2. No win yet, continue game.
3. Alternate moves to validate user of API.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-348-design-tic-tac-toe>
- <doc:script-348-design-tic-tac-toe>
}
