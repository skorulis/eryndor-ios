//  Created by Alexander Skorulis on 7/5/2023.

import Foundation

struct FullTerrainDefinition: Codable {
    
    let name: String
    let id: Int
    let filename: String
    
    static func generate(containers: [TerrainContainer]) -> [FullTerrainDefinition] {
        return containers.reduce([]) { partialResult, container in
            let nextID = partialResult.map { $0.id }.max() ?? 0
            return partialResult + container.definitions(baseID: nextID + 1)
        }
    }
    
}

