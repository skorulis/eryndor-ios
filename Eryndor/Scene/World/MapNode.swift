//Created by Alexander Skorulis on 25/4/2023.

import Foundation
import GameplayKit
import SpriteKit
import Terrain

final class MapNode: SKNode {
    
    let tileProvider = TopTileProvider()
    let bottomTileProvider = BottomTileProvider()
    let tileSize = CGSize(width: TopTileProvider.tileSize, height: TopTileProvider.tileSize)
    let columns = TerrainBlock.blockSize
    let rows = TerrainBlock.blockSize
    let bottomLayer: SKTileMapNode
    let topLayer: SKTileMapNode
    
    override init() {
        bottomLayer = SKTileMapNode(tileSet: tileProvider.tileSet, columns: columns, rows: rows, tileSize: tileSize)
        topLayer = SKTileMapNode(tileSet: tileProvider.tileSet, columns: columns, rows: rows, tileSize: tileSize)
        
        super.init()
        addChild(bottomLayer)

        // make SpriteKit do the work of placing specific tiles
        topLayer.enableAutomapping = true
        bottomLayer.enableAutomapping = false

        // add the grass/water layer to our main map node
        addChild(topLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(block: TerrainBlockRecord) {
        for i in 0..<block.block.rows.count {
            let row = block.block.rows[i]
            for j in 0..<row.squares.count {
                let square = row.squares[j]
                bottomLayer.setTileGroup(tileProvider.tile(for: square.bottom), forColumn: j, row: i)
                print(square.bottom)
                if let top = square.top {
                    topLayer.setTileGroup(tileProvider.tile(for: top), forColumn: j, row: i)
                }
            }
        }
    }
}
