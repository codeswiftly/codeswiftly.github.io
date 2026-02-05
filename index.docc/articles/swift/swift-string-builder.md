# Swift String Builder Patterns

@PageImage(purpose: card, source: "swift-swift-string-builder-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-string-builder-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-string-builder-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review Swift String Builder Patterns")
  @PageImage(purpose: icon, source: "swift-string-builder-icon.codex", alt: "Swift String Builder Patterns icon")
  @PageImage(purpose: card, source: "swift-string-builder-card.codex", alt: "Swift String Builder Patterns card")
}

@Image(source: "swift-string-builder-hero.codex", alt: "Swift String Builder Patterns hero")

Build strings predictably without wasting memory or time, especially in interview settings where
you need clear intent.

## When to Choose a Builder

- You know the parts up front → join once (fastest).
- You stream chunks over time → append with reserved capacity.
- You need custom sinks (logging, codegen) → `TextOutputStream`.
- You work with ASCII/bytes → collect `UInt8` and decode once.

## Join Known Parts

```swift
let csv = rows.map { $0.joined(separator: ",") }.joined(separator: "\n")
```

## Append with Capacity

```swift
func buildGreeting(_ names: [String]) -> String {
  var result = ""
  result.reserveCapacity(names.reduce(0) { $0 + $1.count + 2 })
  for name in names {
    result.append("Hi ")
    result.append(name)
    result.append("!\n")
  }
  return result
}
```

## TextOutputStream Sink

Use when you want `print`-style APIs to target a string buffer.

```swift
struct StringSink: TextOutputStream {
  var storage = ""
  mutating func write(_ string: String) {
    storage.append(string)
  }
}

func renderTable(rows: [[String]]) -> String {
  var sink = StringSink()
  for row in rows {
    print(row.joined(separator: "\t"), to: &sink)
  }
  return sink.storage
}
```

## Byte-first Building

For ASCII-heavy payloads or manual encoding, collect bytes then decode once.

```swift
func renderPath(_ components: [String]) -> String {
  var bytes: [UInt8] = []
  bytes.reserveCapacity(components.reduce(0) { $0 + $1.utf8.count + 1 })
  for (index, component) in components.enumerated() {
    if index > 0 { bytes.append(UInt8(ascii: "/")) }
    bytes.append(contentsOf: component.utf8)
  }
  return String(decoding: bytes, as: UTF8.self)
}
```

## Interview Reminders

- Avoid repeated interpolation inside loops when you can append or join once.
- Call out why you reserved capacity and how it keeps time/space predictable.
- Prefer readable composition over micro-optimizing; annotate when you pick a lower-level path.***
