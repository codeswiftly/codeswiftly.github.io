@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-k-nearest-friends-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-k-nearest-friends-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-k-nearest-friends-icon.codex", alt: "Placeholder icon")
# Meta Final Coding: K Nearest Friends

@Metadata {
  @TitleHeading("K nearest friends by distance")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-k-nearest-friends-icon.codex", alt: "K nearest friends by distance icon")
  @PageImage(purpose: card, source: "meta-final-coding-k-nearest-friends-card.codex", alt: "K nearest friends by distance card")
}

@Image(source: "meta-final-coding-k-nearest-friends-hero.codex", alt: "Meta Final Coding K Nearest Friends hero")

@Image(source: "meta-final-coding-k-nearest-friends-diagram.codex", alt: "Nearest points to the origin")

## Practice Context

### Problem

Given friend locations (x, y), return the nearest K friends.

### Approach

- Compute squared distances.
- Use a max-heap of size K or sort by distance.
- Return the first K after sorting (O(N log N)) or use a heap (O(N log K)).

Heap visualization:

@Image(source: "meta-final-coding-k-nearest-friends-heap.codex", alt: "Max-heap keeping the k closest points")

### Complexity

- Time: O(N log K) with heap, O(N log N) with sort.
- Space: O(K) for heap.

## Swift Starter

```swift
/// struct FriendLocation {
///   let id: Int
///   let x: Int
///   let y: Int
/// }

func kNearest(_ friends: [FriendLocation], k: Int) -> [FriendLocation] {
  // TODO: Sort by squared distance and return first k.
  return []
}
```

## Swift Solution (Commented, Sort)

```swift
/// struct FriendLocation {
///   let id: Int
///   let x: Int
///   let y: Int
/// }

func kNearest(_ friends: [FriendLocation], k: Int) -> [FriendLocation] {
  friends.sorted { first, second in
    let firstDistance = first.x * first.x + first.y * first.y
    let secondDistance = second.x * second.x + second.y * second.y
    return firstDistance < secondDistance  // Compare squared distances.
  }
  .prefix(k)
  .map { $0 }
}
```

## Related Patterns

- <doc:top-15-patterns>
