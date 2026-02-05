# LeetCode 20: Valid Parentheses




Given a string containing parentheses/braces/brackets, determine if the string is valid: closes match opens in correct order and types.


Solve Easy problem.

Given a string containing parentheses/braces/brackets, determine if the string is valid: closes
match opens in correct order and types.

## Core Ideas

- Stack of expected closing characters.

## Constraints and Complexity

- `n <= 10^4`.
- Time `O(n)`, space `O(n)` worst-case stack.

## Edge Cases

- Starts with closing char.
- Odd length implies invalid.

## Swift Starter

```swift
class Solution {
  func isValid(_ s: String) -> Bool {
    // TODO: Stack of opens and match closings.
    return false
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func isValid(_ s: String) -> Bool {
    var stack: [Character] = []
    let pairs: [Character: Character] = [")": "(", "]": "[", "}": "{"]
    for ch in s {
      if pairs.values.contains(ch) {
        stack.append(ch)  // Push open.
      } else if let needed = pairs[ch] {
        guard stack.popLast() == needed else { return false }  // Match close.
      }
    }
    return stack.isEmpty
  }
}
```

## Interview Framing

- Mention faster membership by using `Set` for opens.
- Discuss extension for HTML tags or custom token sets.

## Visualization

### Valid Case: `"{[]}"`


### Invalid Case: `"{[)]}"`

