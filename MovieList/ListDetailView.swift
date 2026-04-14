//
//  ListDetailView.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/14/26.
//

import SwiftData
import SwiftUI

struct ListDetailView: View {
    @State private var vm: ListDetailViewModel
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    init(list: MovieList) {
        self.vm = ListDetailViewModel(list: list)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Picker(vm.filter.rawValue, selection: $vm.filter) {
                    ForEach(FilterOptions.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                            .tag(filter)
                    }
                }
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]) {
                    ForEach(vm.movies) { movie in
                        NavigationLink {
                            MovieDetailView(title: movie.title)
                        } label: {
                            if let image = movie.image {
                                PosterView(posterData: image)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .searchable(text: $vm.searchText)
        .navigationTitle(vm.list.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        vm.showRenamePopover = true
                    } label: {
                        Label("Rename List", systemImage: "pencil")
                    }
                    Button {
                        
                    } label: {
                        Label("Add Movie", systemImage: "plus")
                    }
                    Button {
                        vm.setDelete()
                    } label: {
                        Label("Delete List", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                .popover(isPresented: $vm.showRenamePopover, attachmentAnchor: .point(.trailing), arrowEdge: .top) {
                    HStack {
                        TextField(vm.list.name, text: $vm.newTitle)
                        Button {
                            vm.showRenamePopover = false
                            vm.renameList(modelContext)
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .buttonStyle(.plain)
                    }
                    .padding()
                    .frame(width: 250, height: 75)
                    .presentationCompactAdaptation(.popover)
                    
                }
            }
        }
        .alert("Delete List?", isPresented: $vm.deleteAlert) {
            Button(role: .cancel) {} label: {
                Text("Cancel")
            }
            Button(role: .destructive) {
                vm.deleteList(modelContext)
                dismiss()
            } label: {
                Text("Delete")
            }
        } message: {
            Text("This action cannot be undone.")
        }
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
        ListDetailView(list: list)
            .modelContainer(container)
    }
}
