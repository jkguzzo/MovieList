//
//  FeaturedMoviesView.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/14/26.
//

import SwiftData
import SwiftUI

struct FeaturedMoviesView: View {
    static var fetchDescriptor: FetchDescriptor<Movie> {
        var descriptor = FetchDescriptor<Movie>(
            sortBy: [SortDescriptor(\.addedAt, order: .reverse)]
        )
        descriptor.fetchLimit = 5
        return descriptor
    }
    @State private var scrolledMovie: Int? = 0

    @Query(FeaturedMoviesView.fetchDescriptor) var movies: [Movie]
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            VStack(alignment: .center, spacing: 15) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(movies) { movie in
                            if let image = movie.image {
                                if let uiImage = UIImage(data: image) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: width, height: 300, alignment: .top)
                                        .cornerRadius(16)
                                        .clipped()
                                        .overlay(
                                            VStack {
                                                Spacer()
                                                HStack {
                                                    Text(movie.title)
                                                        .font(.title)
                                                        .fontWeight(.bold)
                                                        .padding(.vertical, 8)
                                                        .padding(.horizontal, 15)
                                                        .glassEffect(.regular, in: .rect(cornerRadius: 10))
                                                    Spacer()
                                                }
                                                .padding(5)
                                            }
                                        )
                                        .id(movies.firstIndex(of: movie))
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrolledMovie)
                
                HStack(spacing: 5) {
                    ForEach(0..<5) { i in
                        Image(systemName: i == scrolledMovie ? "circle.fill" : "circle")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    let container = MockSwiftData.previewContainer
    FeaturedMoviesView()
        .modelContainer(container)
}
