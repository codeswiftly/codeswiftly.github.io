# LeetCode 1275: Find Winner on a Tic Tac Toe Game

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-1275-find-winner-on-a-tic-tac-toe-game-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-1275-find-winner-on-a-tic-tac-toe-game-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-1275-find-winner-on-a-tic-tac-toe-game-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-1275-find-winner-on-a-tic-tac-toe-game-dsa-icon.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-1275-find-winner-on-a-tic-tac-toe-game-dsa-card.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/find-winner-on-a-tic-tac-toe-game/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-1275-find-winner-on-a-tic-tac-toe-game-dsa-hero.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Avoid rescanning the board after every move; update counts incrementally. } > Warning: 2. Stop early once a winner is detected. } }

@Image(source: "leetcode-1275-find-winner-on-a-tic-tac-toe-game-dsa-top.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

Given a sequence of moves on a 3x3 board, return the game result.

## Warnings

@Row {
  @Column {
    > Warning: 1. Avoid rescanning the board after every move; update counts incrementally.
  }
  @Column {
    > Warning: 2. Stop early once a winner is detected.
  }
}

## Problem

- Given a sequence of moves on a 3x3 board, return the game result.

## Solution

- Track row, column, and diagonal counters with +1/-1 per player.
- A player wins when any counter reaches 3. Time O(m), space O(1).

## Tips

- Use move index parity to select the player.
- Test early wins, full draws, and unfinished games.

## Breakdown + Script

@Row {
  @Column {
    - Invariant: rows/cols/diag/anti counters
    - Update: +1 for A, −1 for B at (r,c)
    - Win check: abs(counter) == 3 → winner
    - Complexity: O(m) time, O(1) space
    Diagram source: `Resources/diag-script-1275-tic-tac-toe-winner-flow.svg`
  }
  @Column {
    - Hook: constant‑memory winner
    - Setup: moves → A/B/Draw/Pending
    - Core: increment counters; check ±3
    - Code: init arrays; update r,c,diag,anti; early return
    - Edges: <5 moves pending; duplicates ignored
    - Wrap: reuse for Design Tic‑Tac‑Toe
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
