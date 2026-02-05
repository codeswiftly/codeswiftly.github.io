# LeetCode 14: Longest Common Prefix




Given an array of strings, return the longest common prefix shared by all of them. If none exists, return an empty string.


Solve Easy problem.

Given an array of strings, return the longest common prefix shared by all of them. If none exists,
return an empty string.

Examples:

- `["flower", "flow", "flight"]` → `"fl"`
- `["dog", "racecar", "car"]` → `""`

Constraints:

- `1 <= strings.count <= 200`
- Each string length 0...200; lowercase English letters when non-empty.

## Core Idea (Horizontal Scan)

- Treat the first string as the current prefix.
- For each subsequent string, replace the prefix with the common prefix between current prefix and
  that string.
- Early exit if the prefix becomes empty.
- Time O(L) where L is total characters; space O(1) extra.

## Swift Starter

```swift
class Solution {
  func longestCommonPrefix(_ strings: [String]) -> String {
    // TODO: Walk each string and shrink the prefix.
    return ""
  }
}
```

## Swift Solution (Commented, Using `CommonPrefix`)

```swift
class Solution {
  func longestCommonPrefix(_ strings: [String]) -> String {
    guard var currentPrefix = strings.first else { return "" }

    for index in 1..<strings.count {
      let nextString = strings[index]
      currentPrefix = currentPrefix.commonPrefix(with: nextString)  // Shrink prefix.
      if currentPrefix.isEmpty { return "" }
    }

    return currentPrefix
  }
}
```

## Manual Implementation (Commented, Without `CommonPrefix`)

```swift
class Solution {
  func longestCommonPrefix(_ strings: [String]) -> String {
    guard var currentPrefix = strings.first else { return "" }

    for stringIndex in 1..<strings.count {
      let comparisonString = strings[stringIndex]
      currentPrefix = commonPrefixBetween(currentPrefix, and: comparisonString)
      if currentPrefix.isEmpty { return "" }
    }

    return currentPrefix
  }

  private func commonPrefixBetween(_ first: String, and second: String) -> String {
    let maxLength = min(first.count, second.count)
    var offset = 0

    while offset < maxLength {
      let i1 = first.index(first.startIndex, offsetBy: offset)
      let i2 = second.index(second.startIndex, offsetBy: offset)
      if first[i1] != second[i2] { break }
      offset += 1  // Extend while chars match.
    }

    let end = first.index(first.startIndex, offsetBy: offset)
    return String(first[first.startIndex..<end])
  }
}
```

## Edge Cases

- Single string → return it.
- Empty string present → return `""`.
- No common prefix at all → `""`.
- All identical → return the string.
- One string is a prefix of another → return the shorter one.

## Complexity

- Time: O(L) total characters compared.
- Space: O(1) extra beyond output.

## Interview Notes

- Mention `commonPrefix(with:)` for clarity, and show manual indexing if asked to avoid helpers.
- Be careful with `String.Index` arithmetic; avoid converting to arrays unless required.
- Early exit on empty prefix is a good optimization to call out.

## Interview Framing

Questions to expect:

- What invariant or state do you maintain?
- What is the time and space complexity?
- Which edge cases would you test first?
- How would you optimize for larger inputs?
- What alternative approach would you mention and why?
