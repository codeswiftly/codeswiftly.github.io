# LeetCode 1801: Number of Orders in the Backlog

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-1801-number-of-orders-in-the-backlog-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-1801-number-of-orders-in-the-backlog-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-1801-number-of-orders-in-the-backlog-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-1801-number-of-orders-in-the-backlog-dsa-icon.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")
  @PageImage(purpose: card, source: "leetcode-1801-number-of-orders-in-the-backlog-dsa-card.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")
  @CallToAction(url: "https://leetcode.com/problems/number-of-orders-in-the-backlog/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-1801-number-of-orders-in-the-backlog-dsa-hero.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")

> Warning: 1. Match buy and sell orders in price order using heaps. } > Warning: 2. Apply modulo at the end to avoid overflow. } }

@Image(source: "leetcode-1801-number-of-orders-in-the-backlog-dsa-top.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")

Process buy/sell orders and return remaining backlog size.

## Warnings

@Row {
  @Column {
    > Warning: 1. Match buy and sell orders in price order using heaps.
  }
  @Column {
    > Warning: 2. Apply modulo at the end to avoid overflow.
  }
}

## Problem

- Process buy/sell orders and return remaining backlog size.

## Solution

- Maintain a max-heap for buys and min-heap for sells.
- Match orders greedily while prices overlap.

## Tips

- Reduce order quantity until it reaches zero.
- Use Int64 to prevent intermediate overflow.

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
