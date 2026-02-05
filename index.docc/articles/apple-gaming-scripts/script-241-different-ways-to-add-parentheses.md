# Script — LeetCode 241: Different Ways to Add Parentheses (3:00)


@Metadata {
  @TitleHeading("Script — 241 Different Ways to Add Parentheses")
}


Pattern Focus: Divide and conquer with memoization — split on operator, combine left×right results.

Duration: 3:00

## Narration

00:00–00:15 Hook — “How many values can an expression take with different groupings?”

00:15–00:35 Setup — “Given a string like '2*3-4*5', return all possible results.”

00:35–01:25 Core idea — “For each operator at index i, compute all results for left and right substrings, then cross‑combine using the operator. Memoize substring ranges to avoid recomputation.”

01:25–02:05 Code beats — recursive `eval(l..r)` returns [Int]; on digits only, parse and return.

02:05–02:35 Complexity — Catalan‑like growth; memoization reduces overlap significantly.

02:35–03:00 Wrap — “Same pattern powers boolean expression parsing and DP on trees.”

## Visual Prompts

Walkthrough article: <doc:leetcode-241-different-ways-to-add-parentheses>

- Binary partition diagram with combination tables at nodes.

## Diagram

Diagram source: `Resources/ag-241-add-parentheses.svg`

## Mermaid Sources

- Source: `Resources/mermaid/ag-241-add-parentheses-source.mmd`

Re-render and inline the DocC CSS theme:

```bash
npx -y @mermaid-js/mermaid-cli \
  -i code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-241-add-parentheses-source.mmd \
  -o code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/ag-241-add-parentheses.svg
swift code/scripts/mermaid-inline-css.swift \
  --dir code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources \
  --css code/mono/apple/spm/clis/docc-wrkstrm-cli/docs/mermaid/mermaid-docc-dark.css
```

## Swift Solution (Divide & Conquer + Memo)

```swift
final class Solution {
  func diffWaysToCompute(_ expression: String) -> [Int] {
    let characters = Array(expression)
    var cache: [String: [Int]] = [:]

    func evaluate(_ left: Int, _ right: Int) -> [Int] {
      if left > right { return [] }
      let key = "\(left)#\(right)"
      if let cached = cache[key] { return cached }
      var isPureNumber = true
      for index in left...right {
        let ch = characters[index]
        if ch == "+" || ch == "-" || ch == "*" {
          isPureNumber = false
          break
        }
      }
      if isPureNumber {
        var value = 0
        for index in left...right { value = value * 10 + Int(String(characters[index]))! }
        cache[key] = [value]
        return [value]
      }
      var results: [Int] = []
      var mid = left
      while mid <= right {
        let ch = characters[mid]
        if ch == "+" || ch == "-" || ch == "*" {
          let leftValues = evaluate(left, mid - 1)
          let rightValues = evaluate(mid + 1, right)
          for a in leftValues {
            for b in rightValues {
              switch ch {
              case "+": results.append(a + b)
              case "-": results.append(a - b)
              default: results.append(a * b)
              }
            }
          }
        }
        mid += 1
      }
      cache[key] = results
      return results
    }

    return evaluate(0, characters.count - 1)
  }
}
```

Notes

- Split on each operator; recurse on left/right; cross‑combine results; memoize subranges.
