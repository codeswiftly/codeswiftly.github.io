# SwiftUI Common Types

@PageImage(purpose: card, source: "snippets-swiftui-common-types-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "snippets-swiftui-common-types-icon.codex", alt: "Placeholder icon")

@Image(source: "snippets-swiftui-common-types-hero.codex", alt: "SwiftUI common types hero")

Short snippets to drill SwiftUI fundamentals.

```swift
import SwiftUI

struct WelcomeView: View {
  var body: some View {
    Text("Hello, SwiftUI!")
  }
}
```

```swift
import SwiftUI

struct StackView: View {
  var body: some View {
    VStack(spacing: 12) {
      Text("Title").font(.headline)
      Text("Detail").foregroundStyle(.secondary)
    }
    .padding()
  }
}
```

```swift
import SwiftUI

struct RowView: View {
  var body: some View {
    HStack {
      Image(systemName: "bolt.fill")
      Text("Energy")
      Spacer()
      Text("98%").foregroundStyle(.secondary)
    }
    .padding(.horizontal)
  }
}
```

```swift
import SwiftUI

struct LayeredView: View {
  var body: some View {
    ZStack {
      Color.black.opacity(0.85)
      Text("Center").foregroundStyle(.white)
    }
  }
}
```

```swift
import SwiftUI

struct ActionView: View {
  @State private var count = 0

  var body: some View {
    Button("Tap: \(count)") { count += 1 }
      .buttonStyle(.borderedProminent)
  }
}
```

```swift
import SwiftUI

struct ListView: View {
  let items = ["Swift", "SwiftUI", "Foundation"]

  var body: some View {
    List(items, id: \.self) { item in
      Text(item)
    }
  }
}
```

```swift
import SwiftUI

struct NavigationExample: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("Open Details") { Text("Details") }
      }
      .navigationTitle("Library")
    }
  }
}
```

```swift
import SwiftUI

struct ParentView: View {
  @State private var isOn = false

  var body: some View {
    ToggleView(isOn: $isOn)
  }
}

struct ToggleView: View {
  @Binding var isOn: Bool

  var body: some View {
    Toggle("Enabled", isOn: $isOn)
  }
}
```

```swift
import SwiftUI

@MainActor
final class TimerModel: ObservableObject {
  @Published var seconds = 0
}

struct ModelView: View {
  @StateObject private var model = TimerModel()

  var body: some View {
    Text("Seconds: \(model.seconds)")
  }
}
```

```swift
import SwiftUI

struct DismissView: View {
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    Button("Close") { dismiss() }
  }
}
```
