# LeetCode 2439: Minimize Maximum of Array

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-2439-minimize-maximum-array-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-2439-minimize-maximum-array-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-2439-minimize-maximum-array-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-2439-minimize-maximum-array-dsa-icon.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")
  @PageImage(purpose: card, source: "leetcode-2439-minimize-maximum-array-dsa-card.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")
}

@Image(source: "leetcode-2439-minimize-maximum-array-dsa-hero.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")

Given an array `nums`, you may perform operations that move 1 unit from index `i` to `i-1`. After any number of operations, minimize the maximum element.

@Image(source: "leetcode-2439-minimize-maximum-array-dsa-top.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")

Solve Medium problem.

Given an array `nums`, you may perform operations that move 1 unit from index `i` to `i-1`. After
any number of operations, minimize the maximum element.

## Core Ideas

- Prefix averages bound the answer: the maximum value must be at least the ceiling of any prefix
  average.
- Iterate prefixes, track `ceil(prefixSum / length)` and take the max.

## Constraints and Complexity

- `1 <= nums.count <= 10^5`, `nums[i] <= 10^9`.
- Time `O(n)`, space `O(1)`.

## Edge Cases

- Single element -> itself.
- Large numbers require `Int64` when summing.

## Swift Starter

```swift
class Solution {
  func minimizeArrayValue(_ nums: [Int]) -> Int {
    // TODO: Track prefix averages and take the max ceiling.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func minimizeArrayValue(_ nums: [Int]) -> Int {
    var prefix: Int64 = 0
    var best: Int64 = 0
    for (index, value) in nums.enumerated() {
      prefix += Int64(value)
      let length = Int64(index + 1)
      let avg = (prefix + length - 1) / length  // Ceil of prefix average.
      best = max(best, avg)  // Track the tightest lower bound.
    }
    return Int(best)
  }
}
```

## Interview Framing

- Explain why redistribution can't reduce prefix averages.
- Mention binary search on answer variant.
- Common pitfall: local “shift 1 left if next is bigger” loops can time out and fail to minimize the
  global maximum; the prefix-average bound jumps straight to the optimal answer in O(n).
