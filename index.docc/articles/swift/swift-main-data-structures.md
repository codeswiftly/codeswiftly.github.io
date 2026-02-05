# Swift Main Data Structures


@Metadata {
  @PageColor(blue)
  @TitleHeading("Swift Main data structures")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Swift’s standard library gives you strong primitives (`Array`, `Dictionary`, `Set`, `String`).
For interview problems, most of your correctness and complexity story comes from using these
correctly.

When the problem needs a structure Swift does not ship (heap/priority queue, deque, queue),
build it on top of these primitives: <doc:custom-data-structures-reference>.

## Quick Links

@Links(visualStyle: detailedGrid) {

- <doc:top-15-patterns>
- <doc:heaps-vs-sorted-arrays>
- <doc:sorted-array-bounds>

}

---

## What You Get in Swift Main

| Type | Use it for | Interview notes |
| --- | --- | --- |
| `Array<Element>` | stacks, windows, two pointers, contiguous storage | `append`/`popLast` amortized O(1); `removeFirst` O(n); inserting/removing in the middle O(n) |
| `Dictionary<Key, Value>` | hash maps, frequency counts, memoization | average O(1) get/set; keys must be `Hashable` |
| `Set<Element>` | membership checks, visited sets | average O(1) contains/insert; elements must be `Hashable` |
| `String` / `Substring` | parsing and tokenizing | `String.Index` is not integer; convert to `[Character]` for index math |
| `Optional<T>` | “present vs missing” state | avoid sentinel values; model absence explicitly |

---

## Costs and Footguns to Memorize

- `Array.removeFirst()` is O(n). Don’t implement queues by shifting the whole buffer.
- `String` is a collection of extended grapheme clusters; `O(1)` integer indexing is not a thing.
- `Dictionary` / `Set` are hash-based; worst-case exists, but interview answers typically use
  average O(1).
- Sorting an array is O(n log n) and usually allocates; call it out when you choose “sort + scan”.

---

## When You Must Implement Your Own Structure

If the problem statement demands:

- “Always return min/max so far” with updates → heap / two heaps (priority queue).
- “Process in arrival order” (BFS) → queue (rolling head index).
- “Push and pop both ends” → deque (ring buffer).
- “O(1) eviction and recency updates” → dictionary + linked list (LRU).


## Topics

### Build Next (Custom Structures)


### Pattern Primers (Using Stdlib)

