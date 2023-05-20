//Created by Alexander Skorulis on 20/5/2023.

import AppKit
import Foundation
import SwiftUI

struct InfiniteScrollView: NSViewRepresentable {
    
    private static let size: CGFloat = 50000
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        
        return scrollView
    }
    
    func updateNSView(_ view: NSScrollView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        
    }
}
