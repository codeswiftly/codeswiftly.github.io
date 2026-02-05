# Swift Language Fundamentals

@PageImage(purpose: card, source: "swift-swift-language-fundamentals-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-language-fundamentals-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-language-fundamentals-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Swift Language Fundamentals")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "swift-language-fundamentals-icon.codex", alt: "Swift Language Fundamentals icon")
  @PageImage(purpose: card, source: "swift-language-fundamentals-card.codex", alt: "Swift Language Fundamentals card")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}

@Image(source: "swift-language-fundamentals-hero.codex", alt: "Swift Language Fundamentals hero")

## Quick Links

@Links(visualStyle: detailedGrid) {

- <doc:swift-main-data-structures>
- <doc:custom-data-structures-reference>
- <doc:swift-quick-sheet>
- <doc:swift-gotchas>

}

---

## Optionals (Presence vs Absence)

```swift
let value: Int? = Int("42")
guard let value else { return }
print(value)
```

## Early Exit with `Guard`

```swift
func parse(_ text: String?) -> Int? {
  guard let text else { return nil }
  guard let value = Int(text) else { return nil }
  return value
}
```

## Value Semantics (`Struct`)

```swift
struct Counter {
  var value: Int
}

var left = Counter(value: 1)
var right = left
right.value += 1

// left.value == 1, right.value == 2
```

## Reference Semantics (`Class`)

```swift
final class Box {
  var value: Int
  init(_ value: Int) { self.value = value }
}

let left = Box(1)
let right = left
right.value += 1

// left.value == 2, right.value == 2
```

## Identity Keys with `ObjectIdentifier`

```swift
final class Node {}

let node = Node()
let key = ObjectIdentifier(node)
let visited = Set([key])
```

## `Inout` (Mutate via Parameters)

```swift
func swapValues<T>(_ left: inout T, _ right: inout T) {
  (left, right) = (right, left)
}

var a = 1
var b = 2
swapValues(&a, &b)
```

## Closures Capture Variables

```swift
var total = 0
let add: (Int) -> Void = { value in
  total += value
}

add(3)
add(4)
// total == 7
```

## Arrays (Common Interview Moves)

```swift
var numbers = [3, 1, 2]
numbers.append(4)
let last = numbers.popLast()
let sorted = numbers.sorted()
```

## Dictionaries (Counting with `Default:`)

```swift
let words = ["a", "b", "a"]
var counts: [String: Int] = [:]

for word in words {
  counts[word, default: 0] += 1
}
```

## Sets (Membership and Visited)

```swift
var visited: Set<Int> = []
visited.insert(10)
let seen = visited.contains(10)
```

## Enums (Finite State)

```swift
enum ParseState {
  case start
  case readingNumber
  case done
}

var state: ParseState = .start
state = .readingNumber
```

## Protocols + Extensions (Capabilities)

```swift
protocol DebugRenderable {
  var debugText: String { get }
}

extension Int: DebugRenderable {
  var debugText: String { "Int(\(self))" }
}

let value: DebugRenderable = 42
print(value.debugText)
```

## `String` Indexing (Use `String.Index` Or Convert)

```swift
let text = "👩‍💻swift"
let characters = Array(text)
print(characters[0])
```

## Errors (`Throws` + `Do/Catch`)

```swift
enum ParseError: Error {
  case invalidNumber
}

func parseInt(_ text: String) throws -> Int {
  guard let value = Int(text) else { throw ParseError.invalidNumber }
  return value
}

do {
  let value = try parseInt("123")
  print(value)
} catch {
  print("Invalid input")
}
```
