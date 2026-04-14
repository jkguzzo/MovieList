//
//  ContentView.swift
//  MovieList
//
//  Created by Julia Guzzo on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            MoviesView()
                .tabItem {
                    Label("Movies", systemImage: "list.bullet")
                }
            ChartsView()
                .tabItem {
                    Label("Charts", systemImage: "chart.xyaxis.line")
                }
        }
    }
}

#Preview {
    ContentView()
}
