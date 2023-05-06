//  Created by Alexander Skorulis on 6/5/2023.

import Foundation

enum BaseTerrain: String, CaseIterable {
    case grass = "Grass"
    case sand = "Sand"
}

struct MergedTerrain {
    let bottom: BaseTerrain
    let top: BaseTerrain
    
    var name: String {
        return "\(bottom.rawValue)_\(top.rawValue)"
    }
}
