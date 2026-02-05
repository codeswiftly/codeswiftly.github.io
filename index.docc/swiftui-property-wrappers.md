# SwiftUI Property Wrappers

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Property Wrappers")
  @PageImage(
    purpose: icon,
    alt: "SwiftUI Property Wrappers icon"
  )
  @PageImage(
    purpose: card,
    alt: "SwiftUI Property Wrappers card"
  )
}


Property wrappers define ownership and data flow. In interviews, the right wrapper choice shows
clarity about lifecycle, performance, and architecture boundaries.

## Quick Map

- `@State`: local value state owned by the view.
- `@Binding`: two-way access to state owned by a parent.
- `@StateObject`: creates and owns a reference model.
- `@ObservedObject`: observes a reference model owned elsewhere.
- `@EnvironmentObject`: shared model injected by ancestors.
- `@Environment`: read-only access to system or custom environment values.
- `@AppStorage`: user defaults for small preferences.
- `@SceneStorage`: restore view state per scene.
- `@FocusState`: manage text input focus.
- `@Namespace`: matched geometry animation IDs.

## Pages in This Set

@Links(visualStyle: detailedGrid) {
- <doc:swiftui-state-and-binding>
- <doc:swiftui-observable-models>
- <doc:swiftui-environment-and-storage>
- <doc:swiftui-focus-and-namespace>
- <doc:swiftui-property-wrapper-decision-tree>
- <doc:swiftui-timed-demo-script>
- <doc:swiftui-practice-blocks>
}

## Decision Matrix

Wrapper | Use when | Ownership | Source of truth | Best for | Avoid when
------- | -------- | --------- | --------------- | -------- | ----------
`@State` | Local value state for a single view | View owns | View | Small, local UI state | Sharing across view hierarchy
`@Binding` | Child edits parent-owned state | Parent owns | Parent | Two-way control surfaces | Creating state in child
`@StateObject` | View creates a reference model | View owns | View | Lifetimes tied to the view | Recreating on every render
`@ObservedObject` | View observes model owned elsewhere | External owner | External owner | Sharing models across views | Creating models here
`@EnvironmentObject` | Many views share a model | Ancestor owns | Ancestor | Global-ish app models | Feature-local state
`@Environment` | Read system or custom environment values | System/ancestor | Environment | Locale, color scheme, custom values | Mutable state
`@AppStorage` | Persist small preferences | System | UserDefaults | Simple user prefs | Large or sensitive data
`@SceneStorage` | Restore UI state per scene | System | Scene storage | Navigation/UI restore | Cross-scene data
`@FocusState` | Track focus across inputs | View owns | View | Forms, field focus | Data storage
`@Namespace` | Shared animation namespace | View owns | View | Matched geometry effects | Data flow

## Next: Deep Dive Pages


## Then: Practice Blocks


## Interview Mantra

State lives where it is owned. Bindings flow down. Changes flow up. Reference models are owned
once with `@StateObject`, and observed everywhere else.

## Practice Checklist


## Avoid These Mistakes

- Do not mix ownership: create once with `@StateObject`, observe elsewhere.
- Do not use `@EnvironmentObject` as a shortcut for feature-local state.
- Do not store large or sensitive data in `@AppStorage`.
