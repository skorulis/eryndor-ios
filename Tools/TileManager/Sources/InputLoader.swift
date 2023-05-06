//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit

struct InputLoader {
    
    private let fileManager = FileManager.default
    private let images: [TerrainImages]
    
    init(rootDir: URL) throws {
        let resourceDir = fileManager.currentDirectoryPath + "/TileManager_TileManager.bundle/Contents/Resources/Resource/InputTiles"
        let contents = try fileManager.contentsOfDirectory(atPath: resourceDir)
        for file in contents {
            print(file)
        }
        images = BaseTerrain.allCases.map { Self.load(terrain: $0, folder: resourceDir) }
        print(images)
    }
    
    private static func load(terrain: BaseTerrain, folder: String) -> TerrainImages {
        let fileManager = FileManager.default
        var output = TerrainImages(base: terrain)
        SKTileAdjacencyMask.usedAdjacency.forEach { adj in
            let filename = terrain.rawValue + "_" + adj.fileExtension + ".png"
            let fullPath = folder + "/" + filename
            print(fullPath)
            if fileManager.fileExists(atPath: fullPath) {
                let image = NSImage(contentsOfFile: fullPath)
                output.images[adj] = image
            }
        }
        return output
    }
    
}
