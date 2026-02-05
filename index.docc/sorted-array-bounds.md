# Searching First/Last Occurrence in a Sorted Array (from An Offset)

@Metadata {
  @TitleHeading("Review Searching First/Last Occurrence in a Sorted Array (from an Offset)")
}


Find the first and last index of a target in a sorted `Array` using binary search, starting at a
given offset. Works with `Comparable` elements; O(log n) time, O(1) space.

```swift
// Returns the first or last index of target at or after `start`, if present.
// pass findFirst = true for lower bound; false for upper bound.
func boundIndex<T: Comparable>(
  of target: T,
  in sorted: [T],
  startingAt start: Int = 0,
  findFirst: Bool
) -> Int? {
  var low = max(start, 0)
  var high = sorted.count - 1
  var result: Int?

  while low <= high {
    let mid = (low + high) / 2
    if sorted[mid] < target {
      low = mid + 1
    } else if target < sorted[mid] {
      high = mid - 1
    } else {
      result = mid
      if findFirst {
        high = mid - 1  // continue left
      } else {
        low = mid + 1  // continue right
      }
    }
  }
  return result
}

func firstIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, findFirst: true)
}

func lastIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, findFirst: false)
}
```

Example:

```swift
let nums = [1, 2, 2, 2, 3, 4, 5]
firstIndex(of: 2, in: nums)  // 1
lastIndex(of: 2, in: nums)  // 3
firstIndex(of: 2, in: nums, startingAt: 2)  // 2
lastIndex(of: 2, in: nums, startingAt: 2)  // 3
firstIndex(of: 6, in: nums)  // nil
```

Notes:

- Uses standard binary search; when found, shifts the search window to continue toward the edge
  (left for first, right for last).
- `start` lets you ignore earlier positions (e.g., when scanning segments).
- If you need insertion positions instead, return `low` at exit (lower/upper bound pattern).
