# LeetCode 122: Best Time to Buy and Sell Stock II


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/", label: "Solve on LeetCode")
}


> Warning: 1. You can take multiple transactions, but cannot hold multiple positions. } > Warning: 2. Do not overcomplicate; greedy works. } }


Maximize profit with as many buy/sell transactions as you want.

## Warnings

@Row {
  @Column {
    > Warning: 1. You can take multiple transactions, but cannot hold multiple positions.
  }
  @Column {
    > Warning: 2. Do not overcomplicate; greedy works.
  }
}

## Problem

- Maximize profit with as many buy/sell transactions as you want.

## Solution

- Sum all positive price differences between consecutive days.
- Time O(n), space O(1).

## Tips

- This is equivalent to taking every upward slope.
- Compare with the single-transaction version (LeetCode 121).

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
