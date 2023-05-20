//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit
import Terrain

struct TerrainImages {
    
    let terrain: BaseTerrain
    var images: [Adjacency: NSImage] = [:]
    
    var baseName: String { terrain.baseName }
}
