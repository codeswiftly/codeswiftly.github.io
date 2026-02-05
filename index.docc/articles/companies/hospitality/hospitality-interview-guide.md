# Hospitality Interview Guide


@Metadata {
  @TitleHeading("Hospitality Interview Guide")
  @PageColor(teal)
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Use this guide to prep for a hospitality-style mobile marketplace interview: clear tradeoffs,
end-to-end flow design, and strong storytelling around customer impact.

## Quick Start

- Run one timed coding drill and narrate tradeoffs.
- Walk a marketplace system design end-to-end (search → listing → booking).
- Rehearse two behavioral stories tied to customer impact and ambiguity.

## Signals & Drills

Signal | Read | Drill
------ | ---- | -----
Marketplace system design | <doc:generic-ios-meta-system-design> | <doc:system-design-mermaid-flowcharts>
Search + ranking tradeoffs | <doc:system-design-and-api> | <doc:system-design-mermaid-challenges-part-1-ios-app-nature>
Caching + offline behavior | <doc:lru-cache-primer> | <doc:stockmarket-rate-limiter>
Concurrency and async flows | <doc:concurrency-dispatch-design> | <tutorial:concurrency-quiz>
Behavioral clarity | <doc:behavioral> | <doc:day-of>

## Marketplace Scenarios to Narrate

- Search and filters: relevance vs. latency, pagination, and caching.
- Listing details: offline snapshots, media loading, and optimistic UI.
- Booking flow: idempotency, retries, and failure messaging.
- Messaging: ordering, delivery guarantees, and notification strategy.
- Reviews and trust signals: moderation, abuse handling, and privacy.

## iOS Focus Areas

- Offline and sync strategy: <doc:generic-ios-meta-system-design>
- API boundaries and modeling: <doc:system-design-and-api>
- Performance constraints: <doc:swift-quick-sheet>
- User experience under failure: <doc:system-design-mermaid-sequence-diagrams>

## Topics

### Start Here

- <doc:company-guides>
- <doc:swift-interview-guide>
- <doc:preparation>

### System Design

- <doc:generic-ios-meta-system-design>
- <doc:system-design-and-api>
- <doc:system-design-case-studies>
- <doc:system-design-mermaid-flowcharts>
- <doc:system-design-mermaid-sequence-diagrams>

### Coding and Algorithms

- <doc:algorithms-and-patterns>
- <doc:top-15-patterns>
- <doc:snippets-common-interview-problems>

### Behavioral

- <doc:behavioral>
- <doc:day-of>

### Practice

- <doc:practice-platforms>
- <tutorial:concurrency-quiz>
