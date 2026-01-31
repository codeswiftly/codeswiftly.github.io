import Testing
@testable import SwiftInterviewGuidePOC

@Suite struct ExampleGreeterTests {
  @Test func greetFormatsMessage() {
    let greeter = ExampleGreeter(greeting: "Hello")
    #expect(greeter.greet(name: "Rismay") == "Hello, Rismay!")
  }
}
