# Gaming Deep Dive


@Metadata {
  @PageColor(purple)
  @TitleHeading("Gaming Deep Dive")
  @CallToAction(url: "doc:apple-gaming-leetcode-1275-find-winner-on-a-tic-tac-toe-game", label: "Start warmup: Tic‑Tac‑Toe")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Game‑focused LeetCode progression: model state, simulate rules, and prove correctness with small tests.

This deep dive is used by the Apple company guide: <doc:os-interview-guide>.

> Note: Say the invariant aloud first (what state do you maintain?).

> Warning: Avoid ad‑hoc updates. Use a single source of truth for board state and timestamps.

> Important: After coding, re‑derive time/space and list 3 edge cases you tested.

## Guide Notes

- Do Phase 1 then Phase 2 in order for signal‑rich reps.
- Pick one capstone from Phase 3 and narrate tradeoffs (design + tests).
- If time remains, switch to <doc:finance-deep-dive> (stocks + order books).

## Interview‑night Focus

### Phase 0 — Baseline Harness (Once)

- Create a single Swift CoderPad harness you reuse for every problem: tiny `expect(actual, == expected)` helper and a main that runs tests.

### Phase 1 — Core Game Archetypes (High‑yield)

Winner detection (incremental counters)

- <doc:apple-gaming-leetcode-1275-find-winner-on-a-tic-tac-toe-game>
- <doc:apple-gaming-leetcode-348-design-tic-tac-toe>

Movement + collisions (snake‑style simulation)

- <doc:apple-gaming-leetcode-657-robot-return-to-origin>
- <doc:apple-gaming-leetcode-874-walking-robot-simulation>
- <doc:apple-gaming-leetcode-353-design-snake-game>

Reveal and cascade (minesweeper flood‑fill)

- <doc:apple-gaming-leetcode-733-flood-fill>
- <doc:apple-gaming-leetcode-529-minesweeper>

### Phase 2 — CTCI Game‑like Recursion/DP

Permutations

- <doc:apple-gaming-leetcode-46-permutations>
- <doc:apple-gaming-leetcode-47-permutations-ii>

Hanoi

- <doc:apple-gaming-leetcode-lcci-08-06-hanota>

N‑Queens

- <doc:apple-gaming-leetcode-51-n-queens>
- <doc:apple-gaming-leetcode-52-n-queens-ii>

Parenthesization / Boolean evaluation

- <doc:apple-gaming-leetcode-241-different-ways-to-add-parentheses>
- <doc:apple-gaming-leetcode-1106-parsing-a-boolean-expression>

### Phase 3 — Ordering, Stacks, Outcomes

Stacking/order DP

- <doc:apple-gaming-leetcode-1691-maximum-height-by-stacking-cuboids>
- <doc:apple-gaming-leetcode-354-russian-doll-envelopes>

Winner‑style outcomes

- <doc:apple-gaming-leetcode-2682-find-the-losers-of-the-circular-game>
- <doc:apple-gaming-leetcode-1535-find-the-winner-of-an-array-game>
- <doc:apple-gaming-leetcode-1823-find-the-winner-of-the-circular-game>

## Scripts (3‑Minute Beats)

@Links(visualStyle: detailedGrid) {

- <doc:script-348-design-tic-tac-toe>
- <doc:script-46-permutations>
- <doc:script-lcci-08-06-hanota>
- <doc:script-51-n-queens>
- <doc:script-52-n-queens-ii>
- <doc:script-241-different-ways-to-add-parentheses>
- <doc:script-1106-parsing-a-boolean-expression>
- <doc:script-1691-maximum-height-by-stacking-cuboids>
- <doc:script-354-russian-doll-envelopes>
- <doc:script-2682-find-the-losers-of-the-circular-game>
- <doc:script-1535-find-the-winner-of-an-array-game>
- <doc:script-1823-find-the-winner-of-the-circular-game>

}

## Walkthrough Articles (LeetCode)

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1275-find-winner-on-a-tic-tac-toe-game>
- <doc:leetcode-348-design-tic-tac-toe>
- <doc:leetcode-657-robot-return-to-origin>
- <doc:leetcode-874-walking-robot-simulation>
- <doc:leetcode-353-design-snake-game>
- <doc:leetcode-733-flood-fill>
- <doc:leetcode-529-minesweeper>
- <doc:leetcode-46-permutations>
- <doc:leetcode-47-permutations-ii>
- <doc:leetcode-lcci-08-06-hanota>
- <doc:leetcode-51-n-queens>
- <doc:leetcode-52-n-queens-ii>
- <doc:leetcode-241-different-ways-to-add-parentheses>
- <doc:leetcode-1106-parsing-a-boolean-expression>
- <doc:leetcode-1691-maximum-height-by-stacking-cuboids>
- <doc:leetcode-354-russian-doll-envelopes>
- <doc:leetcode-2682-find-the-losers-of-the-circular-game>
- <doc:leetcode-1535-find-the-winner-of-an-array-game>
- <doc:leetcode-1823-find-the-winner-of-the-circular-game>
- <doc:leetcode-1496-path-crossing>
- <doc:leetcode-999-available-captures-for-rook>
- <doc:leetcode-909-snakes-and-ladders>
- <doc:leetcode-752-open-the-lock>
- <doc:leetcode-773-sliding-puzzle>
- <doc:leetcode-289-game-of-life>
- <doc:leetcode-723-candy-crush>

}

### Movement & Simulation Extras

@Links(visualStyle: detailedGrid) {

- <doc:apple-gaming-leetcode-1496-path-crossing>

}

##### Chessboard Mini-Games (Quick Rules)

@Links(visualStyle: detailedGrid) {

- <doc:apple-gaming-leetcode-999-available-captures-for-rook>

}

#### Phase 4 - Medium Set (Interview Core)

##### Graph BFS "Minimum Moves"

@Links(visualStyle: detailedGrid) {

- <doc:apple-gaming-leetcode-909-snakes-and-ladders>
- <doc:apple-gaming-leetcode-752-open-the-lock>
- <doc:apple-gaming-leetcode-773-sliding-puzzle>

}

##### Board Simulation and Stabilize

@Links(visualStyle: detailedGrid) {

- <doc:apple-gaming-leetcode-289-game-of-life>
- <doc:apple-gaming-leetcode-723-candy-crush>

}

#### Phase 5 - Hard Capstones (Pick 1-2)

#### How to Execute Each Problem (Repeatable Loop)

1. Write 6-12 tests first: smallest case, invalid/bounds, one "trap edge", then normal.
1. State the invariant before coding.
1. Implement; then do a 2-3 minute cleanup pass for naming and structure.

If you want a strict calendar: run Phase 1 and Phase 2 in the first 4 sessions, then Phase 4,
then pick one hard from Phase 5.
