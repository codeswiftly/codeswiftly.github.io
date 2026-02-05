# LeetCode 51: N-Queens


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/n-queens/", label: "Solve on LeetCode")
}


> Warning: 1. Prune invalid placements early using column and diagonal sets. } > Warning: 2. Avoid generating duplicate boards by enforcing row-by-row placement. } }


Return all valid placements of n queens on an n x n chessboard.

## Warnings

@Row {
  @Column {
    > Warning: 1. Prune invalid placements early using column and diagonal sets.
  }
  @Column {
    > Warning: 2. Avoid generating duplicate boards by enforcing row-by-row placement.
  }
}

## Problem

- Return all valid placements of n queens on an n x n chessboard.

## Solution

- Backtrack row by row, tracking occupied columns and diagonals.
- Time is exponential; pruning keeps it manageable for n <= 9.

## Tips

- Encode diagonals as row-col and row+col.
- Build the board from column placements at the end of each solution.

## 3‑Minute Script

See full script: <doc:script-51-n-queens>

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
