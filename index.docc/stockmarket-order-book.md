# Stockmarket Order Book

@PageImage(purpose: icon, source: "stockmarket-order-book-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Stockmarket order book")
  @PageImage(purpose: card, source: "stockmarket-order-book-card.codex", alt: "Stockmarket order book card")
}

@Image(source: "stockmarket-order-book-hero.codex", alt: "Stockmarket order book hero")

## Overview

Order books model buy and sell interest at price levels. Interviews use them to probe data
structures, matching logic, and correctness under concurrent updates.

## Signals to Hit

- Explain bid/ask separation and price-time priority.
- Choose data structures for fast best-price lookups.
- Show how you keep the book consistent under updates.

## Core Structure

- Two heaps or sorted maps: max-heap for bids, min-heap for asks.
- Each price level stores a queue of orders (FIFO by time).
- Match on insert: cross the spread until one side empties.

## Interview Checklist

1. Define how you represent an order (price, size, timestamp).
2. Show update paths (add, cancel, match, partial fill).
3. Talk about latency, memory, and replayability.
