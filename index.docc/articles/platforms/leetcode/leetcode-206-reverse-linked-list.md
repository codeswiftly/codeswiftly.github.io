# LeetCode 206: Reverse Linked List

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-206-reverse-linked-list-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-206-reverse-linked-list-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-206-reverse-linked-list-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-206-reverse-linked-list-dsa-icon.codex", alt: "Easy problem - Pattern 7 (In-Place Reversal)")
  @PageImage(purpose: card, source: "leetcode-206-reverse-linked-list-dsa-card.codex", alt: "Easy problem - Pattern 7 (In-Place Reversal)")
}

@Image(source: "leetcode-206-reverse-linked-list-dsa-hero.codex", alt: "Easy problem - Pattern 7 (In-Place Reversal)")

Reverse a singly linked list iteratively or recursively.

@Image(source: "leetcode-206-reverse-linked-list-dsa-top.codex", alt: "Easy problem - Pattern 7 (In-Place Reversal)")

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
