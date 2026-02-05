# SwiftUI Deep Dive - Quick Implementations

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Deep Dive - Quick Implementations")
  @PageImage(
    purpose: icon,
    alt: "SwiftUI Deep Dive Quick Implementations icon"
  )
  @PageImage(
    purpose: card,
    alt: "SwiftUI Deep Dive Quick Implementations card"
  )
}


This deep dive is a fast-moving SwiftUI playbook for interview demos. It focuses on
high-signal UI tricks that look custom but stay low-risk and easy to explain.

Use it when you get prompts like:

- "Show me a SwiftUI screen that feels production-ready."
- "How do you add motion without hurting clarity?"
- "What quick wins make a prototype feel premium?"

---

## The Interview Stance

Anchor your explanation in product trust and readability:

- **Clarity first**: animations should explain state, not distract from content.
- **Performance-aware**: keep effects lightweight and view counts low.
- **Accessibility**: color changes must be legible; avoid motion that hides content.

## Quick Wins Library

### 1) Glass Card with Edge Stroke

Instant depth for cards, sheets, and focus panels.

```swift
import SwiftUI

struct GlassCard<Content: View>: View {
  let content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    content
      .padding(16)
      .background(
        .ultraThinMaterial,
        in: RoundedRectangle(cornerRadius: 18, style: .continuous)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 18, style: .continuous)
          .stroke(.white.opacity(0.18), lineWidth: 1)
      )
      .shadow(radius: 14, y: 8)
  }
}
```

### 2) Shimmer Overlay

A lightweight sheen makes loading states feel alive.

```swift
import SwiftUI

struct Shimmer: ViewModifier {
  @State private var phase: CGFloat = -0.8

  func body(content: Content) -> some View {
    content
      .overlay {
        GeometryReader { proxy in
          let width = proxy.size.width
          LinearGradient(
            colors: [.clear, .white.opacity(0.28), .clear],
            startPoint: .top,
            endPoint: .bottom
          )
          .rotationEffect(.degrees(20))
          .offset(x: phase * width)
          .blendMode(.plusLighter)
        }
        .allowsHitTesting(false)
      }
      .onAppear {
        withAnimation(.linear(duration: 1.25).repeatForever(autoreverses: false)) {
          phase = 1.2
        }
      }
  }
}

extension View {
  func shimmer() -> some View { modifier(Shimmer()) }
}
```

### 3) Matched Geometry Hero Transition

A single modifier can sell custom motion design.

```swift
import SwiftUI

struct HeroDemo: View {
  @Namespace private var namespace
  @State private var selected: Int?

  var body: some View {
    ZStack {
      if let selected {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .fill(.blue.gradient)
          .matchedGeometryEffect(id: selected, in: namespace)
          .ignoresSafeArea()
          .overlay(alignment: .topLeading) {
            Button("Back") {
              withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                self.selected = nil
              }
            }
            .padding()
            .foregroundStyle(.white)
          }
      } else {
        VStack(spacing: 14) {
          ForEach(0..<6, id: \.self) { identifier in
            RoundedRectangle(cornerRadius: 18, style: .continuous)
              .fill(.blue.gradient.opacity(0.9))
              .frame(height: 72)
              .matchedGeometryEffect(id: identifier, in: namespace)
              .onTapGesture {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                  selected = identifier
                }
              }
          }
        }
        .padding()
      }
    }
  }
}
```

### 4) Symbol Effects

Symbol animations read as native without custom motion code.

```swift
import SwiftUI

struct SymbolPop: View {
  @State private var isOn = false

  var body: some View {
    Button {
      isOn.toggle()
    } label: {
      Image(systemName: isOn ? "heart.fill" : "heart")
        .font(.system(size: 34, weight: .semibold))
        .symbolRenderingMode(.palette)
        .foregroundStyle(.pink, .white.opacity(0.35))
        .symbolEffect(.bounce, value: isOn)
    }
  }
}
```

### 5) Collapsing Header

Parallax headers feel app-grade and take minutes to build.

```swift
import SwiftUI

struct CollapsingHeader: View {
  var body: some View {
    ScrollView {
      GeometryReader { proxy in
        let minY = proxy.frame(in: .global).minY
        Rectangle()
          .fill(.purple.gradient)
          .frame(height: max(220 + minY, 120))
          .clipped()
          .overlay(alignment: .bottomLeading) {
            Text("Dashboard")
              .font(.largeTitle.weight(.bold))
              .foregroundStyle(.white)
              .padding()
              .offset(y: minY > 0 ? 0 : minY * 0.35)
          }
          .offset(y: minY > 0 ? -minY : 0)
      }
      .frame(height: 220)

      VStack(spacing: 12) {
        ForEach(0..<20, id: \.self) { _ in
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(.thinMaterial)
            .frame(height: 70)
        }
      }
      .padding()
    }
  }
}
```

### 6) Inner Bevel Highlight

A tiny inner highlight makes surfaces feel physical.

