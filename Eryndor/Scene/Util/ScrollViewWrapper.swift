//Created by Alexander Skorulis on 24/4/2023.

import Foundation
import SwiftUI

struct ScrollViewWrapper<Content: View>: NSViewRepresentable {

    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        let host = NSHostingView(rootView: content())
        scrollView.addSubview(host)
        pinEdges(of: host, to: scrollView)
        return scrollView
    }

    func updateNSView(_ view: NSScrollView, context: Context) {
//        viewController.hostingController.rootView = AnyView(self.content())
    }
    
    func pinEdges(of viewA: NSView, to viewB: NSView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }
}
