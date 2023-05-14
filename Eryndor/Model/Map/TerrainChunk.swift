//Created by Alexander Skorulis on 10/5/2023.

import Foundation
import Terrain

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
    
    mutating func set(overlay: OverlayTerrain?, coord: Coord) {
        var square = self.square(at: coord)
        square.top = overlay
        self.set(square: square, coord: coord)
    }
    
    func adjacency(coord: Coord, terrain: BaseTerrain) -> Adjacency {
        var result: Adjacency = .init(rawValue: 0)
        
        if rows[2].squares[1].bottom == terrain {
            result.formUnion(.top)
        }
        if rows[0].squares[1].bottom == terrain {
            result.formUnion(.bottom)
        }
        if rows[1].squares[0].bottom == terrain {
            result.formUnion(.left)
        }
        if rows[1].squares[2].bottom == terrain {
            result.formUnion(.right)
        }
        if rows[2].squares[0].bottom == terrain && !result.contains(.top) && !result.contains(.left) {
            result.formUnion(.cornerTopLeft)
        }
        if rows[0].squares[0].bottom == terrain && !result.contains(.bottom) && !result.contains(.left) {
            result.formUnion(.cornerBottomLeft)
        }
        if rows[2].squares[2].bottom == terrain && !result.contains(.top) && !result.contains(.right) {
            result.formUnion(.cornerTopRight)
        }
        if rows[0].squares[2].bottom == terrain && !result.contains(.bottom) && !result.contains(.right) {
            result.formUnion(.cornerBottomRight)
        }
        
        return result
        
    }
    
}
