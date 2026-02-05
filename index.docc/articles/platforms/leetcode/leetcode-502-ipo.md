# LeetCode 502: IPO


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/ipo/", label: "Solve on LeetCode")
}


> Warning: 1. Greedy selection needs two heaps: one by capital, one by profit. } > Warning: 2. Stop early if no projects are affordable. } }


Choose at most k projects to maximize capital with capital constraints.

## Warnings

@Row {
  @Column {
    > Warning: 1. Greedy selection needs two heaps: one by capital, one by profit.
  }
  @Column {
    > Warning: 2. Stop early if no projects are affordable.
  }
}

## Problem

- Choose at most k projects to maximize capital with capital constraints.

## Solution

- Push all affordable projects into a max-heap by profit, pick best each round.
- Time O(n log n + k log n).

## Tips

- Sort by capital or use a min-heap to unlock projects.
- Test when k exceeds project count.

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
