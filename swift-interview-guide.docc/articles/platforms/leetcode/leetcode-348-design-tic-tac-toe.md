
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-348-design-tic-tac-toe-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-348-design-tic-tac-toe-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-348-design-tic-tac-toe-icon.codex", alt: "Placeholder icon")
# LeetCode 348: Design Tic-Tac-Toe

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-348-design-tic-tac-toe-dsa-icon.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-348-design-tic-tac-toe-dsa-card.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/design-tic-tac-toe/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-348-design-tic-tac-toe-dsa-hero.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Avoid O(n^2) scans per move; keep constant-time updates. } > Warning: 2. Confirm diagonal indexing and player identifiers are consistent. } }

@Image(source: "leetcode-348-design-tic-tac-toe-dsa-top.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")

Design a Tic-Tac-Toe class that reports a winner after each move.

## Warnings

@Row {
  @Column {
    > Warning: 1. Avoid O(n^2) scans per move; keep constant-time updates.
  }
  @Column {
    > Warning: 2. Confirm diagonal indexing and player identifiers are consistent.
  }
}

## Problem

- Design a Tic-Tac-Toe class that reports a winner after each move.

## Solution

- Maintain row, column, and diagonal counters per player.
- Update counters on each move and return winner when absolute value hits n.

## Tips

- Use one counter array with +1 for player 1 and -1 for player 2.
- Validate n and ensure moves remain inside the board.

## Breakdown + Script

@Row {
  @Column {
    ### Project Breakdown
    - State: rows[n], cols[n], diag, antiDiag; +1/-1 per player.
    - Check: any abs(counter) == n → winner.
    - Complexity: O(1) per move; O(n) state.

    Diagram source: `Resources/diag-script-348-design-tic-tac-toe-lines.svg`
  }
  @Column {
    ### 3‑Minute Script (Beats)
    - Hook: “O(1) move(), no rescans.”
    - Core: update four counters; abs==n → win.
    - Wrap: generalizes 1275 to any n.

    See full script: <doc:script-348-design-tic-tac-toe>
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
