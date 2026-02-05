# System Design Mermaid Prompts

@PageImage(purpose: card, source: "system-design-mermaid-prompts-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "system-design-mermaid-prompts-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Sketch fast, explain tradeoffs")
  @PageColor(red)
  @PageImage(purpose: icon, source: "system-design-icon.codex", alt: "System design icon")
  @PageImage(purpose: card, source: "system-design-card.codex", alt: "System Design card")
}

@Image(source: "system-design-mermaid-prompts-hero.codex", alt: "System design mermaid prompts hero")

Use these quick Mermaid prompts to sketch **mobile iOS** system design answers in Excalidraw.
Each prompt targets the highest-signal architecture and tradeoffs in minutes, with Meta
product variants (Instagram, WhatsApp, Facebook) in mind.

See the Mermaid references:
- `system-design-mermaid-flowcharts.md`
- `system-design-mermaid-class-diagrams.md`
- `system-design-mermaid-sequence-diagrams.md`

## Shape References

Use these when you need standard database shapes or diagonal relationship references.

### Database (Flowchart)

```mermaid
flowchart LR
  Db[(Database)]
```

@Image(source: "system-design-mermaid-prompts-01-shape-references.codex.svg", alt: "Shape references diagram")



### Database (Expanded Shape)

```mermaid
flowchart LR
  Db@{ shape: cyl, label: "Database" }
```

@Image(source: "system-design-mermaid-prompts-02-shape-references.codex.svg", alt: "Shape references diagram")



### Diagonal Relationship References (Class Diagrams)

Use relationship arrows to convey structure quickly:

```mermaid
classDiagram
  classA <|-- classB
  classC *-- classD
  classE o-- classF
  classG ..> classH
```

@Image(source: "system-design-mermaid-prompts-03-shape-references.codex.svg", alt: "Shape references diagram")



## Rules of Thumb

- Use CamelCase node labels without spaces (for example, `UserSession`, `FeedRanker`).
- Keep each diagram to five nodes or fewer.
- Start with the smallest graph that explains the end-to-end flow.
- Name edges with verbs so reviewers follow the data path.
- Keep device services visible (local store, keychain, push, background tasks).

## Prompt 1: Framework Stack

```mermaid
flowchart TB
  Ui --> State
  State --> Services
  Services --> Infra
```

@Image(source: "system-design-mermaid-prompts-04-prompt-1-framework-stack.codex.svg", alt: "Prompt 1: framework stack diagram")



@Image(source: "framework-stack.codex", alt: "Framework stack diagram")

Use for: layered architecture and separation of concerns.

Meta flavor:

- Instagram: UI = Feed, State = FeedStore, Services = FeedService, Infra = Networking.
- WhatsApp: UI = ChatView, State = ThreadStore, Services = MessageService, Infra = Transport.
- Facebook: UI = Timeline, State = StoryStore, Services = RankingService, Infra = APIClient.

## Prompt 2: Protocol Boundary

```mermaid
flowchart LR
  Client --> Protocol
  Protocol --> Impl
  Protocol --> Mock
```

@Image(source: "system-design-mermaid-prompts-05-prompt-2-protocol-boundary.codex.svg", alt: "Prompt 2: protocol boundary diagram")



@Image(source: "protocol-boundary.codex", alt: "Protocol boundary diagram")

Use for: testability, dependency injection, and clean interfaces.

Meta flavor:

- Instagram: Protocol = MediaUploadClient (real vs mock).
- WhatsApp: Protocol = MessageTransport (real vs mock).
- Facebook: Protocol = FeedRankingClient (real vs mock).

## Prompt 3: Simple API Flow

```mermaid
flowchart LR
  IosApp --> Api
  Api --> Service
  Service --> Db
```

@Image(source: "system-design-mermaid-prompts-06-prompt-3-simple-api-flow.codex.svg", alt: "Prompt 3: simple API flow diagram")



@Image(source: "simple-api-flow.codex", alt: "Simple API flow diagram")

Use for: basic client-server interactions and persistence.

Meta flavor:

- Instagram: PostCreate -> MediaService -> PostDB.
- WhatsApp: SendMessage -> ChatService -> MessageDB.
- Facebook: CreateStory -> StoryService -> StoryDB.

## Prompt 4: Storing Data (Offline)

```mermaid
flowchart LR
  IosApp --> LocalStore
  LocalStore --> SyncSvc
  SyncSvc --> Db
```

@Image(source: "system-design-mermaid-prompts-07-prompt-4-storing-data-offline.codex.svg", alt: "Prompt 4: storing data (offline) diagram")



@Image(source: "storing-data-offline.codex", alt: "Storing data offline diagram")

Use for: offline-first writes and background sync.

Meta flavor:

- Instagram: Drafts and edits in LocalStore, SyncSvc uploads when online.
- WhatsApp: Outbox queue in LocalStore, SyncSvc retries delivery.
- Facebook: Draft posts in LocalStore, SyncSvc publishes when online.

## Prompt 5: Media Upload Pipeline

```mermaid
flowchart LR
  IosApp --> UploadApi
  UploadApi --> MediaSvc
  MediaSvc --> Transcode
  Transcode --> Cdn
```

