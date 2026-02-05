# LeetCode 224: Basic Calculator

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-224-basic-calculator-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-224-basic-calculator-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-224-basic-calculator-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-224-basic-calculator-dsa-icon.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")
  @PageImage(purpose: card, source: "leetcode-224-basic-calculator-dsa-card.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")
}

@Image(source: "leetcode-224-basic-calculator-dsa-hero.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")

Evaluate a string expression with `+`, `-`, parentheses, and spaces.

@Image(source: "leetcode-224-basic-calculator-dsa-top.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")

Solve Hard problem.

Evaluate a string expression with `+`, `-`, parentheses, and spaces.

## Core Ideas

- Maintain a running result and current sign.
- Use a stack to save result/sign at each `(`.

## Constraints and Complexity

- `s.length <= 3 * 10^5`.
- Time `O(n)`, space `O(n)`.

## Edge Cases

- Leading negative numbers.
- Nested parentheses.

## Swift Starter

```swift
class Solution {
  func calculate(_ s: String) -> Int {
    // TODO: Stack for result and sign.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func calculate(_ s: String) -> Int {
    var result = 0
    var sign = 1
    var number = 0
    var stack: [Int] = []

    for ch in s {
      if let digit = ch.wholeNumberValue {
        number = number * 10 + digit
      } else if ch == "+" || ch == "-" {
        result += sign * number
        number = 0
        sign = (ch == "+") ? 1 : -1
      } else if ch == "(" {
        stack.append(result)
        stack.append(sign)
        result = 0
        sign = 1
      } else if ch == ")" {
        result += sign * number
        number = 0
        let prevSign = stack.removeLast()
        let prevResult = stack.removeLast()
        result = prevResult + prevSign * result
      }
    }

    return result + sign * number
  }
}
```

## Interview Framing

- This avoids recursion and handles large input sizes.
- For `*` and `/`, switch to a two-stack parser or precedence handling.
