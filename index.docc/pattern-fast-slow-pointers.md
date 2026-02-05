# Pattern 06: Fast and Slow Pointers

@Image(source: "pattern-fast-slow-pointers-hero.codex", alt: "Placeholder hero")

@Metadata {
  @TitleHeading("Practice Fast and Slow Pointers")
  @PageImage(purpose: icon, source: "pattern-fast-slow-pointers-icon.codex", alt: "Pattern 06: Fast and Slow Pointers icon")
  @PageImage(purpose: card, source: "pattern-fast-slow-pointers-card.codex", alt: "Pattern 06: Fast and Slow Pointers card")
}

@Image(source: "fast-slow-pointers-diagram.codex", alt: "Tortoise and Hare algorithm")

Use two pointers moving at different speeds (usually 1x and 2x) to detect cycles or find list midpoints without extra storage.

## Problem

- Detect a cycle or find the midpoint in a linked list.

## Solution

- Move `slow` by 1 and `fast` by 2; meeting implies a cycle.

## Concept

Also known as the **Floyd's Tortoise and Hare** algorithm.

- **Cycle Detection**: If there is a cycle, the fast pointer will eventually lap the slow pointer and they will meet inside the loop. If `fast` reaches the end (`nil`), there is no cycle.
- **Midpoint**: When `fast` reaches the end, `slow` will be at the middle.

## Complexity

- **Time**: O(N). In a cycle of length K, they meet in at most K steps after entering the cycle.
- **Space**: O(1). Only two pointers needed.

## When to Use

- **Linked Lists**: Cycles, finding middle, checking palindrome (reverse second half).
- **Array Cycles**: "Happy Number" or array jumping problems where values dictate next index.

## Examples

### 1. Linked List Cycle

Determine if a linked list has a cycle.

@Image(source: "fast-slow-cycle-example.codex", alt: "Fast and slow pointers meeting in a cycle")

```swift
public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
    self.val = val
    self.next = nil
  }
}

func hasCycle(_ head: ListNode?) -> Bool {
  var slow = head
  var fast = head

  while let fastNode = fast, let nextFast = fastNode.next {
    slow = slow?.next
    fast = nextFast.next

    // Reference equality check
    if slow === fast {
      return true
    }
  }

  return false
}
```

### 2. Middle of the Linked List

Find the middle node.

@Image(source: "fast-slow-middle-example.codex", alt: "Fast pointer ends while slow points to the middle")

```swift
func middleNode(_ head: ListNode?) -> ListNode? {
  var slow = head
  var fast = head

  while let fastNode = fast, let nextFast = fastNode.next {
    slow = slow?.next
    fast = nextFast.next
  }

  return slow
}
```

## Common Pitfalls

- **Null Safety**: Always check `fast` and `fast.next` before advancing to avoid crashes.
- **Cycle Entry**: To find *where* the cycle starts, reset `slow` to head after they meet, and move both at 1x speed until they meet again.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1823-find-the-winner-of-the-circular-game>
- <doc:leetcode-2682-find-the-losers-of-the-circular-game>
- <doc:leetcode-206-reverse-linked-list>
}

## See Also

- <doc:top-15-patterns>
