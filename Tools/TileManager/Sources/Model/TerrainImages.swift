//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit
import Terrain

protocol TerrainContainer {
    var images: [Adjacency: NSImage] { get }
    var baseName: String { get }
}

struct TerrainImages: TerrainContainer {
    
    let terrain: BaseTerrain
    var images: [Adjacency: NSImage] = [:]
    
    var baseName: String { terrain.baseName }
}
