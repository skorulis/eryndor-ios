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
        
        if square(at: coord + (0,1)).bottom == terrain {
            result.formUnion(.top)
        }
        if square(at: coord + (0,-1)).bottom == terrain {
            result.formUnion(.bottom)
        }
        if square(at: coord + (-1,0)).bottom == terrain {
            result.formUnion(.left)
        }
        if square(at: coord + (1,0)).bottom == terrain {
            result.formUnion(.right)
        }
        if square(at: coord + (-1,1)).bottom == terrain && !result.contains(.top) && !result.contains(.left) {
            result.formUnion(.cornerTopLeft)
        }
        if square(at: coord + (-1,-1)).bottom == terrain && !result.contains(.bottom) && !result.contains(.left) {
            result.formUnion(.cornerBottomLeft)
        }
        if square(at: coord + (1,1)).bottom == terrain && !result.contains(.top) && !result.contains(.right) {
            result.formUnion(.cornerTopRight)
        }
        if square(at: coord + (1,-1)).bottom == terrain && !result.contains(.bottom) && !result.contains(.right) {
            result.formUnion(.cornerBottomRight)
        }
        
        return result
        
    }
    
}
