public final class ExampleGreeter {
  public let greeting: String

  public init(greeting: String) {
    self.greeting = greeting
  }

  public func greet(name: String) -> String {
    "\(greeting), \(name)!"
  }
}
