# Pattern 07: In-Place Reversal


@Metadata {
  @TitleHeading("Practice In-Place Reversal")
}


Manipulate pointer references to reverse linked lists or array segments without allocating new memory.

## Problem

- Reverse a list or segment without extra memory.

## Solution

- Track `prev`, `curr`, and `next`, rewiring one link at a time.

## Concept

Instead of creating a new list, you iterate through the existing list and change the `next` pointer of the current node to point to the `previous` node.

- **State**: You need three pointers: `prev`, `curr`, and `next`.
- **Action**: `curr.next = prev`, then shift all pointers forward.

## Complexity

- **Time**: O(N). You traverse each node once.
- **Space**: O(1). No extra storage is used.

## When to Use

- **Linked List Reversal**: Full reversal or reversing a sub-segment (from index m to n).
- **Palindromes**: Reversing the second half of a linked list to compare with the first half.
- **K-Group Reversal**: Reversing nodes in groups of K.

## Examples

### 1. Reverse Linked List

Reverse a singly linked list.


```swift
func reverseList(_ head: ListNode?) -> ListNode? {
  var prev: ListNode?
  var curr = head

  while let node = curr {
    let nextTemp = node.next
    node.next = prev
    prev = node
    curr = nextTemp
  }

  return prev
}
```

### 2. Reverse Linked List II (Sublist)

Reverse a linked list from position `left` to `right`.


The key idea is to keep a fixed `prev` node before the sublist, then repeatedly move the `then`
node to the front of the sublist. Each iteration shortens the remaining sublist and grows the
reversed prefix without touching nodes outside `[left, right]`.

```swift
func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
  if head == nil || left == right { return head }

  let dummy = ListNode(0)
  dummy.next = head
  var prev = dummy

  // Move to the node before the reversal starts
  for _ in 0..<(left - 1) {
    prev = prev.next!
  }

  let start = prev.next
  let then = start?.next

  // 1 -> 2 -> 3 -> 4, left=2, right=4
  // prev=1, start=2, then=3
  // Reverse (right - left) times
  for _ in 0..<(right - left) {
    start?.next = then?.next
    then?.next = prev.next
    prev.next = then
    then = start?.next
  }

  return dummy.next
}
```

## Common Pitfalls

- **Lost References**: Always save `curr.next` before overwriting it.
- **Edge Cases**: Handling head/tail changes, or single-node lists. A dummy node often simplifies "before head" edge cases.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-206-reverse-linked-list>
- <doc:linked-list-reversal>
}

## See Also

- <doc:top-15-patterns>
