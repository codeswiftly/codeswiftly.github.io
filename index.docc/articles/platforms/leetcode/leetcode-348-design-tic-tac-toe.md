# LeetCode 348: Design Tic-Tac-Toe


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/design-tic-tac-toe/", label: "Solve on LeetCode")
}


> Warning: 1. Avoid O(n^2) scans per move; keep constant-time updates. } > Warning: 2. Confirm diagonal indexing and player identifiers are consistent. } }


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
