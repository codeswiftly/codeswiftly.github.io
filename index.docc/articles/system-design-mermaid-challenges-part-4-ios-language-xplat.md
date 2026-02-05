# System Design Challenges (Languages + Cross-platform)


@Metadata {
  @TitleHeading("Languages + cross-platform: 5 challenge diagrams")
  @PageColor(orange)
}

Use these diagrams to rehearse Part IV challenges.

## 25) Adopting New Languages and Frameworks

```mermaid
flowchart LR
  Swift[Swift 6] --> Concurrency[Strict Concurrency]
  SwiftUI --> Migration[Migration Plan]
  Migration --> Training[Training]
```




## 26) Interop Reality (Objective-C/C/C++/Rust)

```mermaid
flowchart LR
  Native[Swift] --> Bridge[Interop Layer]
  Bridge --> Legacy[ObjC/C/C++/Rust]
  Bridge --> Build[Build System]
```




## 27) Cross-platform Feature Development (iOS-native)

```mermaid
flowchart TD
  Schema[Shared Schema] --> Codegen[iOS Codegen]
  Codegen --> Client[iOS Client]
  Client --> Contract[Contract Tests]
```




## 28) Cross-platform vs Native Decision

```mermaid
flowchart LR
  Need[Feature Need] --> Embed[Embed RN/WebView]
  Need --> Native[Native Rewrite]
  Embed --> Costs[Performance/UX/Security]
  Native --> Costs
```




## 29) Web/PWA & Backend-driven Apps

```mermaid
flowchart LR
  Web[WKWebView] --> Auth[Auth/Cookie Isolation]
  Web --> Nav[App-Web Navigation]
  Web --> Cache[Latency + Caching]
```



