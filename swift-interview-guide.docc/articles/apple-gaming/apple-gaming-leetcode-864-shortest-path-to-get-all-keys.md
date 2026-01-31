@PageImage(purpose: card, source: "apple-gaming-apple-gaming-leetcode-864-shortest-path-to-get-all-keys-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-apple-gaming-leetcode-864-shortest-path-to-get-all-keys-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-apple-gaming-leetcode-864-shortest-path-to-get-all-keys-icon.codex", alt: "Placeholder icon")
# Gaming Deep Dive — LeetCode 864: Shortest Path to Get All Keys

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 864 — Shortest Path to Get All Keys")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-864-shortest-path-to-get-all-keys-icon.codex", alt: "Gaming Deep Dive — 864 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-864-shortest-path-to-get-all-keys-card.codex", alt: "Gaming Deep Dive — 864 card")
  @CallToAction(url: "https://leetcode.com/problems/shortest-path-to-get-all-keys/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-864-shortest-path-to-get-all-keys-hero.codex", alt: "Gaming Deep Dive LeetCode 864 Shortest Path to Get All Keys hero")

## Overview

Grid BFS with a keys bitmask; doors require corresponding key to pass.

## Invariant

- State is `(r, c, keysMask)`; visited depends on the mask since acquiring more keys unlocks new paths.

## Approach

- Parse grid to find start and number of keys; BFS from start with mask 0.
- When stepping onto a key `a..f`, set its bit; when encountering a door `A..F`, require the bit to be set.
- Target is any state with `keysMask == allKeysMask`.

## Complexity

- O(R·C·2^K) states; edges up to 4 per state. Space proportional to visited set.

## Test Plan

1. No doors → behaves like plain BFS to collect keys.
2. Keys behind doors → must find different route ordering.
3. Unreachable key → return −1.
