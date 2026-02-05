# Snapsnap Architecture Blueprint (First Attempt)

@PageImage(purpose: card, source: "system-design-case-study-snapsnap-architecture-blueprint-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "system-design-case-study-snapsnap-architecture-blueprint-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Example case study: first attempt")
  @PageColor(red)
  @PageImage(purpose: icon, source: "system-design-icon.codex", alt: "System design icon")
  @PageImage(purpose: card, source: "system-design-card.codex", alt: "System design card")
}

@Image(source: "system-design-case-study-snapsnap-architecture-blueprint-hero.codex", alt: "Snapsnap architecture blueprint (first attempt) hero")

This is a first-pass architecture sketch used as a case study example.

## Blueprint

- [Download the PDF](snapsnap-architecture-blueprint-1.pdf)

## Excalidraw Templates

- <doc:snap-snap-excalidraw-templates>

## 45-Minute Tour Script

0:00 - 4:00: Frame the problem and constraints (passive experience, battery, privacy).

4:00 - 9:00: System overview.

- Diagram: <doc:snap-snap-excalidraw-templates#System-at-a-glance>
- Walk the entry points, service layers, user flows, and main screen.

9:00 - 13:00: Startup orchestration.

- Diagram: <doc:snap-snap-excalidraw-templates#App-delegate-orchestration>
- Explain how AppDelegate initializes core services and routes FTUE.

13:00 - 18:00: Core service layers.

- Diagram: <doc:snap-snap-excalidraw-templates#Core-service-layers>
- Name each service and why it is single-responsibility.

18:00 - 22:00: Permissions protocol.

- Diagram: <doc:snap-snap-excalidraw-templates#Permissions-services-protocol>
- Problem and solution: unify permission state for UI clarity.

22:00 - 26:00: One-shot onboarding.

- Diagram: <doc:snap-snap-excalidraw-templates#One-shot-onboarding-flow>
- Explain the single flow and why it reduces friction.

26:00 - 30:00: Passive loop and foresight.

- Diagram: <doc:snap-snap-excalidraw-templates#Core-loop-foresight>
- Show proactive downloads and why they unlock relevance.

30:00 - 34:00: Main screen UI states.

- Diagram: <doc:snap-snap-excalidraw-templates#Main-screen-state-driven-UI>
- Map states to content density and explain UI determinism.

34:00 - 38:00: Dependency injection.

- Diagram: <doc:snap-snap-excalidraw-templates#Dependency-injection-weave>
- Show service injection into SwiftUI/UIKit for testability.

38:00 - 42:00: Platform choices.

- Diagram: <doc:snap-snap-excalidraw-templates#Platform-and-technology-stack>
- Call out SwiftUI, sync, local state, and privacy compliance.

42:00 - 45:00: Questions and tradeoffs.

- Preempt battery vs freshness, permission UX risk, offline gaps, abuse cases.
- End with next-iteration deltas and open risks.

## Mapping to the Generic Outline

### Problem Framing

- Passive, location-based photo sharing with minimal interaction after setup.
- Strong constraints: background execution, battery, and privacy trust.

### Architecture

- Service layers: location, local notifications, networking, cache, state, logging.
- Permissions protocol keeps UI state clean and service logic unified.
- Dependency injection connects core services to SwiftUI/UIKit UI components.

### Data Flow

- App launch initializes services, then routes into FTUE or passive state.
- Geo-fence triggers drive background flows and foresight downloads.
- Main UI states map to location context and content relevance.

### Caching and Offline

- Local cache manager exists; define cache keys, TTLs, and refresh policy.
- Open items: offline write queue, retry policy, and conflict resolution.

### Scaling

- Open items: rate limits, batching, and the chosen fanout strategy.
- Define hot-spot mitigation for location-heavy traffic.

### Observability

- Logging/metrics framework exists; define SLIs and dashboard targets.
- Ensure client metrics track cold start, background success, and crash-free rate.

### Privacy and Safety

- Permissions UX note is central; treat location access as a trust contract.
- Privacy compliance is explicit in the platform stack; define retention and deletion.

### Failure Modes

- Open items: degraded modes, cache-only fallback, and kill switches.
- Define how background tasks fail safely without user-facing churn.

## How to Use it

- Walk the diagram end-to-end and narrate assumptions.
- Call out missing pieces and the next iteration you would propose.
- Use it to practice question-driven iteration.
