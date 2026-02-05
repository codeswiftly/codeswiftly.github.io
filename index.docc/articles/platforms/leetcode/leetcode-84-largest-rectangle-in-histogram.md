# LeetCode 84: Largest Rectangle in Histogram

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-84-largest-rectangle-in-histogram-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-84-largest-rectangle-in-histogram-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-84-largest-rectangle-in-histogram-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-84-largest-rectangle-in-histogram-dsa-icon.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")
  @PageImage(purpose: card, source: "leetcode-84-largest-rectangle-in-histogram-dsa-card.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")
}

@Image(source: "leetcode-84-largest-rectangle-in-histogram-dsa-hero.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")

Find the area of the largest rectangle in a histogram.

@Image(source: "leetcode-84-largest-rectangle-in-histogram-dsa-top.codex", alt: "Hard problem - Pattern 8 (Monotonic Stack)")

Solve Hard problem.

Find the area of the largest rectangle in a histogram.

## Core Ideas

- Monotonic increasing stack of indices.
- When a bar drops, compute areas with bars as the smallest height.

## Constraints and Complexity

- `n <= 10^5`.
- Time `O(n)`, space `O(n)`.

## Edge Cases

- Single bar.
- All bars equal.

## Swift Starter

```swift
class Solution {
  func largestRectangleArea(_ heights: [Int]) -> Int {
    // TODO: Monotonic stack of indices.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func largestRectangleArea(_ heights: [Int]) -> Int {
    var stack: [Int] = []
    var maxArea = 0
    let extended = heights + [0]

    for i in 0..<extended.count {
      while let last = stack.last, extended[i] < extended[last] {
        let height = extended[stack.removeLast()]
        let leftIndex = stack.last ?? -1
        let width = i - leftIndex - 1
        maxArea = max(maxArea, height * width)
      }
      stack.append(i)
    }

    return maxArea
  }
}
```

## Interview Framing

- Each index is pushed and popped once, so total work is linear.
- The sentinel `0` flushes the stack at the end.
