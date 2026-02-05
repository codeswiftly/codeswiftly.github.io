# Gaming Deep Dive — LeetCode LCCI 08.06: Hanota

@Metadata {
  @TitleHeading("Gaming Deep Dive: LCCI 08.06 — Hanota")
  @CallToAction(url: "https://leetcode.com/problems/hanota-lcci/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Classic recursion with three stacks; moves follow the Towers of Hanoi pattern.

## Invariant

- Larger disks never go above smaller ones.

## Approach

- Move n−1 from A→B, move last from A→C, move n−1 from B→C.

## Complexity

- O(2^n) moves; O(n) call stack.

## Test Plan

1. n=1, n=2 minimal moves.
2. Verify final order is sorted with largest at bottom.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-lcci-08-06-hanota>
- <doc:script-lcci-08-06-hanota>
}
