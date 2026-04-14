//
//  MovieListApp.swift
//  MovieDetailView
//
//  Created by Julia Guzzo on 4/12/26.
//

import SwiftData
import SwiftUI

struct MovieDetailView: View {
    var title: String
    @State private var movie: MovieDTO?
    @State private var isError = false
    @State private var isLoading = false
    @State private var errorString = ""
    @Environment(\.modelContext) private var modelContext
    @Query var lists: [MovieList]
    @State private var watchStatus: WatchStatus? = nil
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            if isError {
                ContentUnavailableView("Failed to fetch movie", systemImage: "xmark.circle", description: Text("There was an issue fetching this movie: \(errorString). Please try again."))
            } else {
                if isLoading {
                    ProgressView()
                } else {
                    if let movie = movie {
                        movieDetail(movie)
                    }
                }
            }
        }
        .task {
            do {
                isLoading = true
                movie = try await MovieService.shared.fetchMovie(title: title)
                isLoading = false
            } catch {
                isError = true
                errorString = error.localizedDescription
            }
        }
    }
    
    @ViewBuilder
    private func movieDetail(_ movie: MovieDTO) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: movie.poster)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250, alignment: .top)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                    HStack(spacing: 30) {
                        Text(movie.year)
                        Text(movie.rated)
                        Label(movie.runtime, systemImage: "clock")
                    }
                    .foregroundStyle(.secondary)
                    Text("**Genres:** \(movie.genre)")
                        .foregroundStyle(.secondary)
                    Text("**Director**: \(movie.director)")
                        .foregroundStyle(.secondary)
                    Text("**Cast**: \(movie.actors)")
                        .foregroundStyle(.secondary)
                    Text(movie.plot)
                        .foregroundStyle(.secondary)
                    VStack(spacing: 15) {
                        Menu {
                            ForEach(lists) { list in
                                Button {
                                    let movie = Movie(from: movie)
                                    list.movies.append(movie)
                                    dismiss()
                                } label: {
                                    Text(list.name)
                                }
                            }
                        } label: {
                            Label("Add to List", systemImage: "plus.circle")
                                .font(.title2)
                                .bold()
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        HStack(spacing: 15) {
                            Button {
                                watchStatus = .wantToWatch
                            } label: {
                                Text("Watch Later")
                                    .font(.title2)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Button {
                                watchStatus = .watched
                            } label: {
                                Text("Watched")
                                    .font(.title2)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .padding(.vertical, 15)
                    Spacer()
                }
                .padding()
            }
            .buttonStyle(.plain)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let container = MockSwiftData.previewContainer
    NavigationStack {
        MovieDetailView(title: "Interstellar")
            .modelContainer(container)
    }
}
