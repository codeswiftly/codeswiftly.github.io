# Gaming Deep Dive — LeetCode 490: The Maze


@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 490 — The Maze")
  @CallToAction(url: "https://leetcode.com/problems/the-maze/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Roll until hitting a wall; determine if the ball can stop at the destination.

## Invariant

- From each cell and direction, you roll to the farthest reachable stop cell; visit each stop cell at most once.

## Approach

- BFS/DFS over stop cells. For each direction, simulate rolling until just before a wall; enqueue that stop if unseen.

## Complexity

- Each cell is processed up to 4 directions; simulation in total is O(m·n). Space O(m·n).

## Test Plan

1. Straight corridor to goal.
2. Goal reachable only after multiple rolls.
3. Goal unreachable due to walls.
