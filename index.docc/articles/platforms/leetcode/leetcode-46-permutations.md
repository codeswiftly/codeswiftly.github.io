# LeetCode 46: Permutations

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-46-permutations-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-46-permutations-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-46-permutations-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-46-permutations-dsa-icon.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
  @PageImage(purpose: card, source: "leetcode-46-permutations-dsa-card.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
  @CallToAction(url: "https://leetcode.com/problems/permutations/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-46-permutations-dsa-hero.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

> Warning: 1. Backtracking can blow up; keep the path and used markers tight. } > Warning: 2. Avoid mutating shared arrays without undoing changes. } }

@Image(source: "leetcode-46-permutations-dsa-top.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

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
