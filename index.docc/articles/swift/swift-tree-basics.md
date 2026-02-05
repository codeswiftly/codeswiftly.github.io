# Tree Basics and Traversals

@PageImage(purpose: card, source: "swift-swift-tree-basics-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-tree-basics-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-tree-basics-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review Tree Basics and Traversals")
  @PageImage(purpose: icon, source: "swift-tree-basics.codex", alt: "Tree basics icon")
  @PageImage(purpose: card, source: "swift-tree-basics-card.codex", alt: "Tree basics card")
}

@Image(source: "swift-tree-basics-hero.codex", alt: "Tree Basics and Traversals hero")

## Simple Binary Tree Node

```swift
final class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?

  init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
    self.val = val
    self.left = left
    self.right = right
  }
}
```

## Traversals

- Preorder (NLR): visit node, then left, then right.
- Inorder (LNR): visit left, then node, then right (BST yields sorted order).
- Postorder (LRN): visit left, then right, then node.
- Level order (BFS): queue by levels.
- Concurrency tip: tree traversals parallelize by spawning tasks per subtree (post-order). Use task
  groups or actors for thread-safe aggregation; limit depth to avoid oversubscription.

## Left-side Visible Nodes (Count Levels)

- From the left, exactly one node per depth is visible → answer = number of levels.
- **BFS**: level-order; for each level processed, increment count by 1.

```swift
func visibleNodes(_ root: TreeNode?) -> Int {
  guard let root = root else { return 0 }
  var queue: [TreeNode] = [root]
  var visible = 0
  while !queue.isEmpty {
    let levelCount = queue.count
    visible += 1
    for _ in 0..<levelCount {
      let node = queue.removeFirst()
      if let l = node.left { queue.append(l) }
      if let r = node.right { queue.append(r) }
    }
  }
  return visible
}
```

- **DFS**: preorder left-first; track maxDepthSeen; when `depth > maxDepthSeen`, increment visible.

```swift
func visibleNodesDFS(_ root: TreeNode?) -> Int {
  var visible = 0
  var maxDepth = -1
  func walk(_ node: TreeNode?, depth: Int) {
    guard let node = node else { return }
    if depth > maxDepth {
      visible += 1
      maxDepth = depth
    }
    walk(node.left, depth: depth + 1)
    walk(node.right, depth: depth + 1)
  }
  walk(root, depth: 0)
  return visible
}
```

### DFS Recursive

```swift
func preorder(_ root: TreeNode?) -> [Int] {
  guard let node = root else { return [] }
  return [node.val] + preorder(node.left) + preorder(node.right)
}

func inorder(_ root: TreeNode?) -> [Int] {
  guard let node = root else { return [] }
  return inorder(node.left) + [node.val] + inorder(node.right)
}

func postorder(_ root: TreeNode?) -> [Int] {
  guard let node = root else { return [] }
  return postorder(node.left) + postorder(node.right) + [node.val]
}
```

### DFS Iterative (Preorder Example)

```swift
func preorderIterative(_ root: TreeNode?) -> [Int] {
  guard let root = root else { return [] }
  var stack: [TreeNode] = [root]
  var result: [Int] = []
  while let node = stack.popLast() {
    result.append(node.val)
    if let right = node.right { stack.append(right) }
    if let left = node.left { stack.append(left) }
  }
  return result
}
```

### BFS (Level Order)

```swift
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  guard let root = root else { return [] }
  var queue: [TreeNode] = [root]
  var levels: [[Int]] = []
  while !queue.isEmpty {
    let count = queue.count
    var level: [Int] = []
    for _ in 0..<count {
      let node = queue.removeFirst()
      level.append(node.val)
      if let l = node.left { queue.append(l) }
      if let r = node.right { queue.append(r) }
    }
    levels.append(level)
  }
  return levels
}
```

## Rotations (AVL/Red-Black Intuition)

- Rotations rebalance a BST locally without changing inorder sequence.
- **Right rotation** pivots on `y.left` (x); **left rotation** pivots on `y.right` (x).
- Use when height/black-height skews; updates affect parent links.

```swift
// Right rotation around y (y.left = x).
func rotateRight(_ y: TreeNode?) -> TreeNode? {
  guard let y, let x = y.left else { return y }
  let temp = x.right  // will become y.left
  x.right = y  // x becomes new root of this subtree
  y.left = temp  // move subtree to y.left
  return x
}

// Left rotation around y (y.right = x).
func rotateLeft(_ y: TreeNode?) -> TreeNode? {
  guard let y, let x = y.right else { return y }
  let temp = x.left  // will become y.right
  x.left = y  // x becomes new root of this subtree
  y.right = temp  // move subtree to y.right
  return x
}
```

Keep parent updates in the caller; rotations are O(1) and preserve inorder order.

## Operations

- Insert/search in BST: compare to `val`, recurse/iterate left/right.
- Height/size: compute recursively; beware O(n²) if naive on skewed trees.
- Balance factor: use postorder to compute heights.

## BST Insertion (Interview-friendly)

- Prefer explicit `left`/`right` properties (over array child slots) for clarity in interviews.
- Iterative insert avoids recursion depth issues; place duplicates consistently (left in this example).

```swift
func insert(_ root: TreeNode?, _ value: Int) -> TreeNode? {
  guard let root else { return TreeNode(value) }

  var current: TreeNode? = root
  while let node = current {
    if value <= node.val {  // duplicates go left
      guard let left = node.left else {
        node.left = TreeNode(value)
        break
      }
      current = left
    } else {
      guard let right = node.right else {
        node.right = TreeNode(value)
        break
      }
      current = right
    }
  }
  return root
}
```

Why this shape:

- Readable field names (`left`/`right`) make it easy to narrate invariants and pointer moves.
- No hidden index bookkeeping; fewer off-by-one or nil/array-size edge cases to explain.
- Easy to switch to recursion if depth is small; stick to iterative for worst-case skewed trees.

### Variant: Enum-driven Decision (with Associated Child)

Centralize the duplicate policy and next step in an enum that can carry the child node to descend:

```swift
extension TreeNode {
  enum InsertDecision {
    case descend(TreeNode)
    case attachLeft
    case attachRight
  }

  func decision(for value: Int) -> InsertDecision {
    guard value <= val else {
      if let right { return .descend(right) }
      return .attachRight
    }
    if let left { return .descend(left) }
    return .attachLeft
  }
}

func insertWithDecision(_ root: TreeNode?, _ value: Int) -> TreeNode? {
  guard let root else { return TreeNode(value) }
  var node: TreeNode? = root

  while let current = node {
    switch current.decision(for: value) {
    case .descend(let child):
      node = child
    case .attachLeft:
      current.left = TreeNode(value)
      return root
    case .attachRight:
      current.right = TreeNode(value)
      return root
    }
  }
  return root
}
```

This keeps the insert loop small and makes the duplicate side choice explicit (`value <= val` → left).

## Swift Notes

- Class-based nodes are reference types; no CoW. Be mindful of sharing.
- Iterative BFS with `removeFirst()` is O(n²); prefer a rolling-head queue (array + head index) to
  keep amortized O(1) dequeues.
- Tail recursion is not optimized; deep trees risk stack overflow—use iterative when depth can be
  large.
