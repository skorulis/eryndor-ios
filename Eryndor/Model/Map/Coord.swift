//Created by Alexander Skorulis on 18/4/2023.

import Foundation

struct Coord: Identifiable, Hashable {
    let x: Int
    let y: Int
    
    var id: String { "\(x),\(y)" }
    
    static var zero: Coord { .init(x: 0, y: 0) }
    
    func align(gridSize: Int) -> Coord {
        return Coord(
            x: Self.align(value: x, size: gridSize),
            y: Self.align(value: y, size: gridSize)
        )
    }
    
    private static func align(value: Int, size: Int) -> Int {
        let input = value < 0 ? (value - size + 1) : value
        let a = input / size
        return a * size
    }
}

