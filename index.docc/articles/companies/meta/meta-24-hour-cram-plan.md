# Meta 24-Hour Cram Plan


@Metadata {
  @TitleHeading("Meta 24-hour cram plan")
  @PageColor(blue)
}

You have:

- Monday: 2 coding interviews (Ninja)
- Tuesday: system design interview (Pirate)

This plan optimizes for correctness + narration under time for Monday, then switches to structured
design answers for Tuesday.

## Monday (Coding) — Two Reps, Two Retro Cycles

### 0) Setup (15 Minutes)

- Open these pages side-by-side:
  - <doc:swift-quick-sheet>
  - <doc:top-15-patterns>
  - <doc:coderpad-platform>
- In CodeSwiftly, use Smart Picks → “Meta final coding” to pick one prompt and start typing.

Swift drill template (paste into CodeSwiftly if you need a blank frame):

```swift
// Problem:
// Inputs:
// Output:
// Constraints:
// Example:

// Approach (invariants):
// 1.
// 2.

// Complexity:
// Time:
// Space:

func solution(_ input: [Int]) -> Int {
  // TODO: implement
  return 0
}

// Quick tests:
// print(solution(...))
```

### 1) Rep 1 (45 Minutes)

Pick 1 prompt from:

- <doc:meta-final-coding-first-bad-version>
- <doc:meta-final-coding-set-with-count>
- <doc:meta-final-coding-root-to-leaf-sum>
- <doc:meta-final-coding-grid-paths>

Run it like an interview:

1. Restate problem + constraints
2. Example walk-through
3. Approach + invariants
4. Complexity
5. Swift implementation
6. Test cases (out loud)

### 2) Retro 1 (15 Minutes)

Write down:

- the bug you almost shipped
- the edge case you missed
- the sentence you wish you said sooner

Then skim:

- <doc:swift-strings-gotchas>
- <doc:sorted-array-bounds>

### 3) Rep 2 (45 Minutes)

Pick 1 prompt from:

- <doc:meta-final-coding-move-zeroes>
- <doc:meta-final-coding-valid-word-abbreviation>
- <doc:meta-final-coding-validate-number-string>
- <doc:meta-final-coding-shared-superview>

### 4) Retro 2 (15 Minutes)

- If you froze: re-run the “Plan → Solve → Test” script from <doc:coding-interview>
- If Swift slowed you down: skim <doc:swift-main-data-structures>

## Tuesday (System Design) — One Clean, Rehearsable Answer

### 1) Pick a Primary Scaffold (60–90 Minutes)

- <doc:instagram-meta-system-design>
- <doc:generic-ios-meta-system-design>

Rehearse this shape:

1. Requirements + non-goals
2. Data model
3. Core API surface
4. Storage + caching
5. Sync + conflict resolution
6. Observability (metrics/logging)
7. Failure modes + mitigations

### 2) One Narrative Pass (30 Minutes)

Do one complete out-loud walkthrough without stopping. Then re-read:

- <doc:system-design-and-api>

## Minimal “Night Before” Checklist

- Sleep + hydration (don’t trade clarity for another random problem).
- Pick your default approach phrases (one-liners) for:
  - hash map counting
  - BFS/DFS
  - binary search
  - two pointers
