# LeetCode 773: Sliding Puzzle


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/sliding-puzzle/", label: "Solve on LeetCode")
}


> Warning: 1. State explosion requires visited tracking and BFS pruning. } > Warning: 2. Encode the board consistently to avoid duplicate states. } }


Return the minimum moves to solve a 2x3 sliding puzzle.

## Warnings

@Row {
  @Column {
    > Warning: 1. State explosion requires visited tracking and BFS pruning.
  }
  @Column {
    > Warning: 2. Encode the board consistently to avoid duplicate states.
  }
}

## Problem

- Return the minimum moves to solve a 2x3 sliding puzzle.

## Solution

- BFS over board states using a fixed neighbor map for the blank.
- Time O(states), space O(states).

## Tips

- Use a string like "123450" as the state key.
- Early-exit when the target state is found.

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
