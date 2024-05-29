// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSToastMessage",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SSToastMessage",
            targets: ["SSToastMessage"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SSToastMessage",
            path: "SSToastMessage/Sources/Classes"),
    ],
    swiftLanguageVersions: [.v5]
)
