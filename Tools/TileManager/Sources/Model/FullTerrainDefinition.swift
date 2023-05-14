//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import Terrain

struct FullTerrainDefinition: Codable {
    
    let name: String
    let id: Int
    let filename: String
    
    static func generate() -> [FullTerrainDefinition] {
        return BaseTerrain.allCases.reduce([]) { partialResult, terrain in
            let nextID = (partialResult.map { $0.id }.max() ?? 0) + 1
            return partialResult + terrain.allDefinitions(baseID: nextID)
        }
    }
    
}

extension BaseTerrain {
    
    func allDefinitions(baseID: Int) -> [FullTerrainDefinition] {
        return Adjacency.allOptions.map { adj in
            return FullTerrainDefinition(
                name: "\(rawValue)\(adj.fileExtension)".replacingOccurrences(of: "_", with: ""),
                id: baseID + adj.rawValue,
                filename: "\(rawValue)\(adj.fileExtension)"
            )
        }
    }
    
}
