//  Created by Alexander Skorulis on 6/5/2023.

import Foundation

public enum BaseTerrain: Int, Codable, CaseIterable, TileSetEnum {
    case grass = 1
    case sand = 2
    
    public var baseName: String {
        switch self {
        case .grass: return "Grass"
        case .sand: return "Sand"
        }
    }
    
    public var filename: String {
        return "\(baseName)_Center"
    }
    
}
