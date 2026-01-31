
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-188-best-time-to-buy-and-sell-stock-iv-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-188-best-time-to-buy-and-sell-stock-iv-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-188-best-time-to-buy-and-sell-stock-iv-icon.codex", alt: "Placeholder icon")
# LeetCode 188: Best Time to Buy and Sell Stock IV

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-188-best-time-to-buy-and-sell-stock-iv-dsa-icon.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")
  @PageImage(purpose: card, source: "leetcode-188-best-time-to-buy-and-sell-stock-iv-dsa-card.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")
  @CallToAction(url: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-188-best-time-to-buy-and-sell-stock-iv-dsa-hero.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")

> Warning: 1. Large k requires optimization; fallback to unlimited transactions when k >= n/2. } > Warning: 2. Track transitions carefully to avoid off-by-one errors. } }

@Image(source: "leetcode-188-best-time-to-buy-and-sell-stock-iv-dsa-top.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")

Maximize profit with at most k transactions.

## Warnings

@Row {
  @Column {
    > Warning: 1. Large k requires optimization; fallback to unlimited transactions when k >= n/2.
  }
  @Column {
    > Warning: 2. Track transitions carefully to avoid off-by-one errors.
  }
}

## Problem

- Maximize profit with at most k transactions.

## Solution

- Use DP for buy/sell states across transactions.
- Optimize space to O(k) with rolling arrays.

## Tips

- Initialize buy states to negative infinity.
- Test k = 0 and k = 1 explicitly.

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
