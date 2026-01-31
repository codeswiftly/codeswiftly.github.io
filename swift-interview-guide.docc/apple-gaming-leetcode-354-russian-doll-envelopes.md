# Gaming Deep Dive — LeetCode 354: Russian Doll Envelopes

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 354 — Russian Doll Envelopes")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-354-russian-doll-envelopes-icon.codex", alt: "Gaming Deep Dive — 354 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-354-russian-doll-envelopes-card.codex", alt: "Gaming Deep Dive — 354 card")
  @CallToAction(url: "https://leetcode.com/problems/russian-doll-envelopes/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-354-russian-doll-envelopes-hero.codex", alt: "Gaming Deep Dive LeetCode 354 Russian Doll Envelopes hero")

## Overview

Sort + LIS with tie‑break on width to avoid equal width nesting.

## Invariant

- Widths strictly increase; heights form LIS after sorting (width asc, height desc).

## Approach

- Sort (w asc, h desc); run patience sorting (binary search) on heights.

## Complexity

- O(n log n) time, O(n) space.

## Test Plan

1. Equal widths different heights (must not count as nested).
2. Strictly increasing widths and heights.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-354-russian-doll-envelopes>
- <doc:script-354-russian-doll-envelopes>
}