```swift
import SwiftUI

extension View {
  func innerBevel(cornerRadius: CGFloat) -> some View {
    overlay {
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .stroke(.white.opacity(0.22), lineWidth: 1)
        .blendMode(.overlay)
    }
    .overlay {
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .stroke(.black.opacity(0.18), lineWidth: 1)
        .offset(y: 1)
        .blur(radius: 1)
        .mask(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .blendMode(.multiply)
    }
  }
}
```

### 7) Procedural Canvas Background

A subtle animated backdrop reads as custom without heavy cost.

```swift
import SwiftUI

struct ProceduralDots: View {
  var body: some View {
    TimelineView(.animation) { timeline in
      Canvas { context, size in
        let time = timeline.date.timeIntervalSinceReferenceDate
        let step: CGFloat = 18
        for y in stride(from: CGFloat(0), to: size.height, by: step) {
          for x in stride(from: CGFloat(0), to: size.width, by: step) {
            let s = sin((Double(x + y) * 0.02) + time) * 0.5 + 0.5
            let radius = CGFloat(2 + 3 * s)
            context.fill(
              Path(ellipseIn: CGRect(x: x, y: y, width: radius, height: radius)),
              with: .color(.white.opacity(0.12 + 0.18 * s))
            )
          }
        }
      }
    }
    .background(.black)
    .ignoresSafeArea()
  }
}
```

### 8) Sensory Feedback Checkpoints

Use haptics only when state becomes meaningful.

```swift
import SwiftUI

struct HapticToggle: View {
  @State private var isOn = false

  var body: some View {
    Toggle("Alerts", isOn: $isOn)
      .toggleStyle(.switch)
      .sensoryFeedback(.success, trigger: isOn)
      .padding()
  }
}
```

## Property Wrappers and Data Flow Patterns

SwiftUI interviews often hinge on choosing the right wrapper for the right lifecycle.
Use this as your quick decision table.

Wrapper | Use when | Owns the data?
------- | -------- | --------------
`@State` | Local, value-type state inside one view. | Yes
`@Binding` | Child view needs to mutate parent state. | No
`@StateObject` | View creates and owns a reference-type model. | Yes
`@ObservedObject` | View reads a reference-type model owned elsewhere. | No
`@EnvironmentObject` | Shared reference-type model injected by ancestor. | No
`@Environment` | Read-only system or custom environment values. | No
`@AppStorage` | Simple persisted user defaults (small, scalar). | Yes
`@SceneStorage` | State that restores per scene/session. | Yes
`@FocusState` | Focus control across fields and panes. | Yes
`@Namespace` | Matched geometry animations. | Yes

See <doc:swiftui-property-wrappers> for detailed pages on each category.

### Common Data Patterns

**Local UI state**

- Use `@State` for toggles, selections, and ephemeral view control.
- Promote to a model only when multiple views must share behavior.

**Parent-child coordination**

- Use `@Binding` for simple two-way edits (text fields, toggles).
- Avoid passing entire models when only a single field needs mutation.

**Reference models**

- Create with `@StateObject` at the first view that owns lifecycle.
- Read with `@ObservedObject` in descendants.
- For app-wide shared models, inject once and read via `@EnvironmentObject`.

**Persistence and restore**

- Use `@AppStorage` for small user preferences (theme, flags).
- Use `@SceneStorage` for view state you want restored on relaunch.

**Environment and focus**

- Read system settings via `@Environment` (colorScheme, locale, accessibility).
- Control text focus via `@FocusState` instead of manual responders.

### Interview-ready Explanation

If you can only say one thing: _“State lives where it’s owned. Bindings flow down,
changes flow up. Reference models are owned once with `@StateObject`, observed everywhere else.”_

## 15-Minute Demo Script

1. Start with a basic view from <doc:snippets-swiftui-common-types>.
2. Wrap content in `GlassCard` and add `innerBevel`.
3. Apply `shimmer()` to a loading label.
4. Add a matched geometry tap-to-expand card.
5. Finish with a tiny `symbolEffect` on a primary action.

## Practice Checklist

- Start with the decision tree: <doc:swiftui-property-wrapper-decision-tree>.
- Drill isolated blocks: <doc:swiftui-practice-blocks>.
- Run the 10-minute demo sequence: <doc:swiftui-timed-demo-script>.

## Risk Controls and Tradeoffs

- **Avoid motion overload**: do not animate every element at once.
- **Respect Reduce Motion**: guard continuous animation if needed.
- **Keep text crisp**: avoid blurs behind small labels.
- **Limit Canvas area**: use it as a hero backdrop, not for entire screens.

## Closing Checklist

- One primary motion story (hero transition, header collapse, or symbol effect).
- One depth cue (glass card, bevel, or gentle shadow).
- One feedback cue (haptic or color flash).
- Narrate the performance and accessibility reasoning.

## Avoid These Mistakes

- Do not animate every element; pick one motion story.
- Do not blur or glow behind small text.
- Do not rely on continuous animation for core UI state.
