
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-33-search-rotated-sorted-array-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-33-search-rotated-sorted-array-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-33-search-rotated-sorted-array-icon.codex", alt: "Placeholder icon")
# LeetCode 33: Search in Rotated Sorted Array

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-33-search-rotated-sorted-array-dsa-icon.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")
  @PageImage(purpose: card, source: "leetcode-33-search-rotated-sorted-array-dsa-card.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")
}

@Image(source: "leetcode-33-search-rotated-sorted-array-dsa-hero.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")

Given a strictly increasing array that has been rotated at an unknown pivot and a target value, return the index of the target (or `-1` if absent). Array contains no duplicates.

@Image(source: "leetcode-33-search-rotated-sorted-array-dsa-top.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")

Solve Medium problem.

Given a strictly increasing array that has been rotated at an unknown pivot and a target value,
return the index of the target (or `-1` if absent). Array contains no duplicates.

## Core Ideas

- Modified binary search: at each step, one half is guaranteed sorted. Decide whether the target
  lies within the sorted half; otherwise search the other.

## Constraints and Complexity

- `1 <= nums.count <= 10^4`.
- Values within `[-10^4, 10^4]`.
- Time `O(log n)`, space `O(1)`.

## Edge Cases

- Single-element array.
- Pivot at index `0` (i.e., fully sorted).
- Target outside the range of values.

## Swift Starter

```swift
class Solution {
  func search(_ nums: [Int], _ target: Int) -> Int {
    // TODO: Binary search; decide which half is sorted each step.
    return -1
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func search(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1
    while low <= high {
      let mid = (low + high) / 2
      if nums[mid] == target { return mid }

      if nums[low] <= nums[mid] {  // left half sorted
        if nums[low] <= target && target < nums[mid] {
          high = mid - 1  // Target in left half.
        } else {
          low = mid + 1  // Search right half.
        }
      } else {  // right half sorted
        if nums[mid] < target && target <= nums[high] {
          low = mid + 1  // Target in right half.
        } else {
          high = mid - 1  // Search left half.
        }
      }
    }
    return -1
  }
}
```

## Quick Tests

```swift
assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 0) == 4)
assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 3) == -1)
assert(Solution().search([1], 0) == -1)
```

## Interview Framing

- Emphasize invariants: exactly one half of the array is sorted each iteration.
- Mention extension for arrays with duplicates (need to shrink bounds when
  `nums[low] == nums[mid]`).
- Discuss alternative approach: binary search on pivot + regular binary search.
- When it shows up: rotated arrays model feature-flagged rollouts, partial migrations, or
  clock-skewed data streams where a monotone sequence is broken once; this pattern still yields
  O(log n) search.
