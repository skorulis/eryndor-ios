//  Created by Alexander Skorulis on 6/5/2023.

import CoreGraphics
import Foundation
import SpriteKit

final class TerrainMixer {
    
    func mix(top: TerrainImages, bottom: TerrainImages) {
        let background = bottom.images[.adjacencyAll]!
        for (key, value) in top.images {
            assert(value.size == background.size)
            
            let width = Int(value.size.width)
            
            let rep = NSBitmapImageRep(
                bitmapDataPlanes: nil,
                pixelsWide: width,
                pixelsHigh: Int(value.size.height),
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
            background.draw(in: NSRect(origin: .zero, size: value.size))
            value.draw(in: NSRect(origin: .zero, size: value.size))
            context.flushGraphics()
            let image = context.cgContext.makeImage()!
            let nsImage = NSImage(cgImage: image, size: value.size)
            print(nsImage)
            NSGraphicsContext.restoreGraphicsState()
        }
    }
    
}
