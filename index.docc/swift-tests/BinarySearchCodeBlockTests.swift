import Testing

@testable import BinarySearchSnippet

@Test("Binary search finds targets in a rotated array")
func binarySearchFindsTargetsInRotatedArray() {
  let numbers = [4, 5, 6, 7, 0, 1, 2]
  #expect(search(numbers, 0) == 4)
  #expect(search(numbers, 3) == -1)
}

@Test("Binary search handles a single-element array")
func binarySearchHandlesSingleElementArray() {
  let numbers = [7]
  #expect(search(numbers, 7) == 0)
  #expect(search(numbers, 5) == -1)
}
