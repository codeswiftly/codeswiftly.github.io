# LeetCode 123: Best Time to Buy and Sell Stock III

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-123-best-time-to-buy-and-sell-stock-iii-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-123-best-time-to-buy-and-sell-stock-iii-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-123-best-time-to-buy-and-sell-stock-iii-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-123-best-time-to-buy-and-sell-stock-iii-dsa-icon.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")
  @PageImage(purpose: card, source: "leetcode-123-best-time-to-buy-and-sell-stock-iii-dsa-card.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")
  @CallToAction(url: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-123-best-time-to-buy-and-sell-stock-iii-dsa-hero.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")

> Warning: 1. This is the k=2 special case; do not over-allocate state. } > Warning: 2. Track two buys and two sells in order. } }

@Image(source: "leetcode-123-best-time-to-buy-and-sell-stock-iii-dsa-top.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")

Maximize profit with at most two transactions.

## Warnings

@Row {
  @Column {
    > Warning: 1. This is the k=2 special case; do not over-allocate state.
  }
  @Column {
    > Warning: 2. Track two buys and two sells in order.
  }
}

## Problem

- Maximize profit with at most two transactions.

## Solution

- Track best buy1, sell1, buy2, sell2 as you scan prices.
- Time O(n), space O(1).

## Tips

- Initialize buy values to negative infinity.
- Compare with LeetCode 121 and 122 for intuition.

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
