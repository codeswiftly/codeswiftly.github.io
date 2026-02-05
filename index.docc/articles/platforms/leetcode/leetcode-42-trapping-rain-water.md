# LeetCode 42: Trapping Rain Water




Given non-negative heights representing bars, compute total water trapped after raining.


Solve Hard problem.

![A diagram illustrating the 'trapping rain water' problem. The bars are grey and the trapped water is
blue.](trapping-rain-water.svg)

## Core Ideas

- Two-pointer approach tracking `leftMax`/`rightMax`.
- Alternative: monotonic stack of indices.

## Constraints and Complexity

- `n <= 2 * 10^4`.
- Time `O(n)`, space `O(1)` for two-pointer.

## Edge Cases

- Short arrays (<3) trap zero.
- Plateaus; equal heights.

## Swift Starter

```swift
class Solution {
  func trap(_ height: [Int]) -> Int {
    // TODO: Two pointers tracking leftMax/rightMax.
    return 0
  }
}
```

## Swift Solution (Commented, Two-pointer)

```swift
class Solution {
  func trap(_ height: [Int]) -> Int {
    var left = 0
    var right = height.count - 1
    var leftMax = 0
    var rightMax = 0
    var trapped = 0

    while left < right {
      if height[left] < height[right] {
        leftMax = max(leftMax, height[left])
        trapped += max(0, leftMax - height[left])  // Water above left.
        left += 1
      } else {
        rightMax = max(rightMax, height[right])
        trapped += max(0, rightMax - height[right])  // Water above right.
        right -= 1
      }
    }
    return trapped
  }
}
```

## Interview Framing

- Mention memory tradeoffs (prefix/suffix arrays).
- Tie back to histogram problems / dynamic programming.
