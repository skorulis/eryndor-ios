//Created by Alexander Skorulis on 16/4/2023.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MapView {
    @StateObject var viewModel: MapViewModel
    @Environment(\.windowSize) private var windowSize
    
    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        viewModel.windowSize = windowSize
    }
}

// MARK: - Rendering

extension MapView: View {
    
    var body: some View {
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
                        Text("A")
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

