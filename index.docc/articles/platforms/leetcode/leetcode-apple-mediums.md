
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-apple-mediums-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-apple-mediums-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-apple-mediums-icon.codex", alt: "Placeholder icon")
# Apple-Focused LeetCode Mediums

@Metadata {
  @TitleHeading("Review Apple-Focused LeetCode Mediums")
  @PageImage(purpose: icon, source: "track-practice-icon.codex", alt: "Practice track icon")
  @PageImage(purpose: card, source: "track-practice-icon.codex", alt: "Practice track icon")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

Curated list of medium-difficulty questions that show up frequently in Apple Wallet / Core OS /
Services interviews. Use it as a study queue and link to the detailed articles (or create new ones)
using the `LeetCode page pattern`.

## Official Apple Monthly Sets (2025)

### April Set

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-1372-longest-zigzag-path>
- <doc:leetcode-560-subarray-sum-equals-k>
- <doc:leetcode-1207-unique-number-of-occurrences>
- <doc:leetcode-roman-to-integer>
- <doc:leetcode-206-reverse-linked-list>
- <doc:leetcode-121-best-time-stock>
- <doc:leetcode-4-median-two-sorted-arrays>
- <doc:leetcode-42-trapping-rain-water>
- <doc:leetcode-53-maximum-subarray>
- <doc:leetcode-26-remove-duplicates-from-sorted-array>
- <doc:leetcode-20-valid-parentheses>
- <doc:leetcode-3-longest-substring-no-repeat>

}

### March Set

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-39-combination-sum>
- <doc:leetcode-273-integer-to-english-words>
- <doc:leetcode-2439-minimize-maximum-array>
- <doc:leetcode-14-longest-common-prefix>
- <doc:leetcode-595-big-countries>

}

### February Set

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-200-number-of-islands>
- <doc:leetcode-692-top-k-frequent-words>
- <doc:leetcode-295-find-median-data-stream>
- <doc:leetcode-1642-farthest-building>
- <doc:leetcode-36-valid-sudoku>

}

> Tip: keep a Kanban board for these lists. Mark which ones have full write-ups, which are partially
> solved, and which need concurrency extensions.

## Drill Pages and Links

These are the canonical drill pages to keep up to date. The problem groupings below are just
formatting; the `<doc:…>` links remain the source of truth.

### Trees and Graphs

  length) down the recursion.
  grid bounds, and iterative vs recursive approaches.

### Arrays, DP, and Prefix Techniques

  target sum” pattern.
  streaming metrics pattern.
  “best sub-structure so far”.
  for numeric reasoning and invariants.
  boundary-handling and “search answer space” technique.
  (left/right max heights) and implementation tradeoffs.

### Strings and Parsing

  show up often in Apple interviews.
  before more complex parsers.
  search trees.
  to talk about internationalization and edge cases.

### Heaps, Priority, and Greedy

  sort predicates and tie-breaking.
  statistics.
  reasoning about “when to use ladders vs bricks”.

### Validation and Constraints

  sub-grids); good exercise in mapping invariants to data structures.

### Linked Lists

  variants.

### SQL Data Access

  requirements to concrete SELECT/FROM/WHERE.

### Previously Documented Overlaps

- <doc:linked-list-reversal>
- <doc:quick-sort>

These already have full write-ups and overlap with the Apple monthly sets; use them as references
rather than rewriting from scratch.

## How to Work Through Them

1. **Rehearse API-safe Swift**: create a single `Solution` type per problem; avoid globals; prefer
   descriptive naming.
2. **Concurrency add-on**: after solving, sketch how you would shard the work with `TaskGroup` or an
   actor. Example: build islands counting via per-row tasks merged serially.
3. **Explain tradeoffs**: for each problem, write 2–3 sentences covering time/space complexity,
   failure modes, and how you would adapt for production (validation, streaming input, logging).
4. **Link artifacts**: when you expand any problem into a full article, add it to this table and to
   `Navigation groups` → “LeetCode drills”.
5. **Dry runs**: re-implement the top three (3Sum, LRU Cache, Longest Substring) in a single sitting
   to mimic interview fatigue.

## References

- See `leetcode-roman-to-integer.md`, `leetcode-14-longest-common-prefix.md`,
  `leetcode-26-remove-duplicates-from-sorted-array.md`, and `linked-list-reversal.md` for existing
  detailed write-ups.
- Use a consistent “Problem → Ideas → Constraints → Swift solution → Tests → Interview framing”
  structure when adding new articles.
