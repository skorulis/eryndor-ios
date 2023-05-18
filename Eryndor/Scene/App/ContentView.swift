//
//  ContentView.swift
//  Eryndor
//
//  Created by Alexander Skorulis on 16/4/2023.
//

import ASKCore
import SwiftUI

struct ContentView: View {
    
    @Environment(\.factory) private var factory
    
    var body: some View {
        VStack {
            MapView(viewModel: factory.resolveMain())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let ioc = IOC()
        return ContentView()
            .environment(\.factory, ioc)
    }
}
