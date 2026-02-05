# Arrays: Gotchas and Stack Usage

@PageImage(purpose: card, source: "swift-swift-array-gotchas-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-array-gotchas-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-array-gotchas-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review Arrays: Gotchas and Stack Usage")
  @PageImage(purpose: icon, source: "swift-array-gotchas-icon.codex", alt: "Arrays Gotchas and Stack Usage icon")
  @PageImage(purpose: card, source: "swift-array-gotchas-card.codex", alt: "Arrays Gotchas and Stack Usage card")
}

@Image(source: "swift-array-gotchas-hero.codex", alt: "Arrays Gotchas and Stack Usage hero")

## Indexing Basics

- `endIndex` is one past the last element; valid indices are `startIndex ..< endIndex`.
- Slices (`ArraySlice`) keep original indices; when writing back, offset if needed.
- `for i in array.indices { ... }` is safe across empty/non-empty.

## Performance Pitfalls

- `insert(_:at: 0)` or at the front shifts elements (O(n)).
- Repeated `removeFirst()`/`remove(at: 0)` also shift (O(n)); prefer deque for heavy queue use.
- `append` is amortized O(1); `reserveCapacity` when length is predictable to reduce reallocations.
- Copy-on-write: mutations copy storage when arrays are shared; avoid unnecessary copies in hot
  paths.
- Async tasks capturing arrays share storage until a mutation happens; if multiple tasks mutate,
  pass copies (`var local = shared`) or switch to `ManagedBuffer`/actors to coordinate.

## Safe Iteration and Mutation

- Avoid mutating while iterating with `for-in` unless using indices; consider `while` with an index.
- When removing many elements, filter into a new array or use `removeAll(where:)`.

## Using Array As a Stack

- Push: `stack.append(x)`
- Pop: `let top = stack.popLast()` (returns optional)
- Peek: `let top = stack.last`
- Is empty: `stack.isEmpty`

Example:

```swift
var stack: [Int] = []
stack.append(1)
stack.append(2)
let popped = stack.popLast()  // 2
let peek = stack.last  // 1
```

## Common Patterns

- Two-pointer compaction in-place: maintain `write` index; scan with `read`.
- Partitioning: Lomuto/Hoare using indices; be mindful of inclusive vs. exclusive bounds.
- `indices.contains(i)` to bounds-check safely.
- Parallel map/filter: in Swift Concurrency, use `await withTaskGroup` and `chunked` slices; merge
  results deterministically to avoid index races.

## Sorted Array Helpers (Binary Search Bounds)

Use lower/upper bound to find first/last occurrence in a sorted array starting from an offset.

```swift
func boundIndex<T: Comparable>(
  of target: T,
  in sorted: [T],
  startingAt start: Int = 0,
  findFirst: Bool
) -> Int? {
  var low = max(start, 0)
  var high = sorted.count - 1
  var result: Int?

  while low <= high {
    let mid = (low + high) / 2
    if sorted[mid] < target {
      low = mid + 1
    } else if target < sorted[mid] {
      high = mid - 1
    } else {
      result = mid
      if findFirst {
        high = mid - 1
      } else {
        low = mid + 1
      }
    }
  }
  return result
}

func firstIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, findFirst: true)
}

func lastIndex<T: Comparable>(of target: T, in sorted: [T], startingAt start: Int = 0) -> Int? {
  boundIndex(of: target, in: sorted, startingAt: start, findFirst: false)
}
```

### Binary Search with Bias (First/Last Occurrence)

Use `SearchType` to bias toward the first or last index when duplicates exist.

```swift
enum SearchType { case low, mid, high }

func search(nums: [Int], target: Int, type: SearchType = .mid) -> Int {
  guard !nums.isEmpty else { return -1 }
  var lowIndex = nums.startIndex
  var highIndex = nums.index(before: nums.endIndex)  // inclusive
  var result = -1

  while lowIndex <= highIndex {
    let midIndex = lowIndex + (highIndex - lowIndex) / 2
    let midValue = nums[midIndex]

    if midValue == target {
      result = midIndex
      switch type {
      case .mid:
        return midIndex
      case .low:  // continue left to find first occurrence
        highIndex = midIndex - 1
      case .high:  // continue right to find last occurrence
        lowIndex = midIndex + 1
      }
    } else if midValue < target {
      lowIndex = midIndex + 1
    } else {
      highIndex = midIndex - 1
    }
  }
  return result
}
```

`type: .low` yields the first index, `.high` yields the last, `.mid` returns any match quickly.

## When to Reach for Other Types

- Heavy front insert/remove: simulate deque with array + head index or a small ring buffer helper.
- Ordered key-value: `OrderedDictionary`.
- Need stable indices through removals: consider `ContiguousArray` or a custom buffer.
