@PageImage(purpose: card, source: "instagram-meta-system-design-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "instagram-meta-system-design-icon.codex", alt: "Placeholder icon")
# Instagram Meta System Design

@Metadata {
  @TitleHeading("Instagram-style system design (Meta)")
  @PageColor(orange)
  @PageImage(purpose: icon, source: "system-design-icon.codex", alt: "System design icon")
  @PageImage(purpose: card, source: "system-design-card.codex", alt: "System design card")
}

@Image(source: "instagram-meta-system-design-hero.codex", alt: "Instagram meta system design hero")

Use this scaffold to rehearse an Instagram-style system design answer with Meta interview pacing.
Anchor on <doc:generic-ios-meta-system-design>.
This guide assumes iOS mobile constraints and platform APIs.

## iOS Mobile Focus

- Background execution limits, upload tasks, and energy impact.
- Local persistence for drafts, feed cache, and media metadata.
- Apple Push Notification service (APNs) for engagement and delivery.
- Capture and playback: AVFoundation, photo library access, and permissions.

## 45-Minute Tour Script

0:00 - 4:00: Problem framing (feed, media, creators, engagement).
4:00 - 8:00: Architecture stack.
8:00 - 13:00: Primary data flow (post → feed).
13:00 - 17:00: Offline and sync plan.
17:00 - 21:00: Protocol boundaries and test seams.
21:00 - 28:00: Scaling and performance.
28:00 - 33:00: Observability.
33:00 - 38:00: Privacy and safety.
38:00 - 45:00: Failure modes, tradeoffs, questions.

## High-impact Moves (Meta)

- Anchor with numbers: feed QPS, media size, and p95 time-to-first-frame.
- Call out ranking signals (recency, relationship strength, engagement).
- Show a degraded mode: cached feed + lower-bitrate media.
- Mention integrity hooks: spam, abuse reports, and content policy.

## Core Requirements and Constraints

- Fast media start time and smooth scrolling under weak networks.
- Reliable uploads with retries and resumable sessions.
- Safety and moderation at scale without blocking core flows.

## Mapping to the Generic Outline

### Problem Framing

- Define the core job: scroll, discover, engage, create.
- Define success metrics: time-to-feed, media start time, retention.
- Clarify surfaces: feed, stories, reels, profile, and explore.
- Define the first v1: feed + post creation + engagement.

### Architecture

- Client: feed UI, media capture, media playback, state store.
- Services: feed service, media service, engagement service, auth/identity.
- Add supporting services: notifications, moderation, search, and abuse signals.
- Separate media processing (transcode, thumbnails) from feed ranking.

### Data Flow

- Post creation → upload → processing → feed distribution.
- Feed read path → ranking → cache → client render.
- Engagement write path (like, comment) → update counts → fanout to feed.
- Media playback path: metadata fetch → CDN fetch → local cache → player.
- Mention fetch options fast (polling, delta sync, SSE, WebSocket), then focus on the cache.

### Caching and Offline

- Drafts and uploads queued locally.
- Feed cache with TTL and invalidation.
- Media cache with eviction by recency and size limits.
- Offline engagement queue with dedupe.
- Use immutable feed snapshots and diffed updates to keep UI stable.

### Scaling

- Media upload fanout, CDN distribution, feed ranking at scale.
- Rate limits for engagement and upload endpoints.
- Partition by user id for feeds and by media id for processing.
- Use backpressure when upload queues or transcode are saturated.

### Observability

- Feed latency, media playback failures, upload success rate.
- Client performance: scroll FPS, memory pressure.
- Track ranking coverage, stale feed rate, and cache hit ratios.
- Separate user-visible failures from background retries.

### Privacy and Safety

- Content moderation hooks and reporting flows.
- Consent for camera, mic, and library access.
- Protect minors and restricted content with tiered visibility.
- Define data retention and deletion flows for media.

### Failure Modes

- Upload retries, partial failures, CDN fallback.
- Degraded feed mode when ranking is unavailable.
- Fallback to cached feed when ranking or network is degraded.
- Disable high-cost media formats under severe load.

## Diagrams and Prompts

- Start with <doc:system-design-mermaid-prompts>.
- Use prompts: media upload pipeline, feed ranking, simple API flow.

## Open Questions

- What is the minimal v1 feed?
- Where does ranking live (client vs backend)?
- How much personalization is required on day one?
