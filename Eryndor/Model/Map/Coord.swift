//Created by Alexander Skorulis on 18/4/2023.

import Foundation

struct Coord: Identifiable, Hashable {
    let x: Int
    let y: Int
    
    var id: String { "\(x)-\(y)" }
    
    static var zero: Coord { .init(x: 0, y: 0) }
}
