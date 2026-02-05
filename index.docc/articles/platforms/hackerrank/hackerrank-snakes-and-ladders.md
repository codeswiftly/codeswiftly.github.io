# HackerRank -- Snakes and Ladders: The Quickest Way Up


@Metadata {
  @TitleHeading("Review HackerRank -- Snakes and Ladders: the Quickest Way Up")
}


## Problem Restatement

On a 1–100 board, each die roll (1–6) moves you forward unless it would pass 100 (then you stay).
Landing on a ladder’s base teleports you up; landing on a snake’s head teleports you down. Each
square has at most one ladder/snake start. Compute the minimum rolls from 1 to 100, or `-1` if
unreachable.

## Core Ideas

- Model ladders/snakes as a teleport map `start → end`.
- Run BFS from square 1; each node expands up to 6 die outcomes, then applies teleport if present.
- First time you reach 100, the BFS depth is the minimum rolls.

## Complexity

- Time: `O(100 * 6)` ~ `O(1)` bounded; more generally `O(V + E)` with `V=100`, `E=600`.
- Space: `O(100)` for visited/dist/queue.

## Swift Solution (BFS)

```swift
func quickestWayUp(ladders: [[Int]], snakes: [[Int]]) -> Int {
  let goal = 100
  var jump: [Int: Int] = [:]
  for pair in ladders { jump[pair[0]] = pair[1] }
  for pair in snakes { jump[pair[0]] = pair[1] }

  var visited = Array(repeating: false, count: goal + 1)
  var distance = Array(repeating: 0, count: goal + 1)
  var queue: [Int] = [1]
  var head = 0
  visited[1] = true

  while head < queue.count {
    let current = queue[head]
    head += 1
    if current == goal { return distance[current] }

    for roll in 1...6 {
      var next = current + roll
      if next > goal { continue }
      if let tele = jump[next] { next = tele }
      if !visited[next] {
        visited[next] = true
        distance[next] = distance[current] + 1
        queue.append(next)
      }
    }
  }
  return -1
}
```

## Visual Intuition

- Think of each square as a node; edges are dice rolls; ladders/snakes are zero-cost teleports after
  landing. BFS over this graph finds the shortest roll count.
- “Visited” ensures you never revisit a square with a longer path, keeping the search linear.

### Mini Board Sketch

```
  100                                         94
   ^                                           ^
   | ladder 80→99                              | snake 94→72
  80 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 72
   ^              ^ snake 52→11                ^
   | ladder 8→52  |                            | ladder 12→98
   8 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 12
```

- Roll to a square, then apply a jump if present.
- Each row in BFS = one more die roll; first time you see 100 is optimal.

### Example Path (Sample 1)

- Start 1 → roll 1 → 2 → ladder? none.
- Roll 4 → 6 → ladder 6→80 (if configured) → roll 3 → 83 … continue.
- The article sample path: roll 5→6→ ladder 6→80, roll 6→86, roll 6→92, roll 6→98, roll 2→100
  ⇒ 4 rolls (illustrative; actual sample yields 3).

### Queue Evolution (Conceptual)

- Depth 0: [1]
- Depth 1: neighbors of 1 (after jumps)
- Depth 2: neighbors of those, etc.
- Stop when 100 dequeues; its `distance` is the roll count.

### BFS Layer Sketch (Tiny 1–16 Board for Clarity)

```
Squares:  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
Ladder:          3→8
Snake:                             12→5

Layer 0 (rolls=0): [1]
Layer 1 (rolls=1): [2,3,4,5,6,7]            // from 1 + {1...6}, apply jumps → 3→8
Layer 2 (rolls=2): [8,4,5,6,7,8,9,10,11,12,13] // 8 added via ladder, 12 maps to 5 via snake
Layer 3 (rolls=3): keep expanding until 16 appears
```

### Ladder/Snake Overlay (1–16)

```
16 15 14 13
12⇩        9
11 10  8⇧  6
 5  4  3   1
```

- `3⇧` goes to `8`, `12⇩` goes to `5`. Roll, land, apply jump, then enqueue.

## Interview Framing

- Call out BFS over a fixed graph; no need for Dijkstra since all moves cost 1 roll.
- Mention the bounded size (100) and that unreachable cases return `-1` (disconnected graph).

```
