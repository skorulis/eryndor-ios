//  Created by Alexander Skorulis on 6/5/2023.

import Foundation
import CoreGraphics
import SpriteKit

struct OutputWriter {
    
    let baseDir: URL
    
    func write(merged: TerrainImages) throws {
        let fileManager = FileManager.default
        for (key, value) in merged.images {
            let folder = baseDir.appending(path: "\(merged.terrain.rawValue)_\(key.fileExtension).imageset")
            try fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
            
            let filename = merged.terrain.rawValue + "_" + key.fileExtension + ".png"
            let fullPath = folder.appending(path: filename)
            let contentsPath = folder.appending(path: "Contents.json")
            let imageRep = NSBitmapImageRep(data: value.tiffRepresentation!)!
            let pngData = imageRep.representation(using: .png, properties: [:])!
            try pngData.write(to: fullPath)
            
            let contents = Contents(filename: filename)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(contents)
            try jsonData.write(to: contentsPath)
        }
    }
}

extension OutputWriter {
    struct Contents: Encodable {
        let images: [Image]
        let info: Info
        
        init(filename: String) {
            self.images = [Image(filename: filename)]
            self.info = .init()
        }
    }
    
    struct Image: Encodable {
        let filename: String
        let idiom: String = "universal"
    }
    
    struct Info: Encodable {
        let author: String = "xcode"
        let version: Int = 1
    }
}
