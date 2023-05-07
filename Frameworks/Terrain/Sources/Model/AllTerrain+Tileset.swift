//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import SpriteKit

public struct TerrainTileSet {
    
    public let groups: [AllTerrain: SKTileGroup]
    public let tileSet: SKTileSet
    
    public init() {
        groups = Dictionary(grouping: AllTerrain.allCases, by: {$0}).mapValues {
            let texture = SKTexture(imageNamed: $0[0].filename)
            let def = SKTileDefinition(texture: texture)
            return SKTileGroup(tileDefinition: def)
        }
        self.tileSet = SKTileSet(tileGroups: Array(groups.values))
    }
    
    public func group(_ type: AllTerrain) -> SKTileGroup {
        return groups[type]!
    }
    
}
