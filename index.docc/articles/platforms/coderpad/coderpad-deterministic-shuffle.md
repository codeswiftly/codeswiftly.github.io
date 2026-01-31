@PageImage(purpose: card, source: "platforms-coderpad-coderpad-deterministic-shuffle-card.codex", alt: "Placeholder card")
@Image(source: "platforms-coderpad-coderpad-deterministic-shuffle-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-coderpad-coderpad-deterministic-shuffle-icon.codex", alt: "Placeholder icon")
# CoderPad: Deterministic “Top/Bottom” Shuffle

@Metadata {
  @TitleHeading("Review CoderPad: Deterministic “Top/Bottom” Shuffle")
  @PageImage(purpose: icon, source: "difficulty-medium.codex", alt: "Medium problem")
  @PageImage(purpose: card, source: "coderpad-deterministic-shuffle-card.codex", alt: "CoderPad Deterministic Top Bottom Shuffle card")
}

@Image(source: "coderpad-deterministic-shuffle-hero.codex", alt: "CoderPad Deterministic Top Bottom Shuffle hero")

## Overview

- Build a second pile from the original deck:
  1) First card goes on top of the second pile.
  2) Next card goes to the bottom.
  3) Next goes to the top.
  4) Repeat bottom, top, … until empty.
- Goal: return the final order (top-first) of the second pile.

## Direct Simulation (Clear, Uses Insert at 0)

```swift
class Solution {
  func shuffleDeck(_ originalDeck: [String]) -> [String] {
    guard !originalDeck.isEmpty else { return [] }

    var secondPile: [String] = []
    secondPile.append(originalDeck[0])  // first card on top

    var placeBottom = true
    for i in 1..<originalDeck.count {
      let card = originalDeck[i]
      if placeBottom {
        secondPile.append(card)  // bottom
      } else {
        secondPile.insert(card, at: 0)  // top (O(n))
      }
      placeBottom.toggle()
    }
    return secondPile
  }
}
```

- Complexity: `insert(_:at: 0)` shifts, so worst-case O(n²); fine for 52 cards.

## Pattern-based O(n) Solution (Append-only)

- Observation: final order is even indices descending, then odd indices ascending.
- Example n=5: original [c0,c1,c2,c3,c4] → [c4,c2,c0,c1,c3].

```swift
class Solution {
  func shuffleDeck(_ originalDeck: [String]) -> [String] {
    let n = originalDeck.count
    guard n > 0 else { return [] }

    var shuffled: [String] = []
    shuffled.reserveCapacity(n)

    // Evens descending
    var even = (n % 2 == 0) ? n - 2 : n - 1
    while even >= 0 {
      shuffled.append(originalDeck[even])
      even -= 2
    }

    // Odds ascending
    var odd = 1
    while odd < n {
      shuffled.append(originalDeck[odd])
      odd += 2
    }

    return shuffled
  }
}
```

- Complexity: O(n) time; O(n) space for output (required anyway).

## How to Narrate

- Rule: first card starts the new pile on top; then alternate bottom/top.
- Direct sim: append for bottom, insert at 0 for top; matches the process.
- Optimization: recognize the induced permutation (evens descending, odds ascending) and build with
  appends only.
- Mention costs in Swift: insert at 0 shifts; append is amortized O(1).
