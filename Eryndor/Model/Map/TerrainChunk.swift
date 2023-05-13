//Created by Alexander Skorulis on 10/5/2023.

import Foundation

public struct TerrainChunk {
    
    let topLeft: Coord
    let size : Int
    let rows: [MapRow]
    var blocks: [Coord: TerrainBlockRecord]
    
    func square(at coord: Coord) -> MapSquare {
        let rounded = coord.align(gridSize: TerrainBlockRecord.blockSize)
        return blocks[rounded]!.square(at: coord)
    }
    
    mutating func set(square: MapSquare, coord: Coord) {
        let rounded = coord.align(gridSize: TerrainBlockRecord.blockSize)
        blocks[rounded]!.set(square: square, at: coord)
    }
    
}
