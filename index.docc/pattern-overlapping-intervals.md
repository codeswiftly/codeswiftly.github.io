# Pattern 04: Overlapping Intervals

@Image(source: "pattern-overlapping-intervals-hero.codex", alt: "Placeholder hero")

@Metadata {
  @TitleHeading("Practice Overlapping Intervals")
  @PageImage(purpose: icon, source: "pattern-overlapping-intervals-icon.codex", alt: "Pattern 04: Overlapping Intervals icon")
  @PageImage(purpose: card, source: "pattern-overlapping-intervals-card.codex", alt: "Pattern 04: Overlapping Intervals card")
}

@Image(source: "overlapping-intervals-diagram.codex", alt: "Merging overlapping intervals")

Manage time blocks or ranges by sorting them to efficiently merge, count, or schedule overlapping events.

## Problem

- Merge or schedule overlapping time ranges.

## Solution

- Sort by start time and merge in a single pass.

## Concept

Wh  dealing with ranges `[start, end]`:

1. **Sort** by start time. This allows you to process intervals in linear order.
2. **Compare** the current interval's `start` with the previous interval's `end`.
3. **Merge** if they overlap (`current.start <= previous.end`).

## Complexity

- **Time**: O(N log N) dominated by the sorting step. The merge pass is O(N).
- **Space**: O(N) to store the sorted or output array.

## When to Use

- **Scheduling**: Finding free time slots or minimum meeting rooms required.
- **Data Merging**: Consolidating file writes or memory ranges.

## Examples

### 1. Merge Intervals

Given an array of intervals, merge all overlapping intervals.

@Image(source: "overlapping-intervals-merge-example.codex", alt: "Overlapping intervals merge before and after")

```swift
func merge(_ intervals: [[Int]]) -> [[Int]] {
  guard !intervals.isEmpty else { return [] }
  // O(N log N) sort
  let sortedIntervals = intervals.sorted { $0[0] < $1[0] }

  var merged = [sortedIntervals[0]]

  for interval in sortedIntervals.dropFirst() {
    let lastMergedIndex = merged.count - 1
    let currentStart = interval[0]
    let currentEnd = interval[1]
    let previousEnd = merged[lastMergedIndex][1]

    if currentStart <= previousEnd {
      // Overlap: Merge by extending the end time
      merged[lastMergedIndex][1] = max(previousEnd, currentEnd)
    } else {
      // No overlap: Add as new interval
      merged.append(interval)
    }
  }

  return merged
}
```

### 2. Insert Interval

Insert a new interval into a sorted list of non-overlapping intervals and merge if necessary.

@Image(source: "overlapping-intervals-insert-example.codex", alt: "Insert interval and merge result")

```swift
func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
  var result = [[Int]]()
  var i = 0
  let n = intervals.count
  var newStart = newInterval[0]
  var newEnd = newInterval[1]

  // Add all intervals ending before newInterval starts
  while i < n && intervals[i][1] < newStart {
    result.append(intervals[i])
    i += 1
  }

  // Merge all overlapping intervals
  while i < n && intervals[i][0] <= newEnd {
    newStart = min(newStart, intervals[i][0])
    newEnd = max(newEnd, intervals[i][1])
    i += 1
  }
  result.append([newStart, newEnd])

  // Add remaining intervals
  while i < n {
    result.append(intervals[i])
    i += 1
  }

  return result
}
```

## Common Pitfalls

- **Sorting**: Forgetting to sort is the most common mistake.
- **Edge Cases**: Intervals touching at the boundary (e.g., `[1,2]` and `[2,3]`). Usually considered overlapping.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-354-russian-doll-envelopes>
- <doc:leetcode-1691-maximum-height-by-stacking-cuboids>
}

## See Also

- <doc:top-15-patterns>
