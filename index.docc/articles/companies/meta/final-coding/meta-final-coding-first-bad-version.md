# Meta Final Coding: First Bad Version

@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-first-bad-version-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-first-bad-version-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-first-bad-version-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("First bad version")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-first-bad-version-icon.codex", alt: "First bad version icon")
  @PageImage(purpose: card, source: "meta-final-coding-first-bad-version-card.codex", alt: "First bad version card")
}

@Image(source: "meta-final-coding-first-bad-version-hero.codex", alt: "Meta Final Coding First Bad Version hero")

@Image(source: "meta-final-coding-first-bad-version-diagram.codex", alt: "Binary search narrowing to first bad")

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
