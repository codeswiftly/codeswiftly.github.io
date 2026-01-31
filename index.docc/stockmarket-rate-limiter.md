@PageImage(purpose: icon, source: "stockmarket-rate-limiter-icon.codex", alt: "Placeholder icon")
# Stockmarket Rate Limiter

@Metadata {
  @TitleHeading("Stockmarket rate limiter")
  @PageImage(purpose: card, source: "stockmarket-rate-limiter-card.codex", alt: "Stockmarket rate limiter card")
}

@Image(source: "stockmarket-rate-limiter-hero.codex", alt: "Stockmarket rate limiter hero")

## Overview

Rate limiting for trading and quote APIs prevents bursts from exhausting upstream services. This
guide frames common interview prompts around throttling, fairness, and backpressure in a
finance-friendly way.

## Signals to Hit

- Protect core services while keeping latency predictable.
- Explain where to enforce limits (client, edge, gateway, service).
- Pick a strategy based on traffic shape and fairness needs.

## Core Approaches

- Token bucket for bursty traffic with a stable refill rate.
- Leaky bucket for smoothing bursts into steady flow.
- Sliding window for a more exact, time-bounded view of limits.

## Interview Checklist

1. Define the unit (per user, per account, per API key).
2. Set error semantics (429 vs. soft backoff).
3. Describe observability (rate, drops, queue depth).
