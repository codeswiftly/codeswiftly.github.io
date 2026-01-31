@PageImage(purpose: card, source: "swift-swift-quick-sheet-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-quick-sheet-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-quick-sheet-icon.codex", alt: "Placeholder icon")
# Quick Sheet

@Metadata {
  @TitleHeading("Review Quick Sheet")
  @PageImage(purpose: icon, source: "swift-quick-sheet-icon.codex", alt: "Quick Sheet icon")
  @PageImage(purpose: card, source: "swift-quick-sheet-card.codex", alt: "Quick Sheet card")
}

@Image(source: "swift-quick-sheet-hero.codex", alt: "Quick Sheet hero")

Swift leans on value semantics, explicit mutability, and typed errors. Use these snippets to move
fast in interviews without sacrificing safety.

## Syntax Quickies

### Value vs Reference Types

Struct vs class:

```swift
struct Point {
  var x: Int
  var y: Int
}

final class Node {
  var value: Int
  init(_ v: Int) {
    value = v
  }
}
```

### Optionals

```swift
func use(_ input: String?) {
  guard let value = input else {
    return
  }
  print(value)
}
```

### Errors

```swift
func load() throws -> Data { /* ... */  }
let data = try load()
```

### Async

```swift
func fetch() async throws -> String { /* ... */  }
let result = try await fetch()
```

### Collections

```swift
var counts: [String: Int] = [:]
counts["a", default: 0] += 1

var seen: Set<Int> = []
seen.insert(3)
```

### Ranges

```swift
for i in 0..<n {
  // exclusive upper
}

for j in 0...n {
  // inclusive upper
}
```

### Arrays

```swift
let zeros = Array(repeating: 0, count: 5)
for i in zeros.indices {
  // safe index iteration
}
let idx = zeros.index(zeros.startIndex, offsetBy: 2)
let value = zeros[idx]
```

### Strings and Characters

```swift
let s = "hello"
let offset = s.index(s.startIndex, offsetBy: 3)
let ch = s[offset]
let last = s.index(before: s.endIndex)  // use index(before:) instead of s.count - 1
let mid = s.index(s.startIndex, offsetBy: s.count / 2)
let chars = Array(s)  // copies; now chars[mid] works with Int indices
let chars = Array(s)  // O(n) copy, but integer indexing becomes easy
```

### Int-indexed Traversal

```swift
let chars = Array(s)  // O(n) copy; now chars[i] is O(1)
let indices = Array(s.indices)  // map back: s[indices[i]] if you need String.Index
let digits = s.compactMap { $0.wholeNumberValue }  // numeric digits with int subscripts
```

Prefer arrays when you need random access by integer; stay with `String.Index` when you want zero
copy and can advance sequentially.***

### Binary Search Helpers (Sorted Arrays)

```swift
extension Array where Element: Comparable {
  // First index where element >= target (nil if past end)
  func lowerBound(of target: Element, from start: Int = 0) -> Int? {
    var low = Swift.max(start, 0)
    var high = count
    while low < high {
      let mid = (low + high) / 2
      if self[mid] < target { low = mid + 1 } else { high = mid }
    }
    return low < count ? low : nil
  }

  // First index where element > target
  func upperBound(of target: Element, from start: Int = 0) -> Int? {
    var low = Swift.max(start, 0)
    var high = count
    while low < high {
      let mid = (low + high) / 2
      if self[mid] <= target { low = mid + 1 } else { high = mid }
    }
    return low < count ? low : nil
  }

  func firstIndex(of target: Element, from start: Int = 0) -> Int? {
    guard let idx = lowerBound(of: target, from: start), idx < count, self[idx] == target else {
      return nil
    }
    return idx
  }

  func lastIndex(of target: Element, from start: Int = 0) -> Int? {
    guard let upper = upperBound(of: target, from: start) else { return nil }
    let idx = upper - 1
    return idx >= start && self[idx] == target ? idx : nil
  }
}
```

### Enum-driven Variant (First vs Last)

