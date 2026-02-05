# Gaming Deep Dive — LeetCode 47: Permutations II

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 47 — Permutations II")
  @CallToAction(url: "https://leetcode.com/problems/permutations-ii/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Backtracking with duplicate pruning.

## Invariant

- At each depth, skip equal numbers unless the previous equal was used at this level.

## Approach

- Sort input; in the i..end loop, if nums[j] == nums[j-1] and not used[j-1], continue.

## Complexity

- O(k) per permutation; overall ≤ n·n! with pruning benefits.

## Test Plan

1. Input with all distinct values.
2. Input with duplicates; verify no duplicate outputs.
3. Degenerate: all equal numbers.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-47-permutations-ii>
}
