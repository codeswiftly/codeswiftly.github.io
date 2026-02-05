# Gaming Deep Dive — LeetCode 407: Trapping Rain Water II

@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-407-trapping-rain-water-ii-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-407-trapping-rain-water-ii-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-407-trapping-rain-water-ii-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 407 — Trapping Rain Water II")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-407-trapping-rain-water-ii-icon.codex", alt: "Gaming Deep Dive — 407 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-407-trapping-rain-water-ii-card.codex", alt: "Gaming Deep Dive — 407 card")
  @CallToAction(url: "https://leetcode.com/problems/trapping-rain-water-ii/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-407-trapping-rain-water-ii-hero.codex", alt: "Gaming Deep Dive LeetCode 407 Trapping Rain Water II hero")

## Overview

Compute water trapped on a 2D elevation map using a min‑heap frontier from the borders inward.

## Invariant

- The current water level is the minimum boundary height seen so far. When visiting a cell, if `height < level`, we trap `level-height`; we then push `max(height, level)` to the heap.

## Approach

- Push all border cells into a min‑heap and mark visited; pop the lowest, update level, and relax neighbors.

## Complexity

- O(m·n log(m·n)) heap operations; O(m·n) space.

## Test Plan

1. Flat plateau (no water).
2. Bowl with higher rim → positive volume.
3. Multiple basins separated by ridges.
