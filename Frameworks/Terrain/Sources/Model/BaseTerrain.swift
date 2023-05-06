//  Created by Alexander Skorulis on 6/5/2023.

import Foundation

public enum BaseTerrain: String, CaseIterable {
    case grass = "Grass"
    case sand = "Sand"
}

public struct MergedTerrain {
    public let bottom: BaseTerrain
    public let top: BaseTerrain
    
    public init(bottom: BaseTerrain, top: BaseTerrain) {
        self.bottom = bottom
        self.top = top
    }
    
    public var name: String {
        return "\(bottom.rawValue)_\(top.rawValue)"
    }
}
