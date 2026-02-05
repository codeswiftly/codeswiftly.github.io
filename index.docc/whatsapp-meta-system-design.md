# Whatsapp Meta System Design


@Metadata {
  @TitleHeading("WhatsApp-style system design (Meta)")
  @PageColor(orange)
}


Use this scaffold to rehearse a WhatsApp-style system design answer with Meta interview pacing.
Anchor on <doc:generic-ios-meta-system-design>.
This guide assumes iOS mobile constraints and platform APIs.

## iOS Mobile Focus

- Background execution limits, message delivery, and energy impact.
- Local storage for threads, outbox, and media metadata.
- Apple Push Notification service (APNs) for delivery and retries.
- Audio capture and playback with AVFoundation and permissions.

## 45-Minute Tour Script

0:00 - 4:00: Problem framing (messaging, reliability, privacy, latency).
4:00 - 8:00: Architecture stack.
8:00 - 13:00: Primary data flow (send message → delivery).
13:00 - 17:00: Offline and sync plan.
17:00 - 21:00: Protocol boundaries and test seams.
21:00 - 28:00: Scaling and performance.
28:00 - 33:00: Observability.
33:00 - 38:00: Privacy and safety.
38:00 - 45:00: Failure modes, tradeoffs, questions.

## High-impact Moves (Meta)

- Quantify delivery latency targets (p95 send-to-deliver).
- Explain E2E encryption boundaries and metadata minimization.
- Show multi-device sync strategy and conflict resolution.
- Offer fallback when push is degraded (polling + backoff).

## Core Requirements and Constraints

- End-to-end encryption and metadata minimization are first-order goals.
- Delivery reliability under weak networks and device sleep.
- Real-time experience without draining battery.

## Mapping to the Generic Outline

### Problem Framing

- Define the core job: send, receive, and archive messages reliably.
- Define success metrics: delivery latency, retry success, crash-free.
- Clarify surfaces: one-to-one, groups, media, and voice notes.
- Define the first v1: text messages + push + read receipts.

### Architecture

- Client: message composer, thread store, media pipeline.
- Services: message service, presence, push, media upload.
- Key services: encryption key management, delivery receipts, spam controls.
- Separate realtime transport from storage and sync.

### Data Flow

- Send path: client → gateway → message service → fanout.
- Read path: sync → local store → UI.
- Delivery path: server ack → device receipt → sender receipt.
- Media path: upload → store → share pointer → download.
- Mention fetch options fast (polling, delta sync, SSE, WebSocket), then focus on the cache.

### Caching and Offline

- Outbox queue with retries and dedupe.
- Local store for threads and media metadata.
- Background sync to reconcile missed messages.
- Cache media thumbnails and defer full downloads.
- Use immutable thread snapshots and diffed updates per message batch.

### Scaling

- Fanout strategy and shard keys (user id, thread id).
- Push delivery and notification throttling.
- Rate limits for message sends and media uploads.
- Use regional routing to reduce latency.

### Observability

- Send latency, delivery success, retry rate.
- Client metrics: reconnect success, background fetch.
- Track delivery states: sent, delivered, read, failed.
- Monitor encryption errors and key mismatches.

### Privacy and Safety

- End-to-end encryption boundaries and metadata minimization.
- Abuse reporting and spam controls.
- Define how backups are handled without breaking privacy.
- Clarify what data is stored on device vs server.

### Failure Modes

- Offline delivery fallback, duplicate send handling.
- Push outages and degraded polling mode.
- Degraded mode: text-only when media uploads fail.
- Session key rotation failures and recovery path.

## Diagrams and Prompts

- Start with <doc:system-design-mermaid-prompts>.
- Use prompts: realtime messaging, protocol boundary, simple API flow.

## Open Questions

- What is the sync strategy for multi-device history?
- How to handle large media uploads under weak networks?
- How to preserve battery while keeping presence accurate?
