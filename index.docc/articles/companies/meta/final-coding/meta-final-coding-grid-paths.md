# Meta Final Coding: Grid Paths


@Metadata {
  @TitleHeading("All paths in an N x N grid")
  @PageColor(blue)
}



## Practice Context

### Problem

Given an N x N grid, you can only move down or right. Return all paths from `[0, 0]` to
`[n - 1, n - 1]` as strings like `DRRD`.

### Approach

- Use backtracking.
- Append `D` or `R` while staying in bounds.
- When reaching the bottom-right, append the path.

### Complexity

- Time: O(C) where C is the number of paths.
- Space: O(N) for recursion depth (plus output).

## Swift Starter

```swift
func allPaths(_ n: Int) -> [String] {
  // TODO: Backtrack using D/R while staying in bounds.
  return []
}
```

## Swift Solution (Commented)

```swift
func allPaths(_ n: Int) -> [String] {
  var results: [String] = []
  var path: [Character] = []

  func dfs(_ row: Int, _ col: Int) {
    if row == n - 1 && col == n - 1 {
      results.append(String(path))  // Reached destination.
      return
    }
    if row < n - 1 {
      path.append("D")
      dfs(row + 1, col)
      path.removeLast()  // Backtrack.
    }
    if col < n - 1 {
      path.append("R")
      dfs(row, col + 1)
      path.removeLast()  // Backtrack.
    }
  }

  dfs(0, 0)
  return results
}
```

## Related Patterns

- <doc:top-15-patterns>
