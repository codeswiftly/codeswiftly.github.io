@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-grid-paths-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-grid-paths-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-grid-paths-icon.codex", alt: "Placeholder icon")
# Meta Final Coding: Grid Paths

@Metadata {
  @TitleHeading("All paths in an N x N grid")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-grid-paths-icon.codex", alt: "All paths in an N x N grid icon")
  @PageImage(purpose: card, source: "meta-final-coding-grid-paths-card.codex", alt: "All paths in an N x N grid card")
}

@Image(source: "meta-final-coding-grid-paths-hero.codex", alt: "Meta Final Coding Grid Paths hero")

@Image(source: "meta-final-coding-grid-paths-diagram.codex", alt: "Grid paths using D and R steps")

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
