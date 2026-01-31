# Gaming Deep Dive — LeetCode LCCI 08.06: Hanota

@Metadata {
  @TitleHeading("Gaming Deep Dive: LCCI 08.06 — Hanota")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-lcci-08-06-hanota-icon.codex", alt: "Gaming Deep Dive — Hanota icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-lcci-08-06-hanota-card.codex", alt: "Gaming Deep Dive — Hanota card")
  @CallToAction(url: "https://leetcode.com/problems/hanota-lcci/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-lcci-08-06-hanota-hero.codex", alt: "Gaming Deep Dive LeetCode LCCI 08 06 Hanota hero")

## Overview

Classic recursion with three stacks; moves follow the Towers of Hanoi pattern.

## Invariant

- Larger disks never go above smaller ones.

## Approach

- Move n−1 from A→B, move last from A→C, move n−1 from B→C.

## Complexity

- O(2^n) moves; O(n) call stack.

## Test Plan

1. n=1, n=2 minimal moves.
2. Verify final order is sorted with largest at bottom.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-lcci-08-06-hanota>
- <doc:script-lcci-08-06-hanota>
}
