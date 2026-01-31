// swift-tools-version:6.2
import PackageDescription

let package = Package(
  name: "SwiftInterviewGuidePOC",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(name: "SwiftInterviewGuidePOC", targets: ["SwiftInterviewGuidePOC"])
  ],
  targets: [
    .target(name: "SwiftInterviewGuidePOC"),
    .testTarget(name: "SwiftInterviewGuidePOCTests", dependencies: ["SwiftInterviewGuidePOC"])
  ]
)
