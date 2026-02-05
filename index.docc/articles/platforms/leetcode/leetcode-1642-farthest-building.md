# LeetCode 1642: Farthest Building You Can Reach

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-1642-farthest-building-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-1642-farthest-building-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-1642-farthest-building-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-1642-farthest-building-dsa-icon.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")
  @PageImage(purpose: card, source: "leetcode-1642-farthest-building-dsa-card.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")
}

@Image(source: "leetcode-1642-farthest-building-dsa-hero.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")

Given building heights and limited bricks and ladders, determine the farthest index reachable by climbing sequentially. Use bricks for smaller climbs, ladders for largest climbs.

@Image(source: "leetcode-1642-farthest-building-dsa-top.codex", alt: "Medium problem - Pattern 9 (Top-K Heap)")

Solve Medium problem.

Given building heights and limited bricks and ladders, determine the farthest index reachable by
climbing sequentially. Use bricks for smaller climbs, ladders for largest climbs.

## Core Ideas

- Greedy with min-heap of climbs assigned ladders: iterate heights, push positive climbs into heap;
  when heap size exceeds ladders, spend bricks on smallest climb (pop).

## Constraints and Complexity

- `n <= 10^5`.
- Time `O(n log ladders)` (heap operations), space `O(ladders)`.

## Swift Starter

```swift
class Solution {
  func furthestBuilding(_ heights: [Int], _ bricks: Int, _ ladders: Int) -> Int {
    // TODO: Min-heap climbs, spend bricks on smallest when ladders overflow.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func furthestBuilding(_ heights: [Int], _ bricks: Int, _ ladders: Int) -> Int {
    var bricks = bricks
    var heap = PriorityQueue<Int>(sort: <)  // min-heap
    for i in 0..<heights.count - 1 {
      let climb = heights[i + 1] - heights[i]
      if climb > 0 {
        heap.push(climb)
        if heap.count > ladders {
          if let smallest = heap.pop() {
            bricks -= smallest  // Pay bricks for the smallest ladder climb.
            if bricks < 0 { return i }
          }
        }
      }
    }
    return heights.count - 1
  }
}
```

## Interview Framing

- Explain intuition: ladders best for largest climbs.
- Mention binary search on answer + resource simulation variant.
