//Created by Alexander Skorulis on 16/4/2023.

import Foundation

final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero {
        didSet {
            reloadData()
        }
    }
    
    @Published var topLeft: Coord = .init(x: -10, y: -10) {
        didSet {
            reloadData()
        }
    }
    
    @Published var rows: [MapRow] = []
    
    static let squareSize: CGFloat = 32
    
    let scene = MapScene()
    
    init() {
        reloadData()
        
    }
    
}

// MARK: - Computed values

extension MapViewModel {
    var xSquares: Int {
        let value = windowSize.width / Self.squareSize
        return Int(ceil(value))
    }
    
    var ySquares: Int {
        let value = windowSize.height / Self.squareSize
        return Int(ceil(value))
    }
}

// MARK: - Logic

extension MapViewModel {
    
    func tap(location: CGPoint) {
        let converted = CGPoint(x: location.x, y: scene.size.height - location.y)
        let coord = scene.coord(position: converted)
        
        scene.map.topLayer.setTileGroup(scene.map.cobblestone, forColumn: coord.x, row: coord.y)
    }
    
    func reloadData() {
        self.rows = (topLeft.y..<topLeft.y + ySquares).map { y in
            let squares = (topLeft.x..<topLeft.x + xSquares).map { x in
                return MapSquare(x: x, y: y)
            }
            return MapRow(squares: squares)
        }
    }
}

