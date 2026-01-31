
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-39-combination-sum-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-39-combination-sum-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-39-combination-sum-icon.codex", alt: "Placeholder icon")
# LeetCode 39: Combination Sum

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-39-combination-sum-dsa-icon.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
  @PageImage(purpose: card, source: "leetcode-39-combination-sum-dsa-card.codex", alt: "Medium problem - Pattern 14 (Backtracking)")
}

@Image(source: "leetcode-39-combination-sum-dsa-hero.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

Given candidates (distinct positive ints) and target, return all unique combinations where numbers sum to target. Same number may be chosen unlimited times; order of combinations does not matter.

@Image(source: "leetcode-39-combination-sum-dsa-top.codex", alt: "Medium problem - Pattern 14 (Backtracking)")

Solve Medium problem.

Given candidates (distinct positive ints) and target, return all unique combinations where numbers
sum to target. Same number may be chosen unlimited times; order of combinations does not matter.

## Core Ideas

- Backtracking with index parameter to avoid duplicates.
- Sort candidates to prune early.
- Variant without sorting (explicit guard for negative remaining) below.

## Constraints and Complexity

- `candidates.count <= 30`, values <= 200, target <= 500.
- Exponential number of combinations in worst case.

## Edge Cases

- No valid combination.
- Single candidate equals target.

## Swift Starter

```swift
class Solution {
  func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    // TODO: Backtrack with an index to avoid duplicates.
    return []
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    let sorted = candidates.sorted()
    var result: [[Int]] = []
    var current: [Int] = []
    func dfs(_ index: Int, _ remaining: Int) {
      if remaining == 0 {
        result.append(current)
        return
      }
      guard index < sorted.count else { return }
      if sorted[index] <= remaining {
        current.append(sorted[index])
        dfs(index, remaining - sorted[index])
        current.removeLast()  // Backtrack.
      }
      dfs(index + 1, remaining)  // Skip current candidate.
    }
    dfs(0, target)
    return result
  }
}
```

### Alternative (No Sort, Guard Prune)

```swift
class SolutionAlt {
  func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var result: [[Int]] = []
    var combo: [Int] = []
    func backtrack(_ start: Int, _ remaining: Int) {
      guard remaining >= 0 else { return }  // prune negatives
      if remaining == 0 {  // success
        result.append(combo)
        return
      }
      for i in start..<candidates.count {
        combo.append(candidates[i])
        backtrack(i, remaining - candidates[i])  // reuse same index
        combo.removeLast()
      }
    }
    backtrack(0, target)
    return result
  }
}
```

## Interview Framing

- Stress dedup via `index` parameter.
- Mention variations: Combination Sum II (no reuse), coin-change DP.
