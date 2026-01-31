@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-1345-jump-game-iv-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-1345-jump-game-iv-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-1345-jump-game-iv-icon.codex", alt: "Placeholder icon")
# Gaming Deep Dive — LeetCode 1345: Jump Game IV

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1345 — Jump Game IV")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1345-jump-game-iv-icon.codex", alt: "Gaming Deep Dive — 1345 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1345-jump-game-iv-card.codex", alt: "Gaming Deep Dive — 1345 card")
  @CallToAction(url: "https://leetcode.com/problems/jump-game-iv/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1345-jump-game-iv-hero.codex", alt: "Gaming Deep Dive LeetCode 1345 Jump Game IV hero")

## Overview

Minimum jumps to reach the last index; edges connect `i±1` and all indices with the same value.

## Invariant

- BFS from index 0; once we expand all neighbors for a value `v`, clear its list to avoid re‑adding O(n²) edges.

## Approach

- Precompute `value -> [indices]` map.
- BFS: enqueue 0; from `i` push `i-1`, `i+1`, and all indices in `map[a[i]]`; then `map[a[i]].removeAll()`.

## Complexity

- O(n) amortized (each index and value bucket processed once). Space O(n).

## Test Plan

1. All distinct values → behaves like linear BFS (answer n-1).
2. Many duplicates that let you jump far in one step.
3. Single element array (0 jumps).
