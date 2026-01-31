# Gaming Deep Dive - LeetCode 1823: Find the Winner of the Circular Game

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1823: Find the Winner of the Circular Game")
  @CallToAction(url: "https://leetcode.com/problems/find-the-winner-of-the-circular-game/", label: "Solve on LeetCode")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1823-find-the-winner-of-the-circular-game-icon.codex", alt: "Gaming Deep Dive LeetCode 1823 Find the Winner of the Circular Game icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1823-find-the-winner-of-the-circular-game-card.codex", alt: "Gaming Deep Dive LeetCode 1823 Find the Winner of the Circular Game card")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1823-find-the-winner-of-the-circular-game-hero.codex", alt: "Gaming Deep Dive LeetCode 1823 Find the Winner of the Circular Game hero")

## Overview

Josephus elimination on a circle with step `k`.

## Invariant

- Maintain the index of the current survivor as you increase `n` from 1..N with `f(n) = (f(n-1) + k) % n` (1‑indexed result needs `+1`).

## Approach

- Either simulate with a queue (O(n·k)) or compute directly using the Josephus recurrence in O(n).

## Complexity

- Recurrence: O(n) time, O(1) space. Queue simulation: O(n·k).

## Test Plan

1. Small `n,k` pairs (hand-computable).
2. Edge `k = 1` (answer is `n`).
3. Large `n` to verify O(n) recurrence stays fast.

## Local Breakdown

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1823-find-the-winner-of-the-circular-game>
- <doc:script-1823-find-the-winner-of-the-circular-game>

}
