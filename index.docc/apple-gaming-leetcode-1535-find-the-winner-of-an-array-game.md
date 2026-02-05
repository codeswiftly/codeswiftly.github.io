# Gaming Deep Dive - LeetCode 1535: Find the Winner of An Array Game

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1535: Find the Winner of an Array Game")
  @CallToAction(url: "https://leetcode.com/problems/find-the-winner-of-an-array-game/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Use this problem to rehearse stateful simulation with early termination: compare the front two numbers, keep the larger as current winner, rotate the loser.

## Invariant

- Track `(winner, streak)` where `winner` is the current max at the front of the deque and `streak` counts consecutive wins. When `streak == k` the game ends.

## Approach

- Use an index/queue to simulate pairwise comparisons. Initialize `winner = a[0]`, `streak = 0`.
- For each `next` in the remaining stream:
  - If `winner >= next`: `streak += 1`; push `next` to the back.
  - Else: `winner = next`; reset `streak = 1`.
- Return early when `streak == k` or when `winner` equals the global maximum (it will never lose again).

## Complexity

- Amortized O(n + k) time (each element moves to the back only when it loses); O(1) extra space if you use indices, O(n) with an explicit deque.

## Test Plan

1. `k = 1` (winner is max of first two).
2. Strictly increasing array (last element wins quickly).
3. Strictly decreasing array (a[0] wins after k rounds or until end).
4. Random mix where the max is near the end.

## Local Breakdown

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1535-find-the-winner-of-an-array-game>
- <doc:script-1535-find-the-winner-of-an-array-game>

}
