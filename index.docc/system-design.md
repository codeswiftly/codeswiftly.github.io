# System Design

@Metadata {
  @TitleHeading("Review System Design")
    @PageColor(orange)
}


## Mobile-focused Prompts

- Offline-first: how to queue work, retry with backoff, and reconcile conflicts after reconnect.
- Sync: delta updates vs. full sync, pagination, cache invalidation, staleness policies.
- Performance: scrolling and rendering budgets, background tasks, memory warnings, cold starts.
- Security: keychain usage, sensitive logging policies, transport security, integrity checks.
- Observability: structured logs, metrics for latency/failures, user-impact dashboards.
- Real-time: end-to-end latency budgets, jitter, backpressure, graceful degradation paths.
- AI-assisted: LLM integration points (on-device vs cloud), safety layers, prompt design at
  boundaries.

## 45-Minute Checklist (Quick Skim)

- 0:00 - 3:00: Problem framing: users, job, constraints, success metrics.
- 3:00 - 6:00: Architecture stack + boundary callouts.
- 6:00 - 10:00: Primary data flow and UI state transitions.
- 10:00 - 13:00: Offline and sync plan.
- 13:00 - 16:00: Protocol boundaries and test seams.
- 16:00 - 22:00: Scaling and performance.
- 22:00 - 26:00: Observability.
- 26:00 - 30:00: Privacy and safety.
- 30:00 - 35:00: Failure modes, tradeoffs, questions.

## Meta System Design Loop (Interview Focus)

Meta wants clarity under scale, strong product sense, and crisp tradeoffs. Use a tight structure and
explicit numbers. When in doubt, narrate assumptions and move forward.

### Meta Signal Map

- **Scale**: volume, fanout, storage, and read/write amplification.
- **Ranking**: personalization, freshness, and integrity signals.
- **Integrity**: abuse prevention, spam, and policy enforcement.
- **Reliability**: SLOs, rollback plans, and incident detection.
- **Privacy**: access control, data retention, and audit trails.
- **Efficiency**: latency budgets, cache strategy, and cost awareness.

### Meta Interview Structure (45 Minutes)

- **Requirements**: users, core use cases, latency targets, and business goals.
- **Numbers**: MAU/DAU, requests per second, data sizes, and growth assumptions.
- **API**: request/response shape, pagination, and versioning.
- **Data model**: primary entities, indexes, and ownership boundaries.
- **Core flow**: read path and write path, plus one key edge case.
- **Ranking**: signals, candidate generation, and retrieval strategy.
- **Caching**: layers, invalidation, and staleness rules.
- **Safety**: abuse handling, rate limits, and moderation hooks.
- **Observability**: metrics, traces, error budgets, and alerts.
- **Tradeoffs**: consistency vs latency, cost vs accuracy, privacy vs growth.

### Mobile-specific Callouts (Meta)

- Feed caching: prefetch, on-disk cache, and memory budgets.
- Offline: optimistic actions and reconciliation for likes/comments.
- Battery: background work limits and sync windows.
- App size and startup: feature flag gating and cold-start budgets.

### Numbers You Can Reuse

- DAU: 10M, MAU: 100M (adjust if the prompt demands).
- Read ratio: 100:1 for feed-style systems.
- Average feed page: 20 items, each 2-5 KB payload.
- Latency target: p95 < 400 ms for feed fetch, p95 < 150 ms for interactions.

### Example Prompt Outline (Instagram Feed)

- **Goal**: show personalized, fresh content within 400 ms p95.
- **Read path**: client -> feed API -> candidate generator -> ranker -> cache -> response.
- **Write path**: post created -> validation -> media pipeline -> fanout/store -> notify.
- **Ranking**: recency, relationship strength, engagement likelihood, integrity filters.
- **Cache**: per-user feed cache + shared media cache with TTL and invalidation on new posts.

### Common Meta Pitfalls

- Skipping numbers: always anchor scale assumptions.
- Ignoring integrity: spam and abuse are core, not optional.
- Overbuilding v1: deliver a minimal plan, then add ranking sophistication.
- Weak tradeoffs: state a rejected alternative and why it failed.

## Architecture Patterns

