@PageImage(purpose: card, source: "snippets-meta-system-design-outline-card.codex", alt: "Placeholder card")
@Image(source: "snippets-meta-system-design-outline-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "snippets-meta-system-design-outline-icon.codex", alt: "Placeholder icon")
# Meta System Design Outline (Snippet)

Use this as a typing drill so the “Pirate” interview structure is automatic.

```text
1) Requirements
   - core use cases
   - constraints (latency, scale, offline, device, privacy)
   - non-goals

2) Data model
   - entities + identifiers
   - indexes
   - invariants

3) APIs
   - read/write flows
   - pagination
   - idempotency
   - error model

4) Storage + caching
   - local persistence
   - cache keys, TTLs, invalidation

5) Sync + conflicts
   - merge strategy
   - ordering
   - retries/backoff

6) Observability
   - metrics
   - logs/traces
   - alerts

7) Failure modes
   - partial failure handling
   - degraded mode behavior
   - mitigation plan
```
