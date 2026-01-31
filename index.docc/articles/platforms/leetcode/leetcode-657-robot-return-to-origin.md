
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-657-robot-return-to-origin-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-657-robot-return-to-origin-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-657-robot-return-to-origin-icon.codex", alt: "Placeholder icon")
# LeetCode 657: Robot Return to Origin

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-657-robot-return-to-origin-dsa-icon.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-657-robot-return-to-origin-dsa-card.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/robot-return-to-origin/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-657-robot-return-to-origin-dsa-hero.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Do not overthink; a simple coordinate accumulator is enough. } > Warning: 2. Pay attention to uppercase direction letters. } }

@Image(source: "leetcode-657-robot-return-to-origin-dsa-top.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

Given a sequence of moves, determine if the robot returns to (0, 0).

## Warnings

@Row {
  @Column {
    > Warning: 1. Do not overthink; a simple coordinate accumulator is enough.
  }
  @Column {
    > Warning: 2. Pay attention to uppercase direction letters.
  }
}

## Problem

- Given a sequence of moves, determine if the robot returns to (0, 0).

## Solution

- Track x/y deltas for each move and check if both end at zero.
- Time O(n), space O(1).

## Tips

- Map U/D to y and L/R to x for clarity.
- Include the empty string and repeated moves in tests.

## Breakdown + Script

@Row {
  @Column {
    - Maintain dx,dy; U/D adjust y; L/R adjust x
    - Return dx==0 && dy==0
    Diagram source: `Resources/diag-script-657-robot-return-origin.svg`
  }
  @Column {
    - Hook: end at origin?
    - Core: simple loop; ignore invalid chars
    - Wrap: tests 'UD', 'LL', 'URDL'
  }
}

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
