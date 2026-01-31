
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-3-longest-substring-no-repeat-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-3-longest-substring-no-repeat-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-3-longest-substring-no-repeat-icon.codex", alt: "Placeholder icon")
# LeetCode 3: Longest Substring Without Repeating Characters

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-3-longest-substring-no-repeat-dsa-icon.codex", alt: "Medium problem - Pattern 3 (Sliding Window)")
  @PageImage(purpose: card, source: "leetcode-3-longest-substring-no-repeat-dsa-card.codex", alt: "Medium problem - Pattern 3 (Sliding Window)")
}

@Image(source: "leetcode-3-longest-substring-no-repeat-dsa-hero.codex", alt: "Medium problem - Pattern 3 (Sliding Window)")

Given a string, find the length of the longest substring with all unique characters.

@Image(source: "leetcode-3-longest-substring-no-repeat-dsa-top.codex", alt: "Medium problem - Pattern 3 (Sliding Window)")

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
