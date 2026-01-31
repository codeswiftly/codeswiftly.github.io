
@PageImage(purpose: card, source: "platforms-hackerrank-hackerrank-detect-cycle-card.codex", alt: "Placeholder card")
@Image(source: "platforms-hackerrank-hackerrank-detect-cycle-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-hackerrank-hackerrank-detect-cycle-icon.codex", alt: "Placeholder icon")
# HackerRank -- Cycle Detection in a Linked List

@Metadata {
  @TitleHeading("Review HackerRank -- Cycle Detection in a Linked List")
  @PageImage(purpose: icon, source: "difficulty-easy.codex", alt: "Easy problem")
  @PageImage(purpose: card, source: "hackerrank-detect-cycle-card.codex", alt: "HackerRank Cycle Detection in a Linked List card")
}

@Image(source: "hackerrank-detect-cycle-hero.codex", alt: "HackerRank Cycle Detection in a Linked List hero")

## Problem Restatement

Determine whether a singly linked list contains a cycle. Return `1` if there is a cycle, otherwise
`0`.

## Core Ideas

- Floyd’s tortoise and hare: move `slow` by 1, `fast` by 2; if they ever meet, there is a cycle.
- If `fast` or `fast.next` becomes `nil`, the list terminates and has no cycle.

## Constraints and Complexity

- Time: `O(n)`.
- Space: `O(1)` (no extra sets/maps).

## Edge Cases

- Empty list (`head == nil`) → no cycle.
- Single node → no cycle unless it self-points (hare/slow will meet).

## Swift Notes

- Use identity comparison (`===`) on nodes (class references) to detect meeting.
- Guard optional chaining when advancing `fast` by two steps.

## Swift Solution

```swift
func hasCycle(head: SinglyLinkedListNode?) -> Bool {
  var slow = head
  var fast = head
  while let first = fast?.next, let second = first.next {
    slow = slow?.next
    fast = second
    if slow === fast {
      return true
    }
  }
  return false
}
```

## Quick Tests

```swift
let a = SinglyLinkedListNode(nodeData: 1)
let b = SinglyLinkedListNode(nodeData: 2)
let c = SinglyLinkedListNode(nodeData: 3)
a.next = b
b.next = c
c.next = b
assert(hasCycle(head: a) == true)

let x = SinglyLinkedListNode(nodeData: 1)
let y = SinglyLinkedListNode(nodeData: 2)
x.next = y
assert(hasCycle(head: x) == false)
```

## Interview Framing

- Mention why identity comparison is needed (same node reference vs equal data).
- Note the alternative set-of-visited approach trades `O(n)` space for simpler reasoning.***
