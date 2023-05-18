import Foundation
import Terrain

let input = try InputLoader(rootDir: .init(filePath: "~/dev/ios/Eryndor/Tools/TileManager"))
print("Loaded base images")

let mixer = TerrainMixer()

let writer = OutputWriter(baseDir: URL(filePath:"/Users/alex/dev/ios/Eryndor/Frameworks/Terrain/Sources/Resource/Media.xcassets/Generated"))

for terrain in BaseTerrain.allCases {
    let output = mixer.createMissing(initial: input.images(for: terrain))
    try writer.write(merged: output)
}

let defs = FullTerrainDefinition.generate()

let codeWriter = CodeWriter(filename: URL(filePath: "/Users/alex/dev/ios/Eryndor/Frameworks/Terrain/Sources/Model/OverlayTerrain.swift"))

try codeWriter.write(defs: defs)


