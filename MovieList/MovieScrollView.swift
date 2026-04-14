//
//  MovieScrollView.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/13/26.
//

import SwiftData
import SwiftUI

struct MovieScrollView: View {
    var list: MovieList
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                ListDetailView(list: list)
            } label: {
                HStack(alignment: .center, spacing: 3) {
                    Text(list.name.capitalized)
                        .bold()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
                .foregroundStyle(.secondary)
            }
            .padding(.top)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(list.movies) { movie in
                        NavigationLink {
                            // TODO: use separate view for lists already added that doesn't recall the backend
                            MovieDetailView(title: movie.title)
                        } label: {
                            if let image = movie.image {
                                PosterView(posterData: image)
                            }
                        }
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let container = MockSwiftData.previewContainer
    let context = ModelContext(container)
    
    let descriptor = FetchDescriptor<MovieList>(
        predicate: #Predicate { $0.name == "Comedy" }
    )
    let lists = (try? context.fetch(descriptor)) ?? []
    let list = lists.first ?? MovieList(name: "Empty", movies: [])
    NavigationStack {
        MovieScrollView(list: list)
            .modelContainer(container)
    }
}
