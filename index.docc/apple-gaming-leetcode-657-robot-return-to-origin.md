# Gaming Deep Dive — LeetCode 657: Robot Return to Origin

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 657 — Robot Return to Origin")
  @CallToAction(url: "https://leetcode.com/problems/robot-return-to-origin/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Single‑pass coordinate simulation on U/D/L/R commands.

## Invariant

- Start at (0,0); return to origin if and only if net moves cancel out.

## Approach

- Accumulate x/y deltas and check final equality to (0,0).

## Complexity

- O(n) time, O(1) space.

## Test Plan

1. Balanced steps (e.g., "UDLR").
2. Unbalanced in one axis.
3. Empty command string.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-657-robot-return-to-origin>
}
