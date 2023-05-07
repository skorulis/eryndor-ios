//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit
import Terrain

struct InputLoader {
    
    private let fileManager = FileManager.default
    private let images: [TerrainImages]
    
    init(rootDir: URL) throws {
        let resourceDir = fileManager.currentDirectoryPath + "/TileManager_TileManager.bundle/Contents/Resources/Resource/InputTiles"
        images = BaseTerrain.allCases.map { Self.load(terrain: $0, folder: resourceDir) }
    }
    
    private static func load(terrain: BaseTerrain, folder: String) -> TerrainImages {
        var output = TerrainImages(terrain: terrain)
        SKTileAdjacencyMask.usedAdjacency.forEach { adj in
            if let image = ImageAccess.image(terrain: terrain, adjacency: adj) {
                output.images[adj] = image
            }
        }
        return output
    }
    
    func images(for terrain: BaseTerrain) -> TerrainImages {
        return images.first(where: {$0.terrain == terrain} )!
    }
 
}
