# LeetCode 241: Different Ways to Add Parentheses


@Metadata {
  @CallToAction(url: "https://leetcode.com/problems/different-ways-to-add-parentheses/", label: "Solve on LeetCode")
}


> Warning: 1. Without memoization, repeated subexpressions explode. } > Warning: 2. Parse numbers carefully; expressions can be multi-digit. } }


Return all possible results from adding parentheses in an expression.

## Warnings

@Row {
  @Column {
    > Warning: 1. Without memoization, repeated subexpressions explode.
  }
  @Column {
    > Warning: 2. Parse numbers carefully; expressions can be multi-digit.
  }
}

## Problem

- Return all possible results from adding parentheses in an expression.

## Solution

- Divide-and-conquer on each operator and memoize results for substrings.
- Combine left/right results for each operator.

## Tips

- Use a dictionary keyed by substring range.
- Test single-number expressions and mixed operators.

## 3‑Minute Script

See full script: <doc:script-241-different-ways-to-add-parentheses>

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
