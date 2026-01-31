# Gaming Deep Dive — LeetCode 874: Walking Robot Simulation

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 874 — Walking Robot Simulation")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-874-walking-robot-simulation-icon.codex", alt: "Gaming Deep Dive — 874 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-874-walking-robot-simulation-card.codex", alt: "Gaming Deep Dive — 874 card")
  @CallToAction(url: "https://leetcode.com/problems/walking-robot-simulation/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-874-walking-robot-simulation-hero.codex", alt: "Gaming Deep Dive LeetCode 874 Walking Robot Simulation hero")

## Overview

Simulate movement on a grid with turns, forward steps, and obstacles. Track the squared distance.

## Invariant

- `(x, y, dir)` fully describes state; `dir` ∈ {0:N, 1:E, 2:S, 3:W}.
- Obstacles are stored in a hash set for O(1) collision checks.

## Approach

- Maintain `dir` and step deltas; for each forward step, try to move; if blocked, stop stepping.
- Update `maxDist2 = max(maxDist2, x*x + y*y)` after each step.

## Complexity

- O(n) over commands; obstacle lookups O(1) average.

## Test Plan

1. No obstacles; only forward steps.
2. Immediate obstacle in front; ensure stop/turn behaviors.
3. Mix of left/right turns and long forward sequences.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-874-walking-robot-simulation>
}
