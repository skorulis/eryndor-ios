//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import SpriteKit
import Terrain

struct TileProvider {
    static var tileSize: Int = 128
    
    let baseTileSet: TerrainTileSet<BaseTerrain> = .init()
    let overlayTileSet: TerrainTileSet<OverlayTerrain> = .init()
    
    init() {
        
    }
    
    func tile(for terrain: OverlayTerrain) -> SKTileGroup {
        return overlayTileSet.group(terrain)
    }
    
    func tile(for terrain: BaseTerrain) -> SKTileGroup {
        return baseTileSet.group(terrain)
     }
}
