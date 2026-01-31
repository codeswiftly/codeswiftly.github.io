@PageImage(purpose: card, source: "apple-gaming-scripts-script-46-permutations-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-scripts-script-46-permutations-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-scripts-script-46-permutations-icon.codex", alt: "Placeholder icon")
# Script — LeetCode 46: Permutations (3:00)

@Metadata {
  @TitleHeading("Script — 46 Permutations")
}

@Image(source: "script-46-permutations-hero.codex", alt: "Script LeetCode 46 Permutations (3 00) hero")

Pattern Focus: Backtracking — choose → explore → unchoose. Track used elements. No duplicates in input.

Duration: 3:00

## Narration

00:00–00:15 Hook — “How do we systematically list every ordering without missing or repeating?”

00:15–00:40 Setup — “Given distinct integers, return all permutations.”

00:40–01:30 Core idea — “Backtracking builds a path. At each depth pick any unused number, append, recurse, then remove (unchoose). When path.count == n, record a copy.”

01:30–02:20 Code beats —

- Use `var path: [Int]`, `var used = [Bool](repeating:false,count:n)`, and `var out = [[Int]]()`.
- DFS(index): if index == n, push path.
- Loop i in 0..<n: if used[i] continue; used[i]=true; path.append(nums[i]); DFS(index+1); path.removeLast(); used[i]=false.

02:20–02:45 Complexity — “O(n·n!)` results; backtracking overhead is linear per permutation.”

02:45–03:00 Wrap — “This choose/explore/unchoose rhythm scales to N‑Queens, subsets, and more.”

## Visual Prompts

Walkthrough article: <doc:leetcode-46-permutations>

- Tree diagram with levels for each index; highlight choose/unchoose steps.
- Card/icon: generic backtracking visuals are fine.

## Swift Solution

```swift
/// Backtracking: choose → explore → unchoose.
final class Solution {
  func permute(_ numbers: [Int]) -> [[Int]] {
    var allPermutations: [[Int]] = []
    var currentPath: [Int] = []
    var isUsed = Array(repeating: false, count: numbers.count)

    func depthFirstSearch(_ depth: Int) {
      if depth == numbers.count {
        allPermutations.append(currentPath)
        return
      }
      for index in 0..<numbers.count where !isUsed[index] {
        isUsed[index] = true
        currentPath.append(numbers[index])
        depthFirstSearch(depth + 1)
        currentPath.removeLast()
        isUsed[index] = false
      }
    }
    depthFirstSearch(0)
    return allPermutations
  }
}
```

Notes

- Time is O(n·n!) due to result size; backtracking overhead is linear per permutation.
