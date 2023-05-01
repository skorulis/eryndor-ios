//Created by Alexander Skorulis on 16/4/2023.

import Foundation

final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero {
        didSet {
            
        }
    }
    
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
        print(coord)
        
        scene.map.topLayer.setTileGroup(scene.map.tileProvider.cobblestone, forColumn: coord.x, row: coord.y)
        
        Task {
            var block = await terrainManager.block(for: coord)
            var square = block.square(at: coord)
            square.top = .stone
            block.set(square: square, at: coord)
            
            await terrainManager.save(block: block)
        }
    }
    
}

