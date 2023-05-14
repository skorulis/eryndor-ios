//Created by Alexander Skorulis on 30/4/2023.

import Foundation
import GRDB
import Terrain

struct TerrainBlockRecord: Codable, Identifiable {

    static let blockSize: Int = 128
    
    private var rowId: Int64?
    // Top left coordinates
    let x: Int
    let y: Int
    var block: TerrainBlock
    
    var id: String { return coord.id }
    var coord: Coord { Coord(x: x, y: y) }
    
    init(coord: Coord, bottomTerrain: BaseTerrain) {
        self.x = coord.x
        self.y = coord.y
        self.block = TerrainBlockRecord.new(bottomTerrain: bottomTerrain)
    }
    
    func square(at: Coord) -> MapSquare {
        let l = local(coord: at)
        return block.rows[l.y].squares[l.x]
    }
    
    private func local(coord: Coord) -> Coord {
        let i = coord.x - x
        let j = coord.y - y
        guard i < TerrainBlockRecord.blockSize, j < TerrainBlockRecord.blockSize, i >= 0, j >= 0 else {
            fatalError("\(coord) does not live within block at \(self.coord)")
        }
        return Coord(x: i, y: j)
    }
    
    mutating func set(square: MapSquare, at: Coord) {
        let l = local(coord: at)
        block.rows[l.y].squares[l.x] = square
    }
    
    static func new(bottomTerrain: BaseTerrain) -> TerrainBlock {
        let squares = (0..<TerrainBlockRecord.blockSize).map { _ in
            return MapSquare(bottom: bottomTerrain, top: nil)
        }
        let rows = (0..<TerrainBlockRecord.blockSize).map { _ in
            return MapRow(squares: squares)
        }
        return TerrainBlock(rows: rows)
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
    
    var rows: [MapRow]
    
}

struct MapRow: Codable {
    var squares: [MapSquare]
}

struct MapSquare: Codable {
    
    var bottom: BaseTerrain
    var top: OverlayTerrain?
}
