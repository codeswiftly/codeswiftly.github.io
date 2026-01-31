
@PageImage(purpose: card, source: "platforms-hackerrank-hackerrank-insertion-sort-part-2-card.codex", alt: "Placeholder card")
@Image(source: "platforms-hackerrank-hackerrank-insertion-sort-part-2-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-hackerrank-hackerrank-insertion-sort-part-2-icon.codex", alt: "Placeholder icon")
# HackerRank -- Insertion Sort (Part 2)

@Metadata {
  @TitleHeading("Review HackerRank -- Insertion Sort (Part 2)")
  @PageImage(purpose: icon, source: "difficulty-easy.codex", alt: "Easy problem")
  @PageImage(purpose: card, source: "hackerrank-insertion-sort-part-2-card.codex", alt: "HackerRank Insertion Sort (Part 2) card")
}

@Image(source: "hackerrank-insertion-sort-part-2-hero.codex", alt: "HackerRank Insertion Sort (Part 2) hero")

## Problem Restatement

Given an array, perform insertion sort and print the array after each insertion step. Start printing
after placing the second element (the first element alone is already sorted).

## Core Ideas

- Treat the subarray `0...i-1` as sorted; place `arr[i]` into it by shifting larger elements right.
- Print after each insertion so the trace shows the algorithm’s progress.
- Stability comes for free with the standard insertion logic.

## Constraints and Complexity

- Small `n` in HackerRank; duplicates allowed.
- Time: `O(n^2)` (worst case descending). Space: `O(1)` extra.

## Edge Cases

- Already sorted input still prints `n-1` identical lines.
- Single element: no output (loop starts at index 1).
- All equal values: shifts are skipped, prints unchanged arrays.

## Swift Notes

- Use clear names (`valueToInsert`, `scanIndex`) to avoid off-by-one errors.
- Print with `joined(separator: " ")` after each insertion.

## Swift Solution

```swift
import Foundation

func insertionSort2(count: Int, values: [Int]) {
  var array = values
  guard array.count > 1 else { return }

  for insertionIndex in 1..<array.count {
    let valueToInsert = array[insertionIndex]
    var scanIndex = insertionIndex - 1

    while scanIndex >= 0 && array[scanIndex] > valueToInsert {
      array[scanIndex + 1] = array[scanIndex]
      scanIndex -= 1
    }

    array[scanIndex + 1] = valueToInsert
    print(array.map(String.init).joined(separator: " "))
  }
}

// Input parsing for HackerRank harness
let numberOfValues = Int((readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
let values = (readLine() ?? "").split(separator: " ").compactMap { Int($0) }
insertionSort2(count: numberOfValues, values: values)
```

## Quick Trace

Input: `n = 7`, `arr = 3 4 7 5 6 2 1`

```
3 4 7 5 6 2 1
3 4 7 5 6 2 1
3 4 5 7 6 2 1
3 4 5 6 7 2 1
2 3 4 5 6 7 1
1 2 3 4 5 6 7
```

## Interview Framing

- Call out stability and why insertion is good for nearly-sorted arrays.
- Mention that each insertion prints once; no printing during inner shifts.
- Note the quadratic worst case vs. linear best case on sorted inputs.***
