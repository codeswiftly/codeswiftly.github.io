# Swift Interview Guide

@PageImage(purpose: card, source: "swift-interview-guide-card.codex", alt: "Placeholder card")

@Metadata {
  @PageColor(orange)
  @TitleHeading("Build a Swift Interview System")
  @PageImage(purpose: card, source: "swift-interview-guide-hero.codex", alt: "Swift Interview Guide card")
  @CallToAction(url: "doc:preparation", label: "Start the prep plan")
  @PageImage(purpose: icon, source: "swift-interview-guide-icon.codex", alt: "Swift Interview Guide icon")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "swift-interview-guide-hero.codex", alt: "Swift Interview Guide hero")

A curated prep system for Swift interviews that scales as you add new content.

@Row {
  @Column {
    **Focus**
    Keep each session on one theme. Depth beats breadth.
  }
  @Column {
    **Signal**
    Avoid memorized answers. Narrate tradeoffs, risks, and constraints.
  }
  @Column {
    **Retro**
    End every drill with a short retro and capture the fixes.
  }
}

@Small {
  This guide is treated like a handbook: sharpened over time, never bloated.
}

## Quick Start

Use this guide to prep for Swift developer interviews across iOS, macOS, and server Swift roles.
Each article is a short checklist you can skim before a session.

@Small {
  Quick preview helper: see `code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/quickstart.md`
  for the exact serve commands and URL.
}

## CodeSwiftly Practice Blocks

- Problem solution code blocks may include helper types commented out with `///` so you can skip
  typing them during CodeSwiftly drills.
- Reference and primer pages keep helper types active to show the full definitions.

## Guide Architecture

@Row {
  @Column {
    **Interview Fundamentals**
    Lock in Swift fluency, data structures, and system vocab.
  }
  @Column {
    **Systems next**
    Tackle concurrency, API design, and scaling constraints.
  }
  @Column {
    **Rehearsal last**
    Run timed drills, record mistakes, and iterate fast.
  }
}

## Guided Navigator

@TabNavigator {
  @Tab("Playbook") {
    @Links(visualStyle: detailedGrid) {
      - <doc:preparation>
      - <doc:coding-interview>
      - <doc:coding-interview-study-plan>
      - <doc:system-design-and-api>
      - <doc:behavioral>
      - <doc:day-of>
      - <doc:system-design-mermaid-flowcharts>
      - <doc:system-design-mermaid-class-diagrams>
      - <doc:system-design-mermaid-sequence-diagrams>
      - <doc:system-design-mermaid-challenges-part-1-ios-app-nature>
      - <doc:system-design-mermaid-challenges-part-2-ios-complexity>
      - <doc:system-design-mermaid-challenges-part-3-ios-teams>
      - <doc:system-design-mermaid-challenges-part-4-ios-language-xplat>
      - <doc:system-design-mermaid-challenges-part-5-ios-practice>
    }
  }
  @Tab("Reference") {
    @Links(visualStyle: detailedGrid) {
      - <doc:swift-skill-map>
      - <doc:snippets-common-interview-problems>
      - <doc:swift-references>
      - <doc:swiftui-property-wrappers>
      - <doc:swiftui-state-and-binding>
      - <doc:swiftui-observable-models>
      - <doc:swiftui-environment-and-storage>
      - <doc:swiftui-focus-and-namespace>
      - <doc:swiftui-property-wrapper-decision-tree>
      - <doc:swiftui-timed-demo-script>
      - <doc:swiftui-practice-blocks>
    }
  }
  @Tab("Practice") {
    @Links(visualStyle: detailedGrid) {
      - <doc:practice-platforms>
      - <doc:leetcode-platform>
      - <doc:hackerrank-platform>
      - <doc:coderpad-platform>
      - <tutorial:concurrency-quiz>
      - <tutorial:wallet-add-pass-to-wallet>
      - <tutorial:wallet-verify-with-wallet-identity>
      - <tutorial:wallet-shareable-passes>
    }
  }
  @Tab("Tracks") {
    @Links(visualStyle: detailedGrid) {
      - <doc:foundational-interview-prep>
      - <doc:swift-gotchas>
      - <doc:algorithms-and-patterns>
      - <doc:robinhood-interview-guide>
    }
  }
  @Tab("Deep dives") {
    @Links(visualStyle: detailedGrid) {
      - <doc:deep-dives>
      - <doc:wallet-and-passkit>
      - <doc:concurrency-track>
      - <doc:swiftui-deep-dive>
    }
  }
}

## Interview Loops

Loop | Entry point | What it trains
---- | ----------- | --------------
iOS architecture loop | <doc:system-design> | Layering, dependency seams, and practical iOS tradeoffs.
Company loop | <doc:company-guides> | Calibration, stack-specific pitfalls, and role-focused story selection.

## Prep Tracks

Track | Guided Navigator | Why It Matters
----- | ---------------- | --------------

@Small {
  Keep the hub focused. If a section grows past seven links, split it into a new track.
}

## Topics

### Playbook


### Interview Loops


### Reference


### Practice


### Tracks


### Deep Dives


### Low‑level Mirrors

- [Swift Low‑Level (Sosumi mirrors)](/documentation/swift-low-level-apple-passkit)
