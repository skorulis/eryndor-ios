//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import SpriteKit

struct TopTileProvider: TileProvider {
    
    static let tileSize: Int = 128
    
    let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
    
    let waterTiles: SKTileGroup
    let grassTiles: SKTileGroup
    let sandTiles: SKTileGroup
    let cobblestone: SKTileGroup
    
    init() {
        waterTiles = tileSet.group(named: "Water")
        grassTiles = tileSet.group(named: "Grass")
        sandTiles = tileSet.group(named: "Sand")
        cobblestone = tileSet.group(named: "Cobblestone")
    }
    
    func tile(for type: BaseTerrainType) -> SKTileGroup {
        switch type {
        case .grass: return grassTiles
        case .sand: return sandTiles
        case .water: return waterTiles
        case .stone: return cobblestone
        }
    }
}

private extension SKTileSet {
    
    func group(named: String) -> SKTileGroup {
        return tileGroups.first { $0.name == named }!
    }
    
}
