//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import Terrain

@MainActor
final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero {
        didSet {
            
        }
    }
    
    @Published var brushType: BaseTerrain = .sand
    @Published var layer: TerrainLayer = .base
    
    @Published var history: [EditHistory] = []
    
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
        print("Update \(coord)")
        
        Task {
            let square = await terrainManager.square(at: coord)
            history.append(EditHistory(coord: coord, terrain: square.bottom))
            let op = EditHistory(coord: coord, terrain: brushType)
            apply(op: op)
        }
    }
    
    private func apply(op: EditHistory) {
        Task {
            let coord = op.coord
            var chunk = await self.terrainManager.chunk(coord: coord, radius: 2)
            let tileGroup = self.tileProvider.tile(for: op.terrain)
            var square = chunk.square(at: op.coord)
            switch layer {
            case .base:
                square.bottom = op.terrain
                await scene.map.bottomLayer.setTileGroup(tileGroup, forColumn: coord.x, row: coord.y)
            case .overlay:
                break
            }
            chunk.set(square: square, coord: coord)
            for x in -1...1 {
                for y in -1...1 {
                    await self.updateOverlay(
                        at: Coord(x: coord.x + x, y: coord.y + y),
                        brush: op.terrain,
                        chunk: &chunk
                    )
                }
            }
            await terrainManager.update(chunk: chunk)
        }
    }
    
    private func updateOverlay(at coord: Coord, brush: BaseTerrain, chunk: inout TerrainChunk) async {
        var square = chunk.square(at: coord)
        let adjItems = chunk.allAdjacency(coord: coord, excluding: [brush])
        
        guard let anyAdj = adjItems.keys.first, square.bottom != anyAdj else {
            square.top = nil
            chunk.set(square: square, coord: coord)
            scene.map.topLayer.setTileGroup(nil, forColumn: coord.x, row: coord.y)
            return
        }
        let adj = chunk.adjacency(coord: coord, terrain: anyAdj)
        let overlay = OverlayTerrain.match(base: anyAdj, adjacency: adj)
        let group = overlay.map { tileProvider.tile(for: $0) }
        chunk.set(overlay: overlay, coord: coord)
        scene.map.topLayer.setTileGroup(group, forColumn: coord.x, row: coord.y)
    }
    
    func undo() {
        guard let item = history.popLast() else {
            return
        }
        apply(op: item)
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

