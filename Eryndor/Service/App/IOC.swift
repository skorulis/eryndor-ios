//Created by Alexander Skorulis on 16/4/2023.

import ASKCore
import Foundation

final class IOC: IOCService {
    
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        registerStores()
    }
    
    private func registerStores() {
        switch purpose {
        case .normal:
            container.register(SQLStore.self) { _ in
                return SQLStore(inMemory: false)
            }
        case .testing:
            container.register(SQLStore.self) { _ in
                return SQLStore(inMemory: true)
            }
        }
        
    }
    
}
