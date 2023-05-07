//Created by Alexander Skorulis on 30/4/2023.

import Foundation
import GRDB
import Terrain

struct TerrainBlockRecord: Codable, Identifiable {

    private var rowId: Int64?
    // Top left coordinates
    let x: Int
    let y: Int
    var block: TerrainBlock
    
    var id: String { return coord.id }
    var coord: Coord { Coord(x: x, y: y) }
    
    init(coord: Coord, bottomTerrain: AllTerrain) {
        self.x = coord.x
        self.y = coord.y
        self.block = TerrainBlock(bottomTerrain: bottomTerrain)
    }
    
    func square(at: Coord) -> MapSquare {
        let l = local(coord: at)
        return block.rows[l.y].squares[l.x]
    }
    
    private func local(coord: Coord) -> Coord {
        let i = coord.x - x
        let j = coord.y - y
        guard i < TerrainBlock.blockSize, j < TerrainBlock.blockSize, i >= 0, j >= 0 else {
            fatalError("\(coord) does not live within block at \(self.coord)")
        }
        return Coord(x: i, y: j)
    }
    
    mutating func set(square: MapSquare, at: Coord) {
        let l = local(coord: at)
        block.rows[l.y].squares[l.x] = square
    }
    
}

extension TerrainBlockRecord: MutablePersistableRecord {
    // Update auto-incremented id upon successful insertion
    mutating func didInsert(_ inserted: InsertionSuccess) {
        rowId = inserted.rowID
    }
}

extension TerrainBlockRecord: TableRecord {
    static var databaseTableName: String { "blocks" }
}

extension TerrainBlockRecord: FetchableRecord {
    
    enum Columns: String, ColumnExpression {
        case rowId, x, y, block
    }
    
}

struct TerrainBlock: Codable {
    
    static let blockSize: Int = 128
    
    var rows: [MapRow]
    
    init(bottomTerrain: AllTerrain) {
        let squares = (0..<Self.blockSize).map { _ in
            return MapSquare(bottom: bottomTerrain, top: nil)
        }
        rows = (0..<Self.blockSize).map { _ in
            return MapRow(squares: squares)
        }
    }
    
    
}

struct MapRow: Codable {
    var squares: [MapSquare]
}

struct MapSquare: Codable {
    
    var bottom: AllTerrain
    var top: AllTerrain?
}
