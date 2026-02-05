# SwiftUI Observable Models

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Observable Models")
  @PageImage(
    purpose: icon,
    alt: "SwiftUI Observable Models icon"
  )
  @PageImage(
    purpose: card,
    alt: "SwiftUI Observable Models card"
  )
}


Use reference models when state is shared across multiple views or needs business logic.
SwiftUI expects you to declare who owns the model and who observes it.

## Ownership Rules

- `@StateObject`: create and own the model in the first view of its lifecycle.
- `@ObservedObject`: read a model that is owned by someone else.

## Data Patterns

- Shared business state across multiple screens: `@StateObject` at the entry point.
- Child views that only render or edit: `@ObservedObject`.
- App-wide shared models: elevate to `@EnvironmentObject` and inject once.

## Example

```swift
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
  @Published var name = "Taylor"
  @Published var isPremium = false
}

struct ProfileHost: View {
  @StateObject private var model = ProfileViewModel()

  var body: some View {
    ProfileView(model: model)
  }
}

struct ProfileView: View {
  @ObservedObject var model: ProfileViewModel

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(model.name)
      Toggle("Premium", isOn: $model.isPremium)
    }
  }
}
```

```swift
import SwiftUI

@MainActor
final class CartModel: ObservableObject {
  @Published var items: [String] = []

  func add(_ item: String) { items.append(item) }
}

struct CartHost: View {
  @StateObject private var cart = CartModel()

  var body: some View {
    CartSummary(model: cart)
  }
}

struct CartSummary: View {
  @ObservedObject var model: CartModel

  var body: some View {
    Text("Items: \(model.items.count)")
  }
}
```

## Interview Callouts

- Create with `@StateObject` once. Avoid re-creating models on every body recompute.
- Use `@ObservedObject` for read-only ownership in child views.
- Use `@EnvironmentObject` only for true shared, app-level models.
- Prefer value types for local state and reference models for shared state.

## Avoid These Mistakes

- Do not create a `@StateObject` inside a frequently recreated child view.
- Do not use `@ObservedObject` for ownership; it will reset on reload.
- Do not rely on `@EnvironmentObject` for scoped, feature-specific state.
