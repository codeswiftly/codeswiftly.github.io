# LeetCode 999: Available Captures for Rook

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-999-available-captures-for-rook-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-999-available-captures-for-rook-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-999-available-captures-for-rook-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-999-available-captures-for-rook-dsa-icon.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-999-available-captures-for-rook-dsa-card.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/available-captures-for-rook/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-999-available-captures-for-rook-dsa-hero.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Stop scanning in a direction once you hit a piece. } > Warning: 2. Watch for bounds when moving along rows and columns. } }

@Image(source: "leetcode-999-available-captures-for-rook-dsa-top.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

Count the pawns a rook can capture on a chessboard.

## Warnings

@Row {
  @Column {
    > Warning: 1. Stop scanning in a direction once you hit a piece.
  }
  @Column {
    > Warning: 2. Watch for bounds when moving along rows and columns.
  }
}

## Problem

- Count the pawns a rook can capture on a chessboard.

## Solution

- Locate the rook, then scan four directions until blocked.
- Count pawns encountered before a blocking bishop.

## Tips

- Use direction arrays for uniform scanning.
- Test boards where the rook is adjacent to a pawn or bishop.

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
