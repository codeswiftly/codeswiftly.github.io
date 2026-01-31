
@PageImage(purpose: card, source: "platforms-hackerrank-hackerrank-a-very-big-sum-card.codex", alt: "Placeholder card")
@Image(source: "platforms-hackerrank-hackerrank-a-very-big-sum-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-hackerrank-hackerrank-a-very-big-sum-icon.codex", alt: "Placeholder icon")
# HackerRank -- a Very Big Sum

@Metadata {
  @TitleHeading("Review HackerRank -- a Very Big Sum")
  @PageImage(purpose: icon, source: "difficulty-easy.codex", alt: "Easy problem")
  @PageImage(purpose: card, source: "hackerrank-a-very-big-sum-card.codex", alt: "HackerRank a Very Big Sum card")
}

@Image(source: "hackerrank-a-very-big-sum-hero.codex", alt: "HackerRank a Very Big Sum hero")

## Problem Restatement

Given an array of integers, return the sum of its elements. Values can be large, so use a 64-bit
integer for the result.

## Core Ideas

- Straightforward accumulation; no overflow when using 64-bit storage.
- Avoid per-append string parsing costs by mapping once, then reducing.

## Constraints and Complexity

- `1 <= n <= 10^5` (HackerRank sample inputs).
- Time: `O(n)` single pass.
- Space: `O(1)` beyond the input.

## Edge Cases

- Single element.
- All zeros.
- Large values that would overflow 32-bit types.

## Swift Notes

- Use `Int64` for accumulation and return type to mirror “LONG_INTEGER”.
- Convert each `Int` to `Int64` inside the reducer.

## Swift Solution

```swift
func aVeryBigSum(ar: [Int]) -> Int64 {
  ar.reduce(into: 0 as Int64) { total, value in
    total += Int64(value)
  }
}
```

## Quick Tests

```swift
assert(
  aVeryBigSum(ar: [1_000_000_001, 1_000_000_002, 1_000_000_003, 1_000_000_004, 1_000_000_005])
    == 5_000_000_015)
assert(aVeryBigSum(ar: [1]) == 1)
```

## Interview Framing

- Mention why 64-bit storage is required and how Swift’s `Int` maps to platform word size.
- Note that this is a warm-up; for streams, you’d fold as you read rather than storing all values.***
