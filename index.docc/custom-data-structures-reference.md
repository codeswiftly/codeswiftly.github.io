# Custom Data Structures Reference

@Metadata {
  @TitleHeading("Custom data structures reference")
  @PageImage(purpose: icon, source: "custom-data-structures-reference-icon.codex", alt: "Custom data structures reference icon")
  @PageImage(purpose: card, source: "custom-data-structures-reference-card.codex", alt: "Custom data structures reference card")
}

@Image(source: "custom-data-structures-reference-hero.codex", alt: "Custom data structures reference hero")

Swift interview solutions are usually written on top of Swift Main primitives (`Array`,
`Dictionary`, `Set`, `String`), but many data structures that show up in problem statements are
**not** first‑class types in Swift.

Start with the standard library types here: <doc:swift-main-data-structures>.

For full drill write‑ups, see the individual `leetcode-*.md` pages.

## Quick Links

@Links(visualStyle: detailedGrid) {

- <doc:top-15-patterns>
- <doc:heaps-vs-sorted-arrays>
- <doc:sorted-array-bounds>
- <doc:lru-cache-primer>
- <doc:lru-cache-array-primer>

}

---

## What Interviewers Expect You to Implement

Most of these are “stdlib + invariant”:

| Structure | Backed by | When it shows up |
| --- | --- | --- |
| Heap / priority queue | `Array` | Top‑K, scheduling, Dijkstra‑style graphs |
| Queue | `Array` + head index | BFS (tree/graph/grid) |
| Deque | ring buffer | sliding window max, 0‑1 BFS, windowed simulations |
| Linked list (LRU) | reference nodes + `Dictionary` | O(1) eviction + recency updates |
| Union‑find (DSU) | `Array` parents/rank | connectivity, components, Kruskal |


---

## Heap (Binary Min-heap)

Useful when you need:

- A **Top‑K** set of elements (for example, Kth largest, Top K frequent).
- A priority queue (for example, scheduling intervals or Dijkstra-style graphs).

This is a minimal integer min‑heap you can adapt to a generic `Heap<Element>`:

```swift
struct MinHeap {
  private var heap: [Int] = []

  var count: Int { heap.count }
  var peek: Int? { heap.first }

  mutating func push(_ value: Int) {
    heap.append(value)
    siftUp(from: heap.count - 1)
  }

  mutating func pop() -> Int? {
    guard !heap.isEmpty else { return nil }
    heap.swapAt(0, heap.count - 1)
    let popped = heap.removeLast()
    siftDown(from: 0)
    return popped
  }

  // MARK: - Private helpers

  private mutating func siftUp(from index: Int) {
    var child = index
    while child > 0 {
      let parent = (child - 1) / 2
      guard heap[child] < heap[parent] else {
        break
      }
      heap.swapAt(child, parent)
      child = parent
    }
  }

  private mutating func siftDown(from index: Int) {
    var parent = index
    while true {
      let left = parent * 2 + 1
      let right = left + 1
      var candidate = parent

      if left < heap.count && heap[left] < heap[candidate] {
        candidate = left
      }
      if right < heap.count && heap[right] < heap[candidate] {
        candidate = right
      }
      if candidate == parent { break }

      heap.swapAt(parent, candidate)
      parent = candidate
    }
  }
}
```

Example: Top‑K largest numbers using a min‑heap of size `k`:

```swift
func topK(_ numbers: [Int], k: Int) -> [Int] {
  var heap = MinHeap()

  for value in numbers {
    heap.push(value)
    if heap.count > k {
      _ = heap.pop()
    }
  }

  var result: [Int] = []
  while let value = heap.pop() {
    result.append(value)
  }
  return result.reversed()
}
```

<doc:leetcode-692-top-k-frequent-words>, <doc:leetcode-295-find-median-data-stream>.

---

## Queue\<Element\> (Rolling-head Array)

A lightweight FIFO queue built on top of an array with a “rolling head” index. This shows up in:

- BFS on trees and graphs.
- Multi-source BFS in grid problems (for example, Rotting Oranges).
- Any time you want `O(1)` enqueue/dequeue amortized without pulling in `Deque`.

