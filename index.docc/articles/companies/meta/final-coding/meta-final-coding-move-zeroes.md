# Meta Final Coding: Move Zeroes In-Place

@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-move-zeroes-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-move-zeroes-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-move-zeroes-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Move zeroes to the end in place")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-move-zeroes-icon.codex", alt: "Move zeroes to the end in place icon")
  @PageImage(purpose: card, source: "meta-final-coding-move-zeroes-card.codex", alt: "Move zeroes to the end in place card")
}

@Image(source: "meta-final-coding-move-zeroes-hero.codex", alt: "Meta Final Coding Move Zeroes In Place hero")

@Image(source: "meta-final-coding-move-zeroes-diagram.codex", alt: "Stable move of non-zeroes left, zeroes right")

## Practice Context

### Problem

Given an array of integers, move all `0`s to the end while keeping the relative order of the
non-zero elements. Do this in place with minimal operations.

### Approach

- Use a write index.
- When a non-zero is found, write it at `writeIndex` and advance.
- Fill the rest with zeroes.

### Complexity

- Time: O(N)
- Space: O(1)

## Swift Starter

```swift
func moveZeroes(_ nums: inout [Int]) {
  // TODO: Stable move using a write index.
}
```

## Swift Solution (Commented)

```swift
func moveZeroes(_ nums: inout [Int]) {
  var writeIndex = 0
  for value in nums where value != 0 {
    nums[writeIndex] = value  // Write non-zero in order.
    writeIndex += 1
  }

  while writeIndex < nums.count {
    nums[writeIndex] = 0  // Fill the remainder with zeros.
    writeIndex += 1
  }
}
```

## Related Patterns

- <doc:top-15-patterns>
