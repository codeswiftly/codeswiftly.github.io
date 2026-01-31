# Quick Sort (Swift)

@Metadata {
  @TitleHeading("Review Quick Sort (Swift)")
  @PageImage(purpose: icon, source: "quick-sort-icon.codex", alt: "Quick Sort (Swift) icon")
  @PageImage(purpose: card, source: "quick-sort-card.codex", alt: "Quick Sort (Swift) card")
}

@Image(source: "quick-sort-hero.codex", alt: "Quick Sort (Swift) hero")

## Overview

- Classic divide-and-conquer; average O(n log n) time, O(n log n) stack in naive recursive form.
- Simple functional demo using filter; note extra allocations vs. in-place partition.

## Naive Functional Implementation

```swift
func quickSort(_ arr: [Int]) -> [Int] {
  guard arr.count > 1 else { return arr }
  let pivot = arr[arr.count / 2]
  let less = arr.filter { $0 < pivot }
  let equal = arr.filter { $0 == pivot }
  let greater = arr.filter { $0 > pivot }
  return quickSort(less) + equal + quickSort(greater)
}

print(quickSort([6, 4, 3, 9, 1]))  // [1,3,4,6,9]
```

## In-place Partition Implementation

```swift
func quickSort(_ nums: inout [Int]) {
  guard !nums.isEmpty else { return }
  sort(&nums, low: nums.startIndex, high: nums.index(before: nums.endIndex))
}

private func sort(_ nums: inout [Int], low: Int, high: Int) {
  if low >= high { return }

  let pivotIndex = partition(&nums, low: low, high: high)
  sort(&nums, low: low, high: pivotIndex - 1)  // left partition
  sort(&nums, low: pivotIndex + 1, high: high)  // right partition
}

private func partition(_ nums: inout [Int], low: Int, high: Int) -> Int {
  // Median-of-three pivot to reduce worst-case on sorted/reverse-sorted input.
  let mid = low + (high - low) / 2
  let pivotCandidates = [(nums[low], low), (nums[mid], mid), (nums[high], high)]
    .sorted { $0.0 < $1.0 }
  let pivotIndex = pivotCandidates[1].1
  nums.swapAt(pivotIndex, high)  // pivot now at high

  let pivotValue = nums[high]
  var store = low
  for i in low..<high where nums[i] <= pivotValue {
    nums.swapAt(store, i)
    store += 1
  }
  nums.swapAt(store, high)  // pivot to final place
  return store
}
```

- Call with: `var nums = [6,4,3,9,1]; quickSort(&nums)`
- Average O(n log n) time; extra space is recursion stack (O(log n) average, O(n) worst).
- Tail recursion not optimized in Swift; for very large arrays consider an iterative stack to bound
  depth.

## Interview Notes

- Complexity: average O(n log n), worst O(n²) with bad pivots; space O(n log n) stack + O(n) extra
  arrays here.
- This version is easy to explain but allocates many arrays; acceptable for quick demos/tests.
- In-place variant uses partitioning with indices and reduces extra space; call it out if asked.
- Mention pivot choices and tail recursion vs. stack depth; in production, prefer stdlib `sort()`
  unless asked to implement manually.
