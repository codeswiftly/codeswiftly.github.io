@PageImage(purpose: card, source: "platforms-coderpad-coderpad-visible-nodes-card.codex", alt: "Placeholder card")
@Image(source: "platforms-coderpad-coderpad-visible-nodes-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-coderpad-coderpad-visible-nodes-icon.codex", alt: "Placeholder icon")
# CoderPad: Visible Nodes from the Left (Binary Tree)

@Metadata {
  @TitleHeading("Review CoderPad: Visible Nodes from the Left (Binary Tree)")
  @PageImage(purpose: icon, source: "difficulty-medium.codex", alt: "Medium problem")
  @PageImage(purpose: card, source: "coderpad-visible-nodes-card.codex", alt: "CoderPad Visible Nodes from the Left (Binary Tree) card")
}

@Image(source: "coderpad-visible-nodes-hero.codex", alt: "CoderPad Visible Nodes from the Left (Binary Tree) hero")

## Restate

Given a binary tree root, the number of nodes visible from the left equals the number of levels.
From the left, you see the first node at each depth; you only need the count.

## DFS (Preorder Left-first)

```swift
/// final class Node {
///   var value: Int
///   var left: Node?
///   var right: Node?
///   init(_ value: Int, _ left: Node? = nil, _ right: Node? = nil) {
///     self.value = value
///     self.left = left
///     self.right = right
///   }
/// }

func visibleNodes(_ root: Node?) -> Int {
  var visible = 0
  var maxDepth = -1

  func traverse(_ node: Node?, depth: Int) {
    guard let node = node else { return }
    if depth > maxDepth {
      visible += 1
      maxDepth = depth
    }
    traverse(node.left, depth: depth + 1)
    traverse(node.right, depth: depth + 1)
  }

  traverse(root, depth: 0)
  return visible
}
```

## BFS (Level-order)

```swift
func visibleNodesBFS(_ root: Node?) -> Int {
  guard let root = root else { return 0 }
  var queue: [Node] = [root]
  var visible = 0
  while !queue.isEmpty {
    let levelCount = queue.count
    visible += 1  // one visible per level
    for _ in 0..<levelCount {
      let node = queue.removeFirst()
      if let l = node.left { queue.append(l) }
      if let r = node.right { queue.append(r) }
    }
  }
  return visible
}
```

## Complexity

- Time: O(n) for either approach.
- Space: O(width) for BFS queue; O(h) call stack for DFS (worst O(n) on skewed trees).

## What to Say

- “Visible from left = one per depth; I can compute level count by BFS or track first node per
  depth with preorder left-first DFS.”
