//  Created by Alexander Skorulis on 7/5/2023.

import Foundation

struct CodeWriter {
    
    let filename: URL
    static let stencilPath = "/Users/alex/dev/ios/Eryndor/Tools/TileManager/enumStencil.stencil"
    
    func write(defs: [FullTerrainDefinition]) throws {
        let sorted = defs.sorted(by: {$0.id < $1.id})
        let fileManager = FileManager.default
        let tempFilename = fileManager.currentDirectoryPath + "/defs.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let tempJSON = try! encoder.encode(sorted)
        try! tempJSON.write(to: URL(filePath: tempFilename))
        
        let task = Process()
        task.executableURL = URL(filePath: "/opt/homebrew/bin/swiftgen")
        task.arguments = [
            "run",
            "json",
            tempFilename,
            "--templatePath",
            Self.stencilPath,
            "--output",
            filename.pathComponents.joined(separator: "/")
        ]
        
        try task.run()
    }
    
}
