
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-lcci-08-06-hanota-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-lcci-08-06-hanota-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-lcci-08-06-hanota-icon.codex", alt: "Placeholder icon")
# LeetCode LCCI 08.06: Hanota

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-lcci-08-06-hanota-dsa-icon.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
  @PageImage(purpose: card, source: "leetcode-lcci-08-06-hanota-dsa-card.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
}

@Image(source: "leetcode-lcci-08-06-hanota-dsa-hero.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

> Warning: 1. Ensure the recursion base case moves exactly one disk. } > Warning: 2. Do not mutate stacks out of order. } }

@Image(source: "leetcode-lcci-08-06-hanota-dsa-top.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

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
