import Foundation

let input = try InputLoader(rootDir: .init(filePath: "~/dev/ios/Eryndor/Tools/TileManager"))

let mixer = TerrainMixer()

let output = mixer.mix(bottom: input.images(for: .sand), top: input.images(for: .grass))

let defs = FullTerrainDefinition.generate(containers: input.images + [output])

let codeWriter = CodeWriter(filename: URL(filePath: "/Users/alex/dev/ios/Eryndor/Frameworks/Terrain/Sources/Model/AllTerrain.swift"))

try codeWriter.write(defs: defs)

let writer = OutputWriter(baseDir: URL(filePath:"/Users/alex/dev/ios/Eryndor/Frameworks/Terrain/Sources/Resource/Media.xcassets/Generated"))

try writer.write(merged: output)
