@PageImage(purpose: card, source: "platforms-leetcode-leetcode-23-merge-k-sorted-lists-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-23-merge-k-sorted-lists-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-23-merge-k-sorted-lists-icon.codex", alt: "Placeholder icon")
# LeetCode 23: Merge K Sorted Lists

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-23-merge-k-sorted-lists-dsa-icon.codex", alt: "Hard problem - Pattern 9 (Top-K Heap)")
  @PageImage(purpose: card, source: "leetcode-23-merge-k-sorted-lists-dsa-card.codex", alt: "Hard problem - Pattern 9 (Top-K Heap)")
}

@Image(source: "leetcode-23-merge-k-sorted-lists-dsa-hero.codex", alt: "Hard problem - Pattern 9 (Top-K Heap)")

Merge `k` sorted linked lists into one sorted list.

@Image(source: "leetcode-23-merge-k-sorted-lists-dsa-top.codex", alt: "Hard problem - Pattern 9 (Top-K Heap)")

Solve Hard problem.

Merge `k` sorted linked lists into one sorted list.

## Core Ideas

- Use a min-heap of list heads.
- Pop the smallest node and push its next node.

## Constraints and Complexity

- Total nodes up to `10^4`.
- Time `O(n log k)`, space `O(k)`.

## Edge Cases

- Empty lists.
- Single list.

## Swift Starter

```swift
class Solution {
  func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    // TODO: Min-heap of list heads.
    return nil
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    var heap = MinHeap()
    for node in lists {
      if let node { heap.push(node) }
    }

    let dummy = ListNode(0)
    var tail = dummy

    while let node = heap.pop() {
      tail.next = node
      tail = node
      if let next = node.next { heap.push(next) }
    }

    return dummy.next
  }
}

struct MinHeap {
  private var data: [ListNode] = []

  mutating func push(_ node: ListNode) {
    data.append(node)
    siftUp(from: data.count - 1)
  }

  mutating func pop() -> ListNode? {
    guard !data.isEmpty else { return nil }
    data.swapAt(0, data.count - 1)
    let min = data.removeLast()
    siftDown(from: 0)
    return min
  }

  private mutating func siftUp(from index: Int) {
    var child = index
    while child > 0 {
      let parent = (child - 1) / 2
      if data[child].val < data[parent].val {
        data.swapAt(child, parent)
        child = parent
      } else {
        break
      }
    }
  }

  private mutating func siftDown(from index: Int) {
    var parent = index
    while true {
      let left = parent * 2 + 1
      let right = left + 1
      var candidate = parent

      if left < data.count, data[left].val < data[candidate].val {
        candidate = left
      }
      if right < data.count, data[right].val < data[candidate].val {
        candidate = right
      }

      if candidate == parent { return }
      data.swapAt(parent, candidate)
      parent = candidate
    }
  }
}
```

## Interview Framing

- The heap keeps the next smallest head in `O(log k)` time.
- For small `k`, divide-and-conquer merging is a solid alternative.
