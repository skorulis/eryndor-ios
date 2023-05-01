//Created by Alexander Skorulis on 30/4/2023.

import Foundation

enum BaseTerrainType: Int, Codable, CaseIterable, Identifiable {
    case grass
    case sand
    case water
    case stone
    
    var name: String { String(describing: self) }
    var id: Int { rawValue }
    
}
