//
//  SearchView.swift
//  MovieList
//
//  Created by Julia Guzzo on 10/27/25.
//

import SwiftUI

struct SearchView: View {
    @State private var title: String = ""
    @State private var movies: Search = Search(search: [])
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if title.isEmpty || movies.search.isEmpty {
                    ContentUnavailableView("No Movies Found", systemImage: "movieclapper", description: Text("Search for a movie to see it appear here"))
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(spacing: 8), GridItem(spacing: 8)], spacing: 12) {
                            ForEach(movies.search) { movie in
                                NavigationLink {
                                    MovieDetailView(title: movie.title)
                                } label: {
                                    PosterView(posterURL: movie.poster)
                                }
                            }
                        }
                    }
                }
            }
            .searchable(text: $title)
            .onSubmit(of: .search) {
                Task {
                    movies = try await MovieService.shared.searchMovies(title: title)
                }
            }
            .padding(.top)
            .padding(.horizontal)
//            .onChange(of: title) { _, newValue in
//                Task {
//                    movies = try await MovieService.shared.searchMovies(title: title)
//                }
//            }
        }
    }
}

#Preview {
    SearchView()
}
