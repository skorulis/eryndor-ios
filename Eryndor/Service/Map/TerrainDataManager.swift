//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import GRDB

actor TerrainDataManager: ObservableObject {
    
    let sqlStore: SQLStore
    
    private var backingData: [Coord: TerrainBlockRecord] = [:]
    
    init(sqlStore: SQLStore) {
        self.sqlStore = sqlStore
        backingData[.zero] = TerrainBlockRecord(coord: .zero, bottomTerrain: .grass)
    }
}

// MARK: - Logic

extension TerrainDataManager {
    
    private func load(coord: Coord) async -> TerrainBlockRecord {
        let read = try! await sqlStore.dbQueue.read { db in
            try TerrainBlockRecord
                .filter(TerrainBlockRecord.Columns.x == coord.x)
                .filter(TerrainBlockRecord.Columns.y == coord.y)
                .fetchOne(db)
        }
        if let read {
            return read
        }
        
        return try! await sqlStore.dbQueue.write { db in
            var created = TerrainBlockRecord(coord: coord, bottomTerrain: .grass)
            try created.insert(db)
            return created
        }
    }
    
    func block(for coord: Coord) async -> TerrainBlockRecord {
        let rounded = coord.align(gridSize: TerrainBlock.blockSize)
        if let value = backingData[rounded] {
            return value
        }
        let found = await self.load(coord: rounded)
        self.backingData[rounded] = found
        return found
    }
    
    func save(block: TerrainBlockRecord) async {
        try! await sqlStore.dbQueue.write { db in
            try block.update(db)
        }
    }
    
}
