# HackerRank -- Array Left Rotation


@Metadata {
  @TitleHeading("Review HackerRank -- Array Left Rotation")
}


## Problem Restatement

Given an array `a` and integer `d`, perform `d` left rotations (circular) and return the resulting
array.

## Core Ideas

- Effective shift is `d % a.count`.
- Build the rotated array by slicing at `shift` and concatenating tail + head.

## Constraints and Complexity

- `1 <= a.count`, `d` may exceed `a.count`.
- Time: `O(n)`; Space: `O(n)` to produce the rotated array (in place also possible with swaps).

## Edge Cases

- `d == 0` or `d % n == 0` → unchanged.
- `n == 1` → unchanged.

## Swift Notes

- Slice with ranges, then append to a reserved array to avoid extra copies.

## Swift Solution

```swift
func rotLeft(a: [Int], d: Int) -> [Int] {
  guard !a.isEmpty else { return [] }
  let shift = d % a.count
  if shift == 0 { return a }

  var result: [Int] = []
  result.reserveCapacity(a.count)
  result.append(contentsOf: a[shift...])
  result.append(contentsOf: a[..<shift])
  return result
}
```

## Quick Tests

```swift
assert(rotLeft(a: [1, 2, 3, 4, 5], d: 4) == [5, 1, 2, 3, 4])
assert(rotLeft(a: [1, 2, 3, 4, 5], d: 5) == [1, 2, 3, 4, 5])
assert(rotLeft(a: [1], d: 10) == [1])
```

## Interview Framing

- Mention using `d % n` to avoid extra work when `d` is large.
- In-place alternatives exist (reverse sections), but copying is simplest and fine for constraints.***
