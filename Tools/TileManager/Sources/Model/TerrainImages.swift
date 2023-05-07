//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit
import Terrain

struct TerrainImages {
    
    let terrain: BaseTerrain
    var images: [SKTileAdjacencyMask: NSImage] = [:]
    
}

struct MergedTerrainImages {
    let terrain: MergedTerrain
    var images: [SKTileAdjacencyMask: NSImage] = [:]
    
    func definitions(baseID: Int) -> [FullTerrainDefinition] {
        return images.map { key, _ in
            return FullTerrainDefinition(
                name: "\(terrain.name)\(key.name)",
                id: baseID + key.idOffset,
                filename: "\(terrain.name)_\(key.fileExtension)"
            )
        }
    }
}
