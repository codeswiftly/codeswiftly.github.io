# LeetCode 1496: Path Crossing


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/path-crossing/", label: "Solve on LeetCode")
}


> Warning: 1. Track every visited coordinate, not just turns. } > Warning: 2. Use a hash set to detect revisits quickly. } }


Determine if a path crosses itself while moving on a grid.

## Warnings

@Row {
  @Column {
    > Warning: 1. Track every visited coordinate, not just turns.
  }
  @Column {
    > Warning: 2. Use a hash set to detect revisits quickly.
  }
}

## Problem

- Determine if a path crosses itself while moving on a grid.

## Solution

- Walk step by step and insert coordinates into a set.
- If a coordinate repeats, the path crosses. Time O(n), space O(n).

## Tips

- Use "x,y" strings or a tuple hash for keys.
- Include the origin as the first visited point.

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
