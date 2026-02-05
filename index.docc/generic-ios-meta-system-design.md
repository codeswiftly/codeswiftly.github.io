# Generic iOS Meta System Design


@Metadata {
  @TitleHeading("Frame a Meta-scale iOS system design")
  @PageColor(orange)
}


A topic page for a baseline iOS mobile system design at Meta scale. Use this outline to structure
interview answers; each section should become its own deeper page.

## Format (45-Minute Compensation Plan)

- This is a structured, high-signal walkthrough, not a full design doc.
- Define the problem and constraints first.
- Draw the core architecture and data flow.
- Take questions and refine tradeoffs.
- If the coding round was weak, use this loop to show senior-level judgment and clarity.

## 45-Minute Walkthrough

0:00 - 4:00: Problem framing (users, core job, constraints, success metrics).

4:00 - 8:00: Architecture stack. Diagram: <doc:system-design-mermaid-prompts#prompt-1-framework-stack>.

8:00 - 13:00: Primary data flow. Diagram: <doc:system-design-mermaid-prompts#prompt-3-simple-api-flow>.

13:00 - 17:00: Offline and sync plan. Diagram:
<doc:system-design-mermaid-prompts#prompt-4-storing-data-offline>.

17:00 - 21:00: Protocol boundaries and test seams. Diagram:
<doc:system-design-mermaid-prompts#prompt-2-protocol-boundary>.

21:00 - 28:00: Scaling and performance (cache, pagination, fanout, rate limits).

28:00 - 33:00: Observability (SLIs, logging, tracing, dashboards).

33:00 - 38:00: Privacy and safety (permission UX, data minimization, abuse cases).

38:00 - 45:00: Failure modes and tradeoffs; take questions and adjust the design.

## 45-Minute Checklist (Quick Skim)

- 0:00 - 4:00: Problem framing: users, job, constraints, success metrics.
- 4:00 - 8:00: Architecture stack + boundary callouts.
- 8:00 - 13:00: Primary data flow and UI state transitions.
- 13:00 - 17:00: Offline and sync plan.
- 17:00 - 21:00: Protocol boundaries and test seams.
- 21:00 - 28:00: Scaling and performance.
- 28:00 - 33:00: Observability.
- 33:00 - 38:00: Privacy and safety.
- 38:00 - 45:00: Failure modes, tradeoffs, questions.

## High-impact Moves (to Offset a Weak Coding Round)

- Put numbers on everything: QPS, payload size, cache hit rate, and latency budgets.
- Make one strong tradeoff call and defend it (consistency vs latency, fanout on write vs read).
- Add integrity and abuse handling without being prompted.
- Show a rollback plan and a safe default when ranking or personalization fails.
- Call out mobile constraints and battery impact early.

## Diagrams to Draw in Order


Optional (only if asked):

5) Feed ranking: <doc:system-design-mermaid-prompts#prompt-8-feed-ranking>
6) Realtime messaging: <doc:system-design-mermaid-prompts#prompt-7-realtime-messaging>
7) Media upload pipeline: <doc:system-design-mermaid-prompts#prompt-5-media-upload-pipeline>
8) Push notifications: <doc:system-design-mermaid-prompts#prompt-6-push-notifications>

## Architecture

- Start with the four-layer stack: presentation, state/logic, services, infrastructure.
- Name the core modules (UI, state store, service clients, persistence).
- Call out the system boundaries (device, edge services, core backend).
- Identify data ownership per layer and keep mutation centralized.
- Name dependencies that must be mocked or wrapped for tests.
- Separate product services (feed, messaging, media) from platform services (auth, analytics, push).
- Define a clear API contract between mobile and backend (request shapes, ids, pagination).

## Data Flow

- Pick one primary user action and trace end-to-end data flow.
- Note where data is transformed, cached, and observed.
- Identify the write path and the read path separately.
- Call out async boundaries, retries, and idempotency points.
- Show how the UI state changes as each hop completes.
- Define event ordering expectations for realtime updates vs background refresh.
- Mention fetch options fast (polling, delta sync, SSE, WebSocket), then pivot to local cache.

## Caching and Offline

- Define local storage (database, keychain, file cache) and sync strategy.
- Describe conflict resolution and retry semantics.
- Include background refresh and stale data policies.
- Define cache keys, TTLs, and invalidation rules.
- Call out how offline writes are queued and reconciled.
- Explain what the app shows when the cache is cold or empty.
- Prefer immutable snapshots for cache state; use versioned writes and diffing to update UI.

## Scaling

- Describe horizontal scaling and stateless services.
- Note partitioning/sharding keys and hot-spot mitigation.
- Use CDN, fanout services, and queueing where appropriate.
- Define rate limits, batching, and pagination strategy.
- Mention backpressure and graceful degradation under load.
- Pick one scale strategy: fanout on write, fanout on read, or hybrid, and explain why.

## Observability

- Define the core SLIs (latency, error rate, freshness, availability).
- Map logs, metrics, and traces to each tier.
- Name dashboards and alert thresholds.
- Include request identifiers that flow from device to backend.
- Call out redaction rules for logs and analytics.
- Track client health: cold start, memory pressure, scroll performance, and crash-free sessions.

## Privacy and Safety

- Identify sensitive data and apply minimization and encryption.
- Document consent, retention, and redaction policies.
- Call out abuse vectors and moderation hooks.
- Clarify permission prompts and user control surfaces.
- Define data deletion and export expectations.
- Describe how location or contact data is scoped, sampled, and stored.

## Failure Modes

- Enumerate client, network, and backend failures.
- Describe fallbacks and graceful degradation.
- Include retry, backoff, circuit breaker, and rollback paths.
- Name kill switches and feature flags for fast mitigation.
- Call out the one or two most likely incident scenarios and how you would respond.

## See Also

- <doc:system-design>
- <doc:system-design-mermaid-prompts>
