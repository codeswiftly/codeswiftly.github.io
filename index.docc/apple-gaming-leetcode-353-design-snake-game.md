# Gaming Deep Dive — LeetCode 353: Design Snake Game

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 353 — Design Snake Game")
  @CallToAction(url: "https://leetcode.com/problems/design-snake-game/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Classic stateful simulation: queue‑based snake body, grid bounds, self‑collision, and food consumption.

## Invariant

- A deque holds snake cells in order (head at front). A set holds occupied cells (except tail when moving).

## Approach

- Compute next head from direction; pop tail unless eating; check bounds/self‑hit with the set.

## Complexity

- O(1) per move with O(k) space for k cells.

## Test Plan

1. Straight moves no food; ensure score 0.
2. Eat then move; tail not removed on eat step.
3. Self‑collision case and border collision.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-353-design-snake-game>
}
