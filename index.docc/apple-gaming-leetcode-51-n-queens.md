# Gaming Deep Dive — LeetCode 51: N‑Queens

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 51 — N‑Queens")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-51-n-queens-icon.codex", alt: "Gaming Deep Dive — 51 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-51-n-queens-card.codex", alt: "Gaming Deep Dive — 51 card")
  @CallToAction(url: "https://leetcode.com/problems/n-queens/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-51-n-queens-hero.codex", alt: "Gaming Deep Dive LeetCode 51 N Queens hero")

## Overview

Backtracking with constraint sets to place non‑attacking queens.

## Invariant

- No two queens share a row, column, or diagonal.

## Approach

- Recurse by row, keeping columns and diagonals in sets; build board as strings.

## Complexity

- Exponential in n; typical solutions are acceptable for interview constraints.

## Test Plan

1. n=1 trivial; n=2,3 unsolvable; n=4 known 2 solutions.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-51-n-queens>
- <doc:script-51-n-queens>
}
