# Meta Final Coding: Set with Count

@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-set-with-count-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-set-with-count-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-set-with-count-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Implement a Set with count")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-set-with-count-icon.codex", alt: "Implement a Set with count icon")
  @PageImage(purpose: card, source: "meta-final-coding-set-with-count-card.codex", alt: "Implement a Set with count card")
}

@Image(source: "meta-final-coding-set-with-count-hero.codex", alt: "Meta Final Coding Set With Count hero")

@Image(source: "meta-final-coding-set-with-count-diagram.codex", alt: "Set operations and count")

## Practice Context

### Problem

Implement a `Set` with `add`, `remove`, and `get` operations. Track the count of elements.

### Approach

- Use a dictionary from key to a boolean (or just store in a `Set`).
- Update `count` on insert/remove.

### Complexity

- Time: O(1) average for each operation.
- Space: O(N)

## Swift Starter

```swift
struct CountedSet<Element: Hashable> {
  private var storage: Set<Element> = []
  private(set) var count: Int = 0

  mutating func add(_ value: Element) {
    // TODO: insert and update count.
  }

  mutating func remove(_ value: Element) {
    // TODO: remove and update count.
  }

  func get(_ value: Element) -> Bool {
    // TODO: membership check.
    return false
  }
}
```

## Swift Solution (Commented)

```swift
struct CountedSet<Element: Hashable> {
  private var storage: Set<Element> = []
  private(set) var count: Int = 0

  mutating func add(_ value: Element) {
    let inserted = storage.insert(value).inserted
    if inserted {
      count += 1  // Count only on new insert.
    }
  }

  mutating func remove(_ value: Element) {
    if storage.remove(value) != nil {
      count -= 1  // Count only when removal succeeds.
    }
  }

  func get(_ value: Element) -> Bool {
    storage.contains(value)  // Membership check.
  }
}
```

## Related Patterns

- <doc:top-15-patterns>
