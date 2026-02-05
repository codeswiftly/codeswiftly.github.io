# Script — LeetCode 354: Russian Doll Envelopes (3:00)

@PageImage(purpose: card, source: "apple-gaming-scripts-script-354-russian-doll-envelopes-card.codex", alt: "Placeholder card")
@Image(source: "apple-gaming-scripts-script-354-russian-doll-envelopes-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "apple-gaming-scripts-script-354-russian-doll-envelopes-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Script — 354 Russian Doll Envelopes")
}

@Image(source: "script-354-russian-doll-envelopes-hero.codex", alt: "Script LeetCode 354 Russian Doll Envelopes (3 00) hero")

Pattern Focus: Sort + LIS. Sort by width asc, height desc; LIS on heights.

Duration: 3:00

## Narration

00:00–00:15 Hook — “Nesting envelopes is just LIS in disguise.”

00:15–00:35 Setup — “Find max nesting chain.”

00:35–01:20 Core idea — “Sort (w asc, h desc) so equal widths don’t chain. Then patience sorting on heights: maintain tails array; binary search position for each h.”

01:20–02:05 Code beats — implement lowerBound; O(n log n).”

02:05–02:30 Complexity — O(n log n) time, O(n) space.

02:30–03:00 Wrap — “Same pattern recurs in scheduling and stacking cuboids.”

## Visual Prompts

Walkthrough article: <doc:leetcode-354-russian-doll-envelopes>

- Tails array evolution under patience sorting.

<!-- TODO: Mermaid diagram showing sorting and LIS steps -->

## Swift Solution (Sort + LIS on Heights)

```swift
final class Solution {
  func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
    let env = envelopes.sorted { (a, b) -> Bool in
      if a[0] == b[0] { return a[1] > b[1] }  // width asc, height desc
      return a[0] < b[0]
    }
    var tails: [Int] = []
    for e in env {
      let h = e[1]
      var l = 0
      var r = tails.count
      while l < r {
        let m = (l + r) >> 1
        if tails[m] < h { l = m + 1 } else { r = m }
      }
      if l == tails.count { tails.append(h) } else { tails[l] = h }
    }
    return tails.count
  }
}
```

## Diagram

Diagram source: `Resources/ag-354-russian-doll.svg`

## Mermaid Sources

- Source: `Resources/mermaid/ag-354-russian-doll-source.mmd` relative to the bundle root.

Re-render and inline the DocC CSS theme:

```bash
npx -y @mermaid-js/mermaid-cli \
  -i code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-354-russian-doll-source.mmd \
  -o code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/ag-354-russian-doll.svg
swift code/scripts/mermaid-inline-css.swift \
  --dir code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources \
  --css code/mono/apple/spm/clis/docc-wrkstrm-cli/docs/mermaid/mermaid-docc-dark.css
```
