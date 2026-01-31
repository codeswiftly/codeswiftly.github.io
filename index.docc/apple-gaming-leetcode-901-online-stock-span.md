# Finance Deep Dive - LeetCode 901: Online Stock Span

@Metadata {
  @TitleHeading("Finance Deep Dive: LeetCode 901: Online Stock Span")
  @PageColor(green)
  @CallToAction(url: "https://leetcode.com/problems/online-stock-span/", label: "Solve on LeetCode")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-901-online-stock-span-icon.codex", alt: "Finance Deep Dive LeetCode 901 Online Stock Span icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-901-online-stock-span-card.codex", alt: "Finance Deep Dive LeetCode 901 Online Stock Span card")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-901-online-stock-span-hero.codex", alt: "Finance Deep Dive LeetCode 901 Online Stock Span hero")

## Overview

Online processing with a monotonic decreasing stack that stores `(price, span)` pairs.

## Invariant

- Stack is strictly decreasing by price; span accumulates by popping any smaller/equal prices.

## Approach

- For new `p`, set `s=1`; while stack.top.price <= p, `s += top.span` and pop. Push `(p, s)` and return `s`.

## Complexity

- Amortized O(1) per call (each element is pushed and popped once). O(n) space.

## Test Plan

1. Strictly increasing sequence (spans grow cumulatively).
2. Strictly decreasing sequence (span always 1).
3. Plateaus (equal values) merge into larger spans.

## Local Breakdown

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-901-online-stock-span>

}
