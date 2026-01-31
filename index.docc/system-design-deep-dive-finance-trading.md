# System Design Deep Dive -- Trading Finance (Robinhood-Style)

@Metadata {
  @TitleHeading("Review System Design Deep Dive -- Trading // Finance (Robinhood-Style)")
  @PageImage(purpose: icon, source: "system-design-deep-dive-finance-trading-icon.codex", alt: "System Design Deep Dive Trading Finance (Robinhood Style) icon")
  @PageImage(purpose: card, source: "system-design-deep-dive-finance-trading-card.codex", alt: "System Design Deep Dive Trading Finance (Robinhood Style) card")
}

@Image(source: "system-design-deep-dive-finance-trading-hero.codex", alt: "System Design Deep Dive Trading Finance (Robinhood Style) hero")

This deep dive uses Robinhood-style interview problems (order book, rate limiter, fractional
shares, stock tracker) to outline how to design **retail trading systems**:

- Mobile/web clients placing orders and streaming prices.
- Backend services for quotes, orders, and risk checks.
- Data structures and safety concerns specific to finance.

Use it when you get prompts like:

- “Design a stock trading system for a mobile app.”
- “How would you implement an order book and rate limiting?”
- “How do you support fractional share orders safely?”

---

## 45-Minute Tour Script

0:00 - 4:00: Frame the problem (real-time quotes, safe orders, correctness, latency).

4:00 - 9:00: High-level architecture.

- Use the architecture sketch in section 2.
- Name clients, gateway, quote service, order service, account service, market data feeds.

9:00 - 13:00: Streaming quotes and client tracking.

- Use the visual in section 3.
- Call out backpressure and UI throttling.

13:00 - 17:00: Rate limiting.

- Use the visual in section 4.
- Explain where the limiter lives and what happens on denial.

17:00 - 23:00: Order submission flow and idempotency.

- Focus on request shape, validation, risk checks, and order states.

23:00 - 29:00: Order book matching.

- Use the matcher loop in section 5 as the deep dive.

29:00 - 33:00: Fractional shares and precision.

- Use section 6; emphasize Decimal, rounding rules, and limits.

33:00 - 38:00: Observability and SLOs.

- Use section 8; name the top three SLIs and alerts.

38:00 - 45:00: Failure modes and tradeoffs.

- Use section 7 for safety and section 9 for framing tips.
- Take questions and adjust the design.

## Mapping to the Generic Outline

### Problem Framing

- Correctness, latency, availability, and regulatory constraints dominate.

### Architecture

- Client, gateway, quote service, order service, account/positions, market data feeds.
- OMS and risk checks are distinct services, not UI responsibilities.

### Data Flow

- Quotes stream via WebSocket/SSE; orders follow a validate-route-execute loop.
- Read path (quotes) and write path (orders) are separated for clarity.

### Caching and Offline

- Cache latest quotes and portfolio snapshots on device.
- Define fallback when the feed is delayed or disconnected.

### Scaling

- Fanout quotes, rate-limit endpoints, and shard by symbol or account.
- Handle hot symbols and market open spikes.

### Observability

- Track quote latency, order ack latency, rejection rate, and feed lag.
- Correlate client taps with backend order ids.

### Privacy and Safety

- Audit logs, idempotency keys, and deterministic rounding rules.
- Treat trading data as sensitive with strict access controls.

### Failure Modes

- Exchange outages, feed lag, partial fills, and risk system failure.
- Default to safe rejections when dependencies are unhealthy.

## 1. Domain and Constraints

Key constraints in trading/finance:

- **Correctness**:
  - Money and positions must be accurate; rounding bugs are unacceptable.
  - Regulatory obligations (best execution, audit logs).
- **Latency**:
  - Users expect fast quote updates and order acknowledgments.
  - Exchanges have strict response SLAs.
- **Availability**:
  - Downtime during market hours is extremely costly (financially and reputationally).
- **Safety & abuse prevention**:
  - Rate limits on quotes/orders.
  - Risk checks (margin, exposure, limits).

In an interview answer, call these out early when designing a trading system.

---

## 2. High-level Architecture

Retail trading architecture (very simplified):

```text
    [Mobile / Web clients]
          |
      API Gateway
          |
  -------------------------------
  |       |        |           |
 Auth   Quotes   Orders     Account
  |       |        |           |
  v       v        v           v
  DB   Market   Order Mgmt   Positions
       Data       System       / Ledger
             |
         Exchanges
```

