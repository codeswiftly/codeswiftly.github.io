
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-994-rotting-oranges-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-994-rotting-oranges-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-994-rotting-oranges-icon.codex", alt: "Placeholder icon")
# LeetCode 994: Rotting Oranges

@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/rotting-oranges/", label: "Solve on LeetCode")
}

Given an `m x n` grid where `0 = empty`, `1 = fresh`, `2 = rotten`, each minute any fresh orange
adjacent (4-directionally) to a rotten one becomes rotten. Return the minimum minutes until all
fresh oranges are rotten, or `-1` if impossible.

## Core Idea (Multi-source BFS)

- Put all rotten cells into the queue first.
- Each BFS layer = one minute.
- Track `freshCount`; when it reaches 0, you are done.

## Edge Cases

- No fresh oranges → return `0`.
- Fresh oranges but no initial rotten → return `-1`.
- Disconnected fresh regions → return `-1` after BFS ends.

## Swift Starter

```swift
final class Solution {
  func orangesRotting(_ grid: [[Int]]) -> Int {
    // TODO: Multi-source BFS with a queue per minute.
    return -1
  }
}
```

## Swift Solution (Commented, BFS)

```swift
final class Solution {
  func orangesRotting(_ grid: [[Int]]) -> Int {
    var grid = grid
    let rowCount = grid.count
    let columnCount = grid.first?.count ?? 0
    guard rowCount > 0, columnCount > 0 else { return 0 }

    var freshCount = 0
    var queue: [(row: Int, column: Int)] = []

    for rowIndex in 0..<rowCount {
      for columnIndex in 0..<columnCount {
        switch grid[rowIndex][columnIndex] {
        case 1:
          freshCount += 1
        case 2:
          queue.append((row: rowIndex, column: columnIndex))  // Multi-source start.
        default:
          break
        }
      }
    }

    if freshCount == 0 { return 0 }

    let directions = [
      (dx: -1, dy: 0),
      (dx: 1, dy: 0),
      (dx: 0, dy: -1),
      (dx: 0, dy: 1)
    ]

    var queueIndex = 0
    var minutesElapsed = -1

    while queueIndex < queue.count {
      minutesElapsed += 1  // Each BFS layer is one minute.
      let layerCount = queue.count - queueIndex

      for _ in 0..<layerCount {
        let current = queue[queueIndex]
        queueIndex += 1

        for direction in directions {
          let nextRow = current.row + direction.dx
          let nextColumn = current.column + direction.dy

          guard nextRow >= 0,
                nextRow < rowCount,
                nextColumn >= 0,
                nextColumn < columnCount,
                grid[nextRow][nextColumn] == 1
          else { continue }

          grid[nextRow][nextColumn] = 2  // Rot the fresh orange.
          freshCount -= 1
          queue.append((row: nextRow, column: nextColumn))
        }
      }
    }

    return freshCount == 0 ? minutesElapsed : -1
  }
}
```

## Complexity

- Time: `O(mn)` because each cell is processed once.
- Space: `O(mn)` for the queue in the worst case.

## Interview Framing

- Emphasize multi-source BFS: all initial rotten oranges start the wave.
- Each BFS layer equals one minute of time passing.
- Mention early exit when `freshCount` hits 0.
