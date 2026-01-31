@PageImage(purpose: card, source: "companies-meta-final-coding-meta-final-coding-print-view-hierarchy-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-final-coding-meta-final-coding-print-view-hierarchy-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-final-coding-meta-final-coding-print-view-hierarchy-icon.codex", alt: "Placeholder icon")
# Meta Final Coding: Print View Hierarchy Without Superview

@Metadata {
  @TitleHeading("Print view hierarchy without superview")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "meta-final-coding-print-view-hierarchy-icon.codex", alt: "Print view hierarchy without superview icon")
  @PageImage(purpose: card, source: "meta-final-coding-print-view-hierarchy-card.codex", alt: "Print view hierarchy without superview card")
}

@Image(source: "meta-final-coding-print-view-hierarchy-hero.codex", alt: "Meta Final Coding Print View Hierarchy Without Superview hero")

@Image(source: "meta-final-coding-print-view-hierarchy-diagram.codex", alt: "Sorting views using isSubview")

## Practice Context

### Problem

You are given an array of views in random order. Print the hierarchy from top to bottom, but you
cannot access `superview`. Use `isSubview(_:)` to infer structure.

### Approach

- Identify root views: those that are not a subview of any other view in the list.
- To find direct children for a parent, select views that are subviews of the parent, then remove
  any view that is a subview of another candidate (so only direct children remain).
- Recursively print depth-first.

### Complexity

- Time: O(N^2) to compare containment in the worst case.
- Space: O(N)

## Swift Starter

```swift
import UIKit

func printHierarchy(_ views: [UIView]) {
  // TODO: Find roots, find direct children, then DFS print.
}
```

## Swift Solution (Commented)

```swift
import UIKit

func printHierarchy(_ views: [UIView]) {
  let roots = views.filter { candidate in
    !views.contains { other in other !== candidate && other.isSubview(of: candidate) }
  }

  func directChildren(of parent: UIView) -> [UIView] {
    let candidates = views.filter {
      $0 !== parent && parent.isSubview(of: $0) == false && $0.isSubview(of: parent)
    }
    return candidates.filter { child in
      !candidates.contains { other in other !== child && child.isSubview(of: other) }
    }
  }

  func dfs(_ view: UIView, _ depth: Int) {
    let indent = String(repeating: "  ", count: depth)
    print("\(indent)\(view)")
    for child in directChildren(of: view) {
      dfs(child, depth + 1)  // Depth-first print.
    }
  }

  for root in roots {
    dfs(root, 0)
  }
}
```

## Related Patterns

- <doc:top-15-patterns>
