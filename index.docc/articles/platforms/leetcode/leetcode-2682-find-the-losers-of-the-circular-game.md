# LeetCode 2682: Find the Losers of the Circular Game

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-2682-find-the-losers-of-the-circular-game-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-2682-find-the-losers-of-the-circular-game-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-2682-find-the-losers-of-the-circular-game-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-2682-find-the-losers-of-the-circular-game-dsa-icon.codex", alt: "Easy problem - Pattern 6 (Fast/Slow Pointers)")
  @PageImage(purpose: card, source: "leetcode-2682-find-the-losers-of-the-circular-game-dsa-card.codex", alt: "Easy problem - Pattern 6 (Fast/Slow Pointers)")
  @CallToAction(url: "https://leetcode.com/problems/find-the-losers-of-the-circular-game/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-2682-find-the-losers-of-the-circular-game-dsa-hero.codex", alt: "Easy problem - Pattern 6 (Fast/Slow Pointers)")

> Warning: 1. Track visited players to avoid infinite loops. } > Warning: 2. Use 1-based indexing for player labels. } }

@Image(source: "leetcode-2682-find-the-losers-of-the-circular-game-dsa-top.codex", alt: "Easy problem - Pattern 6 (Fast/Slow Pointers)")

Simulate passing a ball in a circle and return players who never touched it.

## Warnings

@Row {
  @Column {
    > Warning: 1. Track visited players to avoid infinite loops.
  }
  @Column {
    > Warning: 2. Use 1-based indexing for player labels.
  }
}

## Problem

- Simulate passing a ball in a circle and return players who never touched it.

## Solution

- Walk the circle with step sizes that increase each round.
- Mark visited players and collect those never visited at the end.

## Tips

- Use modulo arithmetic to wrap around n players.
- Test small n to validate the stepping pattern.

## 3‑Minute Script

See full script: <doc:script-2682-find-the-losers-of-the-circular-game>

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
