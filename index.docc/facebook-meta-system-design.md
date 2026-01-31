@PageImage(purpose: card, source: "facebook-meta-system-design-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "facebook-meta-system-design-icon.codex", alt: "Placeholder icon")
# Facebook Meta System Design

@Metadata {
  @TitleHeading("Facebook-style system design (Meta)")
  @PageColor(orange)
  @PageImage(purpose: icon, source: "system-design-icon.codex", alt: "System design icon")
  @PageImage(purpose: card, source: "system-design-card.codex", alt: "System design card")
}

@Image(source: "facebook-meta-system-design-hero.codex", alt: "Facebook meta system design hero")

Use this scaffold to rehearse a Facebook-style system design answer with Meta interview pacing.
Anchor on <doc:generic-ios-meta-system-design>.
This guide assumes iOS mobile constraints and platform APIs.

## iOS Mobile Focus

- Background execution limits, refresh policies, and energy impact.
- Local persistence for feed cache and composer drafts.
- Apple Push Notification service (APNs) for mentions and reactions.
- Media playback and permissions with AVFoundation and photo library access.

## 45-Minute Tour Script

0:00 - 4:00: Problem framing (news feed, social graph, engagement).
4:00 - 8:00: Architecture stack.
8:00 - 13:00: Primary data flow (post → feed → ranking).
13:00 - 17:00: Offline and sync plan.
17:00 - 21:00: Protocol boundaries and test seams.
21:00 - 28:00: Scaling and performance.
28:00 - 33:00: Observability.
33:00 - 38:00: Privacy and safety.
38:00 - 45:00: Failure modes, tradeoffs, questions.

## High-impact Moves (Meta)

- State the ranking goals and the candidate generation plan.
- Call out integrity: spam, misinformation, and policy enforcement.
- Provide a fallback: chronological feed with cache warming.
- Explain fanout on write vs read and why you pick one.

## Core Requirements and Constraints

- Fresh feed that respects the social graph and ranking quality.
- High engagement without degrading app performance.
- Strong integrity, privacy, and abuse controls.

## Mapping to the Generic Outline

### Problem Framing

- Define the core job: see updates, engage, and connect.
- Define success metrics: feed freshness, engagement, retention.
- Clarify surfaces: feed, groups, pages, and notifications.
- Define the first v1: post creation + feed read + reactions.

### Architecture

- Client: feed UI, composer, media viewer, state store.
- Services: graph service, feed service, ranking service, media service.
- Supporting services: notifications, search, integrity, and content policy.
- Separate graph storage from ranking and delivery.

### Data Flow

- Write path: create post → storage → feed indexing.
- Read path: fetch candidate posts → rank → cache → render.
- Engagement path: reactions and comments update counters and relevance signals.
- Graph changes trigger feed refresh and invalidation.
- Mention fetch options fast (polling, delta sync, SSE, WebSocket), then focus on the cache.

### Caching and Offline

- Feed cache with pagination and invalidation.
- Draft composer with offline queue.
- Cache profile and graph metadata for quick rendering.
- Use staleness indicators when data is out of date.
- Use immutable feed snapshots and diffed updates for rank changes.

### Scaling

- Ranking services, cache layers, and fanout strategy.
- Hot-spot mitigation around high-traffic posts.
- Shard by user id and group id; cache candidate sets.
- Use fanout on write for hot sources, fanout on read for long tail.

### Observability

- Feed latency, ranking errors, engagement funnel.
- Client performance metrics and crash-free sessions.
- Track time-to-first-content and scroll success rate.
- Monitor cache hit rates and invalidation errors.

### Privacy and Safety

- Audience controls, data access logging, moderation hooks.
- Abuse reporting and integrity checks.
- Enforce visibility rules per post and per group.
- Log access for sensitive graph edges.

### Failure Modes

- Ranking fallback to chronological feed.
- Cache corruption and recompute strategy.
- Degraded mode: limit media formats and reduce prefetch.
- Feature flags for fast rollback of ranking changes.

## Diagrams and Prompts

- Start with <doc:system-design-mermaid-prompts>.
- Use prompts: feed ranking, simple API flow, framework stack.

## Open Questions

- Where does ranking happen vs caching?
- How to balance freshness vs relevance?
- How to handle group feed vs main feed differences?
