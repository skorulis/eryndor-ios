//Created by Alexander Skorulis on 18/4/2023.

import Foundation

struct Coord: Identifiable {
    let x: Int
    let y: Int
    
    var id: String { "\(x)-\(y)" }
}
