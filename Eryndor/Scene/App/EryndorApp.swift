//  Created by Alexander Skorulis on 16/4/2023.

import SwiftUI

@main
struct EryndorApp: App {
    
    private let ioc = IOC(purpose: .normal)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.factory, ioc)
        }
    }
}
