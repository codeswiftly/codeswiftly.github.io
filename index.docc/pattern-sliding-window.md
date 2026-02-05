# Pattern 03: Sliding Window

@Image(source: "pattern-sliding-window-hero.codex", alt: "Placeholder hero")

@Metadata {
  @TitleHeading("Practice Sliding Window")
  @PageImage(purpose: icon, source: "pattern-sliding-window-icon.codex", alt: "Pattern 03: Sliding Window icon")
  @PageImage(purpose: card, source: "pattern-sliding-window-card.codex", alt: "Pattern 03: Sliding Window card")
}

@Image(source: "sliding-window-diagram.codex", alt: "Sliding window expanding and shrinking")

Maintain a dynamic range (window) over an array or string to find the longest, shortest, or optimal subarray satisfying a condition.

## Problem

- Longest or shortest subarray that satisfies a constraint.

## Solution

- Expand the window, then shrink until the invariant holds.

## Concept

Instead of recomputing data for every subarray (O(N^2)), use a "window" defined by `start` and `end` indices.

- **Expand**: Increase `end` to include new elements.
- **Shrink**: Increase `start` to exclude elements when the window violates a condition (e.g., sum > target, duplicate found).

## Complexity

- **Time**: O(N). The `start` and `end` pointers each move at most N steps.
- **Space**: O(1) or O(K) where K is the size of the character set or window state map.

## When to Use

- **Contiguous Subarrays**: Finding longest/shortest substring, subarray with sum `s`, or max sum subarray of size `k`.
- **String Anagrams/Permutations**: Checking if a permutation of string A exists in string B.

## Examples

### 1. Longest Substring Without Repeating Characters

Find the length of the longest substring with unique characters.

@Image(source: "sliding-window-longest-unique.codex", alt: "Sliding window for longest unique substring")

```swift
func lengthOfLongestSubstring(_ s: String) -> Int {
  var charIndexMap = [Character: Int]()
  var maxLength = 0
  var start = 0
  let chars = Array(s)

  for (end, char) in chars.enumerated() {
    // If we have seen this char, and it's inside the current window, move start
    if let lastSeen = charIndexMap[char], lastSeen >= start {
      start = lastSeen + 1
    }

    charIndexMap[char] = end
    maxLength = max(maxLength, end - start + 1)
  }
  return maxLength
}
```

### 2. Minimum Size Subarray Sum

Find the minimal length of a contiguous subarray of which the sum is greater than or equal to `target`.

@Image(source: "sliding-window-min-subarray-sum.codex", alt: "Sliding window shrinking to minimum subarray sum")

```swift
func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
  var minLength = Int.max
  var currentSum = 0
  var start = 0

  for end in 0..<nums.count {
    currentSum += nums[end]

    // Shrink the window as small as possible while condition holds
    while currentSum >= target {
      minLength = min(minLength, end - start + 1)
      currentSum -= nums[start]
      start += 1
    }
  }

  return minLength == Int.max ? 0 : minLength
}
```

## Common Pitfalls

- **Shrink Condition**: Ensure the `while` loop condition correctly identifies when the window is valid/invalid.
- **Initialization**: Initialize `minLength` to `Int.max` (or infinity equivalent) and handle the "not found" case (return 0).

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-3-longest-substring-no-repeat>
- <doc:leetcode-121-best-time-stock>
- <doc:leetcode-122-best-time-to-buy-and-sell-stock-ii>
}

## See Also

- <doc:top-15-patterns>
