# SwiftUI Focus and Namespace

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Focus and Namespace")
  @PageImage(
    purpose: icon,
    alt: "SwiftUI Focus and Namespace icon"
  )
  @PageImage(
    purpose: card,
    alt: "SwiftUI Focus and Namespace card"
  )
}


`@FocusState` manages text focus, while `@Namespace` anchors matched-geometry animations.
These wrappers make multi-field forms and hero transitions feel intentional.

## Focus State

### Pattern Notes

- Track focus with an enum, not raw strings.
- Move focus on submit to keep forms fast.
- Drive validation and error states off the focused field.

```swift
import SwiftUI

struct FocusExample: View {
  enum Field { case email, password }

  @State private var email = ""
  @State private var password = ""
  @FocusState private var focusedField: Field?

  var body: some View {
    VStack {
      TextField("Email", text: $email)
        .textInputAutocapitalization(.never)
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

## Namespace

### Pattern Notes

- Store the namespace at the highest common ancestor.
- Use one namespace per transition cluster.
- Keep the matched IDs stable and unique.

```swift
import SwiftUI

struct NamespaceExample: View {
  @Namespace private var namespace
  @State private var expanded = false

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: expanded ? 24 : 12, style: .continuous)
        .fill(.blue.gradient)
        .frame(width: expanded ? 300 : 120, height: expanded ? 220 : 80)
        .matchedGeometryEffect(id: "card", in: namespace)
        .onTapGesture {
          withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
            expanded.toggle()
          }
        }
    }
  }
}
```

## Interview Callouts

- `@FocusState` is safer than manual first responder hacks.
- `@Namespace` should live at the scope that owns the transition.
- Match geometry only when it clarifies navigation, not just for flair.

## Avoid These Mistakes

- Do not scatter multiple namespaces across the same transition.
- Do not animate unrelated elements with matched geometry just for style.
- Do not ignore accessibility focus when you drive custom focus changes.
