# Common Interview Snippets

@PageImage(purpose: icon, source: "snippets-common-interview-problems-icon.codex", alt: "Common interview snippets icon")

@Metadata {
  @PageColor(orange)
  @TitleHeading("Common Interview Snippets")
  @PageImage(purpose: card, source: "snippets-common-interview-problems-card.codex", alt: "Common interview snippets card")
}

Short, copy-ready Swift snippets for common interview problems. Use these as starting points,
then narrate the invariants and complexity.

## Arrays and Strings

### Two Sum (Hash Map)

```swift
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
  var lookup: [Int: Int] = [:]
  for (index, value) in numbers.enumerated() {
    let need = target - value
    if let hit = lookup[need] {
      return [hit, index]
    }
    lookup[value] = index
  }
  return []
}
```

### Longest Substring Without Repeats (Sliding Window)

```swift
func lengthOfLongestSubstring(_ text: String) -> Int {
  let scalars = Array(text)
  var lastSeen: [Character: Int] = [:]
  var left = 0
  var best = 0
  for (right, ch) in scalars.enumerated() {
    if let prev = lastSeen[ch], prev >= left {
      left = prev + 1
    }
    lastSeen[ch] = right
    best = max(best, right - left + 1)
  }
  return best
}
```

### Merge Intervals

```swift
func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
  let sorted = intervals.sorted { $0[0] < $1[0] }
  var merged: [[Int]] = []
  for interval in sorted {
    if merged.isEmpty || merged[merged.count - 1][1] < interval[0] {
      merged.append(interval)
    } else {
      merged[merged.count - 1][1] = max(merged[merged.count - 1][1], interval[1])
    }
  }
  return merged
}
```

## Linked Lists

### Reverse a Singly Linked List

```swift
/// final class ListNode {
///   var value: Int
///   var next: ListNode?
///   init(_ value: Int, _ next: ListNode? = nil) {
///     self.value = value
///     self.next = next
///   }
/// }
func reverseList(_ head: ListNode?) -> ListNode? {
  var previous: ListNode? = nil
  var current = head
  while let node = current {
    let nextNode = node.next
    node.next = previous
    previous = node
    current = nextNode
  }
  return previous
}
```

### Detect a Cycle (Floyd's Tortoise and Hare)

```swift
func hasCycle(_ head: ListNode?) -> Bool {
  var slow = head
  var fast = head
  while let nextFast = fast?.next?.next {
    slow = slow?.next
    fast = nextFast
    if slow === fast { return true }
  }
  return false
}
```

## Trees and Graphs

### Binary Tree BFS (Level Order)

```swift
/// final class TreeNode {
///   var value: Int
///   var left: TreeNode?
///   var right: TreeNode?
///   init(_ value: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
///     self.value = value
///     self.left = left
///     self.right = right
///   }
/// }
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  guard let root else { return [] }
  var result: [[Int]] = []
  var queue: [TreeNode] = [root]
  var index = 0
  while index < queue.count {
    let levelCount = queue.count - index
    var level: [Int] = []
    for _ in 0..<levelCount {
      let node = queue[index]
      index += 1
      level.append(node.value)
      if let left = node.left { queue.append(left) }
      if let right = node.right { queue.append(right) }
    }
    result.append(level)
  }
  return result
}
```

### DFS on a Grid (Number of Islands)

```swift
func numIslands(_ grid: [[Character]]) -> Int {
  var grid = grid
  let rows = grid.count
  let cols = rows > 0 ? grid[0].count : 0
  let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

  func dfs(_ row: Int, _ col: Int) {
    guard row >= 0, row < rows, col >= 0, col < cols else { return }
    guard grid[row][col] == "1" else { return }
    grid[row][col] = "0"
    for (dr, dc) in directions {
      dfs(row + dr, col + dc)
    }
  }

  var count = 0
  for row in 0..<rows {
    for col in 0..<cols {
      if grid[row][col] == "1" {
        count += 1
        dfs(row, col)
      }
    }
  }
  return count
}
```

## Heaps and Priority Queues

### Top K Frequent Elements (Min-heap Sketch)

```swift
struct Heap<Element> {
  var elements: [Element] = []
  let priority: (Element, Element) -> Bool
  mutating func insert(_ value: Element) { elements.append(value); siftUp(from: elements.count - 1) }
  mutating func remove() -> Element? {
    guard !elements.isEmpty else { return nil }
    if elements.count == 1 { return elements.removeLast() }
    let value = elements[0]
    elements[0] = elements.removeLast()
    siftDown(from: 0)
    return value
  }
  var peek: Element? { elements.first }
  mutating func siftUp(from index: Int) {
    var child = index
    var parent = (child - 1) / 2
    while child > 0 && priority(elements[child], elements[parent]) {
      elements.swapAt(child, parent)
      child = parent
      parent = (child - 1) / 2
    }
  }
  mutating func siftDown(from index: Int) {
    var parent = index
    while true {
      let left = parent * 2 + 1
      let right = left + 1
      var candidate = parent
      if left < elements.count && priority(elements[left], elements[candidate]) { candidate = left }
      if right < elements.count && priority(elements[right], elements[candidate]) { candidate = right }
      if candidate == parent { return }
      elements.swapAt(parent, candidate)
      parent = candidate
    }
  }
}

func topKFrequent(_ numbers: [Int], _ k: Int) -> [Int] {
  var counts: [Int: Int] = [:]
  for value in numbers { counts[value, default: 0] += 1 }
  var heap = Heap<(value: Int, count: Int)> { $0.count < $1.count }
  for (value, count) in counts {
    heap.insert((value, count))
    if heap.elements.count > k { _ = heap.remove() }
  }
  return heap.elements.map { $0.value }
}
```

## Dynamic Programming

### Coin Change (Minimum Coins)

```swift
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
  guard amount > 0 else { return 0 }
  var dp = Array(repeating: amount + 1, count: amount + 1)
  dp[0] = 0
  for value in 1...amount {
    for coin in coins where coin <= value {
      dp[value] = min(dp[value], dp[value - coin] + 1)
    }
  }
  return dp[amount] > amount ? -1 : dp[amount]
}
```