```swift
enum BoundDirection {
  case first
  case last
  case any  // standard binary search (any matching index)
}

func boundIndex<T: Comparable>(
  of target: T,
  in sorted: [T],
  startingAt start: Int = 0,
  direction: BoundDirection
) -> Int? {
  guard !sorted.isEmpty, start < sorted.count else { return nil }
  var low = max(start, 0)
  var high = sorted.count - 1
  var result: Int?

  while low <= high {
    let mid = (low + high) / 2
    if sorted[mid] < target {
      low = mid + 1
    } else if target < sorted[mid] {
      high = mid - 1
    } else {
      result = mid
      switch direction {
      case .first:
        high = mid - 1  // tighten left
      case .last:
        low = mid + 1  // tighten right
      case .any:
        return mid  // standard binary search hit
      }
    }
  }
  return result
}

func firstIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, direction: .first)
}

func lastIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, direction: .last)
}

func anyIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, direction: .any)
}

// Range of a value (first, last) if present
func range<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> (Int, Int)? {
  guard let first = firstIndex(of: target, in: sorted, startingAt: start),
    let last = lastIndex(of: target, in: sorted, startingAt: start)
  else {
    return nil
  }
  return (first, last)
}
```

### String Indexing Patterns

```swift
// Forward scan with startIndex/endIndex.
var i = s.startIndex
while i < s.endIndex {
  let ch = s[i]
  i = s.index(after: i)
}

// Backward scan (guard non-empty first).
if !s.isEmpty {
  var j = s.index(before: s.endIndex)
  while true {
    let ch = s[j]
    if j == s.startIndex { break }
    j = s.index(before: j)
  }
}

// Safe offsets without traps.
if let k = s.index(s.startIndex, offsetBy: 5, limitedBy: s.endIndex) {
  print(s[k])
}
```

Notes: do not add/subtract integers from `String.Index`; keep indices from the same string.
Convert to `[Character]` only when integer indexing is worth the `O(n)` copy.

## Core Helpers (Stdlib-only)

### Stack

Stack (amortized O(1) ops):

```swift
struct Stack<Element> {
  private var storage: [Element] = []
  // Pushes an element to the top. Amortized O(1) because rare reallocations are spread out.
  mutating func push(_ x: Element) {
    storage.append(x)
  }
  // Pops an element from the top. O(1).
  mutating func pop() -> Element? {
    storage.popLast()
  }
  // Returns the top element without removing it. O(1).
  var peek: Element? {
    storage.last
  }
  // Checks if the stack is empty. O(1).
  var isEmpty: Bool {
    storage.isEmpty
  }
}
```

### Queue (Rolling Head, Amortized O(1))

```swift
struct Queue<Element> {
  private var storage: [Element] = []
  private var head = 0  // Index of the front of the queue.
  // Checks if the queue is empty. O(1).
  var isEmpty: Bool {
    head >= storage.count
  }
  // Adds an element to the back. Amortized O(1).
  mutating func enqueue(_ x: Element) {
    storage.append(x)
  }
  // Removes an element from the front. Amortized O(1).
  mutating func dequeue() -> Element? {
    guard head < storage.count else { return nil }  // Empty queue.
    let value = storage[head]  // Element at the head.
    head += 1  // Move the head forward.
    // Trim consumed elements occasionally to free memory (rare O(n) => amortized O(1)).
    if head > 32 && head * 2 > storage.count {
      storage.removeFirst(head)
      head = 0
    }
    return value
  }
}
```

### Queue Backed by Linked List (All Ops O(1))

```swift
final class LLNode<T> {
  var value: T
  var next: LLNode?
  init(_ value: T, _ next: LLNode? = nil) {
    self.value = value
    self.next = next
  }
}

struct LinkedListQueue<T> {
  private var head: LLNode<T>?
  private var tail: LLNode<T>?

  var isEmpty: Bool { head == nil }

  mutating func enqueue(_ value: T) {
    let node = LLNode(value)
    if let tail = tail {
      tail.next = node  // Link existing tail to new node.
      self.tail = node  // Update tail to new node.
    } else {
      head = node  // Empty queue: head and tail are the same node.
      tail = node
    }
  }

  mutating func dequeue() -> T? {
    guard let node = head else { return nil }
    head = node.next  // Move head forward.
    if head == nil { tail = nil }  // If queue becomes empty, reset tail.
    return node.value
  }

  // Reverses the queue order in-place. O(n) time, O(1) space.
  mutating func reverse() {
    var previous: LLNode<T>? = nil
    var current = head
    tail = head  // Old head becomes new tail after reversal.
    while let node = current {
      let next = node.next
      node.next = previous
      previous = node
      current = next
    }
    head = previous  // New head is the last non-nil node seen.
  }
}
```

