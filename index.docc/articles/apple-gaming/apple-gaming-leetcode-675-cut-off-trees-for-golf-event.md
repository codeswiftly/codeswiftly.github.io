# Gaming Deep Dive — LeetCode 675: Cut Off Trees for Golf Event

@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-675-cut-off-trees-for-golf-event-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-675-cut-off-trees-for-golf-event-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-675-cut-off-trees-for-golf-event-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 675 — Cut Off Trees for Golf Event")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-675-cut-off-trees-for-golf-event-icon.codex", alt: "Gaming Deep Dive — 675 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-675-cut-off-trees-for-golf-event-card.codex", alt: "Gaming Deep Dive — 675 card")
  @CallToAction(url: "https://leetcode.com/problems/cut-off-trees-for-golf-event/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-675-cut-off-trees-for-golf-event-hero.codex", alt: "Gaming Deep Dive LeetCode 675 Cut Off Trees for Golf Event hero")

## Overview

Collect trees in increasing height order; sum shortest path distances between consecutive targets in a grid with obstacles.

## Invariant

- Trees are visited in sorted height order. For each step, run BFS from current to next; if unreachable, return −1.

## Approach

- Extract all cells with value > 1; sort by value; run BFS between waypoints, accumulating steps.

## Complexity

- Each BFS is O(m·n); at most T BFS runs where T is number of trees → O(T·m·n).

## Test Plan

1. Single tree next to start.
2. Tree blocked by zero obstacles → returns −1.
3. Multiple trees with winding paths.
