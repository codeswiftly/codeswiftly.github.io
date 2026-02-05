# Meta Final Coding: Sum Root-to-Leaf Numbers


@Metadata {
  @TitleHeading("Sum of root-to-leaf numbers")
  @PageColor(blue)
}



## Practice Context

### Problem

Given a binary tree where each node is a digit, return the sum of all numbers formed by
root-to-leaf paths.

### Approach

- DFS from the root.
- Carry a running value `current = current * 10 + node.val`.
- When at a leaf, add `current` to the total.

Recursion stack visualization:


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
