//Created by Alexander Skorulis on 18/4/2023.

import Foundation

struct Coord: Identifiable, Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
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
    
    static func +(lhs: Coord, rhs: Coord) -> Coord {
        return Coord(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func +(lhs: Coord, rhs: (Int, Int)) -> Coord {
        return Coord(x: lhs.x + rhs.0, y: lhs.y + rhs.1)
    }
}

