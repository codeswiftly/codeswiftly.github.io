# LeetCode LCCI 08.06: Hanota




> Warning: 1. Ensure the recursion base case moves exactly one disk. } > Warning: 2. Do not mutate stacks out of order. } }


Link: <https://leetcode.cn/problems/hanota-lcci/> Move disks between pegs following the classic Towers of Hanoi rules.

## Warnings

@Row {
  @Column {
    > Warning: 1. Ensure the recursion base case moves exactly one disk.
  }
  @Column {
    > Warning: 2. Do not mutate stacks out of order.
  }
}

## Problem

- Link: <https://leetcode.cn/problems/hanota-lcci/>
- Move disks between pegs following the classic Towers of Hanoi rules.

## Solution

- Recursively move n-1 disks to the buffer, move the largest, then move n-1 to target.
- Time O(2^n), space O(n) for recursion depth.

## Tips

- Use arrays as stacks and append/pop for moves.
- Test with n = 1 and n = 2 for clarity.

## 3‑Minute Script

See full script: <doc:script-lcci-08-06-hanota>

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
