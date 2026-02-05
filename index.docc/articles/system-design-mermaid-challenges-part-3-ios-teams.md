# System Design Challenges (Large iOS Teams)


@Metadata {
  @TitleHeading("Large iOS teams: 7 challenge diagrams")
  @PageColor(orange)
}

Use these diagrams to rehearse large-team challenges in Part III.

## 18) Planning and Decision Making

```mermaid
flowchart TD
  RFC[RFC/Design Doc] --> Review[API Review]
  Review --> Plan[Release Plan]
  Plan --> Migration[Deprecation/Migration]
```




## 19) Avoid Stepping on Each Other’s Toes

```mermaid
flowchart LR
  Modules[Owned Modules] --> Interfaces[Stable Interfaces]
  Interfaces --> Features[Feature Teams]
  Features --> Flags[Feature Flags]
```




## 20) Shared Architecture Across Apps

```mermaid
flowchart TD
  Shared[Shared SDKs] --> Versioning[SemVer]
  Shared --> Adapters[Compatibility Adapters]
  Shared --> Apps[Multiple Apps]
```




## 21) Tooling Maturity

```mermaid
flowchart LR
  Lint[Lint/Format] --> CI
  Docs[DocC] --> Search[Code Search]
  Metrics[Build/Test Metrics] --> Dashboards
```




## 22) Scaling Build & Merge Times

```mermaid
flowchart LR
  Modularize[Module Boundaries] --> Build[Incremental Builds]
  Build --> CI[CI Caching]
  CI --> Merge[Merge Queue]
```




## 23) Mobile Platform Libraries and Teams

```mermaid
flowchart TD
  Platform[Platform Team] --> Contracts[Contracts]
  Contracts --> Paved[Paved Road]
  Paved --> Adoption[Adoption Playbooks]
```




## 24) In-app Purchases (iOS)

```mermaid
flowchart LR
  StoreKit[StoreKit 2] --> Receipt[Receipt/Server Verify]
  Receipt --> Entitlements
  Entitlements --> Restore
```



