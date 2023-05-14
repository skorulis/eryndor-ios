//  Created by Alexander Skorulis on 6/5/2023.

import CoreGraphics
import Foundation
import SpriteKit
import Terrain

final class TerrainMixer {
    
    func createMissing(initial: TerrainImages) -> TerrainImages {
        let allOptions = Adjacency.allOptions
        var images = TerrainImages(terrain: initial.terrain)
        for opt in allOptions {
            guard initial.images[opt] == nil, opt.rawValue != 0 else {
                continue
            }
            let pieces = components(adjacency: opt)
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
    
    func components(adjacency: Adjacency) -> [Adjacency] {
        var result = sideComponents(adjacency: adjacency)
        if adjacency.contains(.cornerTopLeft) {
            result.append(.cornerTopLeft)
        }
        if adjacency.contains(.cornerTopRight) {
            result.append(.cornerTopRight)
        }
        if adjacency.contains(.cornerBottomLeft) {
            result.append(.cornerBottomLeft)
        }
        if adjacency.contains(.cornerBottomRight) {
            result.append(.cornerBottomRight)
        }
        return result
    }
    
    private func sideComponents(adjacency: Adjacency) -> [Adjacency] {
        if adjacency.contains([.top, .bottom, .left, .right]) {
            return [[.bottom, .left], [.top, .right]]
        } else if adjacency.contains([.top, .bottom, .left]) {
            return [[.bottom, .left], .top]
        } else if adjacency.contains([.top, .bottom, .right]) {
            return [[.bottom, .right], .top]
        } else if adjacency.contains([.bottom, .left, .right]) {
            return [[.bottom, .left], .right]
        } else if adjacency.contains([.top, .left, .right]) {
            return [[.top, .right], .left]
        } else if adjacency.contains([.top, .bottom]) {
            return [.top, .bottom]
        } else if adjacency.contains([.left, .right]) {
            return [.left, .right]
        } else if adjacency.contains(.top) {
            return [.top]
        } else if adjacency.contains(.bottom) {
            return [.bottom]
        } else if adjacency.contains(.left) {
            return [.left]
        } else if adjacency.contains(.right) {
            return [.right]
        }
        return []
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
