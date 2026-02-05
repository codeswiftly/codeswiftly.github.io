@PageImage(purpose: card, source: "apple-gaming-scripts-script-2682-find-the-losers-of-the-circular-game-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-scripts-script-2682-find-the-losers-of-the-circular-game-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-scripts-script-2682-find-the-losers-of-the-circular-game-icon.codex", alt: "Placeholder icon")
# Script — LeetCode 2682: Find the Losers of the Circular Game (3:00)

@Metadata {
  @TitleHeading("Script — 2682 Find the Losers of the Circular Game")
}

@Image(source: "script-2682-find-the-losers-of-the-circular-game-hero.codex", alt: "Script LeetCode 2682 Find the Losers of the Circular Game (3 00) hero")

Pattern Focus: Circular math and visited tracking — simulate jumps of k, 2k, 3k… mod n until repeat; everyone not visited is a loser.

Duration: 3:00

## Narration

00:00–00:15 Hook — “Hot‑potato math with predictable cycles.”

00:15–00:35 Setup — “n players in a circle; at round r move r·k steps; visited players ‘receive the ball’. Return unvisited.”

00:35–01:15 Core idea — “Start at 0; step = k; while player not seen: mark seen, move = (idx + step) % n; step += k. After loop, losers are those never seen.”

01:15–01:50 Code beats — boolean array seen[n]; build losers by scanning.”

01:50–02:15 Complexity — O(n) time and O(n) space.

02:15–03:00 Wrap — “Great warm‑up for Josephus and array‑game champion problems.”

## Visual Prompts

Walkthrough article: <doc:leetcode-2682-find-the-losers-of-the-circular-game>

- Circle of players with step sizes 1k,2k,3k … visualized.

## Swift Solution (Visited Indices via Arithmetic)

```swift
final class Solution {
  func circularGameLosers(_ n: Int, _ k: Int) -> [Int] {
    var seen = Array(repeating: false, count: n)
    var i = 0  // index of current player (0-index)
    var r = 1
    while !seen[i] {
      seen[i] = true
      i = (i + r * k) % n
      r += 1
    }
    var out: [Int] = []
    for p in 0..<n where !seen[p] { out.append(p + 1) }
    return out
  }
}
```

## Diagram

Diagram source: `Resources/ag-2682-circular-losers.svg`

## Mermaid Sources

- Source: `Resources/mermaid/ag-2682-circular-losers-source.mmd` relative to the bundle root.

Re-render and inline the DocC CSS theme:

```bash
npx -y @mermaid-js/mermaid-cli \
  -i code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-2682-circular-losers-source.mmd \
  -o code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/ag-2682-circular-losers.svg
swift code/scripts/mermaid-inline-css.swift \
  --dir code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources \
  --css code/mono/apple/spm/clis/docc-wrkstrm-cli/docs/mermaid/mermaid-docc-dark.css
```
