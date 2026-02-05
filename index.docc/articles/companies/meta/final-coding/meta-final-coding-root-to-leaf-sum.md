# Meta Final Coding: Sum Root-to-Leaf Numbers

@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-root-to-leaf-sum-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-root-to-leaf-sum-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-root-to-leaf-sum-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Sum of root-to-leaf numbers")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-root-to-leaf-sum-icon.codex", alt: "Sum of root-to-leaf numbers icon")
  @PageImage(purpose: card, source: "meta-final-coding-root-to-leaf-sum-card.codex", alt: "Sum of root-to-leaf numbers card")
}

@Image(source: "meta-final-coding-root-to-leaf-sum-hero.codex", alt: "Meta Final Coding Sum Root to Leaf Numbers hero")

@Image(source: "meta-final-coding-root-to-leaf-sum-diagram.codex", alt: "Root to leaf paths forming numbers")

## Practice Context

### Problem

Given a binary tree where each node is a digit, return the sum of all numbers formed by
root-to-leaf paths.

### Approach

- DFS from the root.
- Carry a running value `current = current * 10 + node.val`.
- When at a leaf, add `current` to the total.

Recursion stack visualization:

@Image(source: "meta-final-coding-root-to-leaf-stack.codex", alt: "Recursion stack building the path value")

### Complexity

- Time: O(N)
- Space: O(H)

## Swift Starter

```swift
func sumNumbers(_ root: TreeNode?) -> Int {
  // TODO: DFS and build the path value as you go.
  return 0
}
```

## Swift Solution (Commented)

```swift
/// final class TreeNode {
///   var val: Int
///   var left: TreeNode?
///   var right: TreeNode?
///
///   init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
///     self.val = val
///     self.left = left
///     self.right = right
///   }
/// }

func sumNumbers(_ root: TreeNode?) -> Int {
  func dfs(_ node: TreeNode?, _ current: Int) -> Int {
    guard let node = node else { return 0 }
    let nextValue = current * 10 + node.val  // Extend the number.
    if node.left == nil && node.right == nil {
      return nextValue  // Leaf reached; emit path number.
    }
    return dfs(node.left, nextValue) + dfs(node.right, nextValue)
  }

  return dfs(root, 0)
}
```

## Related Patterns

- <doc:top-15-patterns>
