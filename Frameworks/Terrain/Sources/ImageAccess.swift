//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import SpriteKit

public final class ImageAccess {
    
    public static func image(terrain: BaseTerrain, adjacency: SKTileAdjacencyMask) -> NSImage? {
        let bundle = Bundle.workaround
        let filename = terrain.rawValue + "_" + adjacency.fileExtension
        return bundle.image(forResource: filename)
    }
    
}

private class BundleFinder {}

internal extension Bundle {
    static var workaround: Bundle = {
        return Bundle(for: BundleFinder.self).workaround(name: "Terrain")
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
        fatalError("Could not find workout bundle for \(name)")
    }
    
}
