# Meta Final Coding: Deep Copy Friends Graph


@Metadata {
  @TitleHeading("Deep copy a Friend graph")
  @PageColor(blue)
}



## Practice Context

### Problem

You are given an array of `Friend` objects, each with `id`, `name`, and a list of other friends.
Return a deep copy of the structure.

### Approach

- Treat the structure as a graph (it can contain cycles).
- Use DFS or BFS with a dictionary that maps original nodes to their clones.
- Reuse the clone if a node was already copied.

### Complexity

- Time: O(V + E)
- Space: O(V)

## Swift Starter

```swift
// Friend is provided by the prompt.
func cloneFriends(_ friends: [Friend]) -> [Friend] {
  // TODO: Deep copy with a visited map to avoid cycles.
  return []
}
```

## Swift Solution (Commented)

```swift
/// final class Friend {
///   var id: Int
///   var name: String
///   var friends: [Friend]
///
///   init(id: Int, name: String, friends: [Friend] = []) {
///     self.id = id
///     self.name = name
///     self.friends = friends
///   }
/// }

func cloneFriends(_ friends: [Friend]) -> [Friend] {
  var visited = [ObjectIdentifier: Friend]()

  func clone(_ node: Friend) -> Friend {
    let key = ObjectIdentifier(node)
    if let cached = visited[key] { return cached }  // Reuse existing copy.

    let copy = Friend(id: node.id, name: node.name)  // Copy fields.
    visited[key] = copy
    copy.friends = node.friends.map { clone($0) }  // Clone edges.
    return copy
  }

  return friends.map { clone($0) }
}
```

## Related Patterns

- <doc:top-15-patterns>
