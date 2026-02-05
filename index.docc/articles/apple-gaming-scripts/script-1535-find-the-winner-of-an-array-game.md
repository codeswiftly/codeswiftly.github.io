# Script — LeetCode 1535: Find the Winner of An Array Game (3:00)


@Metadata {
  @TitleHeading("Script — 1535 Find the Winner of an Array Game")
}


Pattern Focus: One‑pass champion simulation — maintain current champion and consecutive win count.

Duration: 3:00

## Narration

00:00–00:15 Hook — “Who keeps the crown after k straight wins?”

00:15–00:35 Setup — “Compare a[0] vs a[1]; bigger stays front; challenger moves to tail. First to k consecutive wins wins overall.”

00:35–01:10 Core idea — “Track `champ` and `streak`. Iterate next values: if x>champ, champ=x and streak=1 else streak+=1. Early exit when streak==k.”

01:10–01:45 Code beats — O(n) time; no need to simulate full queue once a max emerges.

01:45–02:15 Complexity — linear; bounded by number of elements until maximum surfaces.

02:15–03:00 Wrap — “A streaming mindset; treat comparisons as a running tournament.”

## Visual Prompts

Walkthrough article: <doc:leetcode-1535-find-the-winner-of-an-array-game>

- Small bracket showing champion and streak counter.

## Swift Solution (Single Pass)

```swift
final class Solution {
  func getWinner(_ values: [Int], _ requiredConsecutiveWins: Int) -> Int {
    var currentChampion = values[0]
    var consecutiveWins = 0
    let maximumValue = values.max()!
    for nextValue in values.dropFirst() {
      if currentChampion > nextValue {
        consecutiveWins += 1
      } else {
        currentChampion = nextValue
        consecutiveWins = 1
      }
      if consecutiveWins >= requiredConsecutiveWins || currentChampion == maximumValue {
        return currentChampion
      }
    }
    return currentChampion
  }
}
```

## Diagram

Diagram source: `Resources/ag-1535-array-game.svg`

## Mermaid Sources

- Source: `code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-1535-array-game-source.mmd`

Re-render locally and inline the DocC CSS theme:

```bash
npx -y @mermaid-js/mermaid-cli \
  -i code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-1535-array-game-source.mmd \
  -o code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/ag-1535-array-game.svg
swift code/scripts/mermaid-inline-css.swift \
  --dir code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources \
  --css code/mono/apple/spm/clis/docc-wrkstrm-cli/docs/mermaid/mermaid-docc-dark.css
```
