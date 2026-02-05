# LeetCode 529: Minesweeper


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/minesweeper/", label: "Solve on LeetCode")
}


> Warning: 1. Reveal stops on non-zero adjacent mine counts. } > Warning: 2. Do not revisit cells; track visited or update in place. } }


Reveal squares on a minesweeper board after a click.

## Warnings

@Row {
  @Column {
    > Warning: 1. Reveal stops on non-zero adjacent mine counts.
  }
  @Column {
    > Warning: 2. Do not revisit cells; track visited or update in place.
  }
}

## Problem

- Reveal squares on a minesweeper board after a click.

## Solution

- If the click hits a mine, mark it and return.
- Otherwise BFS/DFS, count adjacent mines, and reveal neighbors when count is zero.

## Tips

- Precompute direction offsets for 8 neighbors.
- Test edge clicks and boards with no adjacent mines.

## Breakdown + Script

@Row {
  @Column {
    - Click on 'M' → set 'X' and return
    - Else BFS: count neighbors; label if >0; expand when 0
    - Complexity: O(m·n) worst
    Diagram source: `Resources/diag-script-529-minesweeper-reveal.svg`
  }
  @Column {
    - Hook: reveal with correct cascade
    - Core: count; expand zeros; label otherwise
    - Wrap: test mine click, zero‑expansion, edges
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
