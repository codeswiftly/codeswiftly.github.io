# CoderPad Rounds (Apple, Meta)


@Metadata {
  @TitleHeading("Review CoderPad Rounds (Apple, Meta)")
}


Short, camera-on coding rounds with shared pads. Aim for clarity, steady narration, and runnable
snippets.

## Overview

- Targets: Apple and Meta phone/onsite CoderPad rounds.
- Flavor: project-leaning tasks in a shared pad; less algorithm grind, more completeness/clarity.
- Goals: crisp setup, narrated coding, quick assertions, steady pacing.

## Setup Checklist

- Confirm language = Swift 5/6; set monospace font and zoom to 110–125%.
- Paste a minimal harness: `func run() { /* tests */ }`; keep `main` clean.
- Prepare a Swift Testing-style helper in mind, but keep assertions inline if harnessing is heavy.
- Disable autosave/format-on-type if latency is high; be ready to indent manually.

## Flow

- Restate the problem, inputs/outputs, constraints, and edge cases; agree on examples.
- Choose clear representations (struct/enum) and avoid magic numbers.
- Start with the brute-force or simplest correct approach; narrate as you type.
- Add a tiny test block (examples given) before optimizing.
- Summarize complexity, invariants, and how you would extend (error handling, cancelation).

## Snippet Template

```swift
func solve(_ nums: [Int]) -> Int {
  // TODO: implement
}

func run() {
  assert(solve([2, 7, 11, 15]) == 9)
  assert(solve([3, 2, 4]) == 6)
}

run()
```

## Swift Ergonomics Tips (vs. Python)

- Use `Dictionary<Element, Int>` for counts; `Set` for membership; prefer `guard` returns.
- For queues, use `Array` with `removeFirst()` only when n is small; otherwise import `Deque`.
- Prefer enums for state; avoid parallel optionals/booleans.
- Keep mutability explicit (`var`) and avoid force unwraps; handle optionals with early exits.
- If asked to optimize, mention time/space and thread-safety; then adjust data structure or loop.
