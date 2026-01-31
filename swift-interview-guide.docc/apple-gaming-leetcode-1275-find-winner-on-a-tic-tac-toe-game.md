# Gaming Deep Dive — LeetCode 1275: Find Winner on a Tic‑Tac‑Toe Game

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1275 — Find Winner on a Tic‑Tac‑Toe Game")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1275-find-winner-on-a-tic-tac-toe-game-icon.codex", alt: "Gaming Deep Dive — 1275 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1275-find-winner-on-a-tic-tac-toe-game-card.codex", alt: "Gaming Deep Dive — 1275 card")
  @CallToAction(url: "https://leetcode.com/problems/find-winner-on-a-tic-tac-toe-game/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1275-find-winner-on-a-tic-tac-toe-game-hero.codex", alt: "Gaming Deep Dive LeetCode 1275 Find Winner on a Tic Tac Toe Game hero")

## Overview

Warm‑up winner detection using incremental counters. Tracks rows, columns, and diagonals for O(1) win checks per move.

## Invariant (Say This First)

- `rows[r]`, `cols[c]`, `diag`, `antiDiag` store the net A(+1)/B(−1) counts.
- A line reaches an absolute value of 3 → winner determined immediately.

## Approach

- For move index `i`, set `delta = (i % 2 == 0 ? 1 : -1)`.
- Update counters for `(r, c)` and diagonals; return `A` if any counter == 3, `B` if == -3.
- After all moves: `Draw` if 9 moves, else `Pending`.

## Complexity

- O(n) time across moves, O(1) space.

## Test Plan

1. Row win, column win, and both diagonal wins.
2. Draw with full board; Pending with incomplete move list.
3. Early exit triggers when a line reaches ±3.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1275-find-winner-on-a-tic-tac-toe-game>
}
