# LeetCode 901: Online Stock Span

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-901-online-stock-span-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-901-online-stock-span-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-901-online-stock-span-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-901-online-stock-span-dsa-icon.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")
  @PageImage(purpose: card, source: "leetcode-901-online-stock-span-dsa-card.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")
  @CallToAction(url: "https://leetcode.com/problems/online-stock-span/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-901-online-stock-span-dsa-hero.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")

> Warning: 1. Naive scanning is too slow for long streams. } > Warning: 2. Use a monotonic stack to compress spans. } }

@Image(source: "leetcode-901-online-stock-span-dsa-top.codex", alt: "Medium problem - Pattern 8 (Monotonic Stack)")

For each price, return the span of consecutive days with price <= current.

## Warnings

@Row {
  @Column {
    > Warning: 1. Naive scanning is too slow for long streams.
  }
  @Column {
    > Warning: 2. Use a monotonic stack to compress spans.
  }
}

## Problem

- For each price, return the span of consecutive days with price <= current.

## Solution

- Maintain a stack of (price, span). Pop while top price <= current.
- Aggregate spans and push the new pair. Amortized O(1).

## Tips

- Keep spans as integers to avoid recomputation.
- Test with non-increasing and non-decreasing sequences.

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
