# Gaming Deep Dive — LeetCode 407: Trapping Rain Water II


@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 407 — Trapping Rain Water II")
  @CallToAction(url: "https://leetcode.com/problems/trapping-rain-water-ii/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


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
