@PageImage(purpose: card, source: "platforms-leetcode-leetcode-297-serialize-and-deserialize-binary-tree-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-297-serialize-and-deserialize-binary-tree-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-297-serialize-and-deserialize-binary-tree-icon.codex", alt: "Placeholder icon")
# LeetCode 297: Serialize and Deserialize Binary Tree

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-297-serialize-and-deserialize-binary-tree-dsa-icon.codex", alt: "Hard problem - Pattern 11 (DFS)")
  @PageImage(purpose: card, source: "leetcode-297-serialize-and-deserialize-binary-tree-dsa-card.codex", alt: "Hard problem - Pattern 11 (DFS)")
}

@Image(source: "leetcode-297-serialize-and-deserialize-binary-tree-dsa-hero.codex", alt: "Hard problem - Pattern 11 (DFS)")

Serialize a binary tree to a string and restore it back to the same structure.

@Image(source: "leetcode-297-serialize-and-deserialize-binary-tree-dsa-top.codex", alt: "Hard problem - Pattern 11 (DFS)")

Solve Hard problem.

Serialize a binary tree to a string and restore it back to the same structure.

## Core Ideas

- Preorder DFS with null markers.
- Deserialization consumes tokens in the same order.

## Constraints and Complexity

- `n` up to 10^4 nodes.
- Time `O(n)`, space `O(n)`.

## Edge Cases

- Empty tree.
- Single node.

## Swift Starter

```swift
class Codec {
  func serialize(_ root: TreeNode?) -> String {
    // TODO: Preorder + null markers.
    return ""
  }

  func deserialize(_ data: String) -> TreeNode? {
    // TODO: Rebuild in preorder.
    return nil
  }
}
```

## Swift Solution (Commented)

```swift
class Codec {
  func serialize(_ root: TreeNode?) -> String {
    var parts: [String] = []

    func dfs(_ node: TreeNode?) {
      guard let node else {
        parts.append("#")
        return
      }
      parts.append(String(node.val))
      dfs(node.left)
      dfs(node.right)
    }

    dfs(root)
    return parts.joined(separator: ",")
  }

  func deserialize(_ data: String) -> TreeNode? {
    let tokens = data.split(separator: ",").map(String.init)
    var index = 0

    func build() -> TreeNode? {
      guard index < tokens.count else { return nil }
      let value = tokens[index]
      index += 1
      if value == "#" { return nil }
      let node = TreeNode(Int(value)!)
      node.left = build()
      node.right = build()
      return node
    }

    return build()
  }
}
```

## Interview Framing

- Preorder preserves structure when nulls are explicit.
- BFS serialization works too; mention tradeoffs in output size.
