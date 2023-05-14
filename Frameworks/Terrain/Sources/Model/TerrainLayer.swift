//  Created by Alexander Skorulis on 14/5/2023.

import Foundation

public enum TerrainLayer: String, Identifiable, CaseIterable {
    case base
    case overlay
    
    public var id: String { rawValue }
    
}
