# Tau Cross Deep Dive


@Metadata {
  @PageColor(green)
  @TitleHeading("Tau Cross Deep Dive")
}

Tau Cross is a Robinhood-style trading client case study. Use it to practice real-time quotes,
order preview flows, and risk-aware UX tradeoffs.

## Why Tau Cross Maps to Robinhood-style Interviews

- Real-time quote updates with bid/ask spread and mid-price display.
- Order preview and order placement flows (market vs limit).
- Watchlists, positions, and account selection across environments.
- Mac Catalyst surface that mirrors mobile client constraints.

## Architecture Snapshot

- Client surfaces: quote view, order confirmation, watchlists, account selection.
- Services: market data, order routing, auth, positions, risk checks.
- Storage: cached quotes and user defaults for environment/account.

## Data Flows to Rehearse

- Quotes: fetch or stream, compute mid/spread, throttle UI updates.
- Orders: validate inputs, preview, confirm, submit, handle rejection states.
- Watchlists: edit lists, sync symbols, dedupe on insert.

## Interview Prompts This Supports

- "Design a retail trading app with real-time quotes."
- "How do you preview orders safely before submission?"
- "How would you throttle and cache quote updates on device?"

## Related Deep Dives and Drills

@Links(visualStyle: detailedGrid) {

- <doc:system-design-deep-dive-finance-trading>
- <doc:stockmarket-order-book>
- <doc:stockmarket-rate-limiter>
- <doc:finance-deep-dive>
}
