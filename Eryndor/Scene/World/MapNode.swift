//Created by Alexander Skorulis on 25/4/2023.

import Foundation
import GameplayKit
import SpriteKit

final class MapNode: SKNode {
    
    let tileProvider = TileProvider()
    let tileSize = CGSize(width: 128, height: 128)
    let columns = TerrainBlock.blockSize
    let rows = TerrainBlock.blockSize
    lazy var bottomLayer = SKTileMapNode(tileSet: tileProvider.tileSet, columns: columns, rows: rows, tileSize: tileSize)
    lazy var topLayer = SKTileMapNode(tileSet: tileProvider.tileSet, columns: columns, rows: rows, tileSize: tileSize)
    
    override init() {
        super.init()
        //bottomLayer.fill(with: sandTiles)
        addChild(bottomLayer)
        
        // create the noise map
        let noiseMap = makeNoiseMap(columns: columns, rows: rows)

        // make SpriteKit do the work of placing specific tiles
        topLayer.enableAutomapping = true

        // add the grass/water layer to our main map node
        addChild(topLayer)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeNoiseMap(columns: Int, rows: Int) -> GKNoiseMap {
        let source = GKPerlinNoiseSource()
        source.persistence = 0.9

        let noise = GKNoise(source)
        let size = vector2(1.0, 1.0)
        let origin = vector2(0.0, 0.0)
        let sampleCount = vector2(Int32(columns), Int32(rows))

        return GKNoiseMap(noise, size: size, origin: origin, sampleCount: sampleCount, seamless: true)
    }
    
    func apply(block: TerrainBlockRecord) {
        for i in 0..<block.block.rows.count {
            let row = block.block.rows[i]
            for j in 0..<row.squares.count {
                let square = row.squares[j]
                let bottom = square.layers[0]
                bottomLayer.setTileGroup(tileProvider.tile(for: bottom), forColumn: j, row: i)
                if square.layers.count >= 2 {
                    let top = square.layers[1]
                    topLayer.setTileGroup(tileProvider.tile(for: top), forColumn: j, row: i)
                }
            }
        }
    }
}
