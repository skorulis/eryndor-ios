//  Created by Alexander Skorulis on 6/5/2023.

import CoreGraphics
import Foundation
import SpriteKit
import Terrain

final class TerrainMixer {
    
    func generateImages(initial: TerrainImages) -> TerrainImages {
        let allOptions = Adjacency.allOptions
        var images = TerrainImages(terrain: initial.terrain)
        for opt in allOptions {
            if let existing = initial.images[opt] {
                images.images[opt] = existing
                continue
            }
            let pieces = opt.components
            let imagePieces = pieces.map { initial.images[$0]! }
            images.images[opt] = merge(images: imagePieces)
        }
        return images
    }
    
    func merge(images: [NSImage]) -> NSImage {
        let mixed = mixImage(bottom: images[0], top: images[1])
        if images.count == 2 {
            return mixed
        }
        let next = [mixed] + images.dropFirst(2)
        return merge(images: next)
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
