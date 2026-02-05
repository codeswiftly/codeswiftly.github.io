# Gaming Deep Dive — LeetCode 46: Permutations

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 46 — Permutations")
  @CallToAction(url: "https://leetcode.com/problems/permutations/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Backtracking baseline: generate all permutations via swap or used‑set patterns.

## Invariant

- Prefix up to index i is fixed; remaining elements are candidates.

## Approach

- Option A (swap): for i..end, swap(i,j), recurse(i+1), swap back.
- Option B (used set): build path and mark used indices; unmark on backtrack.

## Complexity

- O(n·n!) time, O(n) additional space.

## Test Plan

1. Single element → one permutation.
2. Two elements → two perms.
3. Larger n: verify counts and no duplicates.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-46-permutations>
- <doc:script-46-permutations>
}
