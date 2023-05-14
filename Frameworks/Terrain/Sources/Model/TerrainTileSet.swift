//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import SpriteKit

public protocol TileSetEnum: CaseIterable, Hashable {
    var filename: String { get }
}

public struct TerrainTileSet<T: TileSetEnum> {
    
    public let groups: [T: SKTileGroup]
    public let tileSet: SKTileSet
    
    public init() {
        let tiles = Self.generatedTileSet()
        self.tileSet = tiles
        
        var lookup: [T: SKTileGroup] = [:]
        
        for group in tiles.tileGroups {
            let key = T.allCases.first(where: {$0.filename == group.name})!
            lookup[key] = group
        }
        self.groups = lookup
    }
    
    public func group(_ type: T) -> SKTileGroup {
        guard let value = groups[type] else {
            fatalError("Could not find group for \(type)")
        }
        return value
    }
    
    static func generatedTileSet() -> SKTileSet {
        let groups = Dictionary(grouping: T.allCases, by: {$0}).mapValues {
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
        result.defaultTileGroup = groups.values.first
        return result
    }
    
}

public extension TileSetEnum {
    
    var image: NSImage {
        let bundle = Bundle.workaround
        return bundle.image(forResource: filename)!
    }
    
}
