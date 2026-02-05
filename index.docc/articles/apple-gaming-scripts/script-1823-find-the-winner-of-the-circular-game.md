# Script — LeetCode 1823: Find the Winner of the Circular Game (3:00)


@Metadata {
  @TitleHeading("Script — 1823 Find the Winner of the Circular Game")
}


Pattern Focus: Josephus recurrence — `J(n,k) = (J(n-1,k) + k) % n` with base 0; add 1 for 1‑indexing.

Duration: 3:00

## Narration

00:00–00:15 Hook — “Hot‑potato elimination solved with one elegant recurrence.”

00:15–00:35 Setup — “n players in a circle; eliminate every k‑th; return winner’s label.”

00:35–01:10 Core idea — “Iterative recurrence: `ans=0; for i in 1..n { ans = (ans + k) % i }` then `ans+1`.”

01:10–01:45 Code beats — O(n) time, O(1) space; avoid simulating the circle.”

01:45–02:15 Complexity — linear, tiny memory.

02:15–03:00 Wrap — “Recurrence thinking beats simulation; memorize Josephus.”

## Visual Prompts

Walkthrough article: <doc:leetcode-1823-find-the-winner-of-the-circular-game>

- Circle animation with modulo arithmetic overlay; show recurrence update.

## Swift Solution (Josephus)

```swift
final class Solution {
  func findTheWinner(_ playerCount: Int, _ stepSize: Int) -> Int {
    var zeroIndexedWinner = 0  // base J(1, stepSize) = 0
    for current in 1...playerCount {
      zeroIndexedWinner = (zeroIndexedWinner + stepSize) % current
    }
    return zeroIndexedWinner + 1  // convert to 1-index labels
  }
}
```

Notes

- O(n) time, O(1) space; avoids simulating the circle.
