# SwiftUI State and Binding

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI State and Binding")
  @PageImage(
    purpose: icon,
    alt: "SwiftUI State and Binding icon"
  )
  @PageImage(
    purpose: card,
    alt: "SwiftUI State and Binding card"
  )
}


`@State` owns local value state. `@Binding` passes a mutable reference to that state into
children. Use this pair for UI toggles, selections, and quick edits.

## When to Use

- `@State`: local, ephemeral view state that does not need sharing.
- `@Binding`: child controls that should write back to a parent.

## Data Patterns

- Local toggle, selection, or draft text: `@State` in the view that owns it.
- Child control of a single field: `@Binding` for that field, not the full model.
- Derived UI values: compute from `@State` instead of duplicating storage.
- Escalate to a reference model when more than one view needs the same source of truth.

## Examples

```swift
import SwiftUI

struct CounterView: View {
  @State private var count = 0

  var body: some View {
    VStack(spacing: 12) {
      Text("Count: \(count)")
      Button("Increment") { count += 1 }
    }
  }
}
```

```swift
import SwiftUI

struct DraftLengthView: View {
  @State private var draft = ""

  var body: some View {
    VStack(spacing: 8) {
      TextField("Draft", text: $draft)
        .textFieldStyle(.roundedBorder)
      Text("Characters: \(draft.count)")
        .font(.caption)
        .foregroundStyle(.secondary)
    }
  }
}
```

```swift
import SwiftUI

struct ParentView: View {
  @State private var isOn = false

  var body: some View {
    ChildToggle(isOn: $isOn)
  }
}

struct ChildToggle: View {
  @Binding var isOn: Bool

  var body: some View {
    Toggle("Enabled", isOn: $isOn)
  }
}
```

## Interview Callouts

- `@State` is view-owned; it resets when the view is recreated.
- Bindings should be narrow. Pass a binding to a single field, not a whole model.
- If multiple views need to share state, promote it to a reference model.
- Avoid duplicate sources of truth: compute derived values from `@State`.

## Avoid These Mistakes

- Do not use `@State` to store reference models or shared data.
- Do not pass a full model by binding when only one field is editable.
- Do not hide business logic inside a binding; keep mutations explicit.
