# LeetCode 354: Russian Doll Envelopes


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/russian-doll-envelopes/", label: "Solve on LeetCode")
}


> Warning: 1. Sort widths ascending and heights descending to avoid false nesting. } > Warning: 2. Use LIS on heights to achieve O(n log n). } }


Find the maximum number of envelopes that can nest.

## Warnings

@Row {
  @Column {
    > Warning: 1. Sort widths ascending and heights descending to avoid false nesting.
  }
  @Column {
    > Warning: 2. Use LIS on heights to achieve O(n log n).
  }
}

## Problem

- Find the maximum number of envelopes that can nest.

## Solution

- Sort as described, then compute LIS on heights.
- Time O(n log n), space O(n).

## Tips

- Test with equal widths to confirm descending height sort.
- Keep a tails array for LIS updates.

## 3‑Minute Script

See full script: <doc:script-354-russian-doll-envelopes>

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
