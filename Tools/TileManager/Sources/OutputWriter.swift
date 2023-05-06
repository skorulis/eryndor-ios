//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import CoreGraphics
import SpriteKit

struct OutputWriter {
    
    let baseDir: URL
    
    func write(merged: MergedTerrainImages) throws {
        for (key, value) in merged.images {
            let filename = merged.terrain.name + "_" + key.fileExtension + ".png"
            let fullPath = baseDir.appending(path: filename)
            let imageRep = NSBitmapImageRep(data: value.tiffRepresentation!)!
            let pngData = imageRep.representation(using: .png, properties: [:])!
            try pngData.write(to: fullPath)
        }
    }
}
