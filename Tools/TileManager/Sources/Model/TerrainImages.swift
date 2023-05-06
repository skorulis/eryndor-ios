//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit

struct TerrainImages {
    
    let terrain: BaseTerrain
    var images: [SKTileAdjacencyMask: NSImage] = [:]
    
}

struct MergedTerrainImages {
    let terrain: MergedTerrain
    var images: [SKTileAdjacencyMask: NSImage] = [:]
    
}
