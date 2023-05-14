//  Created by Alexander Skorulis on 14/5/2023.

import Foundation

public extension OverlayTerrain {
    
    static func match(base: BaseTerrain, adjacency: Adjacency) -> OverlayTerrain? {
        if adjacency.rawValue == 0 {
            return nil
        }
        let baseID = (base.rawValue - 1) * 240
        let id = baseID + adjacency.rawValue
        return OverlayTerrain(rawValue: id)!
    }
    
}
