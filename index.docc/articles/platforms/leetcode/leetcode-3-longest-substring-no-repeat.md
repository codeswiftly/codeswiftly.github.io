# LeetCode 3: Longest Substring Without Repeating Characters




Given a string, find the length of the longest substring with all unique characters.


Solve Medium problem.

## Core Ideas

- Sliding window with dictionary mapping char → last index.

## Constraints and Complexity

- `n <= 5 * 10^4`.
- Time `O(n)`, space `O(min(n, alphabet))`.

## Edge Cases

- Empty string → 0.
- All same char -> 1.

## Swift Starter

```swift
class Solution {
  func lengthOfLongestSubstring(_ s: String) -> Int {
    // TODO: Sliding window with last-seen indices.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func lengthOfLongestSubstring(_ s: String) -> Int {
    var lastSeen: [Character: Int] = [:]
    let chars = Array(s)
    var start = 0
    var best = 0
    for (index, ch) in chars.enumerated() {
      if let prev = lastSeen[ch], prev >= start {
        start = prev + 1  // Move window start past the repeat.
      }
      lastSeen[ch] = index  // Update last seen index.
      best = max(best, index - start + 1)  // Track max window length.
    }
    return best
  }
}
```

## Interview Framing

- Mention alternative using `UnicodeScalar` iteration to avoid array copy.
- Extend to return substring itself or count distinct windows.
