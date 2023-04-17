//
//  WindowSizeView.swift
//  VoidShaperClient
//
//  Created by Alexander Skorulis on 25/7/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct WindowSizeView<Content: View> {
    
    private let content: () -> Content
    
    init(content: @escaping () -> Content) {
        self.content = content
    }
    
}

// MARK: - Rendering

extension WindowSizeView: View {
    
    var body: some View {
        GeometryReader { proxy in
            content()
                .environment(\.windowSize, proxy.size)
        }
    }
}

// MARK: - Environment keys

struct WindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = CGSize(width: 400, height: 400)
}

extension EnvironmentValues {
    var windowSize: CGSize {
        get { self[WindowSizeKey.self] }
        set { self[WindowSizeKey.self] = newValue }
    }
}

// MARK: - Previews

struct WindowSizeView_Previews: PreviewProvider {
    
    static var previews: some View {
        WindowSizeView {
            Text("TEST")
        }
    }
}

