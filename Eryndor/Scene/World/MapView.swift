//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import SpriteKit
import SwiftUI

// MARK: - Memory footprint

struct MapView {
    @StateObject var viewModel: MapViewModel
    @Environment(\.windowSize) private var windowSize
    private let scene = MapScene()
    
    @State private var dragOffset = CGSize.zero
    
    @State private var originalTranslation: CGPoint?
    
    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        scene.size = CGSize(width: 300, height: 300)
        scene.scaleMode = .fill
    }
}

// MARK: - Rendering

extension MapView: View {
    
    var body: some View {
        skContent
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        if originalTranslation == nil {
                            originalTranslation = scene.map.position
                        }
                        scene.map.position = CGPoint(
                            x: originalTranslation!.x + value.translation.width,
                            y: originalTranslation!.y - value.translation.height)
                    }
                    .onEnded { value in
                        self.originalTranslation = nil
                    }
            )
    }
    
    private var skContent: some View {
        ZStack {
            Color.blue
            SpriteView(scene: scene)
                .allowsHitTesting(false)
                .onChange(of: windowSize) { newValue in
                    scene.size = newValue
                    viewModel.windowSize = newValue
                }
        }
        
    }
    
    private var content: some View {
        grid
            .frame(width: windowSize.width, height: windowSize.height)
            .onChange(of: windowSize) { newValue in
                print(windowSize.width)
                viewModel.windowSize = newValue
            }
    }
    
    private var grid: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.rows) { row in
                HStack(spacing: 0) {
                    ForEach(row.squares) { square in
                        Text(square.id)
                            .frame(width: MapViewModel.squareSize, height: MapViewModel.squareSize)
                            .border(Color.black)
                    }
                }
            }
        }
        
    }
}

// MARK: - Previews

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        return MapView(viewModel: ioc.resolve())
            .environment(\.windowSize, .init(width: 500, height: 500))
    }
}

