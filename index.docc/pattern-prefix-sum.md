# Pattern 01: Prefix Sum

@Image(source: "pattern-prefix-sum-hero.codex", alt: "Placeholder hero")

@Metadata {
  @TitleHeading("Practice Prefix Sum")
  @PageImage(purpose: icon, source: "pattern-prefix-sum-icon.codex", alt: "Pattern 01: Prefix Sum icon")
  @PageImage(purpose: card, source: "pattern-prefix-sum-card.codex", alt: "Pattern 01: Prefix Sum card")
}

@Image(source: "prefix-sum-diagram.codex", alt: "Prefix sum calculation flow")

Use prefix sums to precompute cumulative totals, enabling O(1) range queries or efficient subarray counting.

## Problem

- Repeated range-sum or subarray-sum queries on a mostly static array.

## Solution

- Precompute prefix sums and use prefix differences or a frequency map.

## Concept

The core idea is to preprocess the input array `nums` into a `prefixSums` array where `prefixSums[i]` stores the sum of all elements from index `0` to `i-1`.

- **Build**: `prefixSums[i] = prefixSums[i-1] + nums[i-1]` (1-based indexing helps avoid bounds checks).
- **Query**: The sum of the subarray from `L` to `R` is simply `prefixSums[R + 1] - prefixSums[L]`.

## Complexity

- **Time**: O(N) to build the prefix array. O(1) for each range query.
- **Space**: O(N) to store the prefix sums.

## When to Use

- **Immutable Array Range Queries**: When you have a static array and need to perform many range sum queries.
- **Subarray Sum Equals K**: Finding the number of continuous subarrays that sum to a target `k`.
- **Product Except Self**: Using prefix products (and suffix products) to compute values without division.
- **2D Range Sum**: Expanding the concept to 2D matrices for rectangular area sums.

## Examples

### 1. Range Sum Query (Immutable)

Calculate the sum of elements between indices `start` and `end` in constant time.

```swift
class NumArray {
  let prefixSums: [Int]

  init(_ nums: [Int]) {
    var sums = Array(repeating: 0, count: nums.count + 1)
    for (i, num) in nums.enumerated() {
      sums[i + 1] = sums[i] + num
    }
    self.prefixSums = sums
  }

  func sumRange(_ start: Int, _ end: Int) -> Int {
    // sum[start...end] = prefix[end + 1] - prefix[start]
    return prefixSums[end + 1] - prefixSums[start]
  }
}
```

### 2. Subarray Sum Equals K

Find the total number of continuous subarrays whose sum equals `k`.
This variation uses a hash map to store frequency of prefix sums seen so far.

```swift
func subarraySum(_ nums: [Int], _ k: Int) -> Int {
  var count = 0
  var currentSum = 0
  // Map: prefixSum -> frequency
  // Initialize with 0:1 to handle subarrays starting from index 0
  var prefixCounts = [0: 1]

  for num in nums {
    currentSum += num

    // If (currentSum - k) exists in map, it means there is a subarray
    // ending here with sum k.
    if let existing = prefixCounts[currentSum - k] {
      count += existing
    }

    prefixCounts[currentSum, default: 0] += 1
  }

  return count
}
```

## Common Pitfalls

- **Indexing**: Using 0-based prefix arrays often requires extra `if i == 0` checks. Using a size `N+1` array with `prefix[0] = 0` simplifies logic.
- **Integer Overflow**: If sums can exceed `Int.max`, consider checking constraints or using larger types if available (though standard Swift `Int` is usually 64-bit).
- **Negative Numbers**: Prefix sums are not monotonic if the array contains negative numbers, so binary search/sliding window approaches might not apply directly for finding specific sums.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-560-subarray-sum-equals-k>
- <doc:leetcode-53-maximum-subarray>
}

## See Also

- <doc:top-15-patterns>
