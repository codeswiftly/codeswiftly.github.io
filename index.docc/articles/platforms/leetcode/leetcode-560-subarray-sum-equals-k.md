# LeetCode 560: Subarray Sum Equals K

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-560-subarray-sum-equals-k-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-560-subarray-sum-equals-k-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-560-subarray-sum-equals-k-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-560-subarray-sum-equals-k-dsa-icon.codex", alt: "Medium problem - Pattern 1 (Prefix Sum)")
  @PageImage(purpose: card, source: "leetcode-560-subarray-sum-equals-k-dsa-card.codex", alt: "Medium problem - Pattern 1 (Prefix Sum)")
}

@Image(source: "leetcode-560-subarray-sum-equals-k-dsa-hero.codex", alt: "Medium problem - Pattern 1 (Prefix Sum)")

Given an integer array `nums` and integer `k`, return the number of contiguous subarrays whose sum equals `k`.

@Image(source: "leetcode-560-subarray-sum-equals-k-dsa-top.codex", alt: "Medium problem - Pattern 1 (Prefix Sum)")

Solve Medium problem.

Given an integer array `nums` and integer `k`, return the number of contiguous subarrays whose sum
equals `k`.

## Core Ideas

- Prefix sums combined with a hash map of frequency counts.
- For each running sum `prefix`, count how many times `prefix - k` has been seen.

## Constraints and Complexity

- `1 <= nums.count <= 2 * 10^4`, `-10^4 <= nums[i] <= 10^4`.
- Time: `O(n)` single pass.
- Space: `O(n)` worst-case hash map entries.

## Edge Cases

- Negative numbers require prefix approach (no sliding window).
- `k == 0`, array containing zeros.
- Large arrays of zeros -> counts grow quadratically.

## Swift Notes

- Use `[Int: Int]` dictionary; initialize with `[0: 1]` to count subarrays starting at index 0.
- Avoid `default` lookups twice; store in temp.

## Swift Starter

```swift
class Solution {
  func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    // TODO: Prefix sum + hash map of counts.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var counts: [Int: Int] = [0: 1]
    var prefix = 0
    var total = 0
    for value in nums {
      prefix += value
      if let seen = counts[prefix - k] {
        total += seen  // Count subarrays ending here with sum k.
      }
      counts[prefix, default: 0] += 1  // Record this prefix sum.
    }
    return total
  }
}
```

## Quick Tests

```swift
assert(Solution().subarraySum([1, 1, 1], 2) == 2)
assert(Solution().subarraySum([1, 2, 3], 3) == 2)
```

## Interview Framing

- Emphasize why sliding window fails with negatives.
- Mention dictionary growth; for streaming data use LRU or chunked processing.
