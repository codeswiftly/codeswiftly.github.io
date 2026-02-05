# LeetCode 53: Maximum Subarray

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-53-maximum-subarray-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-53-maximum-subarray-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-53-maximum-subarray-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-53-maximum-subarray-dsa-icon.codex", alt: "Medium problem - Pattern 15 (Dynamic Programming)")
  @PageImage(purpose: card, source: "leetcode-53-maximum-subarray-dsa-card.codex", alt: "Medium problem - Pattern 15 (Dynamic Programming)")
}

@Image(source: "leetcode-53-maximum-subarray-dsa-hero.codex", alt: "Medium problem - Pattern 15 (Dynamic Programming)")

Return the largest sum over all contiguous subarrays of `nums`.

@Image(source: "leetcode-53-maximum-subarray-dsa-top.codex", alt: "Medium problem - Pattern 15 (Dynamic Programming)")

Solve Medium problem.

## Core Ideas

- Kadane’s algorithm: running current sum vs global best.

## Constraints and Complexity

- `n <= 10^5`.
- Time `O(n)`, space `O(1)`.

## Edge Cases

- All negative numbers → pick largest (via Kadane).

## Swift Starter

```swift
class Solution {
  func maxSubArray(_ nums: [Int]) -> Int {
    // TODO: Kadane's algorithm with running sum and best.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func maxSubArray(_ nums: [Int]) -> Int {
    var best = nums[0]
    var current = nums[0]
    for value in nums.dropFirst() {
      current = max(value, current + value)  // Extend or restart.
      best = max(best, current)  // Track global best.
    }
    return best
  }
}
```

## Interview Framing

- Mention divide-and-conquer alternative.
- Discuss 2D variant for matrix maximum sum.