@Image(source: "system-design-mermaid-prompts-08-prompt-5-media-upload-pipeline.codex.svg", alt: "Prompt 5: media upload pipeline diagram")



@Image(source: "media-upload-pipeline.codex", alt: "Media upload pipeline diagram")

Use for: uploads, transcoding, and distribution.

Meta flavor:

- Instagram: Reels upload -> Transcode -> CDN delivery.
- WhatsApp: Media upload -> Transcode -> CDN fetch.
- Facebook: Video upload -> Transcode -> CDN playback.

## Prompt 6: Push Notifications

```mermaid
flowchart LR
  IosApp --> AppApi
  AppApi --> PushSvc
  PushSvc --> Apns
  Apns --> Device
```

@Image(source: "system-design-mermaid-prompts-09-prompt-6-push-notifications.codex.svg", alt: "Prompt 6: push notifications diagram")



@Image(source: "push-notifications.codex", alt: "Push notifications diagram")

Use for: delivery fanout, device tokens, and platform transport.

Meta flavor:

- Instagram: Likes/comments send push events to APNS.
- WhatsApp: New message sends a push when app is inactive.
- Facebook: Mentions or reactions trigger notification delivery.

## Prompt 7: Realtime Messaging

```mermaid
flowchart LR
  IosApp --> RealtimeGw
  RealtimeGw --> FanoutSvc
  FanoutSvc --> MessageDb
```

@Image(source: "system-design-mermaid-prompts-10-prompt-7-realtime-messaging.codex.svg", alt: "Prompt 7: realtime messaging diagram")



@Image(source: "realtime-messaging.codex", alt: "Realtime messaging diagram")

Use for: low-latency transport, fanout, and persistence.

Meta flavor:

- Instagram: Thread replies fan out to participants.
- WhatsApp: Message delivery with fanout + storage.
- Facebook: Messenger threads update in realtime.

## Prompt 8: Feed Ranking

```mermaid
flowchart LR
  IosApp --> FeedApi
  FeedApi --> Ranker
  Ranker --> FeedCache
```

@Image(source: "system-design-mermaid-prompts-11-prompt-8-feed-ranking.codex.svg", alt: "Prompt 8: feed ranking diagram")



@Image(source: "feed-ranking.codex", alt: "Feed ranking diagram")

Use for: feed ordering, scoring, and cache strategy.

Meta flavor:

- Instagram: Ranker scores posts for feed.
- WhatsApp: Status ordering uses recency + interactions.
- Facebook: News Feed scoring writes to cache.

## Prompt 9: Auth + Session Refresh

```mermaid
flowchart LR
  IosApp --> AuthApi
  AuthApi --> SessionSvc
  SessionSvc --> Keychain
```

@Image(source: "system-design-mermaid-prompts-12-prompt-9-auth-session-refresh.codex.svg", alt: "Prompt 9: auth + session refresh diagram")



@Image(source: "auth-session-refresh.codex", alt: "Auth session refresh diagram")

Use for: login, token refresh, and session storage.

Meta flavor:

- Instagram: AuthApi issues tokens, SessionSvc refreshes, Keychain stores.
- WhatsApp: SessionSvc handles re-auth for message sync.
- Facebook: SessionSvc enforces logout + token rotation.

## Prompt 10: Rate Limiting + Backoff

```mermaid
flowchart LR
  IosApp --> ApiGateway
  ApiGateway --> RateLimiter
  RateLimiter --> Service
```

@Image(source: "system-design-mermaid-prompts-13-prompt-10-rate-limiting-backoff.codex.svg", alt: "Prompt 10: rate limiting + backoff diagram")



@Image(source: "rate-limiting-backoff.codex", alt: "Rate limiting backoff diagram")

Use for: request throttling, backoff, and abuse control.

Meta flavor:

- Instagram: Rate limit likes/comments and media uploads.
- WhatsApp: Rate limit message sends and media retries.
- Facebook: Rate limit feed refresh and reactions.

## Prompt 11: Search + Explore

```mermaid
flowchart LR
  IosApp --> SearchApi
  SearchApi --> Index
  Index --> Ranker
```

@Image(source: "system-design-mermaid-prompts-14-prompt-11-search-explore.codex.svg", alt: "Prompt 11: search + explore diagram")



@Image(source: "search-explore.codex", alt: "Search explore diagram")

Use for: query flow, indexing, and ranking.

Meta flavor:

- Instagram: Explore search hits index + ranker.
- WhatsApp: Contact/group search uses index + ranker.
- Facebook: Graph search uses index + ranker.

## Prompt 12: Media Playback Pipeline

```mermaid
flowchart LR
  IosApp --> Cdn
  Cdn --> Cache
  Cache --> Player
```

@Image(source: "system-design-mermaid-prompts-15-prompt-12-media-playback-pipeline.codex.svg", alt: "Prompt 12: media playback pipeline diagram")



@Image(source: "media-playback-pipeline.codex", alt: "Media playback pipeline diagram")

Use for: playback flow, caching, and buffering.

Meta flavor:

- Instagram: Reels playback uses CDN + local cache.
- WhatsApp: Media playback uses cache before download.
- Facebook: Video feed uses CDN + player buffering.
