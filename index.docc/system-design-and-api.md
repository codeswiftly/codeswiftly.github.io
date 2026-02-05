# System Design and API

@PageImage(purpose: icon, source: "system-design-and-api-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageColor(red)
  @TitleHeading("Map system design tradeoffs")
  @PageImage(purpose: icon, source: "track-system-design-icon.codex", alt: "System design icon")
  @CallToAction(url: "doc:system-design", label: "Start with the framework")
  @PageImage(purpose: card, source: "system-design-and-api-card.codex", alt: "System Design and API card")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "system-design-and-api-hero.codex", alt: "System Design and API hero")

Architecture notes and API tradeoffs for mobile and service design.

@Row {
  @Column {
    **Frame**
    Start with requirements, constraints, and success metrics.
  }
  @Column {
    **Scope**
    Avoid over-architecting. Propose a minimal v1 first.
  }
  @Column {
    **Risk**
    Call out tradeoffs, failure modes, and rollback plans.
  }
}

## Start Here

@Links(visualStyle: detailedGrid) {

- <doc:system-design>
- <doc:generic-ios-meta-system-design>
- <doc:system-design-case-studies>
- <doc:system-design-mermaid-prompts>
- <doc:system-design-mermaid-flowcharts>
- <doc:system-design-mermaid-class-diagrams>
- <doc:system-design-mermaid-sequence-diagrams>
- <doc:system-design-mermaid-challenges-part-1-ios-app-nature>
- <doc:system-design-mermaid-challenges-part-2-ios-complexity>
- <doc:system-design-mermaid-challenges-part-3-ios-teams>
- <doc:system-design-mermaid-challenges-part-4-ios-language-xplat>
- <doc:system-design-mermaid-challenges-part-5-ios-practice>
- <doc:instagram-meta-system-design>
- <doc:whatsapp-meta-system-design>
- <doc:facebook-meta-system-design>
- <doc:system-design-deep-dive-finance-trading>
- <doc:system-design-deep-dive-avfoundation-composition>
}

## Design Lanes

@Row {
  @Column {
    **System design**
  }
  @Column {
    **Case study**
  }
  @Column {
    **Data pipelines**
    <doc:swift-data-processing-pipelines-in-mono>
  }
}

@Row {
  @Column {
    **Finance systems**
  }
  @Column {
    **Media systems**
  }
}

@Row {
  @Column {
    **API design**
    <doc:apple-wallet-api-design>
  }
  @Column {
    **Identity flows**
    <doc:apple-wallet-requesting-identity-data-design>
  }
}

## Case Study Drills

- <doc:stockmarket-rate-limiter>
- <doc:stockmarket-order-book>
