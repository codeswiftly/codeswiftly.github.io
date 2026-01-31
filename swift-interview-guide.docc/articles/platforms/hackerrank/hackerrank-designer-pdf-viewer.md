
@PageImage(purpose: card, source: "platforms-hackerrank-hackerrank-designer-pdf-viewer-card.codex", alt: "Placeholder card")
@Image(source: "platforms-hackerrank-hackerrank-designer-pdf-viewer-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-hackerrank-hackerrank-designer-pdf-viewer-icon.codex", alt: "Placeholder icon")
# HackerRank -- Designer Pdf Viewer

@Metadata {
  @TitleHeading("Review HackerRank -- Designer Pdf Viewer")
  @PageImage(purpose: icon, source: "difficulty-easy.codex", alt: "Easy problem")
  @PageImage(purpose: card, source: "hackerrank-designer-pdf-viewer-card.codex", alt: "HackerRank Designer Pdf Viewer card")
}

@Image(source: "hackerrank-designer-pdf-viewer-hero.codex", alt: "HackerRank Designer Pdf Viewer hero")

## Problem Restatement

Given heights for each lowercase letter (`h[26]`) and a word, find the highlighted area: width is
`word.count` and height is the tallest letter in the word. Return `width * maxHeight`.

## Core Ideas

- Map each character to its alphabet index (`asciiValue - asciiValue("a")`).
- Track the maximum height across the word; multiply by word length.

## Constraints and Complexity

- `h.count == 26`, word length up to 10^3 (per problem limits).
- Time: `O(n)`; Space: `O(1)`.

## Edge Cases

- Single-character word.
- All letters same height.
- Mixed heights; ensure lowercase indexing.

## Swift Notes

- `asciiValue` gives a `UInt8`; subtract `"a".asciiValue!` to get 0-based index.
- Avoid `% 26`—it misindexes (`"a".asciiValue` is 97).

## Swift Solution

```swift
func designerPdfViewer(h: [Int], word: String) -> Int {
  let aValue = Character("a").asciiValue!
  let tallest = word.reduce(into: 0) { currentMax, ch in
    currentMax = max(currentMax, h[Int(ch.asciiValue! - aValue)])
  }
  return word.count * tallest
}
```

## Quick Tests

```swift
let h = [1, 3, 1, 3, 1, 4, 1, 3, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 7]
assert(designerPdfViewer(h: h, word: "zaba") == 28)
assert(designerPdfViewer(h: h, word: "a") == 1)
```

## Interview Framing

- Call out the ASCII offset to avoid wrong indices; `% 26` fails for ASCII codes.
- Mention overflow is not an issue with the given bounds.***
