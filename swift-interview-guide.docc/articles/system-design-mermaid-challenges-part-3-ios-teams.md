@PageImage(purpose: card, source: "system-design-mermaid-challenges-part-3-ios-teams-card.codex", alt: "Placeholder card")
@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "system-design-mermaid-challenges-part-3-ios-teams-icon.codex", alt: "Placeholder icon")
# System Design Challenges (Large iOS Teams)

@Metadata {
  @TitleHeading("Large iOS teams: 7 challenge diagrams")
  @PageColor(orange)
  @PageImage(purpose: icon, source: "system-design-icon.codex", alt: "System Design icon")
  @PageImage(purpose: card, source: "system-design-card.codex", alt: "System Design card")
}

Use these diagrams to rehearse large-team challenges in Part III.

## 18) Planning and Decision Making

```mermaid
flowchart TD
  RFC[RFC/Design Doc] --> Review[API Review]
  Review --> Plan[Release Plan]
  Plan --> Migration[Deprecation/Migration]
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-01-18-planning-and-decision-making.codex.svg", alt: "18) Planning and decision making diagram")



## 19) Avoid Stepping on Each Other’s Toes

```mermaid
flowchart LR
  Modules[Owned Modules] --> Interfaces[Stable Interfaces]
  Interfaces --> Features[Feature Teams]
  Features --> Flags[Feature Flags]
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-02-19-avoid-stepping-on-each-other-s-toes.codex.svg", alt: "19) Avoid stepping on each other’s toes diagram")



## 20) Shared Architecture Across Apps

```mermaid
flowchart TD
  Shared[Shared SDKs] --> Versioning[SemVer]
  Shared --> Adapters[Compatibility Adapters]
  Shared --> Apps[Multiple Apps]
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-03-20-shared-architecture-across-apps.codex.svg", alt: "20) Shared architecture across apps diagram")



## 21) Tooling Maturity

```mermaid
flowchart LR
  Lint[Lint/Format] --> CI
  Docs[DocC] --> Search[Code Search]
  Metrics[Build/Test Metrics] --> Dashboards
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-04-21-tooling-maturity.codex.svg", alt: "21) Tooling maturity diagram")



## 22) Scaling Build & Merge Times

```mermaid
flowchart LR
  Modularize[Module Boundaries] --> Build[Incremental Builds]
  Build --> CI[CI Caching]
  CI --> Merge[Merge Queue]
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-05-22-scaling-build-merge-times.codex.svg", alt: "22) Scaling build & merge times diagram")



## 23) Mobile Platform Libraries and Teams

```mermaid
flowchart TD
  Platform[Platform Team] --> Contracts[Contracts]
  Contracts --> Paved[Paved Road]
  Paved --> Adoption[Adoption Playbooks]
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-06-23-mobile-platform-libraries-and-teams.codex.svg", alt: "23) Mobile platform libraries and teams diagram")



## 24) In-app Purchases (iOS)

```mermaid
flowchart LR
  StoreKit[StoreKit 2] --> Receipt[Receipt/Server Verify]
  Receipt --> Entitlements
  Entitlements --> Restore
```

@Image(source: "system-design-mermaid-challenges-part-3-ios-teams-07-24-in-app-purchases-ios.codex.svg", alt: "24) In-app purchases (iOS) diagram")


