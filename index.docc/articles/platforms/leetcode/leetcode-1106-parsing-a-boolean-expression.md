# LeetCode 1106: Parsing a Boolean Expression


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/parsing-a-boolean-expression/", label: "Solve on LeetCode")
}


> Warning: 1. Nested expressions require a reliable stack or recursion. } > Warning: 2. Keep operators and operands separated to avoid parsing errors. } }


Evaluate a boolean expression with operators !, &, and |.

## Warnings

@Row {
  @Column {
    > Warning: 1. Nested expressions require a reliable stack or recursion.
  }
  @Column {
    > Warning: 2. Keep operators and operands separated to avoid parsing errors.
  }
}

## Problem

- Evaluate a boolean expression with operators !, &, and |.

## Solution

- Use a stack to process tokens until a closing parenthesis is found.
- Apply the operator to the collected operands and push the result.

## Tips

- Normalize tokens to single-character values.
- Test minimal expressions like "t" and nested negations.

## 3‑Minute Script

See full script: <doc:script-1106-parsing-a-boolean-expression>

## Interview Framing

Questions to expect:

- What invariant or state do you maintain?
- What is the time and space complexity?
- Which edge cases would you test first?
- How would you optimize for larger inputs?
- What alternative approach would you mention and why?

Game-specific prompts:

- How do you model the state and transitions?
- What is the terminal condition or win criteria?
- Where can you prune, memoize, or update incrementally?
- How would you scale to larger inputs or more players?
- Which data structures keep updates fast and traceable?
