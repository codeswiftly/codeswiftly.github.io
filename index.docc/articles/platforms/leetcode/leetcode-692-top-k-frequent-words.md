# LeetCode 692: Top K Frequent Words

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-692-top-k-frequent-words-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-692-top-k-frequent-words-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-692-top-k-frequent-words-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-692-top-k-frequent-words-dsa-icon.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")
  @PageImage(purpose: card, source: "leetcode-692-top-k-frequent-words-dsa-card.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")
}

@Image(source: "leetcode-692-top-k-frequent-words-dsa-hero.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")

Given an array of strings and integer `k`, return the `k` most frequent words sorted by frequency and lexicographical order (higher frequency first; ties broken by smaller lexicographic value).

@Image(source: "leetcode-692-top-k-frequent-words-dsa-top.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")

Solve Medium problem.

Given an array of strings and integer `k`, return the `k` most frequent words sorted by frequency
and lexicographical order (higher frequency first; ties broken by smaller lexicographic value).

## Core Ideas

- Frequency dictionary + min-heap of size `k` OR sort the frequency array.
- For `n <= 10^5`, sorting frequencies is acceptable.

## Constraints and Complexity

- Counting: `O(n)`.
- Sorting: `O(m log m)` where `m` is number of unique words.

## Edge Cases

- Words with identical counts.
- `k == uniqueWords`.

## Swift Starter

```swift
class Solution {
  func topKFrequent(_ words: [String], _ k: Int) -> [String] {
    // TODO: Count and sort by frequency, then lexicographic.
    return []
  }
}
```

## Swift Solution (Commented, Sort)

```swift
class Solution {
  func topKFrequent(_ words: [String], _ k: Int) -> [String] {
    var freq: [String: Int] = [:]
    for word in words {
      freq[word, default: 0] += 1  // Count words.
    }
    return freq.sorted {
      if $0.value == $1.value {
        return $0.key < $1.key  // Tie-breaker: lexicographic.
      }
      return $0.value > $1.value
    }
    .prefix(k)
    .map(\.key)
  }
}
```

## Interview Framing

- Discuss heap approach for streaming data (bounded memory).
- Mention case-insensitive variants.
