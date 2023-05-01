//Created by Alexander Skorulis on 1/5/2023.

import Foundation

enum MapLayer: String, Identifiable, CaseIterable {
    case bottom
    case top
    
    var id: String { rawValue }
}
