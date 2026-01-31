# Coding Interview

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review Coding Interview")
  @PageImage(purpose: icon, source: "coding-interview-icon.codex", alt: "Coding Interview icon")
  @PageImage(purpose: card, source: "coding-interview-card.codex", alt: "Coding Interview card")
}

@Image(source: "coding-interview-hero.codex", alt: "Coding Interview hero")

## Approach

- Restate the problem, inputs, outputs, constraints, and edge cases; confirm data sizes.
- Choose a clear representation first (structs/enums over raw tuples; avoid magic numbers).
- Use Swift Testing-style scaffolds to validate quickly; name tests descriptively.
- Narrate tradeoffs: time/space, determinism, complexity vs. readability.
- Optimize only after correctness; call out when an O(n log n) approach is sufficient.

> Important: Always state a simple brute-force approach out loud before you optimize, and finish by
> explicitly naming the time and space complexity of your final solution.

> Tip: Keep one or two go-to patterns in mind for each problem family (hash maps, sliding windows,
> BFS/DFS) so you can reach for them quickly under pressure.

## Study Plan

Use the 12-week study plan and hard-problem drill list here:

- <doc:coding-interview-study-plan>

## Swift Specifics to Highlight

- Value vs. reference semantics; copy-on-write behavior of Array/String/Dictionary.
- Safe optional handling; prefer guard/early returns; avoid force unwrap.
- Error handling: use typed errors; bubble context with `throws`; prefer Result for async seams.
- Concurrency: structured concurrency, Task groups, actors for isolation, cancellation points.
- Collections: `Dictionary` vs. `OrderedDictionary`, `Set` for uniqueness, `Deque` for queues.
- Use <doc:swift-quick-sheet> as a memory jog for standard library-friendly stack/queue/heap helpers.
- Prefer enum-modeled state when it clarifies invariants and makes edge cases explicit.

## Patterns to Rehearse (with Code)

- Structured concurrency drills: spawn parallel work with `async let`, Task groups, and actors;
  practice limiting task counts and collecting partial failures.
- Dispatch-based concurrency: practice serial vs concurrent queues, dispatch groups, barriers, and
  semaphores; see <doc:concurrency-dispatch-design>.
- Sliding window for substrings/subarrays (longest unique, min window).
- Two-pointer for sorted arrays or linked lists (merge, intersection).
- BFS/DFS on graphs/grids; track visited sets; detect cycles.
- Heap/priority queue for schedules, top-k, or Dijkstra (implement a small binary heap inline).
- Interval merging and sweep-line for calendar/booking problems.
- Dynamic programming: 1D/2D tabulation; space optimization.

## Seven-Step Flow (7 Steps)

Seven steps, every time. Keep the order steady and the signal high.

Step | Name | What To Do
---- | ---- | ----------
**`1`** | Listen For Clues | Restate the prompt, clarify constraints, inputs/outputs, and scope.
**`2`** | Draw An Example | Pick a non-trivial, generic case to surface edge cases.
**`3`** | Brute Force | Outline the obvious correct approach to anchor correctness.
**`4`** | Optimize | Improve time/space; explain tradeoffs and why it fits constraints.
**`5`** | Walk Through The Algo | Dry-run on your example; confirm invariants and order of operations.
**`6`** | Code | Write the clean version you just walked through.
**`7`** | Verification | Test edge cases, state complexity, and call out pitfalls or follow-ups.

## Communication Habits

- State invariants and why they hold; mention how you would test them.
- Flag assumptions (ASCII vs. Unicode scalars, overflow, large n, thread-safety).
- Describe how you would profile or measure if performance is a concern.
- Summarize at the end: approach, complexity, failure cases, and follow-ups.
