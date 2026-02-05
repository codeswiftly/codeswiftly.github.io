# LeetCode 909: Snakes and Ladders


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/snakes-and-ladders/", label: "Solve on LeetCode")
}


> Warning: 1. Map 1-based squares to board coordinates correctly. } > Warning: 2. Use BFS to guarantee minimum moves. } }


Return the minimum number of moves to reach the final square.

## Warnings

@Row {
  @Column {
    > Warning: 1. Map 1-based squares to board coordinates correctly.
  }
  @Column {
    > Warning: 2. Use BFS to guarantee minimum moves.
  }
}

## Problem

- Return the minimum number of moves to reach the final square.

## Solution

- Run BFS from square 1, expanding up to 6 dice rolls each step.
- Apply snake/ladder jumps when landing on a square.

## Tips

- Precompute a square-to-coordinate helper.
- Track visited squares to avoid cycles.

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
