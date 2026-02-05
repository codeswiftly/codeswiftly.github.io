# Gaming Deep Dive — LeetCode 52: N‑Queens II

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 52 — N‑Queens II")
  @CallToAction(url: "https://leetcode.com/problems/n-queens-ii/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Same backtracking as 51, but return the count, not the boards.

## Invariant

- Maintain the same constraint sets; count solutions at the base case.

## Approach

- Increment a counter when a full placement is reached; no need to materialize boards.

## Complexity

- Same search space as 51, slightly less memory pressure.

## Test Plan

1. n=1 → 1, n=2,3 → 0, n=4 → 2.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-52-n-queens-ii>
- <doc:script-52-n-queens-ii>
}
