import Foundation

let input = try InputLoader(rootDir: .init(filePath: "~/dev/ios/Eryndor/Tools/TileManager"))
print("Loaded base images")

let mixer = TerrainMixer()

let grassMix = mixer.createMissing(initial: input.images(for: .grass))
let sandMix = mixer.createMissing(initial: input.images(for: .sand))

let defs = FullTerrainDefinition.generate()

let codeWriter = CodeWriter(filename: URL(filePath: "/Users/alex/dev/ios/Eryndor/Frameworks/Terrain/Sources/Model/AllTerrain.swift"))

try codeWriter.write(defs: defs)

let writer = OutputWriter(baseDir: URL(filePath:"/Users/alex/dev/ios/Eryndor/Frameworks/Terrain/Sources/Resource/Media.xcassets/Generated"))

try writer.write(merged: grassMix)
try writer.write(merged: sandMix)
