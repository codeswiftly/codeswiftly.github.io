# LeetCode 8: String to Integer (Atoi)

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-8-string-to-integer-atoi-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-8-string-to-integer-atoi-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-8-string-to-integer-atoi-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-8-string-to-integer-atoi-dsa-icon.codex", alt: "Medium problem - Pattern 2 (Two Pointers)")
  @PageImage(purpose: card, source: "leetcode-8-string-to-integer-atoi-dsa-card.codex", alt: "Medium problem - Pattern 2 (Two Pointers)")
}

@Image(source: "leetcode-8-string-to-integer-atoi-dsa-hero.codex", alt: "Medium problem - Pattern 2 (Two Pointers)")

Convert a string to a 32-bit signed integer with these rules: skip leading spaces, read an optional sign, consume consecutive digits (skipping leading zeros is fine), stop at the first non-digit, and clamp the result...

@Image(source: "leetcode-8-string-to-integer-atoi-dsa-top.codex", alt: "Medium problem - Pattern 2 (Two Pointers)")

Solve Medium problem.

Convert a string to a 32-bit signed integer with these rules: skip leading spaces, read an
optional sign, consume consecutive digits (skipping leading zeros is fine), stop at the first
non-digit, and clamp the result into `[-2147483648, 2147483647]`. Return `0` if no digits are read.

## Core Ideas

- Walk left-to-right with an index: skip whitespace, then take a leading `+` or `-` if present.
- Consume digit run; leading zeros naturally collapse while multiplying by 10.
- Clamp while reading, using separate thresholds for positive and negative to avoid overflow.
- Stop when the next character is non-numeric or the string ends.

## Constraints and Complexity

- `0 <= s.count <= 200`.
- Time: `O(n)`. Space: `O(1)` (array copy is `O(n)`; use indices directly to stay `O(1)`).

## Edge Cases

- Only whitespace or only a sign → `0`.
- Leading zeros followed by digits → keep digits after the zeros.
- Trailing junk after digits → ignore it.
- Values beyond 32-bit bounds → clamp to `Int32.max` / `Int32.min`.

## Swift Notes

- `Character.wholeNumberValue` returns `nil` for non-digits, which cleanly stops parsing.
- Use `Int` accumulation with guardrails: `Int32.max` is `2147483647` and the magnitude of
  `Int32.min` is `2147483648`.
- Clamp before multiplying by 10 to prevent overflow.

## Swift Starter

```swift
class Solution {
  func myAtoi(_ s: String) -> Int {
    // TODO: Trim spaces, parse sign, consume digits, clamp.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func myAtoi(_ s: String) -> Int {
    let chars = Array(s)
    var index = 0
    let end = chars.count

    while index < end && chars[index] == " " {
      index += 1  // Skip leading spaces.
    }

    var sign = 1
    if index < end {
      if chars[index] == "-" {
        sign = -1
        index += 1
      } else if chars[index] == "+" {
        index += 1
      }
    }

    var value = 0
    let maxPositive = Int(Int32.max)  // 2147483647
    let maxNegativeMagnitude = 2_147_483_648  // abs(Int32.min)
    let posDiv = maxPositive / 10  // 214748364
    let posMod = maxPositive % 10  // 7
    let negDiv = maxNegativeMagnitude / 10  // 214748364
    let negMod = maxNegativeMagnitude % 10  // 8

    while index < end, let digit = chars[index].wholeNumberValue {
      if sign == 1 {
        if value > posDiv || (value == posDiv && digit > posMod) {
          return maxPositive  // Clamp overflow.
        }
      } else {
        if value > negDiv || (value == negDiv && digit > negMod) {
          return Int(Int32.min)  // Clamp underflow.
        }
      }

      value = value * 10 + digit
      index += 1
    }

    return sign == 1 ? value : -value
  }
}
```

## Quick Tests

```swift
assert(Solution().myAtoi("42") == 42)
assert(Solution().myAtoi("   -042") == -42)
assert(Solution().myAtoi("1337c0d3") == 1337)
assert(Solution().myAtoi("0-1") == 0)
assert(Solution().myAtoi("words and 987") == 0)
assert(Solution().myAtoi("-91283472332") == -2_147_483_648)
assert(Solution().myAtoi("91283472332") == 2_147_483_647)
```

## Interview Framing

- Call out the in-loop clamping to avoid overflow.
- Mention the Unicode digit handling via `wholeNumberValue`; LeetCode inputs are ASCII, but the
  check is robust.
- Describe how you would avoid the array copy in production (walk `String.Index` directly).
