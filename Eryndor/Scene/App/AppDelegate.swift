//Created by Alexander Skorulis on 20/5/2023.

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!
    private let ioc = IOC(purpose: .normal)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1280, height: 800),
            styleMask: [.miniaturizable, .closable, .resizable, .titled],
            backing: .buffered, defer: false)
        window.center()
        window.title = "Eryndor"
        window.makeKeyAndOrderFront(nil)
        
        let view = WindowSizeView {
            ContentView()
                .environment(\.factory, self.ioc)
                .environment(\.window, self.window)
        }
        
        window.contentView = NSHostingView(rootView: view)
        
    }
}
