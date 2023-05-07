//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import SpriteKit
import Terrain

struct BottomTileProvider: TileProvider {
    
    static let tileSize: Int = 128
    
    let newTileSet = TerrainTileSet()
    
    var tileSet: SKTileSet {
        return newTileSet.tileSet
    }
    
    init() {
        
    }
    
    func tile(for type: BaseTerrainType) -> SKTileGroup {
        switch type {
        case .grass: return newTileSet.group(.GrassGridCenter)
        case .sand: return newTileSet.group(.SandGridCenter)
        case .water: return newTileSet.group(.GrassGridLeft)
        case .stone: return newTileSet.group(.GrassGridRight)
        }
    }
}

private extension SKTileSet {
    
    func group(named: String) -> SKTileGroup {
        return tileGroups.first { $0.name == named }!
    }
    
}

