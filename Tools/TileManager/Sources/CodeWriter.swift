//  Created by Alexander Skorulis on 7/5/2023.

import Foundation

struct CodeWriter {
    
    let filename: URL
    
    func write(defs: [FullTerrainDefinition]) throws {
        let fileManager = FileManager.default
        let tempFilename = fileManager.currentDirectoryPath + "/defs.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        print(tempFilename)
        let tempJSON = try! encoder.encode(defs)
        try! tempJSON.write(to: URL(filePath: tempFilename))
        
        let task = Process()
        task.executableURL = URL(filePath: "/opt/homebrew/bin/swiftgen")
        task.arguments = [
            "run",
            "json",
            "--templatePath",
            tempFilename
        ]
        
        try task.run()
    }
    
}