- Prefer feature-first modules; inject dependencies with protocols and concrete types.
- Use reducers/stores or async services for state; keep UI thin.
- Model side effects explicitly (async functions returning results/errors, not void callbacks).
- Encapsulate persistence/cache layers; avoid scattering Codable conversions across UI.
- Apply type-safe networking: request builders, typed query items, and predictable decoding.
- For real-time media/AI flows, separate:
  - Transport layer (`WebRTC`/WebSocket, REST).
  - Media layer (`AVAudioEngine`, camera, encoders/decoders).
  - Orchestration/state layer (session manager, turn-taking state machines).
  - Presentation layer (UIKit/SwiftUI + Unity/SceneKit/RealityKit).
- Hide engines (LLM clients, Unity, media stacks) behind small protocol-based facades so you can
  test orchestration logic without spinning heavy dependencies.

### Visual Template – Layered App

```text
 [Presentation]   SwiftUI / UIKit / Unity
        |
 [State/Logic]    Stores, use-cases, orchestrators
        |
 [Services]       Networking, media, persistence, LLM
        |
 [Infra]          HTTP/WebRTC, database, caches, queues
```

Use this layout as a quick sketch in interviews: point to where side effects live and how data
flows down and back up.

> Tip: When a system-design prompt lands, draw this four-layer stack first and narrate where your
> data flows and which layer owns each side effect.

## Scaling Scenarios

- Chat/feed: batching, diffing, pagination (cursor vs. page), optimistic updates, moderation.
- Media: image pipeline (prefetch, in-memory/disk cache, downsampling, placeholders, cancellation).
- Notifications: push handling, deep links, foreground/background behaviors, rate limits.
- Feature flags: remote config with defaults, experiment bucketing, and rollout controls.
- Real-time voice/avatars:
  - Many concurrent sessions, each mixing STT/LLM/TTS.
  - Session sharding (by user/region), autoscaling GPU/CPU workers.
  - Fallback to simpler modes (audio-only, text-only) under load.

## Collaboration and Testing

- Contract tests for networking and storage; use fakes with deterministic data.
- Load/perf testing for critical views; measure scroll FPS, memory, CPU, and IO.
- Rollout playbook: staged rollout, crash monitoring, fast rollback path.
- Document decisions in DocC or README; keep sample commands with CommonShell.
- For real-time systems, add:
  - Synthetic load tests (simulated calls/sessions, packet loss, jitter).
  - Soak tests for long-running sessions (heat, memory leaks, reconnect loops).
  - Dashboards for latency histograms, error spikes, and degradation mode usage.

## Real-time and Streaming Systems

When asked to design a voice or streaming experience, anchor answers in a clear pipeline:

- “Audio → STT → LLM/tools → TTS → client rendering (avatars/UI).”

Key design points:

- Transport:
  - Prefer `WebRTC` for low-latency, bidirectional audio/video + data channels.
  - Use WebSockets for simpler, debug-friendly streaming or control channels.
  - Chunk audio in small frames (for example, 20 ms Opus frames) to keep STT responsive.
- STT/TTS:
  - Decide between cloud-only, on-device-only, or hybrid (on-device first pass, cloud refinement).
  - Use streaming APIs where available so you can start work on partial results.
- Latency budget:
  - Break down mic→STT, STT→LLM, LLM→TTS start, TTS→avatar motion.
  - Target sub-second perceived response for “start of speech” where possible.
- Degradation:
  - Drop video before audio.
  - Lower bitrate before dropping to text-only.
  - Make degradation explicit in the UX (indicators, hints).

### Visual Template – Voice Loop

```text
 Mic  ->  STT  ->  LLM(+tools)  ->  TTS  ->  Player/Avatars
  ^                                                |
  |----------------------------------------------- UI
```

Keep this mental picture and map provider choices (which STT/TTS/LLM) onto the same pipeline.

## LLM and Multimodal Integration

For system design prompts involving LLMs and media (voice/video):

- Treat the LLM as a **service**:
  - Clear request/response contracts (text in, text/tool calls out).
  - Separate policy/safety layers around it.
- Conversation context:
  - Maintain rolling summaries of old messages; keep only the last N turns verbatim.
  - Use dedicated persona/system prompts for each role (bot types, system, tools).
- Latency vs intelligence:
  - Large models give better answers but increase latency and cost.
  - Smaller/distilled models (or on-device models) can handle simpler or latency-sensitive paths.
- Safety and moderation:
  - Run safety checks on user inputs, model outputs, or both.
  - On violation, have clear fallback behaviors (refusal, redaction, or safer responses).

## Turn-taking and Multi-agent Orchestration

Many interviews now include “multi-agent” or “multi-bot” scenarios. Patterns:

