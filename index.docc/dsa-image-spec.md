# DSA Image Spec

@PageImage(purpose: card, source: "dsa-image-spec-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "dsa-image-spec-icon.codex", alt: "Placeholder icon")

@Image(source: "dsa-image-spec-hero.codex", alt: "DSA image spec hero")

Use this spec for DocC images attached to LeetCode DSA problem pages. This is the baseline for
LeetCode only; HackerRank/CoderPad will follow the same conventions with different prefixes.

## Required Images Per Problem

Each LeetCode problem page must include four assets:

- Favicon (DocC icon): `leetcode-<slug>-dsa-icon.svg`
- Card (DocC tile): `leetcode-<slug>-dsa-card.svg`
- Hero (DocC hero): `leetcode-<slug>-dsa-hero.svg`
- Top image (inline): `leetcode-<slug>-dsa-top.svg`

Inline top image should appear near the top of the page body, right after the metadata block.

## Metadata Wiring

Every LeetCode problem page uses the following metadata fields:

- `@PageImage(purpose: icon)` -> icon
- `@PageImage(purpose: card)` -> card
- `@PageImage(purpose: hero)` -> hero
- `@Image` -> top image (inline)

## Difficulty Colors

- Easy: `#27D3A6`
- Medium: `#F5C453`
- Medium-Hard: `#F08B5D`
- Hard: `#E5566D`

## Pattern Numbering

Use the Top 15 patterns as the numeric system for badge numbers.

| Pattern # | Pattern |
| --- | --- |
| 1 | Prefix Sum |
| 2 | Two Pointers |
| 3 | Sliding Window |
| 4 | Overlapping Intervals |
| 5 | Modified Binary Search |
| 6 | Fast/Slow Pointers |
| 7 | In-Place Reversal |
| 8 | Monotonic Stack |
| 9 | Top-K Heap |
| 10 | Tree BFS |
| 11 | DFS |
| 12 | Graph BFS |
| 13 | Matrix Traversal |
| 14 | Backtracking |
| 15 | Dynamic Programming |

## Text and Contrast Rules

- Non-DP patterns: all text is white on the difficulty color background.
- When text is white, add a thin black stroke for legibility on gradients.
- Dynamic Programming (Pattern 15): text is black with a subtle white outline so it reads on any
  difficulty background.
- Favicons show only the pattern number (no difficulty label); use a thin stroke around the number
  for contrast.
- Avoid SVG `foreignObject` for text. Use plain `<text>` so DocC reliably renders labels.

## Card Icon Rule

Card assets must include a semi-generic symbol for the DSA pattern type (not problem-specific).
Hero assets can evolve to problem-specific visuals later; current assets are placeholders.
Cards use a subtle gradient from the previous difficulty color (top-left) to the next difficulty
color (bottom-right), with a soft mid-tone stop to keep the blend cinematic, plus a thin border to
boost contrast against the background.

## LeetCode Mapping

| Problem | Slug | Pattern # | Pattern | Difficulty |
| --- | --- | --- | --- | --- |
| LeetCode - Roman to Integer (Apple-Style) | leetcode-roman-to-integer | 2 | Two Pointers | Easy |
| LeetCode 1071: Greatest Common Divisor of Strings | leetcode-1071-greatest-common-divisor-of-strings | 2 | Two Pointers | Easy |
| LeetCode 1106: Parsing A Boolean Expression | leetcode-1106-parsing-a-boolean-expression | 8 | Monotonic Stack | Hard |
| LeetCode 1207: Unique Number of Occurrences | leetcode-1207-unique-number-of-occurrences | 1 | Prefix Sum | Easy |
| LeetCode 121: Best Time to Buy and Sell Stock | leetcode-121-best-time-stock | 3 | Sliding Window | Easy |
| LeetCode 122: Best Time to Buy and Sell Stock II | leetcode-122-best-time-to-buy-and-sell-stock-ii | 3 | Sliding Window | Easy |
| LeetCode 123: Best Time to Buy and Sell Stock III | leetcode-123-best-time-to-buy-and-sell-stock-iii | 15 | Dynamic Programming | Hard |
| LeetCode 1275: Find Winner on a Tic Tac Toe Game | leetcode-1275-find-winner-on-a-tic-tac-toe-game | 13 | Matrix Traversal | Easy |
| LeetCode 1372: Longest Zigzag Path in a Binary Tree | leetcode-1372-longest-zigzag-path | 10 | Tree BFS | Medium |
| LeetCode 14: Longest Common Prefix | leetcode-14-longest-common-prefix | 2 | Two Pointers | Easy |
| LeetCode 1496: Path Crossing | leetcode-1496-path-crossing | 13 | Matrix Traversal | Easy |
| LeetCode 1535: Find the Winner of an Array Game | leetcode-1535-find-the-winner-of-an-array-game | 2 | Two Pointers | Easy |
| LeetCode 1642: Farthest Building You Can Reach | leetcode-1642-farthest-building | 9 | Top-K Heap | Medium |
| LeetCode 1691: Maximum Height by Stacking Cuboids | leetcode-1691-maximum-height-by-stacking-cuboids | 4 | Overlapping Intervals | Hard |
| LeetCode 1801: Number of Orders in the Backlog | leetcode-1801-number-of-orders-in-the-backlog | 9 | Top-K Heap | Medium |
| LeetCode 1823: Find the Winner of the Circular Game | leetcode-1823-find-the-winner-of-the-circular-game | 6 | Fast/Slow Pointers | Medium |
| LeetCode 188: Best Time to Buy and Sell Stock IV | leetcode-188-best-time-to-buy-and-sell-stock-iv | 15 | Dynamic Programming | Hard |
| LeetCode 20: Valid Parentheses | leetcode-20-valid-parentheses | 8 | Monotonic Stack | Easy |
| LeetCode 200: Number of Islands | leetcode-200-number-of-islands | 11 | DFS | Medium |
| LeetCode 2034: Stock Price Fluctuation | leetcode-2034-stock-price-fluctuation | 8 | Monotonic Stack | Medium |
| LeetCode 206: Reverse Linked List | leetcode-206-reverse-linked-list | 7 | In-Place Reversal | Easy |
| LeetCode 241: Different Ways to Add Parentheses | leetcode-241-different-ways-to-add-parentheses | 15 | Dynamic Programming | Medium |
| LeetCode 2439: Minimize Maximum of Array | leetcode-2439-minimize-maximum-array | 5 | Modified Binary Search | Medium |
| LeetCode 26: Remove Duplicates from Sorted Array | leetcode-26-remove-duplicates-from-sorted-array | 2 | Two Pointers | Easy |
| LeetCode 2682: Find the Losers of the Circular Game | leetcode-2682-find-the-losers-of-the-circular-game | 6 | Fast/Slow Pointers | Easy |
| LeetCode 273: Integer to English Words | leetcode-273-integer-to-english-words | 2 | Two Pointers | Hard |
| LeetCode 289: Game of Life | leetcode-289-game-of-life | 13 | Matrix Traversal | Medium |
| LeetCode 29: Divide Two Integers | leetcode-29-divide-two-integers | 5 | Modified Binary Search | Medium |
| LeetCode 295: Find Median from Data Stream | leetcode-295-find-median-data-stream | 9 | Top-K Heap | Hard |
| LeetCode 3: Longest Substring without Repeating Characters | leetcode-3-longest-substring-no-repeat | 3 | Sliding Window | Medium |
| LeetCode 33: Search in Rotated Sorted Array | leetcode-33-search-rotated-sorted-array | 5 | Modified Binary Search | Medium |
| LeetCode 348: Design Tic-Tac-Toe | leetcode-348-design-tic-tac-toe | 13 | Matrix Traversal | Medium |
| LeetCode 353: Design Snake Game | leetcode-353-design-snake-game | 13 | Matrix Traversal | Medium |
| LeetCode 354: Russian Doll Envelopes | leetcode-354-russian-doll-envelopes | 4 | Overlapping Intervals | Hard |
| LeetCode 36: Valid Sudoku | leetcode-36-valid-sudoku | 13 | Matrix Traversal | Medium |
| LeetCode 39: Combination Sum | leetcode-39-combination-sum | 14 | Backtracking | Medium |
| LeetCode 4: Median of Two Sorted Arrays | leetcode-4-median-two-sorted-arrays | 5 | Modified Binary Search | Hard |
| LeetCode 42: Trapping Rain Water | leetcode-42-trapping-rain-water | 8 | Monotonic Stack | Hard |
| LeetCode 46: Permutations | leetcode-46-permutations | 14 | Backtracking | Medium |
| LeetCode 47: Permutations II | leetcode-47-permutations-ii | 14 | Backtracking | Medium |
| LeetCode 502: IPO | leetcode-502-ipo | 9 | Top-K Heap | Hard |
| LeetCode 51: N-Queens | leetcode-51-n-queens | 14 | Backtracking | Hard |
| LeetCode 52: N-Queens II | leetcode-52-n-queens-ii | 14 | Backtracking | Hard |
| LeetCode 529: Minesweeper | leetcode-529-minesweeper | 13 | Matrix Traversal | Medium |
| LeetCode 53: Maximum Subarray | leetcode-53-maximum-subarray | 15 | Dynamic Programming | Medium |
| LeetCode 560: Subarray Sum Equals K | leetcode-560-subarray-sum-equals-k | 1 | Prefix Sum | Medium |
| LeetCode 595: Big Countries (SQL) | leetcode-595-big-countries | 1 | Prefix Sum | Easy |
| LeetCode 657: Robot Return to Origin | leetcode-657-robot-return-to-origin | 13 | Matrix Traversal | Easy |
| LeetCode 692: Top K Frequent Words | leetcode-692-top-k-frequent-words | 9 | Top-K Heap | Medium |
| LeetCode 723: Candy Crush | leetcode-723-candy-crush | 13 | Matrix Traversal | Medium |
| LeetCode 733: Flood Fill | leetcode-733-flood-fill | 13 | Matrix Traversal | Easy |
| LeetCode 752: Open the Lock | leetcode-752-open-the-lock | 12 | Graph BFS | Medium |
| LeetCode 773: Sliding Puzzle | leetcode-773-sliding-puzzle | 12 | Graph BFS | Hard |
| LeetCode 8: String to Integer (Atoi) | leetcode-8-string-to-integer-atoi | 2 | Two Pointers | Medium |
| LeetCode 874: Walking Robot Simulation | leetcode-874-walking-robot-simulation | 13 | Matrix Traversal | Medium |
| LeetCode 901: Online Stock Span | leetcode-901-online-stock-span | 8 | Monotonic Stack | Medium |
| LeetCode 909: Snakes and Ladders | leetcode-909-snakes-and-ladders | 12 | Graph BFS | Medium |
| LeetCode 999: Available Captures for Rook | leetcode-999-available-captures-for-rook | 13 | Matrix Traversal | Easy |
| LeetCode 23: Merge k Sorted Lists | leetcode-23-merge-k-sorted-lists | 9 | Top-K Heap | Hard |
| LeetCode 76: Minimum Window Substring | leetcode-76-minimum-window-substring | 3 | Sliding Window | Hard |
| LeetCode 84: Largest Rectangle in Histogram | leetcode-84-largest-rectangle-in-histogram | 8 | Monotonic Stack | Hard |
| LeetCode 127: Word Ladder | leetcode-127-word-ladder | 12 | Graph BFS | Hard |
| LeetCode 224: Basic Calculator | leetcode-224-basic-calculator | 8 | Monotonic Stack | Hard |
| LeetCode 297: Serialize and Deserialize Binary Tree | leetcode-297-serialize-and-deserialize-binary-tree | 11 | DFS | Hard |
| LeetCode 1235: Maximum Profit in Job Scheduling | leetcode-1235-maximum-profit-in-job-scheduling | 15 | Dynamic Programming | Hard |
| LeetCode LCCI 08.06: Hanota | leetcode-lcci-08-06-hanota | 14 | Backtracking | Medium |
