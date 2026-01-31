@PageImage(purpose: card, source: "apple-gaming-scripts-script-51-n-queens-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-scripts-script-51-n-queens-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-scripts-script-51-n-queens-icon.codex", alt: "Placeholder icon")
# Script — LeetCode 51: N‑Queens (3:00)

@Metadata {
  @TitleHeading("Script — 51 N‑Queens")
}

@Image(source: "script-51-n-queens-hero.codex", alt: "Script LeetCode 51 N Queens (3 00) hero")

Pattern Focus: Backtracking with conflict sets — track used columns and diagonals to prune early.

Duration: 3:00

## Narration

00:00–00:15 Hook — “Place N queens so none attack each other — how to search efficiently?”

00:15–00:40 Setup — “Return all boards for size n.”

00:40–01:30 Core idea — “At row r, try columns c not in usedCols and not on used diag (r‑c) or antiDiag (r+c). Place, recurse to r+1, then remove.”

01:30–02:10 Code beats — maintain `cols: Set<Int>`, `diag: Set<Int>`, `anti: Set<Int>`, and an `positions: [Int]` mapping row→col. When r==n, render to strings.”

02:10–02:35 Complexity — exponential but pruned heavily; typical interview accepts backtracking with sets.

02:35–03:00 Wrap — “Same choose/explore/unchoose, just smarter pruning with three sets.”

## Visual Prompts

Walkthrough article: <doc:leetcode-51-n-queens>

- Chessboard with blocked diagonals highlighted as we place queens.

## Swift Solution (Sets)

```swift
final class Solution {
  func solveNQueens(_ size: Int) -> [[String]] {
    var usedColumns = Set<Int>()
    var usedMainDiagonals = Set<Int>()  // row - column
    var usedAntiDiagonals = Set<Int>()  // row + column
    var columnAtRow = Array(repeating: -1, count: size)
    var solutions: [[String]] = []

    func renderBoard() -> [String] {
      (0..<size).map { row in
        var chars = Array(repeating: ".", count: size)
        chars[columnAtRow[row]] = "Q"
        return chars.joined()
      }
    }

    func search(_ row: Int) {
      if row == size {
        solutions.append(renderBoard())
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
        columnAtRow[row] = column
        search(row + 1)
        usedColumns.remove(column)
        usedMainDiagonals.remove(row - column)
        usedAntiDiagonals.remove(row + column)
      }
    }
    search(0)
    return solutions
  }
}
```

Notes

- Sets make the constraints explicit and easy to reason about; bitmasks are a faster variant.
