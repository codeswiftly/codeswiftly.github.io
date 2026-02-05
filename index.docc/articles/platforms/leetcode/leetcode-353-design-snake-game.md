# LeetCode 353: Design Snake Game

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-353-design-snake-game-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-353-design-snake-game-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-353-design-snake-game-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-353-design-snake-game-dsa-icon.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-353-design-snake-game-dsa-card.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/design-snake-game/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-353-design-snake-game-dsa-hero.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Use a queue and set for O(1) body updates and collision checks. } > Warning: 2. Remove the tail before checking self-collision on non-food moves. } }

@Image(source: "leetcode-353-design-snake-game-dsa-top.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")

Design a Snake game that reports score after each move.

## Warnings

@Row {
  @Column {
    > Warning: 1. Use a queue and set for O(1) body updates and collision checks.
  }
  @Column {
    > Warning: 2. Remove the tail before checking self-collision on non-food moves.
  }
}

## Problem

- Design a Snake game that reports score after each move.

## Solution

- Store the snake body in a deque and positions in a set.
- On each move, compute the new head, handle food, and update structures.

## Tips

- Treat the tail as free space when the snake moves without eating.
- Test boundary hits, immediate self-collisions, and growth cases.

## Breakdown + Script

@Row {
  @Column {
    - DS: deque body, set positions
    - Move: compute head; allow tail cell if not eating
    - Collisions: wall or head in set (not tail) → game over
    - Complexity: O(1) per move
    Diagram source: `Resources/diag-script-353-snake-game-state.svg`
  }
  @Column {
    - Hook: design API, collisions + growth
    - Core: pop tail if no food; push head; update score
    - Edges: tail‑eat case; boundaries; instant self‑hit
    - Wrap: O(1) ops; clean API
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
