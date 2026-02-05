# LeetCode 289: Game of Life


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/game-of-life/", label: "Solve on LeetCode")
}


> Warning: 1. Update in place with state encoding to avoid extra memory. } > Warning: 2. Count neighbors carefully at the grid edges. } }


Compute the next state of the board based on neighbor counts.

## Warnings

@Row {
  @Column {
    > Warning: 1. Update in place with state encoding to avoid extra memory.
  }
  @Column {
    > Warning: 2. Count neighbors carefully at the grid edges.
  }
}

## Problem

- Compute the next state of the board based on neighbor counts.

## Solution

- Encode transitions (live->dead, dead->live) with temporary values.
- Finalize by normalizing values after the pass.

## Tips

- Use direction offsets for 8 neighbors.
- Test small patterns like blinker or block.

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
