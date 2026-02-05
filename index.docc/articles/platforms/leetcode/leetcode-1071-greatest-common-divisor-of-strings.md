# LeetCode 1071: Greatest Common Divisor of Strings




Return the largest string `x` that divides both `str1` and `str2`, where division means the string repeats some number of times to form the target string.


Solve Easy problem.

Return the largest string `x` that divides both `str1` and `str2`, where division means the string
repeats some number of times to form the target string.

## Core Ideas

- If `str1 + str2 != str2 + str1` there is no common divisor (early exit).
- Otherwise the gcd string has length `gcd(len1, len2)`; take that prefix from either string.
- Use Euclid’s algorithm for the integer gcd.

## Constraints and Complexity

- `1 <= str1.count, str2.count <= 1000`.
- Time: `O(n)` to build/compare concatenations.
- Space: `O(n)` for concatenated strings; `O(1)` for metadata.

## Edge Cases

- Strings that are identical → return the string.
- When one string is a full multiple of the other → smaller string is the answer.
- Non-matching concatenations → empty result.

## Swift Notes

- Concatenate and compare to validate the divisibility condition.
- Slice with `index(_:offsetBy:)` to take the gcd-length prefix.

## Swift Starter

```swift
class Solution {
  func gcdOfStrings(_ str1: String, _ str2: String) -> String {
    // TODO: Check concatenation property, then return gcd-length prefix.
    return ""
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func gcdOfStrings(_ str1: String, _ str2: String) -> String {
    if str1 + str2 != str2 + str1 { return "" }  // Early exit.

    func gcd(_ a: Int, _ b: Int) -> Int {
      var x = a
      var y = b
      while y != 0 {
        let r = x % y
        x = y
        y = r
      }
      return x
    }

    let length = gcd(str1.count, str2.count)
    let end = str1.index(str1.startIndex, offsetBy: length)
    return String(str1[..<end])
  }
}
```

## Quick Tests

```swift
assert(Solution().gcdOfStrings("ABCABC", "ABC") == "ABC")
assert(Solution().gcdOfStrings("ABABAB", "ABAB") == "AB")
assert(Solution().gcdOfStrings("LEET", "CODE") == "")
assert(Solution().gcdOfStrings("AAAAAB", "AAA") == "")
```

## Interview Framing

- Emphasize the concatenation property as the correctness proof.
- Mention Euclid’s algorithm for the gcd length and why it bounds runtime.
- Note that in production, avoid materializing giant concatenations; compare lengths and prefixes.***
