//Created by Alexander Skorulis on 20/5/2023.

import AppKit
import Foundation
import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            print("Update window \(window)")
            self.window = view.window   // << right after inserted in window
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

public struct WindowKey: EnvironmentKey {
    public static var defaultValue: NSWindow = .init()
}

public extension EnvironmentValues {
    
    var window: NSWindow {
        get { self[WindowKey.self] }
        set { self[WindowKey.self] = newValue }
    }
}


