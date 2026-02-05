# HackerRank -- Quicksort (Part 2)


@Metadata {
  @TitleHeading("Review HackerRank -- Quicksort (Part 2)")
}


## Problem Restatement

Sort an array using quicksort where the pivot is always the first element of the subarray. Maintain
the original order of elements relative to the pivot when partitioning (stable left/right). Treat
subarrays of size `<= 1` as sorted. After each partitioned merge (`left + [pivot] + right`), print
the current subarray.

## Core Ideas

- Divide-and-conquer: partition around the first element, recurse on left, then right.
- Stable partition: collect elements `< pivot` and `> pivot` in their scan order.
- Print after combining `left + pivot + right` for subarrays of length > 1.

## Constraints and Complexity

- Unique elements (per prompt).
- Time: average `O(n log n)`, worst `O(n^2)` if pivot choice is poor (here fixed first).
- Space: `O(n)` extra when building new arrays for stability and printing.

## Edge Cases

- Size 0 or 1: nothing to print; already sorted.
- Already sorted or reverse-sorted still printed once per merge.
- Duplicates aren’t expected; if present, bucket `== pivot` with pivot to stay stable.

## Swift Solution

```swift
import Foundation

func quicksortStable(_ values: [Int]) -> [Int] {
  guard values.count > 1 else { return values }

  let pivot = values[0]
  var left: [Int] = []
  var right: [Int] = []

  for value in values.dropFirst() {
    if value < pivot {
      left.append(value)
    } else {
      right.append(value)
    }
  }

  let sortedLeft = quicksortStable(left)
  let sortedRight = quicksortStable(right)
  let merged = sortedLeft + [pivot] + sortedRight

  print(merged.map(String.init).joined(separator: " "))
  return merged
}

// HackerRank harness
let _ = Int((readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
let array = (readLine() ?? "").split(separator: " ").compactMap { Int($0) }
_ = quicksortStable(array)
```

## Quick Trace (Sample)

Input: `5 8 1 3 7 9 2`

```
2 3
1 2 3
7 8 9
1 2 3 5 7 8 9
```

## Interview Framing

- Emphasize stability via building `left`/`right` arrays (mirrors prompt).
- Note the `O(n^2)` worst case with fixed pivot; mention randomized or median-of-three to improve.
- Printing happens post-merge for each subproblem larger than one element.***
