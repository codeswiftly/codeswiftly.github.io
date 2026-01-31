@PageImage(purpose: card, source: "snippets-foundation-common-types-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "snippets-foundation-common-types-icon.codex", alt: "Placeholder icon")
# Foundation Common Types

@Image(source: "snippets-foundation-common-types-hero.codex", alt: "Foundation common types hero")

Short snippets to drill Foundation basics.

```swift
import Foundation

let now = Date()
let formatter = DateFormatter()
formatter.dateStyle = .medium
formatter.timeStyle = .short
let stamp = formatter.string(from: now)
```

```swift
import Foundation

var comps = DateComponents()
comps.year = 2025
comps.month = 12
comps.day = 26
let calendar = Calendar.current
let date = calendar.date(from: comps)
```

```swift
import Foundation

let url = URL(string: "https://example.com")!
var request = URLRequest(url: url)
request.httpMethod = "GET"
```

```swift
import Foundation

var components = URLComponents(string: "https://example.com/search")!
components.queryItems = [
  URLQueryItem(name: "q", value: "swift"),
  URLQueryItem(name: "page", value: "1"),
]
let finalURL = components.url!
```

```swift
import Foundation

struct Profile: Codable {
  let name: String
  let score: Int
}

let data = try JSONEncoder().encode(Profile(name: "Rismay", score: 42))
let profile = try JSONDecoder().decode(Profile.self, from: data)
```

```swift
import Foundation

let text = "Hello"
let data = Data(text.utf8)
let restored = String(decoding: data, as: UTF8.self)
```

```swift
import Foundation

let fm = FileManager.default
let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
let fileURL = documents.appendingPathComponent("notes.txt")
```

```swift
import Foundation

let defaults = UserDefaults.standard
defaults.set(true, forKey: "isOn")
let isOn = defaults.bool(forKey: "isOn")
```

```swift
import Foundation

NotificationCenter.default.post(
  name: Notification.Name("refresh"),
  object: nil
)
```

```swift
import Foundation

let result: Result<Int, Error> = .success(10)
let value = try result.get()
```