### Heap with Configurable Ordering (Push/Pop O(log N))

```swift
struct Heap<Element> {
  private var h: [Element] = []
  private let areSorted: (Element, Element) -> Bool  // true if lhs should precede rhs

  init(sort: @escaping (Element, Element) -> Bool) {
    self.areSorted = sort
  }

  var isEmpty: Bool { h.isEmpty }
  var peek: Element? { h.first }  // O(1)

  mutating func push(_ x: Element) {
    h.append(x)
    siftUp(h.count - 1)  // O(log n)
  }

  mutating func pop() -> Element? {
    guard !h.isEmpty else { return nil }
    h.swapAt(0, h.count - 1)  // swap root with last
    let v = h.removeLast()
    siftDown(0)  // restore heap property
    return v
  }

  // Moves an element up the heap to its correct position. O(log n).
  private mutating func siftUp(_ i: Int) {
    var c = i  // child index
    while c > 0 {
      let p = (c - 1) / 2  // parent index
      guard areSorted(h[c], h[p]) else {
        break
      }
      h.swapAt(c, p)
      c = p
    }
  }

  // Moves an element down the heap to its correct position. O(log n).
  private mutating func siftDown(_ i: Int) {
    var p = i  // parent index
    while true {
      let l = p * 2 + 1
      let r = l + 1  // left and right child indices
      var s = p  // index of extremum per sort
      if l < h.count && areSorted(h[l], h[s]) { s = l }
      if r < h.count && areSorted(h[r], h[s]) { s = r }
      if s == p { break }  // already satisfies heap property
      h.swapAt(p, s)
      p = s
    }
  }
}

// Usage:
// Min-heap: var heap = Heap<Int>(sort: <)
// Max-heap: var heap = Heap<Int>(sort: >)
```

### Priority Queue (Min-heap by Default)

```swift
struct PriorityQueue<Element> {
  private var heap: [Element] = []
  private let areSorted: (Element, Element) -> Bool

  init(sort: @escaping (Element, Element) -> Bool = (<)) {
    self.areSorted = sort
  }

  var isEmpty: Bool { heap.isEmpty }
  var count: Int { heap.count }
  var peek: Element? { heap.first }

  mutating func push(_ element: Element) {
    heap.append(element)
    siftUp(from: heap.count - 1)
  }

  mutating func pop() -> Element? {
    guard !heap.isEmpty else { return nil }
    heap.swapAt(0, heap.count - 1)
    let popped = heap.removeLast()
    siftDown(from: 0)
    return popped
  }

  private mutating func siftUp(from childIndex: Int) {
    var childIndex = childIndex
    while childIndex > 0 {
      let parentIndex = (childIndex - 1) / 2
      guard areSorted(heap[childIndex], heap[parentIndex]) else {
        break
      }
      heap.swapAt(childIndex, parentIndex)
      childIndex = parentIndex
    }
  }

  private mutating func siftDown(from parentIndex: Int) {
    var parentIndex = parentIndex
    while true {
      let leftIndex = parentIndex * 2 + 1
      let rightIndex = leftIndex + 1
      var swapIndex = parentIndex
      if leftIndex < heap.count && areSorted(heap[leftIndex], heap[swapIndex]) {
        swapIndex = leftIndex
      }
      if rightIndex < heap.count && areSorted(heap[rightIndex], heap[swapIndex]) {
        swapIndex = rightIndex
      }
      if swapIndex == parentIndex { break }
      heap.swapAt(parentIndex, swapIndex)
      parentIndex = swapIndex
    }
  }
}
```

### Quicksort (In-place)

