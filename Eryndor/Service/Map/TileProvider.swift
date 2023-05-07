//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import SpriteKit
import Terrain

protocol TileProvider {
    static var tileSize: Int { get }
    
    var tileSet: SKTileSet { get }
    
    func tile(for: AllTerrain) -> SKTileGroup
}
