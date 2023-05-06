import Foundation

let input = try InputLoader(rootDir: .init(filePath: "~/dev/ios/Eryndor/Tools/TileManager"))

let mixer = TerrainMixer()

mixer.mix(top: input.images(for: .grass), bottom: input.images(for: .sand))
