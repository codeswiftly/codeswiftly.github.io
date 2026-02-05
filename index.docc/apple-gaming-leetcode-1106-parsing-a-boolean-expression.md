# Gaming Deep Dive — LeetCode 1106: Parsing a Boolean Expression

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1106 — Parsing a Boolean Expression")
  @CallToAction(url: "https://leetcode.com/problems/parsing-a-boolean-expression/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

Parsing plus recursive evaluation of logical operators.

## Invariant

- Respect parentheses nesting; operations apply to comma‑separated sub‑expressions.

## Approach

- Tokenize or scan; on operator, parse children until matching ')', then combine.

## Complexity

- Linear in length of input; recursion depth equals nesting.

## Test Plan

1. Single literal (t/f).
2. NOT with nested expressions.
3. AND/OR with multiple children.

## Walkthrough Article

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1106-parsing-a-boolean-expression>
- <doc:script-1106-parsing-a-boolean-expression>
}
