import Foundation

public struct SortedArray<Element>: Collection {

  public typealias Comparator<A> = (A, A) -> Bool

  public enum SearchResult {
    case found(at: Int)
    case notFound(insertAt: Int)
  }

  public var elements: [Element]
  public let sortOrder: Comparator<Element>

  public mutating func insert(_ element: Element) {
    switch search(for: element) {
    case let .found(at: index):
      elements.insert(element, at: index)
    case let .notFound(insertAt: index):
      elements.insert(element, at: index)
    }
  }

  public init<S: Sequence>(
    unsorted: S,
    sortOrder: @escaping Comparator<S.Element>
  ) where S.Element == Element {
    self.elements = unsorted.sorted(by: sortOrder)
    self.sortOrder = sortOrder
  }

  public func search(for element: Element) -> SearchResult {
    var start = elements.startIndex
    var end = elements.endIndex

    while start < end {
      let mid = start + (end - start) / 2
      if sortOrder(elements[mid], element) {
        start = mid + 1
      } else if sortOrder(element, elements[mid]) {
        end = mid
      } else {
        return .found(at: mid)
      }
    }

    return .notFound(insertAt: start)
  }

  /// Returns the first index of `element` at or after `start`, if present.
  public func firstIndex(of element: Element, startingAt start: Int = 0) -> Int? {
    boundIndex(of: element, startingAt: start, findFirst: true)
  }

  /// Returns the last index of `element` at or after `start`, if present.
  public func lastIndex(of element: Element, startingAt start: Int = 0) -> Int? {
    boundIndex(of: element, startingAt: start, findFirst: false)
  }

  /// Binary search for lower/upper bound; O(log n).
  private func boundIndex(of element: Element, startingAt start: Int, findFirst: Bool) -> Int? {
    var low = max(start, 0)
    var high = elements.count - 1
    var result: Int?

    while low <= high {
      let mid = (low + high) / 2
      if sortOrder(elements[mid], element) {
        low = mid + 1
      } else if sortOrder(element, elements[mid]) {
        high = mid - 1
      } else {
        result = mid
        if findFirst {
          high = mid - 1 // continue left for first
        } else {
          low = mid + 1  // continue right for last
        }
      }
    }
    return result
  }

  // MARK: - Collection Protocol

  public var startIndex: Int { elements.startIndex }
  public var endIndex: Int { elements.endIndex }
  public subscript(index: Int) -> Element { elements[index] }
  public func index(after i: Int) -> Int { elements.index(after: i) }
  public func min() -> Element? { elements.first }
  public func max() -> Element? { elements.last }
}

public extension SortedArray where Element: Comparable {
  init() {
    self.init(unsorted: [Element](), sortOrder: <)
  }

  init<S: Sequence>(unsorted: S) where S.Element == Element {
    self.init(unsorted: unsorted, sortOrder: <)
  }
}

public extension Array where Element: Comparable {
  var sortedArray: SortedArray<Element> { SortedArray(unsorted: self) }
}
