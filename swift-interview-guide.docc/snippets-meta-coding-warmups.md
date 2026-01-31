@PageImage(purpose: card, source: "snippets-meta-coding-warmups-card.codex", alt: "Placeholder card")
@Image(source: "snippets-meta-coding-warmups-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "snippets-meta-coding-warmups-icon.codex", alt: "Placeholder icon")
# Meta Coding Warmups (Snippets)

Use these as short muscle-memory drills before the coding rounds.

## Binary Search Template

![Binary search flow](binary-search-flow.codex)

```swift
func binarySearch(_ nums: [Int], target: Int) -> Int {
  var left = 0
  var right = nums.count - 1

  while left <= right {
    let mid = left + (right - left) / 2
    if nums[mid] == target { return mid }
    if nums[mid] < target {
      left = mid + 1
    } else {
      right = mid - 1
    }
  }

  return -1
}
```

## BFS Template

![BFS flow](bfs-flow.codex)

```swift
struct Queue<Element> {
  private var values: [Element] = []
  private var head: Int = 0

  mutating func push(_ value: Element) { values.append(value) }

  mutating func pop() -> Element? {
    guard head < values.count else { return nil }
    defer { head += 1 }
    return values[head]
  }

  var isEmpty: Bool { head >= values.count }
}

func bfs(start: Int, neighbors: (Int) -> [Int]) -> [Int] {
  var visited: Set<Int> = [start]
  var queue = Queue<Int>()
  queue.push(start)

  var order: [Int] = []
  while let node = queue.pop() {
    order.append(node)
    for next in neighbors(node) where visited.insert(next).inserted {
      queue.push(next)
    }
  }

  return order
}
```

## Hash Map Counting Template

![Hash map counting flow](hash-map-counting-flow.codex)

```swift
func counts<T: Hashable>(_ values: [T]) -> [T: Int] {
  var counts: [T: Int] = [:]
  for value in values {
    counts[value, default: 0] += 1
  }
  return counts
}
```
