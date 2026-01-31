@PageImage(purpose: icon, source: "preparation-icon.codex", alt: "Placeholder icon")
# Preparation

@Metadata {
  @TitleHeading("Review Preparation")
  @PageImage(purpose: icon, source: "preparation-pencil-icon.codex", alt: "Preparation pencil icon")
  @PageImage(purpose: card, source: "preparation-card.codex", alt: "Preparation card")
}

@Image(source: "preparation-hero.codex", alt: "Preparation hero")

## Working Rhythm

Use this map to keep each session focused and consistent.

### Plan the Arc ✍️

- **Start** with **Preparation** to set your study plan and materials.
- **Use** **Coding Interview** to practice whiteboard tasks in Swift and polish problem framing.
- **Review** **System Design** for mobile-oriented scenarios (offline, sync, caching).
- **Finish** with **Behavioral** and **Day-Of** to sharpen stories and logistics.

### Practice Cadence 🎯

- Practice out loud with timed runs (`35-45 minutes`) in Swift.
- Run the tutorial for an end-to-end rehearsal of prep, coding, and behavioral segments.

### Quality Signals ✅

- Favor clarity: type safety, determinism, and thoughtful error handling.
- Call out tradeoffs and platform specifics (memory, concurrency, UI/threading).
- Keep answers structured: `situation -> constraint -> approach -> testing -> risks`.
- Use the **Quick Sheet** to recall Swift-specific patterns and common data structure fallbacks.
- Practice with the `CoderPad` checklist before Apple/Meta rounds.

## Signals & Drills

### What Interviewers Look for

- Clear reasoning with explicit tradeoffs.
- Correctness (edge cases) and complexity awareness.
- Calm iteration: fix mistakes quickly without thrashing.

### How to Practice

Pick one signal, read the linked article end-to-end, then run the drill on a timer.
For the knowledge inventory (keywords, core types, algorithms), use <doc:swift-skill-map>.
For longer, domain-heavy reads (like data pipelines), use <doc:deep-dives>.

Signal | Read | Drill
------ | ---- | -----
API design reasoning | <doc:system-design> | <doc:apple-wallet-api-design>
Concurrency | <doc:concurrency-beginners-guide> | <tutorial:concurrency-quiz>
Algorithms + data structures | <doc:swift-main-data-structures>, <doc:custom-data-structures-reference> | <doc:top-15-patterns>
Performance + complexity | <doc:swift-quick-sheet> | <doc:stockmarket-rate-limiter>
Networking + sessions | <doc:system-design-deep-dive-finance-trading> | <doc:apple-wallet-nonce-and-session-design>

## Session Loop

@Row {
  @Column {
    **Plan**
    Start with the prep checklist and define time blocks.
  }
  @Column {
    **Practice**
    Run a timed drill and talk through the approach out loud.
  }
  @Column {
    **Reflect**
    Capture mistakes, verify fixes, and update your notes.
  }
}

## Featured Drills

- <tutorial:wallet-add-pass-to-wallet>
- <tutorial:pattern-prefix-sum-practice>

## Targets and Roles

- Clarify the role: product engineer vs. framework/platform vs. infra/backend Swift.
- Align on stack: UIKit, SwiftUI, Combine, concurrency, server-side Swift, CI/CD.
- Map company values and products to your stories and portfolio.

## Study Plan (7-10 Days)

Day Range | Focus | Notes
--------- | ----- | -----
Days 1-2 | Swift Fundamentals | Value/reference semantics, optionals, protocol-oriented design.
Days 3-4 | Concurrency | Structured concurrency, tasks, actors, cancellation, priority inversion.
Day 5 | UI | SwiftUI vs. UIKit tradeoffs, layout performance, accessibility.
Day 6 | Networking | URLSession flows, caching, retries/backoff, offline-first patterns.
Day 7 | Data | Codable pitfalls, Codable vs. JSONDecoder strategies, persistence (Core Data, SQLite).
Days 8-10 | Mixed Mocks | Combine coding + behavioral under timebox, refine succinct explanations.

## Portfolio and Artifacts

- Ship a small demo app or Swift package that mirrors the company domain.
- Add clear README and DocC snippets; include tests and coverage badges if possible.
- Prepare code samples that show:
  - Type-safe APIs (clear models, enums for states and errors).
  - Deterministic behaviors (idempotent operations, retries, testable seams).
  - Performance awareness (measurement, profiling, async boundaries).

## Practice Reps

- Mix easy/medium algorithm questions; bias to array/string/hashmap with Swift Testing harnesses.
- Rehearse common patterns: two-pointer, sliding window, BFS/DFS, binary search, heap/priority
  queue, intervals/merge, topological sort.
- Practice explaining time/space, alternatives, and failure modes.
- Do at least two mock interviews with strict timing and verbal reasoning.

## Device, Tools, and Environment

- Update Xcode and Swift toolchains; confirm simulator devices download.
- Prepare snippets for CommonShell/CommonProcess examples if subprocess execution arises.
- Set up a clean branch or playground for on-the-spot coding; prefer Swift Testing over XCTest.
- Validate build + tests before the interview so you can screen share with confidence.
