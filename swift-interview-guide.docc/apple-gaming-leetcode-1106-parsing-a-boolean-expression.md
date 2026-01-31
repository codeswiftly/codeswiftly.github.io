# Gaming Deep Dive — LeetCode 1106: Parsing a Boolean Expression

@Metadata {
  @TitleHeading("Gaming Deep Dive: LeetCode 1106 — Parsing a Boolean Expression")
  @PageImage(purpose: icon, source: "apple-gaming-leetcode-1106-parsing-a-boolean-expression-icon.codex", alt: "Gaming Deep Dive — 1106 icon")
  @PageImage(purpose: card, source: "apple-gaming-leetcode-1106-parsing-a-boolean-expression-card.codex", alt: "Gaming Deep Dive — 1106 card")
  @CallToAction(url: "https://leetcode.com/problems/parsing-a-boolean-expression/", label: "Solve on LeetCode")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "apple-gaming-leetcode-1106-parsing-a-boolean-expression-hero.codex", alt: "Gaming Deep Dive LeetCode 1106 Parsing a Boolean Expression hero")

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
