
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-2034-stock-price-fluctuation-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-2034-stock-price-fluctuation-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-2034-stock-price-fluctuation-icon.codex", alt: "Placeholder icon")
# LeetCode 2034: Stock Price Fluctuation

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-2034-stock-price-fluctuation-dsa-icon.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")
  @PageImage(purpose: card, source: "leetcode-2034-stock-price-fluctuation-dsa-card.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")
  @CallToAction(url: "https://leetcode.com/problems/stock-price-fluctuation/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-2034-stock-price-fluctuation-dsa-hero.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")

> Warning: 1. Updates can override timestamps; keep latest per timestamp. } > Warning: 2. Use heaps plus a map to lazily discard stale values. } }

@Image(source: "leetcode-2034-stock-price-fluctuation-dsa-top.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")

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
