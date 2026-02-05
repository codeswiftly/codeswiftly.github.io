# LeetCode 733: Flood Fill


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/flood-fill/", label: "Solve on LeetCode")
}


> Warning: 1. Avoid infinite loops by checking the original color. } > Warning: 2. Use bounds checks on every neighbor visit. } }


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