Typical components:

- **Clients**:
  - iOS/Android/web apps.
  - Show quotes, charts, positions; allow order entry.
- **API Gateway**:
  - AuthN/Z, request routing, rate limiting, logging.
- **Quote service**:
  - Consumes real-time market data feeds.
  - Normalizes and fans out quotes to clients.
- **Order service / Order Management System (OMS)**:
  - Validates and normalizes orders.
  - Applies risk checks (buying power, position limits).
  - Routes to exchanges or internalizers.
  - Tracks state (pending, filled, partial, canceled).
- **Account/positions service**:
  - Maintains user balances, holdings, cost basis.
  - Updates when executions arrive.
- **Market data feeds / exchanges**:
  - Upstream sources of prices and trade confirmations.

Tie to Robinhood interview topics:

- **Stock tracker**:
  - Part of the **quote service** and client data model.
- **Rate limiter**:
  - At the **API gateway** and/or **client level** for quotes/orders.
- **Order book matcher**:
  - Simplified version of what an exchange or internal crossing engine does.
- **Fractional shares**:
  - Logic in the **order service** and **position/accounting** layer.

---

## 3. Streaming Prices and Client-side Tracking

Stock tracker interview problem:

- Maintain `minPrice` and `maxProfit` online as prices stream in.

System design angle:

- On the backend:
  - Ingest real-time prices from exchanges/feeds.
  - Normalize into a compact feed per symbol.
  - Offer:
    - **Snapshot** endpoint (current book/price).
    - **Streaming** channel (WebSocket/SSE/WebRTC data channel).
- On the client:
  - Maintain minimal state:
    - `minPriceSoFar`, `maxProfit`.
  - Update on each tick; avoid rescanning history.
  - Decouple UI from raw tick rate:
    - Batch updates or throttle rendering to avoid jank.

Visual:

```text
 Market data feeds
        |
   Quote service
   (normalize, fan-out)
        |
   WebSocket / SSE
        |
   Client StockTracker (minPrice, maxProfit)
        |
       UI
```

Mention:

- How you’d backpressure:
  - Limit tick frequency to UI (for example, 5 updates/sec).
  - Use conflation (keep only last tick if many arrive quickly).
- How you’d test:
  - Simulated feeds, random price walks, edge cases (monotonic up/down).

---

## 4. Rate Limiting for Quotes and Orders

Rate limiter interview problem:

- Per-user, per-window **sliding window**:
  - “Allow at most N requests per user per rolling window.”

System design view:

- Where to apply:
  - **Client side**:
    - Prevents UI from spamming backend (for example, quote refresh button).
  - **Gateway/backend**:
    - Protects market data and order endpoints from abuse.
- Data model (client or single-node backend):
  - Map of user (or user+route) → deque of timestamps.
  - On each request:
    - Evict timestamps older than window.
    - If remaining count < limit → allow and record; else deny.

Visual:

```text
Client / Gateway
   |
RateLimiter
   |
  Map<user, deque<timestamp>>
```

Distributed variant (backend):

- Use a central store (for example, Redis) with sorted sets or counters.
- Consider token-bucket vs leaky-bucket if burst characteristics matter.

Interview points:

- Sliding window vs fixed buckets:
  - Sliding gives more precise control; buckets are easier to implement and shard.
- Backpressure:
  - When denied, client should debounce and avoid spin-retrying.
- Clock considerations:
  - Server-side time vs client time; choose one and be explicit.

---

## 5. Order Book Matching (Exchange-style)

Order book matcher interview problem:

- Maintain two priority queues:
  - Max-heap for bids (highest price first).
  - Min-heap for asks (lowest price first).
- When best bid ≥ best ask:
  - Match orders (partial fills allowed).

System design framing:

- This is a **toy version** of an order-matching engine.
- Real exchanges add:
  - Price-time priority with timestamps.
  - Multiple order types (market, limit, stop).
  - Multi-leg orders (e.g., options spreads).
  - Failover and replication.

Core loop logic (conceptual):

```text
while bestBid.price >= bestAsk.price:
  qty = min(bestBid.qty, bestAsk.qty)
  emit trade at executionPrice (e.g., bestAsk.price)
  decrement both quantities
  remove fully filled orders
  reinsert partials
```

Key interview topics:

- **Data structures**:
  - Heaps or tree maps keyed by price, with FIFO queues per price level.
