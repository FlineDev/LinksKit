// swift-tools-version: 5.9
import PackageDescription

let package = Package(
   name: "LinksKit",
   defaultLocalization: "en",
   platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .visionOS(.v1), .watchOS(.v9)],
   products: [.library(name: "LinksKit", targets: ["LinksKit"])],
   targets: [.target(name: "LinksKit", resources: [.process("Localizable.xcstrings")])]
)
