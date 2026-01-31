
@Image(source: "pattern-backtracking-hero.codex", alt: "Placeholder hero")
# Pattern 14: Backtracking

@Metadata {
  @TitleHeading("Practice Backtracking")
  @PageImage(purpose: icon, source: "pattern-backtracking-icon.codex", alt: "Pattern 14: Backtracking icon")
  @PageImage(purpose: card, source: "pattern-backtracking-card.codex", alt: "Pattern 14: Backtracking card")
}

@Image(source: "backtracking-diagram.codex", alt: "Decision tree exploration")

Systematically search for a solution by building candidates incrementally and abandoning ("backtracking") partial candidates that cannot lead to a valid solution.

## Problem

- Search combinations, permutations, or paths under constraints.

## Solution

- Choose, explore, undo, and prune early.

## Concept

- **Decision Tree**: At each step, you make a choice (e.g., include a number, place a queen).
- **Recursion**: Move to the next step.
- **Constraints**: If the current path is invalid (sum > target), stop.
- **Undo**: After returning from recursion, undo the choice to explore other branches.

## Complexity

- **Time**: Generally exponential, O(N!), O(2^N), or O(K^N). Pruning helps average case.
- **Space**: O(N) recursion depth.

## When to Use

- **Combinatorial Problems**: Permutations, Combinations, Subsets.
- **Constraint Satisfaction**: N-Queens, Sudoku.
- **Path Finding**: All paths from A to B.

## Examples

### 1. Combination Sum

Find all unique combinations where candidate numbers sum to target.

```swift
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
  var result = [[Int]]()
  var path = [Int]()

  func backtrack(_ start: Int, _ remaining: Int) {
    if remaining == 0 {
      result.append(path)
      return
    }
    if remaining < 0 { return }

    for i in start..<candidates.count {
      path.append(candidates[i])
      // Pass 'i' as start to allow reusing the same element
      backtrack(i, remaining - candidates[i])
      path.removeLast()  // Backtrack
    }
  }

  backtrack(0, target)
  return result
}
```

### 2. Permutations

Return all possible permutations of an array.

```swift
func permute(_ nums: [Int]) -> [[Int]] {
  var result = [[Int]]()
  var nums = nums

  func backtrack(_ start: Int) {
    if start == nums.count {
      result.append(nums)
      return
    }

    for i in start..<nums.count {
      nums.swapAt(start, i)
      backtrack(start + 1)
      nums.swapAt(start, i)  // Undo swap
    }
  }

  backtrack(0)
  return result
}
```

## Common Pitfalls

- **State Management**: Ensure you `removeLast()` or undo changes correctly.
- **Duplicates**: Sorting the input helps handling duplicate elements (e.g., `if i > start && nums[i] == nums[i-1] { continue }`).

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-39-combination-sum>
- <doc:leetcode-46-permutations>
- <doc:leetcode-52-n-queens-ii>
}

## See Also

- <doc:top-15-patterns>
