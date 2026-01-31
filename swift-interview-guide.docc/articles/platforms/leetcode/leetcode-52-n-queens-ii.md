
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-52-n-queens-ii-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-52-n-queens-ii-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-52-n-queens-ii-icon.codex", alt: "Placeholder icon")
# LeetCode 52: N-Queens II

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-52-n-queens-ii-dsa-icon.codex", alt: "Hard problem - Pattern 14 (Backtracking)")
  @PageImage(purpose: card, source: "leetcode-52-n-queens-ii-dsa-card.codex", alt: "Hard problem - Pattern 14 (Backtracking)")
  @CallToAction(url: "https://leetcode.com/problems/n-queens-ii/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-52-n-queens-ii-dsa-hero.codex", alt: "Hard problem - Pattern 14 (Backtracking)")

> Warning: 1. Counting solutions still needs the same pruning as the full board version. } > Warning: 2. Use integer counters instead of storing boards. } }

@Image(source: "leetcode-52-n-queens-ii-dsa-top.codex", alt: "Hard problem - Pattern 14 (Backtracking)")

Return the count of valid n-queens placements.

## Warnings

@Row {
  @Column {
    > Warning: 1. Counting solutions still needs the same pruning as the full board version.
  }
  @Column {
    > Warning: 2. Use integer counters instead of storing boards.
  }
}

## Problem

- Return the count of valid n-queens placements.

## Solution

- Use the same backtracking as N-Queens but increment a counter on completion.
- Time is exponential; space O(n) for recursion.

## Tips

- Reuse the same column and diagonal sets.
- Validate n = 1, 2, and 3 to confirm edge behavior.

## 3‑Minute Script

See full script: <doc:script-52-n-queens-ii>

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
