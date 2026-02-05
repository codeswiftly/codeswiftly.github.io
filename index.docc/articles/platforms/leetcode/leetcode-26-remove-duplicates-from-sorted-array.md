# LeetCode 26: Remove Duplicates from Sorted Array

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-26-remove-duplicates-from-sorted-array-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-26-remove-duplicates-from-sorted-array-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-26-remove-duplicates-from-sorted-array-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-26-remove-duplicates-from-sorted-array-dsa-icon.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")
  @PageImage(purpose: card, source: "leetcode-26-remove-duplicates-from-sorted-array-dsa-card.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")
}

@Image(source: "leetcode-26-remove-duplicates-from-sorted-array-dsa-hero.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")

Given a non-decreasing array `nums`, remove duplicates in-place so each unique element appears once. Return `k` = number of unique elements. The first `k` positions must hold the uniques; contents after `k` are...

@Image(source: "leetcode-26-remove-duplicates-from-sorted-array-dsa-top.codex", alt: "Easy problem - Pattern 2 (Two Pointers)")

Solve Easy problem.

Given a non-decreasing array `nums`, remove duplicates in-place so each unique element appears
once. Return `k` = number of unique elements. The first `k` positions must hold the uniques;
contents after `k` are irrelevant.

## Core Idea (Two Pointers)

- Sorted → duplicates are adjacent.
- `read` scans every element; `write` marks where the next unique goes.
- If `nums[read]` differs from `nums[write - 1]`, write it at `write` and advance `write`.
- Time O(n), space O(1).

## Swift Starter

```swift
class Solution {
  func removeDuplicates(_ nums: inout [Int]) -> Int {
    // TODO: Two pointers: read scans, write marks next unique.
    return 0
  }
}
```

## Swift Solution (Commented, Canonical)

```swift
class Solution {
  func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }

    var write = 1  // next slot for a new unique

    for read in 1..<nums.count where nums[read] != nums[write - 1] {
      nums[write] = nums[read]  // Copy the next unique forward.
      write += 1
    }

    return write
  }
}
```

## Dry Run

`nums = [0,0,1,1,1,2,2,3,3,4]`

- write=1
- read=1 (0==0) skip
- read=2 (1!=0) nums[1]=1, write=2
- read=5 (2!=1) nums[2]=2, write=3
- read=7 (3!=2) nums[3]=3, write=4
- read=9 (4!=3) nums[4]=4, write=5
- Result: k=5, nums front = [0,1,2,3,4,...]

## Swift Array Slicing Gotchas

- `nums[1..<nums.count]` is `ArraySlice`; its `startIndex` is 1.
- `enumerated()` on a slice yields offsets starting at 0; offset + slice.startIndex maps back.
- For clarity in interviews, prefer direct indexing (`for i in 1..<nums.count { … }`) instead of
  slicing when you must write back to `nums`.

## Swift-specific Notes

- Watch parameter order in `enumerated()`: it yields `(index, element)`.
- `inout` indicates mutation in place; the judge relies on the mutated `nums`.

## Complexity

- Time: O(n) single pass.
- Space: O(1) extra; the array is updated in place.

## Common Wrong Approaches (and Why They Fail)

- Using an extra array or Set: O(n) extra space; breaks “in-place”.
- Repeated `remove(at:)`: O(n²) worst case due to shifting.
- Set for seen elements: loses sorted order unless you do extra work; unnecessary here.

## Variations to Practice (Same Pattern)

- Allow at most 2 duplicates (LeetCode 80): same pattern with a different write condition.
- Move zeros to end: scan/write non-zeros.
- Partition by predicate: keep values meeting a condition at the front.

## Interview Framing

Questions to expect:

- What invariant or state do you maintain?
- What is the time and space complexity?
- Which edge cases would you test first?
- How would you optimize for larger inputs?
- What alternative approach would you mention and why?
