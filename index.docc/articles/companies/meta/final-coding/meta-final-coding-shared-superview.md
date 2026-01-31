@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-shared-superview-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-shared-superview-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-shared-superview-icon.codex", alt: "Placeholder icon")
# Meta Final Coding: Shared Superview

@Metadata {
  @TitleHeading("Shared superview in a UIView hierarchy")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-shared-superview-icon.codex", alt: "Shared superview in a UIView hierarchy icon")
  @PageImage(purpose: card, source: "meta-final-coding-shared-superview-card.codex", alt: "Shared superview in a UIView hierarchy card")
}

@Image(source: "meta-final-coding-shared-superview-hero.codex", alt: "Meta Final Coding Shared Superview hero")

@Image(source: "meta-final-coding-shared-superview-diagram.codex", alt: "Two views converging to a shared superview")

## Practice Context

### Problem

Given two UIViews `A` and `B` in the same hierarchy, find the first shared superview.

Follow-up: What happens if the hierarchy is very deep (thousands of layers)? How do you optimize?

### Approach

- Walk up from `A`, storing all ancestors in a set.
- Walk up from `B` and return the first ancestor found in the set.
- For very deep trees, compute depths first and advance the deeper view up to the same depth, then
  walk both upward together to find the first match without extra memory.

Pointer movement visualization:

@Image(source: "meta-final-coding-shared-superview-pointers.codex", alt: "Pointers walking up to the shared superview")

### Complexity

- Time: O(h) where h is the height of the hierarchy.
- Space: O(h) for the ancestor set; O(1) for the depth-alignment optimization.

## Swift Starter

```swift
import UIKit

func firstSharedSuperview(_ first: UIView?, _ second: UIView?) -> UIView? {
  // TODO: Walk up from the first, then check ancestors from the second.
  return nil
}
```

## Swift Solution (Commented)

```swift
import UIKit

func firstSharedSuperview(_ first: UIView?, _ second: UIView?) -> UIView? {
  guard let first = first, let second = second else { return nil }

  var ancestors = Set<ObjectIdentifier>()
  var cursor: UIView? = first
  while let view = cursor {
    ancestors.insert(ObjectIdentifier(view))
    cursor = view.superview  // Walk to root.
  }

  cursor = second
  while let view = cursor {
    if ancestors.contains(ObjectIdentifier(view)) {
      return view
    }
    cursor = view.superview
  }

  return nil
}

func firstSharedSuperviewDepthAligned(_ first: UIView?, _ second: UIView?) -> UIView? {
  guard var left = first, var right = second else { return nil }

  func depth(of view: UIView) -> Int {
    var depth = 0
    var cursor: UIView? = view
    while let current = cursor {
      depth += 1
      cursor = current.superview
    }
    return depth
  }

  var leftDepth = depth(of: left)
  var rightDepth = depth(of: right)

  while leftDepth > rightDepth {
    guard let superview = left.superview else { break }
    left = superview
    leftDepth -= 1
  }

  while rightDepth > leftDepth {
    guard let superview = right.superview else { break }
    right = superview
    rightDepth -= 1
  }

  while left !== right {
    guard let leftSuperview = left.superview, let rightSuperview = right.superview else {
      return nil
    }
    left = leftSuperview
    right = rightSuperview
  }

  return left
}
```

### Option 2 (Short)

```swift
import UIKit

func firstSharedSuperviewOption2(_ first: UIView?, _ second: UIView?) -> UIView? {
  guard let first = first, let second = second else { return nil }

  var ancestors = Set<ObjectIdentifier>()
  var cursor: UIView? = first
  while let view = cursor {
    ancestors.insert(ObjectIdentifier(view))
    cursor = view.superview
  }

  cursor = second
  while let view = cursor {
    if ancestors.contains(ObjectIdentifier(view)) {
      return view
    }
    cursor = view.superview
  }

  return nil
}
```

## Related Patterns

- <doc:top-15-patterns>
