# HackerRank -- Insert a Node at a Specific Position in a Linked List

@PageImage(purpose: card, source: "platforms-hackerrank-hackerrank-insert-node-at-position-card.codex", alt: "Placeholder card")
@Image(source: "platforms-hackerrank-hackerrank-insert-node-at-position-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-hackerrank-hackerrank-insert-node-at-position-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review HackerRank -- Insert a Node at a Specific Position in a Linked List")
  @PageImage(purpose: icon, source: "difficulty-easy.codex", alt: "Easy problem")
  @PageImage(purpose: card, source: "hackerrank-insert-node-at-position-card.codex", alt: "HackerRank Insert a Node at a Specific Position in a Linked List card")
}

@Image(source: "hackerrank-insert-node-at-position-hero.codex", alt: "HackerRank Insert a Node at a Specific Position in a Linked List hero")

## Problem Restatement

Given a singly linked list head, a value `data`, and an index `position`, insert a new node with
`data` at that zero-based position and return the (possibly new) head.

## Core Ideas

- Base case inserts at the head (empty list or `position == 0`).
- Recursive approach: recurse to the node before the target position and rewire `next` on the way
  back.
- Iterative alternative: walk to `position - 1`, splice, and return the original head.

## Constraints and Complexity

- List length up to HackerRank limits (~10^3–10^4).
- Time: `O(n)`; Space: `O(n)` for recursion depth or `O(1)` iteratively.

## Edge Cases

- Insert at head.
- Insert in the middle or at tail.
- Empty list with `position == 0` → new head.

## Recursive Swift Solution

```swift
func insertNodeAtPosition(llist: SinglyLinkedListNode?, data: Int, position: Int)
  -> SinglyLinkedListNode?
{
  if llist == nil || position == 0 {
    let node = SinglyLinkedListNode(nodeData: data)
    node.next = llist
    return node
  }
  llist?.next = insertNodeAtPosition(llist: llist?.next, data: data, position: position - 1)
  return llist
}
```

## Iterative Swift Solution

```swift
func insertNodeAtPositionIterative(llist: SinglyLinkedListNode?, data: Int, position: Int)
  -> SinglyLinkedListNode?
{
  guard let head = llist else {
    return SinglyLinkedListNode(nodeData: data)
  }
  if position == 0 {
    let node = SinglyLinkedListNode(nodeData: data)
    node.next = head
    return node
  }
  var current: SinglyLinkedListNode? = head
  var steps = position - 1
  while steps > 0, current?.next != nil {
    current = current?.next
    steps -= 1
  }
  let node = SinglyLinkedListNode(nodeData: data)
  node.next = current?.next
  current?.next = node
  return head
}
```

## Quick Tests

```swift
let list = SinglyLinkedList()
list.insertNode(nodeData: 16)
list.insertNode(nodeData: 13)
list.insertNode(nodeData: 7)
let head = insertNodeAtPosition(llist: list.head, data: 1, position: 2)
// list becomes 16 -> 13 -> 1 -> 7
```

## Interview Framing

- Mention recursion depth vs iterative constant space; either is fine for given constraints.
- Clarify zero-based indexing and how head insertion is handled.***
