# Script — LeetCode 52: N‑Queens II (3:00)

@PageImage(purpose: card, source: "apple-gaming-scripts-script-52-n-queens-ii-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-scripts-script-52-n-queens-ii-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-scripts-script-52-n-queens-ii-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Script — 52 N‑Queens II")
}

@Image(source: "script-52-n-queens-ii-hero.codex", alt: "Script LeetCode 52 N Queens II (3 00) hero")

Pattern Focus: Same as 51 but count solutions only; use bitmasks for speed if desired.

Duration: 3:00

## Narration

00:00–00:15 Hook — “How fast can we count placements without constructing boards?”

00:15–00:40 Setup — “Return the number of valid boards for n.”

00:40–01:20 Core idea — “Recurse by row; track occupied columns/diagonals. Increment a counter when r==n. For an extra flourish, compress sets into bitmasks.”

01:20–02:10 Code beats — identical to 51 but accumulate `count += 1` instead of rendering.

02:10–02:40 Complexity — same pruning; optional bitmasks make it very fast.

02:40–03:00 Wrap — “A counting variant — great demonstration of backtracking ergonomics.”

## Visual Prompts

Walkthrough article: <doc:leetcode-52-n-queens-ii>

- Counter overlay ticking up as branches finish.

## Swift Solution (Count Only)

```swift
final class Solution {
  func totalNQueens(_ size: Int) -> Int {
    var usedColumns = Set<Int>()
    var usedMainDiagonals = Set<Int>()
    var usedAntiDiagonals = Set<Int>()
    var solutionCount = 0

    func search(_ row: Int) {
      if row == size {
        solutionCount += 1
        return
      }
      for column in 0..<size
      where !usedColumns.contains(column)
        && !usedMainDiagonals.contains(row - column)
        && !usedAntiDiagonals.contains(row + column)
      {
        usedColumns.insert(column)
        usedMainDiagonals.insert(row - column)
        usedAntiDiagonals.insert(row + column)
        search(row + 1)
        usedColumns.remove(column)
        usedMainDiagonals.remove(row - column)
        usedAntiDiagonals.remove(row + column)
      }
    }
    search(0)
    return solutionCount
  }
}
```

Notes

- Same search as 51; we only increment a counter at leaves.
