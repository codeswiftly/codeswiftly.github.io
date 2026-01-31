@PageImage(purpose: card, source: "platforms-coderpad-coderpad-2048-bonacci-card.codex", alt: "Placeholder card")
@Image(source: "platforms-coderpad-coderpad-2048-bonacci-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-coderpad-coderpad-2048-bonacci-icon.codex", alt: "Placeholder icon")
# CoderPad: 2048-Bonacci

@Metadata {
  @TitleHeading("Review CoderPad: 2048-Bonacci")
  @PageImage(purpose: icon, source: "difficulty-medium.codex", alt: "Medium problem")
  @PageImage(purpose: card, source: "coderpad-2048-bonacci-card.codex", alt: "CoderPad 2048 Bonacci card")
}

@Image(source: "coderpad-2048-bonacci-hero.codex", alt: "CoderPad 2048 Bonacci hero")

## Overview

- 4×4 grid; cells contain Fibonacci numbers or 0 (empty).
- Push in one direction (up/left/down/right); tiles slide, then adjacent consecutive Fibonacci
  numbers fuse into the next Fibonacci number.
- Fusing order resolves from the far end of the push; fused tiles cannot fuse again in the same
  turn.
- Goal: apply one push and return the new grid.

## Rules Recap

1) Move as far as possible in push direction.  
2) Fuse only consecutive Fibonacci numbers (…1,2,3,5,8,13,…), either order.  
3) Resolve fusions from the back of the push direction; a fused tile can’t fuse twice this turn.  
4) Tiles can move into spaces just freed by a fusion.

## Approach

- Normalize by direction: write a `compressAndFuse(line:)` for a single row/column pushed “left”.
- For each push:
  - Extract each line in push order (rows for left/right, columns for up/down).
  - If pushing right/down, reverse the line, process, then reverse back.
  - Replace the line in the grid.
- `compressAndFuse` steps:
  1) Filter out zeros (slide).
  2) Walk the compacted list with index `i`:
     - If `i+1` exists and `isConsecutiveFib(a[i], a[i+1])`, fuse: push nextFib into result;
       `i += 2`.
     - Else push `a[i]`; `i += 1`.
  3) Pad with zeros to length 4.

## Helpers

- `isConsecutiveFib(_ a: Int, _ b: Int) -> Bool`: precompute a map fib → nextFib to test adjacency.
- `nextFib(_ x: Int) -> Int?`: lookup from map.
- Build fib list up to 2^16 per prompt.

## Swift Sketch

```swift
let fibs: [Int] = {
  var f = [1, 1]
  while let last = f.last, last < (1 << 16) {
    let n = f[f.count - 1] + f[f.count - 2]
    if n > (1 << 16) { break }
    f.append(n)
  }
  return f
}()
let nextFib: [Int: Int] = {
  var m: [Int: Int] = [:]
  for i in 0..<(fibs.count - 1) {
    m[fibs[i]] = fibs[i + 1]
  }
  return m
}()

func isConsecutiveFib(_ a: Int, _ b: Int) -> Bool {
  return nextFib[a] == b || nextFib[b] == a
}

func compressAndFuse(_ line: [Int]) -> [Int] {
  var compact = line.filter { $0 != 0 }
  var result: [Int] = []
  var i = 0
  while i < compact.count {
    if i + 1 < compact.count && isConsecutiveFib(compact[i], compact[i + 1]) {
      let fused =
        nextFib[compact[i]] == compact[i + 1]
        ? nextFib[compact[i]]
        : nextFib[compact[i + 1]]
      if let fused { result.append(fused) }
      i += 2
    } else {
      result.append(compact[i])
      i += 1
    }
  }
  while result.count < 4 { result.append(0) }
  return result
}
```

Apply per direction by extracting rows/cols, reversing for right/down, and writing back.

## Edge Cases

- All zeros → unchanged.
- Single tile → slides to edge.
- Chains like [1,2,3] resolve from the far end (rule 3); the leftmost pair fuses last.
- Ensure fused tile doesn’t fuse again this move.

## Complexity

- Per push: process 4 lines of length 4 → O(1) time/space for fixed 4×4; scales as O(n²) for n×n.
