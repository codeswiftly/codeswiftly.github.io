# LeetCode 200: Number of Islands

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-200-number-of-islands-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-200-number-of-islands-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-200-number-of-islands-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-200-number-of-islands-dsa-icon.codex", alt: "Medium problem - Pattern 11 (DFS)")
  @PageImage(purpose: card, source: "leetcode-200-number-of-islands-dsa-card.codex", alt: "Medium problem - Pattern 11 (DFS)")
}

@Image(source: "leetcode-200-number-of-islands-dsa-hero.codex", alt: "Medium problem - Pattern 11 (DFS)")

Given an `m x n` grid of '1's (land) and '0's (water), count the number of islands (4-directionally connected land).

@Image(source: "leetcode-200-number-of-islands-dsa-top.codex", alt: "Medium problem - Pattern 11 (DFS)")

Solve Medium problem.

Given an `m x n` grid of '1's (land) and '0's (water), count the number of islands (4-directionally
connected land).

## Core Ideas

- DFS/BFS flood fill marking visited cells.
- Alternatively use Union-Find.

## Constraints and Complexity

- `m, n <= 300`.
- Time `O(mn)`, space `O(mn)` for visited recursion or queue.

## Edge Cases

- All water.
- Single cell islands.

## Swift Starter

```swift
class Solution {
  func numIslands(_ grid: [[Character]]) -> Int {
    // TODO: DFS/BFS flood fill each unvisited land cell.
    return 0
  }
}
```

## Swift Solution (Commented, DFS)

```swift
class Solution {
  func numIslands(_ grid: [[Character]]) -> Int {
    var grid = grid
    let rows = grid.count
    let cols = grid.first?.count ?? 0
    guard rows > 0, cols > 0 else { return 0 }
    var count = 0
    func dfs(_ r: Int, _ c: Int) {
      guard r >= 0, c >= 0, r < rows, c < cols, grid[r][c] == "1" else { return }
      grid[r][c] = "0"  // Mark visited.
      dfs(r + 1, c)
      dfs(r - 1, c)
      dfs(r, c + 1)
      dfs(r, c - 1)
    }
    for r in 0..<rows {
      for c in 0..<cols {
        if grid[r][c] == "1" {
          count += 1  // Found a new island.
          dfs(r, c)  // Flood fill it.
        }
      }
    }
    return count
  }
}
```

## Interview Framing

- Talk about BFS queue using `Deque`.
- Mention concurrency extension: process rows in parallel with actors (careful with shared grid).

## Visualization

![A diagram illustrating the 'number of islands' problem.](number-of-islands.codex.svg)
