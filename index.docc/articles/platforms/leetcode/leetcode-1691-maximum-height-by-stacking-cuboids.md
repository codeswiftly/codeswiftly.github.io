# LeetCode 1691: Maximum Height by Stacking Cuboids


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/maximum-height-by-stacking-cuboids/", label: "Solve on LeetCode")
}


> Warning: 1. Sort dimensions per cuboid before global sorting. } > Warning: 2. Use DP to avoid O(2^n) stacking combinations. } }


Stack cuboids to maximize total height with rotation allowed.

## Warnings

@Row {
  @Column {
    > Warning: 1. Sort dimensions per cuboid before global sorting.
  }
  @Column {
    > Warning: 2. Use DP to avoid O(2^n) stacking combinations.
  }
}

## Problem

- Stack cuboids to maximize total height with rotation allowed.

## Solution

- Sort each cuboid's dimensions, then sort cuboids and run LIS-style DP.
- DP[i] = max height with cuboid i on top. Time O(n^2).

## Tips

- Enforce non-decreasing dimensions to allow stacking.
- Verify with small inputs and identical cuboids.

## 3‑Minute Script

See full script: <doc:script-1691-maximum-height-by-stacking-cuboids>

## Interview Framing

Questions to expect:

- What invariant or state do you maintain?
- What is the time and space complexity?
- Which edge cases would you test first?
- How would you optimize for larger inputs?
- What alternative approach would you mention and why?

Game-specific prompts:

- How do you model the state and transitions?
- What is the terminal condition or win criteria?
- Where can you prune, memoize, or update incrementally?
- How would you scale to larger inputs or more players?
- Which data structures keep updates fast and traceable?
