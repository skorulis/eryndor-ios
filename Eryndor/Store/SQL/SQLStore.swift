//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import GRDB

final class SQLStore {
    
    private static let dbURL: URL = PathProvider.docDir.appending(path: "db.sqlite")
    private static var dbPath: String {
        return dbURL.pathComponents.joined(separator: "/")
    }
    
    let dbQueue: DatabaseQueue
    
    init(inMemory: Bool) {
        print("SQL STARTED: \(Self.dbPath)")
        if inMemory {
            self.dbQueue = try! DatabaseQueue(named: "testing")
        } else {
            self.dbQueue = try! DatabaseQueue(path: Self.dbPath)
        }
        
        try! migrate()
    }
    
    private func migrate() throws {
        let migrations = SQLMigrations()
        try migrations.migrator.migrate(dbQueue)
    }
    
}

private enum PathProvider {
    static let docDir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
