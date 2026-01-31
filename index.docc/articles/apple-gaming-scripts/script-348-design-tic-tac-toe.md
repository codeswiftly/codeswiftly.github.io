@PageImage(purpose: card, source: "apple-gaming-scripts-script-348-design-tic-tac-toe-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-scripts-script-348-design-tic-tac-toe-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-scripts-script-348-design-tic-tac-toe-icon.codex", alt: "Placeholder icon")
# Script — LeetCode 348: Design Tic‑Tac‑Toe (3:00)

@Metadata {
  @TitleHeading("Script — 348 Design Tic‑Tac‑Toe")
}

@Image(source: "script-348-design-tic-tac-toe-hero.codex", alt: "Script LeetCode 348 Design Tic Tac Toe (3 00) hero")

Duration: 3:00

## Narration

00:00–00:12 Hook — “Design move() in O(1) per call. No scanning the whole board.”

00:12–00:35 API — “TicTacToe(n).move(r,c,player) → winner or 0.”

00:35–01:25 Approach — “Use line counters: rows[n], cols[n], diag, antiDiag. Player 1 adds +1, player 2 adds −1. If any abs==n after a move, winner is that player.”

01:25–02:20 Code beats — updates and checks with a single pass per move.

02:20–02:45 Edges — invalid moves ignored by constraints; n can be large → arrays ok.

02:45–03:00 Wrap — “Same motif as 1275; generalizes to any n.”

## Visual Prompts

Walkthrough article: <doc:leetcode-348-design-tic-tac-toe>

- n×n grid with bar overlays per row/col; diag/antiDiag badges.
- Use doc-apple-gaming-leetcode-348-design-tic-tac-toe-card.svg.
- Mermaid: Diagram source: `Resources/diag-script-348-design-tic-tac-toe-lines.svg`

## Swift Solution

```swift
/// O(1) per move using line counters.
final class TicTacToe {
  private var rowCounts: [Int]
  private var columnCounts: [Int]
  private var mainDiagonalCount = 0
  private var antiDiagonalCount = 0
  private let boardSize: Int

  init(_ n: Int) {
    self.boardSize = n
    self.rowCounts = Array(repeating: 0, count: n)
    self.columnCounts = Array(repeating: 0, count: n)
  }

  /// Returns 0 (no winner) or the player (1 or 2) that just won.
  func move(_ rowIndex: Int, _ columnIndex: Int, _ player: Int) -> Int {
    let playerDelta = (player == 1) ? 1 : -1
    rowCounts[rowIndex] += playerDelta
    columnCounts[columnIndex] += playerDelta
    if rowIndex == columnIndex { mainDiagonalCount += playerDelta }
    if rowIndex + columnIndex == boardSize - 1 { antiDiagonalCount += playerDelta }

    if abs(rowCounts[rowIndex]) == boardSize || abs(columnCounts[columnIndex]) == boardSize
      || abs(mainDiagonalCount) == boardSize || abs(antiDiagonalCount) == boardSize
    {
      return player
    }
    return 0
  }
}
```

Notes

- Player deltas (+1/−1) let a single counter trip to ±n to detect a win.
- No board needed; indexes are 0‑based as in LeetCode.
