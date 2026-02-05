# HackerRank -- Queue Using Two Stacks

@PageImage(purpose: card, source: "platforms-hackerrank-hackerrank-queue-using-two-stacks-card.codex", alt: "Placeholder card")
@Image(source: "platforms-hackerrank-hackerrank-queue-using-two-stacks-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-hackerrank-hackerrank-queue-using-two-stacks-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review HackerRank -- Queue Using Two Stacks")
  @PageImage(purpose: icon, source: "difficulty-medium.codex", alt: "Medium problem")
  @PageImage(purpose: card, source: "hackerrank-queue-using-two-stacks-card.codex", alt: "HackerRank Queue Using Two Stacks card")
}

@Image(source: "hackerrank-queue-using-two-stacks-hero.codex", alt: "HackerRank Queue Using Two Stacks hero")

## Problem Restatement

Implement a FIFO queue that supports `enqueue`, `dequeue`, and `front` using two LIFO stacks. Process
`q` queries of the forms: `1 x` enqueue `x`; `2` dequeue; `3` print the front element. Valid input
guarantees a front element exists for queries `2` and `3`.

## Core Ideas

- Keep two stacks: `in` for pushes, `out` for pops/peeks.
- When servicing `dequeue`/`front`, move elements from `in` to `out` only if `out` is empty. This
  preserves order and keeps each element moved at most once.
- Amortized `O(1)` per operation; `O(n)` space for stored elements.

## Edge Cases

- Multiple dequeues in a row: `out` drains; refill lazily from `in`.
- Front before any enqueue is not issued per prompt (guaranteed valid).
- Large `q`: rely on amortized cost, avoid shifting arrays.

## Swift Notes

- Use `[Int]` as stacks with `append`/`popLast`.
- The `shift()` helper centralizes the lazy transfer when `out` is empty.

## Swift Solution

```swift
struct TwoStackQueue {
  private var inbox: [Int] = []
  private var outbox: [Int] = []

  mutating func enqueue(_ x: Int) {
    inbox.append(x)
  }

  private mutating func shift() {
    if outbox.isEmpty {
      outbox.append(contentsOf: inbox.reversed())
      inbox.removeAll(keepingCapacity: true)
    }
  }

  mutating func dequeue() {
    shift()
    _ = outbox.popLast()
  }

  mutating func front() -> Int? {
    shift()
    return outbox.last
  }
}

func processQueries(_ queries: [(type: Int, value: Int?)]) -> [Int] {
  var queue = TwoStackQueue()
  var output: [Int] = []

  for query in queries {
    switch query.type {
    case 1:
      if let v = query.value { queue.enqueue(v) }
    case 2:
      queue.dequeue()
    case 3:
      if let v = queue.front() { output.append(v) }
    default:
      break
    }
  }
  return output
}
```

## Quick Tests

```swift
let result = processQueries([
  (1, 42), (2, nil), (1, 14), (3, nil), (1, 28), (3, nil),
  (1, 60), (1, 78), (2, nil), (2, nil),
])
assert(result == [14, 14])
```

## Interview Framing

- Highlight the lazy transfer as the key to amortized `O(1)` time.
- Note that worst-case single operation is `O(n)` when refilling, but each element moves once.
- Mention thread-safety considerations in production (locking or actors) if asked.
