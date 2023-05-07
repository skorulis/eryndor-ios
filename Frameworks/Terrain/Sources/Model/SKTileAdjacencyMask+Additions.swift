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
            .adjacencyUpperRightEdge,
            .adjacencyLowerRightEdge,
            .adjacencyLowerLeftEdge,
            .adjacencyUpperLeftEdge,
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
        case .adjacencyUpperRightEdge: return "Grid_UpRightInterior"
        case .adjacencyLowerRightEdge: return "Grid_DownRightInterior"
        case .adjacencyLowerLeftEdge: return "Grid_DownLeftInterior"
        case .adjacencyUpperLeftEdge: return "Grid_UpLeftInterior"
        default:
            fatalError("Unexpected adjacency \(self)")
        }
    }
    
    var name: String {
        return fileExtension.replacingOccurrences(of: "_", with: "")
    }
    
    var idOffset: Int {
        switch self {
        case .adjacencyAll: return 0
        case .adjacencyDown: return 1
        case .adjacencyUp: return 2
        case .adjacencyLeft: return 3
        case .adjacencyRight: return 4
        case .adjacencyUpperRight: return 5
        case .adjacencyLowerRight: return 6
        case .adjacencyUpperLeft: return 7
        case .adjacencyLowerLeft: return 8
        case .adjacencyUpperRightEdge: return 9
        case .adjacencyLowerRightEdge: return 10
        case .adjacencyLowerLeftEdge: return 11
        case .adjacencyUpperLeftEdge: return 12
        default:
            fatalError("Unexpected adjacency \(self)")
        }
    }
}
