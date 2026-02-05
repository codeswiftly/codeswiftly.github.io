# LeetCode 1372: Longest Zigzag Path in a Binary Tree

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-1372-longest-zigzag-path-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-1372-longest-zigzag-path-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-1372-longest-zigzag-path-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-1372-longest-zigzag-path-dsa-icon.codex", alt: "Medium problem - Pattern 10 (Tree BFS)")
  @PageImage(purpose: card, source: "leetcode-1372-longest-zigzag-path-dsa-card.codex", alt: "Medium problem - Pattern 10 (Tree BFS)")
}

@Image(source: "leetcode-1372-longest-zigzag-path-dsa-hero.codex", alt: "Medium problem - Pattern 10 (Tree BFS)")

Given the root of a binary tree, return the length (number of edges) of the longest path such that adjacent edges alternate between going left and right. Paths can start at any node and move only downward.

@Image(source: "leetcode-1372-longest-zigzag-path-dsa-top.codex", alt: "Medium problem - Pattern 10 (Tree BFS)")

Solve Medium problem.

Given the root of a binary tree, return the length (number of edges) of the longest path such that
adjacent edges alternate between going left and right. Paths can start at any node and move only
downward.

## Core Ideas

- DFS that keeps track of direction of the previous step (`left` vs `right`).
- At each node, recursively compute zigzag length if you go left next vs right next.
- Reset length to 1 whenever you continue in the same direction.

## Constraints and Complexity

- `1 <= nodes <= 5 * 10^4`.
- Time: `O(n)` visiting each node once.
- Space: `O(h)` recursion stack (`h` tree height).

## Edge Cases

- Single node tree → answer `0`.
- Skewed tree (all left or right) → best length `1`.
- Multiple equal-length ZigZags → still return max.

## Swift Notes

- Represent nodes via the provided `TreeNode` class.
- Use recursion with tuple returns or update a shared `maxLength`.
- Avoid global state by passing a mutable reference (`inout Int`) or returning best length.

## Swift Starter

```swift
class Solution {
  func longestZigZag(_ root: TreeNode?) -> Int {
    // TODO: DFS with direction + length.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func longestZigZag(_ root: TreeNode?) -> Int {
    var best = 0
    func dfs(_ node: TreeNode?, fromLeft: Bool, length: Int) {
      guard let node = node else { return }
      best = max(best, length)  // Track best so far.
      if fromLeft {
        dfs(node.right, fromLeft: false, length: length + 1)
        dfs(node.left, fromLeft: true, length: 1)  // Reset when same direction.
      } else {
        dfs(node.left, fromLeft: true, length: length + 1)
        dfs(node.right, fromLeft: false, length: 1)  // Reset when same direction.
      }
    }
    dfs(root?.left, fromLeft: true, length: 1)
    dfs(root?.right, fromLeft: false, length: 1)
    return best
  }
}
```

## Quick Tests

```swift
// Build simple tree to validate.
```

## Interview Framing

- Explain recursion state: `(node, direction, length)`.
- Mention alternative iterative BFS storing direction.
- Discuss memory: `O(h)` stack; to avoid recursion, use manual stack.
