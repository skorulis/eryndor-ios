//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import SpriteKit
import SwiftUI

// MARK: - Memory footprint

struct MapView {
    @StateObject var viewModel: MapViewModel
    @Environment(\.windowSize) private var windowSize
    
    @State private var originalTranslation: CGPoint?
    
    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

// MARK: - Rendering

extension MapView: View {
    
    var body: some View {
        ZStack {
            skContent
                .gesture(dragGesture)
                .onTapGesture(perform: viewModel.tap)
            
            controlsOverlay
        }
        
    }
    
    private var paintGesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                viewModel.tap(location: value.location)
            }
            .modifiers(.command)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                if originalTranslation == nil {
                    originalTranslation = viewModel.scene.map.position
                }
                viewModel.scene.map.position = CGPoint(
                    x: originalTranslation!.x + value.translation.width,
                    y: originalTranslation!.y - value.translation.height)
            }
            .onEnded { value in
                self.originalTranslation = nil
            }
    }
    
    private var skContent: some View {
        ZStack {
            Color.blue
                //.frame(width: 8000, height: 8000)
            SpriteView(scene: viewModel.scene, debugOptions: [.showsFPS])
                .contentShape(Rectangle())
                .allowsHitTesting(false)
                .onChange(of: windowSize) { newValue in
                    viewModel.scene.size = newValue
                    viewModel.windowSize = newValue
                }
        }
        
    }
    
    private var controlsOverlay: some View {
        VStack(alignment: .leading) {
            Spacer()
            terrainPicker
            layerPicker
        }
    }
    
    private var layerPicker: some View {
        Picker("", selection: $viewModel.layer) {
            ForEach(MapLayer.allCases) { layer in
                Text(layer.rawValue)
                    .tag(layer)
            }
        }
        .pickerStyle(.menu)
        .frame(width: 150)
    }
    
    private var terrainPicker: some View {
        Picker("", selection: $viewModel.brushType) {
            ForEach(BaseTerrainType.allCases) { type in
                Text(type.name)
                    .tag(type)
            }
        }
        .pickerStyle(.menu)
        .frame(width: 150)
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

