
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-1207-unique-number-of-occurrences-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-1207-unique-number-of-occurrences-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-1207-unique-number-of-occurrences-icon.codex", alt: "Placeholder icon")
# LeetCode 1207: Unique Number of Occurrences

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-1207-unique-number-of-occurrences-dsa-icon.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")
  @PageImage(purpose: card, source: "leetcode-1207-unique-number-of-occurrences-dsa-card.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")
}

@Image(source: "leetcode-1207-unique-number-of-occurrences-dsa-hero.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")

Given an integer array `arr`, count the frequency of each distinct value. Return `true` if all frequencies are unique, otherwise `false`.

@Image(source: "leetcode-1207-unique-number-of-occurrences-dsa-top.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")

Solve Easy problem.

Given an integer array `arr`, count the frequency of each distinct value. Return `true` if all
frequencies are unique, otherwise `false`.

Example: `[1,2,2,1,1,3]` → counts `{1:3, 2:2, 3:1}` → frequencies `[3,2,1]` are all distinct →
`true`.

## Core Ideas

- Frequency counting with a dictionary `[Int: Int]`.
- Uniqueness check by inserting counts into a `Set`; compare sizes.

## Constraints and Complexity

- `1 <= arr.count <= 1000`, `-1000 <= arr[i] <= 1000`.
- Time: O(n) to count + O(k) to dedupe frequencies; `k` ≤ `n`.
- Space: O(k) for counts + O(k) for the set.

## Edge Cases

- Single element → `true`.
- All identical → `true`.
- Two values sharing a frequency → `false`.
- Mix of negatives/zero works naturally with dictionary keys.

## Swift Notes

- Use `counts[value, default: 0] += 1`.
- `Dictionary`/`Set` are value types; O(1) average insert/lookup.
- Mention complexity aloud in interviews.

## Swift Starter

```swift
func uniqueOccurrences(_ arr: [Int]) -> Bool {
  // TODO: Count values, then verify counts are unique.
  return false
}
```

## Swift Solution (Commented)

```swift
func uniqueOccurrences(_ arr: [Int]) -> Bool {
  var counts: [Int: Int] = [:]
  for value in arr {
    counts[value, default: 0] += 1  // Frequency count.
  }
  let frequencies = counts.values
  return Set(frequencies).count == frequencies.count
}
```

## Quick Tests

```swift
assert(uniqueOccurrences([1, 2, 2, 1, 1, 3]) == true)
assert(uniqueOccurrences([1, 2]) == false)  // both 1x
assert(uniqueOccurrences([3, 3, 3]) == true)
assert(uniqueOccurrences([-1, -1, 0, 0, 0]) == false)  // 2x and 3x overlap not unique
```

## Interview Framing

- Compare to sorting-based approach (O(n log n)); counting is O(n).
- Adaptation: for streaming data, maintain counts and a multiset of frequencies; update on insert.
- Probe angles: why Set works, what collisions mean, handling bigger ranges (still fine with dict).