```swift
// Average O(n log n) time, worst-case O(n^2) if pivots are poor (e.g., already sorted input).
// In-place: O(log n) stack space for recursion on balanced splits.
func quicksort(_ nums: inout [Int]) {
  guard nums.count > 1 else { return }

  func sort(_ low: Int, _ high: Int) {
    if low >= high { return }  // Base case: one or zero elements.

    // Simple middle pivot; random/median-of-three is safer for already sorted input.
    let pivot = nums[(low + high) / 2]
    var i = low
    var j = high

    // Partition: move elements < pivot left, > pivot right.
    while i <= j {
      while nums[i] < pivot { i += 1 }  // Scan forward for an out-of-place element.
      while nums[j] > pivot { j -= 1 }  // Scan backward for an out-of-place element.
      if i <= j {
        nums.swapAt(i, j)  // Swap misplaced pair to restore order around pivot.
        i += 1
        j -= 1
      }
    }

    // Recurse on the partitions.
    if low < j { sort(low, j) }
    if i < high { sort(i, high) }
  }

  sort(nums.startIndex, nums.index(before: nums.endIndex))
}
```

### Sliding Window (Fixed K)

```swift
// Calculates the max sum of a subarray of a fixed size k.
// O(n) time, O(1) space.
func maxSumSubarray(_ arr: [Int], k: Int) -> Int {
  guard arr.count >= k else { return 0 }
  var sum = arr[0..<k].reduce(0, +)  // Initial window sum.
  var best = sum  // Track best so far.
  // Slide the window from left to right.
  for i in 0..<(arr.count - k) {
    sum += arr[i + k] - arr[i]  // Add entering, remove leaving.
    best = max(best, sum)  // Update best.
  }
  return best
}
```

### Prefix Sum (Range Query)

```swift
// Calculates the sum of a range in an array using a prefix sum array.
// O(n) time to build, O(1) time for each query. O(n) space.
func rangeSum(_ nums: [Int], _ i: Int, _ j: Int) -> Int {
  var prefix = Array(repeating: 0, count: nums.count + 1)
  // Build the prefix sum array.
  for k in 0..<nums.count { prefix[k + 1] = prefix[k] + nums[k] }
  // The sum of the range [i, j] is the difference between the prefix sums.
  return prefix[j + 1] - prefix[i]
}
```

### Unique Occurrences (Freq Map)

```swift
// Checks if the number of occurrences of each value in the array is unique.
// O(n) time, O(k) space, where k is the number of distinct values.
func uniqueOccurrences(_ arr: [Int]) -> Bool {
  var counts: [Int: Int] = [:]
  // Count the frequency of each value.
  for v in arr { counts[v, default: 0] += 1 }
  let freq = counts.values
  // Check if the frequencies themselves are unique.
  return Set(freq).count == freq.count
}
```

## Common Big-O Reminders

### Tree Node + Quick Traversals

- Appending/popping on Array end: amortized O(1).
- Rolling-head queue dequeue with periodic trim: amortized O(1); individual trim O(n) but rare.
- Binary heap push/pop: O(log n).
- Sliding window (fixed size): O(n).
- Prefix sum build: O(n); range query: O(1).
- Hash maps/sets average-case insert/lookup: O(1); worst-case O(n) (rare).
- DFS/BFS over n nodes/m edges: O(n + m).

```swift
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

// Inorder traversal — O(n) time, O(h) stack (h = tree height).
func inorder(_ root: TreeNode?) -> [Int] {
  guard let node = root else { return [] }
  // Traverse left, visit self, then traverse right.
  return inorder(node.left) + [node.val] + inorder(node.right)  // LNR
}

// Level order (BFS) — O(n) time, O(w) space (w = tree width).
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  guard let root else { return [] }
  var q = Queue<TreeNode>()
  q.enqueue(root)
  var levels: [[Int]] = []
  while !q.isEmpty {
    var level: [Int] = []
    var next: [TreeNode] = []  // Collect children for the next level.
    while let node = q.dequeue() {
      level.append(node.val)
      if let l = node.left { next.append(l) }
      if let r = node.right { next.append(r) }
    }
    for n in next { q.enqueue(n) }
    levels.append(level)
  }
  return levels
}
```
