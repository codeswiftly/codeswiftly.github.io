# LeetCode 295: Find Median from Data Stream




Design a data structure that supports `addNum(Int)` and `findMedian()` in near `O(log n)` per insert.


Solve Hard problem.

Design a data structure that supports `addNum(Int)` and `findMedian()` in near `O(log n)` per
insert.

## Core Ideas

- Two heaps: max-heap for lower half, min-heap for upper half. Balance sizes (difference <= 1).

## Constraints and Complexity

- Up to `5 * 10^5` operations.
- Insert `O(log n)`, median `O(1)`.

## Swift Notes

- Swift lacks built-in heaps; implement binary heap or use `PriorityQueue` snippet.

## Swift Starter

```swift
class MedianFinder {
  // TODO: Use two heaps (max-heap lower, min-heap upper).
  func addNum(_ num: Int) {}
  func findMedian() -> Double { return 0 }
}
```

## Swift Solution (Commented, Sketch)

```swift
class MedianFinder {
  private var lower = PriorityQueue<Int>(sort: >)  // max-heap
  private var upper = PriorityQueue<Int>(sort: <)  // min-heap

  func addNum(_ num: Int) {
    lower.push(num)
    upper.push(lower.pop()!)  // Move largest lower to upper.
    if upper.count > lower.count {
      lower.push(upper.pop()!)  // Rebalance sizes.
    }
  }

  func findMedian() -> Double {
    guard lower.count > upper.count else {
      return (Double(lower.peek!) + Double(upper.peek!)) / 2.0
    }
    return Double(lower.peek!)
  }
}
```

## Interview Framing

- Describe why balancing ensures median resides at roots.
- Extend to sliding window median (two heaps + lazy deletion).
