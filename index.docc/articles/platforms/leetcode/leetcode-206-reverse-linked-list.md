# LeetCode 206: Reverse Linked List




Reverse a singly linked list iteratively or recursively.


Solve Easy problem.

## Core Ideas

- Iterative pointer reversal (prev, curr, next).
- Recursive approach returning new head.

## Swift Starter

```swift
class Solution {
  func reverseList(_ head: ListNode?) -> ListNode? {
    // TODO: Iterative pointer reversal.
    return nil
  }
}
```

## Swift Solution (Commented, Iterative)

```swift
class Solution {
  func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var current = head
    while let node = current {
      let next = node.next
      node.next = prev  // Reverse link.
      prev = node
      current = next
    }
    return prev
  }
}
```

## Interview Framing

- Explain pointer safety, no extra space.
- Mention recursion risk for long lists (stack overflow).
