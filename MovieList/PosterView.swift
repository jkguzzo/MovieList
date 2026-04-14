//
//  PosterView.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/6/26.
//

import SwiftUI

struct PosterView: View {
    
    private let source: Source
    
    init(posterURL: String) {
        self.source = .url(posterURL)
    }
    
    init(posterData: Data) {
        self.source = .data(posterData)
    }
    
    var body: some View {
        posterContent
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    @ViewBuilder
    private var posterContent: some View {
        switch source {
        case .url(let url):
            if let url = URL(string: url) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        errorPlaceholder
                    case .empty:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                errorPlaceholder
            }
        case .data(let data):
            if let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                errorPlaceholder
            }
        }
    }
    
    private var placeholder: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .frame(height: 300)
            .overlay {
                ProgressView()
            }
    }
    
    private var errorPlaceholder: some View {
        Rectangle()
            .fill(.quaternary)
            .frame(height: 300)
            .overlay {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }
}

#Preview {
    PosterView(posterURL: MovieSearch.example.poster)
}
