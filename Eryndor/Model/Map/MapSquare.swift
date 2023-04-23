//Created by Alexander Skorulis on 17/4/2023.

import Foundation

struct MapSquare: Identifiable {
    let x: Int
    let y: Int
    
    var id: String {
        "\(x)-\(y)"
    }
}

struct MapRow: Identifiable {
    let id: UUID = .init()
    let squares: [MapSquare]
}
