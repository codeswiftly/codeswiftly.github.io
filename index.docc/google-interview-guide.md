# Google Interview Guide


@Metadata {
  @TitleHeading("Review Google Interview Guide")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Google interviews often emphasize clean problem solving, clear communication, and correctness under
constraints.

## Quick Start

- Run one timed coding drill and narrate tradeoffs.
- Walk one system/API design prompt end-to-end (constraints, risks, failure modes).
- Capture gaps and update your prep plan.

## Core Signals

- Clear reasoning and complexity awareness: <doc:coding-interview>
- System design tradeoffs and end-to-end flows: <doc:system-design-and-api>
- Behavioral clarity and decision-making: <doc:behavioral>
- Rehearsal cadence and reflection: <doc:practice-platforms>, <doc:preparation>

## Interview Loop

1) Clarify constraints and success metrics.  
2) Solve with clean Swift and correct edge-case handling.  
3) Explain performance, tradeoffs, and failure modes.  
4) Reflect, fix, and add drills.

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

## Artifacts

Written statement (private; see `job-hunting/Google/Statement.md` outside this bundle).

## Topics

### Start Here


### Practice

- <tutorial:concurrency-quiz>
