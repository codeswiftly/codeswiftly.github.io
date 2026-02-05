# Mobile Interview Guide


@Metadata {
  @TitleHeading("Mobile Interview Guide")
  @PageColor(blue)
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Mobile interviews emphasize behavioral depth, system design reasoning, and coding clarity.
This guide anchors the mobile track.

Common loop labels:

- **Behavioral**: culture fit, leadership, workplace challenges
- **Coding**: problem solving, correctness, complexity
- **System design**: tradeoffs, end-to-end flows, constraints

## 24-Hour Cram Plan

- <doc:meta-24-hour-cram-plan>

## How to Run the Mobile Loop

One clean, repeatable rehearsal loop:

1) **Behavioral** — build and rehearse your story bank:
   - <doc:meta-jedi-framework>
   - <doc:behavioral>
2) **Coding** — do a timed coding drill with narration:
   - <doc:algorithms-and-patterns>
   - <doc:swift-gotchas>
3) **System design** — walk an end-to-end flow with explicit tradeoffs:
   - <doc:system-design-and-api>
4) Capture gaps and update your plan:
   - <doc:preparation>
   - <doc:practice-platforms>

## Recent Interview Takeaways

> [!IMPORTANT]
> **Next Round Prep**: Use the <doc:meta-post-interview-1-cram> for the 20-minute review before your next interview.

This section captures concrete takeaways from a recent coding round (CGRect containment + i18n style
pattern matching). The goal is to turn those misses into a repeatable checklist.

### CGRect Containment (CoreGraphics)

- The core comparisons were correct for standard CGRects (non-negative width/height).
- Debuggability mattered: the interviewer agreed that named guards or booleans are easier to test
  than a single compound expression.
- If the problem statement ignores negative sizes, call it out and proceed. Otherwise standardize.

Preferred "debuggable" structure (production-friendly, interview-readable):

```swift
func contains(_ outer: CGRect, _ inner: CGRect) -> Bool {
  let a = outer.standardized
  let b = inner.standardized
  guard a.minX <= b.minX else { return false }
  guard b.maxX <= a.maxX else { return false }
  guard a.minY <= b.minY else { return false }
  guard b.maxY <= a.maxY else { return false }
  return true
}
```

Also call out test harness expectations:

- A "test" must assert the result (do not drop the Bool).
- Name tests accurately (e.g., "shiftedRight" vs "shiftedLeft").

### I18n Abbreviation Matcher (Tokenization + Match)

What was correct:

- The idea to tokenize the pattern into .string and .number segments is sound.
- Multi-digit number accumulation is required and was attempted.

What must be said and done explicitly (high-signal items):

1) **Consume input on string match**: `hasPrefix` is only a check. You must advance by `s.count`.
2) **Bounds check direction**: skipping a number is valid only when `remaining >= length`.
3) **End condition**: success requires the input is fully consumed, not just the tokens.

Accepted "I ran out of time" verbal script:

- "I keep an input pointer that only moves forward."
- "For a string token, I require a prefix match and advance by the string length."
- "For a number token, I require `j + n <= count` and advance by `n`."
- "Return true only if `j == count`."

### Tactics for No-typecheck Environments

- Focus on invariants first, then mechanics. Say the invariants out loud.
- If you choose "tokenize + match," keep the phases separated so you can finish at least one.
- Use guards for each condition; they are easy to debug and hard to misread.

## Swift APIs to Review (from This Interview)

### CoreGraphics

- `CGRect.minX`, `maxX`, `minY`, `maxY` (prefer over `origin + size`).
- `CGRect.standardized` (handles negative width/height).
- `CGRect.contains(_:)`, `CGRect.intersects(_:)`.
- `CGRect.isEmpty`, `CGRect.isNull` (when discussing intersection results).

### Character and String Parsing

- `Character.wholeNumberValue` for digit extraction (preferred).
- `Character.isNumber`, `isLetter`, `isWhitespace` for classification.
- `String(ch)` to append a Character to a String.
- `Int(String(character))` returns an `Int?` for numeric characters (unwrap explicitly).
- `Array(string)` produces `[Character]`, not `[String]`.

### String Indexing and Slicing

- `input.hasPrefix(s)` for prefix checks.
- `input[inputIndex...]` yields a `Substring`.
- `input.index(inputIndex, offsetBy: n, limitedBy: input.endIndex)` for safe advances.
- `input.formIndex(after: &inputIndex)` to move one step forward.
- `removeFirst(_:)` is interview-friendly but can be O(n). Prefer indices for production.

### Stack-style Array Usage

- `array.last`, `array.popLast()`, `array.append(_)` for token merging.
- Avoid mutating a copy of `array.last`; you must `popLast()` then append the new value.

### Quick Micro-checklist for Abbreviation Problems

- Multi-digit numbers handled.
- Skip logic uses `>=` (not `<`).
- Input pointer advances on every successful token.
- End condition is input fully consumed.
- Optional rule: disallow leading zero in numeric segments (clarify with interviewer).

## Legacy Notes (Archived)

This section preserves legacy mobile interview notes. Source paths are archived in the private
workspace for traceability.

## Study Plan

- Mix study time across: Coding HNs, Cracking the Coding Interview, Interview Cake, Objc.io, legacy
  open source libraries.

## Interview Questions (CoderPad Heavy)

- Prompts:
  - Print tree nodes level by level.
  - NSRange intersections; coderpad prompt on NSRange; find intersection between two NSRanges.
  - Grid paths: move right/down; print all paths 0,0 → m,n.
  - Design contact app with online indicator.
  - Closest k restaurants from 1M locations (closest elements).
  - Move zeros to start (minimal rounds).
  - Add two binary numbers; valid palindrome; inorder BST.
  - Memory management: strong/weak/assign/retain.

Closest-k reference snippet:

```swift
func findKClosestElements(_ nums: [Int], _ k: Int, _ x: Int) -> [Int] {
  var lo = 0
  var hi = nums.count - k
  while lo < hi {
    let mid = (lo + hi) / 2
    if x - nums[mid] > nums[mid + k] - x {
      lo = mid + 1
    } else {
      hi = mid
    }
  }
  return Array(nums[lo..<lo + k])
}
```

## Additional Artifacts

- General study artifacts:
- Interview-specific notes and retrospectives are kept in the private bundle.

## Topics

### Practice

- <tutorial:concurrency-quiz>
