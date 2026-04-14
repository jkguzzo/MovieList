//
//  ListsView.swift
//  MovieList
//
//  Created by Julia Guzzo on 10/27/25.
//
import SwiftData
import SwiftUI

struct MoviesView: View {
    @Query var movies: [Movie]
    @State private var selectedStatus: WatchStatus = .wantToWatch
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            if movies.isEmpty {
                ContentUnavailableView("No Movies Added", systemImage: "movieclapper")
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]) {
                        ForEach(movies.sorted { $0.addedAt < $1.addedAt }) { movie in
                            if let image = movie.image {
                                PosterView(posterData: image)
                            } else {
                                Text(movie.title)
                            }
                        }
                    }
                }
                .padding()
                .searchable(text: $searchText)
            }
        }
    }
}

#Preview {
    let container = MockSwiftData.previewContainer
    MoviesView()
        .modelContainer(container)
}
