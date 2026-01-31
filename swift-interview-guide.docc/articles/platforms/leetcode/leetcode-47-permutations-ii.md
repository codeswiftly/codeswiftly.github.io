
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-47-permutations-ii-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-47-permutations-ii-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-47-permutations-ii-icon.codex", alt: "Placeholder icon")
# LeetCode 47: Permutations II

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-47-permutations-ii-dsa-icon.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
  @PageImage(purpose: card, source: "leetcode-47-permutations-ii-dsa-card.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
  @CallToAction(url: "https://leetcode.com/problems/permutations-ii/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-47-permutations-ii-dsa-hero.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

> Warning: 1. Duplicate values require pruning to avoid repeated permutations. } > Warning: 2. Sort input before recursion to detect duplicates. } }

@Image(source: "leetcode-47-permutations-ii-dsa-top.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

Return all unique permutations for a list that may contain duplicates.

## Warnings

@Row {
  @Column {
    > Warning: 1. Duplicate values require pruning to avoid repeated permutations.
  }
  @Column {
    > Warning: 2. Sort input before recursion to detect duplicates.
  }
}

## Problem

- Return all unique permutations for a list that may contain duplicates.

## Solution

- Sort the array and skip duplicates when the previous identical value is unused.
- Time O(n * n!), space O(n) for recursion depth.

## Tips

- Track used indices rather than values to keep ordering stable.
- Test inputs with all duplicates and mixed duplicates.

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
