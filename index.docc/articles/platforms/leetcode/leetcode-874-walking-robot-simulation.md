# LeetCode 874: Walking Robot Simulation

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-874-walking-robot-simulation-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-874-walking-robot-simulation-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-874-walking-robot-simulation-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-874-walking-robot-simulation-dsa-icon.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-874-walking-robot-simulation-dsa-card.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/walking-robot-simulation/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-874-walking-robot-simulation-dsa-hero.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Represent obstacles in a hash set for O(1) checks. } > Warning: 2. Carefully update direction and position for each command. } }

@Image(source: "leetcode-874-walking-robot-simulation-dsa-top.codex", alt: "Medium problem - Pattern 13 (Matrix Traversal)")

Simulate a robot on a grid with obstacles and return the max distance squared.

## Warnings

@Row {
  @Column {
    > Warning: 1. Represent obstacles in a hash set for O(1) checks.
  }
  @Column {
    > Warning: 2. Carefully update direction and position for each command.
  }
}

## Problem

- Simulate a robot on a grid with obstacles and return the max distance squared.

## Solution

- Keep a direction index and step per command until blocked.
- Track the max x^2 + y^2. Time O(n + steps), space O(obstacles).

## Tips

- Encode obstacles as "x,y" strings or a tuple hash.
- Confirm turn commands (-1, -2) handling with small tests.

## Breakdown + Script

@Row {
  @Column {
    ### Project Breakdown
    - Direction index 0..3 with (dx,dy) table.
    - Commands: -1 right, -2 left, k forward steps with obstacle checks.
    - Track max r² during movement; stop early if obstacle blocks.

    Diagram source: `Resources/diag-script-874-walking-robot-simulation-steps.svg`
  }
  @Column {
    ### 3‑Minute Script (Beats)
    - Hook: “Navigate with turns and obstacles.”
    - Core: rotate on -1/-2; step k times or until blocked.
    - Wrap: O(total steps); obstacle set for O(1) lookup.

    Script (inline, 3‑min beats)
    - Hook: “Navigate with turns and obstacles.”
    - Core: rotate on -1/-2; step k times or until blocked.
    - Wrap: O(total steps); obstacle set for O(1) lookup.
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
