//  Created by Alexander Skorulis on 6/5/2023.

import CoreGraphics
import Foundation
import SpriteKit
import Terrain

final class TerrainMixer {
    
    func mix(bottom: TerrainImages, top: TerrainImages) -> MergedTerrainImages{
        let background = bottom.images[.adjacencyAll]!
        let merged = MergedTerrain(bottom: bottom.terrain, top: top.terrain)
        var output = MergedTerrainImages(terrain: merged)
        top.images.forEach { (key, value) in
            output.images[key] = mixImage(bottom: background, top: value)
        }
        return output
    }
    
    private func mixImage(bottom: NSImage, top: NSImage) -> NSImage {
        assert(bottom.size == top.size)
        
        let width = Int(bottom.size.width)
        
        let rep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: width,
            pixelsHigh: Int(bottom.size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: NSColorSpaceName.deviceRGB,
            bytesPerRow: width * 4,
            bitsPerPixel: 32
        )!
        
        let context = NSGraphicsContext(bitmapImageRep: rep)!
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = context
        bottom.draw(in: NSRect(origin: .zero, size: bottom.size))
        top.draw(in: NSRect(origin: .zero, size: bottom.size))
        context.flushGraphics()
        let image = context.cgContext.makeImage()!
        let nsImage = NSImage(cgImage: image, size: bottom.size)
        NSGraphicsContext.restoreGraphicsState()
        return nsImage
    }
    
}
