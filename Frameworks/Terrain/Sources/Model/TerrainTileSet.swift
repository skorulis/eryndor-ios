//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import SpriteKit

public struct TerrainTileSet {
    
    public let groups: [AllTerrain: SKTileGroup]
    public let tileSet: SKTileSet
    
    public init() {
        let tiles = SKTileSet(named: "AllTerrain")!
        self.tileSet = tiles
        
        var lookup: [AllTerrain: SKTileGroup] = [:]
        
        for group in tiles.tileGroups {
            let key = AllTerrain.allCases.first(where: {$0.filename == group.name})!
            lookup[key] = group
        }
        self.groups = lookup
    }
    
    public func group(_ type: AllTerrain) -> SKTileGroup {
        guard let value = groups[type] else {
            fatalError("Could not find group for \(type)")
        }
        return value
    }
    
}
