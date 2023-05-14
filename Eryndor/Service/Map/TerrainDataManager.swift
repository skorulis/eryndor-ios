//Created by Alexander Skorulis on 1/5/2023.

import Foundation
import GRDB
import Terrain

actor TerrainDataManager: ObservableObject {
    
    let sqlStore: SQLStore
    
    private var backingData: [Coord: TerrainBlockRecord] = [:]
    
    init(sqlStore: SQLStore) {
        self.sqlStore = sqlStore
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
        let rounded = coord.align(gridSize: TerrainBlockRecord.blockSize)
        if let value = backingData[rounded] {
            return value
        }
        let found = await self.load(coord: rounded)
        self.backingData[rounded] = found
        return found
    }
    
    func save(block: TerrainBlockRecord) async {
        self.backingData[block.coord] = block
        try! await sqlStore.dbQueue.write { db in
            try block.update(db)
        }
    }
    
    func square(at: Coord) async -> MapSquare {
        let b = await block(for: at)
        return b.square(at: at)
    }
    
    // Get a chunk of data centered on coord
    // Radius is the number of squares in each diretion.
    func chunk(coord: Coord, radius: Int) async -> TerrainChunk {
        let size = 1 + radius * 2
        let topLeft = Coord(x: coord.x - radius, y: coord.y - radius)
        let bottomRight = Coord(x: coord.x + radius, y: coord.y + radius)
        let rowIndexes = topLeft.y...bottomRight.y
        let columnIndexes = topLeft.x...bottomRight.x
        var blockMap: [Coord: TerrainBlockRecord] = [:]
        let rows = await rowIndexes.asyncMap { y in
            let squares = await columnIndexes.asyncMap { x in
                let c = Coord(x: x, y: y)
                let rounded = c.align(gridSize: TerrainBlockRecord.blockSize)
                var b = blockMap[rounded]
                if b == nil {
                    b = await block(for: c)
                }
                blockMap[rounded] = b
                return b!.square(at: c)
            }
            return MapRow(squares: squares)
        }
        return TerrainChunk(topLeft: topLeft, size: size, rows: rows, blocks: blockMap)
    }
    
    func update(chunk: TerrainChunk) async {
        for (coord, value) in chunk.blocks {
            backingData[coord] = value
        }
        
        try! await sqlStore.dbQueue.write { db in
            try chunk.blocks.values.forEach { try $0.update(db) }
        }
    }
    
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
