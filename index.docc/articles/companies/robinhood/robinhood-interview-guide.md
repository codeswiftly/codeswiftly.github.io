@PageImage(purpose: card, source: "companies-robinhood-robinhood-interview-guide-card.codex", alt: "Placeholder card")
@Image(source: "companies-robinhood-robinhood-interview-guide-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-robinhood-robinhood-interview-guide-icon.codex", alt: "Placeholder icon")
# Robinhood Interview Guide

@Metadata {
  @TitleHeading("Robinhood Interview Guide")
  @PageColor(green)
  @PageImage(purpose: icon, source: "companies-robinhood-robinhood-interview-guide-icon.codex", alt: "Robinhood Interview Guide icon")
  @PageImage(purpose: card, source: "companies-robinhood-robinhood-interview-guide-card.codex", alt: "Robinhood Interview Guide card")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "companies-robinhood-robinhood-interview-guide-hero.codex", alt: "Robinhood Interview Guide hero")

Robinhood interviews emphasize market structure, low-latency systems, and correctness under load.
Use this guide to surface the hardest problems early and map them to trading workflows.

## Quick Start

- Run one hard problem with full narration and invariants.
- Walk an order book or market data system design prompt end-to-end.
- Close with a 5-minute retro: what broke, what to drill next.

## Core Signals

- Order book integrity (matching, cancellations, edge cases).
- Streaming data structures (medians, top-k, volatility windows).
- Concurrency and latency tradeoffs for real-time updates.
- Risk and rate limits (protect the system during spikes).
- Swift clarity: explicit invariants, safe updates, testability.

## Hard Problems to Surface

Problem | Signal | Why it is hard
------ | ------ | --------------
<doc:leetcode-295-find-median-data-stream> | Streaming median | Dual heap invariants, rebalancing.
<doc:leetcode-2034-stock-price-fluctuation> | Mutable order state | Updates + queries without corruption.
<doc:leetcode-1801-number-of-orders-in-the-backlog> | Matching engine | Priority queues, correct ordering.
<doc:leetcode-502-ipo> | Greedy + heaps | Capital constraints and choice order.
<doc:leetcode-901-online-stock-span> | Monotonic stack | Window compression and spans.
<doc:leetcode-188-best-time-to-buy-and-sell-stock-iv> | DP state modeling | Multiple transactions, constraints.
<doc:leetcode-123-best-time-to-buy-and-sell-stock-iii> | DP state modeling | State transitions with limits.
<doc:leetcode-122-best-time-to-buy-and-sell-stock-ii> | Baseline trading | Use as a contrast for harder cases.

## System Design Drills

- <doc:system-design-deep-dive-finance-trading>
- <doc:stockmarket-order-book>
- <doc:stockmarket-rate-limiter>
- <doc:tau-cross-deep-dive>
- <doc:finance-deep-dive>

## Behavioral Prompts to Prep

- Describe a time you shipped a risky change under time pressure.
- How do you ensure correctness when data updates are continuous?
- Walk through a production incident and your follow-up plan.

## Topics

### Start Here

- <doc:company-guides>
- <doc:system-design>

### Coding Focus

- <doc:algorithms-and-patterns>
- <doc:top-15-patterns>

### Practice

- <doc:practice-platforms>
- <doc:preparation>
