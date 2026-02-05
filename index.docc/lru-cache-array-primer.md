# Lru Cache with An Array (Simple Version)

@Metadata {
  @TitleHeading("Review Lru Cache with an Array (Simple Version)")
}


Sometimes you do not need the full complexity of a dictionary + doubly linked list LRU cache. When
the capacity is small (for example, 16–64 entries), an **array-based** design is often simpler to
reason about and entirely good enough in practice.

This article shows a straightforward LRU cache implemented with:

- A dictionary for key → value lookups.
- An array for recency order (most-recently used to least-recently used).

It trades O(1) updates for O(`capacity`) updates, but keeps the mental model and code very simple.

See also: <doc:lru-cache-primer> for the classic O(1) dictionary + linked-list version.

## Invariants

We maintain three rules:

- `storage: [Key: Value]` contains every key in the cache.
- `order: [Key]` stores keys from **most recently used** (`order.first`) to
  **least recently used** (`order.last`).
- Every key appears at most once in `order`, and every key in `order` exists in `storage`.

With these invariants:

- Eviction is just “remove `order.last` and drop that key from `storage`”.
- Marking a key as most-recently used is “move that key to the front of `order`”.

## Data Structures

```swift
final class ArrayLRUCache<Key: Hashable, Value> {
  private let capacity: Int
  private var storage: [Key: Value] = [:]
  private var order: [Key] = []  // most recent at index 0, least recent at last index

  init(capacity: Int) {
    precondition(capacity > 0, "Capacity must be positive")
    self.capacity = capacity
  }
}
```

This design keeps all cache state in two simple values:

- Dictionary: fast lookups by key.
- Array: explicit, human-readable recency ordering.

## Core Operations

### Get: Look Up and Bump Recency

Steps:

1. Check the dictionary for the value.
2. If missing, return `nil`.
3. If found, move the key to the front of `order`.

```swift
extension ArrayLRUCache {
  func get(_ key: Key) -> Value? {
    guard let value = storage[key] else {
      return nil
    }

    markAsMostRecent(key)
    return value
  }
}
```

### Put: Insert/Update and Enforce Capacity

Steps:

1. If the key already exists:
   - Update the value in `storage`.
   - Move the key to the front of `order`.
2. If the key is new:
   - If at capacity, evict the least recently used key:
     - Remove `order.last`.
     - Remove that key from `storage`.
   - Insert the new key at the front of `order`.
   - Store the value in `storage`.

```swift
extension ArrayLRUCache {
  func put(_ key: Key, _ value: Value) {
    if storage[key] != nil {
      storage[key] = value
      markAsMostRecent(key)
      return
    }

    // New key
    if order.count == capacity, let leastRecentKey = order.last {
      storage.removeValue(forKey: leastRecentKey)
      order.removeLast()
    }

    storage[key] = value
    order.insert(key, at: 0)
  }
}
```

### Helpers: Update Recency

`markAsMostRecent(_:)` removes the key from wherever it appears in `order` and reinserts it at the
front.

```swift
extension ArrayLRUCache {
  private func markAsMostRecent(_ key: Key) {
    guard let index = order.firstIndex(of: key) else {
      return
    }
    if index == 0 {
      return  // already most recent
    }

    order.remove(at: index)
    order.insert(key, at: 0)
  }
}
```

Time complexity:

- `firstIndex(of:)`, `remove(at:)`, and `insert(_:at:)` are all O(`capacity`) in the worst case.
- For small capacities, this is usually acceptable and dramatically simpler than a manual linked
  list.

## When to Use This Design

Use the array-based LRU when:

- Capacity is small and fixed (for example, small in-memory caches, UI-related caches).
- Simplicity and clarity are more important than micro-optimizing constant factors.
- You want to explain the LRU concept quickly in an interview before diving into an O(1) version.

Use the dictionary + linked-list LRU when:

- Capacity or traffic is large and you care about worst-case performance.
- You want to demonstrate mastery of pointer-based data structures and invariants

Having both designs in your toolbox lets you choose the right level of complexity for the problem
you are solving.
