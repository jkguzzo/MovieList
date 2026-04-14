//
//  LibraryView.swift
//  MovieList
//
//  Created by Julia Guzzo on 10/27/25.
//

import SwiftData
import SwiftUI

struct LibraryView: View {
    @Query(sort: \MovieList.createdAt) var lists: [MovieList]
    @State private var vm = LibraryViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                FeaturedMoviesView()
                    .frame(height: 300)
                VStack {
                    ForEach(lists) { list in
                        MovieScrollView(list: list)
                            .frame(maxHeight: 175)
                    }
                }
                .padding(10)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            NewListView(vm: vm)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let container = MockSwiftData.previewContainer
    LibraryView()
        .modelContainer(container)
}
