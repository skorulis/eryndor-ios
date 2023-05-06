// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TileManager",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(path: "../../Frameworks/Terrain")
    ],
    targets: [
        .executableTarget(
            name: "TileManager",
            dependencies: [
                "Terrain"
            ],
            path: "Sources",
            resources: [.copy("Resource")]
        ),
    ]
)
