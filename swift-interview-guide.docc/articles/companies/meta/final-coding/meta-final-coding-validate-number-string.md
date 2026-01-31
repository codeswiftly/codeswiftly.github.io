@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-validate-number-string-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-validate-number-string-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-validate-number-string-icon.codex", alt: "Placeholder icon")
# Meta Final Coding: Validate Number String

@Metadata {
  @TitleHeading("Validate a numeric string")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-validate-number-string-icon.codex", alt: "Validate a numeric string icon")
  @PageImage(purpose: card, source: "meta-final-coding-validate-number-string-card.codex", alt: "Validate a numeric string card")
}

@Image(source: "meta-final-coding-validate-number-string-hero.codex", alt: "Meta Final Coding Validate Number String hero")

@Image(source: "meta-final-coding-validate-number-string-diagram.codex", alt: "Parsing digits and decimal")

## Practice Context

### Problem

Validate whether a string represents a number (examples: `123.0`, `-79.0`).

### Approach

- Trim whitespace.
- Optional sign.
- Parse digits, optional decimal point, and digits after the point.
- Require at least one digit overall.

Validation states:

@Image(source: "meta-final-coding-validate-number-string-states.codex", alt: "Simple validation state flow")

### Complexity

- Time: O(N)
- Space: O(1)

## Swift Starter

```swift
func isNumber(_ text: String) -> Bool {
  // TODO: Allow optional sign and a single decimal point.
  // Require at least one digit overall.
  return false
}
```

## Swift Solution (Commented)

```swift
func isNumber(_ text: String) -> Bool {
  let chars = Array(text.trimmingCharacters(in: .whitespacesAndNewlines))
  if chars.isEmpty { return false }

  var index = 0
  if chars[index] == "+" || chars[index] == "-" {
    index += 1  // Consume optional sign.
  }

  var hasDigits = false
  var hasDot = false

  while index < chars.count {
    let current = chars[index]
    if current == "." {
      if hasDot { return false }  // Only one decimal point allowed.
      hasDot = true
    } else if current.isNumber {
      hasDigits = true  // Track that we saw at least one digit.
    } else {
      return false
    }
    index += 1
  }

  return hasDigits  // Must contain at least one digit.
}
```

## Related Patterns

- <doc:top-15-patterns>
