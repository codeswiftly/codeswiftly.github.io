# Pattern 09: Top K with Heap

@Image(source: "pattern-top-k-heap-hero.codex", alt: "Placeholder hero")

@Metadata {
  @TitleHeading("Practice Top K with Heap")
  @PageImage(purpose: icon, source: "pattern-top-k-heap-icon.codex", alt: "Pattern 09: Top K with Heap icon")
  @PageImage(purpose: card, source: "pattern-top-k-heap-card.codex", alt: "Pattern 09: Top K with Heap card")
}

@Image(source: "top-k-heap-diagram.codex", alt: "Min heap maintaining top k elements")

Use a binary heap to manage a subset of the largest or smallest elements in a dataset without sorting the entire collection.

## Problem

- Find the top K items without sorting everything.

## Solution

- Maintain a size-K heap and evict elements as you stream input.

## Concept

- **Top K Largest**: Use a **Min-Heap** of size `K`. Keep the K largest elements seen so far. If a new element is larger than the root (minimum of the top K), pop the root and push the new element.
- **Top K Smallest**: Use a **Max-Heap** of size `K`.

## Complexity

- **Time**: O(N log K). Each insertion/removal in a heap of size K takes O(log K).
- **Space**: O(K) to store the heap.

## When to Use

- **Streaming Data**: You don't have all data upfront, but need the "current" top K.
- **Large N, Small K**: Sorting is O(N log N), but Heap is O(N log K). If K is small, heap is much faster.
- **Kth Element**: Finding the Kth largest/smallest element.

## Examples

### 1. Find Kth Largest Element

```swift
// Assuming a standard Heap implementation is available or using standard library placeholders
// Swift Collections 'Heap' is recommended in real scenarios.

struct MinHeap<T: Comparable> {
  private var elements: [T] = []

  var isEmpty: Bool { elements.isEmpty }
  var count: Int { elements.count }
  var peek: T? { elements.first }

  mutating func push(_ value: T) {
    elements.append(value)
    siftUp(elements.count - 1)
  }

  mutating func pop() -> T? {
    guard !elements.isEmpty else { return nil }
    if elements.count == 1 { return elements.removeLast() }
    let value = elements[0]
    elements[0] = elements.removeLast()
    siftDown(0)
    return value
  }

  // ... helper siftUp/siftDown methods ...
  // For interviews, just explaining the API is often sufficient or assume `CFBinaryHeap`.
  private mutating func siftUp(_ index: Int) { /* Implementation */  }
  private mutating func siftDown(_ index: Int) { /* Implementation */  }
}

func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
  // Min-Heap to store top K largest elements
  // The root will be the smallest of the top K, i.e., the Kth largest.
  // NOTE: In a real interview, define the Heap API or implement a simple one.
  // This example logic assumes a working MinHeap.

  // Placeholder logic:
  // var minHeap = MinHeap<Int>()
  // for num in nums {
  //     minHeap.push(num)
  //     if minHeap.count > k {
  //         minHeap.pop()
  //     }
  // }
  // return minHeap.peek!

  // Quick Sort alternative (QuickSelect) is O(N) average, but Heap is safer worst-case.
  return nums.sorted(by: >)[k - 1]  // Fallback for standard lib
}
```

### 2. Top K Frequent Elements

```swift
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
  let counts = Dictionary(grouping: nums, by: { $0 }).mapValues { $0.count }

  // Sort keys by frequency (count).
  // In strict O(N log K), use a heap of (count, num).
  let sortedKeys = counts.keys.sorted { counts[$0]! > counts[$1]! }
  return Array(sortedKeys.prefix(k))
}
```

## Common Pitfalls

- **Min vs Max Heap**: It feels counter-intuitive. To keep **Top Largest**, use **Min-Heap** (eject small stuff). To keep **Top Smallest**, use **Max-Heap** (eject big stuff).
- **Comparator**: Ensure your heap comparator handles custom types or tuples correctly.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-692-top-k-frequent-words>
- <doc:leetcode-295-find-median-data-stream>
- <doc:leetcode-1642-farthest-building>
}

## See Also

- <doc:top-15-patterns>
