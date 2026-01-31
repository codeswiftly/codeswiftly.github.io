# SwiftUI Practice Blocks

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Practice Blocks")
  @PageImage(
    purpose: icon,
    source: "swiftui-practice-blocks-icon.codex",
    alt: "SwiftUI Practice Blocks icon"
  )
  @PageImage(
    purpose: card,
    source: "swiftui-practice-blocks-card.codex",
    alt: "SwiftUI Practice Blocks card"
  )
}

@Image(source: "swiftui-practice-blocks-hero.codex", alt: "SwiftUI Practice Blocks hero")

Each block isolates one concept you can drill quickly. Copy a block, type it from memory, and
then explain the tradeoffs out loud.

## State Toggle

```swift
import SwiftUI

struct StateToggle: View {
  @State private var isOn = false

  var body: some View {
    Toggle("Alerts", isOn: $isOn)
      .toggleStyle(.switch)
  }
}
```

## Binding Child

```swift
import SwiftUI

struct BindingParent: View {
  @State private var text = ""

  var body: some View {
    BindingChild(text: $text)
  }
}

struct BindingChild: View {
  @Binding var text: String

  var body: some View {
    TextField("Name", text: $text)
      .textFieldStyle(.roundedBorder)
  }
}
```

## Observable Model

```swift
import SwiftUI

@MainActor
final class CounterModel: ObservableObject {
  @Published var count = 0

  func increment() { count += 1 }
}

struct ModelHost: View {
  @StateObject private var model = CounterModel()

  var body: some View {
    VStack {
      Text("Count: \(model.count)")
      Button("Add", action: model.increment)
    }
  }
}
```

## Observed Object Child

```swift
import SwiftUI

@MainActor
final class ProfileModel: ObservableObject {
  @Published var name = "Taylor"
}

struct ProfileHost: View {
  @StateObject private var model = ProfileModel()

  var body: some View {
    ProfileChild(model: model)
  }
}

struct ProfileChild: View {
  @ObservedObject var model: ProfileModel

  var body: some View {
    TextField("Name", text: $model.name)
      .textFieldStyle(.roundedBorder)
  }
}
```

## Environment Object

```swift
import SwiftUI

@MainActor
final class ThemeModel: ObservableObject {
  @Published var isDark = false
}

struct ThemeHost: View {
  @StateObject private var theme = ThemeModel()

  var body: some View {
    ThemeToggle()
      .environmentObject(theme)
  }
}

struct ThemeToggle: View {
  @EnvironmentObject private var theme: ThemeModel

  var body: some View {
    Toggle("Dark Mode", isOn: $theme.isDark)
  }
}
```

## Environment Read

```swift
import SwiftUI

struct EnvironmentRead: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    Text(colorScheme == .dark ? "Dark" : "Light")
  }
}
```

## App and Scene Storage

```swift
import SwiftUI

struct StorageBlock: View {
  @AppStorage("accentColor") private var accentColor = "blue"
  @SceneStorage("lastTab") private var lastTab = "home"

  var body: some View {
    Text("Accent: \(accentColor) · Tab: \(lastTab)")
  }
}
```

## Focus Control

```swift
import SwiftUI

struct FocusControl: View {
  enum Field { case email, password }

  @State private var email = ""
  @State private var password = ""
  @FocusState private var focusedField: Field?

  var body: some View {
    VStack {
      TextField("Email", text: $email)
        .focused($focusedField, equals: .email)

      SecureField("Password", text: $password)
        .focused($focusedField, equals: .password)

      Button("Next") {
        focusedField = focusedField == .email ? .password : nil
      }
    }
  }
}
```

## Focus Submit Flow

```swift
import SwiftUI

struct FocusSubmitFlow: View {
  enum Field { case email, password }

  @State private var email = ""
  @State private var password = ""
  @FocusState private var focusedField: Field?

  var body: some View {
    VStack {
      TextField("Email", text: $email)
        .textInputAutocapitalization(.never)
        .keyboardType(.emailAddress)
        .focused($focusedField, equals: .email)
        .submitLabel(.next)

      SecureField("Password", text: $password)
        .focused($focusedField, equals: .password)
        .submitLabel(.done)
    }
    .onSubmit {
      if focusedField == .email {
        focusedField = .password
      } else {
        focusedField = nil
      }
    }
  }
}
```

## Matched Geometry

```swift
import SwiftUI

struct MatchGeometryBlock: View {
  @Namespace private var namespace
  @State private var expanded = false

  var body: some View {
    RoundedRectangle(cornerRadius: expanded ? 24 : 12, style: .continuous)
      .fill(.blue.gradient)
      .frame(width: expanded ? 280 : 120, height: expanded ? 200 : 80)
      .matchedGeometryEffect(id: "card", in: namespace)
      .onTapGesture {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
          expanded.toggle()
        }
      }
  }
}
```

## Matched Geometry Pair

```swift
import SwiftUI

struct MatchGeometryPair: View {
  @Namespace private var namespace
  @State private var expanded = false

  var body: some View {
    VStack {
      if expanded {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
          .fill(.blue.gradient)
          .frame(height: 220)
          .matchedGeometryEffect(id: "card", in: namespace)
      } else {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .fill(.blue.gradient)
          .frame(height: 100)
          .matchedGeometryEffect(id: "card", in: namespace)
      }
    }
    .onTapGesture {
      withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
        expanded.toggle()
      }
    }
  }
}
```
