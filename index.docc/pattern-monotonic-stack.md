# Pattern 08: Monotonic Stack


@Metadata {
  @TitleHeading("Practice Monotonic Stack")
}


Maintain a stack where elements are always sorted (increasing or decreasing) to efficiently find the "next greater" or "next smaller" element.

## Problem

- Find next greater/smaller elements or range spans efficiently.

## Solution

- Keep a monotone stack and pop while the invariant breaks.

## Concept

- **Monotonic Decreasing Stack**: Used to find the **next greater** element. When a new value `x` comes in, pop all elements `<=` `x`. For every popped element, `x` is the next greater. Push `x`.
- **Monotonic Increasing Stack**: Used to find the **next smaller** element.

## Complexity

- **Time**: O(N). Each element is pushed onto the stack once and popped at most once.
- **Space**: O(N) in the worst case (e.g., sorted input).

## When to Use

- **Next Greater/Smaller Element**: Finding the first element to the right that satisfies a condition.
- **Range Calculations**: Daily temperatures, stock spans.
- **Histogram Areas**: Largest rectangle in histogram (finding boundaries where height drops).

## Examples

### 1. Next Greater Element

For each element, find the next greater element in the array. If none, output -1.

```swift
func nextGreaterElements(_ nums: [Int]) -> [Int] {
  var result = Array(repeating: -1, count: nums.count)
  var stack = [Int]()  // Stores indices

  for (i, num) in nums.enumerated() {
    while let top = stack.last, nums[top] < num {
      result[top] = num
      stack.removeLast()
    }
    stack.append(i)
  }
  return result
}
```

### 2. Daily Temperatures

Number of days you have to wait for a warmer temperature.

```swift
func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
  var answer = Array(repeating: 0, count: temperatures.count)
  var stack = [Int]()  // Indices

  for (currDay, currTemp) in temperatures.enumerated() {
    while let prevDay = stack.last, temperatures[prevDay] < currTemp {
      answer[prevDay] = currDay - prevDay
      stack.removeLast()
    }
    stack.append(currDay)
  }

  return answer
}
```

## Common Pitfalls

- **Stack Contents**: Decide whether to store values or indices. Indices are usually more flexible (you can look up values and calculate distances).
- **Remaining Elements**: Elements left in the stack at the end have no "next greater" element (result is usually -1 or 0).

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-901-online-stock-span>
- <doc:leetcode-42-trapping-rain-water>
- <doc:leetcode-2034-stock-price-fluctuation>
}

## See Also

- <doc:top-15-patterns>
