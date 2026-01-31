@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-valid-word-abbreviation-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-valid-word-abbreviation-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-valid-word-abbreviation-icon.codex", alt: "Placeholder icon")
# Meta Final Coding: Valid Word Abbreviation

@Metadata {
  @TitleHeading("Valid word abbreviation")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-valid-word-abbreviation-icon.codex", alt: "Valid word abbreviation icon")
  @PageImage(purpose: card, source: "meta-final-coding-valid-word-abbreviation-card.codex", alt: "Valid word abbreviation card")
}

@Image(source: "meta-final-coding-valid-word-abbreviation-hero.codex", alt: "Meta Final Coding Valid Word Abbreviation hero")

@Image(source: "meta-final-coding-valid-word-abbreviation-diagram.codex", alt: "Abbreviation scanning with skips")

## Practice Context

### Problem

Given a word and an abbreviation, verify whether the abbreviation is valid.

### Approach

- Walk both strings with two indices.
- When seeing digits, parse the full number and skip that many characters in the word.
- When seeing letters, they must match.

### Complexity

- Time: O(N + M)
- Space: O(1)

![Valid word abbreviation flow](meta-final-coding-valid-word-abbreviation-flow.codex)

## Swift Starter

```swift
func validWordAbbreviation(_ word: String, _ abbr: String) -> Bool {
  // TODO: Walk both strings, parsing digits into skips.
  return false
}
```

## Swift Solution (Commented)

```swift
func validWordAbbreviation(_ word: String, _ abbr: String) -> Bool {
  let wordChars = Array(word)
  let abbrChars = Array(abbr)
  var wordIndex = 0
  var abbrIndex = 0

  while abbrIndex < abbrChars.count && wordIndex <= wordChars.count {
    let current = abbrChars[abbrIndex]
    if current.isNumber {
      if current == "0" { return false }  // Leading zeros are invalid.
      var number = 0
      while abbrIndex < abbrChars.count, abbrChars[abbrIndex].isNumber {
        number = number * 10 + Int(String(abbrChars[abbrIndex]))!
        abbrIndex += 1
      }
      wordIndex += number  // Skip that many letters in the word.
    } else {
      if wordIndex >= wordChars.count || wordChars[wordIndex] != current { return false }
      wordIndex += 1
      abbrIndex += 1
    }
  }

  return wordIndex == wordChars.count && abbrIndex == abbrChars.count
}
```

## Related Patterns

- <doc:top-15-patterns>