- **Partial fills**:
  - Orders may fill in multiple trades; keep remaining quantity.
- **Price-time priority**:
  - Within a price level, earlier orders should win.
- **Edge cases**:
  - Zero quantity orders (reject).
  - Non-crossing book (stop when bestBid < bestAsk).

Where it fits:

- Exchange / internalizer side:
  - Your system design may stop at “we send to exchange,” but understanding the matcher shows depth.
- Internal crossing:
  - Some brokers cross client flow internally before routing out; same logic applies at smaller
    scale.

---

## 6. Fractional Shares and Precision Handling

Fractional shares interview problem:

- Users can specify orders by:
  - **Notional**: “Buy $50 of XYZ.”
  - **Shares**: “Buy 0.125 shares of XYZ.”
- Need to handle:
  - Rounding rules (share increments, tick sizes).
  - Limits on min/max notional and share increments.

Key considerations:

- Precision:
  - Represent money as `Decimal` or integer cents, not `Double`.
  - Represent shares with a fixed **fractional precision** (for example, 1/1,000 share).
- Conversions:

  ```text
  shares = floor( (dollars / price) / increment ) * increment
  ```

  - Floor to avoid overspending unless product spec says otherwise.
- Validation:
  - Enforce:
    - Min notional (for example, $1).
    - Max notional or share limit per order.
    - Sufficient buying power.
  - For limit orders:
    - Max spend = `roundedShares * limitPrice`.
- UX:
  - Make mode (dollars vs shares) explicit in UI.
  - Preview estimated shares, cost, and disclaimers (“final quantity may differ due to price
    movement”).

System design context:

- Order service:
  - Normalizes orders into a canonical representation (for example, shares, limit/market).
  - Uses shared rounding/validation helpers to keep behavior consistent.
- Positions and accounting:
  - Track fractional quantities; cost basis for partial fills.
  - Align with broker/clearing rules on allowable increments.

---

## 7. Safety, Idempotency, and Audit

Trading systems must be **auditable and safe**:

- Idempotency:
  - Use **client order IDs** or idempotency keys for order submissions.
  - If the client retries on a timeout, backend should detect duplicates.
- Logging:
  - Structured logs for:
    - Order life cycle events (submitted, accepted, routed, filled, canceled).
    - Risk check decisions (why an order was blocked).
  - Keep logs queryable for support and compliance.
- Failure scenarios:
  - Partial system outages:
    - Accept vs reject new orders.
    - Fail-safe defaults (prefer refusing new risk over taking orders you cannot route).
  - Market halts:
    - Respect exchange halts; block or queue orders accordingly.

For interviews, emphasize:

- “Money flows are never ‘best effort’—we design for **deterministic**, replayable behavior.”
- How you’d test:
  - Replay logs to reconstruct positions.
  - Simulate order replays and retries.

---

## 8. Observability and SLOs

Example SLOs:

- Quote latency:
  - 99% of client quote updates within X ms of exchange tick.
- Order submission:
  - 99% of orders receive an acknowledgment (accept/reject) within Y ms.
- Availability:
  - 99.9% uptime during market hours for critical paths (quotes, order entry).

Metrics to track:

- On clients:
  - Latency from tap → order acknowledgment.
  - Quote refresh delay.
  - Error rates on trading screens.
- On backend:
  - Latency per endpoint (quotes, orders).
  - Rate of rejected orders (by reason).
  - Rate limit denials.
  - Feed ingestion health (lag, dropped messages).

Alerting:

- Page on:
  - Elevated error rates.
  - Latency spikes.
  - Feed lag beyond thresholds.

---

## 9. Interview Framing Tips for Finance Systems

When asked to design a trading/finance system:

- Start with:

  > “We need to handle real-time quotes, safe order entry, and accurate positions  
  > under low latency and strict correctness constraints.”

- Lay out:
  - Clients, gateway, quote service, order service, account/positions service, market data feeds.
- Choose one or two **deep dives**:
  - Order book matching (data structures + flow).
  - Fractional share validation and rounding.
  - Rate limiting and abuse prevention.
- Always weave in:
  - **Safety** (idempotency, audit logs, rounding).
  - **Latency + backpressure**.
  - **Regulatory awareness** (best execution, risk checks at least at a high level).

Map the Robinhood-style coding questions to their place in the larger system and you will sound like
someone who can both write the code and reason about the production system it lives in.
