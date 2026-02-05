# LeetCode 4: Median of Two Sorted Arrays




Given two sorted arrays `nums1` and `nums2`, return the median of the combined multiset in `O(log(m+n))` time.


Solve Hard problem.

Given two sorted arrays `nums1` and `nums2`, return the median of the combined multiset in
`O(log(m+n))` time.

## Core Ideas

- Binary search on partition size of the smaller array so that left partition contains half of
  elements and max-left <= min-right across both arrays.

## Constraints and Complexity

- `0 <= m, n <= 10^3` (LeetCode) but algorithm handles larger.
- Time `O(log(min(m,n)))`, space `O(1)`.

## Edge Cases

- Empty array(s).
- Duplicates.
- Odd vs even combined length.

## Swift Notes

- Use sentinel `Int.min`/`Int.max` for partition boundaries.
- Keep all indices as `Int`; guard against division rounding.

## Swift Starter

```swift
class Solution {
  func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    // TODO: Binary search partition on the smaller array.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let A = nums1.count < nums2.count ? nums1 : nums2
    let B = nums1.count < nums2.count ? nums2 : nums1
    let total = A.count + B.count
    let half = total / 2
    var low = 0
    var high = A.count

    while true {
      let i = (low + high) / 2
      let j = half - i

      let Aleft = i > 0 ? A[i - 1] : Int.min
      let Aright = i < A.count ? A[i] : Int.max
      let Bleft = j > 0 ? B[j - 1] : Int.min
      let Bright = j < B.count ? B[j] : Int.max

      if Aleft <= Bright && Bleft <= Aright {
        guard total % 2 == 0 else {
          return Double(min(Aright, Bright))
        }
        return Double(max(Aleft, Bleft) + min(Aright, Bright)) / 2.0
      } else if Aleft > Bright {
        high = i - 1  // Move partition left.
      } else {
        low = i + 1  // Move partition right.
      }
    }
  }
}
```

## Interview Framing

- Explain invariants: partitions keep left side count = right side count.
- Discuss fallback `O(m+n)` merge when interviewer relaxes time requirement.
