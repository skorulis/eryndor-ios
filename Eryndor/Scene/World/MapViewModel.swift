//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import Terrain

final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero {
        didSet {
            
        }
    }
    
    @Published var brushType: AllTerrain = .GrassGridUp
    @Published var layer: MapLayer = .top
    
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
            block.set(square: square, at: coord)
            
            await terrainManager.save(block: block)
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

