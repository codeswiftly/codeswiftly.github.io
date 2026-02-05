# Finance Deep Dive — LeetCode 2034: Stock Price Fluctuation

@Metadata {
  @TitleHeading("Finance Deep Dive: LeetCode 2034 — Stock Price Fluctuation")
  @PageColor(green)
  @CallToAction(url: "https://leetcode.com/problems/stock-price-fluctuation/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Practice market‑style simulations: repeated updates, a single source of truth for the latest state, and fast queries for current, min, and max.

## Why it Matters

- Game/market simulations are mostly “state + queries”. The pattern here is: latestByTimestamp + two heaps with lazy deletion.

## Invariant (Say This First)

- `latestByTimestamp[t]` stores only the most recent price for timestamp `t`.
- `currentTimestamp` tracks the highest timestamp seen; `currentPrice = latestByTimestamp[currentTimestamp]`.
- Max‑heap and min‑heap store pairs `(price, timestamp)`; discard stale entries on query.

## Approach

- On update: write `latestByTimestamp[t] = price`; adjust `currentTimestamp` if needed; push `(price, t)` into both heaps.
- On `maximum`/`minimum`: pop until the top `(p, t)` matches `latestByTimestamp[t]`.

## Complexity

- Update: O(log n) for heap pushes
- Query: amortized O(log n) from lazy stale removal
- Space: O(n) for heaps + map

## Test Plan (Minimal)

1. Single update → all queries match that value.
2. Two updates same timestamp → current reflects last; min/max respect new value.
3. Interleave older timestamp updates after newer ones → current unchanged; min/max updated.
4. Many updates across timestamps → lazy deletions don’t return stale values.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-2034-stock-price-fluctuation>
}
