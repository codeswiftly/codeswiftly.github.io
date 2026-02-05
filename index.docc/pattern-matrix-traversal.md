# Pattern 13: Matrix Traversal


@Metadata {
  @TitleHeading("Practice Matrix Traversal")
}


Treat a 2D grid as a graph where each cell is a node and neighbors (up, down, left, right) are edges.

## Problem

- Traverse grid regions or count connected components.

## Solution

- DFS or BFS over 4-neighbors with bounds checks.

## Concept

- **Coordinates**: `(r, c)` represents a node.
- **Neighbors**: `[(r+1, c), (r-1, c), (r, c+1), (r, c-1)]`.
- **Bounds Check**: Always check `0 <= r < rows` and `0 <= c < cols`.
- **Visited**: Modify the grid in-place (e.g., set to '0' or '#') or use a visited boolean matrix.

## Complexity

- **Time**: O(M * N) where M is rows and N is cols.
- **Space**: O(M * N) for visited array or recursion stack/queue.

## When to Use

- **Islands**: Counting connected components.
- **Shortest Path in Grid**: Minimum steps from A to B (BFS).
- **Enclosed Regions**: Surrounded regions (Go).

## Examples

### 1. Number of Islands

Count connected components of '1's.

```swift
func numIslands(_ grid: [[Character]]) -> Int {
  var grid = grid
  if grid.isEmpty { return 0 }
  let rows = grid.count
  let cols = grid[0].count
  var count = 0

  func dfs(_ r: Int, _ c: Int) {
    if r < 0 || c < 0 || r >= rows || c >= cols || grid[r][c] == "0" {
      return
    }
    grid[r][c] = "0"  // Sink the island
    dfs(r + 1, c)
    dfs(r - 1, c)
    dfs(r, c + 1)
    dfs(r, c - 1)
  }

  for r in 0..<rows {
    for c in 0..<cols {
      if grid[r][c] == "1" {
        count += 1
        dfs(r, c)
      }
    }
  }
  return count
}
```

### 2. Rotting Oranges (BFS)

Determine min time for all oranges to rot.

```swift
func orangesRotting(_ grid: [[Int]]) -> Int {
  var grid = grid
  let rows = grid.count
  let cols = grid[0].count
  var queue = [(Int, Int)]()
  var freshCount = 0

  for r in 0..<rows {
    for c in 0..<cols {
      if grid[r][c] == 2 { queue.append((r, c)) } else if grid[r][c] == 1 { freshCount += 1 }
    }
  }

  if freshCount == 0 { return 0 }
  var minutes = 0
  let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

  while !queue.isEmpty && freshCount > 0 {
    minutes += 1
    for _ in 0..<queue.count {
      let (r, c) = queue.removeFirst()
      for d in dirs {
        let nr = r + d.0
        let nc = c + d.1
        if nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == 1 {
          grid[nr][nc] = 2
          freshCount -= 1
          queue.append((nr, nc))
        }
      }
    }
  }

  return freshCount == 0 ? minutes : -1
}
```

## Common Pitfalls

- **BFS Level Loop**: For shortest path or time propagation, remember the inner loop `for _ in 0..<queue.count`.
- **Direction Arrays**: Use `let dirs = [(0,1), (0,-1), (1,0), (-1,0)]` to cleaner loops.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-200-number-of-islands>
- <doc:leetcode-733-flood-fill>
- <doc:leetcode-529-minesweeper>
}

## See Also

- <doc:top-15-patterns>
