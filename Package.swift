// swift-tools-version: 6.0
import PackageDescription

let package = Package(
   name: "LinksKit",
   platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .visionOS(.v1), .watchOS(.v9)],
   products: [.library(name: "LinksKit", targets: ["LinksKit"])],
   targets: [.target(name: "LinksKit")]
)
