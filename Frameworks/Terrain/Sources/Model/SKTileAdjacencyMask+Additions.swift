//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit

extension SKTileAdjacencyMask: Hashable { }

public extension SKTileAdjacencyMask {
    
    static var usedAdjacency: [SKTileAdjacencyMask] {
        return [
            .adjacencyAll,
            .adjacencyDown,
            .adjacencyUp,
            .adjacencyLeft,
            .adjacencyRight,
            .adjacencyUpperRight,
            .adjacencyLowerRight,
            .adjacencyUpperLeft,
            .adjacencyLowerLeft,
        ]
    }
    
    var fileExtension: String {
        switch self {
        case .adjacencyAll: return "Grid_Center"
        case .adjacencyDown: return "Grid_Up"
        case .adjacencyUp: return "Grid_Down"
        case .adjacencyLeft: return "Grid_Right"
        case .adjacencyRight: return "Grid_Left"
        case .adjacencyUpperRight: return "Grid_DownLeft"
        case .adjacencyLowerRight: return "Grid_UpLeft"
        case .adjacencyUpperLeft: return "Grid_DownRight"
        case .adjacencyLowerLeft: return "Grid_UpRight"
        default:
            fatalError("Unexpected adjacency \(self)")
        }
    }
}