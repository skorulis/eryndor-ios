//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import GRDB

final class SQLMigrations {
    
    var migrator = DatabaseMigrator()
    
    init() {
        migrator.registerMigration("V1") { [unowned self] db in
            try self.terrainBlocksTable(db: db)
        }
    }
    
    private func terrainBlocksTable(db: Database) throws {
        try db.create(table: "blocks") { t in
            t.autoIncrementedPrimaryKey("rowid")
            
            t.column("x", .integer)
                .notNull()
            
            t.column("y", .integer)
                .notNull()
            
            t.column("block", .text)
                .notNull()
        }
    }
}
