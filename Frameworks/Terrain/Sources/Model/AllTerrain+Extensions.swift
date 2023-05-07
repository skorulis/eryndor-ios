//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import SpriteKit

public extension AllTerrain {
    
    var image: NSImage {
        let bundle = Bundle.workaround
        return bundle.image(forResource: filename)!
    }
    
    static var generatedTileSet: SKTileSet {
        let groups = Dictionary(grouping: AllTerrain.allCases, by: {$0}).mapValues {
            let type = $0[0]
            let image = type.image
            let texture = SKTexture(image: image)
            let def = SKTileDefinition(texture: texture)
            let group = SKTileGroup(tileDefinition: def)
            group.name = type.filename
            return group
        }
        let result = SKTileSet(tileGroups: Array(groups.values), tileSetType: .grid)
        result.defaultTileSize = CGSize(width: 128, height: 128)
        result.name = "AllTerrain"
        result.defaultTileGroup = groups.values.first
        return result
    }
}
