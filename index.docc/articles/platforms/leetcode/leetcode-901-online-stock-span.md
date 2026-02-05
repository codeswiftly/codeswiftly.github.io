# LeetCode 901: Online Stock Span


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/online-stock-span/", label: "Solve on LeetCode")
}


> Warning: 1. Naive scanning is too slow for long streams. } > Warning: 2. Use a monotonic stack to compress spans. } }


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
