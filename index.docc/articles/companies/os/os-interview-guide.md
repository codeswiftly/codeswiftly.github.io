# OS Interview Guide


@Metadata {
  @TitleHeading("OS Interview Guide")
  @PageColor(indigo)
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


OS interviews emphasize clean reasoning, API design, and correctness under constraints. Use this
guide to rehearse cross-platform fundamentals and platform-specific depth.

## Quick Start

- Run one timed coding drill and narrate tradeoffs.
- Walk one system/API design prompt end-to-end (constraints, risks, failure modes).
- Capture gaps and update your prep plan.

## Core Signals

- API design reasoning: <doc:system-design-and-api>, <doc:apple-wallet-api-design>
- Concurrency and synchronization: <doc:concurrency-dispatch-design>
- Data processing and correctness: <doc:apple-wallet-iso18013-data-processing>
- Clear reasoning and complexity awareness: <doc:coding-interview>
- Behavioral clarity and decision-making: <doc:behavioral>
- Rehearsal cadence and reflection: <doc:practice-platforms>, <doc:preparation>

## Interview Loop

1) Clarify constraints and success metrics.  
2) Solve with clean Swift and correct edge-case handling.  
3) Explain performance, tradeoffs, and failure modes.  
4) Reflect, fix, and add drills.

## Platform API Focus

- API design and identity flows.
- Data processing, serialization, and correctness.
- Concurrency and performance tradeoffs.

## Problem-Solving Focus

- Clean problem solving and correctness under constraints.
- Clear communication and complexity reasoning.
- System design tradeoffs and end-to-end flows.

## Prompts and Snippets

Traveling Salesman / N-choose-K; NP-complete prompts. Concurrency: semaphore vs. mutex lock.
Circular array traversal snippet:

```swift
func isCircular(array: [Int]) -> Bool {
  let count = array.count
  var iteration = 0
  var next = 0
  var seen = Set<Int>()

  while iteration <= count {
    let value = array[next] % count
    if iteration == count {
      return value == 0
    } else if seen.contains(value) {
      return false
    }
    seen.insert(value)
    next = value
    iteration += 1
  }
  return false
}
```

## Topics

### Start Here

- <doc:company-guides>
- <doc:apple>
- <doc:system-design>

### Platform System and API Design

- <doc:apple-wallet-credential-store-design>

### Wallet and Identity

- <doc:apple-wallet-passkit-wallet-apis>
- <doc:apple-wallet-requesting-identity-data-design>
- <doc:apple-passkit-common-api-practices>
- <doc:apple-passkit-traversal>

### Algorithms and References

- <doc:leetcode-apple-mediums>
- <doc:finance-deep-dive>
- <doc:linked-list-reversal>
- <doc:leetcode-273-integer-to-english-words>
- <doc:leetcode-200-number-of-islands>

### Practice

- <doc:practice-platforms>
- <doc:preparation>
- <tutorial:concurrency-quiz>
