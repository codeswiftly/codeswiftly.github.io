# Lru Cache Primer (Dictionary ++ Linked List)

@Metadata {
  @TitleHeading("Review Lru Cache Primer (Dictionary ++ Linked List)")
}


Use this as a mental model and code template for designing a classic **Least Recently Used (LRU)
cache** in Swift using a dictionary and a doubly linked list.

Interviewers love this pattern because it combines:

- Time complexity reasoning (O(1) gets and puts).
- Data-structure composition (hash map + linked list).
- Clear invariants you can state and defend.

## Problem: What An LRU Cache Must Guarantee

An LRU cache stores up to `capacity` key–value pairs and must support:

- `get(key)`:
  - Return the value if the key is present.
  - Mark the entry as **most recently used**.
  - O(1) time.
- `put(key, value)`:
  - Insert or update the value.
  - Mark this key as most recently used.
  - If inserting and the cache is full, **evict the least recently used** key.
  - O(1) time.

Key invariant:

- The cache always knows which item was used least recently, so it can evict it in O(1) time.

## Why a Dictionary Alone Is Not Enough

A Swift dictionary (`[Key: Value]`) gives O(1) average-time lookups and updates, but:

- It **does not track usage order**.
- It **does not let you remove “oldest” in O(1)**; you would need to scan or sort keys.

So we add a second structure whose whole job is ordering.

## Data Structures: Dictionary + Doubly Linked List

We combine:

- **Dictionary**: maps `Key` → `Node` so we can find entries in O(1).
- **Doubly linked list**: stores nodes in **most-recently-used to least-recently-used** order.

Typical layout:

- `head.next` is the **most recently used** item.
- `tail.prev` is the **least recently used** item.

Each node stores:

- `key` – so we can remove the correct entry from the dictionary on eviction.
- `value` – the cached value.
- `prev` and `next` pointers – to move it within the list in O(1).

## Core Operations in Words

### 1. Move a Node to the Front (Mark As Most Recently Used)

We need this for both `get` and `put`:

1. Remove node from its current position (fix its neighbors’ pointers).
2. Insert node right after `head`.

This is O(1) because we already have the node reference.

### 2. Evict the Least Recently Used Node

When we exceed capacity:

1. Look at `tail.prev` (the last real node).
2. Remove that node from the list.
3. Remove its `key` from the dictionary.

Again O(1): `tail.prev` is a direct pointer.

## Swift Implementation Sketch

Below is a minimal, interview-friendly implementation.

```swift
final class LRUCache<Key: Hashable, Value> {
  private final class Node {
    let key: Key
    var value: Value
    var prev: Node?
    var next: Node?

    init(key: Key, value: Value) {
      self.key = key
      self.value = value
    }
  }

  private let capacity: Int
  private var dict: [Key: Node] = [:]
  private let head = Node(key: "HEAD" as! Key, value: "HEAD" as! Value)  // placeholder, see below
  private let tail = Node(key: "TAIL" as! Key, value: "TAIL" as! Value)

  init(capacity: Int) {
    precondition(capacity > 0)
    self.capacity = capacity
    head.next = tail
    tail.prev = head
  }
}
```

In real code, you would avoid abusing generics for sentinels and instead:

- Use `Node<Key, Value>` with an optional `key` for sentinels, or
- Keep `head` and `tail` as separate non-generic node types.

For interview whiteboard code, you can simplify by:

- Using `Int` keys and `Int` values, or
- Storing `key` only on non-sentinel nodes.

Below, we focus on the core list operations (pseudo-ish Swift to keep the idea clear).

```swift
final class LRUCache<Key: Hashable, Value> {
  private final class Node {
    let key: Key
    var value: Value
    var prev: Node?
    var next: Node?

    init(key: Key, value: Value) {
      self.key = key
      self.value = value
    }
  }

  private let capacity: Int
  private var dict: [Key: Node] = [:]
  private let head = NodeSentinel()
  private let tail = NodeSentinel()

  init(capacity: Int) {
    precondition(capacity > 0)
    self.capacity = capacity
    head.next = tail
    tail.prev = head
  }

  func get(_ key: Key) -> Value? {
    guard let node = dict[key] else { return nil }
    moveToFront(node)
    return node.value
  }

  func put(_ key: Key, _ value: Value) {
    if let node = dict[key] {
      node.value = value
      moveToFront(node)
      return
    }

    let node = Node(key: key, value: value)
    dict[key] = node
    insertAtFront(node)

    if dict.count > capacity {
      evictLeastRecentlyUsed()
    }
  }

  private func moveToFront(_ node: Node) {
    remove(node)
    insertAtFront(node)
  }

  private func insertAtFront(_ node: Node) {
    node.next = head.next
    node.prev = head
    head.next?.prev = node
    head.next = node
  }

  private func remove(_ node: Node) {
    node.prev?.next = node.next
    node.next?.prev = node.prev
    node.prev = nil
    node.next = nil
  }

  private func evictLeastRecentlyUsed() {
    guard let lru = tail.prev as? Node, tail.prev !== head else { return }
    remove(lru)
    dict.removeValue(forKey: lru.key)
  }
}
```

In production Swift, you would:

- Make the sentinel nodes their own type or use an enum to avoid forced casts.
- Add tests around edge cases (capacity 1, repeated puts, missing keys).

For interview purposes, the most important part is how you **explain the invariants**:

- Dictionary holds every key in O(1).
- Doubly linked list orders nodes from most recently used (front) to least recently used (back).
- Every `get` and `put` either:
  - Moves a node to the front, or
  - Inserts a new node at the front and possibly evicts from the back.

## How to Present This in An Interview

When asked to design an LRU cache:

1. **Start with requirements** – O(1) get/put, eviction policy is least recently used.
2. **Propose the composition** – dictionary for lookup, doubly linked list for usage order.
3. **Draw the list** – show head/tail sentinels, label front as MRU and back as LRU.
4. **Walk through operations** – narrate how `get` and `put` move nodes and when eviction fires.
5. **Discuss tradeoffs** – LRU is good when recency is a solid predictor of reuse; alternative
   policies (LFU, FIFO) would change the data structure.

Clear reasoning plus a small, correct implementation is usually enough to satisfy this question.
