// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "fatsecret-ios-sdk",
    dependencies: [
      .package(url: "https://github.com/antitypical/Result.git", from: "3.2.0"),
        .package(url: "https://github.com/OAuthSwift/OAuthSwift.git", from: "1.2.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "fatsecret-ios-sdk",
            dependencies: []),
    ]
)
