# LeetCode 46: Permutations


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/permutations/", label: "Solve on LeetCode")
}


> Warning: 1. Backtracking can blow up; keep the path and used markers tight. } > Warning: 2. Avoid mutating shared arrays without undoing changes. } }


Return all permutations of a list of distinct integers.

## Warnings

@Row {
  @Column {
    > Warning: 1. Backtracking can blow up; keep the path and used markers tight.
  }
  @Column {
    > Warning: 2. Avoid mutating shared arrays without undoing changes.
  }
}

## Problem

- Return all permutations of a list of distinct integers.

## Solution

- Use backtracking with a path array and a used boolean array.
- Time O(n * n!), space O(n) for recursion depth.

## Tips

- Use in-place swapping for less memory if desired.
- Validate empty and single-element inputs.

## 3‑Minute Script

See full script: <doc:script-46-permutations>

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
