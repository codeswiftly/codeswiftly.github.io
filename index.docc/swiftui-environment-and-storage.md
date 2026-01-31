# SwiftUI Environment and Storage

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Environment and Storage")
  @PageImage(
    purpose: icon,
    source: "swiftui-environment-and-storage-icon.codex",
    alt: "SwiftUI Environment and Storage icon"
  )
  @PageImage(
    purpose: card,
    source: "swiftui-environment-and-storage-card.codex",
    alt: "SwiftUI Environment and Storage card"
  )
}

@Image(source: "swiftui-environment-and-storage-hero.codex", alt: "SwiftUI Environment and Storage hero")

`@Environment` and storage wrappers are about read-only context and persistence. Use them to
avoid prop drilling and to keep user preferences stable across launches.

## Environment

```swift
import SwiftUI

struct EnvironmentExample: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    Text(colorScheme == .dark ? "Dark" : "Light")
  }
}
```

```swift
import SwiftUI

@MainActor
final class SettingsModel: ObservableObject {
  @Published var showsAdvanced = false
}

struct EnvironmentObjectHost: View {
  @StateObject private var settings = SettingsModel()

  var body: some View {
    EnvironmentObjectChild()
      .environmentObject(settings)
  }
}

struct EnvironmentObjectChild: View {
  @EnvironmentObject private var settings: SettingsModel

  var body: some View {
    Toggle("Advanced", isOn: $settings.showsAdvanced)
  }
}
```

## Storage

```swift
import SwiftUI

struct StorageExample: View {
  @AppStorage("preferredTheme") private var preferredTheme = "system"
  @SceneStorage("lastTab") private var lastTab = "home"

  var body: some View {
    Text("Theme: \(preferredTheme) · Tab: \(lastTab)")
  }
}
```

## Interview Callouts

- Use `@Environment` for system context, not for writable state.
- Use `@EnvironmentObject` when many screens need the same reference model.
- Use `@AppStorage` for small scalars, not complex models.
- Use `@SceneStorage` to restore UI across app sessions and windows.

## Avoid These Mistakes

- Do not mutate business state via `@Environment`; pass data explicitly.
- Do not forget to inject `@EnvironmentObject` at the root or previews will crash.
- Do not store large payloads or models in `@AppStorage`.
- Do not treat `@SceneStorage` as a persistence layer across devices.
