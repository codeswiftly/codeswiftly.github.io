# LeetCode 188: Best Time to Buy and Sell Stock IV


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/", label: "Solve on LeetCode")
}


> Warning: 1. Large k requires optimization; fallback to unlimited transactions when k >= n/2. } > Warning: 2. Track transitions carefully to avoid off-by-one errors. } }


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
