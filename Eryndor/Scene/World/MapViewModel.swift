//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import Terrain

final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero {
        didSet {
            
        }
    }
    
    @Published var brushType: AllTerrain = .SandCenter
    @Published var layer: MapLayer = .bottom
    
    let scene = MapScene()
    let sqlStore: SQLStore
    let terrainManager: TerrainDataManager
    
    init(sqlStore: SQLStore, terrainManager: TerrainDataManager) {
        self.sqlStore = sqlStore
        self.terrainManager = terrainManager
        Task {
            await scene.map.apply(block: terrainManager.block(for: .zero))
        }
        
    }
    
}

// MARK: - Computed values

extension MapViewModel {
    
}

// MARK: - Logic

extension MapViewModel {
    
    func tap(location: CGPoint) {
        let converted = CGPoint(x: location.x, y: scene.size.height - location.y)
        let coord = scene.coord(position: converted)
        
        Task {
            var chunk = await terrainManager.chunk(coord: coord, radius: 2)
            let tileGroup = tileProvider.tile(for: brushType)
            var block = await terrainManager.block(for: coord)
            var square = block.square(at: coord)
            switch layer {
            case .top:
                square.top = self.brushType
                await scene.map.topLayer.setTileGroup(tileGroup, forColumn: coord.x, row: coord.y)
            case .bottom:
                square.bottom = self.brushType
                await scene.map.bottomLayer.setTileGroup(tileGroup, forColumn: coord.x, row: coord.y)
            }
            chunk.set(square: square, coord: coord)
            await terrainManager.update(chunk: chunk)
        }
    }
    
    private var tileProvider: TileProvider {
        switch layer {
        case .bottom:
            return scene.map.tileProvider
        case .top:
            return scene.map.tileProvider
        }
    }
    
}

