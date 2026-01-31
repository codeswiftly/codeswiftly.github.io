
@Image(source: "pattern-depth-first-search-hero.codex", alt: "Placeholder hero")
# Pattern 11: Depth-First Search

@Metadata {
  @TitleHeading("Practice Depth-First Search")
  @PageImage(purpose: icon, source: "pattern-depth-first-search-icon.codex", alt: "Pattern 11: Depth-First Search icon")
  @PageImage(purpose: card, source: "pattern-depth-first-search-card.codex", alt: "Pattern 11: Depth-First Search card")
}

@Image(source: "depth-first-search-diagram.codex", alt: "DFS exploration path")

Explore as far as possible along each branch before backtracking.

## Problem

- Traverse all paths or components in a tree or graph.

## Solution

- Recurse depth-first and track `visited` for graphs.

## Concept

- **Stack / Recursion**: Uses the call stack or an explicit stack.
- **Backtracking**: When a leaf or dead-end is reached, go back to the previous node to explore other paths.
- **Visited Set**: Essential for graphs to avoid infinite loops.

## Complexity

- **Time**: O(N + E) for graphs, O(N) for trees.
- **Space**: O(H) (height of tree) or O(N) (graph visited set).

## When to Use

- **Path Finding**: Does a path exist? (Maze, Graph connection).
- **Tree Properties**: Max depth, Path Sum, LCA.
- **Cycles**: Detecting cycles in a graph.

## Examples

### 1. Max Area of Island

Find the largest group of connected 1s.

```swift
func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
  var grid = grid  // Mutable copy
  var maxArea = 0
  let rows = grid.count
  let cols = grid[0].count

  func dfs(_ r: Int, _ c: Int) -> Int {
    if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
      return 0
    }
    grid[r][c] = 0  // Mark as visited
    return 1 + dfs(r + 1, c) + dfs(r - 1, c) + dfs(r, c + 1) + dfs(r, c - 1)
  }

  for r in 0..<rows {
    for c in 0..<cols {
      if grid[r][c] == 1 {
        maxArea = max(maxArea, dfs(r, c))
      }
    }
  }
  return maxArea
}
```

### 2. Path Sum

Determine if the tree has a root-to-leaf path summing to targetSum.

```swift
func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
  guard let root = root else { return false }

  if root.left == nil && root.right == nil {
    return root.val == targetSum
  }

  return hasPathSum(root.left, targetSum - root.val) || hasPathSum(root.right, targetSum - root.val)
}
```

## Common Pitfalls

- **Stack Overflow**: Deep recursion on large graphs/trees can crash. Use iterative DFS with a stack if depth is an issue.
- **Visited**: Forgetting to mark nodes visited (or unmark for backtracking) is a common bug.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-200-number-of-islands>
- <doc:leetcode-1372-longest-zigzag-path>
- <doc:leetcode-241-different-ways-to-add-parentheses>
}

## See Also

- <doc:top-15-patterns>
