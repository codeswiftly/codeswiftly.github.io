# LeetCode 29: Divide Two Integers

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-29-divide-two-integers-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-29-divide-two-integers-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-29-divide-two-integers-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-29-divide-two-integers-dsa-icon.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")
  @PageImage(purpose: card, source: "leetcode-29-divide-two-integers-dsa-card.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")
}

@Image(source: "leetcode-29-divide-two-integers-dsa-hero.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")

Divide two 32-bit signed integers without using multiplication, division, or mod. Truncate toward zero. If the result overflows 32-bit (`> Int32.max` or `< Int32.min`), clamp to `Int32.max`.

@Image(source: "leetcode-29-divide-two-integers-dsa-top.codex", alt: "Medium problem - Pattern 5 (Modified Binary Search)")

Solve Medium problem.

Divide two 32-bit signed integers without using multiplication, division, or mod. Truncate toward
zero. If the result overflows 32-bit (`> Int32.max` or `< Int32.min`), clamp to `Int32.max`.

## Core Ideas

- Work in negative space to avoid overflow (`Int32.min` has no positive counterpart).
- Use bit-shift doubling (exponential search) to subtract large chunks instead of `O(q)` loops.
- Track the sign separately; apply at the end with overflow clamp.

## Constraints and Complexity

- Inputs fit in 32-bit signed range.
- Time: `O(log n)` where `n` is the absolute dividend (doubling each step).
- Space: `O(1)`.

## Edge Cases

- `divisor == 0` → undefined; LeetCode won’t pass zero divisor.
- `dividend == Int32.min && divisor == -1` → overflow; must return `Int32.max` (2147483647).
- `dividend == 0` → 0.
- Equal magnitudes → ±1 depending on sign.

## Swift Notes

- Use `Int32.max`/`Int32.min` bounds; compute using `Int` to keep headroom but clamp to 32-bit.
- Convert both operands to negative to safely handle `Int32.min` (its abs overflows).

## Swift Starter

```swift
class Solution {
  func divide(_ dividend: Int, _ divisor: Int) -> Int {
    // TODO: Use doubling in negative space and clamp overflow.
    return 0
  }
}
```

## Swift Solution (Commented, Bit Shifts, Negative Space)

```swift
class Solution {
  func divide(_ dividend: Int, _ divisor: Int) -> Int {
    let int32Max = Int(Int32.max)  //  2147483647
    let int32Min = Int(Int32.min)  // -2147483648

    if dividend == int32Min && divisor == -1 {
      return int32Max  // Only overflow case.
    }

    // Sign of the result
    let positive = (dividend < 0) == (divisor < 0)  // Same sign -> positive.

    // Work with negatives to avoid overflow on Int32.min
    var a = dividend < 0 ? dividend : -dividend
    let b = divisor < 0 ? divisor : -divisor

    var quotient = 0

    while a <= b {  // Both negative; more negative means larger magnitude.
      var value = b
      var multiple = 1

      // Double value while it fits; avoid overflow by checking value >= int32Min - value
      while value >= int32Min - value && a <= value + value {
        value += value
        multiple += multiple
      }

      a -= value  // Consume the largest chunk.
      quotient += multiple
    }

    return positive ? quotient : -quotient
  }
}
```

## Interview Framing

- Explain why you stay in negative space: `abs(Int32.min)` overflows; negatives are safe to double.
- The doubling loop makes it `O(log n)` vs. repeated subtraction `O(n)`.
- Clamp the specific overflow case `Int32.min / -1` to `Int32.max` per problem statement.***
