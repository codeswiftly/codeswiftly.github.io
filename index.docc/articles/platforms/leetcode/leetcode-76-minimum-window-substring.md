# LeetCode 76: Minimum Window Substring




Find the smallest substring of `s` that contains all characters of `t` (including duplicates).


Solve Hard problem.

Find the smallest substring of `s` that contains all characters of `t` (including duplicates).

## Core Ideas

- Sliding window with counts for required characters.
- Expand to satisfy requirements, then shrink to minimize.

## Constraints and Complexity

- `s.length, t.length <= 10^5`.
- Time `O(n)`, space `O(1)` for fixed alphabet counts.

## Edge Cases

- `t` longer than `s`.
- Duplicate characters in `t`.
- No valid window.

## Swift Starter

```swift
class Solution {
  func minWindow(_ s: String, _ t: String) -> String {
    // TODO: Sliding window with counts.
    return ""
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func minWindow(_ s: String, _ t: String) -> String {
    let sChars = Array(s)
    let tChars = Array(t)
    if sChars.isEmpty || tChars.isEmpty { return "" }

    var need = [Int](repeating: 0, count: 128)
    var required = 0
    for ch in tChars {
      let idx = Int(ch.unicodeScalars.first!.value)
      if need[idx] == 0 { required += 1 }
      need[idx] += 1
    }

    var window = [Int](repeating: 0, count: 128)
    var formed = 0
    var left = 0
    var bestLen = Int.max
    var bestLeft = 0
    var bestRight = 0

    for right in 0..<sChars.count {
      let rIdx = Int(sChars[right].unicodeScalars.first!.value)
      window[rIdx] += 1
      if need[rIdx] > 0, window[rIdx] == need[rIdx] { formed += 1 }

      while left <= right, formed == required {
        let windowLen = right - left + 1
        if windowLen < bestLen {
          bestLen = windowLen
          bestLeft = left
          bestRight = right
        }
        let lIdx = Int(sChars[left].unicodeScalars.first!.value)
        window[lIdx] -= 1
        if need[lIdx] > 0, window[lIdx] < need[lIdx] { formed -= 1 }
        left += 1
      }
    }

    guard bestLen != Int.max else { return "" }
    return String(sChars[bestLeft...bestRight])
  }
}
```

## Interview Framing

- Explain why shrinking only when the window is valid is safe.
- Mention Unicode vs. ASCII tradeoffs; dictionaries support full Unicode.
