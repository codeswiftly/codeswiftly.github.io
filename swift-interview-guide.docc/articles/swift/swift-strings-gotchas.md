@PageImage(purpose: card, source: "swift-swift-strings-gotchas-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-strings-gotchas-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-strings-gotchas-icon.codex", alt: "Placeholder icon")
# Strings: Gotchas and Patterns

@Metadata {
  @TitleHeading("Review Strings: Gotchas and Patterns")
  @PageImage(purpose: icon, source: "swift-strings-gotchas-icon.codex", alt: "Strings Gotchas and Patterns icon")
  @PageImage(purpose: card, source: "swift-strings-gotchas-card.codex", alt: "Strings Gotchas and Patterns card")
}

@Image(source: "swift-strings-gotchas-hero.codex", alt: "Strings Gotchas and Patterns hero")

Avoid common pitfalls when working with Swift `String`, `Substring`, and `CharacterSet`.

## Overview

- `String.Index` is not `Int`; slice with indices, not offsets.
- Keep `Substring` views until you must copy to `String`.
- Use `CharacterSet` for filtering/trimming; choose `unicodeScalars` vs. `Character` intentionally.

## Indexing and Slicing

- `String.Index` is not an `Int`; use `startIndex` / `endIndex` and `index(_:offsetBy:)`.
- `endIndex` points just past the last valid element (not the last element itself).
- Prefer guards to avoid overstepping:

```swift
let s = "hello"
let idx = s.index(s.startIndex, offsetBy: 2)  // "l"
let ch = s[idx]
```

- Convert to `Array(s)` only when necessary; it copies and loses grapheme semantics.
- When slicing, keep slices as `Substring` (views). Convert to `String` only when needed:

```swift
let prefix = s.prefix(3)  // Substring "hel"
let asString = String(prefix)  // copies
```

## Character Sets

- Use `CharacterSet` for filtering/trimming:

```swift
let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)

let letters = s.unicodeScalars.filter { CharacterSet.letters.contains($0) }
let onlyLetters = String(String.UnicodeScalarView(letters))
```

- Custom sets:

```swift
let vowels = CharacterSet(charactersIn: "aeiouAEIOU")
```

## Building Strings Efficiently

- Join parts once to avoid quadratic copies; reserve capacity when you can estimate length.
- Accumulate UTF8/Character buffers when you need lower-level control.

Simple builders:

```swift
let message = ["Hello", "World"].joined(separator: " ")
```

Reserve and append:

```swift
var s = ""
s.reserveCapacity(128)
for part in parts {
  s.append(part)
}
```

UTF8 buffering:

```swift
var bytes: [UInt8] = []
bytes.reserveCapacity(256)
for ch in parts {
  bytes.append(contentsOf: ch.utf8)
}
let built = String(decoding: bytes, as: UTF8.self)
```

TextOutputStream sink:

```swift
struct StringSink: TextOutputStream {
  var storage = ""
  mutating func write(_ str: String) { storage.append(str) }
}
```

## Iteration and Search

- Iterate by `Character` to respect grapheme clusters; by `unicodeScalars` for ASCII-only checks.
- String algorithms often pair with concurrency: parsing large blobs can be offloaded to a detached
  task returning a `String` slice; ensure you keep the base storage alive (hold the original
  `String`) when sharing `Substring` across tasks.
- `contains(where:)` works directly on `String`:

```swift
let hasDigit = s.contains { $0.isNumber }
```

## Lower/Upper/Normalization

- Use `lowercased()`/`uppercased()` for case folding; be aware of locale effects (default is
  system locale). For stable comparisons, consider `folding(options:.diacriticInsensitive,
  locale:nil)`.

## Performance Tips

- Avoid repeated `index(_:offsetBy:)` in a loop—advance an index incrementally instead.
- Prefer `Substring` views to avoid copies when slicing repeatedly.
- If you need random access by integer index for heavy use, consider buffering `Array(s)` once and
  work on that array (document why).

## Common Interview Helpers

- Check palindrome ignoring non-letters:

```swift
func isAlnumPalindrome(_ s: String) -> Bool {
  let scalars = s.unicodeScalars
  var left = scalars.startIndex
  var right = scalars.index(before: scalars.endIndex)
  while left < right {
    while left < right && !CharacterSet.alphanumerics.contains(scalars[left]) {
      left = scalars.index(after: left)
    }
    while left < right && !CharacterSet.alphanumerics.contains(scalars[right]) {
      right = scalars.index(before: right)
    }
    if scalars[left].properties.lowercaseMapping != scalars[right].properties.lowercaseMapping {
      return false
    }
    left = scalars.index(after: left)
    right = scalars.index(before: right)
  }
  return true
}
```

- Split on whitespace/newlines:

```swift
let tokens = s.split(whereSeparator: { $0.isWhitespace })
```
