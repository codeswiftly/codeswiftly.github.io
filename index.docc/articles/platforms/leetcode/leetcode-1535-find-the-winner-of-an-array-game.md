# LeetCode 1535: Find the Winner of An Array Game


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/find-the-winner-of-an-array-game/", label: "Solve on LeetCode")
}


> Warning: 1. Stop once a value wins k times or becomes the maximum element. } > Warning: 2. Avoid simulating full rotations once the max is at front. } }


Find the winner in an array game where the front element must win k rounds.

## Warnings

@Row {
  @Column {
    > Warning: 1. Stop once a value wins k times or becomes the maximum element.
  }
  @Column {
    > Warning: 2. Avoid simulating full rotations once the max is at front.
  }
}

## Problem

- Find the winner in an array game where the front element must win k rounds.

## Solution

- Track the current champion and consecutive wins while scanning the array.
- Once wins hit k, return the champion; otherwise the max eventually wins.

## Tips

- Precompute the array max to short-circuit for large k.
- Test k = 1 and k larger than the array length.

## 3‑Minute Script

See full script: <doc:script-1535-find-the-winner-of-an-array-game>

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
