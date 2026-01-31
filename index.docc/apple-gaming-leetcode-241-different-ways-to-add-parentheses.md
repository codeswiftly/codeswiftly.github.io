# Gaming Deep Dive — LeetCode 241: Different Ways to Add Parentheses

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 241 — Different Ways to Add Parentheses")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-241-different-ways-to-add-parentheses-icon.codex", alt: "Gaming Deep Dive — 241 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-241-different-ways-to-add-parentheses-card.codex", alt: "Gaming Deep Dive — 241 card")
  @CallToAction(url: "https://leetcode.com/problems/different-ways-to-add-parentheses/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-241-different-ways-to-add-parentheses-hero.codex", alt: "Gaming Deep Dive LeetCode 241 Different Ways to Add Parentheses hero")

## Overview

Divide‑and‑combine recursion with memoization on subexpression ranges.

## Invariant

- `solve(l,r)` returns all results for substring [l,r]; cache by range.

## Approach

- Split at each operator; combine left×right results with the operator.

## Complexity

- Exponential without memoization; memo reduces repeated work.

## Test Plan

1. Single number.
2. Multiple operators; verify all combinations.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-241-different-ways-to-add-parentheses>
- <doc:script-241-different-ways-to-add-parentheses>
}
