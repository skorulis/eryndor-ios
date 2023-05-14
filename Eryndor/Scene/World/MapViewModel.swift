//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import Terrain

final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero {
        didSet {
            
        }
    }
    
    @Published var brushType: BaseTerrain = .sand
    @Published var layer: TerrainLayer = .base
    
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
            var square = chunk.square(at: coord)
            switch layer {
            case .base:
                square.bottom = self.brushType
                await scene.map.bottomLayer.setTileGroup(tileGroup, forColumn: coord.x, row: coord.y)
            case .overlay:
                break
                //square.top = self.brushType
                // await scene.map.topLayer.setTileGroup(tileGroup, forColumn: coord.x, row: coord.y)
            }
            chunk.set(square: square, coord: coord)
            await terrainManager.update(chunk: chunk)
            for x in -1...1 {
                for y in -1...1 {
                    await self.updateOverlay(at: Coord(x: coord.x + x, y: coord.y + y))
                }
            }
            
        }
    }
    
    private func updateOverlay(at coord: Coord) async {
        var chunk = await terrainManager.chunk(coord: coord, radius: 1)
        var square = chunk.square(at: coord)
        if square.bottom == .grass {
            square.top = nil
            chunk.set(square: square, coord: coord)
            await scene.map.topLayer.setTileGroup(nil, forColumn: coord.x, row: coord.y)
        } else {
            let adj = chunk.adjacency(coord: coord, terrain: .grass)
            let overlay = OverlayTerrain.match(base: .grass, adjacency: adj)
            let group = overlay.map { tileProvider.tile(for: $0) }
            chunk.set(overlay: overlay, coord: coord)
            await terrainManager.update(chunk: chunk)
            await scene.map.topLayer.setTileGroup(group, forColumn: coord.x, row: coord.y)
        }
    }
    
    private var tileProvider: TileProvider {
        switch layer {
        case .base:
            return scene.map.tileProvider
        case .overlay:
            return scene.map.tileProvider
        }
    }
    
}

