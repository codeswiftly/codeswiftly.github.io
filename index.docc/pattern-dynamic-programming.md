# Pattern 15: Dynamic Programming


@Metadata {
  @TitleHeading("Practice Dynamic Programming")
}


Solve complex problems by breaking them down into simpler subproblems and storing their solutions to avoid redundant work.

## Problem

- Overlapping subproblems with a recurrence.

## Solution

- Memoize or tabulate computed states.

## Concept

- **Overlapping Subproblems**: The same subproblem is solved multiple times (e.g., Fib(3) in Fib(5)).
- **Optimal Substructure**: The solution to a problem can be constructed from solutions to its subproblems.
- **Memoization (Top-Down)**: Cache results of function calls.
- **Tabulation (Bottom-Up)**: Fill a table iteratively starting from base cases.

## Complexity

- **Time**: O(N) or O(N*M). Reduces exponential time to polynomial.
- **Space**: O(N) for memoization table.

## When to Use

- **Min/Max/Count**: "Minimum cost", "Maximum profit", "Number of ways".
- **Sequences**: Longest Increasing Subsequence, Edit Distance.
- **Choices**: Knapsack (take or skip).

## Examples

### 1. Climbing Stairs

Count ways to reach the top.

```swift
func climbStairs(_ n: Int) -> Int {
  if n <= 2 { return n }
  var oneStepBefore = 2
  var twoStepsBefore = 1

  for _ in 3...n {
    let current = oneStepBefore + twoStepsBefore
    twoStepsBefore = oneStepBefore
    oneStepBefore = current
  }
  return oneStepBefore
}
```

### 2. Coin Change

Fewest coins to make up amount.

```swift
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
  // dp[i] = min coins to make amount i
  // Fill with amount + 1 (impossible value)
  var dp = Array(repeating: amount + 1, count: amount + 1)
  dp[0] = 0

  for i in 1...amount {
    for coin in coins {
      if i - coin >= 0 {
        dp[i] = min(dp[i], dp[i - coin] + 1)
      }
    }
  }

  return dp[amount] > amount ? -1 : dp[amount]
}
```

## Common Pitfalls

- **Base Cases**: `dp[0]` usually needs careful initialization (0 or 1 depending on problem).
- **State Definition**: Defining `dp[i]` correctly is 90% of the work.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-123-best-time-to-buy-and-sell-stock-iii>
- <doc:leetcode-188-best-time-to-buy-and-sell-stock-iv>
- <doc:leetcode-354-russian-doll-envelopes>
}

## See Also

- <doc:top-15-patterns>
