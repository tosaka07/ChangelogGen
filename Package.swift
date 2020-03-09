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
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.2"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0"),
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
                "ArgumentParser",
                "Yams",
                "Rainbow"
            ]),
        .testTarget(
            name: "ChangelogGenTests",
            dependencies: ["ChangelogGen"]),
    ]
)
