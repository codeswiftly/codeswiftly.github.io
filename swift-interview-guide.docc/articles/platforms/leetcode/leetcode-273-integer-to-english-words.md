
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-273-integer-to-english-words-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-273-integer-to-english-words-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-273-integer-to-english-words-icon.codex", alt: "Placeholder icon")
# LeetCode 273: Integer to English Words

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-273-integer-to-english-words-dsa-icon.codex", alt: "Hard problem - Pattern 2 (Two Pointers)")
  @PageImage(purpose: card, source: "leetcode-273-integer-to-english-words-dsa-card.codex", alt: "Hard problem - Pattern 2 (Two Pointers)")
}

@Image(source: "leetcode-273-integer-to-english-words-dsa-hero.codex", alt: "Hard problem - Pattern 2 (Two Pointers)")

Convert a non-negative integer `num <= 2^31 - 1` to its English words representation.

@Image(source: "leetcode-273-integer-to-english-words-dsa-top.codex", alt: "Hard problem - Pattern 2 (Two Pointers)")

Solve Hard problem.

## Core Ideas

- Break number into groups of three digits (billions, millions, thousands, hundreds).
- Helper to convert 0–999 into words using predefined arrays for <20 and tens.

## Constraints and Complexity

- `0 <= num <= 2_147_483_647`.
- Time `O(log10 n)`; constant due to limited groups.
- Space `O(1)` not counting output.

## Edge Cases

- `0` → "Zero".
- Trailing zeros in groups -> skip.

## Swift Starter

```swift
class Solution {
  func numberToWords(_ num: Int) -> String {
    // TODO: Convert in 3-digit chunks with helper.
    return ""
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  private let below20 = [
    "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven",
    "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen",
  ]
  private let tens = [
    "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety",
  ]
  private let thousands = ["", "Thousand", "Million", "Billion"]

  func numberToWords(_ num: Int) -> String {
    guard num != 0 else { return "Zero" }
    var num = num
    var group = 0
    var parts: [String] = []
    while num > 0 {
      let chunk = num % 1000
      if chunk != 0 {
        let chunkWords = helper(chunk).trimmingCharacters(in: .whitespaces)
        let suffix = thousands[group]
        parts.append([chunkWords, suffix].filter { !$0.isEmpty }.joined(separator: " "))
      }
      group += 1
      num /= 1000
    }
    return parts.reversed().joined(separator: " ")
  }

  private func helper(_ num: Int) -> String {
    switch num {
    case 0..<20:
      return below20[num] + " "
    case 20..<100:
      return tens[num / 10] + " " + helper(num % 10)
    default:
      return below20[num / 100] + " Hundred " + helper(num % 100)
    }
  }
}
```

## Interview Framing

- Note immutability of arrays; constant-time lookups.
- Mention localization/grammar complexities in production (pluralization, hyphens).
