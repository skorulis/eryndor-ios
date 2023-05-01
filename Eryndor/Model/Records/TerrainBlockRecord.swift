//Created by Alexander Skorulis on 30/4/2023.

import Foundation
import GRDB

struct TerrainBlockRecord: Codable, Identifiable {

    private var rowId: Int64?
    // Top left coordinates
    let x: Int
    let y: Int
    let block: TerrainBlock
    
    var id: String {
        return Coord(x: x, y: y).id
    }
    
    init(coord: Coord, bottomTerrain: BaseTerrainType) {
        self.x = coord.x
        self.y = coord.y
        self.block = TerrainBlock(bottomTerrain: bottomTerrain)
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
    
    let rows: [MapRow]
    
    init(bottomTerrain: BaseTerrainType) {
        let squares = (0..<Self.blockSize).map { _ in
            return MapSquare(layers: [bottomTerrain])
        }
        rows = (0..<Self.blockSize).map { _ in
            return MapRow(squares: squares)
        }
    }
    
    
}

struct MapRow: Codable {
    let squares: [MapSquare]
}

struct MapSquare: Codable {
    let layers: [BaseTerrainType]
}
