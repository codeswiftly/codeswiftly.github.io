# Linked List Reversal (Iterative and Recursive)


@Metadata {
  @TitleHeading("Review Linked List Reversal (Iterative and Recursive)")
}


## Overview

- Classic pointer exercise; Apple/Meta often use it to gauge comfort with references and optionals.
- Provide both iterative (O(1) space) and recursive (O(n) stack) solutions.

## Common Pitfalls

- Recursing on the same head → infinite recursion.
- Forgetting to advance the pointer (curr) or to break old links (creating cycles).
- Misusing optionals (`head?.next` without unwrap).
- Re-allocating nodes instead of rewiring `.next`.

## Iterative Solution (Canonical)

```swift
class Solution {
  func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var curr = head

    while let node = curr {
      let nextTemp = node.next  // save next
      node.next = prev  // reverse pointer
      prev = node  // move prev forward
      curr = nextTemp  // move curr forward
    }

    return prev
  }
}
```

- Invariant: before each loop, `prev` is the head of the reversed part; `curr` is the node to
  process; `nextTemp` preserves the rest.
- Time O(n), space O(1).

## Recursive Solution (Canonical)

```swift
class Solution {
  func reverseList(_ head: ListNode?) -> ListNode? {
    guard let head = head else { return nil }
    guard let next = head.next else { return head }

    let newHead = reverseList(next)  // reverse rest

    next.next = head  // attach head after next
    head.next = nil  // break old link

    return newHead
  }
}
```

- Base: empty or single node returns itself.
- Time O(n); space O(n) stack.

## Interview Notes

- Mention reference semantics (class ListNode) and in-place rewiring (no new nodes).
- Optional handling: `while let node = curr` is Swifty; guards handle bases cleanly.
- If nudged to discuss alternatives, note that recursion uses stack; iterative is constant space.
- If asked about validation, real-world code should handle invalid inputs; LeetCode assumes valid.
