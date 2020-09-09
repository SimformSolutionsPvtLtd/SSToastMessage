// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSToastMessage",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "SSToastMessage",
            targets: ["SSToastMessage"]),
    ],
    targets: [
        .target(
            name: "SSToastMessage",
            path: "Sources"),
    ],
    swiftLanguageVersions: [.v5]
)