- Orchestrator:
  - Single component per conversation that owns **floor control** and session state.
  - Knows which participants are present and what their roles are.
- Turn-taking:
  - Only one active audio speaker at a time; others can respond as text or wait in a queue.
  - Represent state explicitly (for example, `idle → userSpeaking → processing → botSpeaking`).
- LLM prompts:
  - Instruct the model to respect turn boundaries and include an **end-of-turn marker**.
  - Optionally structure output so it is easy for the orchestrator to map to specific participants.
- Barge-in:
  - Support user interruptions that:
    - Cancel current TTS playback.
    - Stop or truncate current LLM generation.
    - Start a new turn with the latest user utterance.

In answers, describe both the **policy** (who is allowed to speak, when) and the **mechanics**
(how you detect end-of-speech, how you cancel in-flight work).

## Failure Modes and SLOs

For system design, show that you own the bad paths:

> Warning: A system design answer is not complete until you have talked about how the system fails,
> what your SLOs are, and how you will detect and respond to incidents.

- Network:
  - Timeouts, retries with backoff, circuit breakers.
  - Handling transient vs sustained outages differently.
- Media:
  - Packet loss and jitter: jitter buffers, concealment, and user feedback.
  - Device-level failures: mic/camera permissions, hardware not available.
- AI components:
  - STT slow or inaccurate: fall back to manual input; reconcile when final transcript arrives.
  - LLM slow: show “thinking” indicators; enforce token/time limits; cut long responses.
  - TTS slow or failing: downgrade to text; retry with a backup voice.
- SLOs:
  - Define simple, interview-appropriate SLOs (for example, 95% of voice turns respond in < 2 s).
  - Mention how you would **measure** and **alert** on breaches.

### Example Latency Budget Table

| Stage                    | Target (ms) |
| ------------------------ | ----------: |
| Mic → STT final          |   200–400   |
| STT → LLM first token    |   100–300   |
| LLM → TTS first audio    |   150–300   |
| TTS start → avatar sync  |    50–150   |

Use this style of table to communicate where time goes and where you would optimize first.

## Interview Prompts and Drills

Use these as practice seeds:

- “Design a real-time voice assistant for a mobile app (audio → STT → LLM → TTS).”
- “Design a multi-participant chat with AI characters; prevent them from talking over each other.”
- “Add AV-style avatars to a text chat so that responses are lip-synced video.”
- “Handle weak networks and intermittent connectivity for a streaming experience.”
- “Scale a voice+LLM service from a few users to thousands of concurrent sessions.”

For each, structure your answer as:

1. Requirements & constraints (users, latency targets, platforms).
2. High-level architecture (clients, services, data flows).
3. Detailed flow for one core operation (for example, one voice turn).
4. Key tradeoffs and alternatives (transport, models, storage).
5. Failure modes, SLOs, and observability.

See also: <doc:system-design-mermaid-prompts>, <doc:instagram-meta-system-design>,
<doc:whatsapp-meta-system-design>, <doc:facebook-meta-system-design>

Tie back to iOS and Swift:

- Call out where you would use `AVAudioSession`, `AVAudioEngine`, `URLSession`, `WebRTC` bindings,
  and, when appropriate, Unity/SceneKit/RealityKit.
- Highlight concurrency and testing strategies (Swift concurrency, protocol-based boundaries,
  deterministic fakes).

## System Design Deep Dives

Use these when you need **code-level** and **architecture-level** detail for specific domains:

- <doc:system-design-deep-dive-avfoundation-composition> – multi-track audio/video composition
  using `AVFoundation` (compositions, mixes, exports).
- <doc:system-design-deep-dive-finance-trading> – trading/finance systems (quotes, orders, rate
  limits, fractional shares, order books).

## Topics

### Mermaid Diagrams

@Links(visualStyle: detailedGrid) {
  - <doc:system-design-mermaid-flowcharts>
  - <doc:system-design-mermaid-class-diagrams>
  - <doc:system-design-mermaid-sequence-diagrams>
  - <doc:system-design-mermaid-challenges-part-1-ios-app-nature>
  - <doc:system-design-mermaid-challenges-part-2-ios-complexity>
  - <doc:system-design-mermaid-challenges-part-3-ios-teams>
  - <doc:system-design-mermaid-challenges-part-4-ios-language-xplat>
  - <doc:system-design-mermaid-challenges-part-5-ios-practice>
}

### System Design Deep Dives

