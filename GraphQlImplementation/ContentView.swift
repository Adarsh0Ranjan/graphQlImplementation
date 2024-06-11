//
//  ContentView.swift
//  GraphQlImplementation
//
//  Created by Adarsh Ranjan on 11/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: StationListViewModel = StationListViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            viewModel.loadDescriptions()
        }
    }
}

#Preview {
    ContentView()
}
