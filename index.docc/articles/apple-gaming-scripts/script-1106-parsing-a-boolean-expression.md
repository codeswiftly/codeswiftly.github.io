# Script — LeetCode 1106: Parsing a Boolean Expression (3:00)


@Metadata {
  @TitleHeading("Script — 1106 Parsing a Boolean Expression")
}


Pattern Focus: Parse and evaluate — stack or recursive descent. Operators: !(x), &(a,b,...), |(a,b,...).

Duration: 3:00

## Narration

00:00–00:15 Hook — “Tiny interpreter time: parse, then evaluate in one pass.”

00:15–00:35 Setup — “Input is a well‑formed boolean expression using !, &, | and literals t/f.”

00:35–01:25 Core idea — “Use a stack of operators and operand lists; when you hit ')', pop the operator and fold the list. Or write recursive descent: eval() dispatches by leading char.”

01:25–02:05 Code beats — implement fold rules: ! toggles, & requires all true, | requires any true.

02:05–02:35 Complexity — O(n) time, O(n) space for stack/recursion.

02:35–03:00 Wrap — “Interpreter skeleton — exact same pattern extends to arithmetic evaluators.”

## Visual Prompts

Walkthrough article: <doc:leetcode-1106-parsing-a-boolean-expression>

- Operator stack and operand list animation; fold at ')'.

## Diagram

Diagram source: `Resources/ag-1106-boolean-expr.svg`

## Mermaid Sources

- Source: `Resources/mermaid/ag-1106-boolean-expr-source.mmd`

Re-render and inline the DocC CSS theme:

```bash
npx -y @mermaid-js/mermaid-cli \
  -i code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/mermaid/ag-1106-boolean-expr-source.mmd \
  -o code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources/ag-1106-boolean-expr.svg
swift code/scripts/mermaid-inline-css.swift \
  --dir code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/Resources \
  --css code/mono/apple/spm/clis/docc-wrkstrm-cli/docs/mermaid/mermaid-docc-dark.css
```

## Swift Solution (Stack)

```swift
final class Solution {
  func parseBoolExpr(_ expression: String) -> Bool {
    var operators: [Character] = []
    var operandGroups: [[Bool]] = []
    for character in expression {
      switch character {
      case " ": continue
      case "t":
        if var last = operandGroups.popLast() {
          last.append(true)
          operandGroups.append(last)
        } else {
          operandGroups.append([true])
        }
      case "f":
        if var last = operandGroups.popLast() {
          last.append(false)
          operandGroups.append(last)
        } else {
          operandGroups.append([false])
        }
      case "!", "&", "|": operators.append(character)
      case "(": operandGroups.append([])
      case ",": continue
      case ")":
        guard let op = operators.popLast(), let group = operandGroups.popLast() else { continue }
        let value: Bool
        switch op {
        case "!": value = !group[0]
        case "&": value = group.allSatisfy { $0 }
        default: value = group.contains(true)
        }
        if var last = operandGroups.popLast() {
          last.append(value)
          operandGroups.append(last)
        } else {
          operandGroups.append([value])
        }
      default: continue
      }
    }
    return operandGroups.last?.last ?? false
  }
}
```

Notes

- The stack encodes an operator and a pending operand list; closing paren folds using the operator rule.
