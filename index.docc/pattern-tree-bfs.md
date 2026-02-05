# Pattern 10: Binary Tree BFS

@Image(source: "pattern-tree-bfs-hero.codex", alt: "Placeholder hero")

@Metadata {
  @TitleHeading("Practice Binary Tree BFS")
  @PageImage(purpose: icon, source: "pattern-tree-bfs-icon.codex", alt: "Pattern 10: Binary Tree BFS icon")
  @PageImage(purpose: card, source: "pattern-tree-bfs-card.codex", alt: "Pattern 10: Binary Tree BFS card")
}

@Image(source: "tree-bfs-diagram.codex", alt: "Level by level traversal")

Use a queue to visit nodes level-by-level, often to find the shortest path in a tree or to process nodes by depth.

## Problem

- Level-based tree queries such as depth or visible nodes.

## Solution

- Use a queue and process one level at a time.

## Concept

Breadth-First Search (BFS) explores all neighbors at the current depth before moving to the next level.

- **Queue**: Holds nodes to be visited.
- **Level Size**: Loop `queue.count` times to process exactly one level.

## Complexity

- **Time**: O(N). Every node is enqueued and dequeued exactly once.
- **Space**: O(N/2) = O(N) (width of the tree) in the worst case (full binary tree).

## When to Use

- **Level Order Traversal**: Printing or processing levels.
- **Tree Depth**: Finding min/max depth.
- **Visible Nodes**: Right/Left view of a binary tree.

## Examples

### 1. Binary Tree Level Order Traversal

Return the level order traversal of its nodes' values.

```swift
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  guard let root = root else { return [] }
  var result = [[Int]]()
  var queue = [root]

  while !queue.isEmpty {
    var levelValues = [Int]()
    let levelSize = queue.count

    for _ in 0..<levelSize {
      let node = queue.removeFirst()
      levelValues.append(node.val)

      if let left = node.left { queue.append(left) }
      if let right = node.right { queue.append(right) }
    }
    result.append(levelValues)
  }
  return result
}
```

### 2. Binary Tree Right Side View

Visible nodes when looking from the right side.

```swift
func rightSideView(_ root: TreeNode?) -> [Int] {
  guard let root = root else { return [] }
  var result = [Int]()
  var queue = [root]

  while !queue.isEmpty {
    let levelSize = queue.count
    for i in 0..<levelSize {
      let node = queue.removeFirst()
      // If it's the last node in the current level, add to result
      if i == levelSize - 1 {
        result.append(node.val)
      }

      if let left = node.left { queue.append(left) }
      if let right = node.right { queue.append(right) }
    }
  }
  return result
}
```

## Common Pitfalls

- **Queue Performance**: Standard Swift `Array` `removeFirst()` is O(N). For optimal O(1) dequeue, use `Deque` from `swift-collections` or manage an index pointer. In interviews, mentioning `Array` performance cost is crucial.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:swift-tree-basics>
- <doc:leetcode-1372-longest-zigzag-path>
}

## See Also

- <doc:top-15-patterns>
