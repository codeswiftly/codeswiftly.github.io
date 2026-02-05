# LeetCode 2034: Stock Price Fluctuation


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/stock-price-fluctuation/", label: "Solve on LeetCode")
}


> Warning: 1. Updates can override timestamps; keep latest per timestamp. } > Warning: 2. Use heaps plus a map to lazily discard stale values. } }


Support updates and return current, max, and min prices.

## Warnings

@Row {
  @Column {
    > Warning: 1. Updates can override timestamps; keep latest per timestamp.
  }
  @Column {
    > Warning: 2. Use heaps plus a map to lazily discard stale values.
  }
}

## Problem

- Support updates and return current, max, and min prices.

## Solution

- Store latest price by timestamp, track current max timestamp.
- Use max/min heaps and discard stale entries when queried.

## Tips

- Keep the current timestamp and price in variables.
- Test multiple updates to the same timestamp.

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
