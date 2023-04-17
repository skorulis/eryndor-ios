//Created by Alexander Skorulis on 16/4/2023.

import Foundation

final class MapViewModel: ObservableObject {
    
    var windowSize: CGSize = .zero
    
    @Published var rows: [MapRow] = []
    
    static let squareSize: CGFloat = 32
    
    init() {
        rows = [
            MapRow(squares: [
                .init(),
                .init(),
                .init()
            ]),
            MapRow(squares: [
                .init(),
                .init(),
                .init()
            ])
        ]
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
