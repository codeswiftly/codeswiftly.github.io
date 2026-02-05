# SwiftUI Property Wrapper Decision Tree

@Metadata {
  @PageColor(blue)
  @TitleHeading("Review SwiftUI Property Wrapper Decision Tree")
  @PageImage(
    purpose: icon,
    alt: "SwiftUI Property Wrapper Decision Tree icon"
  )
  @PageImage(
    purpose: card,
    alt: "SwiftUI Property Wrapper Decision Tree card"
  )
}

@Image(
  alt: "SwiftUI Property Wrapper Decision Tree hero"
)

Use this tree to choose the correct wrapper based on ownership and lifecycle.

## Decision Tree

@Image(
  alt: "SwiftUI property wrapper decision tree diagram"
)

## Quick Notes

- Start with ownership: who creates the data, and who mutates it.
- Prefer value state unless you need shared logic or reuse.
- Promote to `@StateObject` when the model owns behavior across screens.
