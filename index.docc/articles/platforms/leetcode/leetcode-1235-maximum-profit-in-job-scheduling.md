@PageImage(purpose: card, source: "platforms-leetcode-leetcode-1235-maximum-profit-in-job-scheduling-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-1235-maximum-profit-in-job-scheduling-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-1235-maximum-profit-in-job-scheduling-icon.codex", alt: "Placeholder icon")
# LeetCode 1235: Maximum Profit in Job Scheduling

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-1235-maximum-profit-in-job-scheduling-dsa-icon.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")
  @PageImage(purpose: card, source: "leetcode-1235-maximum-profit-in-job-scheduling-dsa-card.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")
}

@Image(source: "leetcode-1235-maximum-profit-in-job-scheduling-dsa-hero.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")

Pick non-overlapping jobs to maximize total profit.

@Image(source: "leetcode-1235-maximum-profit-in-job-scheduling-dsa-top.codex", alt: "Hard problem - Pattern 15 (Dynamic Programming)")

Solve Hard problem.

Pick non-overlapping jobs to maximize total profit.

## Core Ideas

- Sort by end time.
- DP + binary search to find last compatible job.

## Constraints and Complexity

- `n <= 5 * 10^4`.
- Time `O(n log n)`, space `O(n)`.

## Edge Cases

- Jobs with the same end time.
- All jobs overlapping.

## Swift Starter

```swift
class Solution {
  func jobScheduling(_ startTime: [Int], _ endTime: [Int], _ profit: [Int]) -> Int {
    // TODO: Sort by end time, DP + binary search.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func jobScheduling(_ startTime: [Int], _ endTime: [Int], _ profit: [Int]) -> Int {
    let n = startTime.count
    var jobs: [(start: Int, end: Int, profit: Int)] = []
    for i in 0..<n { jobs.append((startTime[i], endTime[i], profit[i])) }
    jobs.sort { $0.end < $1.end }

    var ends = jobs.map { $0.end }
    var dp = [Int](repeating: 0, count: n)

    for i in 0..<n {
      let compatible = compatibleIndex(ends, jobs[i].start)
      let includeProfit = jobs[i].profit + (compatible >= 0 ? dp[compatible] : 0)
      let excludeProfit = i > 0 ? dp[i - 1] : 0
      dp[i] = max(includeProfit, excludeProfit)
    }

    return dp.last ?? 0
  }

  private func compatibleIndex(_ ends: [Int], _ start: Int) -> Int {
    var left = 0
    var right = ends.count - 1
    var best = -1
    while left <= right {
      let mid = (left + right) / 2
      if ends[mid] <= start {
        best = mid
        left = mid + 1
      } else {
        right = mid - 1
      }
    }
    return best >= 0 ? best : -1
  }
}
```

## Interview Framing

- Sorting by end time turns the problem into weighted interval scheduling.
- Mention the DP recursion: best(i) = max(best(i-1), profit(i) + best(prev)).
