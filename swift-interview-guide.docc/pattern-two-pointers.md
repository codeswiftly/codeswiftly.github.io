
@Image(source: "pattern-two-pointers-hero.codex", alt: "Placeholder hero")
# Pattern 02: Two Pointers

@Metadata {
  @TitleHeading("Practice Two Pointers")
  @PageImage(purpose: icon, source: "pattern-two-pointers-icon.codex", alt: "Pattern 02: Two Pointers icon")
  @PageImage(purpose: card, source: "pattern-two-pointers-card.codex", alt: "Pattern 02: Two Pointers card")
}

@Image(source: "two-pointers-diagram.codex", alt: "Two pointers converging logic")

Use paired indices to traverse arrays or strings to perform comparisons, swaps, or searches in O(N) time and O(1) space.

## Problem

- In-place scans over sorted or symmetric data.

## Solution

- Move left and right pointers with explicit movement rules.

## Concept

Two pointers allows you to process a linear structure by maintaining two references:

- **Converging**: One starts at the beginning (`left`), one at the end (`right`). Useful for sorted arrays (Two Sum) or palindrome checks.
- **Parallel**: Both start at the beginning, but move at different speeds (see <doc:pattern-fast-slow-pointers>) or with a fixed gap.

## Complexity

- **Time**: O(N) because each element is visited at most once by each pointer.
- **Space**: O(1) as it only requires two integer variables.

## When to Use

- **Sorted Arrays**: Searching for pairs that satisfy a condition (e.g., sum to target).
- **In-Place Operations**: Removing duplicates, moving zeroes to the end, or reversing arrays.
- **Palindromes**: Checking symmetry from outside in.

## Examples

### 1. Palindrome Check

Validate a string is a palindrome by comparing characters from the outside moving inward.

@Image(source: "two-pointers-palindrome-hero.codex", alt: "Palindrome check with two pointers")

```swift
func isPalindrome(_ text: String) -> Bool {
  // Convert to an array for O(1) random access
  let chars = Array(text)
  var left = 0
  var right = chars.count - 1

  while left < right {
    if chars[left] != chars[right] { return false }
    left += 1
    right -= 1
  }
  return true
}
```

### 2. Two Sum II - Input Array Is Sorted

Find two numbers that add up to a specific target number in a sorted array.

@Image(source: "two-pointers-two-sum-visual.codex", alt: "Two pointers converging on a target sum")

```swift
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
  var left = 0
  var right = numbers.count - 1

  while left < right {
    let sum = numbers[left] + numbers[right]
    if sum == target {
      // Return 1-based indices as per some problem specs
      return [left + 1, right + 1]
    } else if sum < target {
      left += 1  // Need a larger sum
    } else {
      right -= 1  // Need a smaller sum
    }
  }
  return []
}
```

## Common Pitfalls

- **Off-by-one errors**: Ensure `while left < right` vs `while left <= right` matches the logic (e.g., do you need to process the middle element?).
- **Infinite loops**: Ensure at least one pointer moves in every iteration.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-26-remove-duplicates-from-sorted-array>
- <doc:leetcode-14-longest-common-prefix>
- <doc:leetcode-121-best-time-stock>
}

## See Also

- <doc:top-15-patterns>
