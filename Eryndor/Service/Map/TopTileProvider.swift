//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import SpriteKit
import Terrain

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
    
    func tile(for type: AllTerrain) -> SKTileGroup {
        return tile(for: .grass)
    }
    
    func tile(for type: BaseTerrain) -> SKTileGroup {
        switch type {
        case .grass: return grassTiles
        case .sand: return sandTiles
        }
    }
}

private extension SKTileSet {
    
    func group(named: String) -> SKTileGroup {
        return tileGroups.first { $0.name == named }!
    }
    
}
