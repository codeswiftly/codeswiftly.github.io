# LeetCode 733: Flood Fill

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-733-flood-fill-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-733-flood-fill-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-733-flood-fill-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-733-flood-fill-dsa-icon.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @PageImage(purpose: card, source: "leetcode-733-flood-fill-dsa-card.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")
  @CallToAction(url: "https://leetcode.com/problems/flood-fill/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-733-flood-fill-dsa-hero.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

> Warning: 1. Avoid infinite loops by checking the original color. } > Warning: 2. Use bounds checks on every neighbor visit. } }

@Image(source: "leetcode-733-flood-fill-dsa-top.codex", alt: "Easy problem - Pattern 13 (Matrix Traversal)")

Recolor all connected pixels starting from a seed cell.

## Warnings

@Row {
  @Column {
    > Warning: 1. Avoid infinite loops by checking the original color.
  }
  @Column {
    > Warning: 2. Use bounds checks on every neighbor visit.
  }
}

## Problem

- Recolor all connected pixels starting from a seed cell.

## Solution

- Use DFS or BFS to visit connected cells matching the original color.
- Time O(mn) in the worst case, space O(mn) for recursion/queue.

## Tips

- Early-return if the new color equals the original color.
- Prefer iterative BFS in Swift to avoid deep recursion limits.

## Breakdown + Script

@Row {
  @Column {
    - Guard: if start already newColor → return
    - Visit: BFS/DFS from seed; recolor; push matching neighbors
    - Complexity: O(painted cells)
    Diagram source: `Resources/diag-script-733-flood-fill-dfs.svg`
  }
  @Column {
    - Hook: paint bucket as BFS/DFS
    - Setup: sr, sc, newColor; early guard
    - Core: pop, recolor, push valid neighbors
    - Wrap: test single cell, border, full fill
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
