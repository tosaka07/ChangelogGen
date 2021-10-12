// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChangelogGen",
    platforms: [.macOS(.v10_13)],
    products: [
        .executable(name: "changeloggen", targets: ["ChangelogGen"])
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.1"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.1"),
        .package(url: "https://github.com/jpsim/Yams", from: "4.0.6"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.1"),
    ],
    targets: [
        .target(
            name: "ChangelogGen",
            dependencies: [
                "ChangelogGenCLI"
            ]),
        .target(
            name: "ChangelogGenCLI",
            dependencies: [
                "PathKit",
                "ArgumentParser",
                "Yams",
                "Rainbow",
            ]),
        .testTarget(
            name: "ChangelogGenTests",
            dependencies: ["ChangelogGen"]),
    ]
)
