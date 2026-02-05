# CoderPad: Rotational Cipher (Facebook)

@PageImage(purpose: card, source: "platforms-coderpad-coderpad-rotational-cipher-card.codex", alt: "Placeholder card")
@Image(source: "platforms-coderpad-coderpad-rotational-cipher-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-coderpad-coderpad-rotational-cipher-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review CoderPad: Rotational Cipher (Facebook)")
  @PageImage(purpose: icon, source: "difficulty-easy.codex", alt: "Easy problem")
  @PageImage(purpose: card, source: "coderpad-rotational-cipher-card.codex", alt: "CoderPad Rotational Cipher (Facebook) card")
}

@Image(source: "coderpad-rotational-cipher-hero.codex", alt: "CoderPad Rotational Cipher (Facebook) hero")

## Overview

- Rotate letters and digits by `rotationFactor`; non-alphanumerics unchanged.
- Uppercase wraps A–Z, lowercase wraps a–z, digits wrap 0–9.
- Inputs up to 1,000,000 chars; rotationFactor up to 1,000,000.

## Swift Implementation

```swift
struct RotationalCipher {
  let backing: String

  func cipher(withRotationFactor factor: Int) -> String {
    String(
      backing.map { char in
        guard let ascii = char.asciiValue else { return char }
        switch ascii {
        case 65...90:  // A-Z
          let rotated = UInt8((Int(ascii - 65) + factor) % 26 + 65)
          return Character(UnicodeScalar(rotated))
        case 97...122:  // a-z
          let rotated = UInt8((Int(ascii - 97) + factor) % 26 + 97)
          return Character(UnicodeScalar(rotated))
        case 48...57:  // 0-9
          let rotated = UInt8((Int(ascii - 48) + factor) % 10 + 48)
          return Character(UnicodeScalar(rotated))
        default:
          return char
        }
      })
  }
}
```

## Swift-specific Notes

- `asciiValue` is only non-nil for ASCII; fine here since input is alphanumeric + punctuation.
- Convert via `UInt8` → `UnicodeScalar`; force-free because ranges stay in ASCII.
- Use modulus on `factor` (implicit via `% 26/% 10`) to handle large rotationFactor.

## Tests (Inline Harness)

```swift
private var testCaseNumber = 1
extension String { fileprivate var characterArray: String { "[\"\(self)\"]" } }
extension RotationalCipher {
  fileprivate static func check(_ expected: String, _ output: String) {
    let right = "\u{2713}"
    let wrong = "\u{2717}"
    if expected == output {
      print("\(right) Test #\(testCaseNumber)")
    } else {
      print(
        "\(wrong) Test #\(testCaseNumber) Expected: \(expected.characterArray) "
          + "Your output: \(output.characterArray)"
      )
    }
    testCaseNumber += 1
  }
}

let c = RotationalCipher(backing: "All-convoYs-9-be:Alert1.")
RotationalCipher.check("Epp-gsrzsCw-3-fi:Epivx5.", c.cipher(withRotationFactor: 4))
let d = RotationalCipher(backing: "abcdZXYzxy-999.@")
RotationalCipher.check("stuvRPQrpq-999.@", d.cipher(withRotationFactor: 200))
```

## Complexity

- O(n) time, O(n) space for output; single pass.

## Edge Cases

- rotationFactor 0 → unchanged.
- Large factor → modulus wraps correctly.
- Non-alphanumerics → unchanged. (If extended Unicode appears, `asciiValue` would be nil; problem
  scope is ASCII.)
