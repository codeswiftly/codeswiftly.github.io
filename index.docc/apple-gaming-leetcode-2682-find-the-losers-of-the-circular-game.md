# Gaming Deep Dive — LeetCode 2682: Find the Losers of the Circular Game

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 2682 — Find the Losers of the Circular Game")
  @CallToAction(url: "https://leetcode.com/problems/find-the-losers-of-the-circular-game/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Circle simulation with visited tracking; arithmetic progression of steps.

## Invariant

- A player loses if never visited in the step progression.

## Approach

- Simulate `i += k*step (mod n)` until a repeat; losers are unvisited.

## Complexity

- O(n) time and space.

## Test Plan

1. Small n with k=1 and k>1.
2. Check step cycles repeat as expected.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-2682-find-the-losers-of-the-circular-game>
- <doc:script-2682-find-the-losers-of-the-circular-game>
}
