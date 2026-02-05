# Script — LCCI 08.06: Hanota (Towers of Hanoi) (3:00)


@Metadata {
  @TitleHeading("Script — LCCI 08.06 Hanota")
}


Pattern Focus: Recursion with invariant — move n‑1 to aux, move bottom to target, move n‑1 from aux to target.

Duration: 3:00

## Narration

00:00–00:15 Hook — “Classic recursion kata: three pegs, n disks, one elegant rule.”

00:15–00:35 Setup — “Implement `hanota(A,B,C)` moving all disks from A to C.”

00:35–01:30 Core idea — “If n==1, move A→C. Else hanota(A,C,B) for n‑1, move A→C, then hanota(B,A,C) for n‑1.”

01:30–02:05 Code beats — represent pegs as arrays; append/pop; collect moves for testing.”

02:05–02:35 Complexity — “2^n−1 moves; optimal and canonical.”

02:35–03:00 Wrap — “Recursion describes state change succinctly; prove minimality.”

## Visual Prompts

Walkthrough article: <doc:leetcode-lcci-08-06-hanota>

- Pegs animation showing the 3‑step pattern.

## Swift Solution (Recursive Move)

```swift
final class Solution {
  func hanota(_ A: inout [Int], _ B: inout [Int], _ C: inout [Int]) {
    func move(_ n: Int, _ from: inout [Int], _ aux: inout [Int], _ to: inout [Int]) {
      if n == 0 { return }
      move(n - 1, &from, &to, &aux)
      to.append(from.removeLast())
      move(n - 1, &aux, &from, &to)
    }
    move(A.count, &A, &B, &C)
  }
}
```

## Diagram

Diagram source: `Resources/ag-hanota-recursion.svg`

## Mermaid Sources

- Source: `Resources/mermaid/ag-hanota-recursion-source.mmd` relative to the bundle root.

Re-render and inline the DocC CSS theme:

```bash
npx -y @mermaid-js/mermaid-cli \
  -i code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-hanota-recursion-source.mmd \
  -o code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/ag-hanota-recursion.svg
swift code/scripts/mermaid-inline-css.swift \
  --dir code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources \
  --css code/mono/apple/spm/clis/docc-wrkstrm-cli/docs/mermaid/mermaid-docc-dark.css
```
