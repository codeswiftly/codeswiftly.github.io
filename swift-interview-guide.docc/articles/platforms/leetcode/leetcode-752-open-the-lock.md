
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-752-open-the-lock-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-752-open-the-lock-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-752-open-the-lock-icon.codex", alt: "Placeholder icon")
# LeetCode 752: Open the Lock

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-752-open-the-lock-dsa-icon.codex", alt: "Medium problem - Pattern 12 (Graph BFS)")
  @PageImage(purpose: card, source: "leetcode-752-open-the-lock-dsa-card.codex", alt: "Medium problem - Pattern 12 (Graph BFS)")
  @CallToAction(url: "https://leetcode.com/problems/open-the-lock/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-752-open-the-lock-dsa-hero.codex", alt: "Medium problem - Pattern 12 (Graph BFS)")

> Warning: 1. Avoid deadends early; they prune large parts of the search. } > Warning: 2. Use BFS for shortest turns. } }

@Image(source: "leetcode-752-open-the-lock-dsa-top.codex", alt: "Medium problem - Pattern 12 (Graph BFS)")

Find the minimum turns to reach a target lock combination.

## Warnings

@Row {
  @Column {
    > Warning: 1. Avoid deadends early; they prune large parts of the search.
  }
  @Column {
    > Warning: 2. Use BFS for shortest turns.
  }
}

## Problem

- Find the minimum turns to reach a target lock combination.

## Solution

- BFS from "0000", generating neighbors by turning each wheel.
- Skip deadends and visited states.

## Tips

- Encode combinations as strings or ints for hashing.
- Test when target is "0000" or a deadend.

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
