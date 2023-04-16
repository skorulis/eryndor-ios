//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import GRDB

final class SQLMigrations {
    
    var migrator = DatabaseMigrator()
    
    init() {
        migrator.registerMigration("V1") { [unowned self] db in
            
        }
    }
}
