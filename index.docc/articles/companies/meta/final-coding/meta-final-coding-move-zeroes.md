# Meta Final Coding: Move Zeroes In-Place


@Metadata {
  @TitleHeading("Move zeroes to the end in place")
  @PageColor(blue)
}



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
