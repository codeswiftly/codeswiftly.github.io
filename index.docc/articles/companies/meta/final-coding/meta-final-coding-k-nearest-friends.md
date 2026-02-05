# Meta Final Coding: K Nearest Friends


@Metadata {
  @TitleHeading("K nearest friends by distance")
  @PageColor(blue)
}



## Practice Context

### Problem

Given friend locations (x, y), return the nearest K friends.

### Approach

- Compute squared distances.
- Use a max-heap of size K or sort by distance.
- Return the first K after sorting (O(N log N)) or use a heap (O(N log K)).

Heap visualization:


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
