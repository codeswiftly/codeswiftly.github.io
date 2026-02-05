# Gaming Deep Dive — LeetCode 1691: Maximum Height by Stacking Cuboids

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1691 — Maximum Height by Stacking Cuboids")
  @CallToAction(url: "https://leetcode.com/problems/maximum-height-by-stacking-cuboids/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Sort + LIS‑style DP over normalized boxes.

## Invariant

- Each cuboid dimensions are sorted; valid stack requires non‑decreasing w×l and increasing h.

## Approach

- Normalize each cuboid; sort by base; dp[i] = max stack height ending at i.

## Complexity

- O(n^2) DP; O(n) space.

## Test Plan

1. Single cuboid.
2. Non‑stackable mix vs fully stackable.
3. Equal bases with different heights.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1691-maximum-height-by-stacking-cuboids>
- <doc:script-1691-maximum-height-by-stacking-cuboids>
}
