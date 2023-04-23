//Created by Alexander Skorulis on 22/4/2023.

import Foundation
import GameplayKit
import SpriteKit
import AppKit

class MapScene: SKScene {
    
    let map = SKNode()
    private let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
    let tileSize = CGSize(width: 128, height: 128)
    let columns = 128
    let rows = 128
    lazy var bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
    
    override func didMove(to view: SKView) {
        addChild(map)
        map.xScale = 0.2
        map.yScale = 0.2
        
        let waterTiles = tileSet.tileGroups.first { $0.name == "Water" }
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
        
        bottomLayer.fill(with: sandTiles)
        map.addChild(bottomLayer)
        
        // create the noise map
        let noiseMap = makeNoiseMap(columns: columns, rows: rows)

        // create our grass/water layer
        let topLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)

        // make SpriteKit do the work of placing specific tiles
        topLayer.enableAutomapping = true

        // add the grass/water layer to our main map node
        map.addChild(topLayer)
        
        for column in 0 ..< columns {
            for row in 0 ..< rows {
                let location = vector2(Int32(row), Int32(column))
                let terrainHeight = noiseMap.value(at: location)

                if terrainHeight < 0 {
                    topLayer.setTileGroup(waterTiles, forColumn: column, row: row)
                } else {
                    topLayer.setTileGroup(grassTiles, forColumn: column, row: row)
                }
            }
        }
    }
    
    func coord(position: CGPoint) -> Coord {
        var adjusted = CGPoint(x: position.x - map.position.x, y: position.y + map.position.y)
        adjusted.x /= map.xScale
        adjusted.y /= map.yScale
        let x = bottomLayer.tileColumnIndex(fromPosition: adjusted)
        let y = bottomLayer.tileRowIndex(fromPosition: adjusted)
        // Temporary adjustment to fix some strange bug in the coordinate system
        return Coord(x: x, y: y - 30)
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

}
