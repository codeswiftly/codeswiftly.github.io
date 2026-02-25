# OS Device Interview Prep


@Metadata {
  @PageColor(blue)
  @TitleHeading("Review OS Device Interview Prep")
  @CallToAction(url: "doc:os-interview-guide", label: "Open OS interview guide")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Use this guide when you need to show depth across device classes, not just one primary platform.
Target signal: platform-aware decisions with clean Swift implementation and explicit tradeoffs.

## Device Matrix

Device Class | Interview Signal | Concepts to Name | Drill
------------ | ---------------- | ---------------- | -----
Phone | Feature delivery speed without regressions. | lifecycle, state flow, background work boundaries. | <doc:swiftui-deep-dive>
Tablet | Adaptive layouts and productivity-first UX. | split views, keyboard and focus behavior, multitasking constraints. | <doc:swiftui-focus-and-namespace>
Desktop | Desktop-scale architecture and process boundaries. | window/menu flows, filesystem awareness, sandbox assumptions, async orchestration. | <doc:concurrency-dispatch-design>
Wearable | Low-latency interactions under strict power limits. | compact state models, refresh limits, handoff and companion flow choices. | <doc:system-design-and-api>
TV | Focus-driven navigation and remote-first UX clarity. | deterministic navigation graph, focus behavior, media/session reliability. | <doc:system-design-and-api>
Spatial | Spatial interaction modeling and graceful fallback paths. | scene boundaries, presentation context, performance-aware rendering decisions. | <doc:system-design-case-study-snapsnap-architecture-blueprint>

## 45-Minute Rehearsal Loop

- `0-10 min`: pick one device class and restate what "great UX" means under those constraints.
- `10-25 min`: code one small feature slice in Swift and narrate thread and state decisions.
- `25-35 min`: discuss performance, memory, and battery tradeoffs.
- `35-45 min`: redesign for a second device class and call out what changes and what stays shared.

## Prompt Bank (Device-First)

- Design one shared feature that runs across phone, tablet, and desktop with context-specific UX.
- Explain how you keep logic shared while separating view and interaction layers per device class.
- Walk through a wearable companion flow and discuss what is intentionally omitted for scope.
- Describe how you detect and mitigate regressions when adapting phone UX to tablet multitasking.

## Day-Of Device Readiness

- Verify your coding environment can run Swift quickly with readable font and stable screen share.
- Keep one phone-oriented and one desktop-oriented example ready so you can pivot with confidence.
- Prepare one sentence per device class on performance constraints (CPU, memory, battery, latency).
- Rehearse a fallback plan if an interviewer asks for a device class you did not target recently.

## Next Steps

@Links(visualStyle: detailedGrid) {

- <doc:company-guides>
- <doc:os-interview-guide>
- <doc:preparation>
- <doc:day-of>

}
