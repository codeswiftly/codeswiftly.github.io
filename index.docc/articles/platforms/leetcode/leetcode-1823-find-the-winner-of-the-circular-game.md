# LeetCode 1823: Find the Winner of the Circular Game


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/find-the-winner-of-the-circular-game/", label: "Solve on LeetCode")
}


> Warning: 1. Be careful with index math as the circle shrinks. } > Warning: 2. Use 0-based indexing internally and convert to 1-based output. } }


Simulate eliminating every k-th player until one remains.

## Warnings

@Row {
  @Column {
    > Warning: 1. Be careful with index math as the circle shrinks.
  }
  @Column {
    > Warning: 2. Use 0-based indexing internally and convert to 1-based output.
  }
}

## Problem

- Simulate eliminating every k-th player until one remains.

## Solution

- Use the Josephus recurrence or simulate with a queue.
- Recurrence: winner = (winner + k) % n. Time O(n).

## Tips

- Mention both simulation and recurrence approaches in interviews.
- Test with n = 1 and k = 1 for sanity.

## 3‑Minute Script

See full script: <doc:script-1823-find-the-winner-of-the-circular-game>

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
