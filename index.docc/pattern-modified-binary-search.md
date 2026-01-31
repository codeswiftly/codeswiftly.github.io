
@Image(source: "pattern-modified-binary-search-hero.codex", alt: "Placeholder hero")
# Pattern 05: Modified Binary Search

@Metadata {
  @TitleHeading("Practice Modified Binary Search")
  @PageImage(purpose: icon, source: "pattern-modified-binary-search-icon.codex", alt: "Pattern 05: Modified Binary Search icon")
  @PageImage(purpose: card, source: "pattern-modified-binary-search-card.codex", alt: "Pattern 05: Modified Binary Search card")
}

@Image(source: "modified-binary-search-diagram.codex", alt: "Binary search on rotated array")

Adapt binary search to handle rotated arrays, infinite streams, or solution spaces defined by a monotonic predicate.

## Problem

- Rotated arrays or monotone predicates over an answer space.

## Solution

- Identify the sorted half or binary search on a predicate.

## Concept

Standard binary search divides a sorted range in half. Modified binary search handles cases where the sort order is broken (rotation) or implicit (finding the minimal value satisfying a condition).

- **Rotation**: Determine which half [start...mid] or [mid...end] is sorted to decide where to move.
- **Answer Space**: If `check(x)` is false for all `x < k` and true for all `x >= k`, binary search can find `k`.

## Complexity

- **Time**: O(log N). Each step halves the search space.
- **Space**: O(1). Iterative implementation.

## When to Use

- **Rotated Arrays**: Finding an element or minimum in a rotated sorted array.
- **Implicit Sorted Data**: Finding square roots, first bad version (Git bisect style), or capacity planning (Koko eating bananas).

## Examples

### 1. Search in Rotated Sorted Array

@Image(source: "modified-binary-search-rotated-example.codex", alt: "Rotated array search with a sorted half")

```swift
func search(_ nums: [Int], _ target: Int) -> Int {
  var left = 0
  var right = nums.count - 1

  while left <= right {
    let mid = left + (right - left) / 2
    if nums[mid] == target { return mid }

    // Check if left half is sorted
    if nums[left] <= nums[mid] {
      if nums[left] <= target && target < nums[mid] {
        right = mid - 1
      } else {
        left = mid + 1
      }
    } else {
      // Right half is sorted
      if nums[mid] < target && target <= nums[right] {
        left = mid + 1
      } else {
        right = mid - 1
      }
    }
  }
  return -1
}
```

### 2. First Bad Version

Find the first version that fails a quality check, minimizing calls to the API.

@Image(source: "modified-binary-search-first-bad-version.codex", alt: "Binary search shrinking range to first bad version")

```swift
// Mock API
func isBadVersion(_ version: Int) -> Bool { return true }

func firstBadVersion(_ n: Int) -> Int {
  var left = 1
  var right = n
  var result = n

  while left <= right {
    let mid = left + (right - left) / 2
    if isBadVersion(mid) {
      result = mid
      right = mid - 1  // Try to find an earlier bad version
    } else {
      left = mid + 1
    }
  }
  return result
}
```

## Common Pitfalls

- **Overflow**: Calculate mid as `left + (right - left) / 2` to avoid integer overflow.
- **Loop Termination**: Use `left <= right` for searching a value, `left < right` for finding boundaries, depending on preference, but be consistent.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-33-search-rotated-sorted-array>
- <doc:leetcode-4-median-two-sorted-arrays>
- <doc:leetcode-2439-minimize-maximum-array>
}

## See Also

- <doc:top-15-patterns>
