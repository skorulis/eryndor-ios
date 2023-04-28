//Created by Alexander Skorulis on 25/4/2023.

import Foundation
import GameplayKit
import SpriteKit

final class MapNode: SKNode {
    
    private let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
    let tileSize = CGSize(width: 128, height: 128)
    let columns = 64
    let rows = 64
    lazy var bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
    
    // create our grass/water layer
    lazy var topLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
    
    lazy var waterTiles = tileSet.tileGroups.first { $0.name == "Water" }
    lazy var grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
    lazy var sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
    lazy var cobblestone = tileSet.tileGroups.first { $0.name == "Cobblestone" }
    
    override init() {
        super.init()
        bottomLayer.fill(with: sandTiles)
        //bottomLayer.anchorPoint = .zero
        //topLayer.anchorPoint = .zero
        addChild(bottomLayer)
        
        // create the noise map
        let noiseMap = makeNoiseMap(columns: columns, rows: rows)

        // make SpriteKit do the work of placing specific tiles
        topLayer.enableAutomapping = true

        // add the grass/water layer to our main map node
        addChild(topLayer)
        
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
    
    override func touchesBegan(with event: NSEvent) {
        print(event)
        let x = event.location(in: bottomLayer)
        print(x)
    }
}
