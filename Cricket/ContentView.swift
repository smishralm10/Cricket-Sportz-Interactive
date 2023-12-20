//
//  ContentView.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 19/12/23.
//

import SwiftUI

struct ContentView: View {
    private let container: DIContainer
    
    init() {
        let environment = AppEnvironment.bootstrap()
        self.container = environment.container
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .environment(\.injected, container)
    }
}

#Preview {
    ContentView()
}