```swift
struct Queue<Element> {
  private var storage: [Element] = []
  private var head = 0

  var isEmpty: Bool {
    head >= storage.count
  }

  var count: Int {
    storage.count - head
  }

  mutating func enqueue(_ element: Element) {
    storage.append(element)
  }

  mutating func dequeue() -> Element? {
    guard head < storage.count else { return nil }
    let element = storage[head]
    head += 1

    // Periodically compact storage to keep memory bounded.
    if head > 32 && head * 2 > storage.count {
      storage.removeFirst(head)
      head = 0
    }
    return element
  }
}
```

Example: Level‑order traversal (tree BFS) using `Queue`:

```swift
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  guard let root else { return [] }

  var queue = Queue<TreeNode>()
  queue.enqueue(root)

  var levels: [[Int]] = []

  while !queue.isEmpty {
    let levelCount = queue.count
    var currentLevel: [Int] = []

    for _ in 0..<levelCount {
      guard let node = queue.dequeue() else { continue }
      currentLevel.append(node.val)
      if let left = node.left { queue.enqueue(left) }
      if let right = node.right { queue.enqueue(right) }
    }

    levels.append(currentLevel)
  }

  return levels
}
```

Related patterns: **Binary tree BFS**, **Graph BFS (shortest path)**, and **Matrix traversal**
in <doc:top-15-patterns>. Related drills: <doc:leetcode-200-number-of-islands>,
`Visible Nodes`, and other BFS-style questions.

---

## Deque\<Element\> (Ring Buffer)

A double-ended queue for “push/pop both ends” without `Array.insert` / `Array.removeFirst`.
This is the backbone of things like sliding-window max and some shortest-path variants.

```swift
struct Deque<Element> {
  private var buffer: [Element?] = Array(repeating: nil, count: 16)
  private var head = 0
  private var tail = 0
  private(set) var count = 0

  var isEmpty: Bool { count == 0 }

  mutating func pushBack(_ element: Element) {
    ensureCapacity(for: count + 1)
    buffer[tail] = element
    tail = (tail + 1) % buffer.count
    count += 1
  }

  mutating func popFront() -> Element? {
    guard count > 0 else { return nil }
    let element = buffer[head]
    buffer[head] = nil
    head = (head + 1) % buffer.count
    count -= 1
    return element
  }

  private mutating func ensureCapacity(for requestedCount: Int) {
    guard requestedCount > buffer.count else { return }

    let newCapacity = max(buffer.count * 2, requestedCount)
    var newBuffer: [Element?] = Array(repeating: nil, count: newCapacity)

    for index in 0..<count {
      newBuffer[index] = buffer[(head + index) % buffer.count]
    }

    buffer = newBuffer
    head = 0
    tail = count
  }
}
```

---

## Union-Find (DSU)

Use DSU when you need fast “are these connected?” queries while merging sets.

```swift
struct DisjointSetUnion {
  private var parent: [Int]
  private var rank: [Int]

  init(count: Int) {
    parent = Array(0..<count)
    rank = Array(repeating: 0, count: count)
  }

  mutating func find(_ value: Int) -> Int {
    if parent[value] != value {
      parent[value] = find(parent[value])
    }
    return parent[value]
  }

  mutating func union(_ left: Int, _ right: Int) -> Bool {
    let leftRoot = find(left)
    let rightRoot = find(right)
    if leftRoot == rightRoot { return false }

    if rank[leftRoot] < rank[rightRoot] {
      parent[leftRoot] = rightRoot
    } else if rank[leftRoot] > rank[rightRoot] {
      parent[rightRoot] = leftRoot
    } else {
      parent[rightRoot] = leftRoot
      rank[leftRoot] += 1
    }
    return true
  }
}
```

---

## Notes on List and Tree Nodes

Many linked‑list and tree problems in this guide assume simple reference types:

```swift
final class ListNode {
  var val: Int
  var next: ListNode?

  init(_ val: Int, _ next: ListNode? = nil) {
    self.val = val
    self.next = next
  }
}

final class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?

  init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
    self.val = val
    self.left = left
    self.right = right
  }
}
```

Problems that use these definitions:

- Lists: <doc:leetcode-206-reverse-linked-list>, <doc:linked-list-reversal>, cycle detection drills.
- Trees: <doc:leetcode-1372-longest-zigzag-path>, BFS/DFS tree analytics questions.

Keep these in mind when you sketch APIs so you do not re‑invent node types in every solution.
