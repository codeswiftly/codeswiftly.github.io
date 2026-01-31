
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-roman-to-integer-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-roman-to-integer-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-roman-to-integer-icon.codex", alt: "Placeholder icon")
# LeetCode - Roman to Integer (Apple-Style)

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-roman-to-integer-dsa-icon.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")
  @PageImage(purpose: card, source: "leetcode-roman-to-integer-dsa-card.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")
}

@Image(source: "leetcode-roman-to-integer-dsa-hero.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")

Given a Roman numeral `s`, return its integer value. Symbols: I(1), V(5), X(10), L(50), C(100), D(500), M(1000). Subtractive pairs occur when a smaller symbol precedes a larger one (IV, IX, XL, XC, CD, CM).

@Image(source: "leetcode-roman-to-integer-dsa-top.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")

Solve Easy problem.

Given a Roman numeral `s`, return its integer value. Symbols: I(1), V(5), X(10), L(50), C(100),
D(500), M(1000). Subtractive pairs occur when a smaller symbol precedes a larger one (IV, IX, XL,
XC, CD, CM).

## Core Ideas

- Traverse from right to left; keep `lastValue` (value of last processed symbol).
- If `current < lastValue` → subtract; else add.
- Mapping is a simple `switch` on `Character`.

## Swift Starter

```swift
class Solution {
  func romanToInt(_ s: String) -> Int {
    // TODO: Walk right-to-left and add/subtract based on last value.
    return 0
  }
}
```

## Swift Solution (Commented, Right-to-left)

```swift
class Solution {
  func romanToInt(_ s: String) -> Int {
    var total = 0
    var lastValue = 0

    for ch in s.reversed() {
      let value: Int
      switch ch {
      case "I": value = 1
      case "V": value = 5
      case "X": value = 10
      case "L": value = 50
      case "C": value = 100
      case "D": value = 500
      case "M": value = 1000
      default:
        value = 0  // For LeetCode inputs this never hits; in production, handle error.
      }

      if value < lastValue {
        total -= value  // Subtractive pair.
      } else {
        total += value  // Additive step.
      }

      lastValue = value
    }

    return total
  }
}
```

## Bidirectional Converter with Validation

For panel interviews you are often asked to convert both ways and guard against malformed
numerals. The snippet below keeps a canonical `(value, symbol)` table for greedy conversion, plus
rules that reject more than three repeats, illegal subtractive pairs, or descending order breaks.

```swift
struct RomanNumeralConverter {
  private static let table: [(value: Int, symbol: String)] = [
    (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
    (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
    (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I"),
  ]

  func intToRoman(_ number: Int) -> String {
    precondition(1...3999 ~= number, "Only standard Roman range supported")
    var n = number
    var result = ""

    for entry in Self.table where n > 0 {
      while n >= entry.value {
        n -= entry.value
        result.append(contentsOf: entry.symbol)
      }
    }
    return result
  }

  func romanToInt(_ s: String) throws -> Int {
    var total = 0
    var lastValue = 0
    var repeatCount = 0
    var prevChar: Character?

    for ch in s.reversed() {
      guard let value = value(of: ch) else {
        throw ConversionError.invalidSymbol(ch)
      }

      if let prev = prevChar, prev == ch {
        repeatCount += 1
        if repeatCount == 3 && value != 1000 {
          throw ConversionError.tooManyRepeats(ch)
        }
      } else {
        repeatCount = 0
      }

      if value < lastValue {
        guard isValidSubtractivePair(lhs: value, rhs: lastValue) else {
          throw ConversionError.invalidOrder(lhs: value, rhs: lastValue)
        }
        total -= value
      } else {
        total += value
        lastValue = value
      }

      prevChar = ch
    }
    return total
  }

  private func value(of ch: Character) -> Int? {
    switch ch {
    case "I": return 1
    case "V": return 5
    case "X": return 10
    case "L": return 50
    case "C": return 100
    case "D": return 500
    case "M": return 1000
    default: return nil
    }
  }

  private func isValidSubtractivePair(lhs: Int, rhs: Int) -> Bool {
    switch (lhs, rhs) {
    case (1, 5), (1, 10), (10, 50), (10, 100), (100, 500), (100, 1000): return true
    default: return false
    }
  }

  enum ConversionError: Error {
    case invalidSymbol(Character)
    case invalidOrder(lhs: Int, rhs: Int)
    case tooManyRepeats(Character)
  }
}
```

- **Extension prompts:** Apple likes to ask how you would support values ≥ 4000 (answer: prepend an
  overline marker or continue emitting `M` and describe tradeoffs) or how you would surface errors
  to the UI (throw, return optional, or expose a `Result`).
- Keep the validation talk-track handy: “I cap repeats at three, only allow I/X/C to subtract, and
  reject out-of-order jumps.”

## Alternative (Left-to-right with Lookahead)

- Peek the next character’s value; if `current < next`, subtract `current`, else add.
- Requires safe `String.Index` handling in Swift.

## Quick Tests

```swift
assert(Solution().romanToInt("III") == 3)
assert(Solution().romanToInt("IV") == 4)
assert(Solution().romanToInt("VI") == 6)
assert(Solution().romanToInt("LVIII") == 58)
assert(Solution().romanToInt("MCMXCIV") == 1994)
```

## Interview Notes

- Explain why right-to-left is simpler (no lookahead indexing).
- Mention complexity: O(n) time, O(1) extra space.
- Mention validation knobs (allowed subtractive pairs, maximum repeats) and how you would extend
  the range past 3999.

## Interview Framing

Questions to expect:

- What invariant or state do you maintain?
- What is the time and space complexity?
- Which edge cases would you test first?
- How would you optimize for larger inputs?
- What alternative approach would you mention and why?
