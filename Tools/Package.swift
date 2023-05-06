// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TileManager",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "TileManager",
            targets: ["TileManager"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "TileManager",
            dependencies: [

            ],
            path: "Sources"
        )
    ]
)
