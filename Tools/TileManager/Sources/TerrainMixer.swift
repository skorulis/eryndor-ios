//  Created by Alexander Skorulis on 6/5/2023.

import CoreGraphics
import Foundation
import SpriteKit
import Terrain

final class TerrainMixer {
    
    /*func mix(bottom: TerrainImages, top: TerrainImages) -> MergedTerrainImages{
        let background = bottom.images[.adjacencyAll]!
        let merged = MergedTerrain(bottom: bottom.terrain, top: top.terrain)
        var output = MergedTerrainImages(terrain: merged)
        top.images.forEach { (key, value) in
            output.images[key] = mixImage(bottom: background, top: value)
        }
        return output
    }*/
    
    func createMissing(initial: TerrainImages) -> TerrainImages {
        let allOptions = Adjacency.allOptions
        var images = TerrainImages(terrain: initial.terrain)
        for opt in allOptions {
            guard initial.images[opt] == nil, opt.rawValue != 0 else {
                continue
            }
            let pieces = components(adjacency: opt)
            let image1 = initial.images[pieces[0]]!
            let image2 = initial.images[pieces[1]]!
            images.images[opt] = mixImage(bottom: image1, top: image2)
        }
        return images
    }
    
    func components(adjacency: Adjacency) -> [Adjacency] {
        switch adjacency {
        case [.left, .right]: return [.left, .right]
        case [.top, .bottom]: return [.top, .bottom]
        case [.top, .left, .right]: return [[.top, .right], .left]
        case [.bottom, .left, .right]: return [[.bottom, .left], .right]
        case [.top, .bottom, .right]: return [[.bottom, .right], .top]
        case [.top, .bottom, .left]: return [[.bottom, .left], .top]
        case [.top, .bottom, .left, .right]: return [[.bottom, .left], [.top, .right]]
        default:
            fatalError("Could not build tile for \(adjacency)")
        }
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
