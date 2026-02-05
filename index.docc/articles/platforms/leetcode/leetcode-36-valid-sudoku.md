# LeetCode 36: Valid Sudoku




Given a 9x9 board partially filled with digits, determine if it is valid per Sudoku rules (rows, columns, 3x3 boxes contain digits 1-9 without repetition). Empty cells contain '.'.


Solve Medium problem.

Given a 9x9 board partially filled with digits, determine if it is valid per Sudoku rules (rows,
columns, 3x3 boxes contain digits 1-9 without repetition). Empty cells contain '.'.

## Core Ideas

- Use sets/bitmasks for each row, column, and box.

## Constraints

- Board fixed size 9x9.
- Time `O(81)`, space `O(1)` constant.

## Swift Starter

```swift
class Solution {
  func isValidSudoku(_ board: [[Character]]) -> Bool {
    // TODO: Track seen digits per row/col/box.
    return false
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func isValidSudoku(_ board: [[Character]]) -> Bool {
    var rows = Array(repeating: Set<Character>(), count: 9)
    var cols = Array(repeating: Set<Character>(), count: 9)
    var boxes = Array(repeating: Set<Character>(), count: 9)

    for r in 0..<9 {
      for c in 0..<9 {
        let value = board[r][c]
        guard value != "." else { continue }
        if rows[r].contains(value) || cols[c].contains(value) {
          return false  // Duplicate in row/col.
        }
        let boxIndex = (r / 3) * 3 + c / 3
        if boxes[boxIndex].contains(value) {
          return false  // Duplicate in box.
        }
        rows[r].insert(value)
        cols[c].insert(value)
        boxes[boxIndex].insert(value)
      }
    }
    return true
  }
}
```

## Interview Framing

- Mention bitmask optimization.
- Discuss how to adapt for full solver (backtracking).
