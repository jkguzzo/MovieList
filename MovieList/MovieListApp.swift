//
//  MovieListApp.swift
//  MovieList
//
//  Created by Julia Guzzo on 10/27/25.
//

import SwiftData
import SwiftUI

@main
struct MovieListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Movie.self, MovieList.self])
    }
}
