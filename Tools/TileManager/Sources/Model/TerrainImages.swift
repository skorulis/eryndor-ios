//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit
import Terrain

protocol TerrainContainer {
    var images: [SKTileAdjacencyMask: NSImage] { get }
    var baseName: String { get }
}

struct TerrainImages: TerrainContainer {
    
    let terrain: BaseTerrain
    var images: [SKTileAdjacencyMask: NSImage] = [:]
    
    var baseName: String { terrain.rawValue }
}

struct MergedTerrainImages: TerrainContainer {
    let terrain: MergedTerrain
    var images: [SKTileAdjacencyMask: NSImage] = [:]
    
    var baseName: String { terrain.name }
}

extension TerrainContainer {
    func definitions(baseID: Int) -> [FullTerrainDefinition] {
        return images.map { key, _ in
            return FullTerrainDefinition(
                name: "\(baseName)\(key.name)",
                id: baseID + key.idOffset,
                filename: "\(baseName)_\(key.fileExtension)"
            )
        }
    }
}
