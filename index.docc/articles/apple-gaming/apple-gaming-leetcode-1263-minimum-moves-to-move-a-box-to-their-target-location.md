# Gaming Deep Dive — LeetCode 1263: Minimum Moves to Move a Box to Their Target Location


@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1263 — Minimum Moves to Move a Box to Their Target Location")
  @CallToAction(url: "https://leetcode.com/problems/minimum-moves-to-move-a-box-to-their-target-location/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Sokoban‑style BFS. State includes both the player's position and the box position; pushing is only allowed when the player stands behind the box.

## Invariant

- State `(boxR, boxC, playerR, playerC)` with cost measured in pushes. For each direction, the player must be able to reach the pushing cell without moving the box.

## Approach

- 0‑1 BFS / two‑level BFS: moves without pushing keep the same push count; moving the box increases push count by 1.
- Use flood fill to check player reachability to the pushing cell given current box location as a wall.

## Complexity

- Grid flood fills per transition → O(m·n·log(m·n)) or O(m·n) per check depending on structure; state count bounded by `(m·n)²` but pruned by walls.

## Test Plan

1. Straight corridor — minimal pushes equals Manhattan steps.
2. Obstacles force detours to get behind the box.
3. Target unreachable due to walls.
