//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import SpriteKit
import Terrain

struct InputLoader {
    
    private let fileManager = FileManager.default
    let images: [TerrainImages]
    
    init(rootDir: URL) throws {
        images = BaseTerrain.allCases.map { Self.load(terrain: $0) }
    }
    
    private static func load(terrain: BaseTerrain) -> TerrainImages {
        var output = TerrainImages(terrain: terrain)
        Adjacency.inputAdjacency.forEach { adj in
            if let image = Self.image(terrain: terrain, adjacency: adj) {
                output.images[adj] = image
            }
        }
        return output
    }
    
    public static func image(terrain: BaseTerrain, adjacency: Adjacency) -> NSImage? {
        let bundle = Bundle.workaround
        let filename = terrain.baseName + adjacency.fileExtension
        return bundle.image(forResource: filename)
    }
    
    func images(for terrain: BaseTerrain) -> TerrainImages {
        return images.first(where: {$0.terrain == terrain} )!
    }
 
}

private class BundleFinder {}

internal extension Bundle {
    static var workaround: Bundle = {
        return Bundle(for: BundleFinder.self).workaround(name: "TileManager")
    }()
}

public extension Bundle {
    
    func workaround(name: String) -> Bundle {
        let candidates = [
            Bundle.main.resourceURL,
            self.resourceURL,
            self.resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
            self.resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent()
            
        ].compactMap { $0 }
        
        for can in candidates {
            let paths = [
                can.appending(path: "LocalPackages_\(name).bundle"), // iOS
                can.appending(path: "\(name)_\(name).bundle") // Mac
            ]
            for path in paths {
                if let bundle = Bundle.init(url: path) {
                    return bundle
                }
            }
        }
        fatalError("Could not find workaround bundle for \(name)")
    }
    
}
