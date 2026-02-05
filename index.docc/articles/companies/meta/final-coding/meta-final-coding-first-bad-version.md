# Meta Final Coding: First Bad Version


@Metadata {
  @TitleHeading("First bad version")
  @PageColor(blue)
}



## Practice Context

### Problem

You are given an API `isBadVersion(version: Int) -> Bool`. Given `n`, find the first bad version
while minimizing calls.

### Approach

- Binary search on the version range.
- When a version is bad, move left; otherwise move right.

### Complexity

- Time: O(log N)
- Space: O(1)

## Swift Starter

```swift
/// func isBadVersion(_ version: Int) -> Bool { true }  // Provided by the prompt.

func firstBadVersion(_ n: Int) -> Int {
  // TODO: Binary search for the first bad version.
  return 0
}
```

## Swift Solution (Commented)

```swift
/// func isBadVersion(_ version: Int) -> Bool { true }  // Provided by the prompt.

func firstBadVersion(_ n: Int) -> Int {
  var left = 1
  var right = n
  var answer = n

  while left <= right {
    let mid = left + (right - left) / 2
    if isBadVersion(mid) {
      answer = mid
      right = mid - 1  // Search left half for an earlier bad version.
    } else {
      left = mid + 1  // Search right half.
    }
  }

  return answer
}
```

## Related Patterns

- <doc:top-15-patterns>
