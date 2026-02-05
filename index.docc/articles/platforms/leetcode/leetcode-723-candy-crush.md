# LeetCode 723: Candy Crush


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/candy-crush/", label: "Solve on LeetCode")
}


> Warning: 1. Repeat crush and drop until the board stabilizes. } > Warning: 2. Mark candies to crush without interfering with detection. } }


Simulate candy crush elimination until the board stops changing.

## Warnings

@Row {
  @Column {
    > Warning: 1. Repeat crush and drop until the board stabilizes.
  }
  @Column {
    > Warning: 2. Mark candies to crush without interfering with detection.
  }
}

## Problem

- Simulate candy crush elimination until the board stops changing.

## Solution

- Scan for 3+ matches, mark them, drop remaining candies, and repeat.
- Time O(mn * cycles), space O(1) extra if marking in place.

## Tips

- Use negative values to mark crushed cells.
- Validate against boards that already are stable.

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
